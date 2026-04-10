Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091B033B94A
	for <git@vger.kernel.org>; Fri, 10 Apr 2026 22:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775861754; cv=none; b=qBE4ZjWJskaNTQTDpZ68dot+0C+Sc8vofd9ZdUaiNy5OFmQwsyB5KDkPayhTxHDsKuZ1VJ1r+wxlT2ghidh7ryn3ThrT4pD7Nt5+m2JOpKLl2aqRYiFvosUz+UXBQ5RJv0gzxNgyd8ZmIkI7Qo3SgxVXll9A1DZWeqWAUWpydnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775861754; c=relaxed/simple;
	bh=/n0GwGwXX2yb6Amu84DFUIKtKBD8IFPhKXf/KNP+ylg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mNVAhUNm94a/weHJR+OT5r//Se2aZtP1EQLeyXj/8Zhp2PmpxjfBsqhKht5yaSSLJnnQvmmLuL1V6ZtLYF2fequ24fnHSRCYs7P4IJZsMMxbf7ENVNak89EjwYRSqZKoJzcG5vymWTQ02fbQEgKudsEEHRZ55frP3mOdU1gt+tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B76pYIk9; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B76pYIk9"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-48896199cbaso27108545e9.1
        for <git@vger.kernel.org>; Fri, 10 Apr 2026 15:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775861751; x=1776466551; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FchwcQ4kYS5wIOOXaOKg/Z2I6jgct87pGlOthSAzOvw=;
        b=B76pYIk9GGiIuQta/Y2y4T3ZChC5s20xnhWXnv7Y4Cf/LGd914W8IHpasvT2ZAki5i
         fHV5yk9FRTXbSXfNFgsWhoMJ8MRxaTBWlpcfCIkszkn/nBXN+qhud8IRe1HKVtq3rLVr
         UlI7X0uFU6BBn0s5QBifQmQDbHO5FEM/lFWjQf0XaawnZ+7FqSHZACEZyxzZFbX7ZTHK
         OfhDcnIaAGXTFXOlGs8fnUI0aIT8Eus+PWkqfRHiRznqBW9HSsmOjKGPG7hU0Pn8gSgE
         t88S5M2tV9AlhDjVgFEfx99fPqAB2pv+mNBxny8k5n0V6U4eROhSW88u3Ecsr5PZKhng
         Uh5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775861751; x=1776466551;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FchwcQ4kYS5wIOOXaOKg/Z2I6jgct87pGlOthSAzOvw=;
        b=a6G2iheomH5fR5sGe2EMIGTKlSrjY63uDOZYLvWclaXilTxT3sn5TQsJAWUHG0jjRW
         NxMfAGUXhTRGqkwxHrEC5EzPse79RkXQ/+JsGwwuOZIYQV7/g4LBhsKe6j9SgqtQYxjy
         JmM0bGwrpZfrYJ6b1JbqEep6P0lX7RB1XaFnM8SpINOnx9nzI3w6bXvS3qE/f17R2/DZ
         T6GSMFHCvF8CFtoImWi4M6i4cPBlDOHy2xwkIx/9mcKCEfVpkp0mPs/vnLD7NfXe+/fD
         ZcYAxaHtFJHnUges/GV9nulmgOU3I6WntsXqgiZ5vLA5BwIuqnG1kqnlMYphKyD8c7fn
         w42w==
X-Gm-Message-State: AOJu0Yxae3SlR+Wq9Rv0dKr+oKL0EzpDn24JIU6yOfeizo9+7Oqjbf/q
	v576fL9EzJTVOGj/nWkb0JtMVowJ9xU3e95W9ak/Q/pqdKOU4EtnNwY+ZrRmRhSzURQ=
X-Gm-Gg: AeBDievesHp6gefj2ZjKtqzFnxBrvM+IhK+6iTfTmN2GOLxNN9WuaD7b7gIvM23h4dU
	2x67a+RVtehW1ZWA4yeTZOHdH2iuy0yUpulH3ioCOl/cI3xlyi5USyH6RrUy7oKenc8pWpjRLF3
	21BHGIWf1UpDxcuvZYK7zxBn1qj9BkZJzB53jMa6WsV0Pi8z0sj8htYNmkvpPG5lIFjZNbkmgAl
	v7fj2BvA1HiF/ICAChf932aZj8DJHoF74Ium+NLMKtulvUhBbG39tk06TXAMfkblSblNEbPYw/W
	7Au/3PZknongfs6DmGiAHCQEaTBrc9migmGqozIOI/UcEkPlpV+nvOGTpMfwlnZsf+08ImYR44v
	rzOR1zMy7heTffMGS7wZFo+M60LiNHleR/Z7TNP1fT3ETLyBVy508Tkmoqx9hlwZ61bfkuDLHCc
	rQRdOxAEmtl2jg0V6Lf9Aaw5ucDd7XmnDY
X-Received: by 2002:a05:600c:5249:b0:485:7f02:afd5 with SMTP id 5b1f17b1804b1-488d680079bmr60350365e9.13.1775861750728;
        Fri, 10 Apr 2026 15:55:50 -0700 (PDT)
