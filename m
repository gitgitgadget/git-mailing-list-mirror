From: Jonathan Nieder <jrnieder@gmail.com>
Subject: jc/add-2.0-delete-default (Re: What's cooking in git.git (Apr 2013,
 #05; Mon, 15))
Date: Sun, 21 Apr 2013 00:39:18 -0700
Message-ID: <20130421073918.GD10429@elie.Belkin>
References: <7vd2tr6833.fsf@alter.siamese.dyndns.org>
 <20130418180017.GA5714@sigill.intra.peff.net>
 <7v61zj66wu.fsf@alter.siamese.dyndns.org>
 <20130418203035.GB24690@sigill.intra.peff.net>
 <7vvc7j4j0u.fsf@alter.siamese.dyndns.org>
 <20130418214427.GA10119@sigill.intra.peff.net>
 <7vobdb4hii.fsf@alter.siamese.dyndns.org>
 <20130419043142.GA5055@elie.Belkin>
 <7vbo9a3011.fsf@alter.siamese.dyndns.org>
 <20130419213455.GB20873@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@inf.ethz.ch>, git@vger.kernel.org,
	Jan =?utf-8?Q?Kr=C3=BCger?= <jk@jk.gs>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Apr 21 09:39:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTos1-0002eR-IE
	for gcvg-git-2@plane.gmane.org; Sun, 21 Apr 2013 09:39:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752272Ab3DUHj3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Apr 2013 03:39:29 -0400
Received: from mail-da0-f50.google.com ([209.85.210.50]:34397 "EHLO
	mail-da0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752045Ab3DUHj2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Apr 2013 03:39:28 -0400
Received: by mail-da0-f50.google.com with SMTP id a4so1064249dad.23
        for <git@vger.kernel.org>; Sun, 21 Apr 2013 00:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=u98CTY8I31VxnNPqZY4fjw74jXsDlPbYcLC20J/RiU0=;
        b=PkT0BSLx4YHfWwrLhSwTf8QiimDk3Iwmt+qYrtGMAxJ/XbhxHLTmW0urIYElvS7QXh
         eJXD+QWEe/a1gT9BBqS2maqseUeuB+4Swu5DfZ4i8QY6kaK2gd59eJB3IEyRwh3iuIfb
         mUiklii51cHndlTWuNE/fCKARVwuW/pP2DEOg0LA/pF+WSkVJAqQOtNer36z6zo+Xyj5
         l4mdWUFEkfmF5P8Lc3xwBaBfmpHmfJQCCgKGocJcieKBceGUzAEmb8YDUMzjyjFKN1e3
         J+niwNNxXBxU4wNxzWrYYuk+oudIR1DfpIAx8zpcG9cTv2S+BFGBGvGOoDbRct+Lnt/L
         D8tg==
X-Received: by 10.66.253.132 with SMTP id aa4mr485063pad.131.1366529968225;
        Sun, 21 Apr 2013 00:39:28 -0700 (PDT)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id ra9sm21818366pab.16.2013.04.21.00.39.25
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 21 Apr 2013 00:39:26 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130419213455.GB20873@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221908>

> On Fri, Apr 19, 2013 at 10:25:46AM -0700, Junio C Hamano wrote:
>>> Junio C Hamano wrote:

>>>>     You ran 'git add' with neither '-A (--all)' or '--no-all', whose
>>>>     behaviour will change in Git 2.0 with respect to paths you
>>>>     removed from your working tree.
>>>>
>>>>     * 'git add --no-all <pathspec>', which is the current default,
>>>>       ignores paths you removed from your working tree.
>>>>
>>>>     * 'git add --all <pathspec>' will let you also record the
>>>>       removals.
>>>>
>>>>     The removed paths (e.g. '%s') are ignored with this version of Git.
>>>>     Run 'git status' to remind yourself what paths you have removed
>>>>     from your working tree.
>>>>
>>>> or something?
[...]
>>                                     Somebody good at phrasing needs
>> to trim it down without losing the essense.

By the way, it was mentioned on IRC that the above is a bit odd for
a different reason: the option --no-all that maintains the old behavior
is not intuitively named.

How about something like this?

	warning: "git add" run on path with files removed (e.g., '%s')
	hint: use "git add --ignore-removals <pathspec>" to ignore removals
	hint: or "git add --no-ignore-removals <pathspec>" to notice them
	hint: --ignore-removals is the default but this will change soon
	hint: see git-add(1) for details

Then the --ignore-removals option could be added using a patch like
the following.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Documentation/git-add.txt | 24 +++++++++++++++---------
 builtin/add.c             | 28 +++++++++++++++++++++++++---
 2 files changed, 40 insertions(+), 12 deletions(-)

diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index b0944e57..8607cf37 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -9,7 +9,8 @@ SYNOPSIS
 --------
 [verse]
 'git add' [-n] [-v] [--force | -f] [--interactive | -i] [--patch | -p]
-	  [--edit | -e] [--all | [--update | -u]] [--intent-to-add | -N]
+	  [--edit | -e] [--update | -u] [--no-ignore-removals | -A]
+	  [--intent-to-add | -N]
 	  [--refresh] [--ignore-errors] [--ignore-missing] [--]
 	  [<pathspec>...]
 
@@ -109,17 +110,22 @@ If no <pathspec> is given, the current version of Git defaults to
 and its subdirectories. This default will change in a future version
 of Git, hence the form without <pathspec> should not be used.
 
+--ignore-removals::
+--no-ignore-removals::
 -A::
 --all::
-	Update the index not only where the working tree has a file
-	matching <pathspec> but also where the index already has an
-	entry.	This adds, modifies, and removes index entries to
-	match the working tree.
+	Update the index only where the working tree has a file
+	matching <pathspec>.  This adds and modifies index entries
+	to match the working tree but ignores removed files.
 +
-If no <pathspec> is given, the current version of Git defaults to
-"."; in other words, update all files in the current directory
-and its subdirectories. This default will change in a future version
-of Git, hence the form without <pathspec> should not be used.
+This is currently the default.  Git 2.0 will change the default
+to --no-ignore-removals.
++
+With --no-ignore-removals (and its historical synonyms `-A` and
+`--all`), if no <pathspec> is given, the current version of Git
+defaults to "."; in other words, update all files in the current
+directory and its subdirectories. This default will change in a future
+version of Git, hence the form without <pathspec> should not be used.
 
 -N::
 --intent-to-add::
diff --git a/builtin/add.c b/builtin/add.c
index ab1c9e8f..4a4e71ad 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -28,6 +28,14 @@ struct update_callback_data {
 	int add_errors;
 };
 
+static int parse_opt_neg_tertiary(const struct option *opt, const char *arg,
+				  int unset)
+{
+	int *target = opt->value;
+	*target = unset ? 1 : 2;
+	return 0;
+}
+
 static int fix_unmerged_status(struct diff_filepair *p,
 			       struct update_callback_data *data)
 {
@@ -271,7 +279,8 @@ static const char ignore_error[] =
 N_("The following paths are ignored by one of your .gitignore files:\n");
 
 static int verbose = 0, show_only = 0, ignored_too = 0, refresh_only = 0;
-static int ignore_add_errors, addremove, intent_to_add, ignore_missing = 0;
+static int ignore_add_errors, intent_to_add, ignore_missing = 0;
+static int ignore_removals, addremove;
 
 static struct option builtin_add_options[] = {
 	OPT__DRY_RUN(&show_only, N_("dry run")),
@@ -283,10 +292,12 @@ static struct option builtin_add_options[] = {
 	OPT__FORCE(&ignored_too, N_("allow adding otherwise ignored files")),
 	OPT_BOOLEAN('u', "update", &take_worktree_changes, N_("update tracked files")),
 	OPT_BOOLEAN('N', "intent-to-add", &intent_to_add, N_("record only the fact that the path will be added later")),
-	OPT_BOOLEAN('A', "all", &addremove, N_("add changes from all tracked and untracked files")),
+	OPT_UYN( 0 , "ignore-removals", &ignore_removals, N_("do not record removal of tracked files")),
 	OPT_BOOLEAN( 0 , "refresh", &refresh_only, N_("don't add, only refresh the index")),
 	OPT_BOOLEAN( 0 , "ignore-errors", &ignore_add_errors, N_("just skip files which cannot be added because of errors")),
 	OPT_BOOLEAN( 0 , "ignore-missing", &ignore_missing, N_("check if - even missing - files are ignored in dry run")),
+	{ OPTION_CALLBACK, 'A', "all", &ignore_removals, NULL, N_("synonym for --no-ignore-removals"),
+	  PARSE_OPT_HIDDEN | PARSE_OPT_NOARG, &parse_opt_neg_tertiary },
 	OPT_END(),
 };
 
@@ -377,8 +388,19 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 	argc--;
 	argv++;
 
+	if (ignore_removals == 2) {	/* --no-ignore-removals, or -A */
+		addremove = 1;
+		ignore_removals = 0;
+	}
+	if (ignore_removals && take_worktree_changes)
+		/*
+		 * NEEDSWORK: "git add -u --ignore-removals" should mean
+		 * "git diff --diff-filter=M | git apply --cached"
+		 */
+		die(_("--ignore-removals cannot be used with --update"));
 	if (addremove && take_worktree_changes)
-		die(_("-A and -u are mutually incompatible"));
+		/* -u --no-ignore-removals is the same as -u */
+		addremove = 0;
 	if (!show_only && ignore_missing)
 		die(_("Option --ignore-missing can only be used together with --dry-run"));
 	if (addremove) {
-- 
1.8.2.1
