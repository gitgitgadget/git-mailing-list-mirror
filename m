Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08DE7D3F4
	for <git@vger.kernel.org>; Sun, 16 Feb 2025 21:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739739767; cv=none; b=EvXaidjHTsoRP5aUEqjUbornwLqAHEG0Jgmm4MUXJVGxnDsLLwm7feMuTe5o4DaBUKR+9k40tdxYzo+0U4cNQwsvmbTh2lDCKUt+o+RwsTI6st2AFjKYF6uc74xDzEElZQN4tYY0vTk5lu2r6s1Vxc3QqTD7fBrhPA/SLS98Zf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739739767; c=relaxed/simple;
	bh=i6mGOfc+ZYDxxHlCRCl4PmXH6FxHJeWG4C5wIhsIskg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=dA4vhS8sBKvcECLOzAvIC4TtBDLuB4AlmlcgK6uh6vJ/KVKxPOZMhEdP707zryvYZNQaXRShgd1UNsCf0HyW+twEHLS9OWBzTnuQ7C/T5/+yWrag6RHgv2YhfK/TAxgOjrNKGNrOX6v/hBmi5xmmxp93lYUBKRuXH1yIInWY2cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D4sg4EWd; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D4sg4EWd"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43971025798so5959095e9.1
        for <git@vger.kernel.org>; Sun, 16 Feb 2025 13:02:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739739763; x=1740344563; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H+uuFu7jDTrFxK3BQieHl8p36LDjNy2TqaBCfhKSutY=;
        b=D4sg4EWdXU3EmM6GHdewP352oCr2nFeBVhCHL806b0wIhd2hWGKLYy5odnqRnMGD4o
         pd6TUT/1JeaRYbYqH9nrFcRtzUCu9aehPY8FBcwEEXZ33/0wlIoFkilofvzuzRPmQ7uy
         RMphphVW3Gs5T1lUVgb/HjcYGL2FDd0uLIDq0qLJmA+tcslkqKVGEpK91kZIcWqfje0G
         v3GpIWQKo+mvRJJ2bYMD+bLwxBFaGkBxh+MVfHKA3hcWY91Ss6jzQmu/Ql7CGx9B+Nvn
         D2roEOaavI2XNFgUYIuiE8cUkRgpsS1qPIi+3AClwTA4sTKmg7/qHXz8fGJSBVsdCJFM
         riQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739739763; x=1740344563;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H+uuFu7jDTrFxK3BQieHl8p36LDjNy2TqaBCfhKSutY=;
        b=ndAgnd3sLxUHO+NuxcCcOrbO9CdqSltdO1RpcP0iw1RJrIHcZWlkLL6JXYKe0sBl78
         oNlL8mzXqHD0M2UkZRyxUWXctiPTNLHVC7M3u0uETY7vmFH5vW3xdtazZA3jCCoTZWJS
         cyCx1F5fD+EvPRejn0QxaeuHMGrYD5B1lfTrr56DSiMkentLoUF4tKGIzmapCrqc3mEE
         VseYWCrumrG/MNRgCoMXpkL2R8jB3GqxO/2mtG+rQO6Jz2hhFz0mfXCiyEphuTrZqL5W
         k9aEcaU4Cs+c4TnON/Szo287++9nKspz/xf2mAp4v1OyrbDBDQpJEr0UY6rZjd79vNls
         Ow/w==
X-Gm-Message-State: AOJu0YyzQE9YA3BtkuKgInCKKLhm6SA0IxGHFuODuORIE2JsUsGRpwzt
	KWBhBj3uTMXY3T9/p5Y7rugRDCS5EQCrvMUBQzJcRndUNf9D318zA7riog==
X-Gm-Gg: ASbGncv/++fO/K1yp/gQDEgwUc6/Op23z8ESESIvm4nUsuxQMaN/CCVAlCNypEuY1VI
	CDsMqRmj2vR55kgn7JOq81Xa3H1trqxG+h21De/vo/UKWqEv4+6oMFrUZwNXcRGlkv+opXhlw0b
	YY9kbQ8iJEfEt7kiD0F8CzgZZKPEwrSHYOa0TvwOYcs7a2N06p52pvP84hxRVpNkdfHWP4dZd5s
	Ux0VtvB4dE9irF6Vyp5akHEnEvI0/6ekCBES+Nd+AaZv6sbPOYSbcHgjs7Q7r+ofotIccW+2Kgo
	I40R6jwu+DTXxxG2
