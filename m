Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.12
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795448799;
	b=AJo+z7aiPWA7uCgmTRreZMacUjWlczJRhiLCbqMTRjAav78HU5ll1CIoGIC1JoxRkpq/
	 xQmBCVJ8aKw11k4yGbQ+H2X+UM0yyHWFgM8+C1IhgKz32PTTkCRD8Y53KcijQ7+ZLJ3XV
	 1Amj50Z5cWGntAp7ZlAkhvl9QX/mhacl8k82PvnsdUcMW4+Y968t0gRi5KL6gEObshw7X
	 /LE2zvqG52ZznCIF4P2TXlACtAk5iY01lCUgP4rlTvKDEqdUuKQ7nEsjU5M0AhWM0YGE1
	 K2RLGondblNlMpf1BmKmgJGfp/tDhyEmyJJFE/c83jkHHnYg2CH/vuC+4DJYjrBnL3A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795448799;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=k48CYyCVVTsJUVivhxOH/yzFC+Vjbln95tujbb1n7EY=;
	b=RqVljJqxPEKKO2DExHH65/EBFNnTOb7R67lI2tBiSabKbbRyqvGfAPAkbhuCEysvh6Ta
	 T0aGLFJvMrCEhFbstQYTdWZDyxCeUbD3d/aamNKMv3uywZi8ACjitnpkcwr60kxwu9G6k
	 MoyN1uvIfbZBHcqXyYimewfNHEevr/OKHr7ceaJpOeKTonm98fiuaFuMFCRiyXmVejnU+
	 29dWzYB/9BGHQHLkXg08eG2DTQex/fxInq/fQ6uZfgut7H1UF7Qf4fVX8lAPlXuzxhIwU
	 fQTDTopnF1O9X3MuBUxMoKr4w0Bz2mJTIerRA8D+c7n9YQnxt0ePIKbkUUIkYlYk2xA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=P+TVmov6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.12