Received: from lorenzo-VM ([84.33.160.4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d58a8438sm110842015e9.5.2026.04.10.15.55.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 15:55:50 -0700 (PDT)
Date: Sat, 11 Apr 2026 00:55:48 +0200
From: LorenzoPegorari <lorenzo.pegorari2002@gmail.com>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Derrick Stolee <stolee@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
	Tian Yuchen <cat@malon.dev>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Elijah Newren <newren@gmail.com>
Subject: [GSoC PATCH v5 3/6] repack-promisor: preserve content of promisor
 files after repack
Message-ID: <b483be7558f0efc1a6780b5cff13f4ccc3afd069.1775861047.git.lorenzo.pegorari2002@gmail.com>
References: <cover.1775832056.git.lorenzo.pegorari2002@gmail.com>
 <cover.1775861047.git.lorenzo.pegorari2002@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1775861047.git.lorenzo.pegorari2002@gmail.com>

When a repack involving promisor packfiles happens, the new ".promisor"
file is created empty, losing all the debug info that might be present
inside the ".promisor" files before the repack.

Use the "copy_promisor_content()" function created previously to preserve
the contents of all ".promisor" files inside the first ".promisor" file
created by the repack.

For geometric repacking, we have to create a `strset` that contains the
basenames of all excluded packs. For "normal" repacking this is not
necessary, since there should be no excluded packs.

Also, update the documentation accordingly.

Signed-off-by: LorenzoPegorari <lorenzo.pegorari2002@gmail.com>
---
 Documentation/git-repack.adoc |  4 ++--
 repack-promisor.c             | 30 +++++++++++++++++-------------
 2 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/Documentation/git-repack.adoc b/Documentation/git-repack.adoc
index 673ce91083..33d3c8afbd 100644
--- a/Documentation/git-repack.adoc
+++ b/Documentation/git-repack.adoc
@@ -45,8 +45,8 @@ other objects in that pack they already have locally.
 +
 Promisor packfiles are repacked separately: if there are packfiles that
 have an associated ".promisor" file, these packfiles will be repacked
-into another separate pack, and an empty ".promisor" file corresponding
-to the new separate pack will be written.
+into another separate pack, and a ".promisor" file corresponding to the
+new separate pack will be written (with arbitrary contents).
 
 -A::
 	Same as `-a`, unless `-d` is used.  Then any unreachable
diff --git a/repack-promisor.c b/repack-promisor.c
index 72677f8c9f..6d9590cd4e 100644
--- a/repack-promisor.c
+++ b/repack-promisor.c
@@ -153,7 +153,8 @@ static void copy_promisor_content(struct repository *repo,
 static void finish_repacking_promisor_objects(struct repository *repo,
 					      struct child_process *cmd,
 					      struct string_list *names,
-					      const char *packtmp)
+					      const char *packtmp,
+					      struct strset *not_repacked_basenames)
 {
 	struct strbuf line = STRBUF_INIT;
 	FILE *out;
@@ -171,19 +172,15 @@ static void finish_repacking_promisor_objects(struct repository *repo,
 
 		/*
 		 * pack-objects creates the .pack and .idx files, but not the
-		 * .promisor file. Create the .promisor file, which is empty.
-		 *
-		 * NEEDSWORK: fetch-pack sometimes generates non-empty
-		 * .promisor files containing the ref names and associated
-		 * hashes at the point of generation of the corresponding
-		 * packfile, but this would not preserve their contents. Maybe
-		 * concatenate the contents of all .promisor files instead of
-		 * just creating a new empty file.
+		 * .promisor file. Create the .promisor file.
 		 */
 		promisor_name = mkpathdup("%s-%s.promisor", packtmp,
 					  line.buf);
 		write_promisor_file(promisor_name, NULL, 0);
 
+		/* Now let's fill the content of the newly created .promisor file */
+		copy_promisor_content(repo, line.buf, packtmp, not_repacked_basenames);
+
 		item->util = generated_pack_populate(item->string, packtmp);
 
 		free(promisor_name);
@@ -223,7 +220,7 @@ void repack_promisor_objects(struct repository *repo,
 		return;
 	}
 
-	finish_repacking_promisor_objects(repo, &cmd, names, packtmp);
+	finish_repacking_promisor_objects(repo, &cmd, names, packtmp, NULL);
 }
 
 void pack_geometry_repack_promisors(struct repository *repo,
@@ -234,6 +231,7 @@ void pack_geometry_repack_promisors(struct repository *repo,
 {
 	struct child_process cmd = CHILD_PROCESS_INIT;
 	FILE *in;
+	struct strset not_repacked_basenames = STRSET_INIT;
 
 	if (!geometry->promisor_split)
 		return;
@@ -247,9 +245,15 @@ void pack_geometry_repack_promisors(struct repository *repo,
 	in = xfdopen(cmd.in, "w");
 	for (size_t i = 0; i < geometry->promisor_split; i++)
 		fprintf(in, "%s\n", pack_basename(geometry->promisor_pack[i]));
-	for (size_t i = geometry->promisor_split; i < geometry->promisor_pack_nr; i++)
-		fprintf(in, "^%s\n", pack_basename(geometry->promisor_pack[i]));
+	for (size_t i = geometry->promisor_split; i < geometry->promisor_pack_nr; i++) {
+		const char *name = pack_basename(geometry->promisor_pack[i]);
+		fprintf(in, "^%s\n", name);
+		strset_add(&not_repacked_basenames, name);
+	}
 	fclose(in);
 
-	finish_repacking_promisor_objects(repo, &cmd, names, packtmp);
+	finish_repacking_promisor_objects(repo, &cmd, names, packtmp,
+			strset_get_size(&not_repacked_basenames) ? &not_repacked_basenames : NULL);
+
+	strset_clear(&not_repacked_basenames);
 }
-- 
2.53.0.584.ge8720aaf12

