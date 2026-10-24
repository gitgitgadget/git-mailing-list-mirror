Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792833746;
	b=DdplozkqQfdfcTlZ1vE00GGapT+txYNlNMs+a4OEl9Bu/pDFmrrvHrCJbXp2yJap3Rzb
	 fD61jj9LbHcZaUo/8RnbuNnAe8q7t4LpsBzPr6UaIBcQxBUEtmuVN9p0GwbELDxKZQoCu
	 ok6kqHgLSz/7jIYZtTQDppSrLdOjJW8nsNXmh+pkURdGSUZkcWOId7UvkivjMVuTFPdE8
	 wWb0G6ME/6LzOG7CToqDlCx23F6pReoYCjkqgqqQ5lOD5eAjcX8klU6WR7XaaVWMA7tQ/
	 yfykHmnaMyvJ1PlAlu/uzeOqKWO7YQGc2oqAyyAYgDACtNiOO03hO2Y3dBlzJjXbflw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792833746;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=lcJPViDhCO/huohwR93YeIObhddxq/cBPVyjCMEFBEQ=;
	b=cekzGF4w3Ga7yliF1gJIQztZ9XzjbgWrV8+UxTS+ICqJVHlHvDr9Vdl0ixim6Ys8OhGM
	 kpo3NMBrnYa8lBgGBKOOYU/UM7Jt/ywJH43KSlmoHOMwAqFa85of4nstiKeGHCgZz34fT
	 0J3d51zDZMUdt+oRy5bq4ujs4QD7ATdixRjzpLcQozGjnDH7pgUkU0tyfkdtd5aWRBxXc
	 UUoh4ihEWtnOaQmdCmEz6L9vGCV6on28Bfd/2GUATz1bAHf4Gmu41XaYV+/ypH0tmnhdk
	 e4yNKd99H4VJCf9aj4umQilh07FSHLL7NNkHcpTPs+n8CK2PT1xq83bgU6qvwvxM8xg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jGLS+dLm;
	arc=none smtp.remote-ip=209.85.167.169
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B16606A31B
	for <git@vger.kernel.org>; Sat, 24 Oct 2026 09:22:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 49B16606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jGLS+dLm
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-53c156ba662so827179b6e.1
        for <git@vger.kernel.org>; Sat, 24 Oct 2026 02:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792833745; x=1793438545; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=lcJPViDhCO/huohwR93YeIObhddxq/cBPVyjCMEFBEQ=;
        b=jGLS+dLmb9fHcQwlPN8mEjFBN1BwknlFX5bgL02DFJsPzbMrB65KOs2x2/hE9BarcU
         IExAm4JU0v0TN8Ad6oc8gQZGw8wDBMLT3RHhhgMiWg9uVrTRgNBO2ZUaIarKsSxSFVFL
         cSGZr91XwJ6HJ4+CseiCK/PDR3RlFIP2He79WSU9oiMyHd8rePolO4G5Fe28L3Z91tMz
         pgvYrrTBKI28J3d7ctJ5ceQNr9c9AREB5l8iPgEH/xkbeZwkEflNEnGEkXSzuh62KyQo
         gjW8DW83n0gk+pt2HZRm5eya466/J6cnNl78xC9bKF2vaJ0zTcyB3xHEMf+p/faf+PFW
         V/Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792833745; x=1793438545;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lcJPViDhCO/huohwR93YeIObhddxq/cBPVyjCMEFBEQ=;
        b=JGNd3wJcw3oZPzZj4uvXcMynw3aPlN4qqOtuQ+wtG6+WrsScam0nHq69LHvFeV8y7n
         rNYgTQHIa8hJoUlqm+78vQDDOt/Bddh2GrXs+6amV4uobxNojKP1RBXxfaRWrJwVCihL
         W5f7ZLteQR7d61dz7+kApwSwQqKPt9J3crvS4CYHBOWkaDeiIcAmK5fvhJ9TUvRt03fu
         Rp1kxZ6Xgvhv912qqF1v8rmSTGrLLvWTnYXZbiMN2zQEm4l4JsFECgptEF6Ve/83FiSr
         L20blQG3pJq1m4Hqw2OsQ39/PMsyg3ZJaSD04PCICA32rlK5/uqmJ0F975BFlltpL/iH
         MRyg==
X-Gm-Message-State: AFq9FYKaDz0NIaFRn0DFZXQ0oRBTM6J9ZbhAMDhdIdC5HB4sa0bcAxqe
	ieW8QoyO/sH5PEFtl3zbCZ83w0BfQuiV/4iIktmJQpe+RkORF2rcRnYWQ8PYtgQ4
