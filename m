Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548D9340DB8
	for <git@vger.kernel.org>; Mon, 25 May 2026 10:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779704914; cv=none; b=Y0xsjuIQ7BIrRX5RsquIdjRFazzU7HUsVO7w3yJHUZRTEdRYQ5H8Ej4ITwmq+neKwGlBDBIilyiKfY53EnAF+IuIn6ijQIpZsIviyI3LwzgYGCoWo9MARSlV3aUN2y75ySS5JAguypbWq58NqskA3ioj5o1hG63wyAep5adJynY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779704914; c=relaxed/simple;
	bh=uLuhUTB32JlFevvvfIHT0MLRkg1k+2AqHXXNkLOLIS4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=d2xorvHQzN0aRwlUUx77BGqBIb2ia9NE0009P8lvx7TefAEkucm0yu4rqci3SuQ4enLvbWTPbfjA8mGfkq6lAOy8bXoaaFS1AkBckpSfkLLrLvmVTiTDw4v3GRVTP3In0KpiWIy2GXsx3b0Hkq3b8PkwIqrO+nWlZLlToRWls7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ynvr1x4W; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ynvr1x4W"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-9144163319fso965506485a.2
        for <git@vger.kernel.org>; Mon, 25 May 2026 03:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779704911; x=1780309711; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/zD1QtwMKAXWD+iSDC06V+/ZPpy/IdrbuAbiisUAnec=;
        b=Ynvr1x4Wn12HtwERFc+gKQXE4UhM7+FMu3PhRxfPCgQFOp7MIm8a+VTaND7wvdEP6m
         jkJMBSYVkEumiuqo0yBr+KjzwoPHymEQuAHpMdQNPepbNDpti1LBTliuKbqc7UsS68S6
         PnvK7S+x2E5VqvCYt0fu1Y8evj1KxWh0DsFoG6qU60GtUiHiYCl99hiLc88lUdKuR9jB
         oH8M8AYTkM7b4KMwEl/En1sRnsmQOM7QO3DNbBwBwEg6QPNh1rnxp85QwcEqlyS14WMt
         GCYqNOm8/5TdoAfBW5u220BZovXpQfwTpwSVfGE3ngK1R5W+u2/v0SY3VA9AvDGxLviP
         aOAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779704911; x=1780309711;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/zD1QtwMKAXWD+iSDC06V+/ZPpy/IdrbuAbiisUAnec=;
        b=BPXSzZnRIwvmkia8zLD97Gf0XvVTnI+AzO9fL76mgVJAW8JNn5GCiCprc30wiAHrFr
         gFfvwNWJpeE3jgLdZPGl6Ud7QNIxrWuEgpnn4Kq94AsPXtUG/pBUt1mVmUjmNYmilk3T
         emR4mzktj0IH+2F9+V5CJaXuqY71qsQ7z8cMzNTTqssOviw6BIlvyyX7t70BNgIo5ZlV
         jhhlh+lD2cpXctzb605tnQ0f/vMfH/rg0d0uPJoc9CywXhSs720a6npli1dRBCFml4qO
         LFDt7Y8aLEgcWWa9HPyhgWjWUEiipgp0TyeOIp7/O7B4F1xumgTnPHkYIhjWC8cPYqOj
         KVUQ==
X-Gm-Message-State: AOJu0Yy2tOaHSZV9RkdDXi5wfwHQ4R+C8yGcLOHA8LnVGergUdEd+FG6
	WhWbOhRaXne+iGKY7UQtKnFgjqmTwXqhuDcV949G+xcystLomb/N4iLOUgcUPQ==
X-Gm-Gg: Acq92OFPPGLOK2drfFeU+vl1a003KI/ljzbQTB2cH8dozidKB2Gub9Un32/5R9kj49v
	7K5AhQin4PXgfzL6Z5yut5BrdJEqIo1frbMQprOPhdTEB9SrOqGNFW3RXCsa8EZsD913wGmRIt5
	buVtVEFvGKYZZKc4qWokK2nSjHygVlqsxnWnrnW5slzAt/GXqetOMCuYtcXWmajJsoAp9FLIQwi
	C6KWtBkokHPBWeOgwzwmGp7h6OfmW0jLFpdXzHlyYle0PHcnU6aHpVnFvTBy5bLVyXjutPuPEov
	aNL6Br0fz+A0uxQvBo1gP0JwG54MFVRURJMZ3Ebj8iLrJ/P6+TywXKpdB2QGUWNiZRoDuAlRMcn
	UKp5WTQj0WPNqN2L1/ybB0AEf16+JHOhdDCzGwbRJDw7+g0WWwqWPcx6TDWI5mW6aik/Fly/fjO
	lsT7A3Yw91T2O/gclOc2RxKr51kw==
