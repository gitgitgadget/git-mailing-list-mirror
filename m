Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC41D2063E1
	for <git@vger.kernel.org>; Mon, 16 Dec 2024 14:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734358291; cv=none; b=sNRIEgbhf0Tp++sRQCJyjZb+TtGuY7ucPb8AZUhuUzgYqCYtBmK1HiT8Qlr+s/pHJkF1uMdzc567yIHJFgTDkPt3VBGE6A8umkGGV6Rmvg6kniWwtnSyvXMkDjks9YegLRSN6HaVETYC9YX1uOssPI2wSm6uzNvuTvnpmY6B9+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734358291; c=relaxed/simple;
	bh=6jJA2ZS7Rx3z1KOoMewoAXV9j0NafKegLEIuQuH8Wi4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=a6iR3lP5F26F+SBdZpzBWmqmk2i3fHHNeVvxE4uYdoN2r2GB9SCrC9Lto521CHQ5vEarDVDh5w+fmh9hWoJqRAwW5q9Y75CFZWsxglgyr2JIae0mhqoQ8Bx958CJSAArm+ar4ooMihyxiRWEdrdBgZDkHj+olLyhP8FNm7f9yDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m3PFYXqM; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m3PFYXqM"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3862b364538so2350126f8f.1
        for <git@vger.kernel.org>; Mon, 16 Dec 2024 06:11:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734358287; x=1734963087; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xwRYkbKpnFzl9CdQG1tv8ljGGbGq/TmBMKT3DkV/VZQ=;
        b=m3PFYXqMebwAkcaJJKBzFpirOVYIYRZXE6INN1B8mp6pbiFyPK0g71+EK6V9iL1NKp
         95E25rrgqV0nLS93j+nY6dcuX0kEHlFLgvSEeOap9LbRtLJo9idkcf5r9D4HzoiwxvEH
         TefYJFzX+J76tEK4DUgIz4w897HeaMPvO2L4nY2s1l1+CkPQfkuJrPNnshcLSViTcUoj
         pZ4wRXXdtfmkY1ighME5vH04/mbVfOp0E32+f3lTmkydoVdckj74G5lE0lA5AP81pPh9
         5aZ+qZ2M2YPfmhoGHaNyvRv95GwgkoEmaAcapHX7BjiNexWIO/+vx1cKMA8FCQFjWQ2c
         /PCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734358287; x=1734963087;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xwRYkbKpnFzl9CdQG1tv8ljGGbGq/TmBMKT3DkV/VZQ=;
        b=LzPcdb03X/VD+KMCOZyJ+QvRtG/aU7pWWEvQ8MpesI30S6Lk486Z6V3JgxRphmPTOW
         yTCuiagoWnDBHss3z1JxPliDADMxxZmO/t2EahMFWPdNWx1NqdRV7Z1WVf6TYmZqb3lW
         aj05BKSYiZ+J1SgPFOjArrKLKbc0cuLE2jU18Bp6MjZK7x11BCsnbVE0XrwKyfHVKUDe
         VOHC/vAmNa9qF4b8Tfgc0LMrJp+Vhm4JHXEcNtxwtL/+MJ4//tx98QHd0N8ZDCR2ds3R
         s2Hs3Owj31dlRAOaP/ZIA3oiqQlGR0D5wf0f3UjnA4stEU4llKlP33jz84lDgZ/Kk/zk
         W2AA==
X-Gm-Message-State: AOJu0YxvyU+4NYx2H2C6m/JK/fymceE4kY0YqDwDS15EpzXlyNt40i9S
	xaDLyqW/m+7QGZt5XdvaqZEifcquptbFsRJ/I+7OjO+CxYWnRNz4FKDu3g==
