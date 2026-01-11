Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1C11E7660
	for <git@vger.kernel.org>; Sun, 11 Jan 2026 20:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768164233; cv=none; b=oA8l5jsnAQGePJZ5TU+85oqsQezKYOJhy3zPTf0Ne0tLwJEcFIZrNeuSn0TOKQCb3RVPZBv8IVAUu1juuw4LZMGGCgEgbt1PbMtaPgP5ZTttGFnBpm/7DcQe12YYSQe3eWO6yEw/qMI2LlyeT1Dkr7dALueE1/TRjXqwasIQ+AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768164233; c=relaxed/simple;
	bh=9agVDvjTlsYqw2jvYaRzPIXDxqUI+2Qj3FhMwc5dJtg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O4AXVjqQDeRdDxkXfDBuzcqv+qHvu0JZkpBZU7ckfunBdIdR7/XGTtIsh8uVj+qliYOJX/qddLM4Dm0Skw4ypDE94V5UexDwbcpM6kJQHfl3f/v7JhGBCY+i9j6oexvFpb93Nfnp3M1EKynsnvAH0FW43LAmTGd5CnQGPHT5lvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=michael.lyo.nz; spf=pass smtp.mailfrom=michael.lyo.nz; dkim=pass (2048-bit key) header.d=michael.lyo.nz header.i=@michael.lyo.nz header.b=JYAxQ7dt; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=michael.lyo.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=michael.lyo.nz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=michael.lyo.nz header.i=@michael.lyo.nz header.b="JYAxQ7dt"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4dq6t5261Rz9sxG;
	Sun, 11 Jan 2026 21:43:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=michael.lyo.nz;
	s=MBO0001; t=1768164221;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1dRUwmnXn72UveRDQr5bOJVQQUcIPt/bt/R35iDen+A=;
	b=JYAxQ7dtRXX1PCuB+SRWip8FqT6OV4E6PIRDxxo8/VnhXs6k1d+oSpMNBQ3Tgp19CD79SM
	Uir5DRLc2GWnUfKMY8peetUfR7RYpVzYLjaEpBTJd2SOxUGEXgJHxzMeARLj/iSE3ETXU6
	9y7cCgdGjch/Y5hHqa+Sc/0EO/viXVqZISWyLeggd6vFYEPkT8D/CW3jBqxME0F0VgpO6w
	GLH3OtVXmhHfIvVGs7Eu7O3ioie0u/QUtRsTsnyi+3DwZ3a3uKDuj3lndTa4SrFbIn09Yd
	vH0Wh800I8cQdUkGudM31OA4bcHumZtYTHrGj20Tvmkyb82vdUY6oBcpsgT4Fg==
From: Michael Lyons <git@michael.lyo.nz>
To: git@vger.kernel.org
Cc: Michael Lyons <git@michael.lyo.nz>
Subject: [PATCH 1/1] doc: git-bisect: convert to new doc format
Date: Sun, 11 Jan 2026 15:42:48 -0500
Message-ID: <20260111204316.836446-2-git@michael.lyo.nz>
In-Reply-To: <20260111204316.836446-1-git@michael.lyo.nz>
References: <20260111204316.836446-1-git@michael.lyo.nz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

- Change placeholders to glossary terms
- Refer to placeholders in prose
- Delimit runnable commands and CLI args with backticks
- Link internal heading

Signed-off-by: Michael Lyons <git@michael.lyo.nz>
---
 Documentation/git-bisect.adoc | 67 ++++++++++++++++++-----------------
 1 file changed, 34 insertions(+), 33 deletions(-)

diff --git a/Documentation/git-bisect.adoc b/Documentation/git-bisect.adoc
index b0078dda0e..65fec9fd29 100644
--- a/Documentation/git-bisect.adoc
+++ b/Documentation/git-bisect.adoc
@@ -8,20 +8,20 @@ git-bisect - Use binary search to find the commit that introduced a bug
 
 SYNOPSIS
 --------
-[verse]
-'git bisect' start [--term-(bad|new)=<term-new> --term-(good|old)=<term-old>]
-		   [--no-checkout] [--first-parent] [<bad> [<good>...]] [--] [<pathspec>...]
-'git bisect' (bad|new|<term-new>) [<rev>]
-'git bisect' (good|old|<term-old>) [<rev>...]
-'git bisect' terms [--term-(good|old) | --term-(bad|new)]
-'git bisect' skip [(<rev>|<range>)...]
-'git bisect' next
-'git bisect' reset [<commit>]
-'git bisect' (visualize|view)
-'git bisect' replay <logfile>
-'git bisect' log
-'git bisect' run <cmd> [<arg>...]
-'git bisect' help
+[synopsis]
+git bisect start [--term-(bad|new)=<term-new> --term-(good|old)=<term-old>]
+		 [--no-checkout] [--first-parent] [<bad> [<good>...]] [--] [<pathspec>...]
+git bisect (bad|new|<term-new>) [<commit>]
+git bisect (good|old|<term-old>) [<commit>...]
+git bisect terms [--term-(good|old) | --term-(bad|new)]
+git bisect skip [(<commit>|<range>)...]
+git bisect next
+git bisect reset [<commit>]
+git bisect (visualize|view)
+git bisect replay <logfile>
+git bisect log
+git bisect run <cmd> [<arg>...]
+git bisect help
 
 DESCRIPTION
 -----------
