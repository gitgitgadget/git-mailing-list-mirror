Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B12E41F405
	for <e@80x24.org>; Thu, 20 Dec 2018 16:25:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732815AbeLTQZO (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Dec 2018 11:25:14 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54839 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731218AbeLTQZO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Dec 2018 11:25:14 -0500
Received: by mail-wm1-f67.google.com with SMTP id a62so2661379wmh.4
        for <git@vger.kernel.org>; Thu, 20 Dec 2018 08:25:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HRpusG5qkVTxDrSNiPEdBqCz5TBQyjlh5Q5R1negWek=;
        b=VM7J/+gytSs+VyL27HetolNMK9vjaNwcI6NL4BYHJNN3yxrAO4p7I+LfuzZHj5iSKA
         2vTYAuEVCXQhYyGGDyltRMQkwaUvewOF6r00KpPMySeaI0CEPNQLyoP2bEoa5uuK7Suu
         7pgoLGJeq7j7AdA7ZSzwHLdsqnxklAmSWx5xTyEJOeoUz70r2BY/6A0tH3P8zbd4EI0n
         lAC9p1nBk/dlT9mLGbhov8J/ft59yq118TS4vnxUlizKCFlTka+wN/SKDe95vOSnVEMp
         Y5KG61ei/yHdsF6FYC+ZQWFcRyTTkgZopf9yjP+pI+tn6U8Zj0ghin9oR/61H+WJ2IWE
         mCqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HRpusG5qkVTxDrSNiPEdBqCz5TBQyjlh5Q5R1negWek=;
        b=McsL4qEV0V6ijKnyRIIuZOBt80my8m3z1/1ZnaOb9i9e+yihrJRWnNZP6MpJaJxYiY
         cFmdxy1zYIYAxMQRCMpBSaApueulR5XFJtWHBQeTSBR2W1WYnZD2fkQHNSbgaM0h6Ykw
         Xq4Fr+m5NyoOVdgjCHq0MYC0jxAah6CcKg8a5f/m31Cvfb/eGqMB+xKfphs4O6Z9bn+u
         3+qc/nKnWLsbmZ9JvQVRuWxTabUgqxAGxYMPv3XoZotrgey/20oDS7aVoAV0IzL+Cn5M
         kJGWDp4Ho6RELbtkBHYIhCEuTnJ61DgoGU9+LfOQW9ponAThB4gSHvjjdZGJk6mYiuk6
         iIKA==
X-Gm-Message-State: AA+aEWZhQEoLbK8gJomKL4PbHdQHKlIqyuSIcuL2W9RKE12vRDLXbLSR
        IK6Yg8/78ITiQcOMHuDhD/4=
X-Google-Smtp-Source: AFSGD/UEB3um2UdzN0qt6xvXI/19oy4l1JxKu00deN8uT8ZVcbrvo7tYtGKJnzwFV8ppAXdnI8FocQ==
X-Received: by 2002:a1c:ac85:: with SMTP id v127mr10975008wme.62.1545323111452;
        Thu, 20 Dec 2018 08:25:11 -0800 (PST)
Received: from localhost.localdomain (x4db1e5de.dyn.telefonica.de. [77.177.229.222])
        by smtp.gmail.com with ESMTPSA id 200sm8980566wmw.31.2018.12.20.08.25.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 20 Dec 2018 08:25:10 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 0/5] travis-ci: build with the right compiler
Date:   Thu, 20 Dec 2018 17:24:47 +0100
Message-Id: <20181220162452.17732-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.20.1.151.gec613c4b75
In-Reply-To: <20181016184537.GN19800@szeder.dev>
References: 
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Oct 16, 2018 at 08:45:37PM +0200, SZEDER Gábor wrote:
> Our Makefile has lines like these:
> 
>   CFLAGS = -g -O2 -Wall
>   CC = cc
>   AR = ar
>   SPATCH = spatch
> 
> Note the use of '=', not '?='.  This means that these variables can be
> overridden from the command line, i.e. 'make CC=gcc-X.Y' will build
> with that particular GCC version, but not from the environment, i.e.
> 'CC=gcc-X.Y make' will still build with 'cc'.
> 
> This can be confusing for developers who come from other projects
> where they used to run 'CC=whatever make'.
> 
> And our build jobs on Travis CI are badly affected by this.  We have
> dedicated build jobs to build Git with GCC and Clang both on Linux and
> OSX from the very beginning (522354d70f (Add Travis CI support,
> 2015-11-27)).  But guess how Travis CI specifies which compiler to
> use!  With 'export CC=gcc' and 'export CC=clang', respectively.
> Consequently, our Clang Linux build job has always used gcc, because
> that's where 'cc' points at on Linux by default, while the GCC OSX
> build job has always used Clang.  Oh, well.  Furthermore, see
> 37fa4b3c78 (travis-ci: run gcc-8 on linux-gcc jobs, 2018-05-19), where
> Duy added an 'export CC=gcc-8' in an attempt to use a more modern
> compiler, but this had no effect either.
> 
> I'm not sure what to do.  I'm fine with updating our 'ci/' scripts to
> explicitly respect CC in the environment (either by running 'make
> CC=$CC' or by writing $CC into 'config.mak').

So, this patch series, in particular the last patch fixes this issue
by setting MAKEFLAGS to contain the right CC from the environment.

The first four patches are necessary cleanups/fixes to make it work,
though, arguably, the third patch is neither strictly necessary nor
that closely related to this series, but it just happened to bite me
while working on this series.


SZEDER Gábor (5):
  compat/obstack: fix -Wcast-function-type warnings
  .gitignore: ignore external debug symbols from GCC on macOS
  travis-ci: don't be '--quiet' when running the tests
  travis-ci: switch to Xcode 10.1 macOS image
  travis-ci: build with the right compiler

 .gitignore                 |  1 +
 .travis.yml                |  2 ++
 ci/install-dependencies.sh |  5 +++++
 ci/lib-travisci.sh         | 15 ++++++++++++---
 ci/run-build-and-tests.sh  |  4 ++--
 ci/run-linux32-build.sh    |  2 +-
 compat/obstack.c           | 17 +++++++++--------
 compat/obstack.h           | 18 +++++++++++-------
 8 files changed, 43 insertions(+), 21 deletions(-)

-- 
2.20.1.151.gec613c4b75

