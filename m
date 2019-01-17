Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC8541F62E
	for <e@80x24.org>; Thu, 17 Jan 2019 01:29:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbfAQB3j (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Jan 2019 20:29:39 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44088 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727769AbfAQB3i (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jan 2019 20:29:38 -0500
Received: by mail-wr1-f65.google.com with SMTP id z5so9096564wrt.11
        for <git@vger.kernel.org>; Wed, 16 Jan 2019 17:29:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+g2oBEcUHs+0KUfZAgVLsOvTutfVQa6XgDuI1VOD/e4=;
        b=K2o9/pAGRoFB9xpqcTeCNNispF6o3YdYXWqRN6wV38NhP9Is9PHC79sQ7k78pgxTD0
         H/Ho3Uy1GM4QmtFMEcVKJZRejitE3/Y1vfgfrL8Mrg00/D5fjReXvY7iav+D6lszsnx/
         cHO7Yl+wXkPTri/fz2a1+eVkGuJrslr3CgKy64awuIpZD4zNfPKjIc+XFPdw/PzVhbgJ
         shUh/cjcWgKe14kBs1UOdNSbqZePyWdy8Z4niI6Tdc85Kt5PhewhEjvdZyAME6HwQzHx
         HOu3wxyN2DKlAzdzbpzW1i9d1mNwFoIEnC/bQNK6xNMOAlBImc4f3GuNdEFQuwOco97i
         8onQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+g2oBEcUHs+0KUfZAgVLsOvTutfVQa6XgDuI1VOD/e4=;
        b=JNdvZQQgt3cgWmmG4YG0KBdlUiVCeRABptob4KvjKHq4jX1Gw/dCVncgXd6OPCnli3
         Y9RxWy8hsCk/Tet51VutxsiNx8Y07Ig+owMM3Z/k4zYKF42BmzTMp05xPpLGvmnd7iM2
         Xd2plkI42LhL/s9YKCoJW/N1h8Rvh/ru9EAOxUOQ6kg5JiAmefqeX7QIwakzoc/jIlqg
         XaYm4tWlEzWPLKuFMk31+Gu/b2URcyIb8HBFUvGOM9dTlndJLO8vb3pyM8piPzJhy3l4
         47xusarOvd+hD8ULczqNCnLx8gyOckWf4+zQk6IoqpLHC99CFrKztu3htCweJT9e1BlN
         Sfew==
X-Gm-Message-State: AJcUukd4cAC9wfSfYB/17f/WKZxOPzQ0Yynmft/8Cbd4fkI6Uv+wMvRw
        qO20U0pRA5fBMYuRMPPI2tI=
X-Google-Smtp-Source: ALg8bN4P71r1aiQ2MCCgpdtztQvcIbY7Ih8u6JhytJsZiAtrt7jg9ZzyCiJKK89zH0thXmtQ/9Yw+A==
X-Received: by 2002:a5d:4250:: with SMTP id s16mr9833581wrr.253.1547688576053;
        Wed, 16 Jan 2019 17:29:36 -0800 (PST)
Received: from localhost.localdomain (x4db4a994.dyn.telefonica.de. [77.180.169.148])
        by smtp.gmail.com with ESMTPSA id y13sm36818272wme.2.2019.01.16.17.29.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 16 Jan 2019 17:29:35 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 3/5] travis-ci: don't be '--quiet' when running the tests
Date:   Thu, 17 Jan 2019 02:29:11 +0100
Message-Id: <20190117012913.30562-4-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.20.1.499.gf60de1223c
In-Reply-To: <20190117012913.30562-1-szeder.dev@gmail.com>
References: <20181220162452.17732-1-szeder.dev@gmail.com>
 <20190117012913.30562-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

All Travis CI build jobs run the test suite with 'make --quiet test'.

On one hand, being quiet doesn't save us from much clutter in the
output:

  $ make test |wc -l
  861
  $ make --quiet test |wc -l
  848

It only spares 13 lines, mostly the output of entering the 't/'
directory and the pre- and post-cleanup commands, which is negligible
compared to the ~700 lines printed while building Git and the ~850
lines of 'prove' output.

On the other hand, it's asking for trouble.  In our CI build scripts
we build Git and run the test suite in two separate 'make'
invocations.  In a prelimiary version of one of the later patches in
this series, to explicitly specify which compiler to use, I changed
them to basically run:

  make CC=$CC
  make --quiet test

naively thinking that it should Just Work...  but then that 'make
--quiet test' got all clever on me, noticed the changed build flags,
and then proceeded to rebuild everything with the default 'cc'.  And
because of that '--quiet' option, it did so, well, quietly, only
saying "* new build flags", and it was by mere luck that I happened to
notice that something is amiss.

Let's just drop that '--quiet' option when running the test suite in
all build scripts.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 ci/run-build-and-tests.sh | 4 ++--
 ci/run-linux32-build.sh   | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
index cda170d5c2..84431c097e 100755
--- a/ci/run-build-and-tests.sh
+++ b/ci/run-build-and-tests.sh
@@ -8,7 +8,7 @@
 ln -s "$cache_dir/.prove" t/.prove
 
 make --jobs=2
-make --quiet test
+make test
 if test "$jobname" = "linux-gcc"
 then
 	export GIT_TEST_SPLIT_INDEX=yes
@@ -17,7 +17,7 @@ then
 	export GIT_TEST_OE_DELTA_SIZE=5
 	export GIT_TEST_COMMIT_GRAPH=1
 	export GIT_TEST_MULTI_PACK_INDEX=1
-	make --quiet test
+	make test
 fi
 
 check_unignored_build_artifacts
diff --git a/ci/run-linux32-build.sh b/ci/run-linux32-build.sh
index 2c60d2e70a..26c168a016 100755
--- a/ci/run-linux32-build.sh
+++ b/ci/run-linux32-build.sh
@@ -56,5 +56,5 @@ linux32 --32bit i386 su -m -l $CI_USER -c '
 	cd /usr/src/git
 	test -n "$cache_dir" && ln -s "$cache_dir/.prove" t/.prove
 	make --jobs=2
-	make --quiet test
+	make test
 '
-- 
2.20.1.499.gf60de1223c

