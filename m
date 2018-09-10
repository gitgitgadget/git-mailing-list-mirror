Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EAE281F404
	for <e@80x24.org>; Mon, 10 Sep 2018 17:17:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728484AbeIJWMZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Sep 2018 18:12:25 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34830 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727031AbeIJWMY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Sep 2018 18:12:24 -0400
Received: by mail-wr1-f65.google.com with SMTP id j26-v6so22811122wre.2
        for <git@vger.kernel.org>; Mon, 10 Sep 2018 10:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=RpXbXE3sVUMuflkqoFWWy64tg9tZYReqxakIqBClKy4=;
        b=lRRReIC/P91mgVtskAj8ocfEDk3C4bwX6+8xqHILMLGveLep/6qJd/z27QCdvVzx3o
         VnjfsCqlKU1PeVxTfOWd/SxF2mjYhK1B7uuoeeEUhHz4kUfZBBFxcHiQ6lvH+ELkoICz
         Q/W2Msl8FRe97YiCIjwZ8BnoD3ZMmmOcjZSmbAprjuJfw9SqnjZOeDKNuWbsZOYPRJrS
         tPLIO2LJnz7ypTEnO4G82zP7/2Mlw1uSJ7LM6uAsq3EAX8hQvGbEwjTHCdGdGY641l/y
         +CTRwPdcr0vHFilw8NkRuH1KVRVs/HLh3Ui2c+RFXCCK8jNx3oD/QYuuNhIP9W69mguZ
         6Ofg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=RpXbXE3sVUMuflkqoFWWy64tg9tZYReqxakIqBClKy4=;
        b=ZiCjuYcumKo1+GXb9Ce+zv66e46bGawBOCZGJ7LAaB5AIcekPMoxCj/pKtBUZ8HMFI
         OeiTg9cTf/yIrfkVkzmxawVOuSpfAg6pDF3xhYSSTX0sQBI2CgaVv3X54NTNmk+rJv3q
         SUbUtzSpvZ1BZ5xdxw54E7/rygMGbSzTNjZLxI1K+WTEUxE2d4vFmD1H2XPE2fqN/JDf
         O0a48xXd3/ffIVLYqZM9RDZ9jLBJbZ5V22FIwmh1NllFkdMExx4X0eUrzsI7+1tGZZhU
         6m/iJY58GA5Encsi3ZD+FJi5X5CYAoAMgQ/QmiTWx0e+5hYmEZ1HNsIcUHZ+iBzYHNeh
         y8mg==
X-Gm-Message-State: APzg51CkgUupntg7vWR602epJZYE+GRxZ8INbKP6lGuGLduvND7w7jAy
        OnY/P6hcxO57baHFOPO0/eR+1vK0
X-Google-Smtp-Source: ANB0VdZC4W4u0QCV4lm1J8qKwUI5DNowGU6ExVANQqV5TzQYkWnL1+hOnLNwm7WUeH3Qn+QMw8R4aA==
X-Received: by 2002:adf:e8c1:: with SMTP id k1-v6mr15051685wrn.43.1536599838778;
        Mon, 10 Sep 2018 10:17:18 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id h73-v6sm48735685wma.11.2018.09.10.10.17.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Sep 2018 10:17:17 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v6 17/21] range-diff: populate the man page
References: <pull.1.v5.git.gitgitgadget@gmail.com>
        <pull.1.v6.git.gitgitgadget@gmail.com>
        <8c5543a0667fffe0cb0684427f726fdfb75b28d0.1534159977.git.gitgitgadget@gmail.com>
        <87lg8a7wj2.fsf@evledraar.gmail.com>
        <20180909165431.GA17224@localhost>
        <87k1nu7fm0.fsf@evledraar.gmail.com>
Date:   Mon, 10 Sep 2018 10:17:17 -0700
In-Reply-To: <87k1nu7fm0.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Sun, 09 Sep 2018 19:19:51 +0200")
Message-ID: <xmqqmusptgpu.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> Looking at the git-range-diff manpage though it recommends <base> <rev1>
> <rev2> over <rev1>...<rev2> when the topic has been rebased, which is
> usually the case for e.g. a topic that's submitted to git.git (usually
> be the time feedback has been gathered & a re-submission has been made
> Junio has pushed another "master").
>
> So isn't "<base> <rev1> <rev2>" the right thing to use over
> "<rev1>...<rev2>" for git.git use? I think so, but I'm not sure.

If <rev2> is forked from different base than where <rev1> was
forked, then <base> <rev1> <rev2> would give you more sensible
range.  And such an update is inevitable when <rev2> must rely on
new things that recently appeared on <base> since <rev1> forked from
the mainline.  But otherwise <rev1>...<rev2> should work just fine.

> In any case, there are going to be those use-case where you should be
> using "<base> <rev1> <rev2>", and a rebase will be propagated by a
> force-push, so I thought it made sense that range-diff could directly
> consume the output of "fetch" in that case...

I am not absolutely sure if there is *more* useful interpretation
that "<base> <rev1>...<rev2>" may want to mean than to serve as a
synonym for "<base> <rev1> <rev2>" for those who are too lazy to
type.  But if there isn't, I'd say it is a reasonable synonym to
want.

