Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD52CC433EF
	for <git@archiver.kernel.org>; Thu, 14 Jul 2022 17:44:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240322AbiGNRoV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jul 2022 13:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240326AbiGNRoS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jul 2022 13:44:18 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7B751705B
        for <git@vger.kernel.org>; Thu, 14 Jul 2022 10:44:17 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-10cf9f5b500so2191150fac.2
        for <git@vger.kernel.org>; Thu, 14 Jul 2022 10:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=dc90NpyMe8caA3WBGkIphVhIhtz8+JLCQgomoV5s7iI=;
        b=eqm0iA80zurSwx3MwxdVJHNTTVg70ktcXkKpEDHsaeEVELpnFAl2o3gruw32TXlXj3
         T8aUQjB7XH1GtgeDGHqIzxc0ZPdvcarYvc3vvHoPZxXLcRmcuMVTAP/uAzlKyeGeKy4G
         aLb/OZh0ibhmXx32Ba5pObgJkgjCCcfsKDhBmtN2HQY6a8pwoxoet45gtFHPTXLJgSiM
         CP0ZC1QGci+I6wBD8lWHpEf16iR732wHfh/gnC3fP/w7dGTxn+TiVDv2p3DOI/uRhTLU
         csXpzMYFS5o1ey1gRQdWlXFEUxECG+huMJiR2/8lLTPTwUALyKxIFysIigwgkOX2l4JZ
         gsrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dc90NpyMe8caA3WBGkIphVhIhtz8+JLCQgomoV5s7iI=;
        b=BucZCejZ2q34chaBxVegsUtVvd6uiX9MYad3wZtnklf8ebTFi8WHaGyNBdw0Dambwq
         stzy92RyZwV7vByoIz9LssGkoLFJbYv6MTjJBcIPXyLcHg46aBVLQBO6OvnIpaQTUD6D
         HtUOtIyRNqjXXvMAw6EiHAe5WjDV7cevw42rTTJXsF9szVS46Lqge7PfsZpXbVkWijmx
         ieOxwAOTx817VfzIN2yb1E8wS0uyneKguIOVjt48ZfL1o8mq1kZsjHGfWxn6LOiVfrYn
         aynHE/OnOyA2pe5uW09R5Q7DpnXgPIb3N5AVblM/Hox5cfUAXWBtd7Uzn6MSm8wUGQKd
         E7RQ==
X-Gm-Message-State: AJIora+VCzrnfr4NPDoWAhkpq9Noz61GSALPXNtjwL2J4UgceILoLrQD
        0Ss6JwTzhEDg5+iFzU3CMt7kCSZLA8VJeg==
X-Google-Smtp-Source: AGRyM1tLSSzaXlzVqAejiM5GcSjE7RYLQ1f01dnCoNKO5Lf5EQnUCvK39UkcBlfT9Z+l5d+MTpeyFA==
X-Received: by 2002:a05:6871:28c:b0:10b:fbbc:5fee with SMTP id i12-20020a056871028c00b0010bfbbc5feemr7829459oae.127.1657820656667;
        Thu, 14 Jul 2022 10:44:16 -0700 (PDT)
Received: from mango.meuintelbras.local ([177.32.109.17])
        by smtp.gmail.com with ESMTPSA id bx17-20020a056830601100b0061c5ea08b2bsm906304otb.77.2022.07.14.10.44.15
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 10:44:16 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Subject: [PATCH 1/3] doc: grep: unify configuration variables definitions
Date:   Thu, 14 Jul 2022 14:44:02 -0300
Message-Id: <439cfdf858f5b1917ae7ca3ca327bb33b42f71c7.1657819649.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <cover.1657819649.git.matheus.bernardino@usp.br>
References: <cover.1657819649.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The configuration variables for git-grep are duplicated in
"Documentation/git-grep.txt" and "Documentation/config/grep.txt", which
gqcan make maintenance difficult. The first also contains a definition
that is not present in the latter (grep.fullName), and the latter
received a wording improvement that was not replicated in the former:
see 91028f765 ("grep: clarify what `grep.patternType=default` means",
2021-12-05).

To avoid such problems, unify the information in one file and include it
in the other.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 Documentation/config/grep.txt | 10 ++++++++--
 Documentation/git-grep.txt    | 37 ++++++-----------------------------
 2 files changed, 14 insertions(+), 33 deletions(-)

diff --git a/Documentation/config/grep.txt b/Documentation/config/grep.txt
index 182edd813a..6996e64574 100644
--- a/Documentation/config/grep.txt
+++ b/Documentation/config/grep.txt
@@ -17,8 +17,14 @@ grep.extendedRegexp::
 	other than 'default'.
 
 grep.threads::
-	Number of grep worker threads to use.
-	See `grep.threads` in linkgit:git-grep[1] for more information.
+	Number of grep worker threads to use. See `--threads`
+ifndef::git-grep[]
+	in linkgit:git-grep[1]
+endif::git-grep[]
+	for more information.
+
+grep.fullName::
+	If set to true, enable `--full-name` option by default.
 
 grep.fallbackToNoIndex::
 	If set to true, fall back to git grep --no-index if git grep
diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index 3d393fbac1..65a3ca1101 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -37,7 +37,6 @@ registered in the index file, or blobs in given tree objects.  Patterns
 are lists of one or more search expressions separated by newline
 characters.  An empty string as search expression matches all lines.
 
-
 OPTIONS
 -------
 --cached::
@@ -239,8 +238,10 @@ providing this option will cause it to die.
 	custom hunk-header' in linkgit:gitattributes[5]).
 
 --threads <num>::
-	Number of grep worker threads to use.
-	See `grep.threads` in 'CONFIGURATION' for more information.
+	Number of grep worker threads to use. If not provided (or set to
+	0), Git will use as many worker threads as the number of logical
+	cores available. The default value can also be set with the
+	`grep.threads` configuration.
 
 -f <file>::
 	Read patterns from <file>, one per line.
@@ -334,34 +335,8 @@ performance in this case, it might be desirable to use `--threads=1`.
 CONFIGURATION
 -------------
 
-grep.lineNumber::
-	If set to true, enable `-n` option by default.
-
-grep.column::
-	If set to true, enable the `--column` option by default.
-
-grep.patternType::
-	Set the default matching behavior. Using a value of 'basic', 'extended',
-	'fixed', or 'perl' will enable the `--basic-regexp`, `--extended-regexp`,
-	`--fixed-strings`, or `--perl-regexp` option accordingly, while the
-	value 'default' will return to the default matching behavior.
-
-grep.extendedRegexp::
-	If set to true, enable `--extended-regexp` option by default. This
-	option is ignored when the `grep.patternType` option is set to a value
-	other than 'default'.
-
-grep.threads::
-	Number of grep worker threads to use. If unset (or set to 0), Git will
-	use as many threads as the number of logical cores available.
-
-grep.fullName::
-	If set to true, enable `--full-name` option by default.
-
-grep.fallbackToNoIndex::
-	If set to true, fall back to git grep --no-index if git grep
-	is executed outside of a git repository.  Defaults to false.
-
+:git-grep: 1
+include::config/grep.txt[]
 
 GIT
 ---
-- 
2.37.0

