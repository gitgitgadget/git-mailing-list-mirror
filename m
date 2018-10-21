Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE9B21F453
	for <e@80x24.org>; Sun, 21 Oct 2018 08:09:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727276AbeJUQWo (ORCPT <rfc822;e@80x24.org>);
        Sun, 21 Oct 2018 12:22:44 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:33481 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727219AbeJUQWo (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Oct 2018 12:22:44 -0400
Received: by mail-lj1-f193.google.com with SMTP id z21-v6so34255502ljz.0
        for <git@vger.kernel.org>; Sun, 21 Oct 2018 01:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7Nfh/EXuh/GEoGmihJ63ZcnomAHgfD5xEkB9WPhSJGs=;
        b=OZmT4SKprDg3paI/yGWVSSvnXm+d3nvF7tKwUNRXk4HksE/o1Zsnp3+Z9f03IE/YBp
         BDBLwpMy38oW0zFdue2pGbJq4vHb2Vt99PSXt7vM4vD0nGNd7uEqfp4+PTZlEUIobQ8N
         8pP9Vgy1WS/PqNhPs+H4qm7z1ceUfJ268GHRszqKJtLYpGiFfQHJh98IkhCVcwZnFivG
         ZsErKHfC0x05s1FKoysQRnvs6UWQbYfx/VcILxVWXr51CxmmsiC+2MNuR17BmgzwCquc
         0YZu6/e7WQhOyUNqTbz8AE2Xp9DWjCGfmCfGY6VtJklxTwiZsWgAMpC4TY2Yt9oZGJBD
         9ETg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7Nfh/EXuh/GEoGmihJ63ZcnomAHgfD5xEkB9WPhSJGs=;
        b=LANdFp0SXHVSdFG5et8JBXT9DHY60MS2DEoMaE7Qnp2F4kvjlNblAKSfioNZIyr/2q
         GxGnC2p1tKYTmCIL83hEXZFyqOI/lJ36kouBkNHkV/4yPwmSq5zkyjuCGderorS2Dx6/
         emj5Hqnm6GLTlE3rSI748FgPxJvHhs3MUQqTQ2ALHIy90HnpTGmAgOt8pZ0VW1QrRLiy
         Ic3i2UPcEESkMaSbSaLZK7sUcys6pxXYyCLOprKheZqpXpGZt4x19/fPKO3iBi1tXJXn
         wi2TXmsCO9tAuYsMxmvAlqrUSoVKzaKGP+m71rYWBS0DzhhlKceK6QxXLdRsi0U0IN6q
         XAAw==
X-Gm-Message-State: ABuFfoj0c7YtSRXTP+NlK98mR1sR2ljX/90NFxNBv3GQH4L1BsOaFewi
        dG460Qni/jUBZ3Fd6HWzOxU=
X-Google-Smtp-Source: ACcGV60KGl3emaKO684mxKruBDsPG4HKyCb6GMGbbK1nc3w2ZysNCbOewmUDXKsRQtm7hYt7qDpbFw==
X-Received: by 2002:a2e:9b46:: with SMTP id o6-v6mr29062511ljj.78.1540109352014;
        Sun, 21 Oct 2018 01:09:12 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id k9-v6sm6385889lje.51.2018.10.21.01.09.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Oct 2018 01:09:11 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, newren@gmail.com,
        peff@peff.net, sbeller@google.com
Subject: [PATCH v3 4/8] revision.c: correct a parameter name
Date:   Sun, 21 Oct 2018 10:08:55 +0200
Message-Id: <20181021080859.3203-5-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.647.g708186aaf9
In-Reply-To: <20181021080859.3203-1-pclouds@gmail.com>
References: <20180929191029.13994-1-pclouds@gmail.com>
 <20181021080859.3203-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This function is a callback of for_each_reflog() which will pass a ref
name as the first argument, not a path (to a reflog file).

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 revision.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/revision.c b/revision.c
index b5108b75ab..ea1d695e23 100644
--- a/revision.c
+++ b/revision.c
@@ -1278,13 +1278,14 @@ static int handle_one_reflog_ent(struct object_id *ooid, struct object_id *noid,
 	return 0;
 }
 
-static int handle_one_reflog(const char *path, const struct object_id *oid,
+static int handle_one_reflog(const char *refname,
+			     const struct object_id *oid,
 			     int flag, void *cb_data)
 {
 	struct all_refs_cb *cb = cb_data;
 	cb->warned_bad_reflog = 0;
-	cb->name_for_errormsg = path;
-	refs_for_each_reflog_ent(cb->refs, path,
+	cb->name_for_errormsg = refname;
+	refs_for_each_reflog_ent(cb->refs, refname,
 				 handle_one_reflog_ent, cb_data);
 	return 0;
 }
-- 
2.19.1.647.g708186aaf9

