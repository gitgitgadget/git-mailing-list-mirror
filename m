Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 77E721F576
	for <e@80x24.org>; Wed, 31 Jan 2018 11:06:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753499AbeAaLGi (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jan 2018 06:06:38 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:39674 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752373AbeAaLGh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jan 2018 06:06:37 -0500
Received: by mail-pf0-f194.google.com with SMTP id e11so12235978pff.6
        for <git@vger.kernel.org>; Wed, 31 Jan 2018 03:06:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+dQdL8E6TJ+yeFxzaeeXt1xZ3uAetp7B+68IHzR3IE0=;
        b=CMyRUWDoDuLh5h1NYbkJ1o/anr7dnC/TqFtBbL8dT35RWnxr/sZMetKCSWn3pHfcmq
         XagL6zmK4DhCWjl0Bj5b2OkJ4q5JZX0XxCJexzaJzG0c7IPZY/18tcTyUeNUzX03g5ty
         J3OIOKFp7RZtJP8WwGmS/2VH1mT3YXm5S+H0vMG6Y27rEnf71fB3xGmJFt0ekZvPVHXQ
         D7sta6+hh4qUz5QWCweDs+DEfpjS7nS3Pur2l5eZsOIQXuQm2FPXydg3vgFn1y+64rN+
         ea3gPDG23PbZrarrYoCs2EYAjhE7rHxeYuK9lvdhMxpeRXIZmccYR/AFD8YWka43BpVi
         qyHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+dQdL8E6TJ+yeFxzaeeXt1xZ3uAetp7B+68IHzR3IE0=;
        b=oOWL3vdmeKdi0ThYoOZm7eEk126K/B20j/5YC/MyhZvFvw/O9oy31EWwPrliI8o47f
         vqUidUSEd9d1DU99gny8jh35myBbwePGUHgRuICJnG0Z6IqolHx7gA1/5HH3RQPbHmPR
         XYVmJBV4EF7EZi4cIOD0fly7e0JDodm0irfUFlW6vOg8AYvhWpDQAX13sFIgDehVE0HS
         U60U+rt5SEHb4vQjQRpxO+8EJnGyF0o4cXP2B7csrC2cxMgQyfITh6pzPXe0nnX5sT2T
         uQLv5xaIU4eVpUm++4F/oQedLGs7hoj7tapkvWVUCwDhVLFAneUZp+RLN6qOTARVnJwX
         a9aA==
X-Gm-Message-State: AKwxytcSdOv4P94fHunEEBCxKi4hA73TltFsyLtRY8jl8w9k2GevJZx7
        5LUURR1XV6QmtMDmBojoTwX9HQ==
X-Google-Smtp-Source: AH8x2264yO0efEJZPHPSB0qHkxoZi3yXsWTK9FGkOgy3oqeJ0MZ0gNAUAVnP1RUlhpr2wbU0PIGTLQ==
X-Received: by 10.99.7.14 with SMTP id 14mr26293665pgh.68.1517396796858;
        Wed, 31 Jan 2018 03:06:36 -0800 (PST)
Received: from ash ([171.232.97.171])
        by smtp.gmail.com with ESMTPSA id o7sm21774809pgp.18.2018.01.31.03.06.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jan 2018 03:06:36 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Wed, 31 Jan 2018 18:06:33 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 08/41] completion: use __gitcomp_builtin in _git_branch
Date:   Wed, 31 Jan 2018 18:05:14 +0700
Message-Id: <20180131110547.20577-9-pclouds@gmail.com>
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

The new completable options are:

--all
--create-reflog
--format=
--ignore-case
--quiet

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/branch.c                       | 2 +-
 contrib/completion/git-completion.bash | 8 ++------
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index b5b62c08ba..6d0cea9d4b 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -615,7 +615,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		OPT_BOOL('l', "create-reflog", &reflog, N_("create the branch's reflog")),
 		OPT_BOOL(0, "edit-description", &edit_description,
 			 N_("edit the description for the branch")),
-		OPT__FORCE(&force, N_("force creation, move/rename, deletion"), 0),
+		OPT__FORCE(&force, N_("force creation, move/rename, deletion"), PARSE_OPT_NOCOMPLETE),
 		OPT_MERGED(&filter, N_("print only branches that are merged")),
 		OPT_NO_MERGED(&filter, N_("print only branches that are not merged")),
 		OPT_COLUMN(0, "column", &colopts, N_("list branches in columns")),
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 6f763c524e..4a2858f09c 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1209,12 +1209,8 @@ _git_branch ()
 		__git_complete_refs --cur="${cur##--set-upstream-to=}"
 		;;
 	--*)
-		__gitcomp "
-			--color --no-color --verbose --abbrev= --no-abbrev
-			--track --no-track --contains --no-contains --merged --no-merged
-			--set-upstream-to= --edit-description --list
-			--unset-upstream --delete --move --copy --remotes
-			--column --no-column --sort= --points-at
+		__gitcomp_builtin branch "--no-color --no-abbrev
+			--no-track --no-column
 			"
 		;;
 	*)
-- 
2.16.1.205.g271f633410

