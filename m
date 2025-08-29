Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025512D640D
	for <git@vger.kernel.org>; Fri, 29 Aug 2025 11:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756467939; cv=none; b=lVySwtAQhMXDQRVFh9V1mx+Az0qGhHSt4OUAqnwofrTmPd4X8YTVLNHceu6dDOhwAHQatKxa5CTMyXjq5WY46QYKWyu92iGZzm2NKumxVx5wUSKVB+YE2KlPTeY+PTt1GXk0t9Wl8CCYS0rccMrcDtPAvITXePWN4/r76WhRagE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756467939; c=relaxed/simple;
	bh=+tcP8D7Bo0N+b6/Vp8y+vT4XotetKcL3pUmBOtk4qUw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=tVRntC60Nn8Noq5WGuO5Ue/zvquU69OD1ug/9E667QhaS/x4E8Zms1AaJpNpDiXJO1h+ZnMtHXTQrXGnL5KzebHr0I1PkaTsdbymEgVbP63Epprh0hRfal2nWHhwtaef6AdQ7j++Tz+8xw6EKuffl8hsa6vqpnAkdGgYBgJ9WCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FrjojUuY; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FrjojUuY"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7f861f89313so189516785a.1
        for <git@vger.kernel.org>; Fri, 29 Aug 2025 04:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756467936; x=1757072736; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HJ8SyCHLF4l7hocUmAybAjP72a1XW25REFbV6sTq/9U=;
        b=FrjojUuY311XLBpnXFPkFF9e1YOnfqaiWDqlXLOOqEpTcgZwtvns7r7mLvfIG23a9A
         TM4f4bxtUFTr1iLYVQOBtN15S4f4iHGnhVaRQYcghhK1V/pqfjnC8UTRsX9L52hyt2PG
         ok9Cf77MpkHf9NOiT++K9sJbQ8oE4TX4lAkTWww6x9APZBq7iPYGkeZeAgKc/Pyb369Y
         Gi72uznx/3EzG8FBOiSju5U3uzWv7U9Pe/CcGescIL2LF9bEbzjC1Q4F3jXy5JP1M+pX
         CGC8AWFuQiW0mdqPjxBvjhsK2rplo+ecV08GKCfaN/YXKbtaerIeIS5JgNo8ULmN5jMY
         nutw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756467936; x=1757072736;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HJ8SyCHLF4l7hocUmAybAjP72a1XW25REFbV6sTq/9U=;
        b=I+tAFPODdIXNV6qgfu3uAGUKfGOrhXvh7WxagOkT3rOpTizUYuiYv01c+JpJcHT4X3
         0dRgcGzEuK7IFi+hTJjIwqMbwFGIq571IgXCxAVUld9YRY2tqeE+1CEa+rLKCcs8Y32A
         yN0cHfVDg21XwDGaJh+iOj1FYUKm5ywk6VbJ/RtZ39/wQfiJg+1qoOvylZ7hIKieNEN9
         PQVb9iRENALnkDqk/YKjvbdWaXdwvA8Ozha6AjZx735ZWmQKK+YPE+N173WGWgIuHoN7
         zEBd9uD5+SboR4QfNLGSZzA3UMILeRtzhksU8/6yJMIbNNSEGNeWRpmLb0k6XkbK/nOd
         o5UA==
X-Gm-Message-State: AOJu0YxrG090N2dcY1Le4cZSOxcxYDmunkTNgoqVBV7Izu68Pf8fkjvf
	rjHG9H/8uwi8FWxjuBn1IzWtorRizxnaWum0sCFcIm8Z/kLZVTaLgBMzex/41XTu
X-Gm-Gg: ASbGncsl+4Vawk2Fcw6/wSlEnsBlpiyMT6TX5Cmb0SjJXLRN4Tv95fs5W7QFWn/Inpp
	KQJpwD6Z93GKukI9OiMVwtQcyuAMsdBlpoD1VuBQpbOPLU0QFqvMzIJ38mihifjCVhUUZTpuEEF
	kAhnV/8kZjP2C2m03GxP0UxbCzUj/BR/N3jztaaaBw9OwRmDKrRr5cUVQ/hSo6Nm8+N/XUO1u8I
	m7EYqEcqp7tkAY4piEFMpySoW2GBLbpbAzDg38LrhiFlfCMBAzkP+5sZUukwOfkZ5l4FOGhLIad
	25uOrzvhh24f+BezPQif0S4JbKgveVIO4fOBgqU2kdSj20MaCVigqRHLZIbBHWH7Wlsafvk2+zV
	KlJGnLMS0iGqek5JJYKKQoh6oXgfyNJwqrg==
