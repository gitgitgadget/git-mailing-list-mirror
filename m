Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793720010;
	b=sOA9HZLMarqiwXdB0ssUHR7wsrjmuZ68WKolakDeMHjxGns6LvczCQsrvepaSHCOOGBN
	 GhcZomsuLvAmyTp7R6wTqA71X6Obb8rHSj/g/AqVVjngGlCuzNB3b3sMwYoGb5l9ASIUH
	 R5TP009OlRlpPOfcKa3L3GTemKJMlkUnYvh/71OLapA75U4kNe4rBf5Va2azVbtX87lOU
	 +n8DBZan5opUGHLF8gfRsVl+6y0v6RL8HRR0ma0oAMuPvLxGOD+fGHduvnqdMWtyVlg+O
	 Ie5NwaCRqwA88bYbJ+LkH1l5LkxC78tFrVKzQ8zZznLLVMT7CmbfhGy682iJFhiiWlg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793720010;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:From:Date:
	 Subject:Fcc:Content-Type:Content-Transfer-Encoding:MIME-Version:To:
	 Cc;
	bh=ILDUuZrI5gBNxfR8MBss660k4yfLi0z2rstxPPFI9PA=;
	b=0bn2NilzGzacyIZRLgs31tgNKksU4UxPy4/SWrezwiWZGW1yAPiP0zjRyiS9KwKUQ59q
	 /H1SsTXRJdIiLR3nDpEzgu7Q487vq8/cV8vno/aJOWKYQ4m2TnFHAztJyTH5RUj6/NZLs
	 IMe9cbM4foM9bcZRM/DbKyPkF75lach/9sSZw2UMB2syoxoDD7RKtg6SF703ZWo/Me1Td
	 LO3pzmSXaGhY/Ukuxq7VbiVZgrAWVWtQtaOcLduOoLhr83vGGclXOiOHJFLVn9x1zHriF
	 eyjZ4qrOWJhqjl/niTYPsWbgQa+RjbDIcSmBC+XDZTH96ay8Fvma0zZWc1dbI3PHCCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AQVWicFV;
	arc=none smtp.remote-ip=209.85.160.49
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9203B606D80C
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 15:33:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9203B606D80C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AQVWicFV
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-48e94879f02so1251300fac.0
        for <git@vger.kernel.org>; Tue, 03 Nov 2026 07:33:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793720008; x=1794324808; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ILDUuZrI5gBNxfR8MBss660k4yfLi0z2rstxPPFI9PA=;
        b=AQVWicFVj6YO+cbuqNsD13kvGIsEVemwKFZRSY8mVIX0PIbikj595Wh21tG7HSAolt
         VG113ttnXKQEMlbScJPHq7hJoGwMhVZh9VMD+58bXeFyp9BBPyjUqbHlpjRzE9h6dB6j
         ae6rroyNJNoL85lWPHPsV7HI2GDeMIsQhtlrxTEFqjc3+IjQc2aNCO1qBrNdTaHnDG9H
         HFE3lqMM+TI68JOIQyvyvB1PFFyc6w4J9a2dKIibP9f+jbfiaHBCvr01nuD9X1XeiwVG
         o85DEgFsDH7t4App05Pq3zEtot0Db04iT8XbsZHhNklbWN7++Wh4g7u39nVE7IXURAqQ
         vLHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793720008; x=1794324808;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ILDUuZrI5gBNxfR8MBss660k4yfLi0z2rstxPPFI9PA=;
        b=ZzPLnsHvTuHSvATq2s2ZHbaZ/XI91Vgi0V0sluXU6Js+oRw8hxoWS0IEnz/S8drj3X
         Y6SsjG2Nmyjs0WhC9wBK4TDy/xhO/KF1pHGAxij+wb+5EBtkW5ruqrKUuoCIJg8sdGAU
         8tVX07h+SJGSflcFaSruT8C3uwn3MEmjDo+T/b1PBacz+EkcUbhKZT3MUcqX9G68xxf2
         RiqU2VuRlxHQmxCA5AeXioNMaH8bRESyhwgBql5bf0oiJnb46NshzdkpCiqhNIMCXZvZ
         a+jBCsfM4eXqxoJWMuFBNBs3lnHWyw2TVzRr5Zhl2osB8nf1Y7wfJXc1MgbZm+RFO8Nc
         3ykQ==
