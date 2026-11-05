Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793893222;
	b=D1YKychKKkfhk8CN/mnPPEnR5pXuj1l8L3LBLYw9K6LpaLLm7eEydH3fspu66z9Sxfts
	 lTtVCZ62DzJsuqu0AObrcU5pvmMUSqsgSBHIQkW8EZ8A+wn6Yh+a5bKybPoT60V5h+uGf
	 mm+pD4WrQk91Cien4seLOwHvQwhXb2oQ1Xt0Cccjj48NQT/OX/b+JECrBnNTyshHzU8M5
	 e/EqZtbKv0Cw9ct/CS2ToY95RZgDI3uzssO9hoD4S9eQqiVB3ULHXhXwker4ROymRyay4
	 j4XPtslJIPTJyMJW24a10S+DL0LmV6gPn8v6E6UnqBrQ5ZFvSqahlHiBz10XTJjYCQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793893222;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=+IDxlC7MHMTNL4Hbh5Odzmy4SzKYLACPRF64GHj/exo=;
	b=cvL0CCkUtrgXTXbTVbVuB1d489wvn8fiZT5AJPHEnvPTFGQOprBnXAL8FCDVbTCoNkHB
	 NBYsC/e9GpI6eehT+fiTFcHqk6aDSw+RJPCOt1hZ0TMMQsnsli0BbIXWu/ajozs7Vogth
	 Q+O9QN8BtoJkxU1wwg+7xof/QbvMusjqL/zxqMmI6ZH8fO+sPN4qKXmq4gcp51zMYaJYw
	 NfhTLAyb0kyAcLXHzFw51bQAt4O0X0seGGLZ+HP/he2L0vqSF7GI7OnDb8DulLDeYon0+
	 AlxfCoOsGp1mIavthD8ojUELJbD4dRhp9+sSi9KbqFf0E2Cz/pc6A2MiVEnzUzyl/Rw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ja14eWsa;
	arc=none smtp.remote-ip=209.85.219.44
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6FAB606A331
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 15:40:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C6FAB606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ja14eWsa
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-91ea5600c9cso560076d6.1
        for <git@vger.kernel.org>; Thu, 05 Nov 2026 07:40:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793893221; x=1794498021; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=+IDxlC7MHMTNL4Hbh5Odzmy4SzKYLACPRF64GHj/exo=;
        b=Ja14eWsa+IlCFbsH8CVoHBRn/Db2myFRD2mHq1SwbkXPKzwc8IAdVqSAM2OAblMYq+
         NhuA4HibLDuki7pLJSSzUIFD5TLcu3vN7qHI6xs9TLESnZvUxBjrC9r7CiZOicfybwXD
         rksTq5xOvUOgWS70Ox+XWawxmNiCBYb9Kr9ZTi+2VshJRwHyKKGgf+gJ+pJdvAVz1QC8
         6f9Q1MctTSGRZUnhlh+OBbLSzfFcK4LFK4YmcBpxmsOenKoHDS9Fq4Vp08w3l1oPq6az
         uRI2DY9SYkla6RE7vpnH7nYAeFG0NU/nl6mwEZPk4q9b3G+IkNlKm+UPt/yglgOv/szN
         PExA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793893221; x=1794498021;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+IDxlC7MHMTNL4Hbh5Odzmy4SzKYLACPRF64GHj/exo=;
        b=zTM1+Agjoeehi015oBD+JJBJlA2nlgZowsIW0qQN07tW1IWtPCVNzPngg0wJWIdKr5
         o/AsrDWGzip2Ru+q/6SMznnXcvuA5pG7nm173rjdC15dnM6ndDZ8wU4sJ30Ydou7KHfy
         NTAPL2AKjKsgE7VZ5woiyivHAQD+QJA7S3YuSDnDBWSijEbfxvS8EAxSLwcemzmaEG1o
         SBUULBIxO+y5xcGzYEnmWgO/Xbz7SqihjhPTslV0biFtLztjerTZCkc1kpQNqTdnrdu7
         m1Pwfo+fEHILR6UxyKPoV6x/1B3PiWylYXFL2hRMUk/kcbU8JeTGN3+xHEnrYAH2rG/N
         n0ww==
