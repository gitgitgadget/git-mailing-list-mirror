Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ECBAC1F87F
	for <e@80x24.org>; Tue, 13 Nov 2018 18:56:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730782AbeKNEzi (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Nov 2018 23:55:38 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43354 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730730AbeKNEzi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Nov 2018 23:55:38 -0500
Received: by mail-wr1-f66.google.com with SMTP id y3-v6so14505190wrh.10
        for <git@vger.kernel.org>; Tue, 13 Nov 2018 10:56:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O900/9S0+Zrc3mC8BVjTc2xhTYthoDDcnXjTO41Nkpk=;
        b=coWm3IT+8mZm4AgSjOW8wYsmjUiS/5MQz2Gzi6EvI5v2g7vG8E/zxF0ZS2q1/DNFAq
         ROKVUenKPi+pbwbrTXYaM2rRtXSznmWV74W4hGAVxuUaS32ayHy/jRYaVipfxG6RI/ak
         UVEVFqzahM/N3Qxx4I+cpnNG8phAQGI9xjwq5OsEj7slcWi/QEsWrDmo/09P2rzpS/AD
         j+7Sb8MHH99/2coqAPHLdLNwgPd1K8UoENv1gPaQuh6NY3wjQPKR+3J0B70HkSB95knr
         8raZ3s1OHi2y6UABA0t3aVcXEs/qv2/S8dZeyl/RDJAssumAcLXJbtIe6xK2DMhXS9v7
         n54A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O900/9S0+Zrc3mC8BVjTc2xhTYthoDDcnXjTO41Nkpk=;
        b=Wo5QpWb+WsZyOoOBqIRieB37nhB0sKR/d8nLquBFk257gfLA2lUGjWXYtkj1VpCTAm
         lK9rBlP+p9fDvyEoN2BUXPoMQjsuVaC5MMiqR6zzEj2Nq7JpPHQE7mXLsf0OlfobCsBl
         mWNotoDycBk0oLv5S1VDApYrTP/B24+vN+k2c6DyS2UTOYWnppc6t3jkESwYey5qL3CT
         iBk/pAO62ydtYlxqLH3Ii8wGE95UNdB2nNZPCcUSt9oLxWqQTWCSMRNcu4rqQ923XT6E
         hhWGxNW+CYkEshpjA/4KjorPIiiWyDyQ7hQPFVuTNPsRnwF01ldyliAQ08qIbV+KR92u
         CYvw==
X-Gm-Message-State: AGRZ1gIxUx7/T/jRJF7BFwwAaZYr9HbjrFVS1IjgfDGR+r6oa3AC90pE
        tYn9JRQg+q1in7CNJni91xwFjzMbDos=
X-Google-Smtp-Source: AJdET5dJPm8IQI6r6XSbqpFDp+jJ/0zq+zZOCEwFi0o5jaahF7beedMivN32trB/qBmMQXPRd4TsSQ==
X-Received: by 2002:adf:fa04:: with SMTP id m4-v6mr6269040wrr.155.1542135371937;
        Tue, 13 Nov 2018 10:56:11 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id y81-v6sm9908268wmd.11.2018.11.13.10.56.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 10:56:11 -0800 (PST)
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
Subject: [PATCH v5 2/3] range-diff: fix regression in passing along diff options
Date:   Tue, 13 Nov 2018 18:55:57 +0000
Message-Id: <20181113185558.23438-3-avarab@gmail.com>
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
index 3958720f00..ec937008d0 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -461,7 +461,7 @@ int show_range_diff(const char *range1, const char *range2,
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

