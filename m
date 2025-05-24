Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD6C1A314F
	for <git@vger.kernel.org>; Sat, 24 May 2025 07:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748071895; cv=none; b=tHbDwnbtQipfLefkmg6mju6194lv5tv8xhvTJMxvJdywLM0xDQOvUw5QaXH1BYlQ7r7MLIXeZ7Tom2nbmFgvRb6UC/B1V/juKPEnktk3uoz2FGMxDpq4S2btgm2Cs+gtoEkuBE+h9dwkHa02mqGHaCtIe7OeLpaRG2RSiw+775o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748071895; c=relaxed/simple;
	bh=q8Akl121jmS7kRg2XglobppyvbiAT8s3aasTDTjXw8A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rpqTVp96yzsdJCM8u5AC1y5Dgsp6r7FkwPrAmnror1UYsp7njmWX5X9QhwamvCEa2NyavgeBZaj3NFhSh/3P+N43tmpGXciZI3tJ390hs+yQI/tjwEV2ETyrXXJ7RFCnHjQSQ085izcuxFWnVYCw5KYbywflbWlLDBF3L5Pelgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g0mui2V9; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g0mui2V9"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2341d29c3bcso1297825ad.0
        for <git@vger.kernel.org>; Sat, 24 May 2025 00:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748071893; x=1748676693; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zn4c4PCmDJMUg85HGnleFtljhV+IX89IZGFP+BD/+28=;
        b=g0mui2V9YtEqHpzJZ87QMsNcDOhfn4A5Hfa3brQTgvfW6d9hyb/J6Zp0j6luEl5jSu
         5UWlO6FZiAqhOoKsU/ib8cbs4UKwXMWE8PiTwg5R6O7i1SjFNmIvGp+Y9A7TWJkepBT1
         Nx9acSD7Pt22zaP0hFNG8wZViUJ35BXckKHS5/EDIliEMI5xxHkjr6dYGSk3ypMheq93
         YfV3dg8Ui5p2G0XLGjLz45a0RnOOVXVWWkRzBeWsgWVP1Mn6wYMbfVy6UvbXkweV4ZNq
         xxCWgYOCzxAVAcv/d84OLqarsyECFtg8HAkdc0bSCmNEep2O3Sx0xwWK0JBiBTmER3d0
         F5XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748071893; x=1748676693;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zn4c4PCmDJMUg85HGnleFtljhV+IX89IZGFP+BD/+28=;
        b=U7eC/rgB3VaiSW1l3R/LhVWZy5EbkY9t6ffXrSpnIyHxJ2SFDaNkCL/dXcrcZMPWPi
         7pWsjZQyqc/zLDCK3uFm6jd8D1gPR4+EAysn00pcFtLiK5w/pYciOtFfQvvK48BHRAiI
         vkJoI4yxyDS054IL7J99yGInNi0j9N3e60XItuKonzi/qu0yDN/MKIYq6GdryI+VtOxM
         RRJskGZnLpmDakk2O1khyVCORiXczHN7z8krg0CGmngqPb/eQzUvvi562LRrf1m3F2DH
         esizKhvahS7XBvp2sWrXi3scTkOE80m0QONlBN7QeyqU/QK9ajQBOiGlsT3uh804KU+8
         rX6A==
X-Gm-Message-State: AOJu0YxOvnWf3RtZfTidz+qI0Jhutk0sYMYLaABVagPHVpnk/Tk4BXdW
	fwdTBqdvWwRj8BRnafdSLOULZhkzlhLT5CgcLzXavaid2J+OJikx3OFkJupf8IQL
X-Gm-Gg: ASbGncsqcSTOYB0hwVwSmmjCQUKnqlfFyzimBNZ+eY5cPPvZrb/VJG7yCD12ZSsDKxt
	2nww58ddiVAA+R3imnevHr8gidSswzSnrcoL4DKUu+Bg3aO6oYQBrkIO2L6WDp0i1KQEhTPhW+h
	/Fh6xdfLGT7cMcuJ38XZsGwU5QWZ3JKzVUIlLL52W4M5NQ2VIsoxPTxxIpqgvHnl5Qo75mrKrAo
	RRZdcKu+qrKug4ArOWOPcuxlBqm3WnUXOmf7shX5VV/SVJ0pv7E4xuFt4mWIF+8lqElg0bAqfNI
	kaaURPynLy+9qIyjgENwwUOwRxVBmLWVU9+5GBVDOeNLKuyiiuHHOLD19/LbDk5RXwY=
X-Google-Smtp-Source: AGHT+IE41LEtjc63hTsmtijuXC/PC0Rg+SHObzMi39t4/CWoa1zRvZpYQnVrAvJFGJOWIBQMS7P1Wg==
X-Received: by 2002:a17:903:3acb:b0:231:ba39:d927 with SMTP id d9443c01a7336-23414fbb98fmr37216725ad.38.1748071892848;
        Sat, 24 May 2025 00:31:32 -0700 (PDT)
