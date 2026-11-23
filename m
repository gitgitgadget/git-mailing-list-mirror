Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.12
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795448775;
	b=EsEAOMmIKOjNeLIdUEhGGlisFV+LrA8JgJDNfVABgPXq8ZSl/Q68il9X1JteqQ/5v8TA
	 SVm1FnyI9N/0ij/4q8Kic1IZdmfmSGNffrPJ4ZlP8YRy3GDMYm6s7SqlvuKy3vxxct2CM
	 d071GP1Asonp3kBQHLfxZRvYno+P3i68VzKT9DsOQg+Wzxb9wgo4cZHIEnA+4TjmMBYKe
	 AB4JlbsTT/gaVOOySLXn1Cmtja2bMQY5lqcxJMRRB6dMeOqmjnYm+cFeS60PHMLmMofIY
	 ZZcZHwePfOgMagdT+cL3AEIGQD9JFtAdDmdGu+WUQY/+QeX3ZqujJXaEw4n64Ou6ZOA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795448775;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=if5pBh1fBf+wzmwRWWPz6wTqRIpnP8zf/2YENQI2snU=;
	b=cyD7tibb8/Iv1/a9B4gVdLhmcIdGJXhOawliYItpBhxcpsnTPJ7v0PM/BV7XERcKBap6
	 g2ZmtcdnBZ1A3J09Iu0NmRDTiU5Wxdi54EPbjgZIUdcD1ZjvjsEwvci1YHALUaoD9XYLP
	 bgdgQ5o+kz0eHTmMPwl2MQbah9r2umNrTdYy2Fzt9kCXD0q5dG/UURGIvcg+oji4cGxEc
	 fOWN8mS6InEdhnySQ58HJjjz/yw6IF7uXAsZWvctA74jyv/GyHNA9LXvZJ7EQT9C9HI1o
	 vWMV/ERhBarcq1pyhOVYFuUR+mHORLiD1oAexm7Dx48IVSal6hylKL6k7LmeOJXt8qQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=UTq4nGP9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.12
Received: from sender5-op-o12.zoho.com (sender5-op-o12.zoho.com [165.173.182.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06CD1606A31F
	for <git@vger.kernel.org>; Mon, 23 Nov 2026 15:46:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 06CD1606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=UTq4nGP9
ARC-Seal: i=1; a=rsa-sha256; t=1795448743; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=SvkV8WP4kEMU0+Y1gv17sNI0dBAL8WpU/FR9hhVZNUUOI0UYcQX1LE+I16nFkAH7HRQgssxU6plwz7RVwSLC+LD4gqkvmVmxIq6ssKcwYRtaF0f5qzeVn7NvNb86e9exzrXj/0R4MFuAK6K5Wyds9ya2Xx4nWqTYtGeSu4Q0Tb0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1795448743; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=if5pBh1fBf+wzmwRWWPz6wTqRIpnP8zf/2YENQI2snU=; 
	b=G6lt/puyq8iVmd4yP0M1OHuu+KPG9A+eW2vY7RhCDt63rBzIB3DJtOAi3S5PsAu2F8+VC7OJ5gOtYFVLmFhHRFPS9g4vAgzjgpnw5LkRUBW6I8KG/tt3eicrnzoMW84TYv97qX3LFQGBX97FpmeW22oP3OGf/dkJoR7Kvzqf7uY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: a=rsa-sha256; b=UTq4nGP9gEU2U4WD2p3xFMeT6b62hYrykuInrLc3hu/dc/rkeTho2GZvBOUNUT+V2ALne2Y2pIH9HKPT0LkW+p2R7z3A2fxaF6KFIlo/0Ok1KL5F6wAqCjY6Y+AKiYqEcvb/q7rhOpmEIggD3yAk9GQDS211U/siMin/hQ/vJHw=; c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1; bh=if5pBh1fBf+wzmwRWWPz6wTqRIpnP8zf/2YENQI2snU=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1795448741482812.8212551776204;
	Mon, 23 Nov 2026 07:45:41 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: git@vger.kernel.org
Cc: Adrian Ratiu <adrian.ratiu@collabora.com>,
	Junio C Hamano <gitster@pobox.com>,
	Andreas Wendleder <gonsolo@gmail.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 1/5] submodule: return an error instead of BUG() for an unexpected git dir
Date: Mon, 23 Nov 2026 17:44:56 +0200
Message-ID: <20261123154500.251056-2-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261123154500.251056-1-adrian.ratiu@collabora.com>
References: <20261118163249.1693361-1-adrian.ratiu@collabora.com>
 <20261123154500.251056-1-adrian.ratiu@collabora.com>
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
 submodule.c                 |  4 ++--
 t/t7450-bad-git-dotfiles.sh | 14 ++++++++++++++
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/submodule.c b/submodule.c
index 1302c11ddf..6bdf1efd89 100644
--- a/submodule.c
+++ b/submodule.c
@@ -2412,8 +2412,8 @@ static int validate_submodule_legacy_git_dir(char *git_dir, const char *submodul
 
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

