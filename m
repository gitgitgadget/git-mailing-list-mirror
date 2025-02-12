Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78331E98EA
	for <git@vger.kernel.org>; Wed, 12 Feb 2025 03:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739330847; cv=none; b=VweGjAGZv8ZHhnQBQwsYxhcyLgbEug4Q5hEjEIZ9EnpfZYq/HzOTiDfV69Gkxi6mXV1vzlmT6wXGIY0gO3fjZ7fB2sBqkk5MlVmNx1/KiWBo5NJaN5i/SiHocj6ze5u9OK1SDY4IuZNSWOrGQZlF+DeCv+lKAdmWLrRA/Mu44v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739330847; c=relaxed/simple;
	bh=HcRamvrzcbtIUlzpaFjIKvl79wT8WgDWd1l8byud9Oc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jvfbcCD+vulEk3L1ed0cSYDO4/DmOV7Fmm1ZneBmaw/y+SEZ4SULlHpev0p1RXmS3uu9mBZkSgO1QwN8Xn2r8P8tNL6WYHSRR4JY5aCPDl0Z+skkKbck5xIIynS61UXFqKudi9qzzbJJlxLlBSNqqC5JrYER0cqYknVHKvZkW/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IB9QrjTw; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IB9QrjTw"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-219f8263ae0so112116435ad.0
        for <git@vger.kernel.org>; Tue, 11 Feb 2025 19:27:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739330845; x=1739935645; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wblqpLdDOzzXtmdXTdBplqjywGYcu1aJOcKYQiaY/rE=;
        b=IB9QrjTwv8oFyv8RKo+cywcEMK+in5KGAmlyt1vV+Im6O8n58L20UcYWorvEMrswW/
         5Jl2XfNSjfXIDylaU1FFCxdjwXIqW4e/5GOzf6mX/VSTZkPKHqkx4mgJnimwDTtrnBe0
         sXUht6tQlnh/nWoQ04sTJRJIfyzGkH+TVHvePJ37erpAbT2g4K9sJRANFOoVWwiODbRG
         qLlZuRkxBFR11bEoJ4aHwAbLbstxVfiFqCLnqi8F6bf94yKFYz3T/pC7rI0Di0GwE27L
         s/JxufDj1V2rTR0L6h6eX/g3mmpNnXWu9jV71XaRqHmyT4SjawFxd/QEq2fzgfu5QQ4V
         w/ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739330845; x=1739935645;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wblqpLdDOzzXtmdXTdBplqjywGYcu1aJOcKYQiaY/rE=;
        b=P37mnQ1rC0EcknoZr6yhyGSf4sIa+hW0U5KI4DeLDibtBIy7SdpRknqDGrIGnTQ3DC
         0DXxXIuw42meV4sQqwufzIBj39B6Nw+NK6syva8xwG6F3YtQrPgfJ4JtQYIbklqoITIE
         mVLPYMhUcXc7PnpmfLQxEMHVhzzFpbTM5Lbwp5TTzttcTqp5l6YFbhy9bH/xSgz5yhCw
         nggLVsXgt9iek5uL/6MPLdcB0v3bS9NlmKjlGSyLSWx6i9QbKcL31RMqbvCmb+Ao9GYn
         G6aHQqBCy4V5qsVLILsNLsVtlwcMoogBALgicH0SWGEeSaLCXNQ/7lbvC20txB0ZQQSc
         yBBA==
X-Forwarded-Encrypted: i=1; AJvYcCVkhoWWUwnUOxFZmKgLU11QWLooIyfhSC9RV8DG3b5C4zmCuEYrl1SB9SRRl6Co1w/fHwA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxnrl28Lfzw6eq6axtvyXCrEzfXEd4D4CJ0doN+xQfIIvqKldUb
	M0o9XQtCsXw04NEqETNh68NXY3Ky6W/fvl7Osjxkxu+EFpkng+tv
X-Gm-Gg: ASbGncv9U9thqfccfFEvNR8r6J39VS35foPzYJt6GxclLME1CJUFegwjDAwXwkLUypc
	RraCgcDqJENedf9OxYhVNhKCOu1oyLfyp6NeKvDFU3QonfYj/233nvI0/aD4bPvxWIryE+oXaeT
	5+kn9YtS5+dZnaaHEdJLRq66NYDcJX5NW36nGX8HLT59g5gL19CBmtDi9esOJvg5LfYM9FKkyUc
	dcgZ3IWDn6vXiIMbVs+lkU5VAnY0txZwAUrOvzJGL8BOJGa74DyEzzR0JiuoK1sUU+U2WLtJhan
	eW3hgeTcvk2yZXU+2RW3aGmkgUralz/KuSdL+tE=