X-Gm-Message-State: APuU4Z8hgqLlc6m5bXV8J1f/iDbUpZuQPE+jFqeGFYS29GNAcrp56jGP
	3GMDG9YJxsF24E5HTjNJJTwLO7nhF1U4KGGyseXfbTEZaHje/+uxmatp+JNpG0HBMtY=
X-Gm-Gg: AYBFou3Q/lRfy6WPCh5f9cDV6UoylsKs7czhG8AZsUpVbZhmxbFuPVW98fm/VVsFU5j
	ZMGjlpMda5N838TZmgPp6hPer5EGsm9vzhSiM/PRT8XXnEuXjSccysYSYV9bC7Qv/hB35y02BBK
	m+2BLlhA0W8Y+QLtO18ePWse/A7QtZoJ1l4U/OhklC7s75qcZS9pg/D+vlWuQq7rdXrQ19NP/oC
	I96FOqtlmpi8mS2PaSTa+rMFytvaA9re0iw5yaiLV6mx1n1vLIjAFG3OEClSRUeTFDiaH/UxMuS
	6eV9339/jc/1vf9LnNg5polxpKJsQPhdVqqUcakbXNMHr8/K8Rro0eK9dM7cFfo3v1ZgqrSIm21
	6ogZvAB74kMVXd7ickTVyQ2FuAMI6iwHd1G6NM/37whHUes5Lq18jq0bxVaSSdjEb/26xIhajtB
	TtjC5R2NYGRVUajAY8moQTsh9h1CWUlU8VWWu1N+Cjlz9G38/4ZfYh+/JKv2B7+zfTv3OoCC5tp
	EI6HNjwtOKRmjzdp3Og8zrN64BZUZq3xNBdTwnvTTEPfH6+KljdD71HoBjlGguMPmXkBsEoFuH5
	N9Ti+BzJmqKFplhhRUuAHlu9GzKFEXoexbo=
X-Received: by 2002:a05:6214:d0e:b0:91e:9295:a94c with SMTP id 6a1803df08f44-91e94477561mr46423276d6.24.1793893220206;
        Thu, 05 Nov 2026 07:40:20 -0800 (PST)
Received: from [127.0.0.1] ([135.237.130.159])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91e9a5d0656sm16727206d6.16.2026.11.05.07.40.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 07:40:18 -0800 (PST)
Message-Id: <pull.2293.v2.git.1793893217889.gitgitgadget@gmail.com>
In-Reply-To: <pull.2293.git.1793720007182.gitgitgadget@gmail.com>
References: <pull.2293.git.1793720007182.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 05 Nov 2026 15:40:17 +0000
Subject: [PATCH v2] doc: git-diff: rewrite EXAMPLES section
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
    Julia Evans <julia@jvns.ca>,
    Julia Evans <julia@jvns.ca>

From: Julia Evans <julia@jvns.ca>

The top piece of feedback users always give about man pages is always
that they want better examples that are relevant to them.

The EXAMPLES section's structure has remained mostly unchanged since
2007, which was before we knew how people were going to use `git diff`.
Update it with ways of using `git diff` that are popular with Git
users, gathered by asking Mastodon users for their most commonly used
incantations. Keep the example that was added since 2007
(`git diff AUTO_MERGE`), rewording it to use the more familiar term
"merge conflict" instead of "textual conflict".

Add a note about the EXAMPLES section in the DESCRIPTION since otherwise
readers are unlikely to know it's there. `git diff` is a command where
it's more important than usual to have examples because the command has
so many different forms.

Some design choices:

- Mention both `git diff --staged` and `git diff --cached`, because
  "staged" is the term the Git user interface uses and several users
  said they find it easier to understand. Add an entry for --staged
  saying that it's a synonym. Like with `git switch`, and `git checkout`
  it's useful to leave the older version for folks who are used to using
  `git diff --cached` since we've seen that many people who are used to
  using a command don't see any value in changing how they use it.
