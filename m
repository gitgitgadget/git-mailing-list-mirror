Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 442A81F453
	for <e@80x24.org>; Mon, 18 Feb 2019 18:45:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725830AbfBRSpi (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Feb 2019 13:45:38 -0500
Received: from mail-wr1-f48.google.com ([209.85.221.48]:44411 "EHLO
        mail-wr1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725308AbfBRSph (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Feb 2019 13:45:37 -0500
Received: by mail-wr1-f48.google.com with SMTP id w2so4896518wrt.11
        for <git@vger.kernel.org>; Mon, 18 Feb 2019 10:45:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=mBt9mzW8kOopOoa2hoNq2wD+QRyw1IsBuJszCDH+U44=;
        b=BZmN58Or4xMXtEQNDvVBqRHfkYnMaN0l+S36VjLxaqqTieQe+RrCslaPL+ljyhYgLv
         Evv19WJYV5BDJE23E20CXc310dZv+ln9Z0cZSDVrLIShcoAyFrNtzu9qN1gEO1UY7R3y
         AvgVvXEibL3IRHfDGakSVqE3ppiRI9i26J1OtCinlhxtt3Dz6N5HxXzLqDBO7sZst6Tj
         06vRhBbwGQbiLY09XG9PQta3u3pA5O9qah5nUCglj2hlyA2ot7LX03bZrkv/JLvMhc/a
         GJmxWnIMSuxw+2iSLppkosMhZIrlJO/7+Rm+FigC7zEX/6J4bnwJG+Xj3L7JXk2p9Uee
         DxVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=mBt9mzW8kOopOoa2hoNq2wD+QRyw1IsBuJszCDH+U44=;
        b=kAwLejhy3ZIiGEPBPCYr6ZSVdI5VyyS1ZsrpkMq3MLalZWVUX6LHdp5NlMTef90mE+
         EmGZuaLQ5agkKF+0BPT0yTPR2hYCpO15OkEpSOnh3TVZzGK4+AF7QHm2KxS4q9FBled7
         Upk0WvQd/NvLIR/1h9ESpQ/JCMV5biSHuS+npHCJ3obxoJ+jDIOvLrqf70CF5yuxzbNy
         OKE9pg5gEwNSNSVZOFboCigFW9Btfg/bxl1vG+d9ULv1Fq9iquHdo/867MWEX2IY2HuU
         JczQ57Z8jHJd/DCRJyDJec+3dp9y4cqsaWRhRXoXlpCybXUXhKwaYx1DHXTWY03JYrIl
         oeYg==
X-Gm-Message-State: AHQUAub1inpvzCQiWbXXSsMYVRAXN5Ro4XgTfjAL6ExpUDT2Jka61a5C
        nsUYMakN2Y7LOQIPyqgbFn7HvFMC
X-Google-Smtp-Source: AHgI3IboqDgDd+aqa/ANchkVCZs1hGhsukmGwQufH1mC4ed8SZrdS/nDIdU9PHqhc5NT2p43u7c2sQ==
X-Received: by 2002:adf:ed11:: with SMTP id a17mr17944689wro.283.1550515535577;
        Mon, 18 Feb 2019 10:45:35 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id h62sm221888wmf.11.2019.02.18.10.45.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Feb 2019 10:45:34 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "'Johannes Schindelin'" <Johannes.Schindelin@gmx.de>
Cc:     "'Max Kirillov'" <max@max630.net>,
        'SZEDER =?utf-8?Q?G=C3=A1bor'?= <szeder.dev@gmail.com>,
        <git@vger.kernel.org>, "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: Re: [ANNOUNCE] Git v2.21.0-rc1 (NonStop Results) - Good News
References: <001201d4c617$de429540$9ac7bfc0$@nexbridge.com>
        <xmqqftsn4nik.fsf@gitster-ct.c.googlers.com>
        <000001d4c624$da8e05d0$8faa1170$@nexbridge.com>
        <xmqq5ztj4l3j.fsf@gitster-ct.c.googlers.com>
Date:   Mon, 18 Feb 2019 10:45:34 -0800
In-Reply-To: <xmqq5ztj4l3j.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Sat, 16 Feb 2019 10:57:52 -0800")
Message-ID: <xmqqef852awh.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> I have been wondering about the whole /dev/zero business.  Although
> we have b46221ff ("Merge branch 'rb/no-dev-zero-in-test'",
> 2019-02-13) in 'master', "git grep /dev/zero t" has hits in
> t/helper/test-sha1.sh and t/t4152-am-resume-override-opts.sh, so it
> must have been somewhat incomplete to help platforms that lack
> /dev/zero in the first place.
>
> We haven't heard from Dscho in European timezone, but I'm
> inclined to
>
>  - keep b46221ff in 'master', not reverted.
>  - apply Max's "t5562: do not reuse output files"
>
> to 'master' and hope that we can declare victory in this part of the
> code ;-).  There may be fix-ups for other topics before -rc2 on top
> of that, though.

Just to make sure you didn't miss the exchange, the above plan is
still the latest ("Max's patch is [1]).  As I'll be offline most of
the day today, you still have time to stop or make me change course
to avoid disaster by interjecting (which would be very much
appreciated).

Thanks.


[Reference]

*1* https://public-inbox.org/git/20181124093719.10705-1-max@max630.net/
