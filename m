Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 19EA720450
	for <e@80x24.org>; Thu,  2 Nov 2017 06:53:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752040AbdKBGxF (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Nov 2017 02:53:05 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:57064 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751748AbdKBGxD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Nov 2017 02:53:03 -0400
Received: by mail-pf0-f194.google.com with SMTP id b85so3875939pfj.13
        for <git@vger.kernel.org>; Wed, 01 Nov 2017 23:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4Y2lqQRd+AlpVGCjYlZDPUhiTdZdLC5VWOJzqBcNGyc=;
        b=FqHLUKk4Cra+0cGShSKI0w3ETrfzN+U2YCbpsuoj1YHfXosuKTCcFElrR98LprZfbL
         Ry/lk0KGDmRr0l+pL8cqPA8STtNx8LnKXRn1frkRZWWa75tqrOonbWnVcVlzc1HMPRcX
         BzSmn2a++7MzeBBvzXCbAOdiHS17i8h4DOaE5upXSABQdhuf0jd6+UwHlRmXl5bSGkwN
         ADDEmpPVI0/yr7LqVcO1+F5kGbyfnhGQ6T7LW1RcMcPPi676tI/+cLRBGCgU3f8bp5aa
         6+wf/rFWvnXohHolFWZIxgi2Gxbt/r+qezXXsU567QhMRRTOGiMWDXiVGAzrrLyuGH9W
         pCqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4Y2lqQRd+AlpVGCjYlZDPUhiTdZdLC5VWOJzqBcNGyc=;
        b=uCrmz5KrwsOhIi3O1WQWsF53VjaRffLNZ95CmsEUAW+Vg7HspPWtZLGwv2FEIpG+9f
         LdEa+hlJ03X5GzVVS7o9YqejOaWspvv74r8hUxaJbIk1LtxA0kDx9d2cNBufIf2hbcZx
         L6qISzRjYVN30dlsZikj0LvZX+vOW3WEhO4JQqHafxNWZF/ll9Tzg1O1DKoeJyKuU0RA
         T23JY41+2MoLLNGPK1dv0Gpd6YWYv76SYWeHtaVc9qeHWgTXtguVI92gknpO8x63Qg7F
         xIKqDwVdF6oM98yNcuJFG9pb8UHxp2eZ4fliAxC0OqkWex2o3EIDAZjlM0UgpjqdahaX
         66tQ==
X-Gm-Message-State: AMCzsaW/yR5pfqRvbASpU4cDN9PpeFnp4rZKBBbBRjtsK2JLeFsOdcDm
        uWmNK1Lb1+qSeiDSbSE1gxSBcnVF1i0=
X-Google-Smtp-Source: ABhQp+TdCq4fYF6mdi7iOSxONJZziffuvpYWZmB/09JI73RrkEKzmMBYFOl4+Sq6dFB38tKTi25VaA==
X-Received: by 10.101.69.197 with SMTP id m5mr2467264pgr.200.1509605582391;
        Wed, 01 Nov 2017 23:53:02 -0700 (PDT)
Received: from localhost.localdomain ([117.245.109.9])
        by smtp.gmail.com with ESMTPSA id p4sm3879871pga.58.2017.11.01.23.52.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Nov 2017 23:53:01 -0700 (PDT)
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To:     git@vger.kernel.org
Cc:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Subject: [RFC PATCH v3 1/4] branch: improve documentation and naming of 'create_branch()'
Date:   Thu,  2 Nov 2017 12:22:39 +0530
Message-Id: <20171102065242.25299-2-kaartic.sivaraam@gmail.com>
X-Mailer: git-send-email 2.15.0.461.gf957c703b.dirty
In-Reply-To: <20171102065242.25299-1-kaartic.sivaraam@gmail.com>
References: <20171102065242.25299-1-kaartic.sivaraam@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>

The documentation for 'create_branch()' was incomplete as it didn't say
what certain parameters were used for. Further a parameter name wasn't
very communicative.

So, add missing documentation for the sake of completeness and easy
reference. Also, rename the concerned parameter to make its name more
communicative.

Signed-off-by: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
---
 branch.c | 4 ++--
 branch.h | 7 ++++++-
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/branch.c b/branch.c
index fe1e1c367..ea6e2b359 100644
--- a/branch.c
+++ b/branch.c
@@ -244,7 +244,7 @@ N_("\n"
 "\"git push -u\" to set the upstream config as you push.");
 
 void create_branch(const char *name, const char *start_name,
-		   int force, int reflog, int clobber_head,
+		   int force, int reflog, int clobber_head_ok,
 		   int quiet, enum branch_track track)
 {
 	struct commit *commit;
@@ -258,7 +258,7 @@ void create_branch(const char *name, const char *start_name,
 	if (track == BRANCH_TRACK_EXPLICIT || track == BRANCH_TRACK_OVERRIDE)
 		explicit_tracking = 1;
 
-	if ((track == BRANCH_TRACK_OVERRIDE || clobber_head)
+	if ((track == BRANCH_TRACK_OVERRIDE || clobber_head_ok)
 	    ? validate_branchname(name, &ref)
 	    : validate_new_branchname(name, &ref, force)) {
 		if (!force)
diff --git a/branch.h b/branch.h
index be5e5d130..1512b78d1 100644
--- a/branch.h
+++ b/branch.h
@@ -15,12 +15,17 @@
  *
  *   - reflog creates a reflog for the branch
  *
+ *   - clobber_head_ok allows the currently checked out (hence existing)
+ *     branch to be overwritten; without 'force', it has no effect.
+ *
+ *   - quiet suppresses tracking information
+ *
  *   - track causes the new branch to be configured to merge the remote branch
  *     that start_name is a tracking branch for (if any).
  */
 void create_branch(const char *name, const char *start_name,
 		   int force, int reflog,
-		   int clobber_head, int quiet, enum branch_track track);
+		   int clobber_head_ok, int quiet, enum branch_track track);
 
 /*
  * Check if 'name' can be a valid name for a branch; die otherwise.
-- 
2.15.0.461.gf957c703b.dirty

