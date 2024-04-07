Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632DF3CF7E
	for <git@vger.kernel.org>; Sun,  7 Apr 2024 21:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712524881; cv=none; b=RE8v1b6pdHCdBZyMDEAuzBJY+RF2Z+3vmamHFXjiIg29mBmez1dCgkezLVte9422FGTqW716uTOuoDRknRRQQeMjY/05zfxFIgNzJVxMdjngHymU/rg75EYn0oQg3JtkRVm+wVfkTvvR6N6NXCANzAEbGUZFsDCnZsdtF/s8Bto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712524881; c=relaxed/simple;
	bh=HScXwx8hpXzUJF8KA5i0XV/BQz1jMq5D3cGNcEEe+ZU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CBUeS+gS79bKyfwjdWlAIV5oXC6laN/2DWw7GCqMxE710O/7S03nmJaB3T626q++DnvzVF7zVjc5GOpliM0gY9S0ny9vSl3gAnD/hxElq/H+uh5P6PRGHEHc6yYKYkQ1tvSIos2nte3MS+l/qp2Q/iSJbqRfyG6CGG6yLKGA758=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NvKyev3U; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NvKyev3U"
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-dc25e12cc63so4338566276.0
        for <git@vger.kernel.org>; Sun, 07 Apr 2024 14:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712524878; x=1713129678; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mGk8t4MSQA3PfUL5OiePS0TRYaIr9noLdW4c3m+3v+w=;
        b=NvKyev3URy1knzpWQGAZ3pUgzyp6EkhessFLNeSnQOmeURq6pQmQsJRPh0GTvH4V+Z
         WG5EoceJMbn2BI43KLZcyX5CbIsB3DAAqCPhX4/nlbiY/UiSivmp0LaR3eIlGgLjPx+s
         iyqmkP7EAwkKE7ht4lf4s/LN7vrjNEZ2UHBfTX+ZPLZUEOe3ECotq6RMWmz/EH9M40y3
         rtr4x9LPTQJwd5CFRcgW8NYxGEhkpo5Ra5G1fMGSO6ZLn29QSiR4kynbJWvxX4UZaqpI
         CJ0BieeWXdqMt4DTCb52bpGZqVLHDniXzraqHiRxzuVapfWhnoV4LZpfCU2Vnhn1okjt
         elsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712524878; x=1713129678;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mGk8t4MSQA3PfUL5OiePS0TRYaIr9noLdW4c3m+3v+w=;
        b=rBUITf0TqIx+T/s+JTn8R7P6fwo6B4xkiDbXowh3byd4ZiMhMWobYB7bauNJsc+8n3
         TELiTRJiAAoIZYxWile8Tul6bCGYuh7YdPKvgyG+ix7jrguckPCN6BILXq3NiaCF4hv0
         ChE3LkohNYhmmdI0xN7K4Ccboe1OXnBjjRNic0vY5cbihUQgjmpnCEun81sdGyaA0DvZ
         0IDmu69cBTrlYqZeDRZhoCVLUFawK+DXhIHEBG/jpUb2mWlgiIdfSCcxLjwQrQuwhklz
         IzA+9VuUAVlnF1ji0Q8rejfXLzCJ2hOZICIcZAhUlwi6kmTvzlcG9jNGvPSmvMdXIeX9
         XDuQ==
X-Gm-Message-State: AOJu0Yyto8yzD53K4MkZuE0tRfRpCbbWrkSXeHVX0poiMTOFKIx8lM0j
	90/I6bukOB45t8aj1HT9gQzEiijwshAKRcj3DzSDPIXRKt756Z0+v5L+HX5n
X-Google-Smtp-Source: AGHT+IE/1Pl5KeurGLENN+Sq0mldL4bzzk03lsd9tkONPy8OR4Av7hUuJDwx9gbutQGLYJRnYE4gIg==
X-Received: by 2002:a25:680a:0:b0:dc6:16b7:7d6f with SMTP id d10-20020a25680a000000b00dc616b77d6fmr4977904ybc.10.1712524878223;
        Sun, 07 Apr 2024 14:21:18 -0700 (PDT)
Received: from localhost.localdomain (35.91.249.216.dyn.smithville.net. [216.249.91.35])
        by smtp.gmail.com with ESMTPSA id 63-20020a251642000000b00dcf27be1d1bsm1182908ybw.28.2024.04.07.14.21.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Apr 2024 14:21:17 -0700 (PDT)
From: Pi Fisher <pi.l.d.fisher@gmail.com>
X-Google-Original-From: Pi Fisher <Pi.L.D.Fisher@gmail.com>
To: git@vger.kernel.org
Cc: glencbz@gmail.com,
	Pi Fisher <Pi.L.D.Fisher@gmail.com>
Subject: [PATCH] typo: Replace 'commitish' with 'committish'
Date: Sun,  7 Apr 2024 17:21:08 -0400
Message-ID: <20240407212111.55362-1-Pi.L.D.Fisher@gmail.com>
X-Mailer: git-send-email 2.44.0.501.g19981daefd
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Across only three files, comments and a single function name used
'commitish' rather than 'commit-ish' or 'committish' as the spelling.
The git glossary accepts a hyphen or a double-t, but not a single-t.
Despite the typo in a translation file, none of the typos appear in
user-visible locations.