X-Gm-Gg: AYBFou3zg7kAn1Sdotl04lLmEg/LCBT9oT3fzsu6ny8d5ipgMpN0VTz9k3RjUoioXb9
	MJoZ4RvIbGnyLJY4RANIqG5LNiDdq2GxL/2EaEnjoi05+xJsakC7fAWGbzNNYZ5NXxnCFNWZoHL
	ger52/EFGKa9FSSlahaTeyKlNgo4HYUP3+yEPc9vCl8RQweAjJonnXlpUWsKoGQEsL9dq+4PQMI
	yqv0K70GyAZVavbKNSElWjBoeIJo6oPTliRavkWM1edcTS5Jk+4CGP/RC3F6gBct3I6UE9ETmRS
	wgB7+75PUOqaIpa7KHp+rlsvNSpPJuQDk0B7LTdmKmc+Q2mF6/8ieraYeWrflaFp7tSZ9sViY4w
	vlFL1BBGqTXLGLj/4xmVWLpJ6ZVnSz50iZ6kSUeWkTILu+zcmfoY04N90+CH6ZTe0fFKHPjWuam
	x0qpYhvmmaaJfeAvyVfsthlHbnSjdcloe08A3SSdB0eco9djbcZOI3vrG//CnZaNFgZ761LE5Ma
	TrxJyi9d3zS4oASUIG7OmRQngY29FrmQp82ecfbUsUHkCjo/tAZ4Othcg==
X-Received: by 2002:a05:6808:50a6:b0:4c3:ebb:63d6 with SMTP id 5614622812f47-55c002e9610mr940149b6e.39.1792833744994;
        Sat, 24 Oct 2026 02:22:24 -0700 (PDT)
Received: from [127.0.0.1] ([40.74.231.20])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-55c0429c56asm1066699b6e.9.2026.10.24.02.22.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 02:22:23 -0700 (PDT)
Message-Id: <pull.2266.v3.git.1792833741913.gitgitgadget@gmail.com>
In-Reply-To: <pull.2266.git.1792341073005.gitgitgadget@gmail.com>
References: <pull.2266.git.1792341073005.gitgitgadget@gmail.com>
From: "Shashank S via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 24 Oct 2026 09:22:21 +0000
Subject: [PATCH v3] prune-packed: remove USE_THE_REPOSITORY_VARIABLE
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
    Christian Couder <christian.couder@gmail.com>,
    Siddharth Asthana <siddharthasthana31@gmail.com>,
    Usman Akinyemi <usmanakinyemi202@gmail.com>,
    Junio C Hamano <gitster@pobox.com>,
    Patrick Steinhardt <ps@pks.im>,
    Shashank S <shashu8660@gmail.com>,
    Shashank S <shashu8660@gmail.com>,
    Shashank S Mogaveera <shashu8660@gmail.com>

From: Shashank S Mogaveera <shashu8660@gmail.com>

The prune_packed_objects() function uses the global
the_repository variable. To help with the libification effort,
change this function so it takes a 'struct repository' pointer
as an argument instead.

The function for_each_loose_file_in_source() uses a callback
that only takes a single 'void *data' pointer. This means we
cannot pass both the repository pointer and the 'opts' integer
at the same time. To fix this, create a new 'struct prune_data'
to hold both of them together, and update the prune_subdir() and
prune_object() callbacks to read from this new struct.

Update the builtins that call this function to pass their local 'repo'
variables. We can safely remove the UNUSED macro from them because
while 'repo' may be NULL if the command is invoked with "-h", the
call to parse_options() will give the short help and exit before the
dereference occurs.

Finally, drop the USE_THE_REPOSITORY_VARIABLE macro from
prune-packed.c.

Signed-off-by: Shashank S Mogaveera <shashu8660@gmail.com>
---
    [Outreachy] prune-packed: remove use_the_repository_variable

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2266%2Fshashu8660%2Foutreachy2-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2266/shashu8660/outreachy2-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/2266

