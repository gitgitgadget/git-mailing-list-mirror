Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A14E920281
	for <e@80x24.org>; Mon, 25 Sep 2017 08:20:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934118AbdIYIUp (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Sep 2017 04:20:45 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33168 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933996AbdIYIUl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2017 04:20:41 -0400
Received: by mail-pf0-f195.google.com with SMTP id h4so3329029pfk.0
        for <git@vger.kernel.org>; Mon, 25 Sep 2017 01:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2HnUJxdlkyOrwW1gCoWpocM9D4hSYZtw+9KPReTKYQc=;
        b=YSooRfkoqbE/826EmNlc9NtgOFxpKzc3zrfYE9OXIAl+0pRlH3uAZcdYvgvKVtTNM8
         uBpDDBzitAY2502OsbC1ur+Qcc4ihstm1kNnayJ0vvS1pfK3oc7ddq5C8gkjSWnQ0aCv
         LtJRQ86uBawoA5rrYKnfpq2ydNGjHrOvptg31ZcbKkywC/lP6FKabce+VdPqdalfRWdP
         hyI3viaKI2r2kT9gYLUuLIpfZ6snvO1t1cD6AccdDn4zs0YN2aaFynavbs1aMiV0YfRS
         EgqqQq4hlkxA1gfHCJea13tqe5iyVQHsQzhkZz5hWGs7gjNgESCo+q8+HziCmSu99yUe
         C53A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2HnUJxdlkyOrwW1gCoWpocM9D4hSYZtw+9KPReTKYQc=;
        b=AL87wq+4UmVqc9yTTwyZq1BRPe/6HKiZOZUXu+kt8I4bWpZiiSL09iDBOEihUMpzEf
         QHtGHa4lgpXU/gfqZcXITBpvuqlLXIFlqEhC7cMQmKMb+xnur9EuZNRQmy1+M+WYXzAF
         leHz+MVe/xsgIPXfc9LfsnDc/3S+6Lx+LIzOAAOFjpOHz7qM542Opa7tdKR8WeaKP84K
         6w+KPIm6+qCCm0Vp13RbTB1eT807PUr/DX0xMmosiU/cJXg55E8hA99cgWKraG2lYQYn
         B99ubi9DpkLW0Ynm961Cnoz2WT6p97K08QTuxEZj58EuflXAxMpniGCAH8UYkjOa1AtE
         amIg==
X-Gm-Message-State: AHPjjUh6dAYQ2QM9kiuN+tqG9NtdEF+Z+MgIWNy4WbexiXmGCr295Gu1
        U/kXEGu1HUv/j4CiCCBwdPZATZkoJBaAKQ==
X-Google-Smtp-Source: AOwi7QDnQDCwpdpQH//iTDg33lf1eMJx8FF9TNEs5/OZNunaH5RD5T7ma0k1EvLt+hxXZKTP/fsx7A==
X-Received: by 10.101.77.137 with SMTP id p9mr7047295pgq.88.1506327641231;
        Mon, 25 Sep 2017 01:20:41 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:700a:bb87:18d5:bb83:9cfe:b5d3])
        by smtp.gmail.com with ESMTPSA id g16sm11469444pfd.6.2017.09.25.01.20.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Sep 2017 01:20:40 -0700 (PDT)
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
X-Google-Original-From: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, sbeller@google.com
Subject: [RFC PATCH v2 1/5] branch: improve documentation and naming of certain parameters
Date:   Mon, 25 Sep 2017 13:50:20 +0530
Message-Id: <20170925082024.2691-2-kaarticsivaraam91196@gmail.com>
X-Mailer: git-send-email 2.14.1.935.ge2b2bcd8a
In-Reply-To: <20170925082024.2691-1-kaarticsivaraam91196@gmail.com>
References: <20170919071525.9404-1-kaarticsivaraam91196@gmail.com>
 <20170925082024.2691-1-kaarticsivaraam91196@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Documentation for a certain function was incomplete as it didn't say
what certain parameters were used for. Further a parameter name wasn't
very communicative.

So, add missing documentation for the sake of completeness and easy
reference. Also, rename the concerned parameter to make it's name more
communicative.

Signed-off-by: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
---
 branch.c | 4 ++--
 branch.h | 7 ++++++-
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/branch.c b/branch.c
index 703ded69c..8d4360aa5 100644
--- a/branch.c
+++ b/branch.c
@@ -229,7 +229,7 @@ N_("\n"
 "\"git push -u\" to set the upstream config as you push.");
 
 void create_branch(const char *name, const char *start_name,
-		   int force, int reflog, int clobber_head,
+		   int force, int reflog, int clobber_head_ok,
 		   int quiet, enum branch_track track)
 {
 	struct commit *commit;
@@ -245,7 +245,7 @@ void create_branch(const char *name, const char *start_name,
 
 	if (validate_new_branchname(name, &ref, force,
 				    track == BRANCH_TRACK_OVERRIDE ||
-				    clobber_head)) {
+				    clobber_head_ok)) {
 		if (!force)
 			dont_change_ref = 1;
 		else
diff --git a/branch.h b/branch.h
index b07788558..cb6411f84 100644
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
  * Validates that the requested branch may be created, returning the
-- 
2.14.1.935.ge2b2bcd8a

