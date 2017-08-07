Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 185A22047F
	for <e@80x24.org>; Mon,  7 Aug 2017 14:39:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751989AbdHGOjk (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Aug 2017 10:39:40 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33763 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751541AbdHGOji (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Aug 2017 10:39:38 -0400
Received: by mail-pf0-f195.google.com with SMTP id c65so599442pfl.0
        for <git@vger.kernel.org>; Mon, 07 Aug 2017 07:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=y7WWHHncDx5wHssiV6Q18KHakHdy9xsIZVZlar7ikY8=;
        b=RegvIkOWTOldu3DU8AuidBgCB62Mcig/9ElzBCfxrk5dLkj36Ze3Ixzk0/IFPVNHHY
         8dfrwuKn/wgY9qZDu0cqcFx6+jxiIJsqwIF3Yj31QoF7JIz4Tjg3xvhlp4bv5AIqvosz
         6Jr6VBG5UlsU9L66G1KLNIUGYxREx1XmFbZIBMkhMI8Lsmh9JvQqCyVkYnnoRGcJjIPD
         ATWxAw+mo8TXjqQwFq442Aca5OEwaVpANjFyYMuLteYKwm/m8Qss7D9o2mFRMS7wAMDP
         hphWWRrw7WF+y1ANLtkf352cHC4+JDv4JDVh8bqtEIvQhj9OS+YEK02nY5auZACrXDeb
         Vxag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=y7WWHHncDx5wHssiV6Q18KHakHdy9xsIZVZlar7ikY8=;
        b=pnlSZ6ztDHsIJ/GD3M2zrsyE+U7O5jJfnNe/kOhLQKosgSPaeGvUERwt2OC0Hkw1s8
         TmXqOa+/+bZi9MUcMFU2ff+y3ZBOjWzvVcer5SPic9wcmu5Q5XF6ez7ctp5kAlyZK+P2
         7ACxP75qX0RdbJWk/9YJ4/vRBGQsRt9IJe6WSCQ4b9gVefsmUZo9SM8A8qhJyIruzD5d
         GRhG+1OaLlzpdRInLdyzs1WnB+bUtZh9kDKkReY1HtzZH3imRxeL3r+FH1byC6+RNUKt
         H96a5vo2vfaqgy44BcGlc/M7lO0TcEmtjAmG5Y6mIezuHi0tgkr3M4SnNE2sCehwNHmT
         pHrQ==
X-Gm-Message-State: AHYfb5jf9FhR889+de0zQNS0QhODicDReEOYBofuk1E0uu+2c75lxEJ1
        wU40pmaYAfbsDlnwbjQ=
X-Received: by 10.99.117.19 with SMTP id q19mr744481pgc.442.1502116777724;
        Mon, 07 Aug 2017 07:39:37 -0700 (PDT)
Received: from localhost.localdomain ([117.249.222.33])
        by smtp.gmail.com with ESMTPSA id u69sm15279812pfa.70.2017.08.07.07.39.35
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Aug 2017 07:39:37 -0700 (PDT)
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH 2/2 / RFC] branch: quote branch/ref names to improve readability
Date:   Mon,  7 Aug 2017 20:09:38 +0530
Message-Id: <20170807143938.5127-3-kaarticsivaraam91196@gmail.com>
X-Mailer: git-send-email 2.14.0.rc1.434.g6eded367a
In-Reply-To: <20170807143938.5127-1-kaarticsivaraam91196@gmail.com>
References: <xmqq1sp2q1cc.fsf@gitster.mtv.corp.google.com>
 <20170807143938.5127-1-kaarticsivaraam91196@gmail.com>
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

