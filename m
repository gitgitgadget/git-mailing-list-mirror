Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794521207;
	b=Z7v0oXmWT8fN8vNYGabUlmyU4RY8CPgQpw2gsKp19jVRl6/51qxKBEwMIwjrmztHN/Wy
	 t5wt7nasJ/n57cKtlfmHxxDMIf/660aVKtJn20mw+LSi6rpm5SKPYppBSn2iUVEDslPnD
	 Y2WYlXgHFX/3uBMEozNTHXXt8DvWmLekjWVvT+ywkikSfcRrctBdGq9t0DXLD9AO8wPkG
	 Vl6gl7Zjtf6UGtvYiRQnQ5WfyVZm5osuo3RnyniKjBOyLcL9r5gu2jr65bqIiG3r67GKy
	 /EZ7Fhhwrad9r+gxHI5jCELSL7EmQMd706KIpf0sMYEIzGxRDmk/eQN4rvxJhXgyoyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794521207;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=yrSYFWN4GugDD4l9/NubgnOGwuVLg9oVlxrP5XJpWdA=;
	b=4U18ODafjGP2EgGxGAcM+foPDj5R5aLn6/ZrDYTgnUel3/lh36oO3mcUbLkymaU8fPBL
	 DGoMTZIWy7HAu1EpFKyKZqBK1+p6ikBvAtq1dNsnNwMBJ8clT6WUwMmvthAX5uIZrH3WF
	 NqRkVhJPCpuezfVJf2qD6YMSICjyAlZgQAsVrHAEbgnGxCtyu39E9zc818RPSJO/IaTLd
	 ep292l+AYkA0/5agM/Ae4er/pwu6NXhmuc/rDihyB2HbejY5YVKzlkndfKpsqVZkEk1pv
	 cyNcEzX1eX3xhzUmwfWJhUSJIlKS7nDGq6UulAxF9vO48K0Gp0zM5El3GcvQ6NmbSOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tPleeYJS;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D53606A33B
	for <git@vger.kernel.org>; Thu, 12 Nov 2026 22:06:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E4D53606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tPleeYJS
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a1b07c3c5fso3447495e9.1
        for <git@vger.kernel.org>; Thu, 12 Nov 2026 14:06:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794521205; x=1795126005; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yrSYFWN4GugDD4l9/NubgnOGwuVLg9oVlxrP5XJpWdA=;
        b=tPleeYJSh8EAUvqEMaDWvIeQ/Awc3h47TAq9ANyh4SherqzrbjaqFjsNpD60WDEhEQ
         UEOz0dpFCZsAkamR5TjJ0AeNJe9bVWOBYxfrYvKaA1fO6SDkELBEG9RleSC+UdtMViDU
         vj1Ubil3Ttob7aoXqSz9HJe4olw8CvlkhCHH7gqZoKDUotDCAQMlpZZTo1Qc2Z9yNeLD
         SK6GJYQVxh/vpPYzfqwchVoqKmoLCkTw2slZ5ZA0I4kfh6VYmS8uxxCGLGcR25F3Sagj
         rvyU7lO2abZzhQi2LuUJQUicfC0c2QuqcujNC5FlkOZhA7UPwMclgmCtwYi5UTWESROv
         C1qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794521205; x=1795126005;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yrSYFWN4GugDD4l9/NubgnOGwuVLg9oVlxrP5XJpWdA=;
        b=RUfJOrs1yn0vZUdapfXiz5BQyoWaNoXYVc9DldfbrVK6AftOvdVbswBzjSya0m3fDI
         PWhax0u3TfsP474KKJw5dmEy7zjVZCFiTdbdh4DZHEMbGTbxKnZ6fmDFkggVKlDYw4VJ
         pekkgcAy/t45xQtj1P2GttoBTZC7jyS96Jw6Uqy9N0E3MY0BazUaru4AewAaZBILom3T
         Sx5PYVdGMWw39HaXkcsRxKPARadNQBvynskbQzlYC/KT9X29enUrpqrSUq0A4QCO7L2w
         puIRKwLhoN6qmCsfoRUSjoe3Yhek0/PMzEhVu7Q8CeA15kyEc6ZbHv+ueYPlIFXP1SuI
         lrmQ==
