Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7424B1F404
	for <e@80x24.org>; Mon,  3 Sep 2018 14:49:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbeICTKR (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Sep 2018 15:10:17 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40196 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726160AbeICTKQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Sep 2018 15:10:16 -0400
Received: by mail-wr1-f66.google.com with SMTP id n2-v6so938985wrw.7
        for <git@vger.kernel.org>; Mon, 03 Sep 2018 07:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W4rZNN6MexNf+4Y+yvOzItKC8QYrmCuKgxjS5Cfv4KU=;
        b=QIJKyUMEmJVFMpZosFEvzWdXAETqUfgKBnlq4YYDgEb/4K9DABx92sFI9GxYw6Chxw
         DA3kSX1iY85EkACGqYZVqaRisppuG74nAA+WoCgReizigt3NgDQZBJ4BE0ZFwK7pkdB6
         q4567OGkgC00nWLfXy14dVGur+Lk4tTd/nwYVqo3D7gcCiR1CS9yZD1GyIM5ZT1PHMtr
         bBTOKjaq6HDaj/DIi0gInNMCwKRYkDMosnx6XO6+G3B4c0E2mTQw3wnydboapEdM2ABF
         8vz+TATJ2vBzW6lR1tsuYbmt0hZX3Cgl47RwZkqaXB2xHZhzmTuWh+Z4cNMq/gWrJn63
         F3bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W4rZNN6MexNf+4Y+yvOzItKC8QYrmCuKgxjS5Cfv4KU=;
        b=bUi2pApPN2rh/opu32dYdoB1xEeKUTngcRuklim8W3UgqSY9ajm2XnEXOxvWO/5HMZ
         MlpjXXfuExtwaTRVqhdHLP9e+ybc22tLQd/CwOtkKGFNPxhRrx8tW6h8cidRWwgX4LgE
         qPVmx0gKhS4lldPSCFT3lGWt17nz2roT8dCHItlY0GeU2XwYL0Tm+NNwa5kqCrHUxTp/
         PILcxLJD+lC2BrG/S0PZILZznaiUQavMDIASpdgdhRrncRxy7LrP/ycCmfTqIhtkwX2b
         ckLIF7sqqBrCGg8s29F9+E8z7TMNkGxKSPZnzVBUGktWzqSSSezQBPaoezmIfrflkhdW
         ZUFA==
X-Gm-Message-State: APzg51Dbn3gcDaVNYYOjySpxY5ZlNajRkGx9oJlwUEwdgr/vIPLOCod+
        Xh1ldG2ANzDz+J1EPTeQJiGsr8Dw
X-Google-Smtp-Source: ANB0VdZfeN4DQezVaR8og24J4JIkTgbsrM5w582RWuGDB0rHP481l2VMA3huffXAHHBIS9AANrPR0w==
X-Received: by 2002:adf:9281:: with SMTP id 1-v6mr20716221wrn.69.1535986184700;
        Mon, 03 Sep 2018 07:49:44 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id e133-v6sm23841649wma.33.2018.09.03.07.49.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Sep 2018 07:49:44 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 04/10] fsck: document and test commented & empty line skipList input
Date:   Mon,  3 Sep 2018 14:49:22 +0000
Message-Id: <20180903144928.30691-5-avarab@gmail.com>
X-Mailer: git-send-email 2.19.0.rc1.350.ge57e33dbd1
In-Reply-To: <2b31e12e-20e9-3d08-58bd-977f8b83e0a7@web.de>
References: <2b31e12e-20e9-3d08-58bd-977f8b83e0a7@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There is currently no comment syntax for the fsck.skipList, this isn't
really by design, and it would be nice to have support for comments.

Document that this doesn't work, and test for how this errors
out. These tests reveal a current bug, if there's invalid input the
output will emit some of the next line, and then go into uninitialized
memory. This is fixed in a subsequent change.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/config.txt        | 11 +++++++----
 t/t5504-fetch-receive-strict.sh | 21 +++++++++++++++++++++
 2 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index fd1b5837d0..0e1ce7de8b 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1712,10 +1712,13 @@ will only cause git to warn.
 fsck.skipList::
 	The path to a list of object names (i.e. one SHA-1 per
 	line) that are known to be broken in a non-fatal way and should
-	be ignored. This feature is useful when an established project
-	should be accepted despite early commits containing errors that
-	can be safely ignored such as invalid committer email addresses.
-	Note: corrupt objects cannot be skipped with this setting.
+	be ignored. Comments ('#') and empty lines are not supported, and
+	will error out.
++
+This feature is useful when an established project should be accepted
+despite early commits containing errors that can be safely ignored
+such as invalid committer email addresses.  Note: corrupt objects
+cannot be skipped with this setting.
 +
 Like `fsck.<msg-id>` this variable has corresponding
 `receive.fsck.skipList` and `fetch.fsck.skipList` variants.
diff --git a/t/t5504-fetch-receive-strict.sh b/t/t5504-fetch-receive-strict.sh
index fa56052f0f..38aaf3b928 100755
--- a/t/t5504-fetch-receive-strict.sh
+++ b/t/t5504-fetch-receive-strict.sh
@@ -169,6 +169,27 @@ test_expect_success 'fsck with invalid or bogus skipList input' '
 	test_i18ngrep "Invalid SHA-1: \[core\]" err
 '
 
+test_expect_success 'fsck with invalid or bogus skipList input (comments & empty lines)' '
+	cat >SKIP.with-comment <<-EOF &&
+	# Some bad commit
+	0000000000000000000000000000000000000001
+	EOF
+	test_must_fail git -c fsck.skipList=SKIP.with-comment fsck 2>err-with-comment &&
+	test_i18ngrep "^fatal: Invalid SHA-1: # Some bad commit$" err-with-comment &&
+	cat >SKIP.with-empty-line <<-EOF &&
+	0000000000000000000000000000000000000001
+
+	0000000000000000000000000000000000000002
+	EOF
+	test_must_fail git -c fsck.skipList=SKIP.with-empty-line fsck 2>err-with-empty-line &&
+	test_i18ngrep "^fatal: Invalid SHA-1: " err-with-empty-line
+'
+
+test_expect_failure 'fsck no garbage output from comments & empty lines errors' '
+	test_line_count = 1 err-with-comment &&
+	test_line_count = 1 err-with-empty-line
+'
+
 test_expect_success 'push with receive.fsck.skipList' '
 	git push . $commit:refs/heads/bogus &&
 	rm -rf dst &&
-- 
2.19.0.rc1.350.ge57e33dbd1