X-Google-Smtp-Source: AGHT+IG6Gys6+uWP7or2k6l5Fye8GT/i0yY7YtgNts6gTFzTZ52uIovWwrUZE3eSWibGJH+FLxNRCw==
X-Received: by 2002:a05:620a:4593:b0:7f9:c004:42e with SMTP id af79cd13be357-7f9c0040489mr771156785a.0.1756467936303;
        Fri, 29 Aug 2025 04:45:36 -0700 (PDT)
Received: from [127.0.0.1] ([20.57.47.232])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7fc151f17b8sm154713285a.50.2025.08.29.04.45.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 04:45:35 -0700 (PDT)
Message-Id: <pull.1962.v2.git.1756467934.gitgitgadget@gmail.com>
In-Reply-To: <pull.1962.git.1756148933.gitgitgadget@gmail.com>
References: <pull.1962.git.1756148933.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 29 Aug 2025 11:45:29 +0000
Subject: [PATCH v2 0/5] doc: git-checkout: clarify DESCRIPTION section
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
    Julia Evans <julia@jvns.ca>

 * Remove the numbered list from the beginning
 * Split up the git checkout [<tree-ish>] <pathspec> section into two
   sections, one for git checkout <tree-ish> <pathspec> and one for git
   checkout <pathspec>, to match the SYNOPSIS and because it seems like a
   clearer approach. Also completely rewrite them to be more accurate and
   more clear. Use "Replace" instead of "Restore".
 * Describe what it means to "switch branches" in a way that's more
   accessible to newcomers, and make "If the local changes conflict with the
   changes on ..." more accurate
 * Improve the ARGUMENT DISAMBIGUATION section

Julia Evans (5):
  doc: git-checkout: clarify intro
  doc: git-checkout: clarify `git checkout <branch>`
  doc: git-checkout: don't use "reset"
  doc: git-checkout: deduplicate --detach explanation
  doc: git-checkout: clarify restoring files section

 Documentation/git-checkout.adoc | 114 +++++++++++++++++---------------
 1 file changed, 60 insertions(+), 54 deletions(-)


base-commit: c44beea485f0f2feaf460e2ac87fdd5608d63cf0
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1962%2Fjvns%2Fclarify-checkout-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1962/jvns/clarify-checkout-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1962

