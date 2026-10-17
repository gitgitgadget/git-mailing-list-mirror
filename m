Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA4B4915A9
	for <git@vger.kernel.org>; Sat, 17 Oct 2026 12:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792241710; cv=none; b=dC9h08ng/NIVa5ty69DI6zrdpfL4fei7wW7XJg+XAJSHWYZQPV/yM7Id4DanoUrZFRjj+Yi6FyjQutMqCHwgUbpJzxFAhpqQ+CeN5QZuX9K6taIo251IUFVH7E/CcukpJqxv2zgK7AbvNdbzoBc7pqlTO1O5mORoD42CYqPWvkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792241710; c=relaxed/simple;
	bh=E78TnRh6hbhA0X+tMYZk0nJXASu50/cQBr2O8ufP9xc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=obf55+/npY822yCtcmwQxZFxLxM/ucVqCkj7rJBR8i79rsxgPifLLE9p4tHolucbkziDQ94A5+Cd/8K3jLphz9qS1fIoI/6zEUnpZPYlFtDh8RJ3VQBUvfZFocSAXB6UtE5yExMCPL9Rzbar6iI9Lc5VaPYP7cStRPmiugvKCEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OfmVUn4D; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OfmVUn4D"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-5351d76e1baso9577861cf.1
        for <git@vger.kernel.org>; Sat, 17 Oct 2026 05:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792241708; x=1792846508; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/wQIzeQWuKfP0hKSVDa0vmQNyqzLF/FHbJ8rAUWqtY4=;
        b=OfmVUn4DIuTPB/g7/JX3qGwfiXWnLl2el3vozcOURUKFnvKJE/6R4CIqrMCKIzAcFD
         +zGeZq5go7Bu/ohs92r4FjSbfEsknx9ELchnrYe9aEqDa2MtjF4mfPTcUIwqsqCakGiD
         3sPHBUfFpiwfLF9R6vzhjHsZLq+U2YpuYJ4+COMLjedWfR/X4CREfZ4NMzF1cL2As7Ns
         eNaOBcBaicNbLxpcGU6pXN8W1KTA2hJ+lIYeNJAw1bw9ljNjWTotFpFthYMtgUVu+Kwz
         RwBleo0jvPAK7eTOEAkCOOTGIZOaW0aIoYQDIYVesvad2puWuyZD3LTHYAtg2jnvb6ZJ
         AssQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792241708; x=1792846508;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/wQIzeQWuKfP0hKSVDa0vmQNyqzLF/FHbJ8rAUWqtY4=;
        b=q2pmzI/hJiJt+WEdvvD2siWC4E8gIUG2FYP4hr0XvCFYpamS1j/KOaQtfMzVcMriAA
         fLEshndW2jGnIB7lZxXR4NMzSTI3jUcpoEGs5Ke27/9Z+++d0Jd6Ai/hrCET3ZKj2Qpc
         cf9bIq4Fws9LbYpNlMtnP5pRX8CdJJR5opMKxeK75mdHhvo1ek2HubYtgZcV4k64Gfhu
         xB1VW9hBfz9eZNSFTI8jtyJwgoY+w2JQcLwErcCK2dwOwvgNsEsxDAPgUKFXQpyCuq1P
         IirhCEvkHnBqbmpAg8SRgt6LKmkNvSrRhWY+6X6phATinCCNBfvGvTlggJwssIK7WSOC
         M6cw==
X-Gm-Message-State: AFq9FYL1PNMBwuh9832PX9pxT2kqTjF99RfUmqMQwiuIxwTxVD5IQdVl
	7a8NYX5DcwuacaHeY40uZy8FcbJEM+Jgck/oZoGQgqRqCtVT74rfPEO6BU5+B1Pk
