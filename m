Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793574281;
	b=2lrXCAeXLrZkWTA04PolHs/c41jgUvw91Z5+4UT6vvC6s+lRNHeoTCr/KHSuwRMSncYE
	 vco+BM7hWxwCTqJO16Cd+znX9+N9DzwNFqao3As+neMSAvDIs1vDjW0jL+z0F7l6pQSOY
	 VhGJGy1hD/tUvy+OIiKOvuku2hQ/Zwx+otOwxOHfEqRNljpnwB91Ei8c2J1xyFvt9j+Q0
	 3qn0wMaw0W/YtdzHiR1gkGUJJKLAABACmZSL/kOjELlV4TWj2A7HiFBWEBljMhaLR/6K+
	 Eg6CqkO58+QIa65WxN9bvxa2V0QUhwh9noSC1m2QiGbYiiuD3LbQmD3nDElfWEQmdPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793574281;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=GxOWPX9IKa1Tik4gyxp8Rzlc6GbN0W1kBX7x+r8vr5g=;
	b=E5iSV0ccDbfCKJjYYlDNXDKJGeVkt8wosVQG8s474M2MoEYcSXDHJ5ctx1mQf4JwpDPM
	 IRWKcKJw/pEd6N/sEJhU//guymATe+7p6jZ/BP0+f7tWFSif9U0RpXOtXQyZgq0XOuMjZ
	 RRbA/qb87Ygo8kRoTA6s2XT6+ELP5T48b/ksReWLbfa0TFPBRFENOqDdsbUpjqWFLqOFl
	 CfTvrKIYMu4BK0lbM1+fVi0tkVNwQt9YNGXe7yVo09/DzgAcR2P21GHNe5NE0ei5Gakz6
	 3cJvbocn7+oJOrTAYqizObCNqRQi6YYV3dy5hwISgWtSHlgX/IC6BILjKk5HxYbGKrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WciN9lB0;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D02C60A2602
	for <git@vger.kernel.org>; Sun,  1 Nov 2026 23:04:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4D02C60A2602
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WciN9lB0
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a2167bd087so19105905e9.3
        for <git@vger.kernel.org>; Sun, 01 Nov 2026 15:04:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793574280; x=1794179080; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GxOWPX9IKa1Tik4gyxp8Rzlc6GbN0W1kBX7x+r8vr5g=;
        b=WciN9lB0Oc7jcMJ6vrjQibPtHCwvfovyNYLYIVAwoNA1b/egCZdH+lwv577Luzx5NR
         RnQFESlJjJW2bCzRcWijE9F4+DKExeeMPmIJinDQLQ6uPYmSjzy2JtUhLMAU+tPFV4m2
         BtIm9HkLAYySHj9Ndg0firJbhoJ9Bv56ML2pWPQfClXrdmZNGvmQju6Q2vZAImNkCtgl
         PWW1/qnJJ82J3N3WiOaNyTJhfcEPu9nSzY0uhHDmrzziprugWUlD/KvsXeCC5fQLmh62
         SBi/gKqcpP010xqJlylN9Vst4rBvcSQg7Sf/W7I2O/0C/VGQMA89CEEl+qrMMocq1G/M
         pmpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793574280; x=1794179080;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GxOWPX9IKa1Tik4gyxp8Rzlc6GbN0W1kBX7x+r8vr5g=;
        b=VdTniIsADXR2orLz/h52QvfEy5U3kvhDRTHkJuGlMilAWhPdhIopGThoZj+Qb100pA
         0xfefO8CHxwvQ4QzTywwuWMsacyDRh2QAhg0EBh3h3+/f6AQ1fx1Z1fDaWFbXhZXOOJ0
         EBHP5OkqGzzB/8Rt5h+g/GcZTEX714Ky+81E2jLP+YU27CKbEU8HZA/imtlUzk+J8wZJ
         bviECxxJwy2P3DxrroYwJ2bhzThQDWxwIsqBbv6EFh2SqKBObxioQHRPxtal8QewVfoD
         atIiVS1WolOLI3HkdK/UAHdWP9Ez6fldTpDx/N5ns7jxjGxshkKDBqV20yg/6KReK/1k
         jJCQ==
X-Gm-Message-State: AFq9FYIbGwm52K4g2ZaNPGb29ar/1daC1/Jyt0vDPVoYlZMO2TyctsoF
	D8oTZe99tan/wZ2PvV8/8a5dr7NMtiCSOXpi13+wd0JDIm6GSohMFz73Vjvifttm
X-Gm-Gg: AYBFou1xuMgBz9iqMqEjGCAnkbuO1FFDq8yKU1z/YEuivas/VJ7EtB105RaXp/lN9Jt
	1owp9jLLG0BatyA5YjM/Fb9QkPUZW+V92slMc8FzSTxY+pve1Ei2IJBeaH+PVpkWfQ8dxxBT0BL
	ALAXsbpkPi93KEvAxTuHaQar/8sL09m13acezCW+5/vU9FO/9xD0x2XTywB4Au86/i/IG6+aohk
	tTxeRrrZ9AzeZYQuZ5DJ7+PFJnX+8jajx9kbR36U6tQtONxPBkfhn6gxnw8scWUh3HjI7xTmRBi
	IHsjDlNq9laxdXQsOIAS2ph4HyXfl5nnECcOvaPCy+ZmWVBByLKkOhm/ROC+1TuI0L+a5Zrq3pA
	8M9IgxOdPaHLDiS39fOdZC2jAZ87mq8alm2o51+cmbGuIAJ4ZKYUhQhtFXZQm9o9XoTygOZi/aw
	/QTvX1JPg2bvMOkQpQsoIn9SfOLEL+7vQB/YioQkEeDAEP3I00QT1Jkuv4vCMNFAY58C+q8BzgI
	rdmLmycYOau6kPhpM7rmFc90gU5Jt4JJrDfVXrB+Ht6KQD0KhjJkqZeZVu2y1eJJBkKCw4kYFyI
	N1Mx0c0sQmLze6VoUot/2Q3J+c/HRJStja8Rv6dz+tD8rwXmbMVf5fGMfCx8ZNZVXsV73XfkbMl
	+QSPuIQWNVABNjU2D+CEvjQ==
X-Received: by 2002:a05:600c:3b88:b0:4a1:cf60:dcc3 with SMTP id 5b1f17b1804b1-4ac187a6ffcmr202627025e9.29.1793574279768;
        Sun, 01 Nov 2026 15:04:39 -0800 (PST)
Received: from u.ad.analog.com (sgyl-40-b2-v4wan-169439-cust3365.vm6.cable.virginm.net. [92.234.157.38])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ac0b4df257sm135151125e9.4.2026.11.01.15.04.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 15:04:39 -0800 (PST)
From: Andy Koppe <andy.koppe@gmail.com>
To: git@vger.kernel.org
Cc: Andy Koppe <andy.koppe@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Karthik Nayak <karthik.188@gmail.com>,
	Julia Evans <julia@jvns.ca>
Subject: [PATCH v2 4/5] refs: stop calling root refs pseudorefs
Date: Sun,  1 Nov 2026 23:03:22 +0000
Message-ID: <20261101230326.3675597-5-andy.koppe@gmail.com>
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
those root refs and restricts pseudorefs to FETCH_HEAD and MERGE_HEAD,
so update them.

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

