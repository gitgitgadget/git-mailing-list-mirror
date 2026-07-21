Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C860F3B6BF4
	for <git@vger.kernel.org>; Tue, 21 Jul 2026 21:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784669470; cv=none; b=lvfA6I+Jr7fCMWRtEqY6d5klKm/VQgPqqsDfMWmVpx1+VTp5/1oW507e05/zLrr0uYRGFhWmrVlWqub7a4pNRc+mVBRZB/qlM2HO3jbtsVScTM2h2LIAmT3NU/lkHV6WEOAbHGuiagyPP3MgxeWKOEpzKV30L5LKUHkIqnX8+/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784669470; c=relaxed/simple;
	bh=y5svdNJV0wytNZ/5TbOWGZrTqVF3FgmzKsp9ZDwQ4N0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TC7EBYWdQzbBaeWPxJIYagvQg93ICJW58g4lkyp/XlQbtIlzLdxtp1zaNW09RjfvglQZixv5EzNMVLlYVi2LgedNoJ2Vam2cLSSZnMmTjmXFUTTWFBpBfhySJ77hahOH6bvQupKUxtS3SpzFCoLrFPysYBW8qx5VMC0M3OM2ew8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fIFnO5gB; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fIFnO5gB"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4955aa106b1so25535265e9.0
        for <git@vger.kernel.org>; Tue, 21 Jul 2026 14:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784669467; x=1785274267; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0Hrlip+UNMp3GkJoAP8yFau77KlCuVFqzjJEI30uIrE=;
        b=fIFnO5gBCT7AgPfF97VugZvsWo17mcoS4sNZSyJ+eZtBGIyQZlG4xAY8b4U9MfoVo8
         37eMS4xdojy4DwMa9wpt4lqRAV8Cxg3lGpdZ/xfh5sHu3KHP8Vk27Byk358tjSZUd8xh
         c1eERtNdp+xU55WpCm7G1Jj8pSPaGYKHHN8txn0WrsiQoicC2nY1uMH6pcZ2xFnxe4Xi
         ySAiCC5Qf42p6E3Z2ZaaVGq1uQV91ge8VXBPB/2qCwlMj80e/T3bUVFobbisGlLeV6M2
         VBGBfcgEV2qqpgiB//2wisruizFwa7F5Uz/YU4LqkJpmrq2AYxHsvmDeU+fxepI8UrUq
         cvFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784669467; x=1785274267;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0Hrlip+UNMp3GkJoAP8yFau77KlCuVFqzjJEI30uIrE=;
        b=bHb9NWG59Y8X/mwQqojlSCnr66LX/uLkmUiHGzzMFPDmDdorZEDSnMFu2+gGMgBxBa
         2OjNEyDyQNj6oYQKGEZtl4IVkScBsqNbo4eIr7DuA1dzICYeTK9SviNMj4V/sbxZ+y/z
         gY+x3XekSV4eT1AbdRcrMJTfNPJM8wTWdGPsSw7jg8zfXZDSvCrHFb42VWk2uNWZt/av
         kRleTJ5XQdtwycDdSTHlWh3zdOAgsj49O0uhiN3CknMot3kHXsaAyWH43XySexOGLO2g
         gTm4S1+xAuCSh9gRU6AL95vo8nKu3HoMnqdwI99MKNNdzmkamvL1PGL2nL4e6q3VRHVF
         gIog==
X-Gm-Message-State: AOJu0YyMnomg4Rgn2/TtdC/hT71xuWZpQl5qhtbTkRSCrGHRi7COUxIK
	rXytCMup/HSYs3k4B/qJmagaJjeTkWJ68GuL4n0EHHAhXth1sytT+C9pNUsJng==
X-Gm-Gg: AfdE7cm6aDDMSSDI8AAaIO5xYslA4b1tuMDH3xXbw2eVptEM/7i511MwjQeHm1qIvAv
	rt1F7duJGbUlA9IJuM+k8o7KI7StKKfmZH3/O+adYesMWLgfhusH1B5wmP9Tk68/DCJ+kuc77fv
	HdHrnPwlathb8QJDDP/ZQvDbDDhE4yjA8X7TCPXwOnSxXbm/MF18GcZ2hHIUzyDqhKyIMRO9PvC
	0MTq1ixZvBB80nu9WrAxZ2HKegOfXEfjnxMgdSiaqqUyGTp/Y16YDjs3B89r1PlLlHGU7KqtqYR
	zZp/0FDpgY8AV+4LLWrNKHAJnhixNfJZuY4zPabGhBgrw6U8+qrNlZohISiOLpOBqXmPb5TcUjY
	+YnGUYu5XfeQmp2/HdVeLCZ1oPfo9NAleDAPDseSiDqXIgNxqazQtXZyn1KSDN6W1HuRmtZPMgU
	5tW1WORd8qYOAuKSAPX5kslNIs