X-Gm-Message-State: APuU4Z/3eKFSS+E7ij03uX7GGRnG0uExkht2YTy+Bur41S3BDCZBO0Jf
	czq9UheBKU0biksiBNG82Wk0zEOsONRaADFT4HX9Jdj8LfCaZ9SdMcttAXXy/ef+
X-Gm-Gg: AYBFou3FmgBFG+brYKfLPajDlYTmC++186HRCq5mwvVbSv+4OFFWrX6MWTvlYS9RWZs
	QqnmE33DDv3yKD8aHq8IasTN3hzGMLq/n0OBTBwP5c3Z4y6qilqu4VLyq3FhFWaJpNRSaEW2gtj
	/5dIevg+WkviNuaAAmi2feL+o7m8CJjA8waxubBJqewK6l2XXfaHdr0a84ER9lAzNYCg3GJyOa5
	dQkcvUvjJdcnCx+AXl1ztJFqFOiFTePcku89F750mkl59gorzrJfgbIKszsyoAW6V1/BglMPwsN
	nnab6t+2MeVQlDNRoX28xMILe74c3GJ2voIFolUd3aH+5JxJ2XbxyK/14kZ6rvry6YPjazEdOFu
	ax0PK1ps9LhQ0nnVcCrj8RIp5H27HOhEzSP24GCFCkgrcjF6D/85fJ5y1xpy+YnZtoOcA0Ne7jK
	R5SisEhYEOo9c4xmO1F1UHqO19hALboCTKHoMOuYpgAUR0SPvoSGePXPnRQ6t6zKWI/4uWY2V8b
	tSZ7jxktAw4sUYqGWD2Zd4IupuwELl406dSD496k4ZE7lJAmk6WgByFQWGCtcxScoHtf50heFlE
	6bPpKpEtxy0pvT19m/s1fWe7PyYHJXYWDFKu/PK1aWzcsHm7tI6o91BS9+KR+3dqPmcGVyWOB1R
	4GiASNA4nQWtoCJehQCX66g==
X-Received: by 2002:a05:600c:37cf:b0:4b2:2ec5:8a2b with SMTP id 5b1f17b1804b1-4bb55a4301emr13045185e9.10.1794521205399;
        Thu, 12 Nov 2026 14:06:45 -0800 (PST)
Received: from u.ad.analog.com (sgyl-40-b2-v4wan-169439-cust3365.vm6.cable.virginm.net. [92.234.157.38])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb4e29daa5sm106098995e9.12.2026.11.12.14.06.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 14:06:44 -0800 (PST)
From: Andy Koppe <andy.koppe@gmail.com>
To: git@vger.kernel.org
Cc: Andy Koppe <andy.koppe@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Karthik Nayak <karthik.188@gmail.com>,
	Julia Evans <julia@jvns.ca>
Subject: [PATCH v4 4/5] refs: stop calling root refs pseudorefs
Date: Thu, 12 Nov 2026 22:05:40 +0000
Message-ID: <610138169d8feb979a387b5ff6ef90967c0c8886.1794520948.git.andy.koppe@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794520948.git.andy.koppe@gmail.com>
References: <cover.1794000450.git.andy.koppe@gmail.com> <cover.1794520948.git.andy.koppe@gmail.com>
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

Some messages and comments in the code still use "pseudoref" in its old
sense of any ref outside of "refs/", whereas the glossary now calls
those root refs and restricts pseudorefs to FETCH_HEAD and MERGE_HEAD,
so update them.

The "--merge" error message called MERGE_HEAD, CHERRY_PICK_HEAD,
REVERT_HEAD and REBASE_HEAD pseudorefs, but MERGE_HEAD is the only
actual pseudoref among them, and merely listing their names suggests
that one of them should be given as an argument. Instead, say that an
ongoing merge, cherry-pick, revert or rebase is required.

Bash completion function __git_pseudoref_exists() is not renamed, as
there is no obvious term covering both root refs and pseudorefs, and
third-party completion scripts might depend on the name.

