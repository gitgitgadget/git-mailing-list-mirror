From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 3/3] git-log.txt,rev-list-options.txt: put option blocks in proper order
Date: Tue,  8 Mar 2011 09:31:26 +0100
Message-ID: <f34ebc6211ead3fa6698ff9b7a92903723715a28.1299572814.git.git@drmicha.warpmail.net>
References: <4D75E92C.1090506@drmicha.warpmail.net>
Cc: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 08 09:35:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PwsNw-0002Qp-0w
	for gcvg-git-2@lo.gmane.org; Tue, 08 Mar 2011 09:35:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756367Ab1CHIe7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Mar 2011 03:34:59 -0500
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:57409 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754570Ab1CHIe5 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Mar 2011 03:34:57 -0500
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 16E4C20AFF;
	Tue,  8 Mar 2011 03:34:57 -0500 (EST)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute3.internal (MEProxy); Tue, 08 Mar 2011 03:34:57 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references:in-reply-to:references; s=smtpout; bh=sFYPY+P+iY4Ex8dXWVDVfIvpP8A=; b=V2kWbEG5oEp4KNzt802QSwCNsUW/FtX4JHgLrPPPuxDJ61qnnDkeaQikSStbb3poXGTa+0Y6WrVe/yqfWmKglvtSdF1lrgRQfZCI5pXbWs04sQJqQiKdj/CYqDC1lDu3qzzqsGq+itvxHFKErLtuLnsSrGs4IG3VKCNCaAOwYxg=
X-Sasl-enc: /ThdcDy8SzrCyVw53LEfYlVtBFBRs1i8CpKXfWbreZap 1299573296
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 42BBE447216;
	Tue,  8 Mar 2011 03:34:56 -0500 (EST)
X-Mailer: git-send-email 1.7.4.1.299.g567d7.dirty
In-Reply-To: <4D75E92C.1090506@drmicha.warpmail.net>
In-Reply-To: <2862dfc9969beb42636ec44292d3509ddb215285.1299572814.git.git@drmicha.warpmail.net>
References: <2862dfc9969beb42636ec44292d3509ddb215285.1299572814.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168645>

which is the order in which they get applied:

commit limiting
commit ordering
commit formatting
diff options

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 Documentation/git-log.txt          |    4 +-
 Documentation/rev-list-options.txt |  310 ++++++++++++++++++------------------
 2 files changed, 157 insertions(+), 157 deletions(-)

diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index 48c1715..6ae57dc 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -77,12 +77,12 @@ Common diff options
 ~~~~~~~~~~~~~~~~~~~
 
 :git-log: 1
-include::diff-options.txt[]
-
 include::rev-list-options.txt[]
 
 include::pretty-formats.txt[]
 
+include::diff-options.txt[]
+
 include::diff-generate-patch.txt[]
 
 Examples
diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index adcafa0..f5a426b 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -1,158 +1,3 @@
-Commit Formatting
-~~~~~~~~~~~~~~~~~
-
-ifdef::git-rev-list[]
-Using these options, linkgit:git-rev-list[1] will act similar to the
-more specialized family of commit log tools: linkgit:git-log[1],
-linkgit:git-show[1], and linkgit:git-whatchanged[1]
-endif::git-rev-list[]
-
-include::pretty-options.txt[]
-
---relative-date::
-
-	Synonym for `--date=relative`.
-
---date=(relative|local|default|iso|rfc|short|raw)::
-
-	Only takes effect for dates shown in human-readable format, such
-	as when using "--pretty". `log.date` config variable sets a default
-	value for log command's --date option.
-+
-`--date=relative` shows dates relative to the current time,
-e.g. "2 hours ago".
-+
-`--date=local` shows timestamps in user's local timezone.
-+
-`--date=iso` (or `--date=iso8601`) shows timestamps in ISO 8601 format.
-+
-`--date=rfc` (or `--date=rfc2822`) shows timestamps in RFC 2822
-format, often found in E-mail messages.
-+
-`--date=short` shows only date but not time, in `YYYY-MM-DD` format.
-+
-`--date=raw` shows the date in the internal raw git format `%s %z` format.
-+
-`--date=default` shows timestamps in the original timezone
-(either committer's or author's).
-
-ifdef::git-rev-list[]
---header::
-
-	Print the contents of the commit in raw-format; each record is
-	separated with a NUL character.
-endif::git-rev-list[]
-
---parents::
-
-	Print also the parents of the commit (in the form "commit parent...").
-	Also enables parent rewriting, see 'History Simplification' below.
-
---children::
-
-	Print also the children of the commit (in the form "commit child...").
-	Also enables parent rewriting, see 'History Simplification' below.
-
-ifdef::git-rev-list[]
---timestamp::
-	Print the raw commit timestamp.
-endif::git-rev-list[]
-
---left-right::
-
-	Mark which side of a symmetric diff a commit is reachable from.
-	Commits from the left side are prefixed with `<` and those from
-	the right with `>`.  If combined with `--boundary`, those
-	commits are prefixed with `-`.
-+
-For example, if you have this topology:
-+
------------------------------------------------------------------------
-             y---b---b  branch B
-            / \ /
-           /   .
-          /   / \
-         o---x---a---a  branch A
------------------------------------------------------------------------
-+
-you would get an output like this:
-+
------------------------------------------------------------------------
-	$ git rev-list --left-right --boundary --pretty=oneline A...B
-
-	>bbbbbbb... 3rd on b
-	>bbbbbbb... 2nd on b
-	<aaaaaaa... 3rd on a
-	<aaaaaaa... 2nd on a
-	-yyyyyyy... 1st on b
-	-xxxxxxx... 1st on a
------------------------------------------------------------------------
-
---graph::
-
-	Draw a text-based graphical representation of the commit history
-	on the left hand side of the output.  This may cause extra lines
-	to be printed in between commits, in order for the graph history
-	to be drawn properly.
-+
-This enables parent rewriting, see 'History Simplification' below.
-+
-This implies the '--topo-order' option by default, but the
-'--date-order' option may also be specified.
-
-ifdef::git-rev-list[]
---count::
-	Print a number stating how many commits would have been
-	listed, and suppress all other output.  When used together
-	with '--left-right', instead print the counts for left and
-	right commits, separated by a tab.
-endif::git-rev-list[]
-
-
-ifndef::git-rev-list[]
-Diff Formatting
-~~~~~~~~~~~~~~~
-
-Below are listed options that control the formatting of diff output.
-Some of them are specific to linkgit:git-rev-list[1], however other diff
-options may be given. See linkgit:git-diff-files[1] for more options.
-
--c::
-
-	With this option, diff output for a merge commit
-	shows the differences from each of the parents to the merge result
-	simultaneously instead of showing pairwise diff between a parent
-	and the result one at a time. Furthermore, it lists only files
-	which were modified from all parents.
-
---cc::
-
-	This flag implies the '-c' options and further compresses the
-	patch output by omitting uninteresting hunks whose contents in
-	the parents have only two variants and the merge result picks
-	one of them without modification.
-
--m::
-
-	This flag makes the merge commits show the full diff like
-	regular commits; for each merge parent, a separate log entry
-	and diff is generated. An exception is that only diff against
-	the first parent is shown when '--first-parent' option is given;
-	in that case, the output represents the changes the merge
-	brought _into_ the then-current branch.
-
--r::
-
-	Show recursive diffs.
-
--t::
-
-	Show the tree objects in the diff output. This implies '-r'.
-
--s::
-	Suppress diff output.
-endif::git-rev-list[]
-
 Commit Limiting
 ~~~~~~~~~~~~~~~
 
@@ -762,3 +607,158 @@ These options are mostly targeted for packing of git repositories.
 --do-walk::
 
 	Overrides a previous --no-walk.