- Use a definition list for the examples instead of the footnote style,
  so that the description and the example are right next to each other
  and it's easier to read.
- Use `--merge-base` instead of `...` since several users said they
  find .. vs ... confusing. It's much more obvious what --merge-base
  does.
- Link the options in the examples to make them faster to look up
- Use sub-subsection headings for the different parts to make
  them more visually distinct and easy to scan.

Co-Authored-By: Marie Claire LeBlanc Flanagan <hello@marieflanagan.com>
Signed-off-by: Marie Claire LeBlanc Flanagan <hello@marieflanagan.com>
Signed-off-by: Julia Evans <julia@jvns.ca>
---
    doc: git-diff: rewrite EXAMPLES section
    
    changes in v2:
    
     * Switch from tables to a definition list, to avoid wrapping but still
       staying relatively compact.
     * Mention git diff --cached alongside git diff --staged so folks can
       use whichever version they prefer, and update the commit message with
       some notes about that. It's an example of one of many situations in
       Git where what's best to recommend for new users and what's best for
       long-term users is not necessarily the same.
     * Put back AUTO_MERGE (thanks to Junio for pointing out that it was
       added much more recently than all the rest of the examples)

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2293%2Fjvns%2Fdiff-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2293/jvns/diff-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/2293

Range-diff vs v1:

 1:  46728e7b7a ! 1:  ec565ce334 doc: git-diff: rewrite EXAMPLES section
     @@ Commit message
          2007, which was before we knew how people were going to use `git diff`.
          Update it with ways of using `git diff` that are popular with Git
          users, gathered by asking Mastodon users for their most commonly used
     -    incantations.
     +    incantations. Keep the example that was added since 2007
     +    (`git diff AUTO_MERGE`), rewording it to use the more familiar term
     +    "merge conflict" instead of "textual conflict".
      
          Add a note about the EXAMPLES section in the DESCRIPTION since otherwise
          readers are unlikely to know it's there. `git diff` is a command where
     @@ Commit message
      
          Some design choices:
      
     +    - Mention both `git diff --staged` and `git diff --cached`, because
     +      "staged" is the term the Git user interface uses and several users
     +      said they find it easier to understand. Add an entry for --staged
     +      saying that it's a synonym. Like with `git switch`, and `git checkout`
     +      it's useful to leave the older version for folks who are used to using
     +      `git diff --cached` since we've seen that many people who are used to
     +      using a command don't see any value in changing how they use it.
     +    - Use a definition list for the examples instead of the footnote style,
     +      so that the description and the example are right next to each other
     +      and it's easier to read.
          - Use `--merge-base` instead of `...` since several users said they
            find .. vs ... confusing. It's much more obvious what --merge-base
            does.
     -    - Use a table format instead of the footnote-style formatting since the
     -      footnote style is quite difficult to follow. It's easier to follow
     -      if the description is right next to the command it's describing.
          - Link the options in the examples to make them faster to look up
          - Use sub-subsection headings for the different parts to make
            them more visually distinct and easy to scan.
     @@ Documentation/diff-options.adoc: endif::git-diff[]
       	`--word-diff-regex` below.  The _<mode>_ defaults to `plain`, and
      
       ## Documentation/git-diff.adoc ##
     +@@ Documentation/git-diff.adoc: SYNOPSIS
     + --------
     + [synopsis]
     + git diff [<options>] [<commit>] [--] [<path>...]
     +-git diff [<options>] --cached [--merge-base] [<commit>] [--] [<path>...]
     ++git diff [<options>] --staged [--merge-base] [<commit>] [--] [<path>...]
     + git diff [<options>] [--merge-base] <commit> [<commit>...] <commit> [--] [<path>...]
     + git diff [<options>] <commit>...<commit> [--] [<path>...]
     + git diff [<options>] <blob> <blob>
      @@ Documentation/git-diff.adoc: between the index and a tree, changes between two trees, changes resulting
       from a merge, changes between two blob objects, or changes between two
       files on disk.
     @@ Documentation/git-diff.adoc: between the index and a tree, changes between two t
       `git diff [<options>] [--] [<path>...]`::
       
       	This form is to view the changes you made relative to
     +@@ Documentation/git-diff.adoc: files on disk.
     + 	difference. All such pathspecs must be relative as they
     + 	apply to both sides of the diff.
     + 
     +-`git diff [<options>] --cached [--merge-base] [<commit>] [--] [<path>...]`::
     ++`git diff [<options>] --staged [--merge-base] [<commit>] [--] [<path>...]`::
     + 
     + 	This form is to view the changes you staged for the next
     + 	commit relative to the named _<commit>_.  Typically you
     +@@ Documentation/git-diff.adoc: files on disk.
     + 	do not give _<commit>_, it defaults to `HEAD`.
     + 	If `HEAD` does not exist (e.g. unborn branches) and
     + 	_<commit>_ is not given, it shows all staged changes.
     +-	`--staged` is a synonym of `--cached`.
     ++	`--cached` is a synonym of `--staged`.
     + +
     + If `--merge-base` is given, instead of using _<commit>_, use the merge base
     + of _<commit>_ and `HEAD`.  `git diff --cached --merge-base A` is equivalent to
     +-`git diff --cached $(git merge-base A HEAD)`.
     ++`git diff --staged $(git merge-base A HEAD)`.
     + 
     + `git diff [<options>] [--merge-base] <commit> [--] [<path>...]`::
     + 
      @@ Documentation/git-diff.adoc: section "3-Way Merge" for detailed information.
       
       include::diff-format.adoc[]
     @@ Documentation/git-diff.adoc: section "3-Way Merge" for detailed information.
      -    branch was started off it.
      +Diff uncommitted changes
      +~~~~~~~~~~~~~~~~~~~~~~~~
     + 
     +-Limiting the diff output::
     +-+
     +-------------
     +-$ git diff --diff-filter=MRC            <1>
     +-$ git diff --name-status                <2>
     +-$ git diff arch/i386 include/asm-i386   <3>
     +-------------
     +-+
     +-<1> Show only modification, rename, and copy, but not addition
     +-    or deletion.
     +-<2> Show only names and the nature of change, but not actual
     +-    diff output.
     +-<3> Limit diff output to named subtrees.
     ++Show unstaged changes::
     ++`git diff`
     + 
     +-Munging the diff output::
     +-+
     +-------------
     +-$ git diff --find-copies-harder -B -C  <1>
     +-$ git diff -R                          <2>
     +-------------
     +-+
     +-<1> Spend extra cycles to find renames, copies and complete
     +-    rewrites (very expensive).
     +-<2> Output diff in reverse.
     ++Show staged changes::
     ++`git diff --staged` or `git diff --cached`
      +
     -+`git diff` will show the files from the "before" column as deleted and
     -+from the "after" column as added.
     -+
     -+[cols="1,1"]
     -+|===
     -+|Show unstaged changes
     -+|`git diff`
     -+
     -+|Show staged changes
     -+|`git diff --staged`
     ++Show all changes since the latest commit::
     ++`git diff HEAD`
      +
     -+|Show all changes since the latest commit
     -+|`git diff HEAD`
     -+|===
     ++Show changes made to resolve a merge conflict::
     ++`git diff AUTO_MERGE`
      +
      +Diff a specific file/directory
      +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     @@ Documentation/git-diff.adoc: section "3-Way Merge" for detailed information.
      +diff to that file/directory. You don't always need to put a `--`, but it
      +makes it unambiguous.
      +
     -+[cols="1,1"]
     -+|===
     -+|Show how `file.txt` has changed since `main`
     -+|`git diff main -- file.txt`
     ++Show how `file.txt` has changed since `main`::
     ++`git diff main -- file.txt`
      +
     -+|Show unstaged changes for `file.txt`
     -+|`git diff -- file.txt`
     ++Show unstaged changes for `file.txt`::
     ++`git diff -- file.txt`
      +
     -+|Show unstaged changes in `dir/`
     -+|`git diff -- ./dir`
     -+|===
     ++Show unstaged changes in `dir/`::
     ++`git diff -- ./dir`
      +
      +Diff branches or commits
      +~~~~~~~~~~~~~~~~~~~~~~~~
      +
     -+[cols="1,1"]
     -+|===
     -+|Show changes on the `topic` branch since it branched off `main`
     -+|`git diff --merge-base main topic`
     ++Show changes on the `topic` branch since it branched off `main`::
     ++`git diff --merge-base main topic`
      +
     -+|Show changes between the `topic` branch and the `main` branch
     -+|`git diff main topic`
     ++Show changes between the `topic` branch and the `main` branch::
     ++`git diff main topic`
      +
     -+|Show changes between commit `ff11cc` and `HEAD`
     -+|`git diff ff11cc HEAD`
     -+|===
     ++Show changes between commit `ff11cc` and `HEAD`::
     ++`git diff ff11cc HEAD`
      +
      +Options to summarize the output
      +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      +
     -+[cols="1,1"]
     -+|===
     -+|Show how many lines in each file were changed
     -+|`git diff` <<stat,`--stat`>>
     ++Show how many lines in each file were changed::
     ++`git diff` <<stat,`--stat`>>
      +
     -+|Only show names of changed files
     -+|`git diff`  <<name_only,`--name-only`>>
     ++Only show names of changed files::
     ++`git diff` <<name_only,`--name-only`>>
      +
     -+|Only show filenames and whether they were modified/deleted/added
     -+|`git diff` <<name_status,`--name-status`>>
     -+|===
     ++Only show filenames and whether they were modified/deleted/added::
     ++`git diff` <<name_status,`--name-status`>>
      +
      +Options to display the diff in another way
      +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      +
     -+[cols="1,1"]
     -+|===
     -+|Ignore all whitespace changes
     -+|`git diff` <<ignore_all_space,`--ignore-all-space`>>
     ++Ignore all whitespace changes::
     ++`git diff` <<ignore_all_space,`--ignore-all-space`>>
      +
     -+|Show which individual words changed instead of the whole line
     -+|`git diff` <<word_diff,`--word-diff`>>
     -+|===
     - 
     --Limiting the diff output::
     --+
     --------------
     --$ git diff --diff-filter=MRC            <1>
     --$ git diff --name-status                <2>
     --$ git diff arch/i386 include/asm-i386   <3>
     --------------
     --+
     --<1> Show only modification, rename, and copy, but not addition
     --    or deletion.
     --<2> Show only names and the nature of change, but not actual
     --    diff output.
     --<3> Limit diff output to named subtrees.
     - 
     --Munging the diff output::
     --+
     --------------
     --$ git diff --find-copies-harder -B -C  <1>
     --$ git diff -R                          <2>
     --------------
     --+
     --<1> Spend extra cycles to find renames, copies and complete
     --    rewrites (very expensive).
     --<2> Output diff in reverse.
     ++Show which individual words changed instead of the whole line::
     ++`git diff` <<word_diff,`--word-diff`>>
       
       CONFIGURATION
       -------------


 Documentation/diff-options.adoc |   5 ++
 Documentation/git-diff.adoc     | 140 ++++++++++++++++----------------
 2 files changed, 74 insertions(+), 71 deletions(-)

