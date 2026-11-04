Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793783154;
	b=F0rscsOOEQ7SPvit2jQpvZZozFKM3lIZmykC2mAqNkZGzJVGI6UIdf4Ma3QCHBjXvPvn
	 ZetQKTnbZAO537enV8uQiYrsCKDkW17t1aKfPZl5irgtFEOoCiRvCbxtdNCHagHCDVjcM
	 Xfo1AeTWqxeVMVrYA+XNlE1IsDGjv5E31WcRg+gQNSHv/Kxk89F+maV/cW31cSFrKeVvk
	 G51KBSJt4QM1qQ/gfENXThlMDGf2XdR5Rp/fzElnp+fQKImTawOD/XWl9excVG7nVj8Oc
	 GE+3rU2OY2sk1RQ2Pjpcxggc9dhknoVWVR4jehi5tn/FRudgerK3yAn7RMX95GPkGDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793783154;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=tFiwf8xTC7tS9DZnCav6+sF4ZC0Mv6IbbLPnL5xYO3I=;
	b=CZTObtpRZp0n3tjrZKdYg8yg4+v7OtXj9NOkpS4d2acDmrzwW/2YxufdhZWRdLvRo8iX
	 tVuBEgeLwPMS8a7VSDtCsmsQ4YfibVQildSRQeObXVpdhNDzXazuG69N4IoP/Uz5omfOn
	 7NdCG0dXA4AvmRlYB/YGNSdvlJ0CCkHCj0OnzJ/tuTYVpSNQRfdoJ7R/UrGAudCq+t37M
	 GEm8Eo1oqS4wIGexbxhIWv/bA9ZV9uCoVBBnLDohxu4IMUo+RBhWvmYtHvciK+5Lys+Ct
	 KSujz2uTaPMfDvO2Rvy1QbXIlzoeBf6ZqIT5rPHdwkjJvBPe1/cQxuZEFG5xm7h/ceA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cIAziDmR;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA99606A330
	for <git@vger.kernel.org>; Wed,  4 Nov 2026 09:05:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EFA99606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cIAziDmR
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a2069b9710so3382235e9.2
        for <git@vger.kernel.org>; Wed, 04 Nov 2026 01:05:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793783152; x=1794387952; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tFiwf8xTC7tS9DZnCav6+sF4ZC0Mv6IbbLPnL5xYO3I=;
        b=cIAziDmR/s5ZXcxKJIeJXAZnG7mRlLY5L1KDBeuK4CnG3W9WgXD5HV6RfdrUMsM6HP
         MJs5Gat8SzhZHD0xRgnb3AkKcbJvEPzFw+CMIXRoUNh9rc/HBHtPvrHe90AdeplYpavb
         tOFHYOFoGsjcr8awWHd9yV5llcXRCU7U7XFG24uc1MCWY0eyYUG/UkDft6d5ZKjUIaaf
         /fG6QaIBln5amBO6Spop3l6IdtNGMctUrxhV7TqQLD60zyE6cD2ZuU823zw9n3D94kH6
         tGOeYeYR3BaOGae77cIXBCaqHWKWuZPZyRhBm1igoxOUNqr5PlzeVNdS23CJG6fCrIwe
         I68A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793783152; x=1794387952;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tFiwf8xTC7tS9DZnCav6+sF4ZC0Mv6IbbLPnL5xYO3I=;
        b=fseu2eUuNdEceoXPb4eOR69gHTjy6Dgeuejsss0+odeApfBHRbdg0ZvABDrk4R2lBT
         2dIYEDyln8rkDuviBUquU3DnzoLh8aS0rjFPrIRyzeUR0UuYZSMOJRPwqpmG5eAkcfPc
         qpCLpzXgCFDHXWoOa7CawP+KYQXcAnRFuBh6GPJI5L2nQe0Kk1LVaIJ6TGAE84piIsyB
         6wHTBs5kvou1y8taaedMG6Onm5aRzI4hJrAAhFW9W+S/tDOPkHa+1KmlnbBWlyKK/ngi
         RjZABTdnE0HjsQFOzORZsPgE8Getmxb78BATvrzL7xvdAtRMvcswgFKuz2e19dQbzpxM
         GbCA==