X-Google-Smtp-Source: AGHT+IEbwdqbJNj5RaDUaAvkfsN3UVNjdqH8BKYpai6VI1xuJE3yeGV9JMQ9Y62yWUKaBmsWDXZ9YQ==
X-Received: by 2002:a05:6a21:b98:b0:1e8:c159:b6ef with SMTP id adf61e73a8af0-1ee5c82193emr2947640637.37.1739330844708;
        Tue, 11 Feb 2025 19:27:24 -0800 (PST)
Received: from gamma.hsd1.ca.comcast.net ([2601:647:5580:5760:508a:741e:539b:1c5c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73048ae7f6esm10129577b3a.74.2025.02.11.19.27.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 19:27:24 -0800 (PST)
From: Illia Bobyr <illia.bobyr@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Illia Bobyr <illia.bobyr@gmail.com>,
	git@vger.kernel.org
Subject: [PATCH v5 10/10] diff: docs: Use --patch-{grep,modifies} over -G/-S
Date: Tue, 11 Feb 2025 19:26:54 -0800
Message-ID: <20250212032657.1807939-11-illia.bobyr@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250212032657.1807939-1-illia.bobyr@gmail.com>
References: <20250206014324.1839232-1-illia.bobyr@gmail.com>
 <20250212032657.1807939-1-illia.bobyr@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Long argument names are easier to read, compared to short ones.  So
while short arguments are great when you want to type a command quickly,
the documentation readability is improved if we use long argument names.

Note for reviewers:  All changes are just a replacement of `-G` with
`--patch-grep` and `-S` with `--patch-modifies`.  But as the text was
reformatted to fit the same width in a few places it might look like
there are more changes, if the diff is only line-wise and not word-wise.

The only an exception are changes in `gitdiffcore.adoc`, where I did
rephrase a sentence.  I've moved introduction of the short versions of
the `--patch-{grep,modifies}` into a subsequent paragraph.  The reason
is that I wanted to keep a note on the `-G` mnemonic, and it was awkward
if I would repeat the short definition twice over a span of two
paragraphs.
---
 Documentation/diff-options.txt | 34 ++++++++++-----------
 Documentation/git-blame.txt    |  2 +-
 Documentation/gitdiffcore.txt  | 55 +++++++++++++++++-----------------
 3 files changed, 46 insertions(+), 45 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 07413d..c9f7c 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -658,8 +658,8 @@ renamed entries cannot appear if detection for those types is disabled.
 It is useful when you're looking for an exact block of code (like a
 struct), and want to know the history of that block since it first
 came into being: use the feature iteratively to feed the interesting
-block in the preimage back into `-S`, and keep going until you get the
-very first version of the block.
+block in the preimage back into `--patch-modifies`, and keep going until
+you get the very first version of the block.
 +
 Binary files are searched as well.
 
@@ -668,9 +668,9 @@ Binary files are searched as well.
 	Look for differences whose patch text contains added/removed
 	lines that match _<regex>_.
 +
-To illustrate the difference between `-S<regex>` `--pickaxe-regex` and
-`-G<regex>`, consider a commit with the following diff in the same
-file:
+To illustrate the difference between `--patch-modifies=<regex>
+--pickaxe-regex` and `--patch-grep=<regex>`, consider a commit with the
+following diff in the same file:
 +
 ----
 +    return frotz(nitfol, two->ptr, 1, 0);
@@ -678,9 +678,9 @@ file:
 -    hit = frotz(nitfol, mf2.ptr, 1, 0);
 ----
 +
-While `git log -G"frotz\(nitfol"` will show this commit, `git log
--S"frotz\(nitfol" --pickaxe-regex` will not (because the number of
-occurrences of that string did not change).
+While `git log --patch-grep="frotz\(nitfol"` will show this commit, `git
+log --patch-modifies="frotz\(nitfol" --pickaxe-regex` will not (because the
+number of occurrences of that string did not change).
 +
 Unless `--text` is supplied patches of binary files without a textconv
 filter will be ignored.
@@ -689,22 +689,22 @@ See the 'pickaxe' entry in linkgit:gitdiffcore[7] for more
 information.
 
 `--find-object=<object-id>`::
-	Look for differences that change the number of occurrences of
-	the specified object. Similar to `-S`, just the argument is different
-	in that it doesn't search for a specific string but for a specific
-	object id.
+	Look for differences that change the number of occurrences of the
+	specified object. Similar to `--patch-modifies`, just the argument
+	is different in that it doesn't search for a specific string but
+	for a specific object id.
 +
 The object can be a blob or a submodule commit. It implies the `-t` option in
 `git-log` to also find trees.
 
 `--pickaxe-all`::
-	When `-S` or `-G` finds a change, show all the changes in that
-	changeset, not just the files that contain the change
-	in _<string>_.
+	When `--patch-modifies` or `--patch-grep` finds a change, show all
+	the changes in that changeset, not just the files that contain the
+	change in _<string>_.
 
 `--pickaxe-regex`::
-	Treat the _<string>_ given to `-S` as an extended POSIX regular
-	expression to match.
+	Treat the _<string>_ given to `--patch-modifies` as an extended
+	POSIX regular expression to match.
 
 endif::git-format-patch[]
 
diff --git a/Documentation/git-blame.txt b/Documentation/git-blame.txt
index b1d7fb..0f21d3 100644
--- a/Documentation/git-blame.txt
+++ b/Documentation/git-blame.txt
@@ -41,7 +41,7 @@ a text string in the diff. A small example of the pickaxe interface
 that searches for `blame_usage`:
 
 -----------------------------------------------------------------------------
-$ git log --pretty=oneline -S'blame_usage'
+$ git log --pretty=oneline --patch-modifies='blame_usage'
 5040f17eba15504bad66b14a645bddd9b015ebb7 blame -S <ancestry-file>
 ea4c7f9bf69e781dd0cd88d2bccb2bf5cc15c9a7 git-blame: Make the output
 -----------------------------------------------------------------------------
diff --git a/Documentation/gitdiffcore.txt b/Documentation/gitdiffcore.txt
index e934b9..e7f98 100644
--- a/Documentation/gitdiffcore.txt
+++ b/Documentation/gitdiffcore.txt
@@ -245,33 +245,34 @@ diffcore-pickaxe: For Detecting Addition/Deletion of Specified String
 
 This transformation limits the set of filepairs to those that change
 specified strings between the preimage and the postimage in a certain
-way.  `--patch-modifies=<string>` (`-S<string>` for short) and
-`--patch-grep=<regex>` (`-G<regex>` for short) are used to specify
-different ways these strings are sought.
-
-`-S<string>` detects filepairs whose preimage and postimage
-have different number of occurrences of the specified _<string>_.
-By definition, it will not detect in-file moves.  Also, when a
-changeset moves a file wholesale without affecting the interesting
-string, diffcore-rename kicks in as usual, and `-S` omits the filepair
-(since the number of occurrences of that string didn't change in that
-rename-detected filepair).  When used with `--pickaxe-regex`, treat
-the _<string>_ as an extended POSIX regular expression to match,
-instead of a literal string.
-
-`-G<regex>` (mnemonic: grep) detects filepairs whose textual diff has
-an added or a deleted line that matches the given _<regex>_.  This
-means that it will detect in-file (or what rename-detection considers
-the same file) moves, which is noise.  The implementation runs diff
-twice and greps, and this can be quite expensive.  To speed things up,
-binary files without textconv filters will be ignored.
-
-When `-S` or `-G` are used without `--pickaxe-all`, only filepairs
-that match their respective criterion are kept in the output.  When
-`--pickaxe-all` is used, if even one filepair matches their respective
-criterion in a changeset, the entire changeset is kept.  This behavior
-is designed to make reviewing changes in the context of the whole
-changeset easier.
+way.  `--patch-modifies=<string>` and `--patch-grep=<regex>` are used
+to specify different ways these strings are sought.
+
+`--patch-modifies=<string>` (`-S<string>` for short) detects filepairs
+whose preimage and postimage have different number of occurrences of
+the specified _<string>_.  By definition, it will not detect in-file
+moves.  Also, when a changeset moves a file wholesale without
+affecting the interesting string, diffcore-rename kicks in as usual,
+and `--patch-modifies` omits the filepair (since the number of
+occurrences of that string didn't change in that rename-detected
+filepair).  When used with `--pickaxe-regex`, treat the _<string>_ as
+an extended POSIX regular expression to match, instead of a literal
+string.
+
+`--patch-grep=<regex>` (`-G<regex>` for short, mnemonic: grep) detects
+filepairs whose textual diff has an added or a deleted line that
+matches the given regular expression.  This means that it will detect
+in-file (or what rename-detection considers the same file) moves,
+which is noise.  The implementation runs diff twice and greps, and
+this can be quite expensive.  To speed things up, binary files without
+textconv filters will be ignored.
+
+When `--patch-modifies` or `--patch-grep` are used without
+`--pickaxe-all`, only filepairs that match their respective criterion
+are kept in the output.  When `--pickaxe-all` is used, if even one
+filepair matches their respective criterion in a changeset, the entire
+changeset is kept.  This behavior is designed to make reviewing
+changes in the context of the whole changeset easier.
 
 diffcore-order: For Sorting the Output Based on Filenames
 ---------------------------------------------------------
-- 
2.45.2

