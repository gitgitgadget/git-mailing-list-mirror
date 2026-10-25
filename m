Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792959926;
	b=GqCaA/gLJLl7hJhDL5R+DQlS4P5u6QCZ5XJ5JM429ivd3Vo3MfzetbtTcj5hi61FLtkz
	 CxI/wWvXk0yOnmEUf+Gm8PMohCMpGQ6MsAZm5oq2/5+6HHaO7L8WcOp7ZPi+6v35CDSKi
	 cHVB0hKGwxtslEyMrzSwXWGt9uIUTG3rwqo2SodUuGPvV4M5t3MZsWxdeYoBKuTSLJtIz
	 hMKW9szs36V/Q8oeA4XgYXGEszkxtuz3eQksXKfnEStu3aFDEH1633IrguPJ/STJl3X4x
	 a8baZwdflKDDNWG4m0ScVvAZo9q2DwiIE+a+c3nbtdpu1N9SXD0bse7d5REqcU7Mctw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792959926;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=aNPBPmeWCtFjxPx5kv+txz4v7XkowgD3+OUKZYjAJRg=;
	b=Vq0CpR4ClPUdGLTQhF39lNBN0uYIMeWLa0VNXYLES+X2j2Iu9ISWlkl6NJaSa9HakzvF
	 jAKCPhL5Yx1kdOrX3tr6g93LABKGl0mtvzKNsbnNp6Xa4OBBYFt7MAYkMNa3Bv0GI4ivv
	 PRF0clICdrnEtJ6cQYzpAVxgy4iO82+zjOQN9uDqizgqSM1A11AguJOHZD+e7KCi1gVDG
	 Yk704kGBxPYOdGQik2NcPydIby/SrXxP8aDnwGCYF6HblB2k9JPI+F8ytogDc6pdTJlks
	 dtZERRgpUvJI82UYmRrQjeWuU1elSIQrl/fWKIz8Wc8NxkgUtSzlBPebip7R1QNwl5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=h0wz1YBF;
	arc=none smtp.remote-ip=74.125.82.177
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD958606A329
	for <git@vger.kernel.org>; Sun, 25 Oct 2026 20:25:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BD958606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=h0wz1YBF
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-35cd4e8bdbdso4113287eec.1
        for <git@vger.kernel.org>; Sun, 25 Oct 2026 13:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792959925; x=1793564725; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=aNPBPmeWCtFjxPx5kv+txz4v7XkowgD3+OUKZYjAJRg=;
        b=h0wz1YBF7oOznGjdelbk6ZVlJGledZbnW93x48keSCjuqNgOrkwertGiOARCT46d74
         /yQDGmEYIJ9UJDdY37va1ea8XNdifny/+5oHvoz7mAYkRYhgMpr6OJ1fmyJuAbVhbris
         C1SC/2cLhm06QIK2O6GlsC/7yLOLy+vARq3CyHReRGAY1qfobqwVZ5I7nd1UHf5B3bXK
         cpA5+uHD9cdxneO4+Ohe/N7vCwwyid5fauBnIfcFmU9Ic03AGMYM1s+VolAtoXbkpu5Q
         4nkySOhi+/3mPou0bt7qZvOIYD0z5JkVo2FaaZLpUGURgvyOpn1BsJcw2RfN6U00oIyF
         eBBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792959925; x=1793564725;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aNPBPmeWCtFjxPx5kv+txz4v7XkowgD3+OUKZYjAJRg=;
        b=zWijICPV8IK5ODbWDtXrzCjbKmuoAJozX4uzAaK+j2D+6D1Nr3OmQPuRLvoMSWVoJJ
         2fK5OqHu4SZJ77OKwI1xcMl5LGm7lITdPeinLQ6UdFHaFoLg8y0Y/XaKPUfu60rYYsPq
         a5PmmbEXEQNAutTTi8/gRHdAQX2ycaSnUbC2l+X/asMBMoz0foKvNrqJnm1F+5n4qoH+
         lmIMXlEM50SqmK4CRXTWUCRAyMzLl+iDIcRrSokVNbvwQwsf7ZNNWmHIg73/2dg0D5NU
         sjjzSZExsNv8Za3Emtn8H7VthSIfCCw/baQ8ugukuk3pomvIFp49R+pJrPufRyl8nZfK
         zUiw==
X-Gm-Message-State: AFq9FYLuy2yPK+c6qbw/vaSamXGtaE8fn6Rvt1iHkUWW4SlBlPNPUe5k
	fC9nDMcCRb+aoJKf/xNAsigYGbP00Mw0b/yV/+ARZGg7s4t5xmyRJ8Lds9L9/n8tEQ8=
X-Gm-Gg: AYBFou2hkzIEzGhW6v4pZ6d9wDFUCHX2A7bBOZvR9RaAid/4WBdH2MTYgcM21Prj8Bs
	8L4kcYKaiU2zzek1jLFzaYWy37CNwnJ5jltGxBE4klI4cNiTZ8B8ycszTXtlUC2x9VRWII44VHl
	BYXaPsXAX78kUkDVgAheSIxspv63+8XN4+1WcZ0Sy9Cu9cMkVgyze6YPphNI/I5o3Y5xO9RPwJO
	6i/bqWvPbFOsbK/XrD0zSfu6n6L4qIRkAN2f7CveLrRx9m9qbe61OhvQUq1L2hUQwVGdCYEfsbd
	MJ/zPy7IIffFe+rJlVk1SXjzZ1KxZ8arf7XYp/JdIXb3kxArqBSlrXV9yL7OK8nh7f7oiwkHhGw
	hQ/N4q9ZJ1GJzC4nuZL/7EQmy/81bECAgYSswLANl0AUsVD1olnyvJcVx+1ZgVrwcIxchLCm6rb
	pTtookKdPoQ878okQCcNQBqB0YaKxmjzMm/i+BEqgj7QUcG7gRJ1f7OOXTUd39K+9V7+Ig/iw/Y
	F8a9WbwhfEe4ZbAotoMnVM9ukm4RXwlT5JZu6yhgnF4H9PVgov7YDZY