X-Received: by 2002:a05:620a:254f:b0:8f7:879d:ccdf with SMTP id af79cd13be357-914b49a7269mr1931589485a.50.1779704911155;
        Mon, 25 May 2026 03:28:31 -0700 (PDT)
Received: from [127.0.0.1] ([130.131.15.84])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-914bb8cd26fsm989824385a.10.2026.05.25.03.28.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 03:28:30 -0700 (PDT)
Message-Id: <7284281fe043c931781f0bf4964d1dac73e3ff92.1779704908.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2117.v2.git.1779704908.gitgitgadget@gmail.com>
References: <pull.2117.git.1779049615.gitgitgadget@gmail.com>
	<pull.2117.v2.git.1779704908.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 25 May 2026 10:28:22 +0000
Subject: [PATCH v2 1/6] doc: convert git-bisect to synopsis style
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

Convert Documentation/git-bisect.adoc to the modern synopsis style.

- Replace [verse] with [synopsis] in the SYNOPSIS block
- Remove single quotes around command names in the synopsis
- Use backticks for inline commands, options, refs, and special values
- Apply [synopsis] attribute to in-body command-form code blocks
- Format OPTIONS entries with backtick-quoted terms and direct
- Add synopsis-style formatting to listing blocks
- Format man page references as `command`(N)

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 Documentation/asciidoc.conf.in |  6 +++
 Documentation/git-bisect.adoc  | 90 ++++++++++++++++------------------
 2 files changed, 48 insertions(+), 48 deletions(-)

diff --git a/Documentation/asciidoc.conf.in b/Documentation/asciidoc.conf.in
index 31b883a72c..93c63b284a 100644
--- a/Documentation/asciidoc.conf.in
+++ b/Documentation/asciidoc.conf.in
@@ -84,6 +84,9 @@ ifdef::doctype-manpage[]
 [blockdef-open]
 synopsis-style=template="verseparagraph",filter="sed 's!&#8230;\\(\\]\\|$\\)!<phrase>\\0</phrase>!g;s!\\([\\[ |()]\\|^\\|\\]\\|&gt;\\)\\([-=a-zA-Z0-9:+@,\\/_^\\$.\\\\\\*]\\+\\|&#8230;\\)!\\1<literal>\\2</literal>!g;s!&lt;[-a-zA-Z0-9.]\\+&gt;!<emphasis>\\0</emphasis>!g'"
 
+[blockdef-listing]
+synopsis-style=template="verseparagraph",filter="sed 's!&#8230;\\(\\]\\|$\\)!<phrase>\\0</phrase>!g;s!\\([\\[ |()]\\|^\\|\\]\\|&gt;\\)\\([-=a-zA-Z0-9:+@,\\/_^\\$.\\\\\\*]\\+\\|&#8230;\\)!\\1<literal>\\2</literal>!g;s!&lt;[-a-zA-Z0-9.]\\+&gt;!<emphasis>\\0</emphasis>!g'"
+
 [paradef-default]
 synopsis-style=template="verseparagraph",filter="sed 's!&#8230;\\(\\]\\|$\\)!<phrase>\\0</phrase>!g;s!\\([\\[ |()]\\|^\\|\\]\\|&gt;\\)\\([-=a-zA-Z0-9:+@,\\/_^\\$.\\\\\\*]\\+\\|&#8230;\\)!\\1<literal>\\2</literal>!g;s!&lt;[-a-zA-Z0-9.]\\+&gt;!<emphasis>\\0</emphasis>!g'"
 endif::doctype-manpage[]
