Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6036431A56B
	for <git@vger.kernel.org>; Wed,  3 Sep 2025 16:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756918215; cv=none; b=DRkhTQ3cdB/4+NG9VC7q8q9OPM60r8NfLr39PVAcQ8eY35hhXBrQ+f0Sfr+BbK0pbo+XZBCkSxuzU2D04xYyDUEWFjcgxzdoYrKl3d3ZwXGfJsLhyhhX5azIWwEvkhsv9LMz4FJ/2eqnmQQRel/xGrKG5PCIgJ13qRjwk/60kzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756918215; c=relaxed/simple;
	bh=dS49Pk9jOTiu5vyuNK8jRPKr4dV/HHE5a9WR+ykdfBc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=FsdNkiBPe3ZnnIW/Ce1RVK5shiwqGF3OHAnvVImlfIDca7aEPqBSWTTnteMQXAiE2a43X0vq54Qwub6jeE6vvWXh/RfbDc+wLh0QEGr3GxgqnG0FG6x7YSovoPC/UCM7OtwKqxeW/dUARWcftQpKQGPOhH+X5fWAnjQ1vZ8MM0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hvOVkX1r; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hvOVkX1r"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7f6f367a1f0so15504885a.3
        for <git@vger.kernel.org>; Wed, 03 Sep 2025 09:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756918212; x=1757523012; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/jMYhAnKD4QH2qZ3ZRKiTLkcHROc2Ax0h5r2yeJOkOA=;
        b=hvOVkX1rLYzrrNhE6xC6M6hkyMjiFvPJQDvg08ifnSPE6p2OWQVUFL6T0PRz+3v7QN
         i9xdDRUHAa5EoPBFokLUuKaYcd89RJCp35izaUOokh5asUI4Mqe6wjbV9q9cGSfKXqBN
         TgUM52FnxkMtMQ4e0WLNfn65BSmLh5jJThOCm9FnKtXQDLToE62aDMb+HHy061RuL33u
         bgLHl4dgbX3C5WSi5b102H0vgJpMQ0HB0qLx7ifT0wNeSPhymu6g3hOr90IcTIxUizk8
         NKTpO8tIttc3j3tSS9nSy/iTgw/ksG3uFfpKH2j7dy8NmBM8XIVHwgWcdtdFNLRMVxYp
         aqaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756918212; x=1757523012;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/jMYhAnKD4QH2qZ3ZRKiTLkcHROc2Ax0h5r2yeJOkOA=;
        b=s/kQVhJsbf9/x0PY9zZdYkMi0hIC5qRbvI8LAqt+BzpBEpq/How32w3cR7aU7oauQe
         yg9Mh+53UwywCzp8IxD4wNSlZu50t9r8164RdF0rH0eyV1DCe0L6Qzkigsma2CArVP7v
         7UtqFHK/l33qJUS0gR1Avk0rpbByEDSJxQFDnK6ep25DcPuZF7d8xux/YQ8GNt/y5Urv
         VtqNL57Er5GjKY1d7g8f0HXwpzqgn3YxaBP2kCtVkweehu+/rxpkaz0GaEvs8vAfnsn5
         N08m721x0F8y0oL4ecBfv7DOn+S3rjcFeWPJFAWtQ4Whp1T1jxeZxAMKMpVOW6/2FSf3
         dU6g==
X-Gm-Message-State: AOJu0YzNkhUTZwbfwmWjAddeUyqZw7meX5PLHud3dMWz9UVZbvA+Nzop
	b0ry1U+WtTgg8BXdcu8eMs8XoZeargZkvd7zoNCLox5DsxbhcsW2hbHTyZN1lQ==
X-Gm-Gg: ASbGncuEQ9BOTTdODVGZBydCybTpkRPQg7sdHmWQdQANHJrwH2olmyuXQVt0RRbdV1F
	Oy1720lyHj1EbhT3XpizD5JVrrnfktfAWpXh0FJi6xtIodAhLFGLJND6L7UqpqV03mZFSn/m3Gj
	DuDcgNv57jkLSrXbkjdyIT9jRC/gvDbEIhrUJV2SXyJ+aQOmcJWIm6Pa6EexXLDu5T61h2GWsIn
	ybqOqxVdGuaw95wgsSSsHZ8OJVAqvune+3H3md9ww0itx+1yxks1cDpC5P7cNyYwLmC1Ouk9IRR
	f8Zdnl7btqGxKN+FX49G9MlFH17e+z/xtV9Dk/Yi6Qqk+nM0pLKcImaXlcXXUkeP/Zb37rnA0Mu
	jkc9z5owK5Racnghijvoc/c9P
