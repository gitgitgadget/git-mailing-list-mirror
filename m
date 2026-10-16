Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552DA45A29E
	for <git@vger.kernel.org>; Fri, 16 Oct 2026 19:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792178108; cv=none; b=Z2Iq75azdG9n7Agv1yCIZgDtAF+4tOcK/pvD3oC+K7qCPienReIMAP11hEHvuLQ+ILtTJ3xk1WYkjDdMwwrle81a9lkcEX2yt/ULmqMmcIpkGLkWTNfK3rHQaUO3hoBJta8EHnWznnCaG0z3v+k0wPUAeaMGW7CVHe82B6RO9YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792178108; c=relaxed/simple;
	bh=ivxbIHCA1N2BL081aXYkP+qJFG/luO4jSHd1G1CaOQI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=FF1FbHt3rl9+7Y35BGl0siHzCY4QXFJZAtTnsGHDtteGh2PxtbUTxCEJ2O+OrI/q+V8IJBYFnMTL3h7XkkOhQweyUOTMtVXDVqMD4cn4zxkdXKElKSveK9XTAvUHrtNceK/7tUCOuLM1ko6OuqvimQ6bL1RW3p8MF05FAxZa23w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TMeB+fLb; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TMeB+fLb"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-917c04630c2so3492196d6.3
        for <git@vger.kernel.org>; Fri, 16 Oct 2026 12:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792178106; x=1792782906; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=zhA7vYDd7tqPsbzWipZhCcyMAjoEBLaHbTVIDGyjzXU=;
        b=TMeB+fLbUd9yQOLbEUBd8AL6MFa0sxsdxGB4DM6jKYpreUpc6yfRy4z3t7is967phD
         dT8CAD6obgDPo3fcs35oJyzS7/90NbPG1y9lxTEpXebuPeBDGl/5yBOfK3Mqg5dKmrTk
         1g6xM46G2CLPwKAYjo7IGOFpQFfPVKg0cseRZLhgtyrVzrZ6VxpUVYxVwm0Eoi1ELHuY
         LrgmSYR3IqdXmppW0aZ2rPFcnK0biburFZ1RtaWYrlqM3IAeOyqqCA0XxjtN6TbT5Qhx
         Va5NNhi7S4KyHOX4n64FDqqTnCMx9BWNcWBLqwmaPV8gPHcJ3S7lf0k7zzkXls3tYstJ
         5hWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792178106; x=1792782906;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zhA7vYDd7tqPsbzWipZhCcyMAjoEBLaHbTVIDGyjzXU=;
        b=g9DjyClwU9lAXRmw3TaafKXczbJT1HEZYhnCU9a+L5lNc86g6AmIQfb++nY8ti2KVl
         zIEhnpX7aioMoiPtKtmma+l78FFcSzQuimSq8cyT1xASofooVh74V2FW0wnHxljobitg
         kPl+ph9zk0EbvaSSpiV5rQjs+Ccttr7/zeQ2eK0hgJSSqf7eIC4V5+1uwLN1a52T87US
         yVowsNmoGEtEiY98x4uyXaA0seHmfGgm68kx4ywM3iTxmqufzenm42hpgsrPbYalRE1B
         LILqVYvVCP/6A/bff5gwmUq4FevyAuSrlyR9Vw0jGchZ4EyMJF1xGg/i2JAtLzdpCFn2
         d/Yw==
X-Gm-Message-State: AFq9FYJBsoaHJ5kZvMIMwt5+G3i/YUbhcGc/7lHKTBashyQZCy1sJi5C
	8GbdefdIshsUKArSjF2n/+TlUVMT9h9zWLfQfSDFFy4Fw0D99UG6clnRNz2CLw==
X-Gm-Gg: AYBFou3e42f8qUipGysTp6jaIuB/ot2WcvKOE+PFQBaawTcBW7GhsdpFL1jaZ8t1Vum
	zd3yCmwu5eotoF2dFPeTEqKuOoAj4ZAj/VPX5OaFy5+1cPKtJ0iMipI5VIZPiPjajeThLFpJtWN
	hEUsJWyaK2Bhs8+R++DGmB50q0O0tYCTact1O7UyzLYv1NUg6u3ls7pedrOaGRVU1AAUqcWzBeH
	nmFBI3g8lAgihtl5U3Cjd3UHHMOogr6RWrIhq2Aw6QdbV2LdQ9HfwAkxDAKqQhvIc2m/6uMj9Wk
	LaCNsFQDqr6KLmd7R9OCOqR7GvEP2SrmOCvj4pH5Hsnfke8V47Le+DlhIJ8ztDTVKi2IrqHHYYr
	RMott6Goah7KQM52yyC5HaHQd3ylhPmeJ8aCfs1tgwZ/vyIqpTxUNC5i9ag+nzGDYTdssz+QRig
	gYdPT0tK39dg7eKLDKzjFflsyh03NYWYFu+GkfJOXTRgmf7ByfDAiYWPJ8bLintygv9Jd0BtbiL
	Bk=
