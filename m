Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.12
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795019625;
	b=lQasDkpz0duLphpy6sYZYbDVgkNNZf7DUROPbfDNI8F+NdK8Pikupk3spkTxaegHyWTD
	 vVaQHNjd+4f6thDWVqLSVymSMlPRUcijIbDp2lqNxMdhreQJmMdyUABzZGKSWnfn/7Yqr
	 T9K47XHXuWnMI7RfGyNFBroDDbDzY5Rn1cmVza8z0zJiPDuL7nvr/i8nUYp8g1+NLwmDN
	 1gfGue6QMO/ED6df1rvJ2bJCLqI241ldVc3RLbqt3Mg/NaE/cO8Pc6eO31PWhqskpSAW4
	 LQzR7QZcs+PQy0Rm4calaRmMG/ND2HpLgmc2kZ2OXCP4eDEHvbNvy+WELD/K6uSj1jw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795019625;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=QHtxO3bKxdxTjExvr3da6AHlLb7/Ut+5ayAQiOYnCLg=;
	b=IC44moUCMjPpvSq1A3Tgb/ZVO9NSD3/KB9q0nlYsFe3GJKHvcVwE1wF5JjrsYPk8AgIr
	 KmOBTvxKjVwdcalI5RzVw2ObiJUuKfClnBBW6m5ptyH1cjUgvvWoCssVuhiTe3YEuZkeX
	 sZWFCz5z7U4Ngi+T8DlyO2WGD5RloJ0u+D445ZVwpK3ccMu0pwHa7WWT9ZDhTneBd/gST
	 YA36w3DpBozOSv6MTwpJJbu0991L6QBt7rZE7q+QvWLxYZU9ex7cZeqxDm3N3s6Q9a6Lh
	 ZHpLr4AlDSIB4z4KBuRfZQ+5c9aW9QJx91TtFRVA9hIYwx6qliNmOrUC/sXFnuHDteQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=TfFsC2PJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.12
