Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB1F1DDA39
	for <git@vger.kernel.org>; Sun, 30 Mar 2025 17:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743354975; cv=none; b=fi7uRRbbZ3O9eM8Jh7/uxE26mvdWOwsZOAlteZaibv3V5ayRemAF8XSkgUT0bIBT0dU9WYaOco5ghqhQm7+h2JEmJjH6QdbeipkKnrjB5LyRy+H2QncfkR0Sz2YqCQMoHBoPlC5AWRFUNSVDUnfwqkcJQHvyPBu+U+ESoUoeOhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743354975; c=relaxed/simple;
	bh=ysUXQGXfTyMqHYuY4RfXI3m6WmhTzNwRryI0InO75xU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=oRRkALZHZap9HZG5sTNFjIvJhqydhy7E/F61wgqtbxVXHjaCzjZdvKW9/MJHkORJIMnNg9crp9Ps9HqnNJ7di+zfLoNfuNBEaJ1UVt/deTELtvpaFOWFQGGLyKCPibtTgQmv6Ho6/XbEt4sEkiMS59EpiTFuTj1c1Cy7MmW1SMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=in+jNEzO; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="in+jNEzO"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43cf628cb14so32127975e9.1
        for <git@vger.kernel.org>; Sun, 30 Mar 2025 10:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743354971; x=1743959771; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/uEUT7X67/bvWrb+IAuMscOPwyJnDpSsSA/Dvhszkus=;
        b=in+jNEzOBGBx0hlbzr0i6TOfqyNvrNGKXFQ1nk448hMYzYH/raDZ6j7gl3UVGgxkqX
         cqFjRZ19qG24DsCqkxkQg0D0viAOxPir6CT/XCqtpAgkdyNvJU2hG0+JITFsJ7HJmnTk
         TLNwi7ti1wYvwRxcGN5oRmBihLfmOghLj53lLjidigG7IUgNJDuGg4gG+jFSV+J0qjrF
         9wPj7/wdZEIQE9xTvceWTcGQ/fJBWEO3XXAjkMeTsZjDopaVLic/j2oj1Muf5aIIsO+W
         /6Z5HsGipD34n385nt0UzjDy0wlYgO2UlcENDqGlumGCONN9fQhFaw2nknOrJ30jTosC
         fndg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743354971; x=1743959771;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/uEUT7X67/bvWrb+IAuMscOPwyJnDpSsSA/Dvhszkus=;
        b=IOtOJcLjJcTM47WrBTyMN0fNxJt1rx06oEZrBRFIUGbjdM8/duNwO1dBMUqLEiZew2
         F72gBnOXYRIso5E6tFLN0WTBqExOiHwjdlEEi9PrvDvycZnVxjuWXQyqx804ceS/Newn
         +u3wg+kBhbq5oyVEsf5tsB8NsM/K4lCREEv1bhO+zFRs2T20hIsPmV+ogss1G9de4u11
         w20rzNHvJ3fgTGhvXHS3PpvoicCKYtzViGL1g2K1g58fTJBkItSb8qpaskkpVvkxIySL
         4Ofb968aO/HJEbC9GNuO/mEttUO+JZWqpbM++844VuhXosvx+vU95dNSTl7JfFl9sm3F
         gdoQ==
X-Gm-Message-State: AOJu0YzA3OFeyZsaiWz6bousmj9dO0CCdLa0atl2B/4NK2+X37rEheu9
	yFfvBjeHcgOOsb2ClWLhPWMXiGdIKheHrFk9L10XPlP7Ut99q33mOp477g==
X-Gm-Gg: ASbGncsiDDIdrcDREmMiy7FRY6enneCZozn9oAVzxV8Krpvln7DfODbfqt71JaWzrjt
	H3841MNx4HQnZ0VzMZRhLdlYgqmX1Wnins4Wotm0ygalhNZaFihTONwVHIEYNt4I8q0g2qUeMRh
	HSP7sW48IWwuiNrc4+48RVizczOU0ookRV9Nmq/VdFIX+cCx6L78K4ZLXs5qYHjL2GPUHI+dLds
	GlpSJMj+XKsr2SkHWbGNDLfLG4hXPjA78XK+9ksCt+3H3YedumEnVkBQmUVJzKB3cFxX4eTaJ2N
	BsfYMmT5F8Yz5eVLQjCx209CtvaxIhPRT8YGz16Rg82szg==
