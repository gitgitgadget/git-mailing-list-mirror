Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794000877;
	b=TECRNt0GHSvApq6sJgA7EgyVzHHLtzCJ5di7TexixHDUKVqzyH+PCyJ4H1zdFqIA5+yK
	 9blSwArdyxLMqvfcwAUcUjPeHvwi2q0lua3wRTGj/ahi1FnIrZOT16sgdylYp5K9KEVFE
	 0LFebEJiBxlm8rJYS5yjChOanvIW3K+nB8YNaFg4yKBUQZAsvLQndBHWVTU1VOlD2lnPA
	 GBI0j33RANvRtBl8K6bROstMbWLmyfylupIzAbSGc44+Js1B5rQGS7PMLa0KEGK4PEH7/
	 0/bauVmHD7BgYIn2BysdnwsawE9NEXNVwzuoABbSphbxBaGo4S8YVrqiAyjuODWV9vQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794000877;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=GxOWPX9IKa1Tik4gyxp8Rzlc6GbN0W1kBX7x+r8vr5g=;
	b=oizBDncPO0rvqPLRfF7N1DQWaNioKTmeLR1Szzvq3hscYxT6aiLbd8ySoLN2szEZQY+b
	 hSy9d3OrfGJ7X2D8Pye8KfLcjvogW0dDYi2al+tIpMShs/ZhLG42ER99ZI8oDuaTdiKM5
	 43nwv0X3trPD/EbsclMkuYd2JwmFdF8v8crBUb77wMtjeYhwVPLKoP+GJVF5l9gd6Pqel
	 IDnhMzHPzeUksgJGcr0GCywoKC//3UJ8LHSW0gcJath0SaTUa89eaO5Mq5IUW2B7kTw6F
	 suWFVDf4qlHWMY+DKD6uGqG2c+qvsbpZFeql3W5bhHHwxBKSOMukdpjoS4Zl/Vx9OwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GURqGWZw;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3507606A335
	for <git@vger.kernel.org>; Fri,  6 Nov 2026 21:34:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C3507606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GURqGWZw
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a3517554f7so11387325e9.2
        for <git@vger.kernel.org>; Fri, 06 Nov 2026 13:34:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794000875; x=1794605675; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GxOWPX9IKa1Tik4gyxp8Rzlc6GbN0W1kBX7x+r8vr5g=;
        b=GURqGWZwtPXnKJy4kjtAJPemDLwzhqe15MzAiClrWQFJn+pIRoUQ2yOxSxYP9buahX
         ozDoDixCNz+tjWgerhmEj8qPIqV7e2+B2yFXpctLBtxEcoZXPjcjaVVMUm48RHno5J6y
         HpZzKDzu3CfdWahmoj1thjvn8xWkllpyW3EkSf2vpcOCba5qbyjReUGEYfDg0WxfVNsJ
         ARkbFOBlQHU1X2Mng3B4CJpTAl7lEnQNFAYiYI3XQvvq3V/rY60kbmckm4tQTyJvwMI/
         6jvIYBiECt7YKJlHfkHUJ/mJdIu1m/QLSlmPZTkcJ3g6em4oQ5kFjoy+uThOPO2Zwa7f
         mw/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794000875; x=1794605675;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GxOWPX9IKa1Tik4gyxp8Rzlc6GbN0W1kBX7x+r8vr5g=;
        b=z8uLsD+Z/cit5RwdWLs3HBuRwz2Mzm0UWfvYbEOqa5NTMhulovk1lI7zWr3saZ5/1J
         MgMTHJzN3/IgTrk62TjRf4uHiZim/ugeBm+I1WDf7Buhv6daSOJZ+2OxrFikQlHk3VK/
         beDu4AspzpcX+3bykUkGFqlr10QofusDviF+taxsX8yP/rj6+izbFQhbTDCfU85vPCGI
         MEbqFCAVw7Xgy4fl6IAAi6mOWoq94QYcQaqPNlA0MS30Nz0S6eGcqSnjoHIqPofCVtyQ
         VY/PvvY6r41s2DV4DbpueUgXHq3LG8T825RZ/j96xmFXRaPOd/TKnFNhFgHWQuJXBgCz
         sZkw==
X-Gm-Message-State: APuU4Z9DEPyvrNy/N28r4l89WL5/nK4LSpoX3CN+GLIjCx6mcYzZ/AHM
	rX3mKzUUBLEXUd1fEpkZDgxmdSxhWdxmVCRc7kzYcUiWuJCScRybPU1f/NpUUUzj
X-Gm-Gg: AYBFou08sYZjoTjPDZAJtcNGl5fbtkdhhqLQHPCmGiTDKHwINkmYsN9rz+tabAHhEZN
	rGX3JBbuKHo++FORsjjR9F4ieghmXuWWEo8KV4ZHmU6qIeirxrkFitjAR+SpY6PXEA1ZgjpRwzF
	dPtPgVZDfPIEw9x4IERZIevTjUSLctQQ//5W3bnTVH54z9x6FixBxKlVaeoKvCpCpkWJmHAow0S
	nYALMkXlGocO0KkerkoTcP9ws89hX969fVvmvduvgizqQMDWQBUsAKGBDXfs9Wc8gW8KWooU20K
	hVBrBC6hEmpZlG3tYlOMxaZ0sPfUxqNEILi/PgMFU6FtG+ghPqnfGhGrJfVS14a8XakpR6M0EuN
	d498415iD8kk7PudvB7bmgI0uumC61MyDdN5AV4KENeFm9eZq45NIHEDwnsTDtuGZ1Z8ZiVVmYG
	ZJzyePzKoNzUXK/zq+WDZyuPTWMFo32H0GF1u3d3UK5R+lmqN8n5mbxkwjXvooaEzllDFGaDQnN
	M5wUS7qUnCIIQ59PNvjhZ/bQLFBDs5hXrkfqqD5zet9uw/xc3I/Qwu8jRj2sh5+KLOEHCZ8T21M
	E/WYLUOxNKeCsoaY/ZFhNl1gEHsoDjeRfcFXojKeLJQn5rHBWjtCv1PDo3S21GuaiZX68ZA/i3P
	4RS/WsmCLa2tYe+8kMr/nlA==
X-Received: by 2002:a05:600c:1c19:b0:4a2:1612:636e with SMTP id 5b1f17b1804b1-4b6de3b1a6amr81517035e9.5.1794000875171;
        Fri, 06 Nov 2026 13:34:35 -0800 (PST)
Received: from u.ad.analog.com (sgyl-40-b2-v4wan-169439-cust3365.vm6.cable.virginm.net. [92.234.157.38])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b7e3271867sm9994385e9.6.2026.11.06.13.34.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 13:34:34 -0800 (PST)
From: Andy Koppe <andy.koppe@gmail.com>
To: git@vger.kernel.org
Cc: Andy Koppe <andy.koppe@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Karthik Nayak <karthik.188@gmail.com>,
	Julia Evans <julia@jvns.ca>
Subject: [PATCH v3 4/5] refs: stop calling root refs pseudorefs
Date: Fri,  6 Nov 2026 21:31:07 +0000
Message-ID: <2c3f3ab1951cad3771f5856ed8146286bfb0f5db.1794000450.git.andy.koppe@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794000450.git.andy.koppe@gmail.com>
References: <20261022212903.177261-1-andy.koppe@gmail.com> <cover.1794000450.git.andy.koppe@gmail.com>
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

