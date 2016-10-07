Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E619620986
	for <e@80x24.org>; Fri,  7 Oct 2016 21:08:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756482AbcJGVI3 (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Oct 2016 17:08:29 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:36123 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756106AbcJGVIM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Oct 2016 17:08:12 -0400
Received: by mail-qt0-f193.google.com with SMTP id y38so1614135qta.3
        for <git@vger.kernel.org>; Fri, 07 Oct 2016 14:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ACaUHKzN20nbDE/IMGPwF3S7Hnnq+KWB/+bFkedncPc=;
        b=jU01Md3YB+vx84vC5vlbJJ1bbYZtfjn9tr/PmpYPSnjPYGBFFRlhKhZKRuNaElMd8O
         NdfBN3SYUX9xl6PiBaf09Knt8K2MHOs8I4lJxJ8t1e0pgBWE+b+k7lYJQPGrKy1Qj37q
         66KWu+SGQK5P082GLE7Z5xKCWt2X+8NU1HMpNkiRB0ipJ6LyiUI6k4gIvpHMKOW2tJSQ
         74nPMibHEEeSa3H3eCL0lgFEtocK/KXJqm5RFPgVahYSvb/WBYLCRtBkNu0QaSjIRTNE
         nni9NQ4SL3YPmnWCA+Y33cE2XSXJ3d7ONp+H+k2MttovET2se5NlyGb5O7Bu7+mdgl5H
         6OyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ACaUHKzN20nbDE/IMGPwF3S7Hnnq+KWB/+bFkedncPc=;
        b=BJofOAaz6PgAZVrvpj9nGAysbMcGGVVQHSsAv9sAsgldzZWG/n6UjgYlvhEriVpCle
         Cjt4GsV7D4NNbQEhlg9ampu+eVaqu4MH1hUuKrJzBIRMYwIfC+eGiMLNC8avzIauoZRX
         TT2RFGRSXoop6iigze3kY48D+OGlGCV20oY90hl8ASDIZKHa2LQHTCIpnqcSSY2BfX1z
         //A4xGUigM5Yso6rYparpvwAZTjhBFONSH4rCfMRej9Pv3Xm10hSuBB0gsNvVPQkncVL
         Xc9WzAVzBs4dvbxxg0PRc1E4KrdV06qPqEW3LeaMhVNgmkk7GfgIjvI6aR3U4ufI3SUu
         Hbjw==
X-Gm-Message-State: AA6/9RlGZjrUtNgkg6DFzcC7yvCsQ5IaJ/hBKr+tGeQnDPJII1X4V5ArVYkouPfGreRbzhMd
X-Received: by 10.237.36.28 with SMTP id r28mr13496560qtc.99.1475874452420;
        Fri, 07 Oct 2016 14:07:32 -0700 (PDT)
Received: from LykOS.nyu.edu (NYUFWA-WLESSAUTHCLIENTS-05.NATPOOL.NYU.EDU. [216.165.95.76])
        by smtp.gmail.com with ESMTPSA id a192sm7544808qkc.26.2016.10.07.14.07.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Oct 2016 14:07:31 -0700 (PDT)
From:   santiago@nyu.edu
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, sunshine@sunshineco.com,
        walters@verbum.org, Santiago Torres <santiago@nyu.edu>
Subject: [PATCH v4 7/7] t/t7004-tag: Add --format specifier tests
Date:   Fri,  7 Oct 2016 17:07:21 -0400
Message-Id: <20161007210721.20437-8-santiago@nyu.edu>
X-Mailer: git-send-email 2.10.0
In-Reply-To: <20161007210721.20437-1-santiago@nyu.edu>
References: <20161007210721.20437-1-santiago@nyu.edu>
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
index 8b0f71a..633b089 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -847,6 +847,22 @@ test_expect_success GPG 'verifying a forged tag should fail' '
 	test_must_fail git tag -v forged-tag
 '
 
+test_expect_success 'verifying a proper tag with --format pass and format accordingly' '
+	cat >expect <<-\EOF &&
+	tagname : signed-tag
+	EOF
+	git tag -v --format="tagname : %(tag)" "signed-tag" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'verifying a forged tag with --format fail and format accordingly' '
+	cat >expect <<-\EOF &&
+	tagname : forged-tag
+	EOF
+	test_must_fail git tag -v --format="tagname : %(tag)" "forged-tag" >actual &&
+	test_cmp expect actual
+'
+
 # blank and empty messages for signed tags:
 
 get_tag_header empty-signed-tag $commit commit $time >expect
-- 
2.10.0