Range-diff vs v1:

 1:  a6125a0128 ! 1:  48e7f23029 doc: git-checkout: clarify intro
     @@ Documentation/git-checkout.adoc: git checkout (-p|--patch) [<tree-ish>] [--] [<p
      -or the specified tree.  If no pathspec was given, `git checkout` will
      -also update `HEAD` to set the specified branch as the current
      -branch.
     -+`git checkout` has two main modes:
     -+
     -+1. **Switch branches**, with `git checkout <branch>`
     -+2. **Restore a different version of a file**, for example with `git
     -+   checkout <commit> <filename>` or `git checkout <filename>`
     ++`git checkout` has two main modes: it can
     ++**switch branches**, for example with `git checkout <branch>`, and
     ++**restore files from a different version**, for example with
     ++`git checkout <commit> <filename>` or `git checkout <filename>`
      +
      +See ARGUMENT DISAMBIGUATION below for how Git decides which one to do.
     -+Here's a description of all of the modes:
       
       `git checkout [<branch>]`::
       	To prepare for working on _<branch>_, switch to it by updating
     @@ Documentation/git-checkout.adoc: $ git log -g -2 HEAD
      +`<something>` is intended to be a branch, a commit, or a set of file(s),
      +and then switches branches, switches commits, or restores the files.
      +
     -+If there's a conflict, you can use the double dash `--` to distinguish
     -+between branches and files:
     ++If there's any ambiguity, Git will treat `<something>` as a branch or
     ++commit, but you can use the double dash `--` to force Git to treat the
     ++parameter as a list of files and/or directories, like this:
      +
     -+* `git checkout <branch> --` will force Git to treat the parameter as a
     -+  branch name or commit
     -+* `git checkout -- <pathspec>` will force Git to treat the parameter as
     -+  a set of file(s)
     ++----------
     ++git checkout -- file.txt
     ++----------
       
       EXAMPLES
       --------
 2:  b8873c4529 ! 2:  23a738981a doc: git-checkout: clarify `git checkout <branch>`
     @@ Commit message
          Signed-off-by: Julia Evans <julia@jvns.ca>
      
       ## Documentation/git-checkout.adoc ##
     -@@ Documentation/git-checkout.adoc: See ARGUMENT DISAMBIGUATION below for how Git decides which one to do.
     - Here's a description of all of the modes:
     +@@ Documentation/git-checkout.adoc: DESCRIPTION
     + See ARGUMENT DISAMBIGUATION below for how Git decides which one to do.
       
       `git checkout [<branch>]`::
      -	To prepare for working on _<branch>_, switch to it by updating
     @@ Documentation/git-checkout.adoc: See ARGUMENT DISAMBIGUATION below for how Git d
      -	`HEAD` at the branch. Local modifications to the files in the
      -	working tree are kept, so that they can be committed to the
      -	_<branch>_.
     -+	Switch to _<branch>_. This will update the files in the working tree,
     -+	point `HEAD` at the branch, and update the index. Local changes to
     ++	Switch to _<branch>_. This sets the current branch to <branch> and
     ++	updates the files in your working directory. Local changes to
      +	the files in the working tree are kept, so that they can be committed
     -+	to the _<branch>_. If the local changes conflict with the changes on
     -+	_<branch>_, no changes will be made and the checkout operation will
     -+	fail.
     ++	to the _<branch>_. If the local changes can't be cleanly merged into
     ++	the _<branch>_, no changes will be made and the checkout operation will fail.
       +
       If _<branch>_ is not found but there does exist a tracking branch in
       exactly one remote (call it _<remote>_) with a matching name and
     @@ Documentation/git-checkout.adoc: exactly one remote (call it _<remote>_) with a
      -"check out the current branch", which is a glorified no-op with
      -rather expensive side-effects to show only the tracking information,
      -if it exists, for the current branch.
     -+Running `git checkout` without specifying a branch will output the
     -+tracking information, if it exists, for the current branch, but it's
     -+slower than getting the same information from `git status`.
     ++Running `git checkout` without specifying a branch has no effect except
     ++to print out the tracking information for the current branch.
       
       `git checkout (-b|-B) <new-branch> [<start-point>]`::
       
 3:  0a3915264b ! 3:  360051d2a6 doc: git-checkout: don't use "reset"
     @@ Commit message
          Signed-off-by: Julia Evans <julia@jvns.ca>
      
       ## Documentation/git-checkout.adoc ##
     -@@ Documentation/git-checkout.adoc: slower than getting the same information from `git status`.
     +@@ Documentation/git-checkout.adoc: to print out the tracking information for the current branch.
       	`--track` without `-b` implies branch creation; see the
       	description of `--track` below.
       +
 4:  2221a6bfb5 = 4:  6f3e485c33 doc: git-checkout: deduplicate --detach explanation
 5:  b641874627 ! 5:  9c0119e70d doc: git-checkout: clarify restoring files section
     @@ Metadata
       ## Commit message ##
          doc: git-checkout: clarify restoring files section
      
     -    - Use the term "Restore" to mirror `git restore`
     +    - Split up the forms `git checkout file.txt` and
     +      `git checkout main file.txt` to match what's given in the SYNOPSIS
     +    - Remove `-f` from the SYNOPSIS for the second form, since according to
     +      this man page it is not relevant in that context
          - Many Git users do not know what a "tree-ish" is. Clarify by using an
            example of each case, and by saying "commit or tree" in the text
            instead of "<tree-ish>"
     @@ Commit message
            file's contents" where appropriate, since Git often uses "stage" as a
            verb to mean the same thing as "add to the index" and it's a more
            familiar term.
     +    - Use "Discard unstaged changes" instead of "checking out paths from
     +      the index" where relevant
      
          Signed-off-by: Julia Evans <julia@jvns.ca>
      
       ## Documentation/git-checkout.adoc ##
     -@@ Documentation/git-checkout.adoc: Omitting _<branch>_ detaches `HEAD` at the tip of the current branch.
     - `git checkout [-f|--ours|--theirs|-m|--conflict=<style>] [<tree-ish>] [--] <pathspec>...`::
     - `git checkout [-f|--ours|--theirs|-m|--conflict=<style>] [<tree-ish>] --pathspec-from-file=<file> [--pathspec-file-nul]`::
     +@@ Documentation/git-checkout.adoc: git checkout [-q] [-f] [-m] [<branch>]
     + git checkout [-q] [-f] [-m] --detach [<branch>]
     + git checkout [-q] [-f] [-m] [--detach] <commit>
     + git checkout [-q] [-f] [-m] [[-b|-B|--orphan] <new-branch>] [<start-point>]
     +-git checkout [-f] <tree-ish> [--] <pathspec>...
     +-git checkout [-f] <tree-ish> --pathspec-from-file=<file> [--pathspec-file-nul]
     ++git checkout <tree-ish> [--] <pathspec>...
     ++git checkout <tree-ish> --pathspec-from-file=<file> [--pathspec-file-nul]
     + git checkout [-f|--ours|--theirs|-m|--conflict=<style>] [--] <pathspec>...
     + git checkout [-f|--ours|--theirs|-m|--conflict=<style>] --pathspec-from-file=<file> [--pathspec-file-nul]
     + git checkout (-p|--patch) [<tree-ish>] [--] [<pathspec>...]
     +@@ Documentation/git-checkout.adoc: that is, the branch will not be created or modified unless
     + +
     + Omitting _<branch>_ detaches `HEAD` at the tip of the current branch.
     + 
     +-`git checkout [-f|--ours|--theirs|-m|--conflict=<style>] [<tree-ish>] [--] <pathspec>...`::
     +-`git checkout [-f|--ours|--theirs|-m|--conflict=<style>] [<tree-ish>] --pathspec-from-file=<file> [--pathspec-file-nul]`::
     ++`git checkout <tree-ish> [--] <pathspec>...`::
     ++`git checkout <tree-ish> --pathspec-from-file=<file> [--pathspec-file-nul]`::
       
      -	Overwrite the contents of the files that match the pathspec.
      -	When the _<tree-ish>_ (most often a commit) is not given,
      -	overwrite working tree with the contents in the index.
      -	When the _<tree-ish>_ is given, overwrite both the index and
      -	the working tree with the contents at the _<tree-ish>_.
     -+	Restore another version of the file(s) that match the pathspec.
     ++	Replace the specified files and/or directories with the version from
     ++	the given commit or tree.
       +
      -The index may contain unmerged entries because of a previous failed merge.
      -By default, if you try to check out such an entry from the index, the
      -checkout operation will fail and nothing will be checked out.
      -Using `-f` will ignore these unmerged entries.  The contents from a
     -+If you specify a commit or tree to restore from (for example `git
     -+checkout main file.txt`), this will restore the version of the file(s)
     -+from that commit or tree. This overwrites the file in the working
     +-specific side of the merge can be checked out of the index by
     +-using `--ours` or `--theirs`.  With `-m`, changes made to the working tree
     +-file can be discarded to re-create the original conflicted merge result.
     ++For example, `git checkout main file.txt` will restore the version
     ++of `file.txt` from `main`. This overwrites the file in the working
      +directory and stages the file's contents.
     + 
     ++`git checkout [-f|--ours|--theirs|-m|--conflict=<style>] <pathspec>...`::
     ++`git checkout [-f|--ours|--theirs|-m|--conflict=<style>] --pathspec-from-file=<file> [--pathspec-file-nul]`::
     ++
     ++	Replace the specified files and/or directories with the latest
     ++	committed or staged version.
     +++
     ++This overwrites the file(s) you specify with either the staged version
     ++or the version from the current commit if there is no staged version.
     ++For example, if you've been editing `file.txt` and you want to discard
     ++your changes to it, you can run `git checkout file.txt` to replace it
     ++with the latest committed version.
      ++
     -+If you do not specify where to restore from (for example `git checkout
     -+file.txt`), this will replace the file(s) with the version from the index.
     -+If you check out a file with an unresolved merge
     -+conflict, the checkout operation will fail and no changes will be made.
     -+Using `-f` will ignore the merge conflict.  The contents from a
     - specific side of the merge can be checked out of the index by
     - using `--ours` or `--theirs`.  With `-m`, changes made to the working tree
     - file can be discarded to re-create the original conflicted merge result.
     --
     ++This will fail if the file has a merge conflict and you haven't yet run
     ++`git add file.txt` (or something equivalent) to mark it as resolved.
     ++You can use `-f` to ignore the unmerged files instead of failing, use
     ++`--ours` or `--theirs` to replace them with the version from a specific
     ++side of the merge, or use `-m` to replace them with the original
     ++conflicted merge result.
       `git checkout (-p|--patch) [<tree-ish>] [--] [<pathspec>...]`::
     - 	This is similar to the previous mode, but lets you use the
     +-	This is similar to the previous mode, but lets you use the
     ++	This is similar to the previous two modes, but lets you use the
       	interactive interface to show the "diff" output and choose which
     + 	hunks to use in the result.  See below for the description of
     + 	`--patch` option.

-- 
gitgitgadget
