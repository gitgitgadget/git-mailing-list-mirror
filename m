Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.12
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795019623;
	b=etV2i9uVJBjILX0U3J8F2r2iKqjZwtoxYiDEjIPTsFPkqqSc1JobmWPhglxu2GPUWu5e
	 MLXFScekAanw6rQSXavE97qUNK9IL/Qx05O5v7jtZot6ih/pqo0pScEKdXZjxPmWUbzUW
	 lgUkdti/pSn5spH6vOghHKMwnkTIpzQdy0t/HeeKLlbuPEYpwvcjcp8kA5y/R21dyfooU
	 s3r+u1Oh+vw3xFi+TBrrPBYONBRpDmPWt+GzFUGtAGOJr0vFzomIwAOn94SLc0ld8Vvxc
	 KCLPJhZ/VQcpwKztp5wyv8eADOecGT3XSm2k+XRGnEyFFIoY8R/rQOcOLTSg/hugzjg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795019623;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=H7Ulb74Qwo/v68ZpzEZWra/1aM9SZMYJuesp0KaIi38=;
	b=i3ww/ks1DhVaHdQ+IuCa/1Y1Je9jBE0xYyleQ6PphFBkjf6bUx3aPna7MdAm7OlSHGAk
	 oqcxu1drYDO5aNqpXzEXqSYd+bpUdYM3an7zgYn95eSdtBlEyxo7AVBVwnWKdZmxBNYkf
	 yOsADC8/n3sIHsIrX3RMMp+yuXBSTCyUnDamuRhagHOluXpSrBYXbbSZyK24E19JWUqHN
	 Jb4blxfEnPCoh3YGgvEuq9j2HlVbSUmkW+0lqJRrTeLPNuiOlKOxfolVALOl2ymq77x6g
	 Us/yZ1IYohQWHz1V7H+7GwXZFZMgZ06EAq18kQwyZSiuLmxeEUFLYIKPcL9PsVoHm7w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=GAdJP3ha;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.12
