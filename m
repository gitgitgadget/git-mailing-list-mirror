Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 301F737DE9F
	for <git@vger.kernel.org>; Tue,  6 Oct 2026 20:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791317167; cv=none; b=kkvMvD81DBog4nRuXkVI8NZ+sdSXEUVGwlxN1Sass1FcbBKszPklfOD5zS3l1B6p7U7Cay2Y7ffvt4/KGFcHjntjVpaZvQlVBkAy390yON+MWOji4suiI2n8kh9c9wxcVAm7bUWwxBwLK2z+L8r2ImCmDRB3hLa1aJOFdD2h9C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791317167; c=relaxed/simple;
	bh=VO04pjeg0qHWhI8VqyjwaY3YbomGnTS1thFJNYWsTq4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Bf9R/2jWHYYAt8t50gYggpbkagfJAMRaEO13Wwh0vtnFtovXaLCc+CNtmzvAhPQySQ7R13iaAkw19aXkI3VUPTvIfZ/3zwlrA1i8tqkk6DSqfX0E9fMzGVlcclNrbWZTVulu42YnVwvuvKVOsQUl+EG/C33UaF6Iix+rcavw7AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DHjDI3bT; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DHjDI3bT"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-91957ec41e1so16948866d6.0
        for <git@vger.kernel.org>; Tue, 06 Oct 2026 13:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791317165; x=1791921965; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Pgp7qJJZSzUu/1TyFFrTdSL20K+LZxTQUV6j18rMY5A=;
        b=DHjDI3bTDfteJcjB3+BkCiaTECXSmr8WJ/s0Y/koEMikhtCXmpGDcdEVAeGWM7RwWQ
         so1sf8Jc5Q5NkM+nw/BIZeThoTYIHi5ePdC+aofVkNPSOKgPJOG/H+PFQH6ye+bJGegb
         7GtO5rnGoadBRTECZ/GNiexV4rqQ+/K1umfwxAmWbh2+y5ZFH8YjdIZ+WJcpMV1tOpKV
         GWbNMUt6EoXXFH4E9jLYabm1ygQmdXlgZqVWFKfJS96uQmmcwrWT24kdSJsnrLcP/CT+
         h4Zokd8Rm/YkYw6v4mZ+f2g8GvOlQzY+/kTATOsjsxMddyAYGakUggj26wk9StCmwJM5
         bKTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791317165; x=1791921965;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Pgp7qJJZSzUu/1TyFFrTdSL20K+LZxTQUV6j18rMY5A=;
        b=prHFKnvJ3qQPCh25RIousbfEd2/qHU1SrtH4EYq4nIitReOgzX9+CVe5W2yy28EYUl
         UOVlBoWLiCIGhS7V8a2ymCCoEDkhrKjjoaiWjVydjCZoklo+DQLi/hzH7L1PiiUkX4Nn
         uTaPH+htbkNpFnfOP8qYWH8bm4WPRkVgAtBP8xogQRUu/B9gs7XlsOnrOGcXn/ld0+Ko
         SvO5CuZ76HAgeh9ikyf9KPKtTh3ob13R1h9SqmXoB7a8bDyKFoRwELFwaQTOOCXttMMd
         ltwmqbR3uwb+lnjKKYbEJzS8HI2sUHPNt/i5bKurpq+34wwG5EeNR7v+4Hn86+HZSi16
         jiYA==
X-Gm-Message-State: AFuF++kzykVM+y08U59NBfhaqH6lcAZnSyKNvUpWd/gn07ArfHPqUA/T
	by/LIjHzGaJ4/Ab/EUC4JyXx+3Hczbms3zSIW7JOno3yG4iI/bb82Q6CHxTX8g==
X-Gm-Gg: AYBFou3L2Kz7rdr8g25TpECDfUYiZBu8nqto3GcezrylYkw5LyWRtNvW9FlKLbFbBaR
	5up8hcpHVwzbGD/VkO/T1/IdFyYs92lLHNBnluSBkCveNBUdtQ4uN+QOKiCVRVDxc8CEKmZH8gl
	iqTWaGDkfgIauI0PVfBMy31H+lcHSjtSkmjDX18bSHn8T9A7do0FaHSIsCGbvpKsx2Gu5c1h+lO
	NV68SlyHP4xNbqxzIfj4dboh3NI0KAgU5wOgTzWg4dpvFslAvASIyp8nnGMGwrpUEJ2+Ka+S85w
	1sPtSCfq89gpjTlHqHDq4OLWUR4Og5B5BF0s/VQt/zPOlhD8bkZ0kE9ahyJIbe024B91LHP7+/g
	CvGDUt6G80yyP218jOtLymiXKCpQjxSUuHQ9buocMglMH8I2cpQGgzX+ARtSrvmoHmU0+p2iC0Z
	Yk5ll13eEtkJeWkiUqDAjMPh9PLJP5fKDQhUlcAXhlFZpMRPQu/q6AEE3QvYO/K2icfGjxRY11G
	VogGkCwl5A=
X-Received: by 2002:ad4:5dc6:0:b0:917:a943:c4c2 with SMTP id 6a1803df08f44-919977fe5c4mr569016d6.23.1791317164646;
        Tue, 06 Oct 2026 13:06:04 -0700 (PDT)
Received: from [127.0.0.1] ([20.62.255.24])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91996a40d41sm2491996d6.0.2026.10.06.13.06.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 13:06:04 -0700 (PDT)
Message-Id: <pull.2242.v2.git.1791317163584.gitgitgadget@gmail.com>
In-Reply-To: <pull.2242.git.1790627574093.gitgitgadget@gmail.com>
References: <pull.2242.git.1790627574093.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 06 Oct 2026 20:06:03 +0000
Subject: [PATCH v2] doc: use `man git` to teach users how to navigate the docs
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
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Ben Knoble <ben.knoble@gmail.com>,
    Julia Evans <julia@jvns.ca>,
    Julia Evans <julia@jvns.ca>

