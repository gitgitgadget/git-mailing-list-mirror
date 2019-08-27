Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 42F2E1F461
	for <e@80x24.org>; Tue, 27 Aug 2019 18:36:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730424AbfH0Sgq (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Aug 2019 14:36:46 -0400
Received: from mail-wm1-f48.google.com ([209.85.128.48]:37161 "EHLO
        mail-wm1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730262AbfH0Sgq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Aug 2019 14:36:46 -0400
Received: by mail-wm1-f48.google.com with SMTP id d16so140377wme.2
        for <git@vger.kernel.org>; Tue, 27 Aug 2019 11:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=I7WC2ELTxeDmodG5LAZPtNXdjw2oe8/h1PL2Nq2tcNQ=;
        b=Y7VKddYkZq6NROhjp0uULmOP9QXmYe4iEWY9U/enMaxw7aG7nPb5WCpqHOgkhP3zMb
         FyoKnuq+L0djNPQYQ6o/mJVd37D0mGVxNaWp7IhLNVqnOjbqAv2yKFA5+NG+zZ+EoZJl
         cjpCRL3MogtiXLa9KGue5nbQwPab2zr8CWsL3jCp4pxsaSQEukkW99clGYrfVfq2fOYe
         p3QMpXERukdJodIIylcvvxBFHyhXwt8HCUnmUsORwUrgtD0lP8YeIl5T/bVkza4CPWwb
         SSCz97z6lp4nGcUQf4PYmQ2qAetwkkpw8b7YxMAYGLK20KlJf9RP1mLMNG7RxrqOQmpB
         ziJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=I7WC2ELTxeDmodG5LAZPtNXdjw2oe8/h1PL2Nq2tcNQ=;
        b=XXCVrv26pBG0qeR6Qgo8tYTSWi2Cha/GB1Kur1/xp20sAaQH9Zo4MgsJPjTQtDtdIj
         G15fxolWPyEINfbVGHa1zCMdDd5vS77YWxiwUd3lrzvv6ioxQ4EOsdhK/2hcjkIlKuCQ
         r7bzA+a8yqtNLQikndurw2fb+wkTcIM2aMBxPIVQyS6U9v6C7tf7iIavUbjLQhHlkD0S
         +pRRiwN1Xov8TuWJlxayA9q+s75vQ6bzs2kLNLPrWyQSN+62fvobYGzCN+vZnZ5+QpCv
         36NzQx7L5Oxx9DRx2yPlGZihxc0a9qDuz3XgbkDehA0U+o482N/c8k51pOuaSA2U5+mA
         Ut4Q==
X-Gm-Message-State: APjAAAV3+j5Ojm3NqI155gwZNqgIsvQhaAK1YGw3PL7eyj6qoYZFvhOA
        GlPRkwzBKgPbEF0ak1nI83w=
X-Google-Smtp-Source: APXvYqyIWhJ5ypC+jNJwRqTuoFY5azkAs//efpB/bopy/+ZJd4YBLRgnOXgJuJQQz3dgGBpRsDmYYw==
X-Received: by 2002:a05:600c:2056:: with SMTP id p22mr322188wmg.159.1566931004064;
        Tue, 27 Aug 2019 11:36:44 -0700 (PDT)
Received: from szeder.dev (x4db46f61.dyn.telefonica.de. [77.180.111.97])
        by smtp.gmail.com with ESMTPSA id r17sm41251185wrg.93.2019.08.27.11.36.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Aug 2019 11:36:42 -0700 (PDT)
Date:   Tue, 27 Aug 2019 20:36:40 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Giuseppe Crino' <giuscri@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: How to build to debug with gdb?
Message-ID: <20190827183640.GC8571@szeder.dev>
References: <20190827162725.GA29263@instance-template-2.europe-west6-a.c.vaulted-journal-250706.internal>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190827162725.GA29263@instance-template-2.europe-west6-a.c.vaulted-journal-250706.internal>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 27, 2019 at 04:27:25PM +0000, Giuseppe Crino' wrote:
> Hello, to debug some issues I built and installed git via
> 
> $ make prefix=/usr/local DEVELOPER=1 CFLAGS="-O0 -g"
> $ sudo make install

What do the output of these two command look like?  After the first
command build Git with the custom prefix and CFLAGS, the second
command is supposed to start with printing "* new build flags" and
then to build Git again with the default prefix and CFLAGS.

>  What am I missing?

Just a couple hundred lines worth of build output :)

Try using the same build flags for the install, i.e.:

  make prefix=/usr/local DEVELOPER=1 CFLAGS="-O0 -g" install

