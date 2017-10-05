Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 229331FA21
	for <e@80x24.org>; Thu,  5 Oct 2017 20:55:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752256AbdJEUzH (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Oct 2017 16:55:07 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:38181 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752221AbdJEUzE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Oct 2017 16:55:04 -0400
Received: by mail-qk0-f196.google.com with SMTP id 17so3799780qkq.5
        for <git@vger.kernel.org>; Thu, 05 Oct 2017 13:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XHtGGXGcqDbi+MxWoRyN89gVQkxwD4qHa3c1w9voGIE=;
        b=khEAo6NYRFqwrEBIJHnAobclaaEddCusFpItg7o7p6tnzBDfDdmhlBeTmbyWVyWJnz
         1NbEJvb1Y+F+gv5hyy0kum0dszOitRrImbqZylZhECy3tlukLLel8jr/crKNDpUfKls5
         XsruC6PrGJ+oeIqwGGyzPc/Qa9S7dBUG1/kZC14KApW7qCGKITp/aO8GaRK/7Lcrglpo
         OPCMyXSSkBj25iQzNg+ULKGn6O/1sgXRSqfIL3PtgaxytMLB8OefEoeBXLZQVh7FxlnY
         ztEUqIl5knMM5U9zGj08gZCX48Nw3esYVDZ4GPUnXlm/HeAKkU70dUchpsTHk7cH7FF7
         G6oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XHtGGXGcqDbi+MxWoRyN89gVQkxwD4qHa3c1w9voGIE=;
        b=ot+qBklP3dVQx+yV1U7Y12f9JUYQ1yv8dLx/rr4MA9UW4wMkZTEu85OW4XyINIli5w
         N5UX46TGEpvA2tjkdlRzDNz5V7VU5AstRzYuwM8SN+es6YDCQX1LbVgiYw8Md9f322VC
         zZYbERU9057afsBSQuRHWe4AZKbjms/hYuNe6z87orflMzSJMmE507oS752b2n1PGF4j
         DWCllpt80VwRfXTUQjwuCYyQBTYdBf5k1ZBJgInA0EiZdv1Gm/bUweSyX5d6lbkTEKq6
         9Xu4g6zCF2KW6brAQADR/s8Q7caeI6+ifOC+dDPxrc9EscTD5Irp//v2cv2Cq+2D6//a
         bcIQ==
X-Gm-Message-State: AMCzsaVyOWYX/bR0qDpBrG5qJmJDrz+aahJeQYEnUHB6lEFwy+nKcXIM
        MA5mV/yRh+DEW7gyUY9OCRR9IFE5o4U=
X-Google-Smtp-Source: AOwi7QDjK0r5LB146SiO3rIh5pqyjKtT3Hm0sGZaThYzVwQ95bx3U/TDc5iLEtD3rRSvoxMtj/51bQ==
X-Received: by 10.55.214.156 with SMTP id p28mr6776880qkl.199.1507236903970;
        Thu, 05 Oct 2017 13:55:03 -0700 (PDT)
Received: from localhost.corp.microsoft.com ([2001:4898:8010::76e])
        by smtp.gmail.com with ESMTPSA id x127sm11871596qkd.3.2017.10.05.13.55.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 05 Oct 2017 13:55:03 -0700 (PDT)
From:   jameson.miller81@gmail.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, bmwill@google.com,
        sbeller@google.com, Jameson Miller <jamill@microsoft.com>
Subject: [PATCH 5/6] Add tests around status handling of ignored arguments
Date:   Thu,  5 Oct 2017 16:54:42 -0400
Message-Id: <20171005205443.206900-6-jameson.miller81@gmail.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20171005205443.206900-1-jameson.miller81@gmail.com>
References: <20171005205443.206900-1-jameson.miller81@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jameson Miller <jamill@microsoft.com>

Add tests for status handling of '--ignored=matching` and
`--untracked-files=normal`.

Signed-off-by: Jameson Miller <jamill@microsoft.com>
---
 t/t7519-ignored-mode.sh | 63 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/t/t7519-ignored-mode.sh b/t/t7519-ignored-mode.sh
index a8c35d1cbc..7292ec7d06 100755
--- a/t/t7519-ignored-mode.sh
+++ b/t/t7519-ignored-mode.sh
@@ -129,4 +129,67 @@ test_expect_success 'Verify status behavior on ignored folder containing tracked
 	test_i18ncmp expect output
 '
 
+# Test ignored matching behavior with --untracked=normal
+test_expect_success 'Verify matching ignored files with --untracked-files=normal' '
+	test_when_finished "git clean -fdx" &&
+	cat >expect <<-\EOF &&
+	? expect
+	? output
+	? untracked_dir/
+	! ignored_dir/
+	! ignored_files/ignored_1.ign
+	! ignored_files/ignored_2.ign
+	EOF
+
+	mkdir ignored_dir ignored_files untracked_dir &&
+	touch ignored_dir/ignored_1 ignored_dir/ignored_2 \
+		ignored_files/ignored_1.ign ignored_files/ignored_2.ign \
+		untracked_dir/untracked &&
+	git status --porcelain=v2 --ignored=matching --untracked-files=normal >output &&
+	test_i18ncmp expect output
+'
+
+# Test ignored matching behavior with --untracked=normal
+test_expect_success 'Verify matching ignored files with --untracked-files=normal' '
+	test_when_finished "git clean -fdx" &&
+	cat >expect <<-\EOF &&
+	? expect
+	? output
+	? untracked_dir/
+	! ignored_dir/
+	! ignored_files/ignored_1.ign
+	! ignored_files/ignored_2.ign
+	EOF
+
+	mkdir ignored_dir ignored_files untracked_dir &&
+	touch ignored_dir/ignored_1 ignored_dir/ignored_2 \
+		ignored_files/ignored_1.ign ignored_files/ignored_2.ign \
+		untracked_dir/untracked &&
+	git status --porcelain=v2 --ignored=matching --untracked-files=normal >output &&
+	test_i18ncmp expect output
+'
+
+# Test status behavior on ignored folder with tracked file
+test_expect_success 'Verify status behavior on ignored folder containing tracked file' '
+	test_when_finished "git clean -fdx && git reset HEAD~1 --hard" &&
+	cat >expect <<-\EOF &&
+	? expect
+	? output
+	! ignored_dir/ignored_1
+	! ignored_dir/ignored_1.ign
+	! ignored_dir/ignored_2
+	! ignored_dir/ignored_2.ign
+	EOF
+
+	mkdir ignored_dir &&
+	touch ignored_dir/ignored_1 ignored_dir/ignored_2 \
+		ignored_dir/ignored_1.ign ignored_dir/ignored_2.ign \
+		ignored_dir/tracked &&
+	git add -f ignored_dir/tracked &&
+	test_tick &&
+	git commit -m "Force add file in ignored directory" &&
+	git status --porcelain=v2 --ignored=matching --untracked-files=normal >output &&
+	test_i18ncmp expect output
+'
+
 test_done
-- 
2.13.6

