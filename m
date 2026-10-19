Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792428814;
	b=Ev5Ia4/xWcHT9MWXVZyk5LX0hSRVZ+D7SELJ6sGBIUZUVRTVvCtoISl7pVxC7wsatQAg
	 agrPzAUvRdcLVXtArqW2ZRgOQaSlpUDKnFudhXH9+jsCDQp+4Zceafwfik0/mijSaCW0T
	 rhB9sUASeI3PoeXQYl+jUlC2dPpzlIjppfONp8cqCwwR0pFtUFZnQU2TB9UAsFVbQUgeX
	 TFYW6j/lozeKT2aVggEyCw7EIhvLw4rcTu26z7Vt87WmIGYlzs261230stTAHcwPED9Tb
	 eI++4XCH8W2V3kea61rA5wP3YGF9lLNHxgl/9SvFpaEgcvb0aT0l7PNNgD8Q9+MB8wQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792428814;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=Jdrp7G1fDLJPhOEfE9KrWu6VUhZ7nE8sI3rlesMUomQ=;
	b=oqCzyBWcSsALayjkVFv+ED9p2cpwYOcLLw4E9Io7dlrpZ46Z733GhfCc+kzlKLDYKEyR
	 KH9n7jVkee6XBf7kS2woytg+1Lyv9pSb7VkBW2vuuFankJ6AaTqyAecqjpohVzEQJ1avv
	 EBY9hKZzUk0DR/L9q4c1SPAZwn+EHuEkKKCOyZcozwfbSR2B7kDho+MaYjbiiIYNU7Atb
	 8IZ1d8FLOG69bY8bmGB4WGLnEFbEruxx+ocSIrfNUpaOf/r3kNoPLE/taFPHDf/9injsr
	 TqgdXa8aPKfS8Z0KBVhzcxyztED9sdiLARvl+xTaA9an6A+Io6Ml8VAIiWEfGmHFA/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=nRsPOj0H;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97847606A323
	for <git@vger.kernel.org>; Mon, 19 Oct 2026 16:53:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 97847606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=nRsPOj0H
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-3514b90bb89so6012348eec.1
        for <git@vger.kernel.org>; Mon, 19 Oct 2026 09:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792428813; x=1793033613; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Jdrp7G1fDLJPhOEfE9KrWu6VUhZ7nE8sI3rlesMUomQ=;
        b=nRsPOj0Hyrpu1B1a3Uq1T1cEX+uStWlBY2rOPhSuKlW2njXKae3oXSFGgg5yQ7FuGO
         DlqV+zuCNjuZsEAlb65wy2Rv/RjPcI6JobD7byAv3vAVJD3aV7RxvAVEbN4lvfDCMdSZ
         ZGJ2lCrNvsUj7vDxRM49vZihGnMyWsg0R+AsKd08s5KYqA2LY5rFkD9PMFN7wBrbeaDU
         JuEqxk0vYxrUAu4urXRExb3NNHCZjTiX+ixoPS9UZm2ehVLjj3zZfecrLKfVw0MZhWR3
         k5BGSMEza9jf9HUJx4l7xcDAyI9gd6qMTkMpvMGOmvCCp+2RMqeaj/LnFVq7FW2fRBCn
         Yphg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792428813; x=1793033613;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Jdrp7G1fDLJPhOEfE9KrWu6VUhZ7nE8sI3rlesMUomQ=;
        b=SGWGh0EYP1Pw73DfBLSZMkjwJ+o+CbKQF53Tlp8otf9haA50TjyQJz+daaTlH48Dsg
         XaIYapyIDi9/rpBL+vFNxq1rVtrAzx5lyLZl0XIz9GrVSaDiN3Wgm4pshhaB89uj6Ruv
         mdPb8ivV/aYqfkXRicKzr0O+2Oe821RiwaZ8P5YyhseGFWjTGa1KiIltu0NSEE4P+RP6
         mIrBTGiIIqY+QtcoKSEkZj0prmpK1Y6aXoJSA4dkVXgOAl0hsSjcd5HT3XfS9mjI4aG5
         QvAaGGuhhRbqF00RoGSqkmkQ3L0zuzNmtRvoqQAc/jSfLF4x6DXVDZBHnnE8dnx5ePyj
         39ag==
X-Gm-Message-State: AFq9FYKWtAcR+I/8xC2rx7LjpKovDE5T2+UVEVkZ6CEwt/W2b0Cor1o8
	JJVj+aaMiOotewEGkCkTrv+PwSWMcdzTHkZA3b1ierbvWMQWiThtR4+u5JHrgw==
X-Gm-Gg: AYBFou22190ZwpuH2Evlbv18IS/h9KH5GPcTKISCsOicLZBvHg+Y94Ubb1XMS1VO/MK
	8SQAfIompyonX4I0f/jZC4Fa5t5lAhC3f8ItV3q7SY2WvW95O/WXZdZz6y07HCSxGi4D1rzZl0H
	Sjg9lQ9DjIDq67uyZYI8LVyLJat9q8Zm/RFpRY+0BjX22qAssrOpU2O8a+bxjRxz9iCT4ccEaOA
	uI8GjPzCG3H2nEBGajt+z5R15Shq6WuubK2Q35VFfB+M33I0283doAWJHLyNaBOhYsKgQEz1pXT
	GXHyUC4L7FnqrAG5TT8lO1tOQW8L+KH/R6T4XssmomCVuHklHguI6RMOyQFIRJ0GLDhx3Xk8Vyp
	lO1a8OOrh8NKRyGB3hmLe0V/Xs8oInQjgFjVGqk+6otjMsUdOl37SOw5p2p7A4GAzuXkQ/vL3Xh
	9/3qbgryN4hvgsYCkzh4ylZO0u7Jg+cV8eiM/aKKpPF11inAw289M9ZtPhVkbWQUiFZArAopaoT
	rXqDTMuOaA6yksBqbuspDGiDTx6yanjvgoMBJ6qfac2h2OV2Dru9u+t7EHm2TpEvq4bDiVsokmd
	a8Y=
