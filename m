Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C2171F576
	for <e@80x24.org>; Wed, 31 Jan 2018 11:07:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753661AbeAaLHK (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jan 2018 06:07:10 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:37018 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753647AbeAaLHI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jan 2018 06:07:08 -0500
Received: by mail-pg0-f68.google.com with SMTP id z17so9761971pgc.4
        for <git@vger.kernel.org>; Wed, 31 Jan 2018 03:07:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qtLjttGN6RcBUcVQA5mL5mItEN2W+T7CEHDjC0rvQJY=;
        b=sBZiJjxIZPsOnbCYMyBDJJNE/0zRoB22jEdMvZCpcgFqtzwARA9OdnWUshzjDWzDNp
         pxfxgye76bQYTJUQitrEr4QjszOe1sm+7J7UkXYZS/1BdX4Yf+yTsO3mA9EL61AhsPdL
         pIGgGXnuX6R/0O9nP/3/Mn+sFDwru38dSFAErJMGZGRrZHakKMGFhwMlCwf/wahUgDav
         xH1bIIREnS9ec9ZIxrpoOcfuaaq1Dj7tcRXcgLUUmNrGUHgsVMwRnrhkwRqmeQcM4kmc
         Up9IG/bA20RZzu3IJCkPzjs7Evt30TaoH1jkTlRP40Dw/cMSZQgL953kQ5O6gSjWrqP2
         lXxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qtLjttGN6RcBUcVQA5mL5mItEN2W+T7CEHDjC0rvQJY=;
        b=Hv8dOYspoXYxgTt0+yBrJmRMIJEHfvf4tVHEW/tyTc/CQFL5WFeYz3iaqveCV/Wkxo
         hrJVwM2QAK6Rds7/XWJ05SBr493QUOZ13NAxfGdi/Vn0vb7bN/99JX2kPdmahqfPpI8V
         s7vcQEOpYhdSzS/Zw77OM2eLjq1mr7HFhdlQZnlQ5dBvBUZA3L540GF6H3P/6CWxvAxp
         thCsZdMeuF4yDof5L3l+1fWWxruSGa6pk4ZKzToASx0vac2c33+BmqDHng24dQyIoc2k
         z+zLLM5/tZSwAbXEBAyxR+ChltDfmTGOqkCpS4agm6tYs+gszo6lbKtJPDC79BULwP79
         j+Hg==
X-Gm-Message-State: AKwxytdCN5Wb+eQAkjYu99f0ByhnI4O/h3OdEKjomQmUQg3YCTwhTLQN
        xI+S3RLgh7QZWC3WC4jV+Z7tFA==
X-Google-Smtp-Source: AH8x227cE+6SeA5nVfwkS5GPYtPnoCMBe+et21VIsZEWMypUJBCMCRhxHgF2aCm1LU7Kly/qMTIcOw==
X-Received: by 2002:a17:902:2823:: with SMTP id e32-v6mr26336653plb.44.1517396828070;
        Wed, 31 Jan 2018 03:07:08 -0800 (PST)
Received: from ash ([171.232.97.171])
        by smtp.gmail.com with ESMTPSA id p25sm38519252pfj.29.2018.01.31.03.07.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jan 2018 03:07:07 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Wed, 31 Jan 2018 18:07:03 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 15/41] completion: use __gitcomp_builtin in _git_describe
Date:   Wed, 31 Jan 2018 18:05:21 +0700
Message-Id: <20180131110547.20577-16-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.1.205.g271f633410
In-Reply-To: <20180131110547.20577-1-pclouds@gmail.com>
References: <20180131110547.20577-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

No new completable options!

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 contrib/completion/git-completion.bash | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 1713a583cf..450d8e488e 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1355,11 +1355,7 @@ _git_describe ()
 {
 	case "$cur" in
 	--*)
-		__gitcomp "
-			--all --tags --contains --abbrev= --candidates=
-			--exact-match --debug --long --match --always --first-parent
-			--exclude --dirty --broken
-			"
+		__gitcomp_builtin describe
 		return
 	esac
 	__git_complete_refs
-- 
2.16.1.205.g271f633410

