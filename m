Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C85941F453
	for <e@80x24.org>; Fri,  9 Nov 2018 10:18:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbeKIT6R (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Nov 2018 14:58:17 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42892 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727537AbeKIT6R (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Nov 2018 14:58:17 -0500
Received: by mail-wr1-f68.google.com with SMTP id y15-v6so1278687wru.9
        for <git@vger.kernel.org>; Fri, 09 Nov 2018 02:18:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mMdrYOHSkzOerqOqrJjJZiWtLionYi5tvdp5oyWnnI4=;
        b=idIDR6jAyz8dzCSwivBqH1BPlxuUiT904w1Wt1Y8Aa1KruXbecG9qkFMxWC+PHoveO
         K6Q8vhC+25OCmqERjabRbRX8oNLj1Tcr+wzdz+nRtECy+50inh6FEHsnh1ydwN9L7PAK
         BGzjisVqusZvmnpvqs1lfovKVrD2wmyLHEpx3N2VU9aL4RRw1kIjUZ1xX/kB2NLmviiO
         uJAhwh77qioGGtaOzhS12zNSjDlVtt+KHElAQNUH9A8d475/D6W1Uh3+RhYHj92p9Qvq
         QTqbMN1HymCGcZWe5tjb4m7fiLEBjH5+CgjNiFKgf+dpycIVwgHNEiD6E8aKDcj0NemW
         CElQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mMdrYOHSkzOerqOqrJjJZiWtLionYi5tvdp5oyWnnI4=;
        b=H6eWZQ9rYAO8U/UuT8n3c7n8lLbp8mJaoGkZNHZ1Jl5RZA2ACN2BDYfR7r2f3P2J18
         1lhJeS87GMNvgtLRF0lMJQMnK4AOClNAYlf6ugEsWWi9FMJ1LlVNBAxTwCQrcv8E7/Hr
         XTFOtzubK5KDMCnO20WNTSLDqln70DwVH1LLazIuypwzMWx144xNri1DN+/zUB9d8n9d
         Q7JHwvdxlWKd/q5NRFwvWMzvJjiihX0lGHEu0vujVBjn0yU2mfiO+cD754b7JrLMI9vk
         +Or9j91QU7m6lOBN2jYS7SZUKqqfw1lZ3n2ecqDIr9IjL5MfqN/zfO1fvppoRI10hAmU
         qSxg==
X-Gm-Message-State: AGRZ1gKM5Z15PPkaDsrj2ScKjoZZ3E1bNyiXCVd1UlvqEl4fmQAEaRqL
        Yth5LWi/P9feLo4/tZbAj7sm6/3bRD0=
X-Google-Smtp-Source: AJdET5cKaJ5WX9mG89RbJo+ZL81l3YwxFEgdgTS4jN2GEaK+eaReLZP8fFvPxGo4HHfKB+sba9F7Kg==
X-Received: by 2002:adf:8b0a:: with SMTP id n10-v6mr6978983wra.282.1541758700223;
        Fri, 09 Nov 2018 02:18:20 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id h4-v6sm5662020wrt.76.2018.11.09.02.18.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Nov 2018 02:18:19 -0800 (PST)
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
Subject: [PATCH v4 3/3] range-diff: make diff option behavior (e.g. --stat) consistent
Date:   Fri,  9 Nov 2018 10:18:03 +0000
Message-Id: <20181109101803.3038-4-avarab@gmail.com>
X-Mailer: git-send-email 2.19.1.1182.g4ecb1133ce
In-Reply-To: <20181107122202.1813-3-avarab@gmail.com>
References: <20181107122202.1813-3-avarab@gmail.com>
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
UI if two "diff" and "range-diff" behaved differently when it came to
how they interpret diff options.

The new behavior is also consistent with the existing documentation
added in ba931edd28 ("range-diff: populate the man page",
2018-08-13). See "[...]also accepts the regular diff options[...]" in
git-range-diff(1).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 range-diff.c          |  3 ++-
 t/t3206-range-diff.sh | 22 ----------------------
 2 files changed, 2 insertions(+), 23 deletions(-)

diff --git a/range-diff.c b/range-diff.c
index ea317f92f9..72bde281f3 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -453,7 +453,8 @@ int show_range_diff(const char *range1, const char *range2,
 		struct strbuf indent = STRBUF_INIT;
 
 		memcpy(&opts, diffopt, sizeof(opts));
-		opts.output_format |= DIFF_FORMAT_PATCH;
+		if (!opts.output_format)
+			opts.output_format |= DIFF_FORMAT_PATCH;
 		opts.flags.suppress_diff_headers = 1;
 		opts.flags.dual_color_diffed_diffs = dual_color;
 		opts.output_prefix = output_prefix_cb;
diff --git a/t/t3206-range-diff.sh b/t/t3206-range-diff.sh
index ab44e085d5..9352f65280 100755
--- a/t/t3206-range-diff.sh
+++ b/t/t3206-range-diff.sh
@@ -140,37 +140,15 @@ test_expect_success 'changed commit with --stat diff option' '
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