X-Gm-Message-State: APuU4Z8cSWxc7gzVoVj6wwYiIgZeXY4D5NdebLKTHvVzq34O3hK+Fk0w
	O0Ugzj6MIYEzQxKOKYgJRVCjQJPtEbyBxSwzdejsMO0mSZdjq/VNpEu3vKpElrUB
X-Gm-Gg: AYBFou03NcNAxybPj8tA6zht+tJ+dCEpBrgH8lRUzA4dFB2HtZZJdJEkx1fn5Ngw0B+
	CWaFH+Xo097wli33xEsuvwtZavCyMxoah/a5SZTXhqq1unsR+rKINgx3cKTSHutnOGfHSxGOwyI
	NdZ27hB9ufJszY3MHGnL8Q0B79Kz3u3gbmSe+zclIzRxpTKd3Q6rGT7iLhaIrjLmz4b0/kw0W2A
	EiXK5CmjRN6AiVe0FOpD7orhrMEtuLLWelRfq6mDfh08QSnppC3ft3fLucphYXaGWNUewL6J0Fs
	OK3MKXj+3gZbpscLtG7EF4aUWW+zdlYJ7CeGOR1kEOI08UTAl8CGppDi1zzdfgIm4T4MYLs40JY
	AXjxq9Mp73MovHiikcFYGPw3mgWo7InYPJAfZTefdvq1nldUz8JcszZVC6TXQlT9zMiCry7Yv4I
	KTtwsE5KoWCuXs5K97kqWNDAOnga8T0HzjCbsjAApQu/HCi2nYe63Ju9B7am8OO6dOTOWnuUGVD
	APZxBGaYiLsfIhgwqy/qKyj1zMUaye+4XIPMO8as+yP6dkThJ1fLg8Ypsmvp0pD9VpbaAhJhPqa
	ARMGStJTiiUj/gNxprQ5BYv9hCFlT9ID8qs=
X-Received: by 2002:a05:6871:b0a:b0:48f:e0f6:c45d with SMTP id 586e51a60fabf-4a90771acf8mr7705897fac.43.1793720008304;
        Tue, 03 Nov 2026 07:33:28 -0800 (PST)
Received: from [127.0.0.1] ([172.212.205.181])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a921a80881sm9897096fac.17.2026.11.03.07.33.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 07:33:27 -0800 (PST)
Message-Id: <pull.2293.git.1793720007182.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 03 Nov 2026 15:33:27 +0000
Subject: [PATCH] doc: git-diff: rewrite EXAMPLES section
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
incantations.

Add a note about the EXAMPLES section in the DESCRIPTION since otherwise
readers are unlikely to know it's there. `git diff` is a command where
it's more important than usual to have examples because the command has
so many different forms.

Some design choices:

- Use `--merge-base` instead of `...` since several users said they
  find .. vs ... confusing. It's much more obvious what --merge-base
  does.
- Use a table format instead of the footnote-style formatting since the
  footnote style is quite difficult to follow. It's easier to follow
  if the description is right next to the command it's describing.
- Link the options in the examples to make them faster to look up
- Use sub-subsection headings for the different parts to make
  them more visually distinct and easy to scan.