diff --git a/Documentation/diff-options.adoc b/Documentation/diff-options.adoc
index e605d28678..2dc54fa00e 100644
--- a/Documentation/diff-options.adoc
+++ b/Documentation/diff-options.adoc
@@ -201,6 +201,7 @@ diff" algorithm internally.
 
 include::diff-algorithm-option.adoc[]
 
+[[stat]]
 `--stat[=<width>[,<name-width>[,<count>]]]`::
 	Generate a diffstat. By default, as much space as necessary
 	will be used for the filename part, and the rest for the graph
@@ -318,12 +319,14 @@ Without this option, pathnames with "unusual" characters are quoted as
 explained for the configuration variable `core.quotePath` (see
 linkgit:git-config[1]).
 
+[[name_only]]
 `--name-only`::
 	Show only the name of each changed file in the post-image tree.
 	The file names are often encoded in UTF-8.
 	For more information see the discussion about encoding in the linkgit:git-log[1]
 	manual page.
 
+[[name_status]]
 `--name-status`::
 	Show only the name(s) and status of each changed file. See the description
 	of the `--diff-filter` option on what the status letters mean.
@@ -417,6 +420,7 @@ endif::git-diff[]
 	Ignore changes in amount of whitespace.  This ignores whitespace
 	at line end, and considers all other sequences of one or
 	more whitespace characters to be equivalent.
