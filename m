Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793120345;
	b=NaJossNGEr2srCOLnicaKyyKqdfkCMnsaRl/Kka/KDneLhl6NMPZJCBR0kGdHb2tgXUx
	 fKjQOFu3CSCChp33ij23GbGfbVKQ61nke5GrB+Cy+ZUnd4G7IiPouHD4gr5JAvULuU9hh
	 9s9H3ugQPGrMXRQYFMQuw291qpNZ0fZrE78d0WVco6UR3TTbHqOLc/dzugyNjBFp0QhAP
	 5A/xRFJA4ACQEC6a97UyH5qlpDRnltp/TNNMcH7H9QM9+zBOx1yRjyCmT+iuQPNLVdNIZ
	 /b9xJlm6ySiRhusF1lo8QemtgyfTUg1m7sRbFBxJ27UvOiyVpICFS1au4C9ESQVrZ+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793120345;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=WBC1soXsJ/e1UPR9/Q301+uT7uzS35jsHHlm5AvSiOs=;
	b=lxyXsNuTxnQVkY6tQUhgu7uTu0cnsrwCk5cHdKKCRW2N6tCFBvPfOcPLerysBox9+w5D
	 05NcrImLzK2YiHrb6Rk1xPUouswa9wS2kaJq1datlz7YgLaZ5XUmSG1ymmoL/zwaum8C7
	 bTKIg41Yv/pJeK9XVa0C0X6MmOQqmCOqEkjDUPPgRrisXJwMIZQwdpvoSh/qkO67KAaeM
	 5v4t2sb00QyjUf0Iwc4x9KFYon03TH8uFMyGwFNY/S/mGzEOZmZk+/SPXmSzCdAvubvGO
	 Hjr/NnrLMvu8HkH4l3mFpukjRrDv0i7MxF7duykmmG26YRetVF2KgjsAPVlKS8AkMYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yLc+6kxc;
	arc=none smtp.remote-ip=209.85.222.177
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C5A606A31A
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 16:59:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D5C5A606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yLc+6kxc
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-93cc1ab5f6cso463994085a.0
        for <git@vger.kernel.org>; Tue, 27 Oct 2026 09:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793120344; x=1793725144; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=WBC1soXsJ/e1UPR9/Q301+uT7uzS35jsHHlm5AvSiOs=;
        b=yLc+6kxcfBTCrvlJXDD6VBosnyUXpPGIhxAItVEs/rYUJkxFzVE4w+NxNe3gmocnh+
         iGsWC+OwUjn8O6p6RfIxQT2uzI70SvVnJmfKN+uc9sWS8FtrGNxqdn+Kn8JFplE9tELC
         bbP1ZeIpC3fffcFCfYsQPRzvCKIyUKhnQQxExigMz146mt+hD/FG8RqzzSajoKpprTAv
         sRjArxxjux1XPa02ivnMglTDyi2b6bJXdFpI3RCRwQ2YVmmdavHmrXRn4OIF+LSBjBoq
         J5I47EoMViUpiQ3ONOOiA4Y9VlzDgHDGxJ4WCxbNeWw9+RFnGaWN/ppSE2QatW2fXd+5
         NvGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793120344; x=1793725144;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WBC1soXsJ/e1UPR9/Q301+uT7uzS35jsHHlm5AvSiOs=;
        b=z/wPBXIfasWCOytIRsi/15IsAQq8EObFjQ+fdL7etKDcxPy/6aHmtFT3wnq1X9Yvyh
         XkkxaPnRAT3UZNIegFEtv4ZGaGsjq9huKrZkisl36iqTY3ImMyj8zLGmWtCgR3B9HM5X
         htXYHUL2RLwORcUsKIazCn+4m3euP1jcPQGfKpIT4+2lrkjNinJXu41nsrBMtgZcZ4oT
         gXATb+uLiACjTB7Bh7plJ6oS4na4TOASYWiAcuGJE29Buvsxik03rb+ha8NVN2iCkSO8
         qPkuDN2L+Rh3sBSUmfQ7Mr6+v8MnXPiRjO8hlV/FgWo3M5dneaXyTUWQAoQOPnz/1Dkr
         sERw==
