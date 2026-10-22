Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792666616;
	b=Fs8tt328acUkIaRG/xooB5Lm5cJHg5R+IfaFcXcJoOryMdjOLddHitrZ4kH97MLk9qfa
	 TmqaBEhwo1JFJUYJ+EjT915tdQDgrDcNiKp/MZGb7T1tZsgdOOlvV1i+ViG1wAJVIMCjX
	 Ky/Y6sLIMpd4WyTrap1ITlKoESvwl6hQjzLQXwz6BDkw+lQy1xuVQMyLrZU56XIdWj9T4
	 CRFlaU7Cwl2tc0s/kbGqo2c4qwJGFuvqLjvQHsqb0t8zkBwfhxErMIdRWvxPXO4PbkzR8
	 6UyFqd9dTMakrsQSgKIjyQgttD6gXbtI3mJLnz81x4+hdbrNY2ANW3yrv1NRPg3s+eQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792666616;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=qDCk/FYl30ddy6A3LXnxe0gu/F6NXB9tTdbASM87FKI=;
	b=pXsUfsvZRANvJ4/sqsMbRBWHMTIcRvPXJMQW5vpdBPa56/nlmiVPdNM9wetSqpMesApd
	 U3FO7I8N3zNc80bOlnxUm8qc43640VpYTKl3dhZEy0wNtcCKJ/4Jr7r+QqarHp2u+ZYNN
	 nwLNHXIa8CW0xzZPfkfs30jSUat4y39oXhIWZtf647TMMKIVSAVYaQrlKm0Cp8m8g5FtG
	 t939RyLIZjHzY9lexqWJonUtkXXqxl1ZpTCP50pRRW+7q2DHJqNvJZusNKM1Lg0CCT3V7
	 OSuVH6g8lTOcTQ18sqKEk8mHfY5a3VZeIpmi3JmXKTc565gzuK1UHj1CfvH/Pm2/luA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=k7ridImy;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70104606A320
	for <git@vger.kernel.org>; Thu, 22 Oct 2026 10:56:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 70104606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=k7ridImy
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a2072b9832so2868065e9.1
        for <git@vger.kernel.org>; Thu, 22 Oct 2026 03:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792666615; x=1793271415; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qDCk/FYl30ddy6A3LXnxe0gu/F6NXB9tTdbASM87FKI=;
        b=k7ridImyb0qJ1OnuSgVYJ0XPPV/6+YLOAcQEgXgMrofqWAY1c6Mj19G5kjpXyg9rp5
         vctB7EgIZpStzZRbviGLJMIuIff7cksZ3aGb/dAiXOy+XK8ESSgg7XZz0uRn4KmL6XZZ
         xhrx92HHbyqBwlaJ8bZQR7kGTESaacl5PnOLerCllp5WvDIPVOUWz8iE5m5OkSVifZah
         u5VvPjfdeGaV9DC/QgWgZyDCKoM4hAQ4QYjrLzKnCIx6CQH3zT+WHaCQhuvXPyna3Bxt
         TbyPq5JWDoEdeEasH+wkiXLVFS8IWVuLdgW/XVt8/BIBJfOvjajVjL94Jw0c6CK7fLBN
         JNuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792666615; x=1793271415;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qDCk/FYl30ddy6A3LXnxe0gu/F6NXB9tTdbASM87FKI=;
        b=OePWH+WGL50L22bsw9TJAy/VniVnYsjJERd2Fo7GLMuUZxIqnWjnP36Dl8jhdsr1M+
         AGGfrjrodnRy+nhhhzmw2lPJ1K3L/cVBETGhPvo+xQZFJECaOhny3Ipb4HU1dCbcgNtw
         bjwvsXgUUAP7sglr7nBI4LPRCaxdx/APaPfArY7ykPFEXMwh023A4XHml+4W21ino8mo
         +6vfQupgHUmI1rbKeCqE8t2BZ0POVQEcLhIPu7iCeDWjAyRYeoQqnxrqNXuiOyY4v+/C
         iOlxvfi0DqY30vAIpA6YaG3stDjefYFFL6KYFwsLKBClC1XGGXbvk9vVyplKuBsX9Onn
         8tUA==
