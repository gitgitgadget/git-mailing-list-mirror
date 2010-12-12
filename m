From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] completion: Add PS1 configuration for submodules
Date: Sun, 12 Dec 2010 00:38:48 -0600
Message-ID: <20101212063848.GB17185@burratino>
References: <1291677763-55385-1-git-send-email-scott@appden.com>
 <AANLkTin8JstkjEWaCGZuqpEXZnLMyudFm24K7Y3iCgX6@mail.gmail.com>
 <0E479F18-B26A-4216-A71E-C65EAB41A74A@sb.org>
 <4CFEA249.907@web.de>
 <AANLkTinnH4pFaEf=e4YE64f7cwLRx2R_2o_-=JGua30b@mail.gmail.com>
 <20101207212949.GA25162@burratino>
 <AANLkTinjzvCDjCFrvujdFPRZKo2vK_9_8j3ybLNAfFmE@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jens Lehmann <Jens.Lehmann@web.de>, Kevin Ballard <kevin@sb.org>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	git@vger.kernel.org
To: Scott Kyle <scott@appden.com>
X-From: git-owner@vger.kernel.org Sun Dec 12 07:39:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PRfaK-0005Pb-CK
	for gcvg-git-2@lo.gmane.org; Sun, 12 Dec 2010 07:39:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750840Ab0LLGi7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Dec 2010 01:38:59 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:40754 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750871Ab0LLGi6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Dec 2010 01:38:58 -0500
Received: by yxt3 with SMTP id 3so2784110yxt.19
        for <git@vger.kernel.org>; Sat, 11 Dec 2010 22:38:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=UoFoqa/hehxEq2iIXGq49fnglamJwM5JUmQqyQvpf64=;
        b=JdoTsHsYqz9xuBGhhfkqoSZMIET72FIm9f3SNxNLBL8iBGx7WdDr1DAGjbYLtRHfM/
         s6lVFkZfRB+7fkT3utaoFtEwtrIhLWO4aQqsSZdXCLochgHxjOLok+eyJTB6M2mTEndp
         VtbqSw6bzJWZap7xwJEDh7+coYOSQPUzBXP3U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=UsCprvJ3ue6pGVP/CuS/KGeltReLIx0VlXtiqmDG+qudfh3sxLWcFFd+Eui73lU5w4
         N0ftt9pJ1A350Nz8JC80WgFw4UQTIoKn+zDXSyDhcotGD8IxtRKIMzBrtfMaCHkVybWX
         jOPLY9p3mqhl7i2NNNW2Q7XLtZu2vOBAvcLls=
Received: by 10.150.138.6 with SMTP id l6mr3941946ybd.352.1292135937349;
        Sat, 11 Dec 2010 22:38:57 -0800 (PST)
Received: from burratino (adsl-69-209-48-248.dsl.chcgil.ameritech.net [69.209.48.248])
        by mx.google.com with ESMTPS id u31sm2662185yba.21.2010.12.11.22.38.54
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 11 Dec 2010 22:38:55 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTinjzvCDjCFrvujdFPRZKo2vK_9_8j3ybLNAfFmE@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163474>

Scott Kyle wrote:
> On Tue, Dec 7, 2010 at 1:29 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
>> Scott Kyle wrote:

>>> If I set the "submodule.<name>.ignore" then diffing around inside my
>>> history will not show the changes to that particular submodule.
>>
>> Even if you set it to "dirty"?
>
> Setting it to "dirty" is far less disruptive, you're right, but that
> wouldn't do me much good since my submodules are often on different
> branches while developing.

Ah, I see now.  How about something like this?  Untested, just a
vague sketch to show the idea.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Documentation/config.txt       |    4 +++-
 Documentation/diff-options.txt |    7 +++++--
 Documentation/git-status.txt   |   14 ++------------
 Documentation/gitmodules.txt   |    4 +++-
 diff-lib.c                     |    3 ++-
 diff.h                         |    3 ++-
 submodule.c                    |    4 ++++
 7 files changed, 21 insertions(+), 18 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 0f85793..b93e92b 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1810,7 +1810,9 @@ submodule.<name>.update::
 submodule.<name>.ignore::
 	Defines under what circumstances "git status" and the diff family show
 	a submodule as modified. When set to "all", it will never be considered
