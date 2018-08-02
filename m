Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B93E11F597
	for <e@80x24.org>; Thu,  2 Aug 2018 19:50:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbeHBVme (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Aug 2018 17:42:34 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:53009 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbeHBVme (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Aug 2018 17:42:34 -0400
Received: by mail-wm0-f66.google.com with SMTP id o11-v6so3801580wmh.2
        for <git@vger.kernel.org>; Thu, 02 Aug 2018 12:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=WCPYZGvxpQg16ybkoY007OMuxxOuSEKLnmv0qnfK7lU=;
        b=pIl1b0gGJlA7vIzKQDrYmSyZA1gtUrE6jmPJ84tDGCkcOuJIR94Ej22RmDvD9KwVyR
         rHsgd2uM7mQyn8Cf80BpZ38skcOCWLytun6NVbsnYXYQB2BfGYjCweq1LIwxdmxJQvr0
         /T0EwfQiQMUsAultxSDzQGv8immWNH7vRiZRVPN8ELA9KybXZEFHHX2lXMJ0OG45TLZo
         u5Z9ntZrBM4Far68QeJICjBu3kA9O3JC9cgmmh2wUJ+FBwcBMbW2sfnS/8X853jouNUW
         BpEXKnekS0mRFRGL39AO97D8PyoGm3VwPpkX1G5QqLD4d21tdmq1p+/4tLATfmwnyShi
         RUfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=WCPYZGvxpQg16ybkoY007OMuxxOuSEKLnmv0qnfK7lU=;
        b=uG0lrNc1gse3mMUqmCRaH72Mih+dS6Wh26XlHcUkfe/p1wtCL5BF9fZ6UMKVOZIWjf
         iBfFh1uVpmtPGeptYT3t664r3PWGmB+q1dQGxm2es1ZKT6kScI+emJRpUgeznrw7Re0X
         oRINRWq8ua2NXIVFlvCS9wUe0Oh9roWBadHbUvuBSeVhqNNX3DkGvIKnMZHqIsgcWlER
         6IB1Rr/tKGxBA5QHmwDFBPG8yO3HN93c5cpSgblUhCWZtBkurdB7UICAwer3bIenLnYN
         7JLoLv2L7Q1JQB2tkSdtnt+BY0k99lNIFPizIsREWsthgxfpySte9HNeeRRKFxWsk4OD
         lyRQ==
X-Gm-Message-State: AOUpUlEqXR2fv2pghQjDQexOcFShg7OzqG66x9E5XME19whbow7u3m2b
        d1YkAEQxdeu1AD+y+TLG8oI=
X-Google-Smtp-Source: AAOMgpfOCLNntFxpxZQ1Kx2Nqo8IIMahDsaZvgZkTrUzFMb1wlhIZMpSn/Ly5prfjTR4xXcSpeguOQ==
X-Received: by 2002:a1c:a8d6:: with SMTP id r205-v6mr2878620wme.6.1533239397564;
        Thu, 02 Aug 2018 12:49:57 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id d78-v6sm4594205wma.37.2018.08.02.12.49.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 Aug 2018 12:49:57 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     bmwill@google.com, git@vger.kernel.org, johannes.schindelin@gmx.de,
        peff@google.com
Subject: Re: [PATCH 0/3] sb/config-write-fix done without robbing Peter
References: <xmqq7elbe8po.fsf@gitster-ct.c.googlers.com>
        <20180801193413.146994-1-sbeller@google.com>
Date:   Thu, 02 Aug 2018 12:49:56 -0700
In-Reply-To: <20180801193413.146994-1-sbeller@google.com> (Stefan Beller's
        message of "Wed, 1 Aug 2018 12:34:10 -0700")
Message-ID: <xmqq4lgc1rbv.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

>> Am I correct to understand that this patch is a "FIX" for breakage
>> introduced by that commit?  The phrasing is not helping me to pick
>> a good base to queue these patches on.
>
> Please pick 4f4d0b42bae (Merge branch 'js/empty-config-section-fix', 2018-05-08)
> as the base of this new series (am needs -3 to apply), although I developed this
> series on origin/master.
>
>> Even though I hate to rob Peter to pay Paul (or vice versa)
>
> Yeah me, too. Here is a proper fix (i.e. only pay Paul, without the robbery),
> and a documentation of the second bug that we discovered.

Thanks.

I started with this in 'config'

    [V.A]	r = one
    [v.a]	r = two

and did "git config --replace-all v.a.r 1", which resulted in

    [V.A]
    [v.a]
		r = 1

which is "correct", but defeats the "empty section is irritating"
tweak that introduced the bug these patches try to fix, which is
unfortunate.

But then "git config v.A.r 2" would give us

    [V.A]
    [v.a]
		r = 1
		r = 2

So this seems still broken, somewhat.

