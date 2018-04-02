Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 343091F404
	for <e@80x24.org>; Mon,  2 Apr 2018 20:12:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756395AbeDBUMn (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Apr 2018 16:12:43 -0400
Received: from mail-wm0-f51.google.com ([74.125.82.51]:38580 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755836AbeDBUMm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Apr 2018 16:12:42 -0400
Received: by mail-wm0-f51.google.com with SMTP id i3so5935373wmf.3
        for <git@vger.kernel.org>; Mon, 02 Apr 2018 13:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=a/ddXmlHOgMylgrMVdWifwni762tL6JsZg+snEyVZws=;
        b=sn4tR37jcj7XNc+ySrBpFxfq5gM7M3VBA9zkMlZR716PgE9QGrZxLKwKL6+lnrw212
         XqYQBH3cVt/slU1A8MUPRZ42IdMArxHlUBQf+tFNAy9P6kKxW8oW2HJLQkNKnenulMuE
         mVhAnwVF6exe+XVunlAdi9agwYdilH+KzYR38AWtdJLw4QvKmPBlstH9rGYFmseAhZ23
         pzWZMgHgMSRIJwhbei5jLheF0kRxbaLd6fJta6NbVoHWxAZZqDWwxhNVEEnSWcXrQ0CP
         AsYw7HC5uzQ8u84nRkFAyCLNY/I6CSBDMxN+E9Jx26k7xM19mrsDM1Zq/Da7/ki4JNrT
         PXvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=a/ddXmlHOgMylgrMVdWifwni762tL6JsZg+snEyVZws=;
        b=hCKp+s9z/e6CDN64Cki3nWdPubRM1TGrRE73afqLzSDHc83LNanQ+b3qBEaF7cKMle
         luhJVWdDT+ZjqhsE1HgVJsn1riu5dgVYg+ckap3L1e+9S0TjvJdkDNeqPyQBKIhkbDd2
         H785hYyOICWwdNqFWRo28Q9F0kCYTv2+CmHsHiUrhjp3+syIkdlEYLVctod/5KLomtee
         XoOGBb4vpfTVqK18xG3fl4NFTQSee4mTHvsJc+37DR1xZN1e24OwauqRR76YyLS5mrbS
         dQMdBlYYsykLmQh6oxEAH7Fu5IeSwFOchRg4SSRytnMukPudaa/FobOE8xyZ1eWNwTuT
         vp5Q==
X-Gm-Message-State: AElRT7EXyHoUz6vJ5+jKc82BzGtfFy9/f4pqAtos+GRPavpb/xpdI9je
        vsuxkhNA+hD/49ffk6gNPf6G+zUi
X-Google-Smtp-Source: AIpwx49DQQ3cs995GWn6rCMwjEx0wRaT+XILDOqFW3F1+G5FWX+aWQV0uc9KtiP+Bg6hd5mGnLuRGA==
X-Received: by 10.28.178.212 with SMTP id b203mr1659293wmf.32.1522699960679;
        Mon, 02 Apr 2018 13:12:40 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id r19sm494425wmd.32.2018.04.02.13.12.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Apr 2018 13:12:39 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Harald Nordgren <haraldnordgren@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] ls-remote: create '--sort' option
References: <20180402200736.80161-1-haraldnordgren@gmail.com>
Date:   Mon, 02 Apr 2018 13:12:39 -0700
In-Reply-To: <20180402200736.80161-1-haraldnordgren@gmail.com> (Harald
        Nordgren's message of "Mon, 2 Apr 2018 22:07:36 +0200")
Message-ID: <xmqq1sfxz7t4.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Harald Nordgren <haraldnordgren@gmail.com> writes:

> Subject: Re: [PATCH] ls-remote: create '--sort' option

It would be more helpful to mark as [PATCH v2] a rerolled patch like
this.

> Create a '--sort' option for ls-remote. This is useful e.g. for the Go
> repository after the release of version 1.10, where by default v1.10 is
> sorted before v1.2. See:
>
> 	$ git ls-remote -t https://go.googlesource.com/go

Does this sample command line also need updating for the refined
design?

> 	...
> 	205f850ceacfc39d1e9d76a9569416284594ce8c        refs/tags/go1.1
> 	d260448f6b6ac10efe4ae7f6dfe944e72bc2a676        refs/tags/go1.1.1
> 	1d6d8fca241bb611af51e265c1b5a2e9ae904702        refs/tags/go1.1.2
> 	bf86aec25972f3a100c3aa58a6abcbcc35bdea49        refs/tags/go1.10
> 	ac7c0ee26dda18076d5f6c151d8f920b43340ae3        refs/tags/go1.10.1
> ...
> +	git ls-remote --sort="-version:refname" --tags self >actual &&
> +	test_cmp expect actual
> +...
> +	git ls-remote --sort="-refname" --tags self >actual &&

These both look sensible (also the variant without the dash prefix
which I omitted from the quote).