Received: from sender5-op-o12.zoho.com (sender5-op-o12.zoho.com [165.173.182.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E418606A33A
	for <git@vger.kernel.org>; Wed, 18 Nov 2026 16:33:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9E418606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=TfFsC2PJ
ARC-Seal: i=1; a=rsa-sha256; t=1795019606; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=jFmMUp6YY+b/zPf8CVU/NLBsWa6Wii/0/me10Gg+bvD/C0hxU3vwkwnZKyfIl82gG51G1Vb7kk8AuN+6HJyRb6XVfD6U60lR6v15epEF8kS1kESpn2ESnBGdvcVzMAkbzrdD3VOUgRD0iG2KPWWT7GKSpq1wnXqAAyEnsWSbiho=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1795019606; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=QHtxO3bKxdxTjExvr3da6AHlLb7/Ut+5ayAQiOYnCLg=; 
	b=idXHEutLJFwvmJFH8L0euQd8zUACWY/SCIMX6N8ZOS2YM3KetRWlwTI+v6GW4W6Pt+xpvYA/2o+xxyzAQnoUVqetficGgf6CjKU3WpFXPGpHavRHi/VTqQnep2CN93K5eb1Tubb9bau7vhr6Wm0erFlXN6UMOoIA8uMhjONW/aA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: a=rsa-sha256; b=TfFsC2PJRitsonMcVfOyEW7SyF70lUljeHF4DC3keLSjfORW1WC+aPp/g9I9KBksLU2FryWIdpzWypOXuqV+J+RAM9/dHPBBF5INy5NIZU/fVRamXc1qAblx2kklx2G6e51ESJBjAtd3amZxSn0aMHBvHmce4TlEfX3mn+GkraE=; c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1; bh=QHtxO3bKxdxTjExvr3da6AHlLb7/Ut+5ayAQiOYnCLg=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1795019603599511.9717203008545;
	Wed, 18 Nov 2026 08:33:23 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Andreas Wendleder <gonsolo@gmail.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Patrick Steinhardt <ps@pks.im>,
	Adrian Ratiu <adrian.ratiu@collabora.com>
Subject: [PATCH 1/3] submodule: return an error instead of BUG() for an unexpected git dir
Date: Wed, 18 Nov 2026 18:32:47 +0200
Message-ID: <20261118163249.1693361-2-adrian.ratiu@collabora.com>
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

During a recursive checkout, Git reads a submodule's .git file to find
its git dir and checks that the path ends in the submodule's name, e.g.
".git/modules/sub" for a submodule called "sub".

Without extensions.submodulePathConfig, a path that does not end that
way triggers a BUG() and aborts the command:

  BUG: submodule.c:2414: submodule name 'sub' not a suffix of git dir '...'

This path comes from a file on disk, not from Git's own code, so an
unexpected value is a problem with the user's setup, not a bug in Git.
It can happen when the git dir under .git/modules has been renamed or
the submodule is a linked worktree (handled in a later commit).

When the check was added in a8dee3ca61 (Disallow dubiously-nested
submodule git directories, 2019-10-01), its callers only passed git
dirs computed by Git from the submodule name, so BUG() was correct.

9cf8547320 (clone: prevent clashing git dirs when cloning submodule in
parallel, 2024-01-28) added a caller that passes a path read from the
gitfile, which made the BUG() reachable.

Return an error instead of BUG(), so the command dies with the same
"refusing to create/use ..." message as when the submodulePathConfig
extension is enabled.

Reported-by: Andreas Wendleder <gonsolo@gmail.com>
Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
 submodule.c                 |  8 ++++++--
 t/t7450-bad-git-dotfiles.sh | 14 ++++++++++++++
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/submodule.c b/submodule.c
index 1302c11ddf..d00d820d42 100644
--- a/submodule.c
+++ b/submodule.c
@@ -2410,10 +2410,14 @@ static int validate_submodule_legacy_git_dir(char *git_dir, const char *submodul
 		BUG("validate_submodule_git_dir() must be called with "
 		    "extensions.submodulePathConfig disabled.");
 
+	/*
+	 * The git dir may come from a gitfile on disk, so a mismatch is
+	 * not necessarily a bug in the caller.
+	 */
 	if (len <= suffix_len || (p = git_dir + len - suffix_len)[-1] != '/' ||
 	    strcmp(p, submodule_name))
-		BUG("submodule name '%s' not a suffix of git dir '%s'",
-		    submodule_name, git_dir);
+		return error(_("submodule name '%s' not a suffix of git dir '%s'"),
+			     submodule_name, git_dir);
 
 	/*
 	 * We prevent the contents of sibling submodules' git directories to
diff --git a/t/t7450-bad-git-dotfiles.sh b/t/t7450-bad-git-dotfiles.sh
index 72c7f6f73b..e17642fc16 100755
--- a/t/t7450-bad-git-dotfiles.sh
+++ b/t/t7450-bad-git-dotfiles.sh
@@ -380,6 +380,20 @@ test_expect_success 'checkout -f --recurse-submodules must not use a nested gitd
 	test_path_is_missing nested_checkout/thing2/.git
 '
 
+test_expect_success 'checkout --recurse-submodules rejects gitfile not matching submodule name' '
+	git clone nested mismatched_gitdir &&
+	(
+		cd mismatched_gitdir &&
+		git submodule init thing1 &&
+		git submodule update thing1 &&
+		mv .git/modules/hippo .git/modules/elephant &&
+		echo "gitdir: ../.git/modules/elephant" >thing1/.git
+	) &&
+	test_must_fail git -C mismatched_gitdir checkout -f --recurse-submodules HEAD 2>err &&
+	test_grep "not a suffix of git dir" err &&
+	test_grep ! "BUG" err
+'
+
 test_expect_success SYMLINKS,!WINDOWS,!MINGW 'submodule must not checkout into different directory' '
 	test_when_finished "rm -rf sub repo bad-clone" &&
 
-- 
2.56.1