X-Gm-Message-State: AFq9FYLyBuaGBWqdidG6gH3vmPXkgPQxxMbAaD7yC49Xi1Jwl5NQhK9z
	8rZa5YtCye7kVtTUMcFcRfaAUFly5fwTV0TVLDIQd58x/axx6+FLEuplN5rGEgFhwNMCHA==
X-Gm-Gg: AYBFou3HaFwJckW0W28/LNkmN0sJUi+AdRsQkPIBP3KD6mboWthk6byyqp2pHqD/bdz
	7+CYUl3p8TwVdv6QkOfNIybVoq45BokWDjGgOzpFM+eln2tpDcN+XXbxzZaNoObovtsLUVBEhr7
	Z8DMhbwEOs+dyLzCn0d853UcNu3do+IECB3iUdg17/6U3tqM/Z/Go/JOl1PfCvCTBbnicPzde5o
	yFTBa2Jz0MYhnU8NCNFSZCDiJxIdL2irMbaEOQLOtju01SiWQQM0PRTvapHeOf6tAylTDo4LthJ
	o6USVOD7CFURuJmwGjsOwss7eCrl23rC2lCCwTw3Y7RZgmC/fTJqEIxz3kIHzi8M/9Wu4jxEIvx
	GZvbpb/RqLSZr22fw5AlQveLxLQ4NavWFIfENSx/vULFBlYMrgYyXG+kmfoQEWdxtGh7PwaFc4l
	NOH6LsCnRxyxzxmU74BmWGnQImli7FkG1UZ/4loWegVLjI3z23qSzFdJ7NLaHBlogBU6Irl0G4V
	leqV3UWALQcfmFN/kWU/4tDpGpyQzk9kxYq0TRzaVJoU2K5/r0eTEo8vuOlF9Xwmo1ZzJkwyCRF
	KMkmuKDCYp1G90IdvG9k5MgARGEXUIfVHdaGe9n0SZ7cS6hHkbigcZiVH7AAHzmxbDgIuJrWB4u
	RQcgG9SNRlm+bEbqJKFsBawiyWPOYtNEM6RgX/++BpiWhyd3ew4mwk5U3VFKrPva4KdgL6zFwXJ
	DnVw==
X-Received: by 2002:a05:600c:34d6:b0:4a2:bbd:ea3a with SMTP id 5b1f17b1804b1-4a20bbdea84mr12963505e9.6.1792666614520;
        Thu, 22 Oct 2026 03:56:54 -0700 (PDT)
Received: from localhost.localdomain ([102.88.167.156])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1fcd2eff9sm112279575e9.4.2026.10.22.03.56.52
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 22 Oct 2026 03:56:53 -0700 (PDT)
From: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
To: git@vger.kernel.org
Cc: usmanakinyemi202@gmail.com,
	christian.couder@gmail.com,
	siddharthasthana31@gmail.com,
	kaartic.sivaraam@gmail.com,
	okhuomonajayi54@gmail.com
Subject: [Outreachy PATCH v2] checkout: pass the repository to unique_tracking_name()
Date: Thu, 22 Oct 2026 11:56:41 +0100
Message-ID: <20261022105641.68963-1-okhuomonajayi54@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261017225326.7827-1-okhuomonajayi54@gmail.com>
References: <20261017225326.7827-1-okhuomonajayi54@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

unique_tracking_name() uses the_repository to read the
"checkout.defaultRemote" configuration and look up the object
ID of a remote-tracking branch.

Pass the repository to unique_tracking_name() and through
tracking_name_data so check_tracking_name() can use it for
the object lookup. Update the three callers to pass
the_repository.

This removes the need for USE_THE_REPOSITORY_VARIABLE in
checkout.c. for_each_remote() still uses the global repository;
leave that for a separate change.

