Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E181A1E8332
	for <git@vger.kernel.org>; Fri, 19 Dec 2025 00:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766103872; cv=none; b=opGi04rpMZl5jjnQtA8WjDX1nOaVBXJ2oY9IkO+1B4FO1liJtO1Zr0VFggmGo3YOpHuhGKdcTAYB9puB4aI3ejSQ56GNemGMgxvvxH/iQk307EnLae/D8az0PkPLJG+Uzrpe/KILCom6rRrITjngUEZajYO/a4WgsyB8sRyVlDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766103872; c=relaxed/simple;
	bh=1GvlZ+FzaP7Vy/VD7WXT1lepDPFhDy9UxDCAwZe2+Kg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VGh/yqkB2V2ddy4J2T4o4Spk+0c9Xbdj4iM33qqVadhT3h0ibCkcIjIyUWabr/w4YmYDrGZwg2uRvtrXe4RWCYANhOexuBJfG/grWm3kFBp9D/FFzkUx6mNvxUyouV4IRJm4iPU4JpDL/EYK6AgG8iIY09agSVceRLfnm4aPWD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GiBUemBN; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GiBUemBN"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-78c5adeb964so12220607b3.1
        for <git@vger.kernel.org>; Thu, 18 Dec 2025 16:24:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766103869; x=1766708669; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8tUxwNkbDUmhCSSHigDR/DEaAQ1FdeqkD0NQFNWOAQg=;
        b=GiBUemBNwTCZRlaTiafRxkjBEU0WHWGY9u8fWa5LOtlJIov88T+W/2gyl1FC8M0lMd
         pZHgnjK8MebI8zh3hDqj06C8xRIlia3gacOM00JvxqBUjh+0P2zbZbD9BKs0WKhhc4xI
         77a3/i1cZiYcJHTXJBIvyJBOMFM7H9fMcqY47sUvqW2zr0kzEKrELkaXMm9xeh6pVqau
         JHZcs+ZK2mYGGp0m++88RgtGmVCP8BGrZl0ac6LqoRtYV/pyJcukId6o16szIJSYacPf
         oxlElaTscJ9/Nh18zgb9WKuWImok82mKKypBK2i7/scyeAkFMmuUTAsTowUJS+MPCmDt
         AIwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766103869; x=1766708669;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8tUxwNkbDUmhCSSHigDR/DEaAQ1FdeqkD0NQFNWOAQg=;
        b=nKZZ72M6QEWCjYUd0MMGFoDDe1nnkdN5YuYavpaJ54Y9xAeL1nYiC1V8go1NffzL4k
         PmH3VH9nC5e2CDORWUt4prCnOpEocwOu/DvxFngk57uqBssBQX9qosmD7PQcoqkRXi0b
         vKmMkLHwuum5VlOBDDndDXRmY9l2NXQy8QpAo/eyeBXKDRPUKp4Z4sGPT3kSCzhtcRFX
         y1zkrSS1LB2VwppBTBQS/VkYit+TLDQCfasRSMI1Vk/jVQ0+C8SliD3oYG84gRhCsI4h
         aZBvgRaLyas2vilu9nhAmc7a9B6CilyOkfPCXLjlTYHrjJi3Zd4twer6bewd7pgplJ6/
         Y5Mg==
X-Gm-Message-State: AOJu0YyYB/2ycTH1jXd2b1F/V6X/cfHMVdh9Bhm3L4tgW0HTV9qPOsS2
	Zo+NoxVU9lbj/e6LU5PYuL3WHl8wlqd4D5G16gG+F+L2nflDTfIyEDCAQ04s3A==
X-Gm-Gg: AY/fxX4MUHPIlWLB7oe9Ashtf0qgzHAQx03aLq4xGhXjsiv5W+ZF48mJ0Ll7UqMyd4Y
	T1vLqF4pr1fKus1b/ocWXnxeZ5r5Q/jJ1N3m4hQ6qikAsWqPjM/r4nOdj9McC2R2hHK7lZaDcES
	CaXStJ1edTvwRu+mdZ1gYTNqCWuvgfVSXgBzIn5CCEdY1orPQNNdcBWXmuPgRpRkyMv9Asycl9h
	YHJY9cT/qoZy9pmJBUkFbvfs+6wGz1wR7OUaY3jOeX4bhdHZ3qPceSAq2mpIIvYiwArcWNClqYk
	eNb57Fs8traMlMDlpEjrmSZWdUmCg+w5bX+6TuPuK0tRVHLOxl3kG9JYhKG9zFGhN6JtFm+upRf
	EB2mLYB7C3m0G5OdvEm4q8iC7687y5r0htP+wWyazlQwI0BVAGyyI5Khr4pjVAnpRvkbJMYcTkN
	mQPa4teAF7PaOYflqWmi/vkiE1zQ==
X-Google-Smtp-Source: AGHT+IGv9sMG4n8sks+kzRdMDXNm1qVtqMZYwhVJvsYcPU45ZiphtSh96VqR9pnKKgq/LbDUkIdzrA==
X-Received: by 2002:a05:690c:6c08:b0:786:5ebb:4837 with SMTP id 00721157ae682-78fb40038famr10744357b3.33.1766103869440;
        Thu, 18 Dec 2025 16:24:29 -0800 (PST)
Received: from localhost.localdomain ([2605:a601:90a8:8b00::a])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78fb44f0dcdsm3658427b3.30.2025.12.18.16.24.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 16:24:29 -0800 (PST)
Sender: "D. Ben Knoble" <ben.knoble@gmail.com>
From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
To: git@vger.kernel.org
Cc: Julia Evans <julia@jvns.ca>,
	Junio C Hamano <gitster@pobox.com>,
	"D. Ben Knoble" <ben.knoble+github@gmail.com>,
	=?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
