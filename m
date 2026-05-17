Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3025730C17F
	for <git@vger.kernel.org>; Sun, 17 May 2026 20:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779049621; cv=none; b=i3vOdG5cdJsNvJCzGEc6JkxlBmTXLeTJJMz0P4wGOa7bXevXjBj5fmAXAOmk8OlIatUqCsvw+0tXaenT0g6+g6EBbfjEZCNe5udW//tY4z+X5YdCDhUzAaSsmvrFuI6RRnKGWLkXnb92pGqotn8Pj3Ghrt0zXNNzEKd9l9S9DIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779049621; c=relaxed/simple;
	bh=9Efmh01Q6cP3f+GNr/DjvttWkQm1lf0fZ7c86VEJwXk=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=gSnmI0OlOmnoP6+TUPWr+23IB1N6SV1hmTemEYrJaTsS3zHZ9ksZ+Z6SJQPrB67Tcmd4wPAg2vgtMg+olq7rtUgNdcxtNuIYIshyzbKLOUh3zMRgf5vfNj5MUJbyHu8XhFShtqPgpG/Fu5hKF/0djt8zpNuGTfxLI2Wloe5PuoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ekvq4qxw; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ekvq4qxw"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-50e63771eb0so20817841cf.3
        for <git@vger.kernel.org>; Sun, 17 May 2026 13:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779049619; x=1779654419; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/F8Opadg/J2t/9GOUR/noY5VpPDXOmlrIJUHP31CUM4=;
        b=Ekvq4qxwGuYwb5T2jJSz8KRkFsOAhsIry+k3kLlmYFmR88IFTToe3eDYlOparBfkGE
         E5xdREAlRSBSg0VwA7ujQ/TJYR+KSNPq4wM7bnjC6XdCPBiMmS5rzV4/LHKbltcG3Hq0
         xghz7FDcHG4+l5Ay3y13mk9djOn7Y/fq5kcZvZofZO5e8ViX4dF/jPRA+q1v0XVKNvc0
         oOJMOX9/3ra0zZAdBkEFK4fbINUWhfzsijcplMvdNzcaFkYN6HVsVghPHEjAuaex9cFN
         rIYTOkNe3y5QSVz9xVL7Khm1QfcZ/he9zWiw1pGsMB3H9DXzUazKH/8oW5NzFhYhMxeN
         qEIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779049619; x=1779654419;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/F8Opadg/J2t/9GOUR/noY5VpPDXOmlrIJUHP31CUM4=;
        b=Vjs3ZlaST9JYa0xA10/V90ATmOIcOmJcXlwuNiCKo84CzruHXz7v7PKlCeFVL4aLg2
         j+Uy8DBjLaYRhAX2t2bWPD3EroCssLr7yPHipWqT24l3TN48/LxqK+6X0vBTSOLNOFyh
         GLxz5HJLM9mJRRMO1CGfVOSZuhwuaMQ+fx6momyFg6rLtyIRpWD/Ukn8c/nzWLq2euXq
         fSirKwacFm5DyWtLq2DH61dC/1fcaGsOY/F3bQzcENwMyjrDSm1JwihkDRknhkpq2mCW
         sha4Kzzdiw6rrodyDZxvK6j2ifBoWmFlSIqdX7hxyxy3i3qOfY03Ahvq6LD9A0EIROUK
         fKrA==
X-Gm-Message-State: AOJu0YzxYF0KoVgY9LHlyQG3XJqGnHj38CcWJJBsKXS5l+G0N78XtV4Q
	KRKPzk63w/IRF6KcI7brYoBxncvIBJXDv+5Y/7BlUWGFTBJHLywRlAxv2V33zQ==
X-Gm-Gg: Acq92OGJ0l9+X/WlqjFidg7M0OT6lPPpIMZW8VVVdld0PocblfRtGhT+8zHGXHt40br
	sw645oJhBTzjgA13N64yeBXAz6iHVtA+M5XQvXj2i8n/79QKHIzbqLOP9vcSdI+5wsQPFTPiW52
	7hmQILWDYRDs+QOw9QKKzK3ZDXXghP2m8FoMWsTQSzu6GydJ+55gflRBvRsopOCikg2FKsnAQFk
	fnlLDF4qbNMV4HLPlt9OMZiBjF22AmnKO7+5zWT+GOkX1r0QxpVPEOqlik2dIGbpIy9b4lnpxxe
	4GlycnUcMDYzvXOBVmb7frFJrsHqosNmqp6fRgUbo62exBPPHdOjlyOl/GnHdtZffsLyU+tRmaD
	qzPNl2U5/X36rVCrAOr8HAQI90TrGInRO4bbGZsv1vr5f7geZmj6qU6nooz7dr1fH3qxeKDMWGQ
	p1mflxGbH4GREvBVj/HM1BgMBG7Rc=