Signed-off-by: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
---
Changes since v1:
- Rewrote the commit message to name the function and say what was
  there, what changed and why, as suggested by Usman. No code changes.

 builtin/checkout.c |  3 ++-
 builtin/worktree.c |  6 ++++--
 checkout.c         | 11 ++++++-----
 checkout.h         |  4 +++-
 4 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 2d575a4f57..bad49368b9 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1389,7 +1389,8 @@ static char *parse_remote_branch(const char *arg,
 	int num_matches = 0;
 	struct string_list matched_remote_names = STRING_LIST_INIT_DUP;
 
-	char *remote = unique_tracking_name(arg, rev, &num_matches,
+	char *remote = unique_tracking_name(the_repository, arg, rev,
+					    &num_matches,
 					    &matched_remote_names);
 
 	if (remote && could_be_checkout_paths) {
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 77ecd0f71f..203456bd23 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -802,7 +802,8 @@ static char *dwim_branch(const struct add_opts *opts, const char *path, char **n
 		int num_matches = 0;
 		struct string_list matched_remote_names = STRING_LIST_INIT_DUP;
 
-		remote = unique_tracking_name(*new_branch, &oid, &num_matches,
+		remote = unique_tracking_name(the_repository, *new_branch,
+					      &oid, &num_matches,
 					      &matched_remote_names);
 		if (!remote && num_matches > 1) {
 			if (!opts->quiet &&
@@ -938,7 +939,8 @@ static int add(int ac, const char **av, const char *prefix,
 			int num_matches = 0;
 			struct string_list matched_remote_names = STRING_LIST_INIT_DUP;
 
-			remote = unique_tracking_name(branch, &oid, &num_matches,
+			remote = unique_tracking_name(the_repository, branch,
+						      &oid, &num_matches,
 						      &matched_remote_names);
 			if (remote) {
 				new_branch = branch;
diff --git a/checkout.c b/checkout.c
index a0d0229435..f0fb40d48e 100644
--- a/checkout.c
+++ b/checkout.c
@@ -1,5 +1,3 @@
-#define USE_THE_REPOSITORY_VARIABLE
-
 #include "git-compat-util.h"
 #include "object-name.h"
 #include "remote.h"
@@ -11,6 +9,7 @@
 #include "string-list.h"
 
 struct tracking_name_data {
+	struct repository *repo;
 	/* const */ char *src_ref;
 	char *dst_ref;
 	struct object_id *dst_oid;
@@ -30,7 +29,7 @@ static int check_tracking_name(struct remote *remote, void *cb_data)
 	memset(&query, 0, sizeof(struct refspec_item));
 	query.src = cb->src_ref;
 	if (remote_find_tracking(remote, &query) ||
-	    repo_get_oid(the_repository, query.dst, cb->dst_oid)) {
+	    repo_get_oid(cb->repo, query.dst, cb->dst_oid)) {
 		free(query.dst);
 		return 0;
 	}
@@ -51,17 +50,19 @@ static int check_tracking_name(struct remote *remote, void *cb_data)
 	return 0;
 }
 
-char *unique_tracking_name(const char *name, struct object_id *oid,
+char *unique_tracking_name(struct repository *repo,
+			   const char *name, struct object_id *oid,
 			   int *dwim_remotes_matched,
 			   struct string_list *dwim_remote_names)
 {
 	struct tracking_name_data cb_data = TRACKING_NAME_DATA_INIT;
 	const char *default_remote = NULL;
 
-	if (!repo_config_get_string_tmp(the_repository,
+	if (!repo_config_get_string_tmp(repo,
 					"checkout.defaultremote",
 					&default_remote))
 		cb_data.default_remote = default_remote;
+	cb_data.repo = repo;
 	cb_data.src_ref = xstrfmt("refs/heads/%s", name);
 	cb_data.dst_oid = oid;
 	cb_data.remote_names = dwim_remote_names;
diff --git a/checkout.h b/checkout.h
index 0b185a0fc9..25fe7dfb7c 100644
--- a/checkout.h
+++ b/checkout.h
@@ -3,6 +3,7 @@
 
 #include "hash.h"
 
+struct repository;
 struct string_list;
 
 /*
@@ -10,7 +11,8 @@ struct string_list;
  * tracking branch.  Return the name of the remote if such a branch
  * exists, NULL otherwise.
  */
-char *unique_tracking_name(const char *name,
+char *unique_tracking_name(struct repository *repo,
+			   const char *name,
 			   struct object_id *oid,
 			   int *dwim_remotes_matched,
 			   struct string_list *dwim_remote_names);

base-commit: c51408889c3b372814bc20b9431c3b74d0d268eb
-- 
2.56.0

