Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793445316;
	b=1QyJ20Ry0QXovg3QfpDLTGRtJM+PwYehvU8kLNhBhwpvRQGZLgLX7V71Bbi/T6cBFbY+
	 J/ayBAo8sbxP7XY9MOWFuYdkVPg+r/6Hi2zIecyLbPCFWBIz3yZy5CbAnS89s+0B6uvaz
	 kvoY98fXNWsA+Ze+2O7wl9ui/rgCj8nX6xXt0QlQtt6QN61gYecIhZWEiEtiCRc9qFPDb
	 2ZAJc3eUqbu86gtZu2jx3D0ydSilOU4JKLjVGsYSEEqikDAYA3erMtN+iM8+Nbw9BRea0
	 FpyR+VPqQNUWjr9Y4FSBF2DQIWvEzst1jA4BkgF8zkabbh3wUJv5QMo0/u9rJtL+MrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793445316;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=dFG0CMPquyZWKWGbbU1ycjjb/HcPAkQ158S/Gyn9/lk=;
	b=sF7hZ13kcFWwrrSbhg9wA1a0DaJaXIokilRTe7KDz3T6aw0vTVphhOWW8fSlCwsvKVVo
	 GdAJpWlpYoayTmMNwzdAbmkZWf8b2lt2v7/+EqGJmVKv3qiqU2/BlhHKMpkLug2Z+HjtN
	 g8wT9N+suOJ4PTzs0TKyeBr7tYkQimq5KUfz9WbZTe9eUornsbeWmwfz/7cD6jE8dpYhr
	 ngb+E+fEXlUxr9cAb4Ci7s5C1R+/jG8HtzYGHbLUSxvGyflLIsOYfYaPR/B7ILg7yjYpt
	 DNIvVPKD8BQ7iY9xj8IlE1Xr1GeyxuJvFLCoNqFALJrl2acQlIy+ZGPn+GHqMGDzLRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lsR3mb2A;
	arc=none smtp.remote-ip=209.85.216.50
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97EA2606A31D
	for <git@vger.kernel.org>; Sat, 31 Oct 2026 11:15:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 97EA2606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lsR3mb2A
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3ace1f3897cso784742a91.0
        for <git@vger.kernel.org>; Sat, 31 Oct 2026 04:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793445315; x=1794050115; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=dFG0CMPquyZWKWGbbU1ycjjb/HcPAkQ158S/Gyn9/lk=;
        b=lsR3mb2A2LLZxLybWnpM2/l+cuyfenzpnVkBGvoSprKbVJ8NboMTY2W2M07qHBGBIm
         OGT5REA6ijLuMSEIHfjGSQwQKg7APmM9XHJsm1AJzL4znRfl7eLNJpj5k8lBTThMh+IH
         30oLR3bCUYANbHYlYmK6TitRYKp1kOn+qqFA8frqdCAzTcjmKPoHI3JWjgvxx5yxy/jR
         nmEHWNyDVPvoLqQz0noRnm2jd0YukpJXbZFJuCAsGIMapDB9o5WWIFJDTjlCq73nkhXi
         Q8jDr8/UWZffpOmd3Aww3MB1AMS82Dxb8Ar/d3SB5oeuBJ4d4Jz0MgEukdFIseQj1agF
         FJfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793445315; x=1794050115;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dFG0CMPquyZWKWGbbU1ycjjb/HcPAkQ158S/Gyn9/lk=;
        b=HgAaYfijwvgBmyjiHF1N4yjgz5njrapjjIzZUYho6RyrcWXNuyAK1VU45+QI/u4nVx
         yaEH10wtNXAG7gAxP0bdfydOR5HHvQqZqfG8uRZwkqHL5BnPRU0o+P20RukwA6vejVE8
         w+s/bJBKv1AV7h79F1nEX/EcHKmlS/TGtCyDDg+3tXphJfwJQleiADQfp+5cBAeFaiXK
         SlCKFNepePkCz412Q/4IaRD8GElO+g/V1Ex87BLTdasuilT+KzOZ3O3+3r4LnnmvvzBk
         VcOhh4CMZem7TshVm/QdpwZ8P05a9GL1Yw8mnGJHzLxb+DiVWzcCIwPrLdux+k8iDk86
         QziQ==
X-Gm-Message-State: AFq9FYJXf3dthG6RxLBjPpPwyfkfwx0RADrBrEAtgD2wS4vI+ZRNa+Df
	x+YHPHHIpO6aXKTKJYz3eYRW2T/XLiq6seeZ9YePdstHLeNCizh//r0BsMF6DRJJFj8=
