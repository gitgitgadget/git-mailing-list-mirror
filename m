Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795633595;
	b=fkQK3IPZhQQCBj4QFHMkxipZSyzlhXpRC5O/nZrbbsPMFFaVN2vBB/rrRhbCRsRjxdqg
	 o87xzf3H5wv6ovvp/S6QqUh8jD33ev7WBO/fJXOTecWdzSgUhYM2ax7s16xmZEzHvoazf
	 +PL6aOyCUYB/M5bXFSBKrMau5FDuigrdyOh7Qp01URpW8ZqVnZ+HicDQMEtJcSz8MiUZx
	 ZX6i31OAoOly6wcPXTKGTg2vAqpoQIeeA3FQ8EY7tZgLY4kez7R8+cCoRXAmhsJhzdcwI
	 0XRBNisP7QIaSJl00dfFcf/t0HsDHr5WLKcAfZ2aIUVYKp1mSnVAjttg+YhGZ9ZYo0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795633595;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=P5M0rbfF1vYO4G48sEGgR/KVoSAxkdFihHbb4El+od0=;
	b=Kgibqknv5z/RO3h1xtY3iSiF/ckgHqPCxSpqQvIMAALQCpDc8HPpyosIVQC2ei579Tnk
	 pXZ5lpQkEWdZhaqQ4My+5lmM1Jr+q+krwwoh6vj4CdwnCserZxEMyvxXpeKAoSjsFnr+H
	 neHg+hzFDy77JHFxQtKBgeXvSTniuHhQ3Y/lpxLmUkqs7EDR2H3v+UU5Atz3kYkjfQFQX
	 ESfcmnbeW9YCuSHF6iTaHw7WrPxKO3Sn5/0nZD9ZJMZfD8Aibx6OyueRro2EfRkIv6r+/
	 l5MFBz8NpxHzAir8U4N3mVmZb4O66fFkvu3KIWwMCeFRLHE7IX8fkwSZwUMowW4249Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jPkZ5kSq;
	arc=none smtp.remote-ip=209.85.160.42
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5555606A31E
	for <git@vger.kernel.org>; Wed, 25 Nov 2026 19:06:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E5555606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jPkZ5kSq
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-475920b9ca2so2095585fac.1
        for <git@vger.kernel.org>; Wed, 25 Nov 2026 11:06:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795633594; x=1796238394; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=P5M0rbfF1vYO4G48sEGgR/KVoSAxkdFihHbb4El+od0=;
        b=jPkZ5kSqeDOt+dd/TCh9w0QVA7jWtxtKMMpmXZJ7yhjqSrkobdPU3c4Q8ijYWuIDcl
         LhaWIRPbj8KB7iP8kEp92PkDgwKgJ708uBCvGFLlDGbzFA029lM+dZ49xg0REmHar5gP
         6480Txon1x9XqQx4xL29zWNCTVHnjnsYE6ZuNxC4aCLQ5JjN3QVaLlX1ourXXSwJirqf
         fkxz/ai/AR1fxyMN7ue5sAivgKkR/Ke85xaGTU0ynGw7M0ePaQHRs3/PzojikOofdU++
         Gpuuw/jt3p4TmX5AgJ3lahXF/ds/QY0XagFW9sF/8YX2qKoex8DKaL3s4Kwa+0RR4AJ4
         nXzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795633594; x=1796238394;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P5M0rbfF1vYO4G48sEGgR/KVoSAxkdFihHbb4El+od0=;
        b=XFfk36IPYtNshlMdkTfcfdJvEzTu3EjMQerS2gz1zBtjYwJhRSqLQHv51lyYHlOJmP
         ZPwu9WWbVndrSsuijzQRRoBq80dCcNeBGTCrrUDg9ySK6Xi3G9asILKDKJa8tlC6/Hr3
         VnESayr+gWCb0ktG4z6ZHHWlgMjT5p3rJwSgoO3ktQHh3VJaJvfI3vabJ3xDG6N5XDlT
         tLpy+Y9rPwtOy0zJbf9rMqzu8qrOwX2JS98eUIPsoWTh4WZMLLs8yZFNQ9ORotEATPsO
         4WdO6z5JVucG2qPJU7T/exkHTWSO4b3oW7ML701culZiepKgYxGXc3nj5D0EvxSPBNz7
         o3xA==