X-Google-Smtp-Source: AGHT+IGDEC0uIZ3lzAZZSzJS4e+P/pgQcBYm7ZI2kMnYHF1AKD1TF3LN0Owc5BcX6BCeHFI7hB5ong==
X-Received: by 2002:a05:620a:25cb:b0:80b:9eb8:bd5 with SMTP id af79cd13be357-80b9eb80d0dmr253311485a.3.1756918211914;
        Wed, 03 Sep 2025 09:50:11 -0700 (PDT)
Received: from [127.0.0.1] ([20.55.213.113])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-80aaaa1dbeesm130153685a.33.2025.09.03.09.50.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 09:50:11 -0700 (PDT)
Message-Id: <90fe48cfe37852b9e245aa0f7b45383f9b879199.1756918202.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1962.v3.git.1756918202.gitgitgadget@gmail.com>
References: <pull.1962.v2.git.1756467934.gitgitgadget@gmail.com>
	<pull.1962.v3.git.1756918202.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 03 Sep 2025 16:50:02 +0000
Subject: [PATCH v3 6/6] doc: git-checkout: clarify restoring files section
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
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
    Julia Evans <julia@jvns.ca>,
    Julia Evans <julia@jvns.ca>

From: Julia Evans <julia@jvns.ca>

- Reword to avoid jargon ("tree-ish", "index") where possible.
  Use "commit or tree" and "stage" (as a verb) instead where appropriate
- Add examples
- Use a simpler sentence structure to describe options for handling
  unmerged entries: "use -f to.., use --ours to..., or use -m to.."

Signed-off-by: Julia Evans <julia@jvns.ca>
---
 Documentation/git-checkout.adoc | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/Documentation/git-checkout.adoc b/Documentation/git-checkout.adoc
index b361ff011a..ae19565f4f 100644
--- a/Documentation/git-checkout.adoc
+++ b/Documentation/git-checkout.adoc
@@ -74,23 +74,27 @@ Omitting _<branch>_ detaches `HEAD` at the tip of the current branch.
 `git checkout <tree-ish> [--] <pathspec>...`::
 `git checkout <tree-ish> --pathspec-from-file=<file> [--pathspec-file-nul]`::
 
-	Overwrite both the index and the working tree with the
-	contents at the _<tree-ish>_ for the files that match the pathspec.
+	Replace the specified files and/or directories with the version from
+	the given commit or tree and stage the files' contents.
++
+For example, `git checkout main file.txt` will replace `file.txt`
+with the version from `main`.
 
 `git checkout [-f|--ours|--theirs|-m|--conflict=<style>] [--] <pathspec>...`::
 `git checkout [-f|--ours|--theirs|-m|--conflict=<style>] --pathspec-from-file=<file> [--pathspec-file-nul]`::
 
-	Overwrite working tree with the contents in the index for the files
-	that match the pathspec.
+	Discard any unstaged changes to the specified files and/or directories.
+	This works by copying the file from the index to your working directory.
+	For example, `git checkout file.txt` will replace `file.txt` with either
+	the staged version of `file.txt` (if there is one) or the version from the
+	current commit.
 +
-The index may contain unmerged entries because of a previous failed merge.
-By default, if you try to check out such an entry from the index, the
-checkout operation will fail and nothing will be checked out.
-Using `-f` will ignore these unmerged entries.  The contents from a
-specific side of the merge can be checked out of the index by
-using `--ours` or `--theirs`.  With `-m`, changes made to the working tree
-file can be discarded to re-create the original conflicted merge result.
-
+This will fail if the file has a merge conflict and you haven't yet run
+`git add file.txt` (or something equivalent) to mark it as resolved.
+You can use `-f` to ignore the unmerged files instead of failing, use
+`--ours` or `--theirs` to replace them with the version from a specific
+side of the merge, or use `-m` to replace them with the original
+conflicted merge result.
 `git checkout (-p|--patch) [<tree-ish>] [--] [<pathspec>...]`::
 	This is similar to the previous two modes, but lets you use the
 	interactive interface to show the "diff" output and choose which
-- 
gitgitgadget
