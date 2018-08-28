Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0DEE21F404
	for <e@80x24.org>; Tue, 28 Aug 2018 09:52:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727595AbeH1Nnb (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Aug 2018 09:43:31 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:40699 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727176AbeH1Nna (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Aug 2018 09:43:30 -0400
Received: by mail-wm0-f67.google.com with SMTP id 207-v6so1297281wme.5
        for <git@vger.kernel.org>; Tue, 28 Aug 2018 02:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Yi7EozukgtrIOetTZl4nyix7Uj3c2OU6OCRFlbMPjr4=;
        b=ebU3UcsAyBQN/x32yRy0tOKXc/JFyfD3QpGUahxpt/T1rkt6heHhzHzMeRbuqfc5w4
         skvs/dnXKmKVGsuIGeIgFN07Kaenxq7v2XqlsOYsDCkackZ9FYj3bVty2ew1Mw5t1IvI
         TA8SeQ2GH2RjvYh6q61DYwxwiU03XK0m84QrzQl18lvlX31BJtCjfLD7amX2bm/SCtEE
         VTs/qpb5i2dMdljCJx4nKfL4lsUHhT4wMyJmEMx4VtQjGWaaXnMBjsuF4/Sduz6zejUX
         9FTaXlLzgSa5mIRKn9QgWhtGtN11/oc5Al0EwQB/5180M14kGrTX9Cah7jRcJCi6sfkG
         7glQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Yi7EozukgtrIOetTZl4nyix7Uj3c2OU6OCRFlbMPjr4=;
        b=heeyOTM8tIMgau5qFXJpvmgXKofNP97agl40NV+aSH7GozEQrkduwqrxFoh/5SwN+0
         Wecv4MpwxPxjwdzz3Uj0F6V6SXFA2ZjugTJZsTeFJ/yJcjOrJvkH7GBAV0WRXjxNIEka
         5CfUYlrMhl6sbun86WzLsfGFqognFXu+oeXJMUTxie0yTWfGeRuglad8kEY2ZdfkM9nv
         Al7YTFNGFEs9WZurNx7aNUG2nq0qi9Dx7QtUuujRkESlL6G2MFidWiNEADIEqaTYBeF8
         KOHNkxaz2m3WoAZUjNzGr7SlE4gtCT+gA65hauNcJ/hy5+GD5ZntabFWXPEnbe6MZ+La
         3bBg==
X-Gm-Message-State: APzg51DpfMq4Jyda+sj6lni9O37rnZ2r256/ejOU8d21EsyazExjgPlf
        DGkU0S8sdaeqyDlnpNUN9Y3ILeFwrzc=
X-Google-Smtp-Source: ANB0VdaMu1WiOFwN9HJtKWZQVFSYvfUowRyxngwiRQttt0iGzroo5l+PVMsUxFBRXcHs7KbmNQOH5w==
X-Received: by 2002:a1c:82c8:: with SMTP id e191-v6mr797881wmd.35.1535449957780;
        Tue, 28 Aug 2018 02:52:37 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id a37-v6sm1572238wrc.21.2018.08.28.02.52.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Aug 2018 02:52:37 -0700 (PDT)
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
Subject: [PATCH v4 4/8] fsck: document and test commented & empty line skipList input
Date:   Tue, 28 Aug 2018 09:52:15 +0000
Message-Id: <20180828095219.23296-5-avarab@gmail.com>
X-Mailer: git-send-email 2.19.0.rc0.228.g281dcd1b4d0
In-Reply-To: <87lg8refcr.fsf@evledraar.gmail.com>
References: <87lg8refcr.fsf@evledraar.gmail.com>
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
index b2fdbc6764..c7f033f036 100644
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
2.19.0.rc0.228.g281dcd1b4d0