X-Google-Smtp-Source: AGHT+IFDnK1NnjN7Iny9eXByedYGyL2ksEJ0lDXZtYn45wZa68bBpGmSG8LxR1Jt5ksKB+qzE1JaTg==
X-Received: by 2002:a05:600c:a086:b0:43d:186d:a4bf with SMTP id 5b1f17b1804b1-43dabe2384dmr43987055e9.0.1743354971099;
        Sun, 30 Mar 2025 10:16:11 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d82e6adf6sm138438045e9.15.2025.03.30.10.16.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Mar 2025 10:16:10 -0700 (PDT)
Message-Id: <4887567c57cd54b8f5989d1d05a9a7a9663665b1.1743354964.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1896.git.1743354964.gitgitgadget@gmail.com>
References: <pull.1896.git.1743354964.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 30 Mar 2025 17:16:04 +0000
Subject: [PATCH 5/5] doc: convert git-mv to new documentation format
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
    =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

- Switch the synopsis to a synopsis block which will automatically
  format placeholders in italics and keywords in monospace
- Use _<placeholder>_ instead of <placeholder> in the description
- Use `backticks` for keywords and more complex option
descriptions. The new rendering engine will apply synopsis rules to
these spans.

Unfortunately, there's an inconsistency in the synopsis style, where
the ellipsis is used to indicate that the option can be repeated, but
it can also be used in Git's three-dot notation to indicate a range of
commits. The rendering engine will not be able to distinguish
between these two cases.

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 Documentation/git-mv.adoc | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/Documentation/git-mv.adoc b/Documentation/git-mv.adoc
index 08d660643fc..a0b8118cf4f 100644
--- a/Documentation/git-mv.adoc
+++ b/Documentation/git-mv.adoc
@@ -8,17 +8,18 @@ git-mv - Move or rename a file, a directory, or a symlink
 
 SYNOPSIS
 --------
-[verse]
-'git mv' [-v] [-f] [-n] [-k] <source> <destination>
-'git mv' [-v] [-f] [-n] [-k] <source> ... <destination-directory>
+
+[synopsis]
+git mv [-v] [-f] [-n] [-k] <source> <destination>
+git mv [-v] [-f] [-n] [-k] <source> ... <destination-directory>
 
 DESCRIPTION
 -----------
 Move or rename a file, directory, or symlink.
 
-In the first form, it renames <source>, which must exist and be either
-a file, symlink or directory, to <destination>.
-In the second form, the last argument has to be an existing
+In the first form, it renames _<source>_, which must exist and be either
+a file, symlink or directory, to _<destination>_.
+In the second form, _<destination-directory>_ has to be an existing
 directory; the given sources will be moved into this directory.
 
 The index is updated after successful completion, but the change must still be
@@ -26,20 +27,20 @@ committed.
 
 OPTIONS
 -------
--f::
---force::
+`-f`::
+`--force`::
 	Force renaming or moving of a file even if the <destination> exists.
--k::
+`-k`::
 	Skip move or rename actions which would lead to an error
 	condition. An error happens when a source is neither existing nor
 	controlled by Git, or when it would overwrite an existing
 	file unless `-f` is given.
--n::
---dry-run::
+`-n`::
+`--dry-run`::
 	Do nothing; only show what would happen
 
--v::
---verbose::
+`-v`::
+`--verbose`::
 	Report the names of files as they are moved.
 
 SUBMODULES
@@ -47,8 +48,8 @@ SUBMODULES
 Moving a submodule using a gitfile (which means they were cloned
 with a Git version 1.7.8 or newer) will update the gitfile and
 core.worktree setting to make the submodule work in the new location.
-It also will attempt to update the submodule.<name>.path setting in
-the linkgit:gitmodules[5] file and stage that file (unless -n is used).
+It also will attempt to update the `submodule.<name>.path` setting in
+the linkgit:gitmodules[5] file and stage that file (unless `-n` is used).
 
 BUGS
 ----
-- 
gitgitgadget