-	modified, "dirty" will ignore all changes to the submodules work tree and
+	modified, "worktree" will ignore all changes in the work tree not
+	registered in the superproject index, "dirty" will ignore all changes
+	to the submodules work tree and
 	takes only differences between the HEAD of the submodule and the commit
 	recorded in the superproject into account. "untracked" will additionally
 	let submodules with modified tracked files in their work tree show up.
diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index f3e9538..93fe084 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -360,7 +360,8 @@ endif::git-format-patch[]
 
 --ignore-submodules[=<when>]::
 	Ignore changes to submodules in the diff generation. <when> can be
-	either "none", "untracked", "dirty" or "all", which is the default
+	either "none", "untracked", "dirty", "worktree", or "all", which is
+	the default.
 	Using "none" will consider the submodule modified when it either contains
 	untracked or modified files or its HEAD differs from the commit recorded
 	in the superproject and can be used to override any settings of the
@@ -369,7 +370,9 @@ endif::git-format-patch[]
 	contain untracked content (but they are still scanned for modified
 	content). Using "dirty" ignores all changes to the work tree of submodules,
 	only changes to the commits stored in the superproject are shown (this was
-	the behavior until 1.7.0). Using "all" hides all changes to submodules.
+	the behavior until 1.7.0).  Using "worktree" submodules in the worktree are
+	never considered dirty but diffs between old commits do not ignore
+	submodules.  Using "all" hides all changes to submodules.
 
 --src-prefix=<prefix>::
 	Show the given source prefix instead of "a/".
diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
index dae190a..8c3b0ac 100644
--- a/Documentation/git-status.txt
+++ b/Documentation/git-status.txt
@@ -55,18 +55,8 @@ specified.
 
 --ignore-submodules[=<when>]::
 	Ignore changes to submodules when looking for changes. <when> can be
-	either "none", "untracked", "dirty" or "all", which is the default.
-	Using "none" will consider the submodule modified when it either contains
-	untracked or modified files or its HEAD differs from the commit recorded
-	in the superproject and can be used to override any settings of the
-	'ignore' option in linkgit:git-config[1] or linkgit:gitmodules[5]. When
-	"untracked" is used submodules are not considered dirty when they only
-	contain untracked content (but they are still scanned for modified
-	content). Using "dirty" ignores all changes to the work tree of submodules,
-	only changes to the commits stored in the superproject are shown (this was
-	the behavior before 1.7.0). Using "all" hides all changes to submodules
-	(and suppresses the output of submodule summaries when the config option
-	`status.submodulesummary` is set).
+	either "none", "untracked", "dirty", "worktree", or "all",
+	which is the default.  See linkgit:git-diff[1] for details.
 
 -z::
 	Terminate entries with NUL, instead of LF.  This implies
diff --git a/Documentation/gitmodules.txt b/Documentation/gitmodules.txt
index bcffd95..02185c4 100644
--- a/Documentation/gitmodules.txt
+++ b/Documentation/gitmodules.txt
@@ -47,7 +47,9 @@ submodule.<name>.update::
 submodule.<name>.ignore::
 	Defines under what circumstances "git status" and the diff family show
 	a submodule as modified. When set to "all", it will never be considered
-	modified, "dirty" will ignore all changes to the submodules work tree and
+	modified; with "worktree", changes in the superproject index are
+	significant but in the subprojects are not;
+	"dirty" will ignore all changes to the submodules work tree and
 	takes only differences between the HEAD of the submodule and the commit
 	recorded in the superproject into account. "untracked" will additionally
 	let submodules with modified tracked files in their work tree show up.
