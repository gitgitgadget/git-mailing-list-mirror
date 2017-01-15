Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF27E2079E
	for <e@80x24.org>; Sun, 15 Jan 2017 18:47:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751393AbdAOSrg (ORCPT <rfc822;e@80x24.org>);
        Sun, 15 Jan 2017 13:47:36 -0500
Received: from mail-qt0-f196.google.com ([209.85.216.196]:35180 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751352AbdAOSrb (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Jan 2017 13:47:31 -0500
Received: by mail-qt0-f196.google.com with SMTP id f4so12105871qte.2
        for <git@vger.kernel.org>; Sun, 15 Jan 2017 10:47:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AIJJBixlH3D00JdOWwPLlUFVmoEANmx4LaGJp+2etO4=;
        b=FJM41gLHtflwCMCH9S7EA+7qNgaElMDbX14N+wi89PXAp3zQSW6kQf5ZJTHziJoJF3
         MaRrmQbG0fVctrZJt8PjUiT8pkw9PdbX/D4689wnR1J+sIRvwxrLxQC81vA5IYMecf//
         T1kVmDqz9KX2Jy8INYeSfBGXLakeaNIbiUowZ5fVRcWHr6qs65sl9gCq5Rs8wa2s3CyU
         A1u4DjrQBGO8GwrCqNsKJg8fqqonhZX9/DQ98m/zcCktshBkH9r7TNeNEHCV+rYtzh1D
         mbuPzvb5J73VPMUi7+iQ9Ebumr80/jxt30xh6k0hvCiQ32VfFbKMFkW+GO/u2G9TJtaT
         JJBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AIJJBixlH3D00JdOWwPLlUFVmoEANmx4LaGJp+2etO4=;
        b=EP+JDW4RzBY+M8yc876TLaRCiA6P3a7dtcKH7WYg1RmUX6moRhhv8iFPIIJfIq+SkC
         SUGR2yY2wCT9kmkZo4msF77bdI61ybYuAZGY0waFXeCgZrWMUhrbfEjfpVf80OlcYzBo
         dW3Dydq1BPxzonLush3LaXLYCbomaDrWNbxG1nG6kONlC4Kk/W34hhcU/8LSdyWAzqUW
         mA2keHzDZ6vkhxUZB5U7MhRfdoBso6Jxw3ej4838yT1zyeHKo4Z7Qgeya+VipkX3lpiZ
         6eo6MUTMECTFcqDFq94Zw5O4euhcOylSQu0iQxhsvQO8FI3zyTyaAwJ7ciUyaCAwK0Uu
         N/Zw==
X-Gm-Message-State: AIkVDXLUK0BncIuwh8eRmRS9wcdKah3Dn9dm/Zq72Gt3WHsIKbyRWLB/yJ/GObvmVohCmMnV
X-Received: by 10.200.43.115 with SMTP id 48mr12098528qtv.157.1484506050356;
        Sun, 15 Jan 2017 10:47:30 -0800 (PST)
Received: from localhost.localdomain ([2604:2000:8183:da00::3])
        by smtp.gmail.com with ESMTPSA id x40sm14362243qtx.12.2017.01.15.10.47.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Jan 2017 10:47:29 -0800 (PST)
From:   santiago@nyu.edu
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, sunshine@sunshineco.com,
        walters@verbum.org, Santiago Torres <santiago@nyu.edu>
Subject: [PATCH v5 7/7] t/t7004-tag: Add --format specifier tests
Date:   Sun, 15 Jan 2017 13:47:05 -0500
Message-Id: <20170115184705.10376-8-santiago@nyu.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170115184705.10376-1-santiago@nyu.edu>
References: <20170115184705.10376-1-santiago@nyu.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Santiago Torres <santiago@nyu.edu>

tag -v now supports --format specifiers to inspect the contents of a tag
upon verification. Add two tests to ensure this behavior is respected in
future changes.

Signed-off-by: Santiago Torres <santiago@nyu.edu>
---
 t/t7004-tag.sh | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index 07869b0c0..b2b81f203 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -874,6 +874,22 @@ test_expect_success GPG 'verifying a forged tag should fail' '
 	test_must_fail git tag -v forged-tag
 '
 
+test_expect_success 'verifying a proper tag with --format pass and format accordingly' '
+	cat >expect <<-\EOF 
+	tagname : signed-tag
+	EOF &&
+	git tag -v --format="tagname : %(tag)" "signed-tag" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'verifying a forged tag with --format fail and format accordingly' '
+	cat >expect <<-\EOF 
+	tagname : forged-tag
+	EOF &&
+	test_must_fail git tag -v --format="tagname : %(tag)" "forged-tag" >actual &&
+	test_cmp expect actual
+'
+
 # blank and empty messages for signed tags:
 
 get_tag_header empty-signed-tag $commit commit $time >expect
-- 
2.11.0

