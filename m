Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F2413B293
	for <git@vger.kernel.org>; Wed,  7 Jan 2026 23:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767827009; cv=pass; b=E/06qPOWYdzeJFmyFOUosXsMClE+6yarlVUTNsnYO/8xUqcjEOKrPL3b4QSeH2hpvj6FvJWwipr+kNt7T4OlxnFOKXpdcfkLtbCs4KGvblVZ8h41IcZT6oL0+1Y0hDBxScPGAwjtrRUdKGVDlRiBetDkJpv2fGnTjPV03UF4ns0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767827009; c=relaxed/simple;
	bh=zykaHxy39MT7ILO2NMdVVEDnlRg3I1OveAqa2YIUjy8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LGr9r6vpdBEZ8yOpeeg4oly0y7VXQQfy5oRtVhQtPGXE+CBS6zuM2VsrIOM/aenAKCE/f3PbizH8oJb5O9Zom5QNvqccTQVYj14akxqERQ5/HAiX3iK0DIxooe7CRWPThYEqp2evJQAHB5djPBJUcdiiulC9AqzRe2SryJYmDzw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=ISl/DtnH; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="ISl/DtnH"
ARC-Seal: i=1; a=rsa-sha256; t=1767826993; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ZSXPpzkMVvdFpTRxf1VtQjcB7TYhFElNiQsywXu8n7AjE5pEvRIdeGwwYcr6GhtSyq0xenwEGNCckL7sLLtuVYwLsuUdFRaVblmHzInxM4iCICa2SUFpo6XRraSD6QMBY5fbgLYLOjailK2ySs65jzQmMYh7H2pxKbEojUK452k=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1767826993; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=YLiCk8DeneJwc8oT2w+Ig90EPZFPdOe/QpCqwVRVTdY=; 
	b=XOvi6CFtpmSiaZ7rm3C8oxlp1c5Ihq1PWJc5n+0VPvL0Hb57InkUecD/DH2uR3g9NPkzGe/TujtVns9nWJupQ7fBGvNkMYKt8wahIKixrxGMfrUnUt4AuKP4hPacfcaNbVV64ytXGQD8NPeMvvq/9JbjG97Y6OxBkNo1E6Kyz5Y=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1767826992;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=YLiCk8DeneJwc8oT2w+Ig90EPZFPdOe/QpCqwVRVTdY=;
	b=ISl/DtnHxXj4VERN/thkjJyVed86Xlk8ALnkjTW6fbOmjGqkjZVZkOfjvj0EZ6vh
	eQ1cha+sOFKqvacPof1U5JbI5rwyZz7KUkt+3pgaNRQU18XP2Uxq6wosSQMPDAshx4L
	Wo07wzhpnsFYVd+nQQm2CMXGms8MNGF1dr91bHCY=
Received: by mx.zohomail.com with SMTPS id 1767826990304786.0283632473743;
	Wed, 7 Jan 2026 15:03:10 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: git@vger.kernel.org
Cc: Emily Shaffer <emilyshaffer@google.com>,
	Rodrigo Damazio Bovendorp <rdamazio@google.com>,
	Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Aaron Schrab <aaron@schrab.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Josh Steadmon <steadmon@google.com>,
	Ben Knoble <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Adrian Ratiu <adrian.ratiu@collabora.com>
Subject: [PATCH v8 10/11] submodule: hash the submodule name for the gitdir path
Date: Thu,  8 Jan 2026 01:01:44 +0200
Message-ID: <20260107230145.517562-11-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260107230145.517562-1-adrian.ratiu@collabora.com>
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
 <20260107230145.517562-1-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

If none of the previous plain-text / encoding / derivation steps work
and case 2.4 is reached, then try a hash of the submodule name to see
if that can be a valid gitdir before giving up and throwing an error.

