Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9612D1F404
	for <e@80x24.org>; Thu, 13 Sep 2018 18:54:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727842AbeINAFg (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Sep 2018 20:05:36 -0400
Received: from mail-ed1-f54.google.com ([209.85.208.54]:42976 "EHLO
        mail-ed1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727231AbeINAFg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Sep 2018 20:05:36 -0400
Received: by mail-ed1-f54.google.com with SMTP id l5so5470034edw.9
        for <git@vger.kernel.org>; Thu, 13 Sep 2018 11:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=eJNhHwpY6Q2hDwQNlpGeHlZQTas3/Xodg5BYWH5ob+I=;
        b=WGG+T2E1bTRm5XeFku+v5QvSRDi0o1/mLAvPdClk2sK4Lcziy+dfsWRXxetLvNyazH
         9YyUG7VNf2K/UWSbAg9REwx9Z6SY+OeGmrQzKhxibWsrJ8ol5NbUk09kCRQ+1LhDdMSF
         CrMlkfLUncRm5wVJzp5LEtpt+G+cYlGOSLx9yDyuqH7j+/Wicb/GFrQJmGNso2FU7OVv
         BQdIbDmYqj3eEPc6n9FyCvT0q0qgm8bi60u/cZo99fP/e0egASrzkKKa/8WBynX6v5QA
         vF1d1nsGbrejQ9MnhKtyiHgEswLH/zuS6qqnEubHsxNmoo8w42XjLgmNQg7aBqu5RRcF
         0YKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=eJNhHwpY6Q2hDwQNlpGeHlZQTas3/Xodg5BYWH5ob+I=;
        b=dn+Yc7CHggOYO6Rc68bhzunhCuXe9RpZeUDw51Sn/MkIYy6qQXmybiyesS2NK+Xt/H
         cUetMTbADg3lfmIHRZUqhSHvfR6OIMl0cPZUDXZz3mAQjcJIdV7VHhYvBNc40ou+8Diz
         PA0QUv/jlK076Kd+VsXDX+pEX05pMNyjmEFiYKPKcNdbbcRq/jdiHUfn41WMAtqSxAFJ
         R5QBM7kr01BCd7nc8mJvyvNfbtbFB9QTk1GsufF7xILgDJKWXV/6BsxZm4K07clRm50Y
         hMEHjP4E1JAxagqs61LwgzuFutDL+ZSKNSLz0Hb7GJtRgkoN9Ur9DXIjNxyUw5P97jsF
         ldmA==
X-Gm-Message-State: APzg51CAv6xZolgeIkkKbxVuL0DsCJuqPG4u4yIhRewRcofD45cVKhZp
        XcbM0T8SuYUt/ZVXZLDSoLnqpG7KTfU=
X-Google-Smtp-Source: ANB0VdbMUis4LIOMnMkb0QjhsbbMecIgWNWXfSjr0g6GJUrbE9C4Y5WGNKqO56kJJumBO9baLDCyVw==
X-Received: by 2002:a50:ec03:: with SMTP id g3-v6mr13397163edr.96.1536864888734;
        Thu, 13 Sep 2018 11:54:48 -0700 (PDT)
Received: from evledraar (157-157-127-103.dsl.dynamic.simnet.is. [157.157.127.103])
        by smtp.gmail.com with ESMTPSA id x32-v6sm2887062eda.81.2018.09.13.11.54.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Sep 2018 11:54:47 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Ben Peart <benpeart@microsoft.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>,
        "gitster\@pobox.com" <gitster@pobox.com>,
        Ben Peart <Ben.Peart@microsoft.com>
Subject: Re: [PATCH v1] fsmonitor: update GIT_TEST_FSMONITOR support
References: <20180913174522.53872-1-benpeart@microsoft.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20180913174522.53872-1-benpeart@microsoft.com>
Date:   Thu, 13 Sep 2018 20:54:46 +0200
Message-ID: <87h8itkz2h.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Sep 13 2018, Ben Peart wrote:

> diff --git a/config.c b/config.c
> index 3461993f0a..3555c63f28 100644
> --- a/config.c
> +++ b/config.c
> @@ -2278,7 +2278,7 @@ int git_config_get_max_percent_split_change(void)
>  int git_config_get_fsmonitor(void)
>  {
>  	if (git_config_get_pathname("core.fsmonitor", &core_fsmonitor))
> -		core_fsmonitor = getenv("GIT_FSMONITOR_TEST");
> +		core_fsmonitor = getenv("GIT_TEST_FSMONITOR");
>
>  	if (core_fsmonitor && !*core_fsmonitor)
>  		core_fsmonitor = NULL;
> diff --git a/t/README b/t/README
> index 9028b47d92..545438c820 100644
> --- a/t/README
> +++ b/t/README
> @@ -319,6 +319,10 @@ GIT_TEST_OE_DELTA_SIZE=<n> exercises the uncomon pack-objects code
>  path where deltas larger than this limit require extra memory
>  allocation for bookkeeping.
>
> +GIT_TEST_FSMONITOR=$PWD/t7519/fsmonitor-all exercises the fsmonitor
> +code path for utilizing a file system monitor to speed up detecting
> +new or changed files.
> +
>  Naming Tests
>  ------------

I've seen this & will watch out for it, but still, when I'm updating to
"next" in a couple of months I may not be tracking the exact state of
the integration of this patch, and then running with
GIT_FSMONITOR_TEST=... will suddenly be a noop.

So maybe something like this to test-lib.sh as well (or directly in
config.c):

    if test -n "$GIT_FSMONITOR_TEST"
    then
        echo "The GIT_FSMONITOR_TEST variable has been renamed to GIT_TEST_FSMONITOR"
        exit 1
    fi

Maybe I'm being too nitpicky and there's only two of us who run the test
with this anyway, and we can deal with it.

It just rubs me the wrong way that we have a test mode that silently
stops being picked up because a command-line option or env variable got
renamed, especially since we've had it for 4 stable releases, especially
since it's so easy for us to avoid that confusion (just die),
v.s. potential time wasted downstream (wondering why fsmonitor stuff
broke on $SOME_OS even though we're testing for it during package
build...).