Signed-off-by: Andy Koppe <andy.koppe@gmail.com>
---
 builtin/for-each-ref.c                 |  2 +-
 contrib/completion/git-completion.bash |  7 ++++---
 refs.h                                 | 13 ++++++-------
 revision.c                             |  2 +-
 4 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 4a2fc421db..6ff32e919c 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -48,7 +48,7 @@ int for_each_ref_core(int argc, const char **argv, const char *prefix, struct re
 		OPT_NO_CONTAINS(&filter.no_commit, N_("print only refs which don't contain the commit")),
 		OPT_BOOL(0, "ignore-case", &icase, N_("sorting and filtering are case insensitive")),
 		OPT_BOOL(0, "stdin", &from_stdin, N_("read reference patterns from stdin")),
-		OPT_BOOL(0, "include-root-refs", &include_root_refs, N_("also include HEAD ref and pseudorefs")),
+		OPT_BOOL(0, "include-root-refs", &include_root_refs, N_("also include root refs")),
 		OPT_END(),
 	};
 
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index c3a49e2e22..0e24839099 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -147,8 +147,9 @@ __git_eread ()
 	test -r "$1" && IFS=$'\r\n' read -r "$2" <"$1"
 }
 
-# Runs git in $__git_repo_path to determine whether a pseudoref exists.
-# 1: The pseudo-ref to search
+# Runs git in $__git_repo_path to determine whether a root ref or
+# pseudoref exists.
+# 1: The name to check
 __git_pseudoref_exists ()
 {
 	local ref=$1
@@ -954,7 +955,7 @@ __git_refs ()
 	esac
 }
 
-# Completes refs, short and long, local and remote, symbolic and pseudo.
+# Completes refs, short and long, local and remote, symbolic, root and pseudo.
 #
 # Usage: __git_complete_refs [<option>]...
 # --remote=<remote>: The remote to list refs from, can be the name of a
diff --git a/refs.h b/refs.h
index ee3b8a62ef..307ca1e2df 100644
--- a/refs.h
+++ b/refs.h
@@ -85,7 +85,7 @@ enum ref_transaction_error {
  * Even with RESOLVE_REF_ALLOW_BAD_NAME, names that escape the refs/
  * directory and do not consist of all caps and underscores cannot be
  * resolved. The function returns NULL for such ref names.
- * Caps and underscores refers to the pseudorefs, such as HEAD,
+ * Caps and underscores refers to root refs and pseudorefs, such as HEAD,
  * FETCH_HEAD and friends, that all live outside of the refs/ directory.
  */
 #define RESOLVE_REF_READING 0x01
@@ -448,8 +448,8 @@ enum refs_for_each_flag {
 	REFS_FOR_EACH_OMIT_DANGLING_SYMREFS = (1 << 2),
 
 	/*
-	 * Include root refs i.e. HEAD and pseudorefs along with the regular
-	 * refs.
+	 * Include root refs, such as HEAD and ORIG_HEAD, along with the
+	 * regular refs.
 	 */
 	REFS_FOR_EACH_INCLUDE_ROOT_REFS = (1 << 3),
 };
@@ -1306,10 +1306,9 @@ void update_ref_namespace(enum ref_namespace namespace, char *ref);
 int is_root_ref(const char *refname);
 
 /*
- * Pseudorefs are refs that have different semantics compared to
- * "normal" refs. These refs can thus not be stored in the ref backend,
- * but must always be accessed via the filesystem. The following refs
- * are pseudorefs:
+ * Pseudorefs are names that can be used like refs, but have additional
+ * semantics. They cannot be stored in the ref backend, but must always
+ * be accessed via the filesystem. The following are pseudorefs:
  *
  * - FETCH_HEAD may contain multiple object IDs, and each one of them
  *   carries additional metadata like where it came from.
diff --git a/revision.c b/revision.c
index a83e499047..7b64197155 100644
--- a/revision.c
+++ b/revision.c
@@ -2000,7 +2000,7 @@ static const char *lookup_other_head(struct object_id *oid)
 			return other_head[i];
 		}
 
-	die(_("--merge requires one of the pseudorefs MERGE_HEAD, CHERRY_PICK_HEAD, REVERT_HEAD or REBASE_HEAD"));
+	die(_("--merge requires an ongoing merge, cherry-pick, revert or rebase"));
 }
 
 static void prepare_show_merge(struct rev_info *revs)
-- 
2.56.0

