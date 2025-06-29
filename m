Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9AC2253BA
	for <git@vger.kernel.org>; Sun, 29 Jun 2025 13:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751203255; cv=none; b=omymH0hiVKjRBC+3QCeBDZClfymS/2TtCAbMMI9gxrTTvZO1R+qdIMgkqtgO2pSXreftWkGvnAZ03Vyc3ka9UsCGx2Y1pBmJpvSCA0Afbh8CcW792/sg970nqvCKkFzwOYG3VwWshFBIeBlGnOqsGp5r0UVLyYua+/MsXRU9rcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751203255; c=relaxed/simple;
	bh=8V/TV82R3vzowqqWhFTC3QvI1vCIjg08tNJxiV9iAaE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=aBefHYDvuy4TVIjaOqFxd0eQjwscuzH7RwD0rLVQq8vTbsqiNWtizQEwgJyqGpXa4QnUdI05evTDSfOVxiXVVHRUIfIxnVmigT78t/n7eR1RSfV5OMeWuxLMxgsrxNxFrT9EO9s8icOr/xDQHyPfklomFPFcrjzRYjd0ADdekZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PqYFGcz2; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PqYFGcz2"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3a5123c1533so645550f8f.2
        for <git@vger.kernel.org>; Sun, 29 Jun 2025 06:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751203251; x=1751808051; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2llW7Yo3mxNnZNQtjT3vU4dVBN7TwQb9rDmq9eIPMkQ=;
        b=PqYFGcz2/WZX7VmmBgBj/EvCqtfsNFlZRCZXdlZTmvlSyOwUs13qy2/GQEY8a8Ss28
         Th+CAm+nSBKMW2I4zUvM4aL9HFe1uHP9TaW+E0tCf9Iw1VDDyl0kfhaR1/9FJQLjIl7k
         kfFIb7GQJrDOGzWMwMzzhpQQsaCK0kdEgIOe/8b89fXjK9yxX4nP4Sr/nB7OQDDbYW7T
         ctcinWpTKeHyzIodmBFcYDBwRYmYQq6mZyqhbVJn4FvkYbaGPpdrh399lIBEcLRqZ1ao
         YWP6RfD08jt4SYPdOFYagqxq7GZiSNBomOf+VUOSYyynvyQyFYEtRTwKmwAq9DhqkkEw
         yE6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751203251; x=1751808051;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2llW7Yo3mxNnZNQtjT3vU4dVBN7TwQb9rDmq9eIPMkQ=;
        b=meI+XUqbzxWjrTSLUhXsl/rfxC0J+DEjEMYmM77xyTDJHYZ8om47esu998SoGOOeh/
         vZphzpzqhHlAQZD6Jb/+zBiTlJi17pevtZatdNyqOf2997n959Dco+rZa/uYfgSliUFL
         G0DM+6Z5NsaMHj1dGjIgXhkajAVXCNg3W363b0hPTp0wAGQTPmHytR19JZi2zSqUpT/I
         Ifx5i3wRwowbpZ04mSodJ6oq0YKcBdEcjuuztm033QHonY5cYjXqRCeLPRYsRRY6ne1e
         jDZxlhisMdifSZYYcQ0X8bDk+QvrOZqr1KLUBLZBpvANfI+VNBT+oi0OsqIgSHY9cbKe
         4Sbw==
X-Gm-Message-State: AOJu0YxqTlb38tKe0va2ZOGoUuDo0UWlQTEXflPrqTLmzHtDoVooZAyq
	cg2y7U8MwLp58vfR0GdeeGuZTucfs2IyBBFO12bOHpwq2kmjaoJD64PqOlz7Pw==
X-Gm-Gg: ASbGncsyJg/CeM/YFhfwEy/u+UF2SnrG10J7dmEVVhtLiThmMckmIHGu5cpzC9vEfiK
	4lgo691WAyx4NLdYeY4H0g8x+czH5s43LC8+rXm/f3OQBd0dVuLap8fVut4+yldEBqEl+CkgzlH
	D86S0I5LX5AGsliutCJMBYuJuzvCe85N7mQY64g+MWaS8R4wlZ1L74o0kdIHj2ITj7QZzxtJkI3
	j9IvrWA9rbWIJfSVaL/LMKRqi1Vc6afbWQPwyZTngykIofeVcgDjHcGpSOZrWCfAUiZ7h2oDLiU
	DcC+sFjAkSNThgjvBek7KdLp8G1EJT9O7VDPxb8cccHp3w22XodoIg5uiiR/e04=
X-Google-Smtp-Source: AGHT+IFd9X6Am10ALbF5XLeqGnUCAOQQYvGWCVK0D7JXNdo+tdJ72w86eEsOJFo/N4FbA7BdPrYqxQ==
X-Received: by 2002:a05:6000:2b09:b0:3a5:2cb5:642f with SMTP id ffacd0b85a97d-3a8fe5b1d4dmr5065120f8f.34.1751203251313;
        Sun, 29 Jun 2025 06:20:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453823b75cdsm132266995e9.32.2025.06.29.06.20.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jun 2025 06:20:50 -0700 (PDT)