X-Google-Smtp-Source: AGHT+IHZy/J17C5xRInjX+MlID3ojJVE2mcOyG1Dl6QrV1yJYJeEO7ou4nJv13RY/auV3M2wq77gYg==
X-Received: by 2002:a05:600c:a014:b0:439:8340:637 with SMTP id 5b1f17b1804b1-439861fdba3mr4776065e9.30.1739739763126;
        Sun, 16 Feb 2025 13:02:43 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439618262c6sm101819075e9.21.2025.02.16.13.02.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2025 13:02:42 -0800 (PST)
Message-Id: <pull.1893.v2.git.git.1739739761445.gitgitgadget@gmail.com>
In-Reply-To: <pull.1893.git.git.1739477118350.gitgitgadget@gmail.com>
References: <pull.1893.git.git.1739477118350.gitgitgadget@gmail.com>
From: "M Hickford via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 16 Feb 2025 21:02:41 +0000
Subject: [PATCH v2] doc: use 'title' consistently
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
Cc: M Hickford <mirth.hickford@gmail.com>,
    M Hickford <mirth.hickford@gmail.com>

From: M Hickford <mirth.hickford@gmail.com>

The first line of a commit message is variously called 'title' or
'subject'.

Prefer 'title' unless discussing email.

Signed-off-by: M Hickford <mirth.hickford@gmail.com>
---
    doc: use 'title' consistently
    
    Patch v2 includes git-rebase.txt

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1893%2Fhickford%2Ftitle-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1893/hickford/title-v2
Pull-Request: https://github.com/git/git/pull/1893

Range-diff vs v1:

 1:  4e31627a4c4 ! 1:  0bca7a06d11 doc: use 'title' consistently
     @@ Commit message
      
          Signed-off-by: M Hickford <mirth.hickford@gmail.com>
      
     - ## Documentation/git-commit.txt ##
     -@@ Documentation/git-commit.txt: OPTIONS
     + ## Documentation/git-commit.adoc ##
     +@@ Documentation/git-commit.adoc: OPTIONS
       	replaces the log message of _<commit>_ with its own log message
       	but makes no changes to the content of _<commit>_.
       +
     @@ Documentation/git-commit.txt: OPTIONS
       and is recognized specially by `git rebase --autosquash`. The `-m`
       option may be used to supplement the log message of the created
       commit, but the additional commentary will be thrown away once the
     -@@ Documentation/git-commit.txt: commit, but the additional commentary will be thrown away once the
     +@@ Documentation/git-commit.adoc: commit, but the additional commentary will be thrown away once the
       `git rebase --autosquash`.
       +
       The commit created by `--fixup=amend:<commit>` is similar but its
     @@ Documentation/git-commit.txt: commit, but the additional commentary will be thro
       _<commit>_ is copied into the log message of the "amend!" commit and
       opened in an editor so it can be refined. When `git rebase
       --autosquash` squashes the "amend!" commit into _<commit>_, the
     -@@ Documentation/git-commit.txt: See linkgit:git-rebase[1] for details.
     +@@ Documentation/git-commit.adoc: See linkgit:git-rebase[1] for details.
       
       `--squash=<commit>`::
       	Construct a commit message for use with `git rebase --autosquash`.
     @@ Documentation/git-commit.txt: See linkgit:git-rebase[1] for details.
       	commit with a prefix of "squash! ".  Can be used with additional
       	commit message options (`-m`/`-c`/`-C`/`-F`). See
       	linkgit:git-rebase[1] for details.
     +
     + ## Documentation/git-rebase.adoc ##
     +@@ Documentation/git-rebase.adoc: See also INCOMPATIBLE OPTIONS below.
     + --no-autosquash::
     + 	Automatically squash commits with specially formatted messages into
     + 	previous commits being rebased.  If a commit message starts with
     +-	"squash! ", "fixup! " or "amend! ", the remainder of the subject line
     ++	"squash! ", "fixup! " or "amend! ", the remainder of the title
     + 	is taken as a commit specifier, which matches a previous commit if it
     +-	matches the subject line or the hash of that commit.  If no commit
     ++	matches the title or the hash of that commit.  If no commit
     + 	matches fully, matches of the specifier with the start of commit
     +-	subjects are considered.
     ++	titles are considered.
     + +
     + In the rebase todo list, the actions of squash, fixup and amend commits are
     + changed from `pick` to `squash`, `fixup` or `fixup -C`, respectively, and they
     +@@ Documentation/git-rebase.adoc: be used to review and edit the todo list before proceeding.
     + The recommended way to create commits with squash markers is by using the
     + `--squash`, `--fixup`, `--fixup=amend:` or `--fixup=reword:` options of
     + linkgit:git-commit[1], which take the target commit as an argument and
     +-automatically fill in the subject line of the new commit from that.
     ++automatically fill in the title of the new commit from that.
     + +
     + Setting configuration variable `rebase.autoSquash` to true enables
     + auto-squashing by default for interactive rebase.  The `--no-autosquash`


 Documentation/git-commit.adoc | 8 ++++----
 Documentation/git-rebase.adoc | 8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-commit.adoc b/Documentation/git-commit.adoc