+[[ignore_all_space]]
 `ignore-all-space`::
 	Ignore whitespace when comparing lines. This ignores differences
 	even if one line has whitespace where the other line has none.
@@ -432,6 +436,7 @@ endif::git-diff[]
 	used to override configuration settings. It is the same as
 	`--color-moved-ws=no`.
 
+[[word_diff]]
 `--word-diff[=<mode>]`::
 	By default, words are delimited by whitespace; see
 	`--word-diff-regex` below.  The _<mode>_ defaults to `plain`, and
diff --git a/Documentation/git-diff.adoc b/Documentation/git-diff.adoc
index 272331afba..f15e56633e 100644
--- a/Documentation/git-diff.adoc
+++ b/Documentation/git-diff.adoc
@@ -10,7 +10,7 @@ SYNOPSIS
 --------
 [synopsis]
 git diff [<options>] [<commit>] [--] [<path>...]
-git diff [<options>] --cached [--merge-base] [<commit>] [--] [<path>...]
+git diff [<options>] --staged [--merge-base] [<commit>] [--] [<path>...]
 git diff [<options>] [--merge-base] <commit> [<commit>...] <commit> [--] [<path>...]
 git diff [<options>] <commit>...<commit> [--] [<path>...]
 git diff [<options>] <blob> <blob>
