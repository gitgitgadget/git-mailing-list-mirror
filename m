Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792790155;
	b=of+pS/jU+ClCiLb/n4Qbkt6dnKfSK4bgXIvBwxW5YO0WHOoejw/I3kOG2jxMqBfhVW6C
	 kdUKGefO5CaQWt54t+M0aRszZeNrTX1d3KgOPzCZOL2kcgS4VMjRpqRTk06NuWZZ0prRr
	 pzVSK1IM8nxPtWvPKTDSbBqSDFMXIa6z6BKiNIMU4uvafye6GxFtTT1SLiLfqiHOMeqiO
	 /KGLPCEZckJ43K4e+qdIggaBkdlCxWRUJQI2omBs2A/UwYWumZ5VSyGczGQEbGn7gFpNT
	 of7BuDrMqUpiGNfQVx9ctozx9rryUzi5uDw5lvUzyJr/gU84YhfxRTunZPMyvc3cuag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792790155;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=tFiwf8xTC7tS9DZnCav6+sF4ZC0Mv6IbbLPnL5xYO3I=;
	b=ai5OnbtRcWq2bxS+ftkJCfMkal/tzavVRp4Btm0B5ha1mv5fS1nTU2lOk3OR34sfWtX5
	 0yrKIFitS6mquCzjJot+NTDCjkWxjPWRDKhavH0nQQR3rn6EMjC0cHjY7PloukyNgWA9X
	 VTPDS9hn2n+n1ierHp7rKqmyn9XyYMMYI8JnBgxnREthJAWXir8PkaFs1Og+6APo25oPE
	 DwYMV7nXd+TEOEs+psEXLu2NATMFFj3U4Yot78c9An6s/eRYFZlrmZS2xgTy4dJ0JYJCY
	 3snodhW3Ss6n7kBxn/3uZM9kMmZ7TlIsMywtH7fau9bApLb6nsabr0L4Sxs2fy5MY3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UrtKcT3D;
	arc=none smtp.remote-ip=209.85.221.51
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC577606A320
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 21:15:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BC577606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UrtKcT3D
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-48dfc0421d9so1074239f8f.1
        for <git@vger.kernel.org>; Fri, 23 Oct 2026 14:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792790153; x=1793394953; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tFiwf8xTC7tS9DZnCav6+sF4ZC0Mv6IbbLPnL5xYO3I=;
        b=UrtKcT3DaIM6I+PV7YaiVwhmrkVDbJkl/NzIczDmgTUEQBPNILbKSfw0xlTfRpxBJ0
         JDv4ZU5ofBuIpq2Sbg3HTDqB3Pl1AmZCWrEKJPms7HYqRA4uL9xJ2AXvDH0nwZXj79f7
         YysOJYDJGTn4aToqlxltN5VRgrXP/L+dJ8Y1rkvtZKhECOEeTD8goXGQyGnPbUPvKvVJ
         DtRPos9TiNmYCgpijHDzEM6xMOvcXhjOEmKIPy3prj92gC8WMqERB1QTbm3SVajsVVxT
         1F2MNGnBR/M+TDc5NFGpB2AZUQ3T64rx94g5tgmMzpXCNoZSvkyL4lMfjex2ZYWlUa7l
         wDWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792790153; x=1793394953;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tFiwf8xTC7tS9DZnCav6+sF4ZC0Mv6IbbLPnL5xYO3I=;
        b=1sn1Jn7ZIrf4jlgWdjiIvb4n79TVf6EJ7wRJDco4kirzMARU3DQIVmEwOdSIGNbsGE
         YRUIc+AogsObXUsJf5OcvGHxfdd2N9FXBGpdJE1uL4kg4GafV2EUZIMTD5OqBWozmder
         bU5WbHv8BAOh2+JYrHMdjv/XipbGTSx4lXsq2B27n8UMy3ZdDrr/0d3CTGJDwHwqN+EJ
         2m0w+PQG1b5evmg8Y2RJEkOKVbYJ0ZBwjOtqPVDAepn4DxcHE/CF/KKnDKkad2wj86bg
         kJ8xQSY5cIaRhazNBeI8qOU9+BWeKVtdnewW6j85NlXssbYmdj7dR9IXmKWR7sz/MCe5
         49wQ==
X-Gm-Message-State: AFq9FYJdHIjJ9bMwqijMNPr8KEnMKyn0aQF6YC44QMlS0KrtvofZmk6U
	kckSq+8asfMrbuTwAtWe3bF992MVKITmCK805pHl+1dniCAgoRnXa9bnZJoGBxRxOHMkRQ==
X-Gm-Gg: AYBFou1xNyy8p4bKQ2AeHs1kQXE3kSRcVSGACMlW7MsM6anPg72VFaLdjV47aF8uHgx
	xZbCZs51JjuJpX2ztJp9KGFS1j9N0VhlbNSlYeZ14cpm+b/UglEgVPWjDyRNX6gzSK9zaByHsv0
	WRHgXtfcUD2OQDqx6PDJF+nulIQ9mCBs0G0A1M4ul3hNuRNGBIfyH1YndJsw2ZgmgUxT7SPBYL+
	rEJWSKwNAcA5nU611oYWpwyLt7NOymp5OOSIx2hjEF+0U77ZCCq1soowOZE8AjakUNWjLiMMyEy
	fIlXf7B8W7Is8bif4FCorFrPWmZn/SvuEpzdkNhwynzxfhjJb9uKamCEAsy6MDN1LvqKpG9/tvM
	VKPPXkZjkFoeh79ZNLNUD1wF5yUvTyHMQbXSgM7/6arc7KJAN3MPQGPsOUjD2Hw7dDgK6FpIlIp
	MC3Yfe8EasBQHyzkxjToas10pTHpdKERGKCQ2FoWd8YNv0FlSeUDEli6FU4rnDrNLwHbPB0mqjz
	uBSrglfYBKVpX5Ib3bYpRCuT7iSFLjCRA0Hge5mJey/g7cJ33ixXhCtCq3V0pOGxjmXoDfIt4eD
	T3X+oxyR7OqOwDGeUnQJ+6Jd3fkyc0K/zyxtvDPh2slM+pes+R2acjteDnSfNuvo0K3aoBVVIu0
	Vt+Z7M7RASKYd9ZUT5EqgdwZgoK9QBHEz0P5xsXOiWAmP0qB+1mnNUuKl
X-Received: by 2002:adf:f284:0:b0:48e:2980:d396 with SMTP id ffacd0b85a97d-48e3eb8d6a5mr252119f8f.37.1792790153002;
        Fri, 23 Oct 2026 14:15:53 -0700 (PDT)
Received: from localhost.localdomain ([102.88.167.156])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebc3bcdsm334600f8f.13.2026.10.23.14.15.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 23 Oct 2026 14:15:52 -0700 (PDT)
From: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	christian.couder@gmail.com,
	usmanakinyemi202@gmail.com,
	siddharthasthana31@gmail.com,
	kaartic.sivaraam@gmail.com,
	Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Subject: [Outreachy PATCH v3 2/2] checkout: pass the repository to unique_tracking_name()
Date: Fri, 23 Oct 2026 22:15:33 +0100
Message-ID: <20261023211533.73433-3-okhuomonajayi54@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261023211533.73433-1-okhuomonajayi54@gmail.com>
References: <20261022105641.68963-1-okhuomonajayi54@gmail.com>
 <20261023211533.73433-1-okhuomonajayi54@gmail.com>
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

