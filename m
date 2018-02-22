Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 084BA1F404
	for <e@80x24.org>; Thu, 22 Feb 2018 18:06:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933537AbeBVSGz (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Feb 2018 13:06:55 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:55611 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933441AbeBVSGy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Feb 2018 13:06:54 -0500
Received: by mail-wm0-f65.google.com with SMTP id q83so42088wme.5
        for <git@vger.kernel.org>; Thu, 22 Feb 2018 10:06:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=DQ9ocOe4ZAbzOusi0PmqFkOganm4L1FZQaOyqaJHXDo=;
        b=nvLJ1rS0RtNtWmql+zi+zIoLYPzFjDoGU0AY3H8+vfirYgunPbSGuaau4Yhe54D/tc
         mpV3jqMmYl4NuosqwQ2pxOzpe758TkS50LfgTbLuI385AgIMYclXXd6Clv5F4gmGoZS1
         XALs4xFQt8O9AvctLgpEcvqe4fvKs5qOew1/d+WCI97DZZpo6ZoZbE9cIHl5AvGmIfn4
         578GWRTfbw7WtCOWwFSEnBGgGR5wfFXjLH+w7n8p8xQKShUvWAsYH/CEwupu/gS0PYfC
         Ym5JFRIucL8MNEJcTato0tpwremKQlRDzmPLFEjKnSyuKql2Wj1w/CvLC+p/xXk4Ui8T
         rQTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=DQ9ocOe4ZAbzOusi0PmqFkOganm4L1FZQaOyqaJHXDo=;
        b=DCflrmtUYgrzytoTuR/X09mzYNXz/YBYqB+35QMtgVveMv3HRXM1rlWVcqeOd/98DI
         1Hh0FeDUv6tbRNFBVb9QfQu8N2zJrVurnbhvJ/62TR+snNAZYvofFrXy5uk/zBtqJGWU
         Y5+Y/uEoVzLloRmfvc8JOoHfOGh3ySSnnUZmWVrbkcKzFVs3MBQuq4EfLWZ68tyWtES/
         lQSDzWm7kIG0pP72TLd6Pa+XP4fBFauYO/5teYgUSF5uHgHLhK0TP4MpoJ5OgeU5ZRQE
         Z1e3siFo53Q1QBe0sqUW7+ndcjTMWU2vcwMUb3bRUVH2l72ECbvYcGjlG0gNf5KvJZk7
         a1Qg==
X-Gm-Message-State: APf1xPA12K2EHnjKVZxPgsbJcnS74ct/JPW0YPCnqMR/dIplvIYVdX2F
        d+rWetWrzR/uJiqL/f6SABM=
X-Google-Smtp-Source: AG47ELv908HBp+i0o3+E9RU6YpR3OpTOm2r9mnjtGbHz0UJGzS3GjHEwIDz2xR6v1Wy37hXeie5A7w==
X-Received: by 10.28.129.198 with SMTP id c189mr35181wmd.65.1519322812691;
        Thu, 22 Feb 2018 10:06:52 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id y111sm956099wrc.0.2018.02.22.10.06.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 22 Feb 2018 10:06:51 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Feb 2018, #03; Wed, 21)
References: <xmqq1shdyidz.fsf@gitster-ct.c.googlers.com>
        <20180222005640.GI127348@google.com>
Date:   Thu, 22 Feb 2018 10:06:50 -0800
In-Reply-To: <20180222005640.GI127348@google.com> (Brandon Williams's message
        of "Wed, 21 Feb 2018 16:56:40 -0800")
Message-ID: <xmqqwoz4x5j9.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

>>  Is the 'fixup!' cleanly squashable to the problematic one, or does
>>  this series require another reroll to get it in a good enough shape?
>
> Yeah the fixup patch looks good to me.  I don't think there was anything
> else that needed attention so it should be in good shape with the fixup
> patch.

OK, let me squash it down and mark the topic to be merged to 'next'
after giving it a quick final look.  Thanks.