@@ -23,6 +23,9 @@ between the index and a tree, changes between two trees, changes resulting
 from a merge, changes between two blob objects, or changes between two
 files on disk.
 
+The <<EXAMPLES,EXAMPLES>> section has examples of the most common ways
+to diff.
+
 `git diff [<options>] [--] [<path>...]`::
 
 	This form is to view the changes you made relative to
@@ -44,7 +47,7 @@ files on disk.
 	difference. All such pathspecs must be relative as they
 	apply to both sides of the diff.
 
-`git diff [<options>] --cached [--merge-base] [<commit>] [--] [<path>...]`::
+`git diff [<options>] --staged [--merge-base] [<commit>] [--] [<path>...]`::
 
 	This form is to view the changes you staged for the next
 	commit relative to the named _<commit>_.  Typically you
@@ -52,11 +55,11 @@ files on disk.
 	do not give _<commit>_, it defaults to `HEAD`.
 	If `HEAD` does not exist (e.g. unborn branches) and
 	_<commit>_ is not given, it shows all staged changes.
-	`--staged` is a synonym of `--cached`.
+	`--cached` is a synonym of `--staged`.
 +
 If `--merge-base` is given, instead of using _<commit>_, use the merge base
 of _<commit>_ and `HEAD`.  `git diff --cached --merge-base A` is equivalent to
-`git diff --cached $(git merge-base A HEAD)`.
+`git diff --staged $(git merge-base A HEAD)`.
 
 `git diff [<options>] [--merge-base] <commit> [--] [<path>...]`::
 
@@ -160,78 +163,73 @@ section "3-Way Merge" for detailed information.
 
 include::diff-format.adoc[]
 
+[[EXAMPLES]]
 EXAMPLES
 --------
 
