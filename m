Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D2DC20899
	for <e@80x24.org>; Tue,  8 Aug 2017 17:11:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752156AbdHHRL3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Aug 2017 13:11:29 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:38208 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752059AbdHHRL1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2017 13:11:27 -0400
Received: by mail-pg0-f65.google.com with SMTP id 123so3558518pga.5
        for <git@vger.kernel.org>; Tue, 08 Aug 2017 10:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=y7WWHHncDx5wHssiV6Q18KHakHdy9xsIZVZlar7ikY8=;
        b=YseBKLNWE0+dp/CCfLCkzJNI2y9SHsBrFa4Q8Lnd28MNUQUNeDbWDACx+pjFGowk6P
         RFugtWf154GvCqyT3PzapCmhQOrRctDEDab48K4qB+vZkhbwJgLNEDBpOKvK49bT26ot
         oknlhyGpuI4tRDUPRhXS2vhuRZEtoDXrT3DWrjRU+Nz+hdvKHl3hK28jJPRuSa8aiWGJ
         VrhTjOp5s2HxGPb61dj48FrRdJ58vQgxXQOUjVeVXpUbc7F7NAwY+uPf5pP3aQK2ucUR
         6rjQiNZeRG9zgbkPK5JvfUMd95HJzPa20dhRLRboFIDZfRdmpKm61mJJV9cqqDbvKaLn
         dO6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=y7WWHHncDx5wHssiV6Q18KHakHdy9xsIZVZlar7ikY8=;
        b=XrGlkO5BP4z6NLSiTmmCQ1bB+uy8CLPVDAeJIoNQh+zWt0qVgERPSu/pqOzBz4Fac5
         bh2fg46V3oDlDUEpJffyBaoJrMvjjbnDrxBEiBsRv7s89p4w+Gb487AJzYiLMOxjkdFI
         H8cKMrFu9Wnq29OBbCg/OxdXTm+R1FtjZjELSQ/ZwciI/ZZb4l1Ox3oaLm5dv3nZUrFE
         JNRumaHkjLFCdEgql+NhvWPGcynHj9drt3GcKL/hwdnjAjJ6yRPnxxesyjU1FSWPPwwD
         Q1LgkTpGhmeO1Oo16zUFEVXMaPwWKeEkPgxKGsCMYSYlqvJJDARfuvcuhMAQ6taSN559
         Eq4w==
X-Gm-Message-State: AHYfb5j1T9TgemspDqOGiLzcWzG1jGNakmz53Rpz0JKCfhxRrqx/sRFi
        fAmudly3+OfGvFq3S04=
X-Received: by 10.98.58.12 with SMTP id h12mr5286596pfa.102.1502212287065;
        Tue, 08 Aug 2017 10:11:27 -0700 (PDT)
Received: from localhost.localdomain ([117.249.214.142])
        by smtp.gmail.com with ESMTPSA id n184sm2417976pga.89.2017.08.08.10.11.24
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Aug 2017 10:11:26 -0700 (PDT)
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH v2 2/2 / RFC] branch: quote branch/ref names to improve readability
Date:   Tue,  8 Aug 2017 22:41:36 +0530
Message-Id: <20170808171136.31168-2-kaarticsivaraam91196@gmail.com>
X-Mailer: git-send-email 2.14.0.rc1.434.g6eded367a
In-Reply-To: <20170808171136.31168-1-kaarticsivaraam91196@gmail.com>
References: <xmqq60dzp00l.fsf@gitster.mtv.corp.google.com>
 <20170808171136.31168-1-kaarticsivaraam91196@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
---
 branch.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/branch.c b/branch.c
index ad5a2299b..a40721f3c 100644
--- a/branch.c
+++ b/branch.c
@@ -90,24 +90,24 @@ int install_branch_config(int flag, const char *local, const char *origin, const
 		if (shortname) {
 			if (origin)
 				printf_ln(rebasing ?
-					  _("Branch %s set up to track remote branch %s from %s by rebasing.") :
-					  _("Branch %s set up to track remote branch %s from %s."),
+					  _("Branch '%s' set up to track remote branch '%s' from '%s' by rebasing.") :
+					  _("Branch '%s' set up to track remote branch '%s' from '%s'."),
 					  local, shortname, origin);
 			else
 				printf_ln(rebasing ?
-					  _("Branch %s set up to track local branch %s by rebasing.") :
-					  _("Branch %s set up to track local branch %s."),
+					  _("Branch '%s' set up to track local branch '%s' by rebasing.") :
+					  _("Branch '%s' set up to track local branch '%s'."),
 					  local, shortname);
 		} else {
 			if (origin)
 				printf_ln(rebasing ?
-					  _("Branch %s set up to track remote ref %s by rebasing.") :
-					  _("Branch %s set up to track remote ref %s."),
+					  _("Branch '%s' set up to track remote ref '%s' by rebasing.") :
+					  _("Branch '%s' set up to track remote ref '%s'."),
 					  local, remote);
 			else
 				printf_ln(rebasing ?
-					  _("Branch %s set up to track local ref %s by rebasing.") :
-					  _("Branch %s set up to track local ref %s."),
+					  _("Branch '%s' set up to track local ref '%s' by rebasing.") :
+					  _("Branch '%s' set up to track local ref '%s'."),
 					  local, remote);
 		}
 	}
-- 
2.14.0.rc1.434.g6eded367a

