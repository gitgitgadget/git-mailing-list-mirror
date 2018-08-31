Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B47D11F404
	for <e@80x24.org>; Fri, 31 Aug 2018 11:54:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727545AbeHaQB0 (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Aug 2018 12:01:26 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:36467 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727258AbeHaQB0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Aug 2018 12:01:26 -0400
Received: by mail-qk1-f196.google.com with SMTP id 93-v6so1177451qks.3
        for <git@vger.kernel.org>; Fri, 31 Aug 2018 04:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ipxE6FZnbKCg0fJWI5iB6QFFlzdqcX81LI8x5a1aF/U=;
        b=EDq7WbD4O3HUvStJCnDctdUigxmVw/oasKBwDPYICzECS7nPMXDlOrWJJNeB1Oy33n
         yhWHM+39Mu0Yz+ZQeaoAIHU+Fv9YWjanDfMfLUMTE94Na8XcA9iTxARoz1slXt4xZIxH
         taTeRrIO9vxsKzvWFhG6dJ9m6mWZ6jt9hEmUIbRWAdk8/Ii3kHcamiOioYTM45l3Tk8J
         rGJrd8s2LLiWpNm6+cuvN+cfENVS+TFW63i5+DSOF5oNaPmzrfASdFZ+/eWLYkdj1bRH
         lQz1v/0nl9vRqz6QbmOxEx2N7CRjdLqXED/8zPsTLrkthR6mZb3nxoAQUF5FqLmhgbYA
         IFnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ipxE6FZnbKCg0fJWI5iB6QFFlzdqcX81LI8x5a1aF/U=;
        b=KjjDNeRH+Wq045k9w7i9PAaGrPh9mJsjtX61s1xRkRTavB2aoOU5S23hNkt5Vhnhyb
         gbZfPzTRGvq7xqDuFihzILMnRbPCUXpTCTVORrlaN8b9CJfydrbwkX8L+q27Xa9B51zd
         jGHFLUAWQyIjfo82dGrrLmwurOmVMD6ZpU9T/tgr6HQGXy7g1nqnYxO/zo7NiOsjaeKS
         T+KOobTYIkbGjZQDKe5tSdJ4fWQRZvwlDzzA/AE+kdnGtRwz9nthXrVRddFnlcW89vWM
         EHADaUNpfHGup2rdk0qNx5Rn4HTMHaE1uHLqWW1EdQMKdKwoKT76NQzOPHHulM2+p0AP
         Rp/w==
X-Gm-Message-State: APzg51CLe2ZnSCe8oJV0WbeHWURlV95yW6KjjsghwxLRWn1LR7p69D9D
        23rD6gjaYalDqEMFeXaBetfr/ilC8L6K0+N1lyo=
X-Google-Smtp-Source: ANB0VdZbaCKy4wckLwdJxFNCOcxSYVneFyoacfwOWAsfD4Sv+qTS5xYDI41mFSH9Pe6DVWMSm2vz5mq4qO3jWKxIUAo=
X-Received: by 2002:a37:10d1:: with SMTP id 78-v6mr15099920qkq.72.1535716457830;
 Fri, 31 Aug 2018 04:54:17 -0700 (PDT)
MIME-Version: 1.0
References: <20180805075736.GF44140@aiede.svl.corp.google.com> <20180831083342.34836-1-sunshine@sunshineco.com>
In-Reply-To: <20180831083342.34836-1-sunshine@sunshineco.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Fri, 31 Aug 2018 13:54:05 +0200
Message-ID: <CACBZZX6uCQkCermt8O6v2XB2MnUkt5ER3_z5GYJtGdSk-9JNLA@mail.gmail.com>
Subject: Re: [PATCH] config.mak.uname: resolve FreeBSD iconv-related
 compilation warning
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Renato Botelho <garga@freebsd.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 31, 2018 at 11:52 AM Eric Sunshine <sunshine@sunshineco.com> wrote:
> OLD_ICONV has long been needed by FreeBSD so config.mak.uname defines
> it unconditionally. However, recent versions do not need it, and its
> presence results in compilation warnings. Resolve this issue by defining
> OLD_ICONV only for older FreeBSD versions.

This seems sane, but just for context is FreeBSD ports itself just
compiling without iconv entirely?

[CC FreeBSD devel/git maintainer]

$ uname -r; grep -ri iconv /usr/ports/devel/git
11.2-RELEASE-p2
/usr/ports/devel/git/Makefile:OPTIONS_DEFINE=   GUI SVN GITWEB CONTRIB
P4 CVS HTMLDOCS PERL ICONV CURL \
/usr/ports/devel/git/Makefile:OPTIONS_DEFAULT=  CONTRIB P4 CVS PERL
GITWEB ICONV CURL SEND_EMAIL PCRE \
/usr/ports/devel/git/Makefile:ICONV_USES=               iconv
/usr/ports/devel/git/Makefile:ICONV_MAKE_ARGS_OFF=      NO_ICONV=1

I have little clue about how ports works, but just noticed that
they're not monkeypatching in OLD_ICONV there.