-Various ways to check your working tree::
-+
-------------
-$ git diff            <1>
-$ git diff --cached   <2>
-$ git diff HEAD       <3>
-$ git diff AUTO_MERGE <4>
-------------
-+
-<1> Changes in the working tree not yet staged for the next commit.
-<2> Changes between the index and your last commit; what you
-    would be committing if you run `git commit` without `-a` option.
-<3> Changes in the working tree since your last commit; what you
-    would be committing if you run `git commit -a`
-<4> Changes in the working tree you've made to resolve textual
-    conflicts so far.
-
-Comparing with arbitrary commits::
-+
-------------
-$ git diff test            <1>
-$ git diff HEAD -- ./test  <2>
-$ git diff HEAD^ HEAD      <3>
-------------
-+
-<1> Instead of using the tip of the current branch, compare with the
-    tip of "test" branch.
-<2> Instead of comparing with the tip of "test" branch, compare with
-    the tip of the current branch, but limit the comparison to the
-    file "test".
-<3> Compare the version before the last commit and the last commit.
-
-Comparing branches::
-+
-------------
-$ git diff topic master    <1>
-$ git diff topic..master   <2>
-$ git diff topic...master  <3>
-------------
-+
-<1> Changes between the tips of the topic and the master branches.
-<2> Same as above.
-<3> Changes that occurred on the master branch since when the topic
-    branch was started off it.
+Diff uncommitted changes
+~~~~~~~~~~~~~~~~~~~~~~~~
 
-Limiting the diff output::
-+
-------------
-$ git diff --diff-filter=MRC            <1>
-$ git diff --name-status                <2>
-$ git diff arch/i386 include/asm-i386   <3>
-------------
-+
-<1> Show only modification, rename, and copy, but not addition
-    or deletion.
-<2> Show only names and the nature of change, but not actual
-    diff output.
-<3> Limit diff output to named subtrees.
+Show unstaged changes::
+`git diff`
 
-Munging the diff output::
-+
-------------
-$ git diff --find-copies-harder -B -C  <1>
-$ git diff -R                          <2>
-------------
-+
-<1> Spend extra cycles to find renames, copies and complete
-    rewrites (very expensive).
-<2> Output diff in reverse.
+Show staged changes::
+`git diff --staged` or `git diff --cached`
+
+Show all changes since the latest commit::
+`git diff HEAD`
+
+Show changes made to resolve a merge conflict::
+`git diff AUTO_MERGE`
+
+Diff a specific file/directory
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+You can usually put a filename or directory at the end to restrict the
+diff to that file/directory. You don't always need to put a `--`, but it
+makes it unambiguous.
+
+Show how `file.txt` has changed since `main`::
+`git diff main -- file.txt`
+
+Show unstaged changes for `file.txt`::
+`git diff -- file.txt`
+
+Show unstaged changes in `dir/`::
+`git diff -- ./dir`
+
+Diff branches or commits
+~~~~~~~~~~~~~~~~~~~~~~~~
+
+Show changes on the `topic` branch since it branched off `main`::
+`git diff --merge-base main topic`
+
+Show changes between the `topic` branch and the `main` branch::
+`git diff main topic`
+
+Show changes between commit `ff11cc` and `HEAD`::
+`git diff ff11cc HEAD`
+
+Options to summarize the output
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Show how many lines in each file were changed::
+`git diff` <<stat,`--stat`>>
+
+Only show names of changed files::
+`git diff` <<name_only,`--name-only`>>
+
+Only show filenames and whether they were modified/deleted/added::
+`git diff` <<name_status,`--name-status`>>
+
+Options to display the diff in another way
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Ignore all whitespace changes::
+`git diff` <<ignore_all_space,`--ignore-all-space`>>
+
+Show which individual words changed instead of the whole line::
+`git diff` <<word_diff,`--word-diff`>>
 
 CONFIGURATION
 -------------

base-commit: 0ffa3e35c7c82ab8d0de226149fb03b3f7674d05
-- 
gitgitgadget