X-Gm-Message-State: AFq9FYL+DB9KxnZhiq8gFPjCVttxq3wmCFlM5MFmoDzg7Dh8UlzG8R7f
	/IWgAFiF4PVEnB9HskW9ZkeZOZt/YO4c7KEWyBGWe+pUIBpH0GnTMSG1eJlsnwAE
X-Gm-Gg: AYBFou0MTS6d7DlKar3mQlOn3fb2vF1ragJVmPURXIK7DDYeInsJn7W8QfPJZPxXrsI
	HW6hXWA+0QNk0K6//QFZVHSdgLhboGSjSG3SNoAfzF+0hNCjpnMhEp1su7tWbkIAs0MkrLKG95x
	aQffivPcyc2V0yhF+VlFNJQuFFfGJRPmm+dUA4l/InLDMUdFgjlW6Cyeh5ltCKyH5Vp+EQqTwx8
	Tx8gW1++cndMopGY8p0SnsKEnQniTpHvZu8OK2DpKtczjrdVc59pl20i7Eh8Uiv3Jaivhh0tps/
	/+f9q0apcVCTykMCbQJLibRpulpnQelhHk4deSdpEinVKfagK8wfB0ZneykkF9UVw3vwxDPFf1l
	SPKEld7OfbH7GL9lpC1Gt2c2Rxu2HqJN+NaTNDqQbFD90GpUdN+glqrM94QUzg5OSi9/cmTmnCQ
	T8m4E1qT4EmdLgG3cXYR1at5LAAXuKrB9Q2WUC4ehFMi786vLCUqhy5rkGBd08/ft5K7nvQXv5D
	ud7dGGwbHQmwa1GgpvXmo+3K9CjtfeaQNTb5j54r64OYqQcYbhnR5KOsfo=
X-Received: by 2002:a05:620a:44c1:b0:937:d6e8:59b0 with SMTP id af79cd13be357-940ef7abe53mr1597028685a.10.1793120343644;
        Tue, 27 Oct 2026 09:59:03 -0700 (PDT)
Received: from [127.0.0.1] ([57.154.218.75])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-940f0a771c9sm1020097785a.34.2026.10.27.09.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 09:59:02 -0700 (PDT)
Message-Id: <pull.2266.v4.git.1793120342393.gitgitgadget@gmail.com>
In-Reply-To: <pull.2266.git.1792341073005.gitgitgadget@gmail.com>
References: <pull.2266.git.1792341073005.gitgitgadget@gmail.com>
From: "Shashank S via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 27 Oct 2026 16:59:02 +0000
Subject: [PATCH v4] prune-packed: remove USE_THE_REPOSITORY_VARIABLE
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

Update the builtins that call this function to pass their local
`repo` parameters. As all of those builtins are declared with
`RUN_SETUP` we know that they won't execute outside a repository
and thus the repository parameter will be set. Unless the command
was invoked with "-h" to print help, but all new uses of the `repo`
variable are after a call to `parse_options()` which knows to exit
early in case it sees "-h"

Finally, drop the USE_THE_REPOSITORY_VARIABLE macro from
prune-packed.c.

Signed-off-by: Shashank S Mogaveera <shashu8660@gmail.com>
---
    [Outreachy] prune-packed: remove use_the_repository_variable

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2266%2Fshashu8660%2Foutreachy2-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2266/shashu8660/outreachy2-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/2266

