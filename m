Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 577DA202A2
	for <e@80x24.org>; Fri, 20 Oct 2017 23:50:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752824AbdJTXuY (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Oct 2017 19:50:24 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:47909 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752498AbdJTXuX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Oct 2017 19:50:23 -0400
Received: by mail-wm0-f65.google.com with SMTP id t69so557151wmt.2
        for <git@vger.kernel.org>; Fri, 20 Oct 2017 16:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:mime-version
         :content-transfer-encoding;
        bh=NlG3M+JmVhK9ekixi2EMuJNblHaiQWVuxU7DotQUDoU=;
        b=KIEpJc8eovK3F0CUE46N7RxdqQBs74yAW+Nq0gaKItM/rbp44f7GJCjxDVjYwIjV+I
         dawNgMfWd6QfpmIOVmS6HmfygBRo7ZOqXvWAokL/6UmU7KyrJnGSL1xp9uRe8gY2PkCw
         52XKi+o4OpxZQzRsH1r7weK//4HO/Oo4Nwgb9A3XRUv6o+/840anYvy0FYGG08ydVxRC
         Ok6iJTxmwMXHFqtDo6na1kMUybys1aMagBq/gcBszYoaGgxrgmPMmGPhH58m5DxhS1oT
         Wh3wMxUUH2BRXX6Yr0Xb3FWm9i8zqLSNg30enin6r4If7+2CjUKK/Msz8gIhbnV7htnH
         YLXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :mime-version:content-transfer-encoding;
        bh=NlG3M+JmVhK9ekixi2EMuJNblHaiQWVuxU7DotQUDoU=;
        b=f/fR0FiIj6Ff/XvygGaMw7pecMPzt34P80wUsmz8KwOQiU9L6SC/DNq8Z4ej2Kfnrr
         LGJ3g+MROQRM1igO0HAdx1dPPGOuUVB2P/7cioxw+KZsgTAEfCCKhgDnt808KMonjrWE
         jAoKKP/0TonoJp2vypN383LfE2XRF3SuBT/mQWLM95MRXeNaavVjknst3DKptlgk0LVQ
         KoS/HqMWf+rntVGd43DdyHhC+t5j9800cFk7aI7RYvKZV/fACe4safJqTmow3e4G1Les
         t2aUVtq81OaPyy5k/egcwRVp+AjwstagTYC+SwwJ5Qjh7BZF1348a7o4OYnmbqhWJ9zU
         rf1A==
X-Gm-Message-State: AMCzsaUHDASdTNFSl5WXiOYAftQu8orSXm1d4cNImlDHLd2TMdTGXbkJ
        +yXt6liB52DXRkfmwYrCQyo=
X-Google-Smtp-Source: ABhQp+R7omYDBf4K3QJYLTxGyR7BWN+RVWZyYQwvrmg0WXDBH+0tBpgtPGOi+Mf7Xq/dDlV31RGLkQ==
X-Received: by 10.28.191.138 with SMTP id o10mr248211wmi.61.1508543422449;
        Fri, 20 Oct 2017 16:50:22 -0700 (PDT)
Received: from localhost.localdomain (x590de0df.dyn.telefonica.de. [89.13.224.223])
        by smtp.gmail.com with ESMTPSA id e17sm6892453wmf.46.2017.10.20.16.50.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 20 Oct 2017 16:50:21 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 4/3] t/Makefile: introduce TEST_SHELL_PATH
Date:   Sat, 21 Oct 2017 01:50:01 +0200
Message-Id: <20171020235001.5072-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.15.0.rc1.76.g9702d22d1
In-Reply-To: <20171020225340.6qgybldewi7knxvz@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On Thu, Oct 19, 2017 at 05:01:40PM -0400, Jeff King wrote:
> 
> > I sometimes run git's test suite as part of an automated testing
> > process. I was hoping to add "-x" support to get more details when a
> > test fails (since failures are sometimes hard to reproduce).

Would it make sense (or be feasible) to enable "-x" on Travis CI?


> diff --git a/Makefile b/Makefile
> index cd75985991..9baa3c4b50 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -425,6 +425,10 @@ all::
>  #
>  # to say "export LESS=FRX (and LV=-c) if the environment variable
>  # LESS (and LV) is not set, respectively".
> +#
> +# Define TEST_SHELL_PATH if you want to use a shell besides SHELL_PATH for
> +# running the test scripts (e.g., bash has better support for "set -x"
> +# tracing).
>  
>  GIT-VERSION-FILE: FORCE
>  	@$(SHELL_PATH) ./GIT-VERSION-GEN
> @@ -727,6 +731,8 @@ endif
>  export PERL_PATH
>  export PYTHON_PATH
>  
> +TEST_SHELL_PATH = $(SHELL_PATH)
> +
>  LIB_FILE = libgit.a
>  XDIFF_LIB = xdiff/lib.a
>  VCSSVN_LIB = vcs-svn/lib.a
> @@ -1721,6 +1727,7 @@ prefix_SQ = $(subst ','\'',$(prefix))
>  gitwebdir_SQ = $(subst ','\'',$(gitwebdir))
>  
>  SHELL_PATH_SQ = $(subst ','\'',$(SHELL_PATH))
> +TEST_SHELL_PATH_SQ = $(subst ','\'',$(TEST_SHELL_PATH))
>  PERL_PATH_SQ = $(subst ','\'',$(PERL_PATH))
>  PYTHON_PATH_SQ = $(subst ','\'',$(PYTHON_PATH))
>  TCLTK_PATH_SQ = $(subst ','\'',$(TCLTK_PATH))
> @@ -2350,6 +2357,7 @@ GIT-LDFLAGS: FORCE
>  # and the first level quoting from the shell that runs "echo".
>  GIT-BUILD-OPTIONS: FORCE
>  	@echo SHELL_PATH=\''$(subst ','\'',$(SHELL_PATH_SQ))'\' >$@+
> +	@echo TEST_SHELL_PATH=\''$(subst ','\'',$(TEST_SHELL_PATH_SQ))'\' >$@+

This redirection overwrites, loosing the just written SHELL_PATH.  It
should append like the lines below.

>  	@echo PERL_PATH=\''$(subst ','\'',$(PERL_PATH_SQ))'\' >>$@+
>  	@echo DIFF=\''$(subst ','\'',$(subst ','\'',$(DIFF)))'\' >>$@+
>  	@echo PYTHON_PATH=\''$(subst ','\'',$(PYTHON_PATH_SQ))'\' >>$@+


Gábor

