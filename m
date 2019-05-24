Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E2FD61F462
	for <e@80x24.org>; Fri, 24 May 2019 09:25:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390114AbfEXJZC (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 May 2019 05:25:02 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37448 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389777AbfEXJZB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 May 2019 05:25:01 -0400
Received: by mail-pf1-f195.google.com with SMTP id a23so4990636pff.4
        for <git@vger.kernel.org>; Fri, 24 May 2019 02:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZkU0Sy3kGo2Tpxjx47UMjQZq7d/ezG/8c+Qx3KTnaGM=;
        b=a8C8fY1yhBsEIW2pYCqHNdn8GcIukZzcqB0ucnl/7l/0oXhvLdg1yRdWulKWxz7FvH
         0o8zMDgBlCHHTI5Zz3i2HZQewA7RML2aw+aqM9WDWDYf6w2n0RiaZfEbaDm8oN3KDer+
         nzoGma1cJekO8mWivYZlWS1WKicFFOV7n5nstjvDPm9875h767bXwFuvifgiWpPRj706
         I/tqrGJXn1tEx6hI2LthJYXwO0A6l1EAdKCZk9cqWZ2tGJl5iABDbiJeqDqiY2zLdnnO
         A7eZbPLOW18rvFWhmVlm576o2GQWJ742XZRh1bJOBLUiWBrjwNceKZh4cZgg83jZ5Cur
         eqig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZkU0Sy3kGo2Tpxjx47UMjQZq7d/ezG/8c+Qx3KTnaGM=;
        b=FBpg2M2wrgGCP1UEFGls+Zi0a99x0s/s9EZROqSu1Lk+u55ZI8TGp41T7oETLSx/PO
         XCReWt2V7g4kqmKWVTc/i+uf5wla1vQvWTF/OWEix6aNV+bxa22yNnndO1exMam00u2y
         YcXJwn1xxy6io2wiHkwIwJearLHM7mbVQ7RDW41Ie8hRZAjlfEWMbrb68fIjS4IIQrlD
         hwXV3IB4lxiS9e2VclxgfEHxONB1rU+dDX162xyLE7Q7C48DaNfiMKQZa3WB/g3fQUdy
         RnaXoik9EgauUqn0lUNo6ew7pI57koeGgLtGSmOkmD+ATXXTAjs3cY1YPbTQj9VMbHa8
         LacA==
X-Gm-Message-State: APjAAAVIRo5/6Zbo6dZnrtSo3sEeGCT3nDj3AzqoGhlYgB44RmMNPaDX
        HOHuDMZ70Ofse3Jz34lbJ32bIJVH
X-Google-Smtp-Source: APXvYqwRVBc1+ZQuPCJcpH6OXS2cv5vnjxChpMmjww088eursLi4ohB1w43cuWZuEsH2raGoNEOzJA==
X-Received: by 2002:a17:90a:32c1:: with SMTP id l59mr7650060pjb.1.1558689900303;
        Fri, 24 May 2019 02:25:00 -0700 (PDT)
Received: from ash ([115.72.28.243])
        by smtp.gmail.com with ESMTPSA id x18sm3823972pfj.17.2019.05.24.02.24.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 02:24:59 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Fri, 24 May 2019 16:24:55 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, bturner@atlassian.com, tmz@pobox.com,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 2/3] diff-parseopt: restore -U (no argument) behavior
Date:   Fri, 24 May 2019 16:24:41 +0700
Message-Id: <20190524092442.701-3-pclouds@gmail.com>
X-Mailer: git-send-email 2.22.0.rc0.322.g2b0371e29a
In-Reply-To: <20190524092442.701-1-pclouds@gmail.com>
References: <20190524092442.701-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Before d473e2e0e8 (diff.c: convert -U|--unified, 2019-01-27), -U and
--unified are implemented with a custom parser opt_arg() in diff.c. I
didn't check this code carefully and not realize that it's the
equivalent of PARSE_OPT_NONEG | PARSE_OPT_OPTARG.

In other words, if -U is specified without any argument, the option
should be accepted, and the default value should be used. Without
PARSE_OPT_OPTARG, parse_options() will reject this case and cause a
regression.

Reported-by: Bryan Turner <bturner@atlassian.com>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 diff.c                                    | 10 ++++---
 t/t4013-diff-various.sh                   |  2 ++
 t/t4013/diff.diff_-U1_initial..side (new) | 29 ++++++++++++++++++++
 t/t4013/diff.diff_-U2_initial..side (new) | 31 ++++++++++++++++++++++
 t/t4013/diff.diff_-U_initial..side (new)  | 32 +++++++++++++++++++++++
 5 files changed, 100 insertions(+), 4 deletions(-)

