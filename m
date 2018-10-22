Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5CFEA1F454
	for <e@80x24.org>; Mon, 22 Oct 2018 20:23:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728418AbeJWEnk (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Oct 2018 00:43:40 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:40633 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbeJWEnj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Oct 2018 00:43:39 -0400
Received: by mail-ed1-f68.google.com with SMTP id r1-v6so39231604edd.7
        for <git@vger.kernel.org>; Mon, 22 Oct 2018 13:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r1gn7DQ/FT3+RFxwntpp1sYdJnLbw5//PTT/vn2/2CQ=;
        b=tbgozHQYNTo/O3FZwH8z4zCUj1WSdGoMnLRmdD83BgiZ0fMP4KkLFYY2qAWkq0EMFJ
         ZyF34ToVzX1Uclus47FBZr34E4FGCI4nghdnjjozNhdwi79RAuNVrzDIILktj/vMhaJJ
         1MCUJjZjsGh430xaYuYnxFK5+76lQ3d6EYzVwTNzSC+3i80HezPtWvlVBIH7QjVBkhpK
         rrRV18zQykuGHTvqZMLdtQDwXQdBJm9Yy1CltR1ZbjTbE6aPOXxbb5B0LPc0/ZHtPo25
         nHJ/Pjf1fyTwJy+mLzhhuRuUUysN8iGCRB+g2giVd3ZRbiRL59oCiHqQ+cjmCSkNmSWQ
         j7BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r1gn7DQ/FT3+RFxwntpp1sYdJnLbw5//PTT/vn2/2CQ=;
        b=auRfNHdRw12wtOVUMlwbLrAqJR38+buY++2PgO87dvVYnUTy4tSQ0koccs0ZBFM6NU
         PejITOB+y5+0KPYkFhASL0dKWqsHZ2xoXeDYFWHYnWlINK+sbSBMbxiAbqArygHBzJBc
         WY/FIBBQjFycxZ9Q5TJGX+tD4XKg9aA9UKZbs8Vd9wQ3bsQwXN6Zv3bvFOjql2ZhMlDV
         sw9NLGfPUCSVx6RJWdj31bh5vH9ydLs5lP7/UlPK+cU2w20iIGQ5/faEez2accRyjV5u
         H+6Vv+HB67rUffbYlctsHSaMjnVRMluQcjMad5fFoZyRO5vZgvTQwuPsNohIpQGVru10
         R/iw==
X-Gm-Message-State: ABuFfohxhCSbS1tiWTXDncYD2bxltqHJCfpjoLKdjfEAaBqihye9SX56
        9+Zi8nBtDlRwkIVh5FMPzOgLIPym
X-Google-Smtp-Source: ACcGV60zDJX/8zrSPBqabZTvSAI6pQ8lj2A8V8ASYm3h2ozzXeny0ZNPL4hwb3fnO+B2TY4VaI9nZg==
X-Received: by 2002:a50:f9c7:: with SMTP id a7-v6mr13598249edq.138.1540239818398;
        Mon, 22 Oct 2018 13:23:38 -0700 (PDT)
Received: from localhost.localdomain (x4db968d4.dyn.telefonica.de. [77.185.104.212])
        by smtp.gmail.com with ESMTPSA id h21-v6sm16882228eda.23.2018.10.22.13.23.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 22 Oct 2018 13:23:37 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0?= <avarab@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 8/8] travis-ci: run GETTEXT POISON build job in scrambled mode, too
Date:   Mon, 22 Oct 2018 22:22:41 +0200
Message-Id: <20181022202241.18629-9-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.19.1.681.g6bd79da3f5
In-Reply-To: <20181022202241.18629-1-szeder.dev@gmail.com>
References: <20181022153633.31757-1-pclouds@gmail.com>
 <20181022202241.18629-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Run the test suite twice in the GETTEXT POISON build: first with
GIT_GETTEXT_POISON=scrambled and then with "regular" poisoning, to see
whether the scrambled mode hid any mis-translations.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 ci/lib-travisci.sh        |  1 +
 ci/run-build-and-tests.sh | 10 +++++++---
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/ci/lib-travisci.sh b/ci/lib-travisci.sh
index 109ef280da..fdfa4e035b 100755
--- a/ci/lib-travisci.sh
+++ b/ci/lib-travisci.sh
@@ -122,5 +122,6 @@ osx-clang|osx-gcc)
 	;;
 GETTEXT_POISON)
 	export GETTEXT_POISON=YesPlease
+	export GIT_GETTEXT_POISON=scrambled
 	;;
 esac
diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
index 3735ce413f..74ba05e152 100755
--- a/ci/run-build-and-tests.sh
+++ b/ci/run-build-and-tests.sh
@@ -9,10 +9,14 @@ ln -s "$cache_dir/.prove" t/.prove
 
 make --jobs=2
 make --quiet test
-if test "$jobname" = "linux-gcc"
-then
+case "$jobname" in
+linux-gcc)
 	GIT_TEST_SPLIT_INDEX=YesPlease make --quiet test
-fi
+	;;
+GETTEXT_POISON)
+	GIT_GETTEXT_POISON=YesPlease make --quiet test
+	;;
+esac
 
 check_unignored_build_artifacts
 
-- 
2.19.1.681.g6bd79da3f5

