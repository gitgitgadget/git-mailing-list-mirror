Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 241012089D
	for <e@80x24.org>; Sun, 30 Jul 2017 11:58:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750988AbdG3L64 (ORCPT <rfc822;e@80x24.org>);
        Sun, 30 Jul 2017 07:58:56 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:33185 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750817AbdG3L6z (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Jul 2017 07:58:55 -0400
Received: by mail-pg0-f68.google.com with SMTP id u185so5623021pgb.0
        for <git@vger.kernel.org>; Sun, 30 Jul 2017 04:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iVanjFxGopAe0ond991MxGPrgeJUx6Sq2R1veyIuYmQ=;
        b=t+aLJD/tTjAuZZMd+pQTevZf6AxlV8bAbSGJTDY40RqWak920QciQrrKFNl08byv+8
         e0VQVZe0zRzOgq5Tf7ezDtrb6/NVNiSFmXLgg0bHuyO3zSF8kNjDwSRDafgkbqJwN1Rz
         kLfTFI8xw6G1iiFlUJ/J2FONAIenWJVqS2AjpJfvxpNVCQUdg8JITxNzOjy4PqhT/heG
         /xFO5V3eJ+N9nj+dYKhENsf/l/PZQVmdtA0mIpp4jBuPegR3ok+27siuyvlhHajlYWWK
         APTJt6IjQVYAYGD5XzUjUI52EiFyz+FpB/ply65glADdTdfTrM8RPA6cM9pluT+WYSZP
         Hs2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iVanjFxGopAe0ond991MxGPrgeJUx6Sq2R1veyIuYmQ=;
        b=MtbDTm4DY4Itv8etXcFbMYTL+EAq30Ry5oRJ3evhyGLlu4VTKdRBsgdd7+MAKeegOQ
         UcA2hYanIGmLsUbXbKgR5P1DXDlOPaL66XJXRc6E4Gr02b9acRkCcn2uX20RMfvydMCm
         829V6EFxxBduqePYoFYyNvzoOnT8DXsP54d9bgAjUUob9c1iIgeRIjjcRxb6/uWoTto4
         O+Oek7une9XfqXP2gyzboY+2+iBL28451JP7IBorkhSPcfplohaSd+lrIvQRFHiR0YBJ
         MtiiRnUwMsrjyxYLnXduC5z1133gpzjiIBSu9n732roGi8nEPinWHMoERhf1WU45DWZi
         BSKg==
X-Gm-Message-State: AIVw113TZgSNisdCZCKkwvf0u9tBhRBawdLeh6+3K5FJ1Jx4+8GkaQEC
        nmZDE8GDD96Ung==
X-Received: by 10.84.198.1 with SMTP id o1mr13781053pld.33.1501415934869;
        Sun, 30 Jul 2017 04:58:54 -0700 (PDT)
Received: from localhost.localdomain ([42.111.163.163])
        by smtp.gmail.com with ESMTPSA id o4sm43688253pga.47.2017.07.30.04.58.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Jul 2017 04:58:54 -0700 (PDT)
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org
Subject: [PATCH] branch: change the error messages to be more meaningful
Date:   Sun, 30 Jul 2017 17:29:08 +0530
Message-Id: <20170730115908.13841-1-kaarticsivaraam91196@gmail.com>
X-Mailer: git-send-email 2.14.0.rc1.434.g6eded367a
In-Reply-To: <0102015d7b021c6c-8741d523-c7d7-4be5-923a-cd4a925842a0-000000@eu-west-1.amazonses.com>
References: <0102015d7b021c6c-8741d523-c7d7-4be5-923a-cd4a925842a0-000000@eu-west-1.amazonses.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The error messages shown when the branch command is misused
by supplying it wrong number of parameters wasn't meaningful.
That's because it used the the phrase "too many branches"
assuming all parameters to be "valid" branch names. It's not
always the case as exemplified below,

        $ git branch
          foo
        * master

        $ git branch -m foo foo old
        fatal: too many branches for a rename operation

Change the messages to be more general thus making no assumptions
about the "parameters".

Signed-off-by: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
---
 Sending this patch to the correct thread. I apologise if this
 seems reduntant. I'm having hard time keeping up with the patch-flow
 without 'send-email'!

 builtin/branch.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index a3bd2262b..59fedf085 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -707,12 +707,12 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		else if (argc == 2)
 			rename_branch(argv[0], argv[1], rename > 1);
 		else
-			die(_("too many branches for a rename operation"));
+			die(_("too many parameters for a rename operation"));
 	} else if (new_upstream) {
 		struct branch *branch = branch_get(argv[0]);
 
 		if (argc > 1)
-			die(_("too many branches to set new upstream"));
+			die(_("too many parameters to set new upstream"));
 
 		if (!branch) {
 			if (!argc || !strcmp(argv[0], "HEAD"))
@@ -735,7 +735,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		struct strbuf buf = STRBUF_INIT;
 
 		if (argc > 1)
-			die(_("too many branches to unset upstream"));
+			die(_("too many parameters to unset upstream"));
 
 		if (!branch) {
 			if (!argc || !strcmp(argv[0], "HEAD"))
-- 
2.14.0.rc1.434.g6eded367a