This is a "last resort" type of measure to avoid conflicts since it
loses the human readability of the gitdir path. This logic will be
reached in rare cases, as can be seen in the test we added.

Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
 builtin/submodule--helper.c                | 19 +++++++
 t/t7425-submodule-gitdir-path-extension.sh | 59 ++++++++++++++++++++++
 2 files changed, 78 insertions(+)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 402f98489a..ab4a6318b7 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -465,6 +465,10 @@ static int validate_and_set_submodule_gitdir(struct strbuf *gitdir_path,
 static void create_default_gitdir_config(const char *submodule_name)
 {
 	struct strbuf gitdir_path = STRBUF_INIT;
+	struct git_hash_ctx ctx;
+	char hex_name_hash[GIT_MAX_HEXSZ + 1], header[128];
+	unsigned char raw_name_hash[GIT_MAX_RAWSZ];
+	int header_len;
 
 	/* Case 1: try the plain module name */
 	repo_git_path_append(the_repository, &gitdir_path, "modules/%s", submodule_name);
@@ -506,6 +510,21 @@ static void create_default_gitdir_config(const char *submodule_name)
 			return;
 	}
 
+	/* Case 2.4: If all the above failed, try a hash of the name as a last resort */
+	header_len = snprintf(header, sizeof(header), "blob %zu", strlen(submodule_name));
+	the_hash_algo->init_fn(&ctx);
+	the_hash_algo->update_fn(&ctx, header, header_len);
+	the_hash_algo->update_fn(&ctx, "\0", 1);
+	the_hash_algo->update_fn(&ctx, submodule_name, strlen(submodule_name));
+	the_hash_algo->final_fn(raw_name_hash, &ctx);
+	hash_to_hex_algop_r(hex_name_hash, raw_name_hash, the_hash_algo);
+	strbuf_reset(&gitdir_path);
+	repo_git_path_append(the_repository, &gitdir_path, "modules/%s", hex_name_hash);
+	if (!validate_and_set_submodule_gitdir(&gitdir_path, submodule_name)) {
+		strbuf_release(&gitdir_path);
+		return;
+	}
+
 	/* Case 3: nothing worked, error out */
 	die(_("failed to set a valid default config for 'submodule.%s.gitdir'. "
 	      "Please ensure it is set, for example by running something like: "
diff --git a/t/t7425-submodule-gitdir-path-extension.sh b/t/t7425-submodule-gitdir-path-extension.sh
index c49e67b4c8..1c2d4905b1 100755
--- a/t/t7425-submodule-gitdir-path-extension.sh
+++ b/t/t7425-submodule-gitdir-path-extension.sh
@@ -442,4 +442,63 @@ test_expect_success CASE_INSENSITIVE_FS 'verify case-folding conflicts are corre
 	verify_submodule_gitdir_path cloned-folding "fooBar" "modules/fooBar0"
 '
 
+test_expect_success CASE_INSENSITIVE_FS 'verify hashing conflict resolution as a last resort' '
+	git clone -c extensions.submodulePathConfig=true main cloned-hash &&
+	(
+		cd cloned-hash &&
+
+		# conflict: add all submodule conflicting variants until we reach the
+		# final hashing conflict resolution for submodule "foo"
+		git submodule add ../new-sub "foo" &&
+		git submodule add ../new-sub "foo0" &&
+		git submodule add ../new-sub "foo1" &&
+		git submodule add ../new-sub "foo2" &&
+		git submodule add ../new-sub "foo3" &&
+		git submodule add ../new-sub "foo4" &&
+		git submodule add ../new-sub "foo5" &&
+		git submodule add ../new-sub "foo6" &&
+		git submodule add ../new-sub "foo7" &&
+		git submodule add ../new-sub "foo8" &&
+		git submodule add ../new-sub "foo9" &&
+		git submodule add ../new-sub "%46oo" &&
+		git submodule add ../new-sub "%46oo0" &&
+		git submodule add ../new-sub "%46oo1" &&
+		git submodule add ../new-sub "%46oo2" &&
+		git submodule add ../new-sub "%46oo3" &&
+		git submodule add ../new-sub "%46oo4" &&
+		git submodule add ../new-sub "%46oo5" &&
+		git submodule add ../new-sub "%46oo6" &&
+		git submodule add ../new-sub "%46oo7" &&
+		git submodule add ../new-sub "%46oo8" &&
+		git submodule add ../new-sub "%46oo9" &&
+		test_commit add-foo-variants &&
+		git submodule add ../new-sub "Foo" &&
+		test_commit add-uppercase-foo
+	) &&
+	verify_submodule_gitdir_path cloned-hash "foo" "modules/foo" &&
+	verify_submodule_gitdir_path cloned-hash "foo0" "modules/foo0" &&
+	verify_submodule_gitdir_path cloned-hash "foo1" "modules/foo1" &&
+	verify_submodule_gitdir_path cloned-hash "foo2" "modules/foo2" &&
+	verify_submodule_gitdir_path cloned-hash "foo3" "modules/foo3" &&
+	verify_submodule_gitdir_path cloned-hash "foo4" "modules/foo4" &&
+	verify_submodule_gitdir_path cloned-hash "foo5" "modules/foo5" &&
+	verify_submodule_gitdir_path cloned-hash "foo6" "modules/foo6" &&
+	verify_submodule_gitdir_path cloned-hash "foo7" "modules/foo7" &&
+	verify_submodule_gitdir_path cloned-hash "foo8" "modules/foo8" &&
+	verify_submodule_gitdir_path cloned-hash "foo9" "modules/foo9" &&
+	verify_submodule_gitdir_path cloned-hash "%46oo" "modules/%46oo" &&
+	verify_submodule_gitdir_path cloned-hash "%46oo0" "modules/%46oo0" &&
+	verify_submodule_gitdir_path cloned-hash "%46oo1" "modules/%46oo1" &&
+	verify_submodule_gitdir_path cloned-hash "%46oo2" "modules/%46oo2" &&
+	verify_submodule_gitdir_path cloned-hash "%46oo3" "modules/%46oo3" &&
+	verify_submodule_gitdir_path cloned-hash "%46oo4" "modules/%46oo4" &&
+	verify_submodule_gitdir_path cloned-hash "%46oo5" "modules/%46oo5" &&
+	verify_submodule_gitdir_path cloned-hash "%46oo6" "modules/%46oo6" &&
+	verify_submodule_gitdir_path cloned-hash "%46oo7" "modules/%46oo7" &&
+	verify_submodule_gitdir_path cloned-hash "%46oo8" "modules/%46oo8" &&
+	verify_submodule_gitdir_path cloned-hash "%46oo9" "modules/%46oo9" &&
+	hash=$(printf "Foo" | git hash-object --stdin) &&
+	verify_submodule_gitdir_path cloned-hash "Foo" "modules/${hash}"
+'
+
 test_done
-- 
2.51.2

