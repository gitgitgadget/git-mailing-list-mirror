Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76ADA1C5F1B
	for <git@vger.kernel.org>; Fri, 19 Dec 2025 00:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766103858; cv=none; b=OpqcCkLPpxMFmGfl8YZ9ZGk8MxAs1ExjLbLV9VwTu4NODrNqb+FVrTCrAG5hYWlnePZPuHZo0pUWQTbkkFVWL7J6NnD9twlgJ+L0SmNCkf5GIa5UwI1dvNnlEIAhLFLHLQN8dOQllrvhgws/+Pxc2D+aNuEmsZuksSlyIO9xkAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766103858; c=relaxed/simple;
	bh=zSiz9rcibaLtfeMz91O8NqL82qkJeZ2zM51rNixsmCI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GACkWDSUmTH/jmWHPn0O6M6ej8tlVl9eYvpRonoJN78zGEPFWHE/DpuhQ49/nyWHzSDjCVNgpK1gvV8LYgXLo5vErLjE98cJoO2nX4AEDYghKJyyUHaU2RiuYGLxn1KgfloMhZC8MmJvs4XBTEfbbEt0TTo6vfoC3A2d9jfcdDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZjIbZOhY; arc=none smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZjIbZOhY"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-64464de1c45so1096486d50.2
        for <git@vger.kernel.org>; Thu, 18 Dec 2025 16:24:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766103855; x=1766708655; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/0sVOuMJUSJPRWsg4ljOWXopSHaA3ZBPQTxjWpktyV4=;
        b=ZjIbZOhYMDqwVBgqpqxISacp33Ha4W7uM88bitn9F5MOYEpqP6VOpo64nprouHs3oH
         ER2Gy7vuRv2Q4iSaXczhkgLFS1kx06mRT06X6aQku4KRwQsAzyah++JYfSCLpCxZHMIB
         qL+k+sEM39/A+8Z6mlOklF8wRN0XVccCg78OMt3R6sLMoSyh+rtVHpMc+F++MNbC5BXJ
         aZnf1SJ5X0aRa5klY4w7BWwlZr2wDjAFUBAfHXKvgm1ySFS4zYFV4IyMBjenIUhGwHdB
         /3Ktg2SVrNAzD//GVs1DkhPDPDCGemwoeovv8e3HLHPgIWQ8Y/yktIuaNlYDXhZ/xfzP
         OoaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766103855; x=1766708655;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/0sVOuMJUSJPRWsg4ljOWXopSHaA3ZBPQTxjWpktyV4=;
        b=dhZPKTFagSMDJ8vZ0jfBKgtyXpXhfWM4StJ6zPHUVF2n+hqhSGpvJdCZ7WFaK/K3dZ
         FyHp/731DJhyfXqfiyX/PNllvttcV7WFdQjI0griuDiYApnRnbnKQLs1MHglwS/kyKdr
         z6Rs5mhBVp0nb6H38I/MSz4PZ6KCe8wZikFEKUo95LlUtFQ6qM/IuskJ3cFKH37mhxcE
         gNc/sVLiO6Sg+1cgx3zg78L4qxK1/EKfyUfbmk3s3NKMhh1JgKM7MBUBYOCw1mVI2Pdq
         tj6M25S/YVAfBZr4M6Vk3v1n/C9/J4y2WAc1DSz2GF0fdDdnIJi5uV8HG7KKyXkvQRl6
         76TQ==
X-Gm-Message-State: AOJu0YzcCZ2AOACu96IpmSHrPGs6uzOKSN/3WCicUfmOrPmTJINzyZuz
	i1yGEaOkYU3LijsZhDsakBQ4BnWfGGBJ8A3okVhVL3lolXiw2q+p55GynbwFTQ==
X-Gm-Gg: AY/fxX47Czllh14putw//ZYjEyB+5WIm41Zd0ui9Q2jpYt1tVyzNUclN8CvoctFkH10
	3GxPjyioHDzL+O489+dLZZWibdOmnwfIjexXKh6LMKqBtlMaRx7iA2eqEY0z+HlOOKSzK/Osy0g
	/y/nGM9tDO4K0dciD8sAy7hhjPxQ+J+evL07kYSzVlVPjlpDszThUU7VkM+aM/Ktv/zUthaNvxb
	J5+XDAIPF15dukJLoRyz+Lv4BM/C0KaiDJdL9qyhNBd8DB8qCDowU4aonSSr8Cn7nfVpye1l16x
	VxW9ObkKO0qTPYAWV7pfoeSe+WW413D4EolQxCT6yDYUNpqJhCToTVW42KTexILAcaNDWlbsORG
	Wh/gfTvrMWL0jRMR8af/4cQFGNB9klS+E2OCQ4IKDzwwxWQeLZ+YSKP30sJL0ycVmSDwrgHEecY
	N/JfgpAzALakzPWaA=