@@ -93,6 +96,9 @@ ifdef::backend-xhtml11[]
 [blockdef-open]
 synopsis-style=template="verseparagraph",filter="sed 's!&#8230;\\(\\]\\|$\\)!<span>\\0</span>!g;s!\\([\\[ |()]\\|^\\|\\]\\|&gt;\\)\\([-=a-zA-Z0-9:+@,\\/_^\\$.\\\\\\*]\\+\\|&#8230;\\)!\\1<code>\\2</code>!g;s!&lt;[-a-zA-Z0-9.]\\+&gt;!<em>\\0</em>!g'"
 
+[blockdef-listing]
+synopsis-style=template="verseparagraph",filter="sed 's!&#8230;\\(\\]\\|$\\)!<span>\\0</span>!g;s!\\([\\[ |()]\\|^\\|\\]\\|&gt;\\)\\([-=a-zA-Z0-9:+@,\\/_^\\$.\\\\\\*]\\+\\|&#8230;\\)!\\1<code>\\2</code>!g;s!&lt;[-a-zA-Z0-9.]\\+&gt;!<em>\\0</em>!g'"
+
 [paradef-default]
 synopsis-style=template="verseparagraph",filter="sed 's!&#8230;\\(\\]\\|$\\)!<span>\\0</span>!g;s!\\([\\[ |()]\\|^\\|\\]\\|&gt;\\)\\([-=a-zA-Z0-9:+@,\\/_^\\$.\\\\\\*]\\+\\|&#8230;\\)!\\1<code>\\2</code>!g;s!&lt;[-a-zA-Z0-9.]\\+&gt;!<em>\\0</em>!g'"
 endif::backend-xhtml11[]
diff --git a/Documentation/git-bisect.adoc b/Documentation/git-bisect.adoc
index b0078dda0e..4765d3b969 100644
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
+git bisect (bad|new|<term-new>) [<rev>]
+git bisect (good|old|<term-old>) [<rev>...]
+git bisect terms [--term-(good|old) | --term-(bad|new)]
+git bisect skip [(<rev>|<range>)...]
+git bisect next
+git bisect reset [<commit>]
+git bisect (visualize|view)
+git bisect replay <logfile>
+git bisect log
+git bisect run <cmd> [<arg>...]
+git bisect help
 
 DESCRIPTION
 -----------
@@ -94,7 +94,7 @@ Bisect reset
 ~~~~~~~~~~~~
 
 After a bisect session, to clean up the bisection state and return to
-the original HEAD, issue the following command:
+the original `HEAD`, issue the following command:
 
 ------------------------------------------------
 $ git bisect reset
@@ -107,9 +107,8 @@ that, as it cleans up the old bisection state.)
 With an optional argument, you can return to a different commit
 instead:
 
-------------------------------------------------
+[synopsis]
 $ git bisect reset <commit>
-------------------------------------------------
 
 For example, `git bisect reset bisect/bad` will check out the first
 bad revision, while `git bisect reset HEAD` will leave you on the
@@ -143,23 +142,20 @@ To use "old" and "new" instead of "good" and bad, you must run `git
 bisect start` without commits as argument and then run the following
 commands to add the commits:
 
-------------------------------------------------
+[synopsis]
 git bisect old [<rev>]
-------------------------------------------------
 
 to indicate that a commit was before the sought change, or
 
-------------------------------------------------
+[synopsis]
 git bisect new [<rev>...]
-------------------------------------------------
 
 to indicate that it was after.
 
 To get a reminder of the currently used terms, use
 
-------------------------------------------------
+[synopsis]
 git bisect terms
-------------------------------------------------
 
 You can get just the old term with `git bisect terms --term-old`
 or `git bisect terms --term-good`; `git bisect terms --term-new`
@@ -171,9 +167,8 @@ If you would like to use your own terms instead of "bad"/"good" or
 subcommands like `reset`, `start`, ...) by starting the
 bisection using
 
-------------------------------------------------
+[synopsis]
 git bisect start --term-old <term-old> --term-new <term-new>
-------------------------------------------------
 
 For example, if you are looking for a commit that introduced a
 performance regression, you might use
@@ -194,7 +189,7 @@ of `git bisect good` and `git bisect bad` to mark commits.
 Bisect visualize/view
 ~~~~~~~~~~~~~~~~~~~~~
 
-To see the currently remaining suspects in 'gitk', issue the following
+To see the currently remaining suspects in `gitk`, issue the following
 command during the bisection process (the subcommand `view` can be used
 as an alternative to `visualize`):
 