Received: from sender6-op-o12.zoho.com (sender6-op-o12.zoho.com [165.173.180.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124D0606A31F
	for <git@vger.kernel.org>; Mon, 23 Nov 2026 15:46:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 124D0606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=P+TVmov6
ARC-Seal: i=1; a=rsa-sha256; t=1795448763; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ahf3Ndzc1jK6rz+eKvn71AaGCA26lLTGWRxp2BW07O9DhtWKgOfljKyo0SrY4TBBJViUNg/2d2fzKvNRoTo32n//YBFg2cIBnc6WgCC8RGKrUMv8wNSBJHxlg9a6bFfZ08h3p5LriWMw9X/F3Vst6mmFU7klYvqnYsvnb95x3Do=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1795448763; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=k48CYyCVVTsJUVivhxOH/yzFC+Vjbln95tujbb1n7EY=; 
	b=f4kloUAAa1pbqOCpbXQXelc5/rAlP5vSxz6ZmIhoho0BabT6Rhk0EnaftGAINlWYGAP3WQShBD38E11Irb0F+t+yKCdd6tUEknAitomoiKf/mWPsevDZ/4Vrxl+d4YbDQ2G/dpXwckUEOMxAQGXkmywDik7QiuuvDwca4MTtWfA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: a=rsa-sha256; b=P+TVmov6T1wPRT+6KeOt8g9/Gv4nh/kwmmn5zkMA3DWuq6JFXBo3fi5AeLlG0VyAPaPW8xcOj1lAuMkbcftPLvv2RpYlvExn9enLZTTIlpPcVc75g307UtpZodbRyUWGUxq3vcW6+xKuZvgkvHa99CSsYZk5Amtc4vKZt4sYFas=; c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1; bh=k48CYyCVVTsJUVivhxOH/yzFC+Vjbln95tujbb1n7EY=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1795448761379561.7403069206767;
	Mon, 23 Nov 2026 07:46:01 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: git@vger.kernel.org
Cc: Adrian Ratiu <adrian.ratiu@collabora.com>,
	Junio C Hamano <gitster@pobox.com>,
	Andreas Wendleder <gonsolo@gmail.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 4/5] submodule: validate the git dir after absorbing it
Date: Mon, 23 Nov 2026 17:44:59 +0200
Message-ID: <20261123154500.251056-5-adrian.ratiu@collabora.com>
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

When a submodule or one of its nested submodules has a .git directory,
submodule_move_head() absorbs it, then points the submodule .git file
to "$GIT_DIR/modules/<name>" without validating the git dir.

Absorbing only moves .git directories, so a submodule that already used
a gitfile keeps pointing to its old git dir, valid or not.

Validate it after absorbing too, so that Git refuses a bad one instead
of silently replacing it.

Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
 submodule.c                 | 20 ++++++++++----------
 t/t7450-bad-git-dotfiles.sh | 18 ++++++++++++++++++
 2 files changed, 28 insertions(+), 10 deletions(-)

diff --git a/submodule.c b/submodule.c
index 8aae789e98..9eae297c8a 100644
--- a/submodule.c
+++ b/submodule.c
@@ -2124,18 +2124,18 @@ static void setup_submodule_git_dir(const struct submodule *sub,
 				    const char *old_head, unsigned flags)
 {
 	if (old_head) {
+		char *dotgit, *git_dir;
+
 		if (!submodule_uses_gitfile(path))
 			absorb_git_dir_into_superproject(path, super_prefix);
-		else {
-			char *dotgit = xstrfmt("%s/.git", path);
-			char *git_dir = xstrdup(read_gitfile(dotgit));
-
-			free(dotgit);
-			if (validate_submodule_git_dir(git_dir, sub->name) < 0)
-				die_refusing_submodule_git_dir(the_repository,
-							       git_dir);
-			free(git_dir);
-		}
+
+		/* Now path/.git is a gitfile, so validate it. */
+		dotgit = xstrfmt("%s/.git", path);
+		git_dir = xstrdup(read_gitfile(dotgit));
+		free(dotgit);
+		if (validate_submodule_git_dir(git_dir, sub->name) < 0)
+			die_refusing_submodule_git_dir(the_repository, git_dir);
+		free(git_dir);
 	} else {
 		struct strbuf gitdir = STRBUF_INIT;
 		submodule_name_to_gitdir(&gitdir, the_repository, sub->name);
diff --git a/t/t7450-bad-git-dotfiles.sh b/t/t7450-bad-git-dotfiles.sh
index a710c05a5d..72ef1af661 100755
--- a/t/t7450-bad-git-dotfiles.sh
+++ b/t/t7450-bad-git-dotfiles.sh
@@ -395,6 +395,24 @@ test_expect_success 'checkout --recurse-submodules rejects gitfile not matching
 	test_grep ! "BUG" err
 '
 
+test_expect_success 'checkout --recurse-submodules rejects gitfile not matching submodule name after absorbing' '
+	git clone nested mismatched_absorbed &&
+	(
+		cd mismatched_absorbed &&
+		git submodule init thing1 &&
+		git submodule update thing1 &&
+		mv .git/modules/hippo .git/modules/elephant &&
+		echo "gitdir: ../.git/modules/elephant" >thing1/.git &&
+		# a nested .git directory makes the checkout absorb it first
+		git clone ../nested thing1/inner &&
+		git -C thing1 submodule add ./inner inner
+	) &&
+	echo "gitdir: ../.git/modules/elephant" >expect &&
+	test_must_fail git -C mismatched_absorbed checkout -f --recurse-submodules HEAD 2>err &&
+	test_grep "not a suffix of git dir" err &&
+	test_cmp expect mismatched_absorbed/thing1/.git
+'
+
 test_expect_success SYMLINKS,!WINDOWS,!MINGW 'submodule must not checkout into different directory' '
 	test_when_finished "rm -rf sub repo bad-clone" &&
 
-- 
2.56.1