X-Google-Smtp-Source: AGHT+IF0rvUS1X1NofViu+7yyEc+2kU6+ruAHZOq6HLrVBoU8Do/xcjPM8A8k8BOZZAKsaz3rgac5A==
X-Received: by 2002:a53:bd86:0:b0:644:7afd:f484 with SMTP id 956f58d0204a3-6466a8a9970mr781987d50.40.1766103854884;
        Thu, 18 Dec 2025 16:24:14 -0800 (PST)
Received: from localhost.localdomain ([2605:a601:90a8:8b00::a])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78fb44f0dcdsm3658427b3.30.2025.12.18.16.24.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 16:24:14 -0800 (PST)
Sender: "D. Ben Knoble" <ben.knoble@gmail.com>
From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble+github@gmail.com>,
	Julia Evans <julia@jvns.ca>
Subject: [PATCH v2 0/4] doc: git-reset: clarify DESCRIPTION section
Date: Thu, 18 Dec 2025 19:23:52 -0500
Message-ID: <cover.1766103827.git.ben.knoble+github@gmail.com>
X-Mailer: git-send-email 2.52.0.rc0.365.g9bf09b728d.dirty
In-Reply-To: <pull.1991.git.1760731558.gitgitgadget@gmail.com>
References: <pull.1991.git.1760731558.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This continues Julia Evans's excellent work updating the git-reset docs.

Changes in v2:
- Mostly address Junio's review while keeping to Julia's style (?),
  taking at a stab at a few gray areas.
- I left alone the first patch, the commented-upon part of which is
  later rewritten anyway.

v1: https://lore.kernel.org/git/pull.1991.git.1760731558.gitgitgadget@gmail.com/
Published-as: https://github.com/benknoble/git/tree/bk/je/doc-reset

Julia Evans (4):
  doc: git-reset: reorder the forms
  doc: git-reset: clarify intro
  doc: git-reset: clarify `git reset [mode]`
  doc: git-reset: clarify `git reset <pathspec>`

 Documentation/git-reset.adoc | 105 ++++++++++++++++++-----------------
 1 file changed, 54 insertions(+), 51 deletions(-)

Diff-intervalle contre v1 :
1:  5074fbf4ea ! 1:  a558c5a868 doc: git-reset: reorder the forms
    @@ Metadata
      ## Commit message ##
         doc: git-reset: reorder the forms
     
    -    >From user feedback: three users commented that the `git reset [mode]`
    +    From user feedback: three users commented that the `git reset [mode]`
         form is the one that they primarily use, and that they were suprised to
         see it listed last.
         ("I've never used git reset in any mode other than --hard").
