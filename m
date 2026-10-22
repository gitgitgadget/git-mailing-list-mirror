Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792704588;
	b=Fp9S4ea++VnOkznQn4Bp6VEZ2904nTAzmu2UY4oAxFAQ/h9n6hBFPPGqF7K1MALIyntB
	 3ah/xvOKkLTru/UdbCgRAr2dScbttdWeQDJ0Fpbct0sOo8KrYzkxjf2RsojSc05EInbga
	 ozGpU708EGUN/wJpwHSWfsrjek/dhKPyZIAdwO5pucDPyWEABAsmLB3REYy9SBqkPjFLk
	 o9V5MHNmM2fxIZ15+K2mTMWB8RdRJmyrAEQgcpCVN4iMU+SGeu3ae4r1PRj7AXQU6EwVC
	 WrbfhulyNiEeOFohcef01564KR4ZKz3mYN4aZ08PvUgVjg+01RMJEherxYSlEu5KMIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792704588;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=OrN4GpjQoTibMYUrXwvKWO7XlnL0P2/Oa6v/Znmxtvc=;
	b=vKzbH5eF4ggissqtHtfafVz+eXc8tz1DOi8fgKXzVz80w3bzgyF8TgjrDwWlO8L/wfmY
	 fbuPaumV6Bfy46RIFU8RAHfI4UuVh3CGVsvA0jBgTJHwker+Rhh1WkaDhBHhEQEP70pri
	 Ugpo8KzVUJIXRAEFdcR0XgNP3Jga8A5zrXPWq1PmeIJZYYA1sq4/fLyI10U7pUROUVupF
	 SRiZQEuuEGunIYbr02lWksaAY3cB4ZifvMztNinfFs5pTWptY3PeZKGptFRPkaS3bBGma
	 GyIa8jI4Rux6FsaL0d5ZBLRhhBA3VyGHd9SBbNcQYscmv01g2emOzSONYNaVwgYMh7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=shHKHZrg;
	arc=none smtp.remote-ip=209.85.221.46
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0FA6606A31A
	for <git@vger.kernel.org>; Thu, 22 Oct 2026 21:29:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C0FA6606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=shHKHZrg
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-487049569b6so141696f8f.1
        for <git@vger.kernel.org>; Thu, 22 Oct 2026 14:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792704586; x=1793309386; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OrN4GpjQoTibMYUrXwvKWO7XlnL0P2/Oa6v/Znmxtvc=;
        b=shHKHZrgo2xn1B9Odzq6l7R+aAHr8PRDXW9MYkhWX7U2lz7RduafGkDBWQ1u50np7t
         b1jTdQr4kWaZNq7//Ynbkhfv11LPKWCSmsU8d+93ooDiHbKZRB04q/RpESDThnJ5xDAm
         GQlLGfF7bgOO/mImMkvC3OYyWWA+4jeDKq0Cm3aciKnSswO8ftFjgIj4Rxjhn9o0IWiO
         NpUsjH8hLXdpNaHDH2JT3Se6JYKkBtl3AC6GKlKmsyfJz6xnQgjLO5PmmkBrNPLW3ToS
         HXFJJWp0OqHkYG7tChM4mFlkRekKFhDd+lVzNBgGVzY7CUNy7XcgpyVigCTZtkCEncgp
         8mAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792704586; x=1793309386;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OrN4GpjQoTibMYUrXwvKWO7XlnL0P2/Oa6v/Znmxtvc=;
        b=sNrcR+DiH3yCtepVi76eX92/R+AudFuhUt/Q3fSC10WaduE7pc/6WfMBJyohEkx7+W
         re4qgqvtky1FXiBe9N4TEQwRJZlS3zII0sdSsqK/YhM9f9DxG2z1xHDQPgt31tRf3NHI
         ak14z2lh4C7mKs5d0p5Q/5ZAy+Aeleu78KG03Gr1WrIIveSQ9jNs2Wp5GX9eEmk9QDZP
         wBrpnIthDIR7/+9BPUQpfDSWBNqsLEUupRKmvmTzYOffvR2N5ucQ5ISZOFOaAwQ5tJcx
         rFGwjdUI8KJkm8nhNaHCn6WDoUS/euit0w0eyh0U4wk7F1UvYlsflgU1eTLsnj1XzpHW
         tkBA==
X-Gm-Message-State: AFq9FYKSeBjZaV6/wqw/N0JvyFBFaGflcplxqrc3RMhwCTgTePoflHae
	fwPagWEBag6hlxznknMB3GLs0sti4lO6Zpaw+PQYMeFAYGuT87ITVOlCIKBQCDoq
