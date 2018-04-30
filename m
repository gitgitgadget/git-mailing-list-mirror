Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F79121841
	for <e@80x24.org>; Mon, 30 Apr 2018 09:51:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752224AbeD3JvJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Apr 2018 05:51:09 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36752 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751529AbeD3JvF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Apr 2018 05:51:05 -0400
Received: by mail-wm0-f65.google.com with SMTP id n10so13210398wmc.1
        for <git@vger.kernel.org>; Mon, 30 Apr 2018 02:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=znFcSDBl3HyCg4pby8GzLU+/8/jb8qxQ5GbKHHHNY0Y=;
        b=Pg7Sxjtf44Nu+1SsLF3ta+lrWrWZ+sxTR/6MBD3kAKSdHpbPunOaFOTP0ZCoM1n4dv
         q4746Sx2v5ON5+OARhQQRffuvMMZvqkivTRqlnmoANHXCNU83VlJ1t2UQa9u1rf57uGS
         Gu4GPUdPmsWCt8GYy8Q2J92tdt6HC1mae1ierUZ89K327lSoV560z3rEoQl170zby4Xk
         E+BeSAUsORkeMKxm75U84VSYsZoLEjwjME5DKIxL1JQCLugFv5YH9qnMPRGn4h418SaE
         ZY3UVnyH+EkuYjq4+WymNn0T4s2QE6fIsPtAH6me3ye7VlK5frX+gzTDGmhfYPwYJ2Aq
         HaKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=znFcSDBl3HyCg4pby8GzLU+/8/jb8qxQ5GbKHHHNY0Y=;
        b=phocu2Dv2Al3c0vf+yPxMAdK4J8KU3qnWQ929gmT5sRy8ca0ebnYOmq4Aha7e83i2U
         SEc7dzky9CRSo/5UgxrYPy//ciFu7gCntv8UTkaDkZTPlHqnNrVGr5mkdNEFM17cwiBS
         /OABkA815onr7z2qHqRgszR5GUoNvo6JnpD7ed7khVxfZsAoNsDW6i671FFmcsyjWvlp
         Q6vxKG9TmrzQxS9DQwe72VBFLVZzM5y2A/ii1gddS1ZM4QAtRMdc+PqZThjDb5APy9On
         ONrYPDfV85pFQKy7QF9eCOulrJqnYxFbGDE4dO7LaweDmfCRIexY/KLq22lQmzJ6vH4C
         qDQA==
X-Gm-Message-State: ALQs6tAv7qPQMfBoLwOMy1IjMaXyuBkzqj+4SDbefXRkVjk99C2+o0ry
        VkpbZFtPJ2XPJpDAL1lVbNlzuOFj
X-Google-Smtp-Source: AB8JxZqf6Xf2gmCQfDKdYCXcJakFFHs9u2JPIgDk8BdADqXYBDPODivNItIgUM5bJVbsumbUWrvLHA==
X-Received: by 10.28.3.85 with SMTP id 82mr2524617wmd.96.1525081863518;
        Mon, 30 Apr 2018 02:51:03 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id 42-v6sm13178687wrx.24.2018.04.30.02.51.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Apr 2018 02:51:02 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Avery Pennarun <apenwarr@gmail.com>, Jeff King <peff@peff.net>,
        Stephen R Guglielmo <srguglielmo@gmail.com>,
        "A . Wilcox" <AWilcox@Wilcox-Tech.com>,
        David Aguilar <davvid@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 3/4] subtree: fix a test failure under GETTEXT_POISON
Date:   Mon, 30 Apr 2018 09:50:43 +0000
Message-Id: <20180430095044.28492-4-avarab@gmail.com>
X-Mailer: git-send-email 2.17.0.290.gded63e768a
In-Reply-To: <20180430095044.28492-1-avarab@gmail.com>
References: <20180430095044.28492-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t7900-subtree.sh | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/t/t7900-subtree.sh b/t/t7900-subtree.sh
index eb223ff049..a6e7103f92 100755
--- a/t/t7900-subtree.sh
+++ b/t/t7900-subtree.sh
@@ -38,6 +38,16 @@ check_equal()
 	fi
 }
 
+check_equal_i18n()
+{
+	if test_have_prereq C_LOCALE_OUTPUT
+	then
+		check_equal "$@"
+	else
+		return 0
+	fi
+}
+
 undo()
 {
 	git reset --hard HEAD~
@@ -250,7 +260,7 @@ test_expect_success 'merge the added subproj again, should do nothing' '
 		# this shouldn not actually do anything, since FETCH_HEAD
 		# is already a parent
 		result=$(git merge -s ours -m "merge -s -ours" FETCH_HEAD) &&
-		check_equal "${result}" "Already up to date."
+		check_equal_i18n "${result}" "Already up to date."
 	)
 '
 
-- 
2.17.0.290.gded63e768a