X-Gm-Gg: ASbGncsRMhRp3NktznMvvjFZ/pVtODRcUQHutCTjBcTP73bFFhWN9nuZvyQtmYx4RcF
	ZzQcpQjW4wX+U/e5PXMv9/X0fW5FTYNBG4KlaYlxMbo60hSGObELHcbpXzbtflbG6PDKMRuKd7J
	5MZTCXWgiG78s1GqYuezh8MPTN8tc2pxLh83iI2dFdDukGCrxTXVLLleynOXn7P5/BipGGHO8oY
	8OT0IOjkajdkf/VtsSnFfSWIrFAf7rfymwNyqY0FYiXCyg8EWDEz5FJ5A==
X-Google-Smtp-Source: AGHT+IGZkezO1zY14XwXEOWnW2BVGN79H17X7joTwXLw0p4F4FoAwvggbe+jP2IfiXHN7HuA02RBmg==
X-Received: by 2002:a5d:6d8a:0:b0:386:4570:ee3d with SMTP id ffacd0b85a97d-388c3a7e0famr9935748f8f.24.1734358286999;
        Mon, 16 Dec 2024 06:11:26 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-388c80605casm8348581f8f.86.2024.12.16.06.11.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 06:11:26 -0800 (PST)
Message-Id: <f99416acd5a4fa7d6173be52ab41e238cd99e151.1734358282.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1734.v3.git.1734358282.gitgitgadget@gmail.com>
References: <pull.1734.v2.git.1731073383564.gitgitgadget@gmail.com>
	<pull.1734.v3.git.1734358282.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 16 Dec 2024 14:11:22 +0000
Subject: [PATCH v3 2/2] range-diff: introduce the convenience option
 `--remerge-diff`
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
Cc: Philippe Blain <levraiphilippeblain@gmail.com>,
    Johannes Sixt <j6t@kdbg.org>,
    Elijah Newren <newren@gmail.com>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Just like `git log`, now also `git range-diff` has that option as a
shortcut for the common operation that would otherwise require the quite
unwieldy (if theoretically "more correct") `--diff-mode=remerge` option.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/git-range-diff.txt | 4 ++++
 builtin/range-diff.c             | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/Documentation/git-range-diff.txt b/Documentation/git-range-diff.txt
index 150b0acbd86..e9e97d94480 100644
--- a/Documentation/git-range-diff.txt
+++ b/Documentation/git-range-diff.txt
@@ -11,6 +11,7 @@ SYNOPSIS
 'git range-diff' [--color=[<when>]] [--no-color] [<diff-options>]
 	[--no-dual-color] [--creation-factor=<factor>]
 	[--left-only | --right-only] [--diff-merges=<format>]
+	[--remerge-diff]
 	( <range1> <range2> | <rev1>...<rev2> | <base> <rev1> <rev2> )
 	[[--] <path>...]
 
@@ -92,6 +93,9 @@ have produced. In other words, if a merge commit is the result of a
 non-conflicting `git merge`, the `remerge` mode will represent it with an empty
 diff.
 
+--remerge-diff::
+	Convenience option, equivalent to `--diff-merges=remerge`.
+
 --[no-]notes[=<ref>]::
 	This flag is passed to the `git log` program
 	(see linkgit:git-log[1]) that generates the patches.
diff --git a/builtin/range-diff.c b/builtin/range-diff.c
index 9d6236e5116..3ab871ab925 100644
--- a/builtin/range-diff.c
+++ b/builtin/range-diff.c
@@ -34,6 +34,8 @@ int cmd_range_diff(int argc, const char **argv, const char *prefix)
 				  PARSE_OPT_OPTARG),
 		OPT_PASSTHRU_ARGV(0, "diff-merges", &diff_merges_arg,
 				  N_("style"), N_("passed to 'git log'"), 0),
+		OPT_PASSTHRU_ARGV(0, "remerge-diff", &diff_merges_arg, NULL,
+				  N_("passed to 'git log'"), PARSE_OPT_NOARG),
 		OPT_BOOL(0, "left-only", &left_only,
 			 N_("only emit output related to the first range")),
 		OPT_BOOL(0, "right-only", &right_only,
-- 
gitgitgadget