X-Received: by 2002:a05:600c:c84:b0:495:4689:1e98 with SMTP id 5b1f17b1804b1-4954a3ed426mr220185445e9.10.1784669466744;
        Tue, 21 Jul 2026 14:31:06 -0700 (PDT)
Received: from ccjmne-arch (82-65-84-247.subs.proxad.net. [82.65.84.247])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63e52aa4sm43037446f8f.10.2026.07.21.14.31.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 14:31:06 -0700 (PDT)
From: =?UTF-8?q?=C3=89ric=20NICOLAS?= <ccjmne@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Jacob Keller <jacob.keller@gmail.com>,
	=?UTF-8?q?=C3=89ric=20NICOLAS?= <ccjmne@gmail.com>
Subject: [PATCH] submodule: resolve insteadof-aliases when matching remote
Date: Tue, 21 Jul 2026 23:30:42 +0200
Message-ID: <20260721213042.3357346-1-ccjmne@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When ca62f524c1 introduced a mechanism to identify which remote is to be
used by a submodule, we had it compare the URL stored in the .gitmodules
inventory to those of each available remote.

However, when using URL aliasing via url.<base>.insteadOf, we store
in .gitmodules the URL pre-resolution of the alias, whereas the
corresponding remote set up in the submodule reports using the
*resolved* URL.  This mechanism therefore fails to find a match then,
and resorts to the fallback logic, which does use either the only
configured remote if there is only one, or attempts using "origin"
otherwise.

Resolve the alias in the URL inventoried in .gitmodules before comparing
it against those of the corresponding submodule's configured remotes.

Signed-off-by: Éric NICOLAS <ccjmne@gmail.com>
---
 remote.c                    | 15 ++++++++++++---
 t/t7406-submodule-update.sh | 21 +++++++++++++++++++++
 2 files changed, 33 insertions(+), 3 deletions(-)

diff --git a/remote.c b/remote.c
index b17648d6ef..ae187fb3d6 100644
--- a/remote.c
+++ b/remote.c
@@ -1821,17 +1821,26 @@ const char *repo_default_remote(struct repository *repo)
 
 const char *repo_remote_from_url(struct repository *repo, const char *url)
 {
+	char *rewritten_url;
+	const char *url_to_match;
+	const char *remote_name = NULL;
+
 	read_config(repo, 0);
+	rewritten_url = alias_url(url, &repo->remote_state->rewrites);
+	url_to_match = rewritten_url ? rewritten_url : url;
 
 	for (int i = 0; i < repo->remote_state->remotes_nr; i++) {
 		struct remote *remote = repo->remote_state->remotes[i];
 		if (!remote)
 			continue;
 
-		if (remote_has_url(remote, url))
-			return remote->name;
+		if (remote_has_url(remote, url_to_match)) {
+			remote_name = remote->name;
+			break;
+		}
 	}
-	return NULL;
+	free(rewritten_url);
+	return remote_name;
 }
 
 int branch_has_merge_config(struct branch *branch)
diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index 9554720152..84e2cbbef9 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -256,6 +256,27 @@ test_expect_success 'submodule update --remote should fetch upstream changes' '
 	)
 '
 
+test_expect_success 'submodule update --remote resolves URL rewrites' '
+	test_config_global "url.$(pwd)/.insteadOf" local: &&
+	mkdir aliased-super aliased-submodule &&
+	(
+		cd aliased-submodule &&
+		git init &&
+		echo line >file &&
+		git add file &&
+		git commit -m "Initial commit"
+	) &&
+	(
+		cd aliased-super &&
+		git init &&
+		git submodule add local:aliased-submodule submodule &&
+		git submodule update --force submodule &&
+		git -C submodule remote rename origin upstream &&
+		git -C submodule remote add fork user@host &&
+		git submodule update --remote submodule
+	)
+'
+
 test_expect_success 'submodule update --remote should fetch upstream changes with .' '
 	(
 		cd super &&
-- 
2.55.0