Signed-off-by: Pi Fisher <Pi.L.D.Fisher@gmail.com>
---
The function name was renamed to use 'committish', preferring to avoid a
hyphenated word. Comments referencing this function were rewritten to
match the new name. In the translation file, 'commit-ish' appeared
multiple times, but 'committish' appeared only once, so I changed the
comment to match the more popular option.

 branch.c | 10 +++++-----
 branch.h | 14 +++++++-------
 po/tr.po |  2 +-
 3 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/branch.c b/branch.c
index 6719a181bd..b8f8fd4979 100644
--- a/branch.c
+++ b/branch.c
@@ -734,7 +734,7 @@ static int submodule_create_branch(struct repository *r,
 }
 
 void create_branches_recursively(struct repository *r, const char *name,
-				 const char *start_commitish,
+				 const char *start_committish,
 				 const char *tracking_name, int force,
 				 int reflog, int quiet, enum branch_track track,
 				 int dry_run)
@@ -744,8 +744,8 @@ void create_branches_recursively(struct repository *r, const char *name,
 	struct object_id super_oid;
 	struct submodule_entry_list submodule_entry_list;
 
-	/* Perform dwim on start_commitish to get super_oid and branch_point. */
-	dwim_branch_start(r, start_commitish, BRANCH_TRACK_NEVER,
+	/* Perform dwim on start_committish to get super_oid and branch_point. */
+	dwim_branch_start(r, start_committish, BRANCH_TRACK_NEVER,
 			  &branch_point, &super_oid);
 
 	/*
@@ -768,7 +768,7 @@ void create_branches_recursively(struct repository *r, const char *name,
 				submodule_entry_list.entries[i].submodule->name);
 			if (advice_enabled(ADVICE_SUBMODULES_NOT_UPDATED))
 				advise(_("You may try updating the submodules using 'git checkout --no-recurse-submodules %s && git submodule update --init'"),
-				       start_commitish);
+				       start_committish);
 			exit(code);
 		}
 
@@ -783,7 +783,7 @@ void create_branches_recursively(struct repository *r, const char *name,
 			    name);
 	}
 
-	create_branch(r, name, start_commitish, force, 0, reflog, quiet,
+	create_branch(r, name, start_committish, force, 0, reflog, quiet,
 		      BRANCH_TRACK_NEVER, dry_run);
 	if (dry_run)
 		return;
diff --git a/branch.h b/branch.h
index 30c01aed73..ec2f35fda4 100644
--- a/branch.h
+++ b/branch.h
@@ -78,26 +78,26 @@ void create_branch(struct repository *r,
  * those of create_branch() except for start_name, which is represented
  * by two different parameters:
  *
- * - start_commitish is the commit-ish, in repository r, that determines
+ * - start_committish is the commit-ish, in repository r, that determines
  *   which commits the branches will point to. The superproject branch
- *   will point to the commit of start_commitish and the submodule
- *   branches will point to the gitlink commit oids in start_commitish's
+ *   will point to the commit of start_committish and the submodule
+ *   branches will point to the gitlink commit oids in start_committish's
  *   tree.
  *
  * - tracking_name is the name of the ref, in repository r, that will be
  *   used to set up tracking information. This value is propagated to
  *   all submodules, which will evaluate the ref using their own ref
- *   stores. If NULL, this defaults to start_commitish.
+ *   stores. If NULL, this defaults to start_committish.
  *
- * When this function is called on the superproject, start_commitish
+ * When this function is called on the superproject, start_committish
  * can be any user-provided ref and tracking_name can be NULL (similar
  * to create_branches()). But when recursing through submodules,
- * start_commitish is the plain gitlink commit oid. Since the oid cannot
+ * start_committish is the plain gitlink commit oid. Since the oid cannot
  * be used for tracking information, tracking_name is propagated and
  * used for tracking instead.
  */
 void create_branches_recursively(struct repository *r, const char *name,
-				 const char *start_commitish,
+				 const char *start_committish,
 				 const char *tracking_name, int force,
 				 int reflog, int quiet, enum branch_track track,
 				 int dry_run);
diff --git a/po/tr.po b/po/tr.po
index 19d6661bbe..5837752d0b 100644
--- a/po/tr.po
+++ b/po/tr.po
@@ -20,7 +20,7 @@
 # clone                       | klon(lamak)                 #
 # commit (ad)                 | işleme                      #
 # commit (eyl.)               | işlemek                     #
-# commitish                   | işlememsi                   #
+# commit-ish                  | işlememsi                   #
 # conflict                    | çakışma                     #
 # cruft                       | süprüntü                    #
 # dangling object             | sallanan nesne              #

base-commit: 3c2a3fdc388747b9eaf4a4a4f2035c1c9ddb26d0
-- 
2.34.1

