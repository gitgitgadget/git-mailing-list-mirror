Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CBA421F87F
	for <e@80x24.org>; Tue, 13 Nov 2018 18:56:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730848AbeKNEzl (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Nov 2018 23:55:41 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38223 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730730AbeKNEzk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Nov 2018 23:55:40 -0500
Received: by mail-wm1-f65.google.com with SMTP id f2-v6so12435084wme.3
        for <git@vger.kernel.org>; Tue, 13 Nov 2018 10:56:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IqWk7WSGS2xsaSuUsc3hwt34fNRZrZC9512AG9QgIrY=;
        b=bi0Wamg8xzw3gi2Mug4rupXfJDEsKovrLkuSS7LFCsaPkB+lspdwBsGB4P5qOdBtPM
         5neHpM0NbuCN6I5uOyyaMDcp1ZAO/isPxTOo5AYegQYvhCg68oEiQKelQolfCo3R1cRo
         KNIAdHaMKDcTc4zC9cNUAMJN2Y4TJCZCJboODZs8zXn30pqHIJgD1WNQsJawBejHuMyR
         5vfZrlrPMyzDZy9bhbqNhW3D/8iPKtbesLw1zq0AxTo8REnMx3Hc0TlEdXo8egn0zSJP
         ud4HUhdtMZ6WD+JaTTV+ckz0dFNNQxXJOJdVFIhVmYTcmT7uoBoW3kUiW1jfq796OMli
         eXqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IqWk7WSGS2xsaSuUsc3hwt34fNRZrZC9512AG9QgIrY=;
        b=d1//imrNCLPiR2RR5aXF5mqQwA7+5t1I2sudEhVh8jETjpNF5SuQmk72GjI8YItbco
         yvrHr1+JZDbj2KKoa5ZtRTNaqiPapGvUcpHzqhHYufQ0IZToRq+28aWEZMH3752A4o7b
         OcFzj2msGbebGEH0H0zgP+m5Xh0If7XPQA0FCrkD3PRoyUSS/69yCTiBYt09sEQ1BWDo
         5lj5KkCNqguAUI2oV9tINxXokLvGwcrr/uyjrezFL1MhJiJvYwbqiSFsEfyiacLJtwnT
         mU3AKKzvH6ejnaK3rXNFXWN6vGO4TrYMCAUcUeUJPKXyDS4v0JlzThB6Ra9bmb11ftfR
         8NCQ==
X-Gm-Message-State: AGRZ1gIYMa9x7AwA0iKCBDwSb88b9vfdVvzdrr9Kv7tSUwAvrWYPiRfJ
        RvTJpHT7FJBiquWWdUZOQyBdjHDCbJc=
X-Google-Smtp-Source: AJdET5cdGsJWI07FXADO4tO7PMDcYglbJPtvkv4cr7tGy4OVRDEeJumkjnmzYnWfk8HoiDvs0Z9MVg==
X-Received: by 2002:a1c:2104:: with SMTP id h4-v6mr4116667wmh.130.1542135373609;
        Tue, 13 Nov 2018 10:56:13 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id y81-v6sm9908268wmd.11.2018.11.13.10.56.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 10:56:12 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Stephen & Linda Smith <ischis2@cox.net>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 3/3] range-diff: make diff option behavior (e.g. --stat) consistent
Date:   Tue, 13 Nov 2018 18:55:58 +0000
Message-Id: <20181113185558.23438-4-avarab@gmail.com>
X-Mailer: git-send-email 2.19.1.1182.g4ecb1133ce
In-Reply-To: <xmqqftw73r9a.fsf@gitster-ct.c.googlers.com>
References: <xmqqftw73r9a.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Make the behavior when diff options (e.g. "--stat") are passed
consistent with how "diff" behaves.

Before 73a834e9e2 ("range-diff: relieve callers of low-level
configuration burden", 2018-07-22) running range-diff with "--stat"
would produce stat output and the diff output, as opposed to how
"diff" behaves where once "--stat" is specified "--patch" also needs
to be provided to emit the patch output.

As noted in a previous change ("range-diff doc: add a section about
output stability", 2018-11-07) the "--stat" output with "range-diff"
is useless at the moment.

But we should behave consistently with "diff" in anticipation of such
output being useful in the future, because it would make for confusing
UI if "diff" and "range-diff" behaved differently when it came to how
they interpret diff options.

The new behavior is also consistent with the existing documentation
added in ba931edd28 ("range-diff: populate the man page",
2018-08-13). See "[...]also accepts the regular diff options[...]" in
git-range-diff(1).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 range-diff.c          |  3 ++-
 t/t3206-range-diff.sh | 23 -----------------------
 2 files changed, 2 insertions(+), 24 deletions(-)

diff --git a/range-diff.c b/range-diff.c
index ec937008d0..767af8c5bb 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -461,7 +461,8 @@ int show_range_diff(const char *range1, const char *range2,
 		struct strbuf indent = STRBUF_INIT;
 
 		memcpy(&opts, diffopt, sizeof(opts));
-		opts.output_format |= DIFF_FORMAT_PATCH;
+		if (!opts.output_format)
+			opts.output_format = DIFF_FORMAT_PATCH;
 		opts.flags.suppress_diff_headers = 1;
 		opts.flags.dual_color_diffed_diffs = dual_color;
 		opts.output_prefix = output_prefix_cb;
diff --git a/t/t3206-range-diff.sh b/t/t3206-range-diff.sh
index ab44e085d5..e497c1358f 100755
--- a/t/t3206-range-diff.sh
+++ b/t/t3206-range-diff.sh
@@ -134,43 +134,20 @@ test_expect_success 'changed commit with --no-patch diff option' '
 '
 
 test_expect_success 'changed commit with --stat diff option' '
-	four_spaces="    " &&
 	git range-diff --no-color --stat topic...changed >actual &&
 	cat >expected <<-EOF &&
 	1:  4de457d = 1:  a4b3333 s/5/A/
 	     a => b | 0
 	     1 file changed, 0 insertions(+), 0 deletions(-)
-	$four_spaces
 	2:  fccce22 = 2:  f51d370 s/4/A/
 	     a => b | 0
 	     1 file changed, 0 insertions(+), 0 deletions(-)
-	$four_spaces
 	3:  147e64e ! 3:  0559556 s/11/B/
 	     a => b | 0
 	     1 file changed, 0 insertions(+), 0 deletions(-)
-	$four_spaces
-	    @@ -10,7 +10,7 @@
-	      9
-	      10
-	     -11
-	    -+B
-	    ++BB
-	      12
-	      13
-	      14
 	4:  a63e992 ! 4:  d966c5c s/12/B/
 	     a => b | 0
 	     1 file changed, 0 insertions(+), 0 deletions(-)
-	$four_spaces
-	    @@ -8,7 +8,7 @@
-	     @@
-	      9
-	      10
-	    - B
-	    + BB
-	     -12
-	     +B
-	      13
 	EOF
 	test_cmp expected actual
 '
-- 
2.19.1.1182.g4ecb1133ce

