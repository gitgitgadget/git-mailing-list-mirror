Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 74FD71F453
	for <e@80x24.org>; Thu, 17 Jan 2019 18:35:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbfAQSfq (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Jan 2019 13:35:46 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50305 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbfAQSfp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jan 2019 13:35:45 -0500
Received: by mail-wm1-f66.google.com with SMTP id n190so2154944wmd.0
        for <git@vger.kernel.org>; Thu, 17 Jan 2019 10:35:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=nyHiNd/RPJ+2/0NiAbZfiF4HWk/txXxfG/bNi1QCLmg=;
        b=Vb2ZBjjN2zzADhrxYAnRGUq90EMse8PK9b878jWwHcQJIJFcCnJblJFKU7fOYhZWO5
         d/8ahvyCRmwBgdeOKz+wwonCE8KZy/zQzqVoi56ZAh4jgxWmiO6SOgxJ1RXYecjDgjxE
         6iQmSu7Mrss2qTsqAkdImpC/B3SoRJFlzGEwbpWIC5St9Kkh6c/Zfa1yncbpZUEkt8pk
         3JqRoE5O7NPZ2sx5PB3ie+n8WONkhbRGyRQLsVVg61qkSz41dR5ThLEtToscXBOC5eoT
         F7f3Medc3pWIoj/NNOfUhfDTDMUeUp1Ws/p3370O50h4aCc50+t65jK7OpaGBrZ/R+9l
         wOEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=nyHiNd/RPJ+2/0NiAbZfiF4HWk/txXxfG/bNi1QCLmg=;
        b=onrr/2m+QVybwrB2ZGoP7/oXr8LJwIOXeO+8oaMHv6DAa6Z/dQ07nasoSNPp/oVZ/l
         eB2uWCoOCCmVpyIXHc6CJeqsMQE6uy/nfpxojdsG3DoHnBIoZZ+DQhJF39NnSqEg/lzt
         OvQS+mdgyYCJ14E7RPkBdavy2+ZFsdZz3wMz1VwuRnK5Vp9a5LkpEavjAAgZSNVZ3ynr
         XqmPztIrk+Np933VI98wDBp8/myvO3Ag6uthEWYW0a/7db0vxvU+EYWtNNfyKzasDVud
         nUlDnkHII83e+yNUoJQ+kbcCBe3Po9c5IQTyHdSbWbN+iyrbvZR+WbGdT8hPS3q3efc1
         LglQ==
X-Gm-Message-State: AJcUukfSI6ZdbT8ZurYnDqTvGUBs8vz3aOJOmwb0U7EK+NXxCWkW3g7b
        D7mMavsX1SGacuIYr1T7nrC/om8i
X-Google-Smtp-Source: ALg8bN70KMVrb9JShQHxQiTSQsarsLsVmG7s/jHdnE2/nar1kj5iwd1YWHCMps2UEryNtXeKMvVPXw==
X-Received: by 2002:a1c:180a:: with SMTP id 10mr12777298wmy.92.1547750143389;
        Thu, 17 Jan 2019 10:35:43 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id k19sm123567108wre.5.2019.01.17.10.35.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Jan 2019 10:35:42 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jan 2019, #02; Tue, 15)
References: <xmqq4la9r1sl.fsf@gitster-ct.c.googlers.com>
        <20190116212631.GK25639@hank.intra.tgummerer.com>
Date:   Thu, 17 Jan 2019 10:35:42 -0800
In-Reply-To: <20190116212631.GK25639@hank.intra.tgummerer.com> (Thomas
        Gummerer's message of "Wed, 16 Jan 2019 21:26:31 +0000")
Message-ID: <xmqqlg3jnncx.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Gummerer <t.gummerer@gmail.com> writes:

> On 01/15, Junio C Hamano wrote:
>> * ps/stash-in-c (2019-01-04) 27 commits
>>  - tests: add a special setup where stash.useBuiltin is off
>>  - stash: optionally use the scripted version again
>>  - stash: add back the original, scripted `git stash`
>>  - stash: convert `stash--helper.c` into `stash.c`
>>  ...
>>  - sha1-name.c: add `get_oidf()` which acts like `get_oid()`
>>  - Merge branch 'sd/stash-wo-user-name'
>> 
>>  "git stash" rewritten in C.
>> 
>>  Comments?
>
> I read over the series last weekend.  I had some small comments on
> 21/26 and 25/26.  I forgot to reply with my overall assessment on the
> thread though.  I'd be happy to give my Reviewed-by for the whole
> series with or without the changes I suggested.  I double-checked the
> re-introduced "legacy" stash script to make sure it is actually the
> same as it is on master.

Thanks for helping.  And thanks for reminding us about the late
addition of the legacy stuff, which makes the progression of the
series less than ideal, but the benefit that would come from a
possible reroll to start the series from the last three patches
would be fairly limited anyway.  Such a reorganized series would
have allowed investigation of regressions and bugs during the
development comparing the original and rewritten implementations
slightly easier, but experience from seeing the evolution of these
"reimplement in C" topics tells us that we see major part of the
regression fallouts after the series is declared "feature complete",
so in the long run, the less-than-ideal organization of the topic
does not matter much in practice.

> So I'd be happy to get this merged into 'next', and if anything comes
> up to fix that on top.

OK.