Received: from sender5-op-o12.zoho.com (sender5-op-o12.zoho.com [165.173.182.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14EC606A7C2
	for <git@vger.kernel.org>; Wed, 18 Nov 2026 16:33:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C14EC606A7C2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=GAdJP3ha
ARC-Seal: i=1; a=rsa-sha256; t=1795019608; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=aN9FMbv7YB2KAw5Y+8ZeSxlFo2K0A0uYtFdbWo9rpQVG1rawO/sPpDkANm6OxMXcEY1XB8hNKkD7zxepxd+xwp4s1M3qpVFHhZmd3VSnhhEcXPShLyEGsR1+CecCKKd+qTPGoEpaRisGGY0cClmd0FPbzbaQRKnTmcZIeSmHdas=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1795019608; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=H7Ulb74Qwo/v68ZpzEZWra/1aM9SZMYJuesp0KaIi38=; 
	b=lJlTgsbNlXIpfe08fyP3sdUHlw0CRPVmlFUaZUsYm8jz0QTgQ5G+kqwXcYvuxjTJuGt+jv+J6Yfv8XmeAswtU4QPFZwFYOHIWK5whU933a86dDTmns3MAINl4paWhEqiWvEJQDLW0lMCgU7WqLQPs3f2RDaTTdFQRWwqRf+2EVw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: a=rsa-sha256; b=GAdJP3har3HO5aXpIRSEgOyvvWaEsTg5jD++7VxK0IVAlcrx+8AcWRb49US6CWd78YuiopDW9b/6Y+sgIb4TiYZlyZWPAgl/+/8UyJFSRx1PI6k+bgi5LXL5hB9sWTBDyvvtVdFRbjes5sSjoktmSKcspixgt2Re6JRuoVJdkXw=; c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1; bh=H7Ulb74Qwo/v68ZpzEZWra/1aM9SZMYJuesp0KaIi38=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1795019605901366.49226987591055;
	Wed, 18 Nov 2026 08:33:25 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Andreas Wendleder <gonsolo@gmail.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Patrick Steinhardt <ps@pks.im>,
	Adrian Ratiu <adrian.ratiu@collabora.com>
Subject: [PATCH 2/3] submodule: only suggest submodulePathConfig when it is disabled
Date: Wed, 18 Nov 2026 18:32:48 +0200
Message-ID: <20261118163249.1693361-3-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261118163249.1693361-1-adrian.ratiu@collabora.com>
References: <avuJBGlB3pRU3JU0@pampelmuse>
 <20261118163249.1693361-1-adrian.ratiu@collabora.com>
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

When a recursive checkout refuses to use a submodule's git dir, the
error message ends with:

  Enabling extensions.submodulePathConfig should fix this.

This is printed even when the extension is already enabled, which is
confusing: the user is told to turn on something that is already on.

Move the suggestion into a separate hint, as submodule_name_to_gitdir()
already does, and only show it when the extension is disabled.

Reported-by: Andreas Wendleder <gonsolo@gmail.com>
Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
 submodule.c                                | 10 ++++++----
 t/t7425-submodule-gitdir-path-extension.sh | 14 ++++++++++++++
 t/t7450-bad-git-dotfiles.sh                |  1 +
 3 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/submodule.c b/submodule.c
index d00d820d42..64cd8005f7 100644
--- a/submodule.c
+++ b/submodule.c
@@ -2171,11 +2171,13 @@ int submodule_move_head(const char *path, const char *super_prefix,
 
 				free(dotgit);
 				if (validate_submodule_git_dir(git_dir,
-							       sub->name) < 0)
+							       sub->name) < 0) {
+					if (!the_repository->repository_format_submodule_path_cfg)
+						advise(_("enabling extensions.submodulePathConfig "
+							 "might fix the following error."));
 					die(_("refusing to create/use '%s' in "
-					      "another submodule's git dir. "
-					      "Enabling extensions.submodulePathConfig "
-					      "should fix this."), git_dir);
+					      "another submodule's git dir."), git_dir);
+				}
 				free(git_dir);
 			}
 		} else {
diff --git a/t/t7425-submodule-gitdir-path-extension.sh b/t/t7425-submodule-gitdir-path-extension.sh
index ea86ecf7ee..80438a7231 100755
--- a/t/t7425-submodule-gitdir-path-extension.sh
+++ b/t/t7425-submodule-gitdir-path-extension.sh
@@ -525,4 +525,18 @@ test_expect_success 'submodule gitdir conflicts with previously encoded name (lo
 	)
 '
 
+test_expect_success 'rejected submodule gitfile does not suggest enabling the extension' '
+	git clone -c extensions.submodulePathConfig=true --recurse-submodules nested clone_moved_gitdir &&
+	(
+		cd clone_moved_gitdir &&
+		mkdir .git/modules/zoo &&
+		mv .git/modules/hippo .git/modules/zoo/hippo &&
+		git config set -f .git/modules/zoo/hippo/config core.worktree ../../../../thing1 &&
+		echo "gitdir: ../.git/modules/zoo/hippo" >thing1/.git
+	) &&
+	test_must_fail git -C clone_moved_gitdir checkout -f --recurse-submodules HEAD 2>err &&
+	test_grep "refusing to create/use" err &&
+	test_grep ! "extensions.submodulePathConfig" err
+'
+
 test_done
diff --git a/t/t7450-bad-git-dotfiles.sh b/t/t7450-bad-git-dotfiles.sh
index e17642fc16..a710c05a5d 100755
--- a/t/t7450-bad-git-dotfiles.sh
+++ b/t/t7450-bad-git-dotfiles.sh
@@ -391,6 +391,7 @@ test_expect_success 'checkout --recurse-submodules rejects gitfile not matching
 	) &&
 	test_must_fail git -C mismatched_gitdir checkout -f --recurse-submodules HEAD 2>err &&
 	test_grep "not a suffix of git dir" err &&
+	test_grep "enabling extensions.submodulePathConfig" err &&
 	test_grep ! "BUG" err
 '
 
-- 
2.56.1