Message-Id: <b12b8294b86e53dd864f954628542cfff497a0e0.1751203241.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1933.v2.git.1751203241.gitgitgadget@gmail.com>
References: <pull.1933.git.1749373787.gitgitgadget@gmail.com>
	<pull.1933.v2.git.1751203241.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 29 Jun 2025 13:20:41 +0000
Subject: [PATCH v2 9/9] doc: git-log: convert log config to new doc format
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

- Use `backticks` for keywords and more complex option
descriptions. The new rendering engine will apply synopsis rules to
these spans.
- Explain possible options in description list instead of in a paragraph.

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 Documentation/config/log.adoc | 47 +++++++++++++++++++----------------
 1 file changed, 26 insertions(+), 21 deletions(-)

diff --git a/Documentation/config/log.adoc b/Documentation/config/log.adoc
index a9b160e7dee4..16e00e8d296a 100644
--- a/Documentation/config/log.adoc
+++ b/Documentation/config/log.adoc
@@ -1,5 +1,5 @@
-log.abbrevCommit::
-	If true, makes
+`log.abbrevCommit`::
+	If `true`, make
 ifndef::with-breaking-changes[]
 	linkgit:git-log[1], linkgit:git-show[1], and
 	linkgit:git-whatchanged[1]
@@ -10,62 +10,67 @@ endif::with-breaking-changes[]
 	assume `--abbrev-commit`. You may
 	override this option with `--no-abbrev-commit`.
 
-log.date::
-	Set the default date-time mode for the 'log' command.
-	Setting a value for log.date is similar to using 'git log''s
+`log.date`::
+	Set the default date-time mode for the `log` command.
+	Setting a value for log.date is similar to using `git log`'s
 	`--date` option.  See linkgit:git-log[1] for details.
 +
 If the format is set to "auto:foo" and the pager is in use, format
 "foo" will be used for the date format. Otherwise, "default" will
 be used.
 
-log.decorate::
+`log.decorate`::
 	Print out the ref names of any commits that are shown by the log
-	command. If 'short' is specified, the ref name prefixes 'refs/heads/',
-	'refs/tags/' and 'refs/remotes/' will not be printed. If 'full' is
-	specified, the full ref name (including prefix) will be printed.
-	If 'auto' is specified, then if the output is going to a terminal,
-	the ref names are shown as if 'short' were given, otherwise no ref
-	names are shown. This is the same as the `--decorate` option
-	of the `git log`.
+	command. Possible values are:
++
+----
+`short`;; the ref name prefixes `refs/heads/`, `refs/tags/` and
+	`refs/remotes/` are not printed.
+`full`;; the full ref name (including prefix) are printed.
+`auto`;; if the output is going to a terminal,
+	the ref names are shown as if `short` were given, otherwise no ref
+	names are shown.
+----
++
+This is the same as the `--decorate` option of the `git log`.
 
-log.initialDecorationSet::
+`log.initialDecorationSet`::
 	By default, `git log` only shows decorations for certain known ref
 	namespaces. If 'all' is specified, then show all refs as
 	decorations.
 
-log.excludeDecoration::
+`log.excludeDecoration`::
 	Exclude the specified patterns from the log decorations. This is
 	similar to the `--decorate-refs-exclude` command-line option, but
 	the config option can be overridden by the `--decorate-refs`
 	option.
 
-log.diffMerges::
+`log.diffMerges`::
 	Set diff format to be used when `--diff-merges=on` is
 	specified, see `--diff-merges` in linkgit:git-log[1] for
 	details. Defaults to `separate`.
 
-log.follow::
+`log.follow`::
 	If `true`, `git log` will act as if the `--follow` option was used when
 	a single <path> is given.  This has the same limitations as `--follow`,
 	i.e. it cannot be used to follow multiple files and does not work well
 	on non-linear history.
 
-log.graphColors::
+`log.graphColors`::
 	A list of colors, separated by commas, that can be used to draw
 	history lines in `git log --graph`.
 
-log.showRoot::
+`log.showRoot`::
 	If true, the initial commit will be shown as a big creation event.
 	This is equivalent to a diff against an empty tree.
 	Tools like linkgit:git-log[1] or linkgit:git-whatchanged[1], which
 	normally hide the root commit will now show it. True by default.
 
-log.showSignature::
+`log.showSignature`::
 	If true, makes linkgit:git-log[1], linkgit:git-show[1], and
 	linkgit:git-whatchanged[1] assume `--show-signature`.
 
-log.mailmap::
+`log.mailmap`::
 	If true, makes linkgit:git-log[1], linkgit:git-show[1], and
 	linkgit:git-whatchanged[1] assume `--use-mailmap`, otherwise
 	assume `--no-use-mailmap`. True by default.
-- 
gitgitgadget