diff --git a/diff.c b/diff.c
index 4d3cf83a27..80ddc11671 100644
--- a/diff.c
+++ b/diff.c
@@ -5211,9 +5211,11 @@ static int diff_opt_unified(const struct option *opt,
 
 	BUG_ON_OPT_NEG(unset);
 
-	options->context = strtol(arg, &s, 10);
-	if (*s)
-		return error(_("%s expects a numerical value"), "--unified");
+	if (arg) {
+		options->context = strtol(arg, &s, 10);
+		if (*s)
+			return error(_("%s expects a numerical value"), "--unified");
+	}
 	enable_patch_output(&options->output_format);
 
 	return 0;
@@ -5272,7 +5274,7 @@ static void prep_parse_options(struct diff_options *options)
 			  DIFF_FORMAT_PATCH, DIFF_FORMAT_NO_OUTPUT),
 		OPT_CALLBACK_F('U', "unified", options, N_("<n>"),
 			       N_("generate diffs with <n> lines context"),
-			       PARSE_OPT_NONEG, diff_opt_unified),
+			       PARSE_OPT_NONEG | PARSE_OPT_OPTARG, diff_opt_unified),
 		OPT_BOOL('W', "function-context", &options->flags.funccontext,
 			 N_("generate diffs with <n> lines context")),
 		OPT_BIT_F(0, "raw", &options->output_format,
diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index 9f8f0e84ad..a9054d2db1 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -338,6 +338,8 @@ format-patch --inline --stdout initial..master^^
 format-patch --stdout --cover-letter -n initial..master^
 
 diff --abbrev initial..side
+diff -U initial..side
+diff -U1 initial..side
 diff -r initial..side
 diff --stat initial..side
 diff -r --stat initial..side
diff --git a/t/t4013/diff.diff_-U1_initial..side b/t/t4013/diff.diff_-U1_initial..side
new file mode 100644
index 0000000000..b69f8f048a
--- /dev/null
+++ b/t/t4013/diff.diff_-U1_initial..side
@@ -0,0 +1,29 @@
+$ git diff -U1 initial..side
+diff --git a/dir/sub b/dir/sub
+index 35d242b..7289e35 100644
+--- a/dir/sub
++++ b/dir/sub
+@@ -2 +2,3 @@ A
+ B
++1
++2
+diff --git a/file0 b/file0
+index 01e79c3..f4615da 100644
+--- a/file0
++++ b/file0
+@@ -3 +3,4 @@
+ 3
++A
++B
++C
+diff --git a/file3 b/file3
+new file mode 100644
+index 0000000..7289e35
+--- /dev/null
++++ b/file3
+@@ -0,0 +1,4 @@
++A
++B
++1
++2
+$
diff --git a/t/t4013/diff.diff_-U2_initial..side b/t/t4013/diff.diff_-U2_initial..side
new file mode 100644
index 0000000000..8ffe04f203
--- /dev/null
+++ b/t/t4013/diff.diff_-U2_initial..side
@@ -0,0 +1,31 @@
+$ git diff -U2 initial..side
+diff --git a/dir/sub b/dir/sub
+index 35d242b..7289e35 100644
+--- a/dir/sub
++++ b/dir/sub
+@@ -1,2 +1,4 @@
+ A
+ B
++1
++2
+diff --git a/file0 b/file0
+index 01e79c3..f4615da 100644
+--- a/file0
++++ b/file0
+@@ -2,2 +2,5 @@
+ 2
+ 3
++A
++B
++C
+diff --git a/file3 b/file3
+new file mode 100644
+index 0000000..7289e35
+--- /dev/null
++++ b/file3
+@@ -0,0 +1,4 @@
++A
++B
++1
++2
+$
diff --git a/t/t4013/diff.diff_-U_initial..side b/t/t4013/diff.diff_-U_initial..side
new file mode 100644
index 0000000000..c66c0dd5c6
--- /dev/null
+++ b/t/t4013/diff.diff_-U_initial..side
@@ -0,0 +1,32 @@
+$ git diff -U initial..side
+diff --git a/dir/sub b/dir/sub
+index 35d242b..7289e35 100644
+--- a/dir/sub
++++ b/dir/sub
+@@ -1,2 +1,4 @@
+ A
+ B
++1
++2
+diff --git a/file0 b/file0
+index 01e79c3..f4615da 100644
+--- a/file0
++++ b/file0
+@@ -1,3 +1,6 @@
+ 1
+ 2
+ 3
++A
++B
++C
+diff --git a/file3 b/file3
+new file mode 100644
+index 0000000..7289e35
+--- /dev/null
++++ b/file3
+@@ -0,0 +1,4 @@
++A
++B
++1
++2
+$
-- 
2.22.0.rc0.322.g2b0371e29a