Range-diff vs v3:

 1:  0b474e3433 ! 1:  66f3becea8 prune-packed: remove USE_THE_REPOSITORY_VARIABLE
     @@ Commit message
          to hold both of them together, and update the prune_subdir() and
          prune_object() callbacks to read from this new struct.
      
     -    Update the builtins that call this function to pass their local 'repo'
     -    variables. We can safely remove the UNUSED macro from them because
     -    while 'repo' may be NULL if the command is invoked with "-h", the
     -    call to parse_options() will give the short help and exit before the
     -    dereference occurs.
     +    Update the builtins that call this function to pass their local
     +    `repo` parameters. As all of those builtins are declared with
     +    `RUN_SETUP` we know that they won't execute outside a repository
     +    and thus the repository parameter will be set. Unless the command
     +    was invoked with "-h" to print help, but all new uses of the `repo`
     +    variable are after a call to `parse_options()` which knows to exit
     +    early in case it sees "-h"
      
          Finally, drop the USE_THE_REPOSITORY_VARIABLE macro from
          prune-packed.c.
     @@ prune-packed.c
      -void prune_packed_objects(int opts)
      +void prune_packed_objects(struct repository *r, int opts)
       {
     --	if (opts & PRUNE_PACKED_VERBOSE)
     --		progress = start_delayed_progress(the_repository,
     --						  _("Removing duplicate objects"), 256);
     -+    struct prune_data cb_data = {
     -+	.r = r,
     -+	.opts = opts
     -+    };
     ++	struct prune_data cb_data = {
     ++		.r = r,
     ++		.opts = opts
     ++	};
      +
     -+    if (opts & PRUNE_PACKED_VERBOSE)
     -+	progress = start_delayed_progress(r,
     -+			  _("Removing duplicate objects"), 256);
     + 	if (opts & PRUNE_PACKED_VERBOSE)
     +-		progress = start_delayed_progress(the_repository,
     ++		progress = start_delayed_progress(r,
     + 						  _("Removing duplicate objects"), 256);
       
      -	for_each_loose_file_in_source(the_repository->objects->source,
      -				      prune_object, NULL, prune_subdir, &opts);
     -+    for_each_loose_file_in_source(r->objects->source,
     -+		      prune_object, NULL, prune_subdir, &cb_data);
     ++	for_each_loose_file_in_source(r->objects->source,
     ++				      prune_object, NULL, prune_subdir, &cb_data);
       
     --	/* Ensure we show 100% before finishing progress */
     --	display_progress(progress, 256);
     --	stop_progress(&progress);
     -+    /* Ensure we show 100% before finishing progress */
     -+    display_progress(progress, 256);
     -+    stop_progress(&progress);
     - }
     + 	/* Ensure we show 100% before finishing progress */
     + 	display_progress(progress, 256);
      
       ## prune-packed.h ##
      @@


 builtin/prune-packed.c |  4 ++--
 builtin/prune.c        |  2 +-
 builtin/repack.c       |  2 +-
 prune-packed.c         | 32 ++++++++++++++++++++------------
 prune-packed.h         |  4 +++-
 5 files changed, 27 insertions(+), 17 deletions(-)

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
index b6749b8d13..00a770795f 100644
--- a/prune-packed.c
+++ b/prune-packed.c
@@ -1,5 +1,3 @@
-#define USE_THE_REPOSITORY_VARIABLE
-
 #include "git-compat-util.h"
 #include "gettext.h"
 #include "object-file.h"
@@ -8,40 +6,50 @@
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
+	struct prune_data cb_data = {
+		.r = r,
+		.opts = opts
+	};
+
 	if (opts & PRUNE_PACKED_VERBOSE)
-		progress = start_delayed_progress(the_repository,
+		progress = start_delayed_progress(r,
 						  _("Removing duplicate objects"), 256);
 
-	for_each_loose_file_in_source(the_repository->objects->source,
-				      prune_object, NULL, prune_subdir, &opts);
+	for_each_loose_file_in_source(r->objects->source,
+				      prune_object, NULL, prune_subdir, &cb_data);
 
 	/* Ensure we show 100% before finishing progress */
 	display_progress(progress, 256);
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
