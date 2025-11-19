Received: from sender3-op-o12.zoho.com (sender3-op-o12.zoho.com [136.143.184.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68FB32EDD62
	for <git@vger.kernel.org>; Wed, 19 Nov 2025 21:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.184.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763586719; cv=pass; b=czg+gkr0Dos7Fxe5DBdUS4OuZcPn6lCiPU2wrJ7jQZXYuelEhwSJ7pSzAE5JW8I8d7MNQzsql8VE0PyjanHVzc1lkEOawMSwl88+FLwlRrB+qHcYbGskxKZrq1cOSWVrV5MKpBzuXFwcVGvM5RImILquBnZ3DA2TXzhARAD00UU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763586719; c=relaxed/simple;
	bh=5lAGFHArX10ezkVeQ/RxqYOcAadpOjN3QPynJyR+Dd0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KJqwR1W4Zx/oa24ikD5S0OCQ702sXajq8pxXMGCVRupWkWRrOqjhFND9rdiDnx+joiluiLWWycLrBTB/HhI/nuP3Avl288TqZZUkQ7C6R/Jz2no/O3ZZPBI8EfzofEMn8UXDIeaHLBXumOmuRB+2ZExvSVJwFnGbVN9yD6TD6CE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=DJTJZZB/; arc=pass smtp.client-ip=136.143.184.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="DJTJZZB/"
ARC-Seal: i=1; a=rsa-sha256; t=1763586694; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=GeqJxfhqbKJvEndg5l+XFSv1T0DrINuMSMeYo+57SJ9GEz9vnDafmGWwaSZyHaOBb98VzcPZ48ljw+jUayxq8t9RuqqgtbU4iZxoo/sjEwlMw5joLIyFfi07nv7ecLxaPq9v5irFFYWjiMcEGy9c6COmQq5AqieF3JxgVvekWAo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1763586694; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=To5eN/RDTrmHWVtCtDeM+0IT+XMPho/nK30hQn+UoBs=; 
	b=lpJpVScCEgAxzXGKCdhazcoyM5/d1RIWX3qX0Isio5GcA0DgaEaC+CYoOa1RxcAgq93VmhaIZpeSY/xcLT2St7Rs1S5IFVxZiS+P8Onwb58Ix0YfztUsXbktoOAfribSqRYmm4fgveGAGqglmg4hLUuKRojh6BalY30GmpI9QtU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1763586694;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=To5eN/RDTrmHWVtCtDeM+0IT+XMPho/nK30hQn+UoBs=;
	b=DJTJZZB/CCXr00PfXOG5kT6YDKvWmyQlnPuDv9JBGV0+9Kn+U07sZfkowqzTEcQj
	mSXwx+SEg5jF/VCVOLkwOuoiDEOWNVMAcNm/HkU3U95ZUl5JM7GkgqNAqTqqxJPpGOK
	3scMA/d5qA477EvhXtEbcWJ2gXNEsD/Eou453ITQ=
Received: by mx.zohomail.com with SMTPS id 1763586692737793.4926280575527;
	Wed, 19 Nov 2025 13:11:32 -0800 (PST)
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
Subject: [PATCH v5 6/7] submodule: use hashed name for gitdir
Date: Wed, 19 Nov 2025 23:10:29 +0200
Message-ID: <20251119211030.2008441-7-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251119211030.2008441-1-adrian.ratiu@collabora.com>
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
 <20251119211030.2008441-1-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

If none of the previous steps work and we reach case 2.4, try to
hash the submodule name and see if that can be a valid gitdir
before giving up and throwing an error.

This is a "last resort" type of measure to avoid conflicts since
it loses the gitdir human readability. Itis not such a big deal
because users are now supposed to use the submodule.<name>.gitdir
config as the single source of truth for gitdir paths.

This logic will be reached in very rare cases, as can be seen in
the test we added.

Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
 submodule.c                   | 20 +++++++++++-
 t/t7425-submodule-encoding.sh | 59 +++++++++++++++++++++++++++++++++++
 2 files changed, 78 insertions(+), 1 deletion(-)

diff --git a/submodule.c b/submodule.c
index b3f74f7e3c..2c0df96d55 100644
--- a/submodule.c
+++ b/submodule.c
@@ -2660,8 +2660,12 @@ static int validate_and_set_submodule_gitdir(struct strbuf *gitdir_path,
 void submodule_name_to_gitdir(struct strbuf *buf, struct repository *r,
 			      const char *submodule_name)
 {
+	unsigned char raw_name_hash[GIT_MAX_RAWSZ];
+	char hex_name_hash[GIT_MAX_HEXSZ + 1];
+	struct git_hash_ctx ctx;
 	const char *gitdir;
-	char *key;
+	char *key, header[128];
+	int header_len;
 
 	repo_git_path_append(r, buf, "modules/");
 	strbuf_addstr(buf, submodule_name);
@@ -2732,6 +2736,20 @@ void submodule_name_to_gitdir(struct strbuf *buf, struct repository *r,
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
+	strbuf_reset(buf);
+	repo_git_path_append(r, buf, "modules/");
+	strbuf_addstr(buf, hex_name_hash);
+	if (!validate_and_set_submodule_gitdir(buf, submodule_name))
+		return;
+
 	/* Case 3: Nothing worked: error out */
 	die(_("Cannot construct a valid gitdir path for submodule '%s': "
 	      "please set a unique git config for 'submodule.%s.gitdir'."),
diff --git a/t/t7425-submodule-encoding.sh b/t/t7425-submodule-encoding.sh
index 093238939a..10703b34c8 100755
--- a/t/t7425-submodule-encoding.sh
+++ b/t/t7425-submodule-encoding.sh
@@ -196,4 +196,63 @@ test_expect_success CASE_INSENSITIVE_FS 'verify case-folding conflicts are corre
 	verify_submodule_gitdir_path cloned-folding "fooBar" "modules/fooBar0"
 '
 
+test_expect_success CASE_INSENSITIVE_FS 'verify hashing conflict resolution as a last resort' '
+	git clone -c extensions.submoduleEncoding=true main cloned-hash &&
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
2.51.0