Subject: [PATCH v2 1/4] doc: git-reset: reorder the forms
Date: Thu, 18 Dec 2025 19:23:53 -0500
Message-ID: <a558c5a8684639a2e888866a650357f54f29f2a6.1766103827.git.ben.knoble+github@gmail.com>
X-Mailer: git-send-email 2.52.0.rc0.365.g9bf09b728d.dirty
In-Reply-To: <cover.1766103827.git.ben.knoble+github@gmail.com>
References: <pull.1991.git.1760731558.gitgitgadget@gmail.com> <cover.1766103827.git.ben.knoble+github@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Julia Evans <julia@jvns.ca>

From user feedback: three users commented that the `git reset [mode]`
form is the one that they primarily use, and that they were suprised to
see it listed last.
("I've never used git reset in any mode other than --hard").

Move it to be first, since the `git reset [mode]` form is what
"Reset current HEAD to the specified state" at the beginning refers
to, and because the `git reset [mode]` form is the only thing that
`git reset` uniquely does, the others could also be done with
`git restore`.

Signed-off-by: Julia Evans <julia@jvns.ca>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: D. Ben Knoble <ben.knoble+github@gmail.com>
---
 Documentation/git-reset.adoc | 58 ++++++++++++++++++------------------
 1 file changed, 29 insertions(+), 29 deletions(-)

diff --git a/Documentation/git-reset.adoc b/Documentation/git-reset.adoc
index 3b9ba9aee9..9843682e81 100644
--- a/Documentation/git-reset.adoc
+++ b/Documentation/git-reset.adoc
@@ -8,43 +8,17 @@ git-reset - Reset current HEAD to the specified state
 SYNOPSIS
 --------
 [synopsis]
+git reset [--soft | --mixed [-N] | --hard | --merge | --keep] [-q] [<commit>]
 git reset [-q] [<tree-ish>] [--] <pathspec>...
 git reset [-q] [--pathspec-from-file=<file> [--pathspec-file-nul]] [<tree-ish>]
 git reset (--patch | -p) [<tree-ish>] [--] [<pathspec>...]
-git reset [--soft | --mixed [-N] | --hard | --merge | --keep] [-q] [<commit>]
 
 DESCRIPTION
 -----------
-In the first three forms, copy entries from _<tree-ish>_ to the index.
-In the last form, set the current branch head (`HEAD`) to _<commit>_,
+In the first form, set the current branch head (`HEAD`) to _<commit>_,
 optionally modifying index and working tree to match.
 The _<tree-ish>_/_<commit>_ defaults to `HEAD` in all forms.
-
-`git reset [-q] [<tree-ish>] [--] <pathspec>...`::
-`git reset [-q] [--pathspec-from-file=<file> [--pathspec-file-nul]] [<tree-ish>]`::
-	These forms reset the index entries for all paths that match the
-	_<pathspec>_ to their state at _<tree-ish>_.  (It does not affect
-	the working tree or the current branch.)
-+
-This means that `git reset <pathspec>` is the opposite of `git add
-<pathspec>`. This command is equivalent to
-`git restore [--source=<tree-ish>] --staged <pathspec>...`.
-+
-After running `git reset <pathspec>` to update the index entry, you can
-use linkgit:git-restore[1] to check the contents out of the index to
-the working tree. Alternatively, using linkgit:git-restore[1]
-and specifying a commit with `--source`, you
-can copy the contents of a path out of a commit to the index and to the
-working tree in one go.
-
-`git reset (--patch | -p) [<tree-ish>] [--] [<pathspec>...]`::
-	Interactively select hunks in the difference between the index
-	and _<tree-ish>_ (defaults to `HEAD`).  The chosen hunks are applied
-	in reverse to the index.
-+
-This means that `git reset -p` is the opposite of `git add -p`, i.e.
-you can use it to selectively reset hunks. See the "Interactive Mode"
-section of linkgit:git-add[1] to learn how to operate the `--patch` mode.
+In the last three forms, copy entries from _<tree-ish>_ to the index.
 
 `git reset [<mode>] [<commit>]`::
 	This form resets the current branch head to _<commit>_ and
@@ -98,6 +72,32 @@ but carries forward unmerged index entries.
 	the submodules' `HEAD` to be detached at that commit.
 --
 
+`git reset [-q] [<tree-ish>] [--] <pathspec>...`::
+`git reset [-q] [--pathspec-from-file=<file> [--pathspec-file-nul]] [<tree-ish>]`::
+	These forms reset the index entries for all paths that match the
+	_<pathspec>_ to their state at _<tree-ish>_.  (It does not affect
+	the working tree or the current branch.)
++
+This means that `git reset <pathspec>` is the opposite of `git add
+<pathspec>`. This command is equivalent to
+`git restore [--source=<tree-ish>] --staged <pathspec>...`.
++
+After running `git reset <pathspec>` to update the index entry, you can
+use linkgit:git-restore[1] to check the contents out of the index to
+the working tree. Alternatively, using linkgit:git-restore[1]
+and specifying a commit with `--source`, you
+can copy the contents of a path out of a commit to the index and to the
+working tree in one go.
+
+`git reset (--patch | -p) [<tree-ish>] [--] [<pathspec>...]`::
+	Interactively select hunks in the difference between the index
+	and _<tree-ish>_ (defaults to `HEAD`).  The chosen hunks are applied
+	in reverse to the index.
++
+This means that `git reset -p` is the opposite of `git add -p`, i.e.
+you can use it to selectively reset hunks. See the "Interactive Mode"
+section of linkgit:git-add[1] to learn how to operate the `--patch` mode.
+
 See "Reset, restore and revert" in linkgit:git[1] for the differences
 between the three commands.
 
-- 
2.52.0.rc0.365.g9bf09b728d.dirty