@@ -38,8 +38,8 @@ In fact, `git bisect` can be used to find the commit that changed
 *any* property of your project; e.g., the commit that fixed a bug, or
 the commit that caused a benchmark's performance to improve. To
 support this more general usage, the terms "old" and "new" can be used
-in place of "good" and "bad", or you can choose your own terms. See
-section "Alternate terms" below for more information.
+in place of "good" and "bad", or you can choose your own terms. See the
+<<alternate-terms,Alternate terms>> section below for more information.
 
 Basic bisect commands: start, bad, good
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
@@ -116,6 +116,7 @@ bad revision, while `git bisect reset HEAD` will leave you on the
 current bisection commit and avoid switching commits at all.
 
 
+[[alternate-terms]]
 Alternate terms
 ~~~~~~~~~~~~~~~
 
@@ -144,13 +145,13 @@ bisect start` without commits as argument and then run the following
 commands to add the commits:
 
 ------------------------------------------------
-git bisect old [<rev>]
+git bisect old [<commit>]
 ------------------------------------------------
 
 to indicate that a commit was before the sought change, or
 
 ------------------------------------------------
-git bisect new [<rev>...]
+git bisect new [<commit>...]
 ------------------------------------------------
 
 to indicate that it was after.
@@ -208,7 +209,7 @@ Git detects a graphical environment through various environment variables:
 `MSYSTEM`, which is set under Msys2 and Git for Windows.
 `SECURITYSESSIONID`, which may be set on macOS in interactive desktop sessions.
 
-If none of these environment variables is set, 'git log' is used instead.
+If none of these environment variables is set, `git log` is used instead.
 You can also give command-line options such as `-p` and `--stat`.
 
 ------------
@@ -308,8 +309,8 @@ by checking out a different revision.
 Cutting down bisection by giving more parameters to bisect start
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-You can further cut down the number of trials, if you know what part of
-the tree is involved in the problem you are tracking down, by specifying
+If you know what part of the tree is involved in the problem you are
+tracking down, you can further cut down the number of trials by specifying
 pathspec parameters when issuing the `bisect start` command:
 
 ------------
@@ -333,12 +334,12 @@ If you have a script that can tell if the current source code is good
 or bad, you can bisect by issuing the command:
 
 ------------
-$ git bisect run my_script arguments
+$ git bisect run <my_script> <arguments>
 ------------
 
-Note that the script (`my_script` in the above example) should exit
-with code 0 if the current source code is good/old, and exit with a
-code between 1 and 127 (inclusive), except 125, if the current source
+Note that the script (`<my_script> <arguments>` in the above example)
+should exit with code 0 if the current source code is good/old, and exit
+with a code between 1 and 127 (inclusive), except 125, if the current source
 code is bad/new.
 
 Any other exit code will abort the bisect process. It should be noted
@@ -355,22 +356,22 @@ details do not matter, as they are normal errors in the script, as far as
 `bisect run` is concerned).
 
 You may often find that during a bisect session you want to have
-temporary modifications (e.g. s/#define DEBUG 0/#define DEBUG 1/ in a
+temporary modifications (e.g. `s/#define DEBUG 0/#define DEBUG 1/` in a
 header file, or "revision that does not have this commit needs this
 patch applied to work around another problem this bisection is not
 interested in") applied to the revision being tested.
 
-To cope with such a situation, after the inner 'git bisect' finds the
+To cope with such a situation, after the inner `git bisect` finds the
 next revision to test, the script can apply the patch
 before compiling, run the real test, and afterwards decide if the
 revision (possibly with the needed patch) passed the test and then
-rewind the tree to the pristine state.  Finally the script should exit
+rewind the tree to the pristine state.  Finally, the script should exit
 with the status of the real test to let the `git bisect run` command loop
 determine the eventual outcome of the bisect session.
 
 OPTIONS
 -------
---no-checkout::
+`--no-checkout`::
 +
 Do not checkout the new working tree at each iteration of the bisection
 process. Instead just update the reference named `BISECT_HEAD` to make
@@ -381,7 +382,7 @@ does not require a checked out tree.
 +
 If the repository is bare, `--no-checkout` is assumed.
 
---first-parent::
+`--first-parent`::
 +
 Follow only the first parent commit upon seeing a merge commit.
 +
@@ -491,9 +492,9 @@ $ git bisect run sh -c '
 $ git bisect reset                   # quit the bisect session
 ------------
 +
-In this case, when 'git bisect run' finishes, bisect/bad will refer to a commit that
-has at least one parent whose reachable graph is fully traversable in the sense
-required by 'git pack objects'.
+In this case, when `git bisect run` finishes, bisect/bad will refer to a
+commit that has at least one parent whose reachable graph is fully
+traversable in the sense required by `git pack objects`.
 
 * Look for a fix instead of a regression in the code
 +
-- 
2.47.3

