Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B57301F829
	for <e@80x24.org>; Wed,  3 May 2017 13:55:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752762AbdECNy6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 May 2017 09:54:58 -0400
Received: from mail-wr0-f180.google.com ([209.85.128.180]:33885 "EHLO
        mail-wr0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751649AbdECNy4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2017 09:54:56 -0400
Received: by mail-wr0-f180.google.com with SMTP id l9so108173498wre.1
        for <git@vger.kernel.org>; Wed, 03 May 2017 06:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SS41iovL5rANwElzK2lI3/iJ1rtFmMJq68CW9UmC0O4=;
        b=OFn+KTePePW2TJ0scl1JVNDMbKw+W/LVSp1ull4URJO56BsiUl/Ot+GmYH9pXmj7FC
         fxBv2AjbJ+ni4b5lEXusvNDgDCCy6XcGSAAa58CNM+fh4OgVAbYBjE5XktGlpkalUfHK
         EmBfoO7HFcrfauEYf6sQpmsNEb/ZZtuE6nqDR3wtmyR4HCxKi9ybIXwRZo82g7IUHH0Y
         ptJAp3cRi8iATFb4J/QAOamXdFmajbymCVbPc433oUK4U6K75tDopgxVfaZo0QqvRWGs
         EQlXVJDRDNVXNeIMM6cvLq362o4fOtOfkYxnqiWl7Ka3ntaPJhsa+MOuqwyyhkkC+RYs
         aSZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SS41iovL5rANwElzK2lI3/iJ1rtFmMJq68CW9UmC0O4=;
        b=ZySNeqQCoMIcvq3ePwOJMjS0ANVyeRS520Q1hQkrnSwqBB5aH1iV3LaIAmVaeBO/Nb
         QPaRPeRjC9h9LwLzn8la8AT2YgYvAPfkNQfbe+hVAC79Zx2UvYSUfd3JVwlijB9M3KM2
         OrAaOB4osCT4twd+1htI9qNEhngFFkg7RD/FLoPvIrQlNbTpDoCMKPQmDVbF00vCu4Pp
         Upc4QHI0PFCtwm9HbExrxkv3IpHY69jOe44L4HVrMHfLq40ymxqBfbv8ZeoBVGSgE/bZ
         L2RueNSIvhAgzA9LTbJ9N35ArgKBRfwHHfg179KDFCvqxNaOvQG0bsZOVs7hN9Y+yrqr
         8nxQ==
X-Gm-Message-State: AN3rC/6tNyPkxyI5IxFWmTq+8zmSA5L/+971RgPkr7ZX0+n2e5MbHAoZ
        t4Re//hAN3KMLw==
X-Received: by 10.223.170.142 with SMTP id h14mr22540960wrc.140.1493819689448;
        Wed, 03 May 2017 06:54:49 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id s110sm23550105wrc.5.2017.05.03.06.54.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 May 2017 06:54:48 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] config.mak.uname: set NO_REGEX=NeedsStartEnd on AIX
Date:   Wed,  3 May 2017 13:54:30 +0000
Message-Id: <20170503135430.7785-1-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Set the NO_REGEX=NeedsStartEnd Makefile flag by default on AIX.

Since commit 2f8952250a ("regex: add regexec_buf() that can work on a
non NUL-terminated string", 2016-09-21) git has errored out at
compile-time if the regular expression library doesn't support
REG_STARTEND.

While looking through Google search results for the use of NO_REGEX I
found a Chef recipe that set this on AIX[1], looking through the
documentation for the latest version of AIX (7.2, released October
2015) shows that its regexec() doesn't have REG_STARTEND.

1. https://github.com/chef/omnibus-software/commit/e247e36761#diff-3df898345d670979b74acc0bf71d8c47
2. https://www.ibm.com/support/knowledgecenter/ssw_aix_72/com.ibm.aix.basetrf2/regexec.htm

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 config.mak.uname | 1 +
 1 file changed, 1 insertion(+)

diff --git a/config.mak.uname b/config.mak.uname
index 399fe19271..192629f143 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -237,6 +237,7 @@ ifeq ($(uname_S),AIX)
 	NO_MKDTEMP = YesPlease
 	NO_STRLCPY = YesPlease
 	NO_NSEC = YesPlease
+	NO_REGEX = NeedsStartEnd
 	FREAD_READS_DIRECTORIES = UnfortunatelyYes
 	INTERNAL_QSORT = UnfortunatelyYes
 	NEEDS_LIBICONV = YesPlease
-- 
2.11.0