X-Gm-Message-State: APuU4Z/fu9ZeJzCRAg2sq+Rj9FEL1lOjl+SqyMjdAYa+zhifTZvkiMIZ
	KiHe9LLExZAItJzj8e/8BczEt+irRhpINgfBasp89oyby0PdzZTHRfn38CXTzlpw
X-Gm-Gg: AZFdTZdVxE0bxbZ/JO7EkbVRKARsJaOs7dcGaSVk5KCm9o13VxlMZkj4ybn7Iumi1PT
	+PPR7xeRESgyORqSsxE1K72ydHxrSMjSzpEWomP9sZ7YctLcZuF3j5vx9ZWG71K/OWRfuu4aQli
	/Js8f5JyuC0dtLX3F27oScx8D67UuP1rLTJ9drCw8t0M/WEMAdSIgeJLVlEaIq7W4Two0dLo7YC
	qHQMhJMEJf8L6kmil5u1Kl8JfG6KcDbOPjBZKdgoRgGQHYiOSML08nkuGp+GLPtl5GvqeDVXsK4
	EO7vOl3RxgN/scdmrz7L8Cd4pjRfUCxyEseaJwa/B+zNf3O2bbmm4mFrY7CfGYQJzqGoYyZZcf+
	cjn08CxBHHH3OuyCm/t2m57svds3i43KHP/R5dt71CprjeqIL9j/7yZb3E7eicKBk5aYaZW2vrg
	Z9AG6DpIF6XpHJJwfXfZe6ny7EhWx98MQH58CUXphpzpRWAXtcxgvRq4Le4UXD+yLGZnCjckyLY
	AtXR17064Cip9/JKZuhJj8rfFmCIMFZVxLLtLvgpAfIPIAXRInT+37lNOVibQuxi24qPiETujKL
	dx06C9nvfl0mmh85lQpbZuRYyAQcK3vM
X-Received: by 2002:a05:6870:de0e:b0:49e:d4c:e6f0 with SMTP id 586e51a60fabf-4c9f67d1172mr3741784fac.46.1795633593688;
        Wed, 25 Nov 2026 11:06:33 -0800 (PST)
Received: from [127.0.0.1] ([40.124.78.245])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4bc5fc97bb2sm17005137fac.9.2026.11.25.11.06.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 11:06:32 -0800 (PST)
Message-Id: <f019dd4529ce4cbb448a14eee72379f2663e0f55.1795633584.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2412.v16.git.git.1795633584.gitgitgadget@gmail.com>
References: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
	<pull.2412.v16.git.git.1795633584.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 25 Nov 2026 19:06:21 +0000
Subject: [PATCH v16 4/7] fetch: extract collect_upstream_from_remote() helper
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
    Matt Hunter <m@lfurio.us>,
    Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
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
index d9c0e8c2f7..0f91bccf1e 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -2032,8 +2032,6 @@ static int do_fetch(struct transport *transport,
 	if (rs->nr) {
 		refspec_ref_prefixes(rs, &transport_ls_refs_options.ref_prefixes);
 	} else {
-		struct branch *branch = branch_get(NULL);
-
 		if (transport->remote->fetch.nr) {
 			refspec_ref_prefixes(&transport->remote->fetch,
 					     &transport_ls_refs_options.ref_prefixes);
@@ -2048,14 +2046,14 @@ static int do_fetch(struct transport *transport,
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
index d3bb874ed5..92fe44c026 100644
--- a/remote.c
+++ b/remote.c
@@ -1971,6 +1971,21 @@ int branch_merge_matches(struct branch *branch,
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

