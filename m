Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3DDF51F453
	for <e@80x24.org>; Fri,  9 Nov 2018 10:18:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727752AbeKIT6Q (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Nov 2018 14:58:16 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46393 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727537AbeKIT6Q (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Nov 2018 14:58:16 -0500
Received: by mail-wr1-f66.google.com with SMTP id 74-v6so1267402wrb.13
        for <git@vger.kernel.org>; Fri, 09 Nov 2018 02:18:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FfVr+AlR+GLQAFqd/HyREFZ07DF/QlSd1crf+snlTo0=;
        b=V3kZjZuS9VCwtMV5Hvjk1z/NOPAm4Eyk5vSnHxLdllq43pzVobgVZrOfBxZ22xaRq7
         darI/fUegN7A4xfRUKD/xhXhvg2qGYnokYSfFf14KUQI8JmVuFC7yVsdccK01k6qWPGg
         zjCj8W5niykCBc5vTPdQ9BAS3Xp0L0yoHn540/csH9Tu4NERsplHb9XHPcaUwRSMxlj4
         ksDSs2aWR4KSwGDIlRPa/xLRszJmlpZKyQGzNaK6aQ1VaJFp+ymFrvpHzUiV+7RiZF4E
         B6oZmPbhBcjsk6yMQJg00it/V8H/rCPoe8JkjkagrIEwEZANUJKbxMemCGNM3ajgL/gw
         eDYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FfVr+AlR+GLQAFqd/HyREFZ07DF/QlSd1crf+snlTo0=;
        b=KiK1A7GxvyMyI8XLRhhvakjLoaHH+bMahs7/H/InpfEhsNj8MCiJEVtkALqJycWNeW
         DgjCsZPlcsG6vrhDaSTa5MRs4zMOCHE49xbKqR5wE5CfyZXwq0mcZRMGEkxOhPmnx99j
         5tEDl1d+vyoD2AWngfK6RCBp+jfV0gvlLerrHf3+gN3OAvGSbz3yoQu3zBjFf0dSGwtO
         eLRjhW7SJ/Ph1kY+q5n0h2yVyL6a/DOVKkKl3sql2UTJ6JKJvsoBqhtfU6Tl0kUwYIbd
         hEsOURfNubKNzNmE9CwzxJMnrI/I8GvHgRVn7v21o5qOzp/XfBGbdASj56jXFz9vDdNE
         Tqew==
X-Gm-Message-State: AGRZ1gJVACnX2h72D0gyInUOh+HzLV6ulo4H2wwaQ0ns19S7orsBeiGc
        wJFbqtV4fGqShWCRXQiH/Ft6ty2Cyn8=
X-Google-Smtp-Source: AJdET5eH/g+aseNVRxgFAXXuIR1JAw3oZ5iu2g0L+20Tq52xsn/j487Dfj35FtdmFZ5JKFazfmhyKg==
X-Received: by 2002:adf:b612:: with SMTP id f18-v6mr6946193wre.120.1541758698716;
        Fri, 09 Nov 2018 02:18:18 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id h4-v6sm5662020wrt.76.2018.11.09.02.18.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Nov 2018 02:18:18 -0800 (PST)
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
Subject: [PATCH v4 2/3] range-diff: fix regression in passing along diff options
Date:   Fri,  9 Nov 2018 10:18:02 +0000
Message-Id: <20181109101803.3038-3-avarab@gmail.com>
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

In 73a834e9e2 ("range-diff: relieve callers of low-level configuration
burden", 2018-07-22) we broke passing down options like --no-patch,
--stat etc.

Fix that regression, and add a test asserting the pre-73a834e9e2
behavior for some of these diff options.

As noted in a change leading up to this ("range-diff doc: add a
section about output stability", 2018-11-07) the output is not meant
to be stable. So this regression test will likely need to be tweaked
once we get a "proper" --stat option.

See
https://public-inbox.org/git/nycvar.QRO.7.76.6.1811071202480.39@tvgsbejvaqbjf.bet/
for a further explanation of the regression. The fix here is not the
same as in Johannes's on-list patch, for reasons that'll be explained
in a follow-up commit.

The quoting of "EOF" here mirrors that of an earlier test. Perhaps
that should be fixed, but let's leave that up to a later cleanup
change.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 range-diff.c          |  2 +-
 t/t3206-range-diff.sh | 53 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+), 1 deletion(-)

diff --git a/range-diff.c b/range-diff.c
index bd8083f2d1..ea317f92f9 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -453,7 +453,7 @@ int show_range_diff(const char *range1, const char *range2,
 		struct strbuf indent = STRBUF_INIT;
 
 		memcpy(&opts, diffopt, sizeof(opts));
-		opts.output_format = DIFF_FORMAT_PATCH;
+		opts.output_format |= DIFF_FORMAT_PATCH;
 		opts.flags.suppress_diff_headers = 1;
 		opts.flags.dual_color_diffed_diffs = dual_color;
 		opts.output_prefix = output_prefix_cb;
diff --git a/t/t3206-range-diff.sh b/t/t3206-range-diff.sh
index 6aae364171..ab44e085d5 100755
--- a/t/t3206-range-diff.sh
+++ b/t/t3206-range-diff.sh
@@ -122,6 +122,59 @@ test_expect_success 'changed commit' '
 	test_cmp expected actual
 '
 
+test_expect_success 'changed commit with --no-patch diff option' '
+	git range-diff --no-color --no-patch topic...changed >actual &&
+	cat >expected <<-EOF &&
+	1:  4de457d = 1:  a4b3333 s/5/A/
+	2:  fccce22 = 2:  f51d370 s/4/A/
+	3:  147e64e ! 3:  0559556 s/11/B/
+	4:  a63e992 ! 4:  d966c5c s/12/B/
+	EOF
+	test_cmp expected actual
+'
+
+test_expect_success 'changed commit with --stat diff option' '
+	four_spaces="    " &&
+	git range-diff --no-color --stat topic...changed >actual &&
+	cat >expected <<-EOF &&
+	1:  4de457d = 1:  a4b3333 s/5/A/
+	     a => b | 0
+	     1 file changed, 0 insertions(+), 0 deletions(-)
+	$four_spaces
+	2:  fccce22 = 2:  f51d370 s/4/A/
+	     a => b | 0
+	     1 file changed, 0 insertions(+), 0 deletions(-)
+	$four_spaces
+	3:  147e64e ! 3:  0559556 s/11/B/
+	     a => b | 0
+	     1 file changed, 0 insertions(+), 0 deletions(-)
+	$four_spaces
+	    @@ -10,7 +10,7 @@
+	      9
+	      10
+	     -11
+	    -+B
+	    ++BB
+	      12
+	      13
+	      14
+	4:  a63e992 ! 4:  d966c5c s/12/B/
+	     a => b | 0
+	     1 file changed, 0 insertions(+), 0 deletions(-)
+	$four_spaces
+	    @@ -8,7 +8,7 @@
+	     @@
+	      9
+	      10
+	    - B
+	    + BB
+	     -12
+	     +B
+	      13
+	EOF
+	test_cmp expected actual
+'
+
 test_expect_success 'changed commit with sm config' '
 	git range-diff --no-color --submodule=log topic...changed >actual &&
 	cat >expected <<-EOF &&
-- 
2.19.1.1182.g4ecb1133ce