2:  c7049edf39 ! 2:  f90be8559f doc: git-reset: clarify intro
    @@ Metadata
      ## Commit message ##
         doc: git-reset: clarify intro
     
    -    >From user feedback, there were several points of confusion:
    +    From user feedback, there were several points of confusion:
     
         - What "tree-ish", "entries", "working tree", "HEAD", and "index" mean
           ("I have no clue what the index is", "I've been using git for 20 years
    @@ Documentation/git-reset.adoc: git-reset(1)
      NAME
      ----
     -git-reset - Reset current HEAD to the specified state
    -+git-reset - Set HEAD to point at the specified commit
    ++git-reset - Set HEAD or the index to a known state
      
      SYNOPSIS
      --------
    @@ Documentation/git-reset.adoc: git reset (--patch | -p) [<tree-ish>] [--] [<paths
     -optionally modifying index and working tree to match.
     -The _<tree-ish>_/_<commit>_ defaults to `HEAD` in all forms.
     -In the last three forms, copy entries from _<tree-ish>_ to the index.
    -+`git reset [<mode>] <commit>` changes which commit HEAD points to.
    -+This makes it possible to undo various Git operations, for example
    -+commit, merge, rebase, and pull.
    ++`git reset` does either of the following:
     +
    -+However, when you specify files or directories or pass `--patch`,
    -+`git reset` will instead update the staged version of the specified
    -+files without updating HEAD.
    ++1. `git reset [<mode>] <commit>` changes which commit HEAD points to. This makes
    ++   it possible to undo various Git operations, for example commit, merge,
    ++   rebase, and pull.
    ++2. When you specify files or directories or pass `--patch`, `git reset` updates
    ++   the staged version of the specified files.
      
      `git reset [<mode>] [<commit>]`::
      	This form resets the current branch head to _<commit>_ and
3:  84aed17da6 ! 3:  89c87c14aa doc: git-reset: clarify `git reset [mode]`
    @@ Metadata
      ## Commit message ##
         doc: git-reset: clarify `git reset [mode]`
     
    -    >From user feedback, there was some confusion about the differences
    +    From user feedback, there was some confusion about the differences
         between the modes, including:
     
         1. Sometimes it says "index" and sometimes "index file".
            Fix by replacing "index file" with "index".
         2. Many comments about not being able to understand what `--merge` does.
    -       Fix by mentioning `git merge --abort` since my best guess is that
    -       most folks want to use that instead of `git reset --merge`.
    +       Fix by mentioning obscure situations, since that seems to be what
    +       it's for. Most folks will use `git <cmd> --abort`.
         3. Issues telling the difference between --soft and --mixed, as well as
            --keep. Leave --keep alone because I couldn't understand its use case,
            but change `--soft` / `--mixed` / `--hard` as follows:
    @@ Commit message
         Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
      ## Documentation/git-reset.adoc ##
    -@@ Documentation/git-reset.adoc: However, when you specify files or directories or pass `--patch`,
    - files without updating HEAD.
    +@@ Documentation/git-reset.adoc: DESCRIPTION
    +    the staged version of the specified files.
      
      `git reset [<mode>] [<commit>]`::
     -	This form resets the current branch head to _<commit>_ and
    @@ Documentation/git-reset.adoc: However, when you specify files or directories or
      linkgit:git-add[1]).
      
     +`--soft`::
    -+	Leaves your working directory unchanged. The index is left unchanged,
    -+	so everything in your current commit will be staged.
    ++	Leave your working tree files and the index unchanged.
     +	For example, if you have no staged changes, you can use
     +	`git reset --soft HEAD~5; git commit`
    -+	to combine the last 5 commits into 1 commit.
    ++	to combine the last 5 commits into 1 commit. This works even with
    ++	changes in the working tree, which are left untouched, but such usage
    ++	can lead to confusion.
     +
      `--hard`::
     -	Resets the index and working tree. Any changes to tracked files in the
     -	working tree since _<commit>_ are discarded.  Any untracked files or
     -	directories in the way of writing any tracked files are simply deleted.
     +	Overwrites all files and directories with the version from _<commit>_,
    -+	and may overwrite untracked files.
    ++	and may overwrite untracked files. Tracked files not in _<commit>_ are
    ++	removed so that the working tree matches _<commit>_.
     +	Updates the index to match the new HEAD, so nothing will be staged.
      
      `--merge`::
    -+	Mainly exists for backwards compatibility: `git merge --abort` is the
    -+	usual way to abort a merge. See linkgit:git-merge[1] for the differences.
    ++	Mainly exists to reset unmerged index entries, like those left behind by
    ++	`git am -3` or `git switch -m` in certain situations.
      	Resets the index and updates the files in the working tree that are
      	different between _<commit>_ and `HEAD`, but keeps those which are
      	different between the index and working tree (i.e. which have changes
4:  0b9583f872 ! 4:  d6582dc53c doc: git-reset: clarify `git reset <pathspec>`
    @@ Metadata
      ## Commit message ##
         doc: git-reset: clarify `git reset <pathspec>`
     
    -    >From user feedback:
    +    From user feedback:
     
         - Continued confusion about the terms "tree-ish" and "pathspec"
         - The word "hunks" is confusing folks, use "changes" instead.
    @@ Documentation/git-reset.adoc: linkgit:git-add[1]).
     -and specifying a commit with `--source`, you
     -can copy the contents of a path out of a commit to the index and to the
     -working tree in one go.
    -+`git reset` only modifies the index: use linkgit:git-restore[1] instead
    -+if you'd like to also update the file in your working directory.
    ++In this mode, `git reset` updates only the index (without updating the HEAD or
    ++working tree files). If you want to update the files as well as the index
    ++entries, use linkgit:git-restore[1].
      
      `git reset (--patch | -p) [<tree-ish>] [--] [<pathspec>...]`::
     -	Interactively select hunks in the difference between the index
    @@ Documentation/git-reset.adoc: linkgit:git-add[1]).
     -	in reverse to the index.
     +	Interactively select changes from the difference between the index
     +	and the specified commit or tree (which defaults to `HEAD`).
    -+	The chosen changes are unstaged.
    ++	The chosen changes are added to the index.
      +
      This means that `git reset -p` is the opposite of `git add -p`, i.e.
     -you can use it to selectively reset hunks. See the "Interactive Mode"
-- 
2.52.0.rc0.365.g9bf09b728d.dirty