Co-Authored-By: Marie Claire LeBlanc Flanagan <hello@marieflanagan.com>
Signed-off-by: Marie Claire LeBlanc Flanagan <hello@marieflanagan.com>
Signed-off-by: Julia Evans <julia@jvns.ca>
---
    doc: git-diff: rewrite EXAMPLES section
    
    A couple of self-review comments:
    
     * May want to add back the git diff AUTO_MERGE, nobody mentioned it but
       it's often nice to include 1 cool little-known example to try to
       promote it.
     * I'm not 100% sure about the table format, it does make it more
       compact which is really nice and makes it much more readable, but on
       an 80-character terminal there is some wrapping. One potential con is
       that it means we can't include as many details about what the command
       does. From my point of view that's a good thing because in a "cheat
       sheet" format it's very important to be concise, and people can
       always read the rest of the man page for the details.
    
    Here's what one of the tables looks like on an 80-character terminal
    with a little bit of wrapping.
    
       ┌─────────────────────────┬───────────────────────┐
       │Ignore all whitespace    │ git diff              │
       │changes                  │ --ignore-all-space    │
       ├─────────────────────────┼───────────────────────┤
       │Show which individual    │ git diff --word-diff  │
       │words changed instead of │                       │
       │the whole line           │                       │
       └─────────────────────────┴───────────────────────┘
    

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2293%2Fjvns%2Fdiff-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2293/jvns/diff-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2293

 Documentation/diff-options.adoc |   5 ++
 Documentation/git-diff.adoc     | 149 ++++++++++++++++++--------------
 2 files changed, 87 insertions(+), 67 deletions(-)

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
index 272331afba..8d9de30f64 100644
--- a/Documentation/git-diff.adoc
+++ b/Documentation/git-diff.adoc
@@ -23,6 +23,9 @@ between the index and a tree, changes between two trees, changes resulting
 from a merge, changes between two blob objects, or changes between two
 files on disk.
 
+The <<EXAMPLES,EXAMPLES>> section has examples of the most common ways
+to diff.
+
 `git diff [<options>] [--] [<path>...]`::
 
 	This form is to view the changes you made relative to
@@ -160,78 +163,90 @@ section "3-Way Merge" for detailed information.
 
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
+
+`git diff` will show the files from the "before" column as deleted and
+from the "after" column as added.
+
+[cols="1,1"]
+|===
+|Show unstaged changes
+|`git diff`
+
+|Show staged changes
+|`git diff --staged`
+
+|Show all changes since the latest commit
+|`git diff HEAD`
+|===
+
+Diff a specific file/directory
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+You can usually put a filename or directory at the end to restrict the
+diff to that file/directory. You don't always need to put a `--`, but it
+makes it unambiguous.
+
+[cols="1,1"]
+|===
+|Show how `file.txt` has changed since `main`
+|`git diff main -- file.txt`
+
+|Show unstaged changes for `file.txt`
+|`git diff -- file.txt`
+
+|Show unstaged changes in `dir/`
+|`git diff -- ./dir`
+|===
+
+Diff branches or commits
+~~~~~~~~~~~~~~~~~~~~~~~~
+
+[cols="1,1"]
+|===
+|Show changes on the `topic` branch since it branched off `main`
+|`git diff --merge-base main topic`
+
+|Show changes between the `topic` branch and the `main` branch
+|`git diff main topic`
+
+|Show changes between commit `ff11cc` and `HEAD`
+|`git diff ff11cc HEAD`
+|===
+
+Options to summarize the output
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+[cols="1,1"]
+|===
+|Show how many lines in each file were changed
+|`git diff` <<stat,`--stat`>>
+
+|Only show names of changed files
+|`git diff`  <<name_only,`--name-only`>>
+
+|Only show filenames and whether they were modified/deleted/added
+|`git diff` <<name_status,`--name-status`>>
+|===
+
+Options to display the diff in another way
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+[cols="1,1"]
+|===
+|Ignore all whitespace changes
+|`git diff` <<ignore_all_space,`--ignore-all-space`>>
+
+|Show which individual words changed instead of the whole line
+|`git diff` <<word_diff,`--word-diff`>>
+|===
 
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
 
 CONFIGURATION
 -------------

base-commit: 7e34d8174dcda3435d1404c9a30bef46afe6c13e
-- 
gitgitgadget
