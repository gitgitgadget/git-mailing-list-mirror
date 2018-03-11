Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 46CD01F404
	for <e@80x24.org>; Sun, 11 Mar 2018 00:00:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932068AbeCKAAJ (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Mar 2018 19:00:09 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:42496 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751206AbeCKAAI (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Mar 2018 19:00:08 -0500
Received: by mail-wr0-f196.google.com with SMTP id k9so12255912wre.9
        for <git@vger.kernel.org>; Sat, 10 Mar 2018 16:00:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=shS2W+Vm/m2a7iOB3ToqGUfMRsCS9zCb5jkE7x+KQeA=;
        b=p5IomaH8EzcB+aCLzmjd41CsNONxmfYkM8FBK91gUX8ZeY88nBZX5JuiUpAlcwg6Dj
         QfBndU+QbIxfeAykIndfCuNLKxLjo47dQ07C0+es8Jkc032sZf+vlbgSJeEpIvNgWsHu
         dDidVGW1cvPJXNiwFeYy3oLy3iOSSz/iporDE0CiQMtB/0ALXsSRV84ufoCEcmccfFm6
         BzTo2nyFMRyAQVo7a1TeFSVnfJTY9IShpi1ttk5d9bzEjGUkk8kXVLoi9E7qVNBlmX8J
         JovvJSFylxpV/1iz5tkS1efOcX8Kl3XpTqZR8Dnw62AL2zw7SgwxJFX6MkeJP3KWaFCL
         WUiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=shS2W+Vm/m2a7iOB3ToqGUfMRsCS9zCb5jkE7x+KQeA=;
        b=dzErsAIMs+Q+MlO4uPgBsFeEaAt5cCWXUJqYEMtlXRQkMjzbgONnIr8qUCO0qcR0Rs
         ubKw5dMP93BwkZJvXfK123rBjVuVygmAPJzJ+YCDFpqVMnopH+N6iomd1lQUTpNlwLIn
         QHgCdCZsN6Fn2QPJmpOIR6THEjspdmiwJX0lT1vI4V6LHkep83xet9DSIkSPm6uDH2j3
         msLR8gxnUH3rzfkA3qljmQODxZCc3q3dTKG5w6Cy1P8LydW9dDhSpirI/a/5ThtvORqR
         LPrGy+XotE549yy7IvId+O8RS94UgTA7ZkotDIh6gbLSIzvIgmq8cDVeYOY4cKsXKxSS
         FE1Q==
X-Gm-Message-State: AElRT7H9Al0twGo+1iKdmU7LZ/JaE3eYNcb5qDR1OXh7vgnlbGF02yim
        SkSBjgZ8d9nR9X0xbOVfVjg=
X-Google-Smtp-Source: AG47ELsXfZKQ5HqX3nZUxoiKUao8VCbfQyRqCBkgK3Mj0hkUn8LUd0mNW5hcdaf7GoK6tvzj7fjo4A==
X-Received: by 10.223.161.10 with SMTP id o10mr2692318wro.60.1520726407634;
        Sat, 10 Mar 2018 16:00:07 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id z73sm5447185wrb.50.2018.03.10.16.00.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 10 Mar 2018 16:00:05 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ilya Kantor <iliakan@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: git rerere to remember half-merged progress - valid use?
References: <CAFU8umhtBxs9X+f1p3k8D6a4mue6OvM9cydrK-cRW8Nsq8Vcww@mail.gmail.com>
Date:   Sat, 10 Mar 2018 16:00:04 -0800
In-Reply-To: <CAFU8umhtBxs9X+f1p3k8D6a4mue6OvM9cydrK-cRW8Nsq8Vcww@mail.gmail.com>
        (Ilya Kantor's message of "Sat, 10 Mar 2018 17:22:46 +0300")
Message-ID: <xmqq1sgr4h2z.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ilya Kantor <iliakan@gmail.com> writes:

> Let's say I'm merging a branch with many conflicts.
> I resolved some of them, but then can't proceed or need to switch elsewhere.
>
> Will it be a good practice to call `git rerere` to remember resolved
> conflicts, so that in the future
> when I re-merge, I get my half-done merge back?

As many of real world issues, the answer is "it depends".  

If you are absolutely sure about what you have resolved so far, then
recording the resolutions for files that you have finished while
there are still other files with conflicts to be resolved before
switching away to another task is a very sensible thing to do.

On the other hand, recording resolutions you are not sure about
means more work for you when you come back and attempt the merge
again, as you would need to check resolutions of which files need
to be nuked and redone (using "checkout -m" and "rerere forget").

My personal strategy is to avoid abandoning conflict resolution in
the middle in the first place ;-), but in many cases I can be quite
confident that I resolved conflicts in a file correctly without
looking at conflicts in other files, so I do not think it is a bad
practice to record resolution of files you resolved so far by
calling "rerere" manually.