diff --git a/diff-lib.c b/diff-lib.c
index 392ce2b..39fa605 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -72,7 +72,8 @@ static int match_stat_with_submodule(struct diff_options *diffopt,
 		unsigned orig_flags = diffopt->flags;
 		if (!DIFF_OPT_TST(diffopt, OVERRIDE_SUBMODULE_CONFIG))
 			set_diffopt_flags_from_submodule_config(diffopt, ce->name);
-		if (DIFF_OPT_TST(diffopt, IGNORE_SUBMODULES))
+		if (DIFF_OPT_TST(diffopt, IGNORE_SUBMODULES) ||
+		    DIFF_OPT_TST(diffopt, IGNORE_WT_SUBMODULES))
 			changed = 0;
 		else if (!DIFF_OPT_TST(diffopt, IGNORE_DIRTY_SUBMODULES)
 		    && (!changed || DIFF_OPT_TST(diffopt, DIRTY_SUBMODULES)))
diff --git a/diff.h b/diff.h
index 0083d92..3b835ce 100644
--- a/diff.h
+++ b/diff.h
@@ -77,7 +77,8 @@ typedef struct strbuf *(*diff_prefix_fn_t)(struct diff_options *opt, void *data)
 #define DIFF_OPT_DIRTY_SUBMODULES    (1 << 24)
 #define DIFF_OPT_IGNORE_UNTRACKED_IN_SUBMODULES (1 << 25)
 #define DIFF_OPT_IGNORE_DIRTY_SUBMODULES (1 << 26)
-#define DIFF_OPT_OVERRIDE_SUBMODULE_CONFIG (1 << 27)
+#define DIFF_OPT_IGNORE_WT_SUBMODULES (1 << 27)
+#define DIFF_OPT_OVERRIDE_SUBMODULE_CONFIG (1 << 28)
 
 #define DIFF_OPT_TST(opts, flag)    ((opts)->flags & DIFF_OPT_##flag)
 #define DIFF_OPT_SET(opts, flag)    ((opts)->flags |= DIFF_OPT_##flag)
diff --git a/submodule.c b/submodule.c
index 91a4758..81a99bd 100644
--- a/submodule.c
+++ b/submodule.c
@@ -102,6 +102,7 @@ int parse_submodule_config_option(const char *var, const char *value)
 		strbuf_release(&submodname);
 	} else if ((len > 7) && !strcmp(var + len - 7, ".ignore")) {
 		if (strcmp(value, "untracked") && strcmp(value, "dirty") &&
+		    strcmp(value, "worktree") &&
 		    strcmp(value, "all") && strcmp(value, "none")) {
 			warning("Invalid parameter \"%s\" for config option \"submodule.%s.ignore\"", value, var);
 			return 0;
@@ -127,6 +128,7 @@ void handle_ignore_submodules_arg(struct diff_options *diffopt,
 	DIFF_OPT_CLR(diffopt, IGNORE_SUBMODULES);
 	DIFF_OPT_CLR(diffopt, IGNORE_UNTRACKED_IN_SUBMODULES);
 	DIFF_OPT_CLR(diffopt, IGNORE_DIRTY_SUBMODULES);
+	DIFF_OPT_CLR(diffopt, IGNORE_WT_SUBMODULES);
 
 	if (!strcmp(arg, "all"))
 		DIFF_OPT_SET(diffopt, IGNORE_SUBMODULES);
@@ -134,6 +136,8 @@ void handle_ignore_submodules_arg(struct diff_options *diffopt,
 		DIFF_OPT_SET(diffopt, IGNORE_UNTRACKED_IN_SUBMODULES);
 	else if (!strcmp(arg, "dirty"))
 		DIFF_OPT_SET(diffopt, IGNORE_DIRTY_SUBMODULES);
+	else if (!strcmp(arg, "worktree"))
+		DIFF_OPT_SET(diffopt, IGNORE_WT_SUBMODULES);
 	else if (strcmp(arg, "none"))
 		die("bad --ignore-submodules argument: %s", arg);
 }
-- 
1.7.2.4
