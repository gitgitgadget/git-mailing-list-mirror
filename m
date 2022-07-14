Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77F15C43334
	for <git@archiver.kernel.org>; Thu, 14 Jul 2022 17:44:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240384AbiGNRoW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jul 2022 13:44:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240374AbiGNRoU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jul 2022 13:44:20 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA8E517593
        for <git@vger.kernel.org>; Thu, 14 Jul 2022 10:44:19 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-10bec750eedso3302638fac.8
        for <git@vger.kernel.org>; Thu, 14 Jul 2022 10:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Egf4uiUaAGMsKUgyMm7wLfO8MohWRPTTE0BbshagsR4=;
        b=rCVKr+dQGOacyPQFgc/YQPhSRa8E/kznFTvxzJDOzhX6jM7RdDReK92+K2SXaMeQpD
         7W1ug/Q4/UOO8fwMGHgf7oFSFo4LJEPUw/2itOgJAwMjFLfZQ/3q3JGI/RCLid6SHdwK
         04bcvCbbyoiMUhqE+LpafZrQT83tfpX0paGENBdg0cyvd5xhVV2TqoekpmApE5wuZhfW
         1u4cEm8lEA2iedAF4PzeCLRmZ9bVGBpM2avaQQyWWs9HdF0uAVeMF0sMrE3H8yCT0Wy7
         SwPWO7j8Ovt3mrYWoCMA5BHRSXKSV5TAKhBh44RkFKcfYBVHlrW1ZzO/GUOMGiZsLBy1
         zvOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Egf4uiUaAGMsKUgyMm7wLfO8MohWRPTTE0BbshagsR4=;
        b=LpzSq99sbd0lZf2hv/eGlAZPVuoeoKAdemWJytArDIEcasBDgpDaNtUkxZNrdeOCBp
         HLCQboymJXNU70dlFpvfX8gp2eejt06AZqW0BMjQDp11lknBFENBExgw9QNmjcNjzGer
         m81J3e0zPTOvxgPGRStJZfkPOHJ/Q3LK1fwE/flnknyGih5/GACCS6tGr+CarzrOXkpP
         ePShc7/cJtqg9n22Lw0l5CCPAQBjalkm813/XUxAppIkKbWJSQwtIL53VDkkrkqp7mz2
         uEeIJlMrWbg72jokWZ3N3w5fY1WcQuiHbjvfyN9UGWv3LqtUe0Q33rGqwIfambfFo0pE
         KMjw==
X-Gm-Message-State: AJIora/7qaC4bMCFS4EgxDR2vlkW6aM1NLUWCFVV/0zHOKBEAqKgfWir
        of0ZzN7u0X7O83GYwqt3pUC1oRUxUT65AA==
X-Google-Smtp-Source: AGRyM1vScl6Ir5zs70eWC8fG1yERbfhRbMCxfNGso9IPHg39omklYnWBTBNrw/pvR9zrUl1uNHfqgQ==
X-Received: by 2002:a05:6870:461b:b0:e9:a015:36a6 with SMTP id z27-20020a056870461b00b000e9a01536a6mr7594968oao.185.1657820658702;
        Thu, 14 Jul 2022 10:44:18 -0700 (PDT)
Received: from mango.meuintelbras.local ([177.32.109.17])
        by smtp.gmail.com with ESMTPSA id bx17-20020a056830601100b0061c5ea08b2bsm906304otb.77.2022.07.14.10.44.17
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 10:44:18 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Subject: [PATCH 2/3] doc: apply: unify configuration variables definitions
Date:   Thu, 14 Jul 2022 14:44:03 -0300
Message-Id: <a25a6d89647638ffd682fb24ef0b5b6c9bed0941.1657819649.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <cover.1657819649.git.matheus.bernardino@usp.br>
References: <cover.1657819649.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Note that apply.ignoreWhitespace and apply.whitespace are defined with
slightly different wordings at git-apply.txt and config/apply.txt.
Nevertheless, there is no loss of information from using one or the
other, so I kept the latter for the single unified definition.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 Documentation/config/apply.txt | 7 ++++++-
 Documentation/git-apply.txt    | 9 ++-------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/config/apply.txt b/Documentation/config/apply.txt
index 8fb8ef763d..7fb1ae7f8a 100644
--- a/Documentation/config/apply.txt
+++ b/Documentation/config/apply.txt
@@ -4,8 +4,13 @@ apply.ignoreWhitespace::
 	option.
 	When set to one of: no, none, never, false tells 'git apply' to
 	respect all whitespace differences.
+ifndef::git-apply[]
 	See linkgit:git-apply[1].
+endif::git-apply[]
 
 apply.whitespace::
 	Tells 'git apply' how to handle whitespaces, in the same way
-	as the `--whitespace` option. See linkgit:git-apply[1].
+	as the `--whitespace` option.
+ifndef::git-apply[]
+	See linkgit:git-apply[1].
+endif::git-apply[]
diff --git a/Documentation/git-apply.txt b/Documentation/git-apply.txt
index b6d77f4206..7ababdaaa7 100644
--- a/Documentation/git-apply.txt
+++ b/Documentation/git-apply.txt
@@ -263,13 +263,8 @@ has no effect when `--index` or `--cached` is in use.
 CONFIGURATION
 -------------
 
-apply.ignoreWhitespace::
-	Set to 'change' if you want changes in whitespace to be ignored by default.
-	Set to one of: no, none, never, false if you want changes in
-	whitespace to be significant.
-apply.whitespace::
-	When no `--whitespace` flag is given from the command
-	line, this configuration item is used as the default.
+:git-apply: 1
+include::config/apply.txt[]
 
 SUBMODULES
 ----------
-- 
2.37.0