Range-diff vs v2:

 1:  6b583e1d46 ! 1:  0b474e3433 [Outreachy Patch] prune-packed: remove USE_THE_REPOSITORY_VARIABLE
     @@ Metadata
      Author: Shashank S Mogaveera <shashu8660@gmail.com>
      
       ## Commit message ##
     -    [Outreachy Patch] prune-packed: remove USE_THE_REPOSITORY_VARIABLE
     +    prune-packed: remove USE_THE_REPOSITORY_VARIABLE
      
          The prune_packed_objects() function uses the global
          the_repository variable. To help with the libification effort,
     @@ Commit message
          to hold both of them together, and update the prune_subdir() and
          prune_object() callbacks to read from this new struct.
      
     -    Update the builtins that call this function (builtin/prune-packed.c,
     -    builtin/prune.c, and builtin/repack.c) to pass their local 'repo'
     +    Update the builtins that call this function to pass their local 'repo'
          variables. We can safely remove the UNUSED macro from them because
     -    these commands are all declared with the RUN_SETUP flag in git.c,
     -    which guarantees that the 'repo' pointer will never be NULL.
     +    while 'repo' may be NULL if the command is invoked with "-h", the
     +    call to parse_options() will give the short help and exit before the
     +    dereference occurs.
      
          Finally, drop the USE_THE_REPOSITORY_VARIABLE macro from
          prune-packed.c.
     @@ builtin/prune-packed.c: int cmd_prune_packed(int argc,
      
       ## builtin/prune.c ##
      @@ builtin/prune.c: int cmd_prune(int argc,
     - 	for_each_loose_file_in_source(repo->objects->sources,
     + 	for_each_loose_file_in_source(repo->objects->source,
       				      prune_object, prune_cruft, prune_subdir, &revs);
       
      -	prune_packed_objects(show_only ? PRUNE_PACKED_DRY_RUN : 0);
     @@ prune-packed.c
      -void prune_packed_objects(int opts)
      +void prune_packed_objects(struct repository *r, int opts)
       {
     -+	struct prune_data cb_data = {
     -+		.r = r,
     -+		.opts = opts
     -+	};
     -+
     - 	if (opts & PRUNE_PACKED_VERBOSE)
     +-	if (opts & PRUNE_PACKED_VERBOSE)
      -		progress = start_delayed_progress(the_repository,
     -+		progress = start_delayed_progress(r,
     - 						  _("Removing duplicate objects"), 256);
     +-						  _("Removing duplicate objects"), 256);
     ++    struct prune_data cb_data = {
     ++	.r = r,
     ++	.opts = opts
     ++    };
     ++
     ++    if (opts & PRUNE_PACKED_VERBOSE)
     ++	progress = start_delayed_progress(r,
     ++			  _("Removing duplicate objects"), 256);
       
     --	for_each_loose_file_in_source(the_repository->objects->sources,
     +-	for_each_loose_file_in_source(the_repository->objects->source,
      -				      prune_object, NULL, prune_subdir, &opts);
     -+	for_each_loose_file_in_source(r->objects->sources,
     -+				      prune_object, NULL, prune_subdir, &cb_data);
     ++    for_each_loose_file_in_source(r->objects->source,
     ++		      prune_object, NULL, prune_subdir, &cb_data);
       
     - 	/* Ensure we show 100% before finishing progress */
     - 	display_progress(progress, 256);
     +-	/* Ensure we show 100% before finishing progress */
     +-	display_progress(progress, 256);
     +-	stop_progress(&progress);
     ++    /* Ensure we show 100% before finishing progress */
     ++    display_progress(progress, 256);
     ++    stop_progress(&progress);
     + }
      
       ## prune-packed.h ##
      @@


 builtin/prune-packed.c |  4 ++--
 builtin/prune.c        |  2 +-
 builtin/repack.c       |  2 +-
 prune-packed.c         | 42 +++++++++++++++++++++++++-----------------
 prune-packed.h         |  4 +++-
 5 files changed, 32 insertions(+), 22 deletions(-)

diff --git a/builtin/prune-packed.c b/builtin/prune-packed.c
index 4d63f26b0a..d44e7f81d4 100644
--- a/builtin/prune-packed.c
+++ b/builtin/prune-packed.c
@@ -11,7 +11,7 @@ static const char * const prune_packed_usage[] = {
 int cmd_prune_packed(int argc,
 		     const char **argv,
 		     const char *prefix,
-		     struct repository *repo UNUSED)
+		     struct repository *repo)
 {
 	int opts = isatty(2) ? PRUNE_PACKED_VERBOSE : 0;
 	const struct option prune_packed_options[] = {
@@ -30,6 +30,6 @@ int cmd_prune_packed(int argc,
 			      prune_packed_usage,
 			      prune_packed_options);
 
-	prune_packed_objects(opts);
+	prune_packed_objects(repo, opts);
 	return 0;
 }
diff --git a/builtin/prune.c b/builtin/prune.c
index 97f4c1418b..d543c3ad2d 100644
--- a/builtin/prune.c
+++ b/builtin/prune.c
@@ -201,7 +201,7 @@ int cmd_prune(int argc,
 	for_each_loose_file_in_source(repo->objects->source,
 				      prune_object, prune_cruft, prune_subdir, &revs);
 
-	prune_packed_objects(show_only ? PRUNE_PACKED_DRY_RUN : 0);
+	prune_packed_objects(repo, show_only ? PRUNE_PACKED_DRY_RUN : 0);
 	remove_temporary_files(repo_get_object_directory(repo));
 	s = mkpathdup("%s/pack", repo_get_object_directory(repo));
 	remove_temporary_files(s);
diff --git a/builtin/repack.c b/builtin/repack.c
index 5d06872d77..585cdd3d1d 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -757,7 +757,7 @@ int cmd_repack(int argc,
 						       wrote_incremental_midx);
 		if (show_progress)
 			opts |= PRUNE_PACKED_VERBOSE;
-		prune_packed_objects(opts);
+		prune_packed_objects(repo, opts);
 
 		if (!keep_unreachable &&
 		    (!(pack_everything & LOOSEN_UNREACHABLE) ||
diff --git a/prune-packed.c b/prune-packed.c
index b6749b8d13..e02d5d7a01 100644
--- a/prune-packed.c
+++ b/prune-packed.c
@@ -1,5 +1,3 @@
-#define USE_THE_REPOSITORY_VARIABLE
-
 #include "git-compat-util.h"
 #include "gettext.h"
 #include "object-file.h"
@@ -8,42 +6,52 @@
 #include "prune-packed.h"
 #include "repository.h"
 
+struct prune_data {
+	struct repository *r;
+	int opts;
+};
+
 static struct progress *progress;
 
 static int prune_subdir(unsigned int nr, const char *path, void *data)
 {
-	int *opts = data;
+	struct prune_data *d = data;
 	display_progress(progress, nr + 1);
-	if (!(*opts & PRUNE_PACKED_DRY_RUN))
+	if (!(d->opts & PRUNE_PACKED_DRY_RUN))
 		rmdir(path);
 	return 0;
 }
 
 static int prune_object(const struct object_id *oid, const char *path,
-			 void *data)
+			void *data)
 {
-	int *opts = data;
+	struct prune_data *d = data;
 
-	if (!has_object_pack(the_repository, oid))
+	if (!has_object_pack(d->r, oid))
 		return 0;
 
-	if (*opts & PRUNE_PACKED_DRY_RUN)
+	if (d->opts & PRUNE_PACKED_DRY_RUN)
 		printf("rm -f %s\n", path);
 	else
 		unlink_or_warn(path);
 	return 0;
 }
 
-void prune_packed_objects(int opts)
+void prune_packed_objects(struct repository *r, int opts)
 {
-	if (opts & PRUNE_PACKED_VERBOSE)
-		progress = start_delayed_progress(the_repository,
-						  _("Removing duplicate objects"), 256);
+    struct prune_data cb_data = {
+	.r = r,
+	.opts = opts
+    };
+
+    if (opts & PRUNE_PACKED_VERBOSE)
+	progress = start_delayed_progress(r,
+			  _("Removing duplicate objects"), 256);
 
-	for_each_loose_file_in_source(the_repository->objects->source,
-				      prune_object, NULL, prune_subdir, &opts);
+    for_each_loose_file_in_source(r->objects->source,
+		      prune_object, NULL, prune_subdir, &cb_data);
 
-	/* Ensure we show 100% before finishing progress */
-	display_progress(progress, 256);
-	stop_progress(&progress);
+    /* Ensure we show 100% before finishing progress */
+    display_progress(progress, 256);
+    stop_progress(&progress);
 }
diff --git a/prune-packed.h b/prune-packed.h
index 936fa9df23..9ec7ff0d60 100644
--- a/prune-packed.h
+++ b/prune-packed.h
@@ -1,9 +1,11 @@
 #ifndef PRUNE_PACKED_H
 #define PRUNE_PACKED_H
 
+struct repository;
+
 #define PRUNE_PACKED_DRY_RUN 01
 #define PRUNE_PACKED_VERBOSE 02
 
-void prune_packed_objects(int);
+void prune_packed_objects(struct repository *r, int opts);
 
 #endif

base-commit: 7e34d8174dcda3435d1404c9a30bef46afe6c13e
-- 
gitgitgadget
