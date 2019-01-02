Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE4A81F770
	for <e@80x24.org>; Wed,  2 Jan 2019 17:27:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730678AbfABR1T (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Jan 2019 12:27:19 -0500
Received: from mail-wm1-f53.google.com ([209.85.128.53]:33822 "EHLO
        mail-wm1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730586AbfABR1S (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Jan 2019 12:27:18 -0500
Received: by mail-wm1-f53.google.com with SMTP id y185so33221396wmd.1
        for <git@vger.kernel.org>; Wed, 02 Jan 2019 09:27:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=3K/JS4MzqidH1jEgz/XzfsF+Adqmz6yj6DbyYjW10u8=;
        b=hprcIadQSfTibG1VB4vQ1KIYnVR1LayvC65UD8YRyw/LhL2GtnHYEfKm4LDn7q7mV0
         2O6YmuWnqHow9P1wgikFWC5oanwnKF3lW78u4H/CueBNDh9Tz1qVkrI5ijlhbN+n/vwR
         odwCh/2lmRjdyDGrytsSUZr+y/CETsSaH4iCEoSB1xKkbMTuPpjiTJ97vON88bkFyI9P
         RYakfCkNS+J1c0xacwKU+1Pzg5bGGNfjKEDNo6Pjs8+bab4VYQ5WZQ2oZWljUSpaO7xr
         EkdH9sCO/aH/Kx+MIjA/SNe0jJxHrwUSOwWw3FpGzTN1DW2ZDsNgr6ti30oX/hhhLzlQ
         cguw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=3K/JS4MzqidH1jEgz/XzfsF+Adqmz6yj6DbyYjW10u8=;
        b=gkIbsRu8V1bNqbGtsIX+soARshxE7mfaQTnK2OWGn9yYm4yy6L7KMtnbICJcbju8oN
         sdc6tiTGTUgKQL+ixrZrmQ4qvfdFcPUGJbqNBtBKChOTzbFAkN7vROv4ixhUBMzcnr45
         UWUgoSQ34v9EWdA6FSmZjde3+CVwidn0U4FsShdnwLoCCu1HiBPCn7AnG/t5UPTVAQ1F
         Yfd+AMChFYA+CtXf0Qj4qhuQME3W2a8vQLyJBKXWEjjkO9wN5mAgPw9Q1r/IPOlyu0lL
         I9wpOr9fktn+DU81YycVVRQV5X41lCLPjrEvUAcCxZzcBBV4acPRlVCgRTqsqZ0860OP
         dCJQ==
X-Gm-Message-State: AJcUukcML++2RPJRp6ykOjNSAgeiboNv9T8KAWSeKaqQXvNp6c0qg2xk
        BuZ44z2ea9wsumlwvwCv4wA=
X-Google-Smtp-Source: ALg8bN4uj7o9RMi6nz6WajNwuN6WpHGTPZ9yj4cXi860MZj/I+hnk5YsSh4tg6OXsi5ItsehlP5xwA==
X-Received: by 2002:a1c:7306:: with SMTP id d6mr2816244wmb.98.1546450036532;
        Wed, 02 Jan 2019 09:27:16 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id g16sm43417504wru.41.2019.01.02.09.27.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 02 Jan 2019 09:27:14 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Xheroz 128 <kenneth.951218@gmail.com>, git@vger.kernel.org
Subject: Re: Git extra hook, pre-upload
References: <754B8F69-BD83-4EBB-9E86-6DF845624B1B@gmail.com>
        <87k1jqem1p.fsf@evledraar.gmail.com>
Date:   Wed, 02 Jan 2019 09:27:13 -0800
In-Reply-To: <87k1jqem1p.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Sun, 30 Dec 2018 22:34:26 +0100")
Message-ID: <xmqq1s5vkm1a.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> We do not have such a pre-upload hook, but could have one. There's an
> old thread from 2011 detailing some potential downsides:
>
> https://public-inbox.org/git/CAMK1S_jaEWV=F6iHKZw_6u5ncDW0bPosNx-03W9bOLOfEEEY1Q@mail.gmail.com/
>
> FWIW I think most servers who find themselves needing such a hook use it
> to e.g. log how many fetches a given repository might serve, and end up
> instead wrapping git commands in some custom shell.

Thanks for a concise summary.