Received: from fedora.. ([2405:201:c005:b018:6a51:b86d:8d8d:758])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23414e86538sm8737935ad.184.2025.05.24.00.31.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 May 2025 00:31:32 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: jayatheerthkulkarni2005@gmail.com
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	mlell08@gmail.com
Subject: [PATCH v7 2/2] submodule: prevent overwriting .gitmodules entry on path reuse
Date: Sat, 24 May 2025 13:00:55 +0530
Message-ID: <20250524073055.58092-3-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.49.GIT
In-Reply-To: <20250524073055.58092-1-jayatheerthkulkarni2005@gmail.com>
References: <CA+rGoLdbZvD_aMfB=J_cJay-4Ptgf+=R3es9vmdrsHkGhCtPmw@mail.gmail.com>
 <20250524073055.58092-1-jayatheerthkulkarni2005@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding a submodule at a path that previously hosted another submodule
(e.g., 'child') reuses the submodule name derived from the path. If the
original submodule was only moved (e.g., to 'child_old') and not renamed,
this silently overwrites its configuration in .gitmodules.

This behavior loses user configuration and causes confusion when the
original submodule is expected to remain intact. It assumes that the
path-derived name is always safe to reuse, even though the name might
still be in use elsewhere in the repository.

Teach `module_add()` to check if the computed submodule name already
exists in the repository's submodule config, and if so, refuse the
operation unless the user explicitly renames or uses force to auto increment.

Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
---
 builtin/submodule--helper.c | 28 ++++++++++++++++++++++++++++
 t/t7400-submodule-basic.sh  | 23 +++++++++++++++++++++++
 2 files changed, 51 insertions(+)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 53da2116dd..9f6df833f0 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -3444,6 +3444,10 @@ static int module_add(int argc, const char **argv, const char *prefix,
 	struct add_data add_data = ADD_DATA_INIT;
 	const char *ref_storage_format = NULL;
 	char *to_free = NULL;
+	const struct submodule *existing;
+	struct strbuf buf = STRBUF_INIT;
+	int i;
+	char *sm_name_to_free = NULL;
 	struct option options[] = {
 		OPT_STRING('b', "branch", &add_data.branch, N_("branch"),
 			   N_("branch of repository to add as submodule")),
@@ -3546,6 +3550,29 @@ static int module_add(int argc, const char **argv, const char *prefix,
 	if(!add_data.sm_name)
 		add_data.sm_name = add_data.sm_path;
 
+	existing = submodule_from_name(the_repository,
+					null_oid(the_hash_algo),
+					add_data.sm_name);
+
+	if (existing && strcmp(existing->path, add_data.sm_path)) {
+		if (!force) {
+			die(_("submodule name '%s' already used for path '%s'"),
+			add_data.sm_name, existing->path);
+		}
+
+		/* --force: build <name><n> until unique */
+		for (i = 1; ; i++) {
+			strbuf_reset(&buf);
+			strbuf_addf(&buf, "%s%d", add_data.sm_name, i);
+			if (!submodule_from_name(the_repository,
+						null_oid(the_hash_algo),
+						buf.buf)) {
+				break;
+			}
+		}
+
+		add_data.sm_name = sm_name_to_free = strbuf_detach(&buf, NULL);
+	}
 	if (check_submodule_name(add_data.sm_name))
 		die(_("'%s' is not a valid submodule name"), add_data.sm_name);
 
@@ -3561,6 +3588,7 @@ static int module_add(int argc, const char **argv, const char *prefix,
 
 	ret = 0;
 cleanup:
+	free(sm_name_to_free);
 	free(add_data.sm_path);
 	free(to_free);
 	strbuf_release(&sb);
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index d6a501d453..f5514decab 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -1482,4 +1482,27 @@ test_expect_success '`submodule init` and `init.templateDir`' '
 	)
 '
 
+test_expect_success 'submodule add fails when name is reused' '
+	git init test-submodule &&
+	(
+		cd test-submodule &&
+		git commit --allow-empty -m init &&
+
+		git init ../child-origin &&
+		git -C ../child-origin commit --allow-empty -m init &&
+
+		git submodule add ../child-origin child &&
+		git commit -m "Add submodule child" &&
+
+		git mv child child_old &&
+		git commit -m "Move child to child_old" &&
+
+		# Now adding a *new* repo at the old name must fail
+		git init ../child2-origin &&
+		git -C ../child2-origin commit --allow-empty -m init &&
+		test_must_fail git submodule add ../child2-origin child
+	)
+'
+
+
 test_done
-- 
2.49.GIT