index dfb78169cb7..dc219025f1e 100644
--- a/Documentation/git-commit.adoc
+++ b/Documentation/git-commit.adoc
@@ -98,8 +98,8 @@ OPTIONS
 	replaces the log message of _<commit>_ with its own log message
 	but makes no changes to the content of _<commit>_.
 +
-The commit created by plain `--fixup=<commit>` has a subject
-composed of "fixup!" followed by the subject line from _<commit>_,
+The commit created by plain `--fixup=<commit>` has a title
+composed of "fixup!" followed by the title of _<commit>_,
 and is recognized specially by `git rebase --autosquash`. The `-m`
 option may be used to supplement the log message of the created
 commit, but the additional commentary will be thrown away once the
@@ -107,7 +107,7 @@ commit, but the additional commentary will be thrown away once the
 `git rebase --autosquash`.
 +
 The commit created by `--fixup=amend:<commit>` is similar but its
-subject is instead prefixed with "amend!". The log message of
+title is instead prefixed with "amend!". The log message of
 _<commit>_ is copied into the log message of the "amend!" commit and
 opened in an editor so it can be refined. When `git rebase
 --autosquash` squashes the "amend!" commit into _<commit>_, the
@@ -128,7 +128,7 @@ See linkgit:git-rebase[1] for details.
 
 `--squash=<commit>`::
 	Construct a commit message for use with `git rebase --autosquash`.
-	The commit message subject line is taken from the specified
+	The commit message title is taken from the specified
 	commit with a prefix of "squash! ".  Can be used with additional
 	commit message options (`-m`/`-c`/`-C`/`-F`). See
 	linkgit:git-rebase[1] for details.
diff --git a/Documentation/git-rebase.adoc b/Documentation/git-rebase.adoc
index 133fe8c5e6a..153cb69a4f8 100644
--- a/Documentation/git-rebase.adoc
+++ b/Documentation/git-rebase.adoc
@@ -599,11 +599,11 @@ See also INCOMPATIBLE OPTIONS below.
 --no-autosquash::
 	Automatically squash commits with specially formatted messages into
 	previous commits being rebased.  If a commit message starts with
-	"squash! ", "fixup! " or "amend! ", the remainder of the subject line
+	"squash! ", "fixup! " or "amend! ", the remainder of the title
 	is taken as a commit specifier, which matches a previous commit if it
-	matches the subject line or the hash of that commit.  If no commit
+	matches the title or the hash of that commit.  If no commit
 	matches fully, matches of the specifier with the start of commit
-	subjects are considered.
+	titles are considered.
 +
 In the rebase todo list, the actions of squash, fixup and amend commits are
 changed from `pick` to `squash`, `fixup` or `fixup -C`, respectively, and they
@@ -613,7 +613,7 @@ be used to review and edit the todo list before proceeding.
 The recommended way to create commits with squash markers is by using the
 `--squash`, `--fixup`, `--fixup=amend:` or `--fixup=reword:` options of
 linkgit:git-commit[1], which take the target commit as an argument and
-automatically fill in the subject line of the new commit from that.
+automatically fill in the title of the new commit from that.
 +
 Setting configuration variable `rebase.autoSquash` to true enables
 auto-squashing by default for interactive rebase.  The `--no-autosquash`

base-commit: 03944513488db4a81fdb4c21c3b515e4cb260b05
-- 
gitgitgadget