X-Gm-Gg: AYBFou0zd4bZkI6yjzVMXChh/t5c6oo11wT3tECN/GQg1JIO/nvq+4uylZFqGz7WKgJ
	vcAMBhYaeGzXFSHlKAfD8ZgDY54Tp5nyEqaVTNnpyZ9nAAWts995/qTuIgs7TdKI5r3Z0/fwbzD
	UqIQUcSX4MuoQTI5o07739t3vKWmL2vFWqTX58AynvrNdGkT6cdK/lkPAiDcB8qww5+jzOV8VpE
	YH9RUSbgI9FN8ekVwl66O5tfKivggo755zdd0lB7GCGR6jPRQ+TCpE0Llq+UdXkubgtSUkAgTiE
	DCwlWwsJGdhH+PW/OwEAOESy645MjKgFLIeJFy9o5Cci7O/R/Z8kcSxkcPB3TA2DTNyeB1C6LCf
	rtsX8O0bycxGy95ijR6p40j14mRj8t+Nyvdbezn+47YVX/l96jcwZUPqn0CN5bhRaHwcbOEa04R
	O5tWsMPLCnhBbAY+DE36q7taEiYiZUs3avym6ezHflkAEyYpedpCewR7VGgra2TRiy4ZDEPBFDn
	mWXpJYDkhI8TzxKmYq7rXtaNA3t8tdDs7bHsD+kQCE8izu0azlZ7+CakA+oofixX4RFL1+akScR
	Wlv/oeFheEm/zW6i76Rqq609TVEwDKoupw0sRSno7h60piafT3XFbTNY6xjO3dPHPkM4D0pRetn
	rxrsoj5PS9f3j89VikPfrGIEvpgIw4t93CSoGUuD8WHUwq1chn5CyWkGIDNAo1IyJMzykCqr9GW
	5NRdndmol0PRFIN7fGKy0rtf/CtMyw
X-Received: by 2002:a17:90b:4c12:b0:3ae:5572:c4d1 with SMTP id 98e67ed59e1d1-3ae8986e3bamr4547151a91.62.1793445314879;
        Sat, 31 Oct 2026 04:15:14 -0700 (PDT)
Received: from localhost.localdomain ([104.28.251.99])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae845984absm7596354a91.10.2026.10.31.04.15.09
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 31 Oct 2026 04:15:14 -0700 (PDT)
From: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	usmanakinyemi202@gmail.com,
	siddharthasthana31@gmail.com,
	kaartic.sivaraam@gmail.com,
	Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Subject: [Outreachy PATCH] fsmonitor: stop using the_repository
Date: Sat, 31 Oct 2026 12:14:50 +0100
Message-ID: <20261031111450.66192-1-okhuomonajayi54@gmail.com>
X-Mailer: git-send-email 2.56.0
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

refresh_fsmonitor() gets its repository from the index, but the
helpers it calls still use the_repository: fsmonitor_hook_version()
reads core.fsmonitorHookVersion, query_fsmonitor_hook() runs the
hook in the work tree, and fsmonitor_refresh_callback() checks
core.ignoreCase.

Pass the repository to fsmonitor_hook_version(), whose only caller
is refresh_fsmonitor(). query_fsmonitor_hook() already receives one,
and fsmonitor_refresh_callback() can use istate->repo.

Drop USE_THE_REPOSITORY_VARIABLE, as the file no longer uses
the_repository.

Signed-off-by: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
---
 fsmonitor.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/fsmonitor.c b/fsmonitor.c
index 107767527e..ed3d36d3fe 100644
--- a/fsmonitor.c
+++ b/fsmonitor.c
@@ -1,4 +1,3 @@
-#define USE_THE_REPOSITORY_VARIABLE
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
@@ -39,11 +38,11 @@ static void fsmonitor_ewah_callback(size_t pos, void *is)
 	ce->ce_flags &= ~CE_FSMONITOR_VALID;
 }
 
-static int fsmonitor_hook_version(void)
+static int fsmonitor_hook_version(struct repository *r)
 {
 	int hook_version;
 
-	if (repo_config_get_int(the_repository, "core.fsmonitorhookversion", &hook_version))
+	if (repo_config_get_int(r, "core.fsmonitorhookversion", &hook_version))
 		return -1;
 
 	if (hook_version == HOOK_INTERFACE_VERSION1 ||
@@ -171,7 +170,7 @@ static int query_fsmonitor_hook(struct repository *r,
 	strvec_pushf(&cp.args, "%d", version);
 	strvec_pushf(&cp.args, "%s", last_update);
 	cp.use_shell = 1;
-	cp.dir = repo_get_work_tree(the_repository);
+	cp.dir = repo_get_work_tree(r);
 
 	trace2_region_enter("fsm_hook", "query", NULL);
 
@@ -453,7 +452,7 @@ static void fsmonitor_refresh_callback(struct index_state *istate, char *name)
 	 * case-insensitive file system, try again using the name-hash
 	 * and dir-name-hash.
 	 */
-	if (!nr_in_cone && repo_ignore_case(the_repository)) {
+	if (!nr_in_cone && repo_ignore_case(istate->repo)) {
 		nr_in_cone = handle_using_name_hash_icase(istate, name);
 		if (!nr_in_cone)
 			nr_in_cone = handle_using_dir_name_hash_icase(
@@ -573,7 +572,7 @@ void refresh_fsmonitor(struct index_state *istate)
 
 	assert(fsm_mode == FSMONITOR_MODE_HOOK);
 
-	hook_version = fsmonitor_hook_version();
+	hook_version = fsmonitor_hook_version(r);
 
 	/*
 	 * This could be racy so save the date/time now and query_fsmonitor_hook

base-commit: 50fe5cc63f9cd6e89b87a2c9ccf96a444f4cfdb7
-- 
2.56.0