X-Gm-Gg: AYBFou2LsD3Aa39xkRaefAOqsTs+Qa2N4OuvzZph+TzSjtdM/mMeoY9kW69z2Yvk3I4
	BS1X1rCU4P4lMKH4JEPH1XwhnUlMTyCEeBwR1T8vDe7q/bKuYgHX1TY3G3+cZvNavgSoy6mGbKw
	zMYYoIDZv3Y7Nte/5X2Zl5TsyBTcT204YYPwJjlH9pQuR2LA+wayzktNOMwJpUK75iS2/CUA+9N
	Kd/8m8RrKOJfWHzO/RC+yYptO873qI794VBreUJjzvDUOL36vW579EWaDp6V6PVozuHJdH/yXHP
	iR0dVmqeSeUlDJZq1rtdSnRumejEqH3wPObbQrpR5YStsGsIO/iWFCtGMiz63OBb9wBt4l8oBHf
	I44l+QiD7toeLrqvHYvNgAIyI0qnKKtPcpEmgCqdaoj3gsYBSr/qZXeOAJCGWg1t563QWU2LNXU
	vUCiUDlVR4zVZW68ZZlH7diF/wXs8obIWBjrg4kUwZ/L0e0OoZ+XzZAjL9IJqMC3EaIqIS+V+yu
	QI=
X-Received: by 2002:a05:622a:646:b0:536:5ab2:46bf with SMTP id d75a77b69052e-5365ab26ab0mr4752121cf.11.1792241707751;
        Sat, 17 Oct 2026 05:55:07 -0700 (PDT)
Received: from [127.0.0.1] ([52.152.180.199])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5362aa26559sm49010771cf.25.2026.10.17.05.55.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 05:55:07 -0700 (PDT)
Message-Id: <7087e829bbfafe22b665364d8ee56526fd12e783.1792241702.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2225.v3.git.1792241702.gitgitgadget@gmail.com>
References: <pull.2225.git.1789269613.gitgitgadget@gmail.com>
	<pull.2225.v3.git.1792241702.gitgitgadget@gmail.com>
From: "Yoichi NAKAYAMA via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 17 Oct 2026 12:55:00 +0000
Subject: [PATCH v3 3/5] worktree repair: use read_gitfile_raw() in
 infer_backlink()
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
    Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>,
    Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>,
    Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>

From: Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>

Use read_gitfile_raw() in infer_backlink() to parse .git files
consistently with repair_gitfile(). Unlike strbuf_trim(),
read_gitfile_raw() does not silently discard trailing whitespace. Such
whitespace is treated as part of the path and may cause the path to be
treated as not referencing a repository.

Extract get_worktree_id() for use in a subsequent commit.

Signed-off-by: Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>
---
 worktree.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/worktree.c b/worktree.c
index f8e9850f6f..3627dbc044 100644
--- a/worktree.c
+++ b/worktree.c
@@ -637,6 +637,14 @@ int other_head_refs(struct repository *repo,
 	return ret;
 }
 
+static const char *get_worktree_id(const char *dotgit_contents)
+{
+	const char *slash = find_last_dir_sep(dotgit_contents);
+	if (!slash)
+		return "";
+	return slash + 1;
+}
+
 /*
  * Repair worktree's /path/to/worktree/.git file if missing, corrupt, or not
  * pointing at <repo>/worktrees/<id>.
@@ -801,27 +809,24 @@ static ssize_t infer_backlink(struct repository *repo,
 			      const char *gitfile,
 			      struct strbuf *inferred)
 {
-	struct strbuf actual = STRBUF_INIT;
+	struct strbuf contents = STRBUF_INIT;
 	const char *id;
+	int err;
 
-	if (strbuf_read_file(&actual, gitfile, 0) < 0)
+	err = read_gitfile_raw(&contents, gitfile);
+	if (err)
 		goto error;
-	if (!starts_with(actual.buf, "gitdir:"))
-		goto error;
-	if (!(id = find_last_dir_sep(actual.buf)))
-		goto error;
-	strbuf_trim(&actual);
-	id++; /* advance past '/' to point at <id> */
+	id = get_worktree_id(contents.buf);
 	if (!*id)
 		goto error;
 	repo_common_path_replace(repo, inferred, "worktrees/%s", id);
 	if (!is_directory(inferred->buf))
 		goto error;
 
-	strbuf_release(&actual);
+	strbuf_release(&contents);
 	return inferred->len;
 error:
-	strbuf_release(&actual);
+	strbuf_release(&contents);
 	strbuf_reset(inferred); /* clear invalid path */
 	return -1;
 }
-- 
gitgitgadget