X-Received: by 2002:a05:693c:4015:b0:369:d992:e3 with SMTP id 5a478bee46e88-369e8660a6bmr7179653eec.32.1792959924692;
        Sun, 25 Oct 2026 13:25:24 -0700 (PDT)
Received: from [127.0.0.1] ([4.242.195.32])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369e8c576ebsm18754361eec.3.2026.10.25.13.25.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 13:25:24 -0700 (PDT)
Message-Id: <f6850510336cc69f84cc4c7230e2ec3a3fc44746.1792959921.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2412.v11.git.git.1792959921.gitgitgadget@gmail.com>
References: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
	<pull.2412.v11.git.git.1792959921.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 25 Oct 2026 20:25:18 +0000
Subject: [PATCH v11 2/5] fetch: extract collect_upstream_from_remote() helper
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>,
    "D. Ben Knoble" <ben.knoble@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

When a fetch has no refspec to work from, we decide what to fetch from
two sources: the remote's configured fetch refspec, and the current
branch's upstream, if it lives on that remote. For example, after

    git clone --single-branch <url>
    git switch -c work
    git push -u origin work

the remote's refspec only covers "main", but a refspec-less "git fetch
origin" still fetches "work" into FETCH_HEAD, so that a plain "git
pull" finds the branch to merge. See 49ca2fba39 (fetch: add
branch.*.merge to default ref-prefix extension, 2022-09-08).

That "does this branch build on this remote" check was inlined for
just the current branch. Move it into its own function,
collect_upstream_from_remote(), so the same logic can be reused for
branches other than just the current one.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 builtin/fetch.c | 18 ++++++++----------
 remote.c        | 15 +++++++++++++++
 remote.h        |  9 +++++++++
 3 files changed, 32 insertions(+), 10 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index ffcb5ba29a..51bd5b0838 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1979,8 +1979,6 @@ static int do_fetch(struct transport *transport,
 	if (rs->nr) {
 		refspec_ref_prefixes(rs, &transport_ls_refs_options.ref_prefixes);
 	} else {
-		struct branch *branch = branch_get(NULL);
-
 		if (transport->remote->fetch.nr) {
 			refspec_ref_prefixes(&transport->remote->fetch,
 					     &transport_ls_refs_options.ref_prefixes);
@@ -1995,14 +1993,14 @@ static int do_fetch(struct transport *transport,
 			else
 				follow_remote_head = BUILTIN_FOLLOW_REMOTE_HEAD_DFLT;
 		}
-		if (branch && branch_has_merge_config(branch) &&
-		    !strcmp(branch->remote_name, transport->remote->name)) {
-			int i;
-			for (i = 0; i < branch->merge_nr; i++) {
-				strvec_push(&transport_ls_refs_options.ref_prefixes,
-					    branch->merge[i]->src);
-			}
-		}
+
+		/*
+		 * The configured refspec may not cover the current
+		 * branch's upstream (e.g. a narrowed -t refspec), so
+		 * make sure we can still fetch it regardless.
+		 */
+		collect_upstream_from_remote(the_repository, transport->remote,
+					      NULL, &transport_ls_refs_options.ref_prefixes);
 
 		/*
 		 * If there are no refs specified to fetch, then we just
diff --git a/remote.c b/remote.c
index 06c61bbc5f..43441945cf 100644
--- a/remote.c
+++ b/remote.c
@@ -1899,6 +1899,21 @@ int branch_merge_matches(struct branch *branch,
 	return refname_match(branch->merge[i]->src, refname);
 }
 
+void collect_upstream_from_remote(struct repository *repo,
+				   const struct remote *remote,
+				   const char *refname,
+				   struct strvec *tracked)
+{
+	struct branch *branch = repo_branch_get(repo, refname);
+
+	if (!branch_has_merge_config(branch) ||
+	    strcmp(branch->remote_name, remote->name))
+		return;
+
+	for (int i = 0; i < branch->merge_nr; i++)
+		strvec_push(tracked, branch->merge[i]->src);
+}
+
 __attribute__((format (printf,2,3)))
 static char *error_buf(struct strbuf *err, const char *fmt, ...)
 {
diff --git a/remote.h b/remote.h
index ac485a584d..003c8fd180 100644
--- a/remote.h
+++ b/remote.h
@@ -359,6 +359,15 @@ int branch_has_merge_config(struct branch *branch);
 
 int branch_merge_matches(struct branch *, int n, const char *);
 
+/*
+ * If refname's branch builds on remote, add its upstream on remote to
+ * tracked. A NULL refname means the current branch.
+ */
+void collect_upstream_from_remote(struct repository *repo,
+				   const struct remote *remote,
+				   const char *refname,
+				   struct strvec *tracked);
+
 /* list of the remote in a group as configured */
 struct remote_group_data {
 	const char *name;
-- 
gitgitgadget