+
+Commit Formatting
+~~~~~~~~~~~~~~~~~
+
+ifdef::git-rev-list[]
+Using these options, linkgit:git-rev-list[1] will act similar to the
+more specialized family of commit log tools: linkgit:git-log[1],
+linkgit:git-show[1], and linkgit:git-whatchanged[1]
+endif::git-rev-list[]
+
+include::pretty-options.txt[]
+
+--relative-date::
+
+	Synonym for `--date=relative`.
+
+--date=(relative|local|default|iso|rfc|short|raw)::
+
+	Only takes effect for dates shown in human-readable format, such
+	as when using "--pretty". `log.date` config variable sets a default
+	value for log command's --date option.
++
+`--date=relative` shows dates relative to the current time,
+e.g. "2 hours ago".
++
+`--date=local` shows timestamps in user's local timezone.
++
+`--date=iso` (or `--date=iso8601`) shows timestamps in ISO 8601 format.
++
+`--date=rfc` (or `--date=rfc2822`) shows timestamps in RFC 2822
+format, often found in E-mail messages.
++
+`--date=short` shows only date but not time, in `YYYY-MM-DD` format.
++
+`--date=raw` shows the date in the internal raw git format `%s %z` format.
++
+`--date=default` shows timestamps in the original timezone
+(either committer's or author's).
+
+ifdef::git-rev-list[]
+--header::
+
+	Print the contents of the commit in raw-format; each record is
+	separated with a NUL character.
+endif::git-rev-list[]
+
+--parents::
+
+	Print also the parents of the commit (in the form "commit parent...").
+	Also enables parent rewriting, see 'History Simplification' below.
+
+--children::
+
+	Print also the children of the commit (in the form "commit child...").
+	Also enables parent rewriting, see 'History Simplification' below.
+
+ifdef::git-rev-list[]
+--timestamp::
+	Print the raw commit timestamp.
+endif::git-rev-list[]
+
+--left-right::
+
+	Mark which side of a symmetric diff a commit is reachable from.
+	Commits from the left side are prefixed with `<` and those from
+	the right with `>`.  If combined with `--boundary`, those
+	commits are prefixed with `-`.
++
+For example, if you have this topology:
++
+-----------------------------------------------------------------------
+             y---b---b  branch B
+            / \ /
+           /   .
+          /   / \
+         o---x---a---a  branch A
+-----------------------------------------------------------------------
++
+you would get an output like this:
++
+-----------------------------------------------------------------------
+	$ git rev-list --left-right --boundary --pretty=oneline A...B
+
+	>bbbbbbb... 3rd on b
+	>bbbbbbb... 2nd on b
+	<aaaaaaa... 3rd on a
+	<aaaaaaa... 2nd on a
+	-yyyyyyy... 1st on b
+	-xxxxxxx... 1st on a
+-----------------------------------------------------------------------
+
+--graph::
+
+	Draw a text-based graphical representation of the commit history
+	on the left hand side of the output.  This may cause extra lines
+	to be printed in between commits, in order for the graph history
+	to be drawn properly.
++
+This enables parent rewriting, see 'History Simplification' below.
++
+This implies the '--topo-order' option by default, but the
+'--date-order' option may also be specified.
+
+ifdef::git-rev-list[]
+--count::
+	Print a number stating how many commits would have been
+	listed, and suppress all other output.  When used together
+	with '--left-right', instead print the counts for left and
+	right commits, separated by a tab.
+endif::git-rev-list[]
+
+
+ifndef::git-rev-list[]
+Diff Formatting
+~~~~~~~~~~~~~~~
+
+Below are listed options that control the formatting of diff output.
+Some of them are specific to linkgit:git-rev-list[1], however other diff
+options may be given. See linkgit:git-diff-files[1] for more options.
+
+-c::
+
+	With this option, diff output for a merge commit
+	shows the differences from each of the parents to the merge result
+	simultaneously instead of showing pairwise diff between a parent
+	and the result one at a time. Furthermore, it lists only files
+	which were modified from all parents.
+
+--cc::
+
+	This flag implies the '-c' options and further compresses the
+	patch output by omitting uninteresting hunks whose contents in
+	the parents have only two variants and the merge result picks
+	one of them without modification.
+
+-m::
+
+	This flag makes the merge commits show the full diff like
+	regular commits; for each merge parent, a separate log entry
+	and diff is generated. An exception is that only diff against
+	the first parent is shown when '--first-parent' option is given;
+	in that case, the output represents the changes the merge
+	brought _into_ the then-current branch.
+
+-r::
+
+	Show recursive diffs.
+
+-t::
+
+	Show the tree objects in the diff output. This implies '-r'.
+
+-s::
+	Suppress diff output.
+endif::git-rev-list[]
-- 
1.7.4.1.299.g567d7.dirty