X-Received: by 2002:a05:620a:17a2:b0:93e:f9ba:690e with SMTP id af79cd13be357-93f29b632c6mr149861485a.3.1792178106064;
        Fri, 16 Oct 2026 12:15:06 -0700 (PDT)
Received: from [127.0.0.1] ([20.127.215.179])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93f1a185ea6sm284342385a.21.2026.10.16.12.15.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 12:15:04 -0700 (PDT)
Message-Id: <pull.2242.v3.git.1792178103727.gitgitgadget@gmail.com>
In-Reply-To: <pull.2242.git.1790627574093.gitgitgadget@gmail.com>
References: <pull.2242.git.1790627574093.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 16 Oct 2026 19:15:03 +0000
Subject: [PATCH v3] doc: use `man git` to teach users how to navigate the docs
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

Rewrite `man git` to give a more realistic view of what the
documentation actually provides.

Explain how Git's help system works in `man git`
(`git push -h` gives a short help, `git push --help` is the full docs),
since it's a slightly unusual approach.

Remove the direct references to all the guides, for the following
reasons:

* gittutorial and giteveryday are unlikely to help new users learn
  Git. Currently they feel very aspirational (it would be nice to have
  a tutorial and a guide to everyday Git commands!), but we should give
  users a realistic view of what the documentation actually provides.

  The goal is to mention the tutorial again when when we have a tutorial
  we're happy with.
* gitcli is not very useful for users. A lot of it is about scripting
  and internal details about the option parser.
* the user manual is outdated. The chapter on "Sharing development with
  others" explains how to use `git format-patch` which is not how most
  Git users collaborate with git.
* mentioning the data model feels out of place once everything else is
  removed

Mention `git help` instead of `giteveryday` for now, which does a better
job of giving an overview of everyday commands.

Mention `git help --guides` and `git help --user-interfaces`,
since there are some important guides in there (like `submodules`) that
are hard to discover.

Do not mention `git help --developer-interfaces` since it's not relevant
to users.

Remove https://git.github.io/htmldocs/git.html since it points to the
`master` version of the documentation. https://git-scm.com/ has the
version from the latest release which is more likely to be useful.

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
    
    Changes in v3: (just updates to the commit message)
    
     * Add a sentence summarizing the goals "give a more realistic view of
       what the documentation actually provides."
     * Explain why we're removing https://git.github.io/htmldocs/git.html,
       gitcli, and the user manual, and the data model
     * Mention the plan to include the tutorial again here once we have one
       we're happy with

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2242%2Fjvns%2Fupdate-git-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2242/jvns/update-git-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/2242

Range-diff vs v2:

 1:  18f373a8f3 ! 1:  6cb4390e53 doc: use `man git` to teach users how to navigate the docs
     @@ Metadata
       ## Commit message ##
          doc: use `man git` to teach users how to navigate the docs
      
     -    Many existing users of Git don't know how Git's documentation is
     -    structured, and a lot of folks have expressed frustration that `man git`
     -    doesn't make it easy to find out how to get help with using Git.
     +    Rewrite `man git` to give a more realistic view of what the
     +    documentation actually provides.
      
          Explain how Git's help system works in `man git`
          (`git push -h` gives a short help, `git push --help` is the full docs),
          since it's a slightly unusual approach.
      
     -    Remove the references to gittutorial and giteveryday since they're
     -    unlikely to help new users learn Git. Currently they feel very
     -    aspirational (it would be nice to have a tutorial and a guide to
     -    everyday Git commands!), but we should give users a realistic view of
     -    what the documentation actually provides.
     +    Remove the direct references to all the guides, for the following
     +    reasons:
     +
     +    * gittutorial and giteveryday are unlikely to help new users learn
     +      Git. Currently they feel very aspirational (it would be nice to have
     +      a tutorial and a guide to everyday Git commands!), but we should give
     +      users a realistic view of what the documentation actually provides.
     +
     +      The goal is to mention the tutorial again when when we have a tutorial
     +      we're happy with.
     +    * gitcli is not very useful for users. A lot of it is about scripting
     +      and internal details about the option parser.
     +    * the user manual is outdated. The chapter on "Sharing development with
     +      others" explains how to use `git format-patch` which is not how most
     +      Git users collaborate with git.
     +    * mentioning the data model feels out of place once everything else is
     +      removed
      
          Mention `git help` instead of `giteveryday` for now, which does a better
          job of giving an overview of everyday commands.
      
     -    Also mention `git help --guides` and `git help --user-interfaces`,
     -    since those parts of the documentation are useful and hard to discover.
     +    Mention `git help --guides` and `git help --user-interfaces`,
     +    since there are some important guides in there (like `submodules`) that
     +    are hard to discover.
      
          Do not mention `git help --developer-interfaces` since it's not relevant
          to users.
      
     +    Remove https://git.github.io/htmldocs/git.html since it points to the
     +    `master` version of the documentation. https://git-scm.com/ has the
     +    version from the latest release which is more likely to be useful.
     +
          Signed-off-by: Julia Evans <julia@jvns.ca>
      
       ## Documentation/git.adoc ##


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