X-Gm-Message-State: APuU4Z9+XWIJLHzfQhlNUss3kjBikJzT3c0u2s4statNG18IQquA8WAR
	DF4XlDC3+A0VTJ4SR3t3wAmuWwM19Ea89bdJ6hWePJBntXEXtQ9reR+3Zi7Sm7bxwjA=
X-Gm-Gg: AYBFou1f8gPZQyaEwRsYn1jqWzLm2Zz0ZkDJAI5Hb5SrBB9lBoXnERYMAej7WJl5ZNk
	6upVWU1HJY7MkU6TB2b9rBngy2tnFrAQiWuWx6V9TQ+zGYmlL7epGocE5NVnenSNtOAk9bp00gb
	6/vaOyLgwk+ipqCHpQQRDjCj1JBD/9J5DYPp3SK4TctCxBuvmGfmKf0tAJ/sEhu0wtck/WgGxbv
	76I0svAeTPmupEZqfgAMHapNesNFtWypvHt1kStjolL5b8Sm7IdHiy1KcbrJoAcJfFQecxNBc3T
	QAYDlk87xZz18S2UXBPRmrOsBK48hLvJDvYMUOIp2Uk0+KXxTOkX0n9vL49lbrSVrB1j+YunI31
	+MgGJ/8hgq6FrDUh9eGf2chn0RA+xr3DtZkvhGWmt4QezJ5nQVcJfbPvWfwLBn0Wnjf10gPgRYb
	yOpPZe5X86gczUQWPhvbnCcwFlFeyWcRIKLMQobIx8k5spdMQkj/SXSUOTr57RCfiNK25K6tPS6
	bISwhSEwbLVkN1jGUSr2wUUkPS8NKXCB6F3BboatFasn9yECSSNMgJa30WIPGaZI9t/uONtnhPo
	hr6X4ESxUJGck27Fxj/uEn7TBtm5kaDqthPNUcoRURtxKsmnCb1cpuMH6NVkDjIw8rxAAPeKsJv
	Xld9VFzVEhoUjtZo1PpdEtTQejghAWrbQhJMqTtdt/PsKoigmnbXHJUdMvaHzOzRcZW50Gr6lUX
	WN3KUEaylp9XtFIbsGm94MA75czXm+NjbO1uE4W3dsAPuwo5V0/A==
X-Received: by 2002:a05:600c:a45:b0:4a1:da58:1ee with SMTP id 5b1f17b1804b1-4ac1932b43amr366049685e9.31.1793783152313;
        Wed, 04 Nov 2026 01:05:52 -0800 (PST)
Received: from localhost.localdomain ([104.28.219.97])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b2a9fafe08sm201732925e9.3.2026.11.04.01.05.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 04 Nov 2026 01:05:51 -0800 (PST)
From: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	usmanakinyemi202@gmail.com,
	siddharthasthana31@gmail.com,
	kaartic.sivaraam@gmail.com,
	Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Subject: [Outreachy PATCH v4 2/2] checkout: pass the repository to unique_tracking_name()
Date: Wed,  4 Nov 2026 10:05:34 +0100
Message-ID: <20261104090534.21838-3-okhuomonajayi54@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261104090534.21838-1-okhuomonajayi54@gmail.com>
References: <20261023211533.73433-1-okhuomonajayi54@gmail.com>
 <20261104090534.21838-1-okhuomonajayi54@gmail.com>
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
the object lookup, and use repo_for_each_remote() so the
remotes are also read from that repository. Update the three
callers to pass the_repository.

This removes the need for USE_THE_REPOSITORY_VARIABLE in
checkout.c.

Signed-off-by: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
---
 builtin/checkout.c |  3 ++-
 builtin/worktree.c |  6 ++++--
 checkout.c         | 13 +++++++------
 checkout.h         |  4 +++-
 4 files changed, 16 insertions(+), 10 deletions(-)

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
index a0d0229435..8a4812df8d 100644
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
@@ -51,21 +50,23 @@ static int check_tracking_name(struct remote *remote, void *cb_data)
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
-	for_each_remote(check_tracking_name, &cb_data);
+	repo_for_each_remote(repo, check_tracking_name, &cb_data);
 	if (dwim_remotes_matched)
 		*dwim_remotes_matched = cb_data.num_matches;
 	free(cb_data.src_ref);
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
-- 
2.56.0