X-Received: by 2002:a05:693c:884f:b0:35d:4e41:d2c2 with SMTP id 5a478bee46e88-361a2c38d17mr11476646eec.33.1792428812483;
        Mon, 19 Oct 2026 09:53:32 -0700 (PDT)
Received: from [127.0.0.1] ([20.171.34.172])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36082b8573dsm33586221eec.25.2026.10.19.09.53.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 09:53:31 -0700 (PDT)
Message-Id: <pull.2266.v2.git.1792428811100.gitgitgadget@gmail.com>
In-Reply-To: <pull.2266.git.1792341073005.gitgitgadget@gmail.com>
References: <pull.2266.git.1792341073005.gitgitgadget@gmail.com>
From: "Shashank S via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 19 Oct 2026 16:53:31 +0000
Subject: [PATCH v2] [Outreachy Patch] prune-packed: remove
 USE_THE_REPOSITORY_VARIABLE
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

Update the builtins that call this function (builtin/prune-packed.c,
builtin/prune.c, and builtin/repack.c) to pass their local 'repo'
variables. We can safely remove the UNUSED macro from them because
these commands are all declared with the RUN_SETUP flag in git.c,
which guarantees that the 'repo' pointer will never be NULL.

Finally, drop the USE_THE_REPOSITORY_VARIABLE macro from
prune-packed.c.

Signed-off-by: Shashank S Mogaveera <shashu8660@gmail.com>
---
    [Outreachy PATCH] prune-packed: remove use_the_repository_variable

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2266%2Fshashu8660%2Foutreachy2-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2266/shashu8660/outreachy2-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/2266

Range-diff vs v1:

 1:  5d9ba0cf3a ! 1:  6b583e1d46 prune-packed: remove USE_THE_REPOSITORY_VARIABLE
     @@
       ## Metadata ##
     -Author: Shashank <shashu8660@gmail.com>
     +Author: Shashank S Mogaveera <shashu8660@gmail.com>
      
       ## Commit message ##
     -    prune-packed: remove USE_THE_REPOSITORY_VARIABLE
     +    [Outreachy Patch] prune-packed: remove USE_THE_REPOSITORY_VARIABLE
      
     -    Right now, the prune_packed_objects() function uses the global
     +    The prune_packed_objects() function uses the global
          the_repository variable. To help with the libification effort,
          change this function so it takes a 'struct repository' pointer
          as an argument instead.
     @@ Commit message
          prune_object() callbacks to read from this new struct.
      
          Update the builtins that call this function (builtin/prune-packed.c,
     -    builtin/prune.c, and builtin/repack.c) to pass their local `repo`
     -    variables. Because we are now actually using the 'repo'  parameter
     -    in these files, we can safely remove the UNUSED macro from them.
     +    builtin/prune.c, and builtin/repack.c) to pass their local 'repo'
     +    variables. We can safely remove the UNUSED macro from them because
     +    these commands are all declared with the RUN_SETUP flag in git.c,
     +    which guarantees that the 'repo' pointer will never be NULL.
      
     -    finally, drop the USE_THE_REPOSITORY_VARIABLE macro from
     +    Finally, drop the USE_THE_REPOSITORY_VARIABLE macro from
          prune-packed.c.
      
     -    Signed-off-by: Shashank <shashu8660@gmail.com>
     +    Signed-off-by: Shashank S Mogaveera <shashu8660@gmail.com>
      
       ## builtin/prune-packed.c ##
      @@ builtin/prune-packed.c: static const char * const prune_packed_usage[] = {


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
index a7e4678d11..4eee5a2e27 100644
--- a/builtin/prune.c
+++ b/builtin/prune.c
@@ -201,7 +201,7 @@ int cmd_prune(int argc,
 	for_each_loose_file_in_source(repo->objects->sources,
 				      prune_object, prune_cruft, prune_subdir, &revs);
 
-	prune_packed_objects(show_only ? PRUNE_PACKED_DRY_RUN : 0);
+	prune_packed_objects(repo, show_only ? PRUNE_PACKED_DRY_RUN : 0);
 	remove_temporary_files(repo_get_object_directory(repo));
 	s = mkpathdup("%s/pack", repo_get_object_directory(repo));
 	remove_temporary_files(s);
diff --git a/builtin/repack.c b/builtin/repack.c
index c4360382c1..e8970e8eb7 100644
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
index d49dc11957..a53b7031b5 100644
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
 
-	for_each_loose_file_in_source(the_repository->objects->sources,
-				      prune_object, NULL, prune_subdir, &opts);
+	for_each_loose_file_in_source(r->objects->sources,
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

base-commit: 6de20f6092dcf9bdb1c8efe03db4b70c82b423dd
-- 
gitgitgadget