@@ -203,12 +198,13 @@ $ git bisect visualize
 ------------
 
 Git detects a graphical environment through various environment variables:
-`DISPLAY`, which is set in X Window System environments on Unix systems.
-`SESSIONNAME`, which is set under Cygwin in interactive desktop sessions.
-`MSYSTEM`, which is set under Msys2 and Git for Windows.
-`SECURITYSESSIONID`, which may be set on macOS in interactive desktop sessions.
 
-If none of these environment variables is set, 'git log' is used instead.
+`DISPLAY`:: which is set in X Window System environments on Unix systems.
+`SESSIONNAME`:: which is set under Cygwin in interactive desktop sessions.
+`MSYSTEM`:: which is set under Msys2 and Git for Windows.
+`SECURITYSESSIONID`:: which may be set on macOS in interactive desktop sessions.
+
+If none of these environment variables is set, `git log` is used instead.
 You can also give command-line options such as `-p` and `--stat`.
 
 ------------
@@ -342,8 +338,8 @@ code between 1 and 127 (inclusive), except 125, if the current source
 code is bad/new.
 
 Any other exit code will abort the bisect process. It should be noted
-that a program that terminates via `exit(-1)` leaves $? = 255, (see the
-exit(3) manual page), as the value is chopped with `& 0377`.
+that a program that terminates via `exit(-1)` leaves `$?` = 255, (see the
+`exit`(3) manual page), as the value is chopped with `& 0377`.
 
 The special exit code 125 should be used when the current source code
 cannot be tested. If the script exits with this code, the current
@@ -355,12 +351,12 @@ details do not matter, as they are normal errors in the script, as far as
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
@@ -370,20 +366,18 @@ determine the eventual outcome of the bisect session.
 
 OPTIONS
 -------
---no-checkout::
-+
-Do not checkout the new working tree at each iteration of the bisection
-process. Instead just update the reference named `BISECT_HEAD` to make
-it point to the commit that should be tested.
+`--no-checkout`::
+	Do not checkout the new working tree at each iteration of the bisection
+	process. Instead just update the reference named `BISECT_HEAD` to make
+	it point to the commit that should be tested.
 +
 This option may be useful when the test you would perform in each step
 does not require a checked out tree.
 +
 If the repository is bare, `--no-checkout` is assumed.
 
---first-parent::
-+
-Follow only the first parent commit upon seeing a merge commit.
+`--first-parent`::
+	Follow only the first parent commit upon seeing a merge commit.
 +
 In detecting regressions introduced through the merging of a branch, the merge
 commit will be identified as introduction of the bug and its ancestors will be
@@ -395,7 +389,7 @@ branch contained broken or non-buildable commits, but the merge itself was OK.
 EXAMPLES
 --------
 
-* Automatically bisect a broken build between v1.2 and HEAD:
+* Automatically bisect a broken build between v1.2 and `HEAD`:
 +
 ------------
 $ git bisect start HEAD v1.2 --      # HEAD is bad, v1.2 is good
@@ -403,7 +397,7 @@ $ git bisect run make                # "make" builds the app
 $ git bisect reset                   # quit the bisect session
 ------------
 
-* Automatically bisect a test failure between origin and HEAD:
+* Automatically bisect a test failure between origin and `HEAD`:
 +
 ------------
 $ git bisect start HEAD origin --    # HEAD is bad, origin is good
@@ -430,7 +424,7 @@ and `exit 1` otherwise.
 +
 It is safer if both `test.sh` and `check_test_case.sh` are
 outside the repository to prevent interactions between the bisect,
-make and test processes and the scripts.
+`make` and test processes and the scripts.
 
 * Automatically bisect with temporary modifications (hot-fix):
 +
@@ -491,9 +485,9 @@ $ git bisect run sh -c '
 $ git bisect reset                   # quit the bisect session
 ------------
 +
-In this case, when 'git bisect run' finishes, bisect/bad will refer to a commit that
+In this case, when `git bisect run` finishes, `bisect/bad` will refer to a commit that
 has at least one parent whose reachable graph is fully traversable in the sense
-required by 'git pack objects'.
+required by `git pack-objects`.
 
 * Look for a fix instead of a regression in the code
 +
-- 
gitgitgadget