From: Julia Evans <julia@jvns.ca>

Many existing users of Git don't know how Git's documentation is
structured, and a lot of folks have expressed frustration that `man git`
doesn't make it easy to find out how to get help with using Git.

Explain how Git's help system works in `man git`
(`git push -h` gives a short help, `git push --help` is the full docs),
since it's a slightly unusual approach.

Remove the references to gittutorial and giteveryday since they're
unlikely to help new users learn Git. Currently they feel very
aspirational (it would be nice to have a tutorial and a guide to
everyday Git commands!), but we should give users a realistic view of
what the documentation actually provides.

Mention `git help` instead of `giteveryday` for now, which does a better
job of giving an overview of everyday commands.

Also mention `git help --guides` and `git help --user-interfaces`,
since those parts of the documentation are useful and hard to discover.

Do not mention `git help --developer-interfaces` since it's not relevant
to users.

Signed-off-by: Julia Evans <julia@jvns.ca>
---
    [doc] Use man git to teach users how to navigate the docs
    
    Changes in v2:
    
     * mention the git help push form too
     * mention you can get HTML docs with git help --web push at the end to
       advertise git help's great features, and remove
       https://git.github.io/htmldocs/git.html since
       https://git-scm.com/docs has a nicer view and 3 different options is
       a lot.
     * some minor wording changes
     * fix commit message style (doc: not [doc])

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2242%2Fjvns%2Fupdate-git-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2242/jvns/update-git-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/2242

Range-diff vs v1:

 1:  5da3881760 ! 1:  18f373a8f3 [doc] Use `man git` to teach users how to navigate the docs
     @@ Metadata
      Author: Julia Evans <julia@jvns.ca>
      
       ## Commit message ##
     -    [doc] Use `man git` to teach users how to navigate the docs
     +    doc: use `man git` to teach users how to navigate the docs
      
          Many existing users of Git don't know how Git's documentation is
          structured, and a lot of folks have expressed frustration that `man git`
     @@ Documentation/git.adoc: Git is a fast, scalable, distributed revision control sy
      -commands.  The link:user-manual.html[Git User's Manual] has a more
      -in-depth introduction.  See linkgit:gitdatamodel[7] if you want to
      -learn about the data model and important terminology.
     --
     ++There are two ways to get help with any Git subcommand (replace "push"
     ++with the command you want help with):
     + 
      -After you mastered the basic concepts, you can come back to this
      -page to learn what commands Git offers.  You can learn more about
      -individual Git commands with "git help command".  linkgit:gitcli[7]
      -manual page gives you an overview of the command-line command syntax.
     -+There are two ways to get help on any Git subcommand (replace "push"
     -+with the command you want help with):
     -+
      +- `git push -h` for a short help
     -+- `git push --help` for the full documentation
     -+
     ++- `git push --help` or `git help push` for the full documentation
     + 
     +-A formatted and hyperlinked copy of the latest Git documentation
     +-can be viewed at https://git.github.io/htmldocs/git.html
     +-or https://git-scm.com/docs.
      +There are also guides explaining Git's concepts and more:
     -+
     + 
      +- `git help` shows the most frequently used Git subcommands
      +- `git help --guides` lists Git's concept guides
      +- `git help --user-interfaces` lists guides for various
      +  special files you can use to change Git's behaviour
     ++
     ++You can view an HTML version of the documentation with `git help --web`
     ++(for example `git help --web push`) or at https://git-scm.com/docs.
       
     - A formatted and hyperlinked copy of the latest Git documentation
     - can be viewed at https://git.github.io/htmldocs/git.html
     + OPTIONS
     + -------


 Documentation/git.adoc | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/Documentation/git.adoc b/Documentation/git.adoc
index 6f0075f918..6dfb829a7e 100644
--- a/Documentation/git.adoc
+++ b/Documentation/git.adoc
@@ -22,21 +22,21 @@ Git is a fast, scalable, distributed revision control system with an
 unusually rich command set that provides both high-level operations
 and full access to internals.
 
-See linkgit:gittutorial[7] to get started, then see
-linkgit:giteveryday[7] for a useful minimum set of
-commands.  The link:user-manual.html[Git User's Manual] has a more
-in-depth introduction.  See linkgit:gitdatamodel[7] if you want to
-learn about the data model and important terminology.
+There are two ways to get help with any Git subcommand (replace "push"
+with the command you want help with):
 
-After you mastered the basic concepts, you can come back to this
-page to learn what commands Git offers.  You can learn more about
-individual Git commands with "git help command".  linkgit:gitcli[7]
-manual page gives you an overview of the command-line command syntax.
+- `git push -h` for a short help
+- `git push --help` or `git help push` for the full documentation
 
-A formatted and hyperlinked copy of the latest Git documentation
-can be viewed at https://git.github.io/htmldocs/git.html
-or https://git-scm.com/docs.
+There are also guides explaining Git's concepts and more:
 
+- `git help` shows the most frequently used Git subcommands
+- `git help --guides` lists Git's concept guides
+- `git help --user-interfaces` lists guides for various
+  special files you can use to change Git's behaviour
+
+You can view an HTML version of the documentation with `git help --web`
+(for example `git help --web push`) or at https://git-scm.com/docs.
 
 OPTIONS
 -------

base-commit: 0f8e75abebff0877cae681a3d5ff31ac47f54220
-- 
gitgitgadget