X-Gm-Gg: AYBFou2ZqkPoIPjIMd3ff8k84hfEKpZUwODz6NT5c2GlEU+k9qXysjAG8CCtdzd9LoR
	/Tk7PqGXEXuv4fH0OT/mMjBZF0Lg94VMbEJVB4kbesgd0xeHSPF8wJqGGBRrl6RFLa6mWG/hunZ
	FhZc3m1VekenX7hM7DF1gKO09jA4Q3Oz9WAIrjVGErPinWHUcodf5zHnxfA4sipu5w8gYuwKyE4
	eCmRoRQH6o8wOI8FkAFOyeuLiaEzUPVvxcDdLnIb4Lbs0Ow36CLCPAMIGllo4HzGDcRffTNV+pM
	X7KyTvG9VMsJT3F0A2gQjtTo2NLE8kDPoLFhU5PB5be4xR/Jj/FbqgM/1Gf0e1k7JdbhqaXvmRx
	aU62b4zimBerkyDpOmJDD6sNLU+WZrPbK2A9tPgIn5Krt3A0WDPreIFUB2WvU7xkJOWA4qgFJXq
	V8MpBgXP/q1sfXZ05w9GMfXYss+SKbKP6EY3VCr0eniauKVU1V7xtp7Jo1A3iYySN892+jOuoLf
	38ZG7n+18877FLApQhC6B58XDve5nk1Xk/5u5sAuXbkXVh9eVIM3AjgAAeAyeuR4ZJOijNUrfvE
	Ad4rRdTiTTMrtHFBwXs0BAbBajw0/I2N8HRpywyv0HviDc3b
X-Received: by 2002:a05:6000:200a:b0:48d:fdc0:8bf2 with SMTP id ffacd0b85a97d-48e385af178mr126875f8f.41.1792704585966;
        Thu, 22 Oct 2026 14:29:45 -0700 (PDT)
Received: from u.ad.analog.com (sgyl-40-b2-v4wan-169439-cust3365.vm6.cable.virginm.net. [92.234.157.38])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e38044e8fsm739355f8f.31.2026.10.22.14.29.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 14:29:44 -0700 (PDT)
From: Andy Koppe <andy.koppe@gmail.com>
To: git@vger.kernel.org
Cc: Andy Koppe <andy.koppe@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Karthik Nayak <karthik.188@gmail.com>,
	Julia Evans <julia@jvns.ca>
Subject: [PATCH 4/5] refs: stop calling root refs pseudorefs
Date: Thu, 22 Oct 2026 22:28:52 +0100
Message-ID: <20261022212903.177261-5-andy.koppe@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261022212903.177261-1-andy.koppe@gmail.com>
References: <20261022212903.177261-1-andy.koppe@gmail.com>
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
those root refs and restricts pseudorefs to FETCH_HEAD and MERGE_HEAD.

Replace "pseudoref" with "root ref" in the help text for
"git for-each-ref --include-root-refs", in comments in refs.h, and in
comments in the bash completion script, including the one for
__git_pseudoref_exists(), which is also used for root refs. The function
itself is not renamed. There is no obvious term covering both root refs
and pseudorefs, and the old name might need to be kept for third-party
completion scripts.

Update the description of pseudorefs in refs.h to match the glossary.

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
index c3a49e2e22..e12ac0359c 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -147,8 +147,9 @@ __git_eread ()
 	test -r "$1" && IFS=$'\r\n' read -r "$2" <"$1"
 }
 
-# Runs git in $__git_repo_path to determine whether a pseudoref exists.
-# 1: The pseudo-ref to search
+# Runs git in $__git_repo_path to determine whether a root ref or
+# pseudoref exists.
+# 1: The ref to check
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
index ee3b8a62ef..3be7ef3b0e 100644
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
+ * Pseudorefs are names that can be used like refs, but have different
+ * semantics. They cannot be stored in the ref backend, but must always
+ * be accessed via the filesystem. The following are pseudorefs:
  *
  * - FETCH_HEAD may contain multiple object IDs, and each one of them
  *   carries additional metadata like where it came from.
diff --git a/revision.c b/revision.c
index a83e499047..d6dd56faf1 100644
--- a/revision.c
+++ b/revision.c
@@ -2000,7 +2000,7 @@ static const char *lookup_other_head(struct object_id *oid)
 			return other_head[i];
 		}
 
-	die(_("--merge requires one of the pseudorefs MERGE_HEAD, CHERRY_PICK_HEAD, REVERT_HEAD or REBASE_HEAD"));
+	die(_("--merge requires one of MERGE_HEAD, CHERRY_PICK_HEAD, REVERT_HEAD or REBASE_HEAD"));
 }
 
 static void prepare_show_merge(struct rev_info *revs)
-- 
2.56.0

