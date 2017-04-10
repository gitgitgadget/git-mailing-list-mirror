Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F03E11FAFB
	for <e@80x24.org>; Mon, 10 Apr 2017 01:47:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752100AbdDJBre (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Apr 2017 21:47:34 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35904 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751200AbdDJBrd (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Apr 2017 21:47:33 -0400
Received: by mail-wm0-f66.google.com with SMTP id q125so7166370wmd.3
        for <git@vger.kernel.org>; Sun, 09 Apr 2017 18:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:mime-version
         :content-transfer-encoding;
        bh=yEZXoDhRqtStTbH6mHfqPDvUIdB2Ab/Y2NH/nbIyIY8=;
        b=fU8/NgmHybozI2ofTqsn04H90R//lEto4KpVQJuFfxzyG/wao0BnU3AxIn9/fUCcg6
         WKnRkaQuHluOGZLnIe5irO8zu8lPK2FZm2PaWwlSI9sWuZdriqHuMcfdGCEPPWPXsY41
         aTEisLGu2s0g1Uws+XxFvv1twb6DGzG5LVBqCYVmaSSAJ1zcfqODUhEYwmJAgFJQ5+VW
         k4jVJsu58P5jlcUAmprSS4+8oUUNdty+4tmLq2pZ2E4nY7TiMWRU7orCd2fNldKYPbio
         qQEp96m1IYH00PNsyAvooE/8IhK87CVh0SE3pVcHdJV0l+cI6aLXiucIBLSORMaN4nGr
         cyew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :mime-version:content-transfer-encoding;
        bh=yEZXoDhRqtStTbH6mHfqPDvUIdB2Ab/Y2NH/nbIyIY8=;
        b=eXkxxrcKAgfvXWW47SptL6erGliPg1iEBPvG+PsRyQ7kfs7w9UIjA58h0OVCKMzzuP
         qTeWGcEmKzZcbHk50rd59GRPkbvZDocRaKOHiOQ1koHZnO2aNvr/K5Nc9rZH8IO84RqD
         WUTTn1kmOfstY3G4XXUcM+MxPnXtHeFPQcJvdrbO9CSrHsIqQjyvpEtaaQOiy2Vq7TvP
         Mwt1eem1iTr7FT0dEcIuxtF2fidlDbPuJh5xFp4txofiMD6fNjYE7flNP9NxcblxIjDa
         Z3Rfcix4q+fo16+iXq76W1vuAArGhmUAo6E0nU/Bv78hZQEeFCt/sT/Zris6g3rwTNqM
         sWmA==
X-Gm-Message-State: AN3rC/5jtDSJ86olVObB4SDBsx3DxDYUqY6/J4Sq4k0qHICX9tvJVjA8CGq9fjwaPE/3AA==
X-Received: by 10.28.149.208 with SMTP id x199mr7548587wmd.91.1491788852312;
        Sun, 09 Apr 2017 18:47:32 -0700 (PDT)
Received: from localhost.localdomain (x590cc874.dyn.telefonica.de. [89.12.200.116])
        by smtp.gmail.com with ESMTPSA id v186sm8255546wmv.2.2017.04.09.18.47.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 09 Apr 2017 18:47:31 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bmwill@google.com>,
        Jeff King <peff@peff.net>,
        Joachim Durchholz <jo@durchholz.org>,
        Stefan Beller <sbeller@google.com>, git@vger.kernel.org
Subject: Re: [PATCH 2/2] test-lib: exhaustively insert non-alnum ASCII into the TRASH_DIRECTORY name
Date:   Mon, 10 Apr 2017 03:47:12 +0200
Message-Id: <20170410014712.26716-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.12.2.613.g9c5b79913
In-Reply-To: <20170409191117.25175-3-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Change the test library to insert non-alphanumeric ASCII characters
> into the TRASH_DIRECTORY name, that's the directory the test library
> creates, chdirs to and runs each individual test from.
> 
> Unless test_fails_on_unusual_directory_names=1 is declared before
> importing test-lib.sh (and if perl isn't available on the system), the
> trash directory will contain every non-alphanumeric character in
> ASCII, in order.

At the very least there must be an easier way to disable this, e.g. a
command line option.

This change is sure effective in smoking out bugs, but it's a major
annoyance during development when it comes to debugging a test.  At
first I could not even cd into the trash directory, because TAB
completing the directory name with all those non-printable characters
didn't work (this may be a bug in the bash-completion package).  And
simply copy-pasting the dirname didn't work either, because 'ls'
displayed it as

  trash directory.t9902-completion.??????????????????????????????? !"#$%&'()*+,-:;<=>?@[\]^_`{|}~?

After some headscratching, Sunday night may be my excuse, I figured
out that 'cd tr*' works...  only to be greeted with the ugliest-ever
three-line(!) shell prompt.

Therefore I would say that this should not even be enabled by default
in test-lib.sh, so at least running a test directly from the command
line as ./t1234-foo.sh would considerately give us an easily
accessible trash directory even without any command line options.  We
could enable it for 'make test' by default via GIT_TEST_OPTS in
t/Makefile, though.


> This includes all the control characters, !, [], {} etc. the "."
> character isn't included because it's already in the directory name,
> and nor is "/" for obvious reasons, although that would actually work,
> we'd just create a subdirectory, which would make the tests harder to
> inspect when they fail.i

1. Heh.  How an additional subdirectory would make the tests harder to
   inspect is nothing compared to the effect of all the other
   characters.

2. s/i$//

> This change is inspired by the "submodule: prevent backslash expantion
> in submodule names" patch[1]. If we'd had backslashes in the
> TRASH_DIRECTORY all along that bug would have been fixed a long time
> ago. This will flag such issues by marking tests that currently fail
> with "test_fails_on_unusual_directory_names=1", ensure that new tests
> aren't added unless a discussion is had about why the code can't
> handle unusual pathnames, and prevent future regressions.
> 
> 1. <20170407172306.172673-1-bmwill@google.com>
> ---
>  t/README      | 12 ++++++++++++
>  t/test-lib.sh |  4 ++++
>  2 files changed, 16 insertions(+)
> 
> diff --git a/t/README b/t/README
> index ab386c3681..314dd40221 100644
> --- a/t/README
> +++ b/t/README
> @@ -345,6 +345,18 @@ assignment to variable 'test_description', like this:
>  	This test registers the following structure in the cache
>  	and tries to run git-ls-files with option --frotz.'
>  
> +By default the tests will be run from a directory with a highly
> +unusual filename that includes control characters, a newline, various
> +punctuation etc., this is done to smoke out any bugs related to path
> +handling. If for whatever reason the tests can't deal with such
> +unusual path names, set:
> +
> +    test_fails_on_unusual_directory_names=1
> +
> +Before sourcing 'test-lib.sh' as described below. This option is
> +mainly intended to grandfather in existing broken tests & code, and
> +should usually not be used in new code, instead your tests or code
> +probably need fixing.
> 
>  Source 'test-lib.sh'
>  --------------------
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 13b5696822..089ff5ac7d 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -914,6 +914,10 @@ fi
>  
>  # Test repository
>  TRASH_DIRECTORY="trash directory.$(basename "$0" .sh)"
> +if test -z "$test_fails_on_unusual_directory_names" -a "$(perl -e 'print 1+1' 2>/dev/null)" = "2"
> +then
> +   TRASH_DIRECTORY="$TRASH_DIRECTORY.$(perl -e 'print join q[], grep { /[^[:alnum:]]/ and !m<[./]> } map chr, 0x01..0x7f')"
> +fi
>  test -n "$root" && TRASH_DIRECTORY="$root/$TRASH_DIRECTORY"
>  case "$TRASH_DIRECTORY" in
>  /*) ;; # absolute path is good
> -- 
> 2.11.0