X-Received: by 2002:a05:622a:1454:b0:516:4f8e:2ffc with SMTP id d75a77b69052e-51659fd9b78mr185757311cf.6.1779049619122;
        Sun, 17 May 2026 13:26:59 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.134.161])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ca3619e814sm31814246d6.39.2026.05.17.13.26.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 13:26:58 -0700 (PDT)
Message-Id: <dca7f192f1e5cdfb57682feace0a4b3a10204376.1779049615.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2117.git.1779049615.gitgitgadget@gmail.com>
References: <pull.2117.git.1779049615.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 17 May 2026 20:26:51 +0000
Subject: [PATCH 1/5] doc: convert git-bisect to synopsis style
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
 Documentation/git-bisect.adoc  | 80 ++++++++++++++++++----------------
 2 files changed, 48 insertions(+), 38 deletions(-)

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
index b0078dda0e..9a3b7b3cdb 100644
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
@@ -107,6 +107,7 @@ that, as it cleans up the old bisection state.)
 With an optional argument, you can return to a different commit
 instead:
 
+[synopsis]
 ------------------------------------------------
 $ git bisect reset <commit>
 ------------------------------------------------
@@ -143,12 +144,14 @@ To use "old" and "new" instead of "good" and bad, you must run `git
 bisect start` without commits as argument and then run the following
 commands to add the commits:
 
+[synopsis]
 ------------------------------------------------
 git bisect old [<rev>]
 ------------------------------------------------
 
 to indicate that a commit was before the sought change, or
 
+[synopsis]
 ------------------------------------------------
 git bisect new [<rev>...]
 ------------------------------------------------
@@ -157,6 +160,7 @@ to indicate that it was after.
 
 To get a reminder of the currently used terms, use
 
+[synopsis]
 ------------------------------------------------
 git bisect terms
 ------------------------------------------------
@@ -171,6 +175,7 @@ If you would like to use your own terms instead of "bad"/"good" or
 subcommands like `reset`, `start`, ...) by starting the
 bisection using
 
+[synopsis]
 ------------------------------------------------
 git bisect start --term-old <term-old> --term-new <term-new>
 ------------------------------------------------
@@ -194,7 +199,7 @@ of `git bisect good` and `git bisect bad` to mark commits.
 Bisect visualize/view
 ~~~~~~~~~~~~~~~~~~~~~
 
-To see the currently remaining suspects in 'gitk', issue the following
+To see the currently remaining suspects in `gitk`, issue the following
 command during the bisection process (the subcommand `view` can be used
 as an alternative to `visualize`):
 
@@ -203,12 +208,13 @@ $ git bisect visualize
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
@@ -342,8 +348,8 @@ code between 1 and 127 (inclusive), except 125, if the current source
 code is bad/new.
 
 Any other exit code will abort the bisect process. It should be noted
-that a program that terminates via `exit(-1)` leaves $? = 255, (see the
-exit(3) manual page), as the value is chopped with `& 0377`.
+that a program that terminates via `exit(-1)` leaves `$?` = 255, (see the
+`exit`(3) manual page), as the value is chopped with `& 0377`.
 
 The special exit code 125 should be used when the current source code
 cannot be tested. If the script exits with this code, the current
@@ -355,12 +361,12 @@ details do not matter, as they are normal errors in the script, as far as
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
@@ -370,20 +376,18 @@ determine the eventual outcome of the bisect session.
 
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
@@ -395,7 +399,7 @@ branch contained broken or non-buildable commits, but the merge itself was OK.
 EXAMPLES
 --------
 
-* Automatically bisect a broken build between v1.2 and HEAD:
+* Automatically bisect a broken build between v1.2 and `HEAD`:
 +
 ------------
 $ git bisect start HEAD v1.2 --      # HEAD is bad, v1.2 is good
@@ -403,7 +407,7 @@ $ git bisect run make                # "make" builds the app
 $ git bisect reset                   # quit the bisect session
 ------------
 
-* Automatically bisect a test failure between origin and HEAD:
+* Automatically bisect a test failure between origin and `HEAD`:
 +
 ------------
 $ git bisect start HEAD origin --    # HEAD is bad, origin is good
@@ -430,7 +434,7 @@ and `exit 1` otherwise.
 +
 It is safer if both `test.sh` and `check_test_case.sh` are
 outside the repository to prevent interactions between the bisect,
-make and test processes and the scripts.
+`make` and test processes and the scripts.
 
 * Automatically bisect with temporary modifications (hot-fix):
 +
@@ -491,9 +495,9 @@ $ git bisect run sh -c '
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

