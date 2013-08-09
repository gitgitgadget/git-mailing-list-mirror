From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Remove old forgotten command: whatchanged
Date: Fri, 09 Aug 2013 10:28:53 -0700
Message-ID: <7vwqnu6aei.fsf@alter.siamese.dyndns.org>
References: <CALkWK0=zZKTwn7cdrJXsVXH-rF=xWMeD_z2XAOCnuaf2bK_h8Q@mail.gmail.com>
	<vpqfvukdy39.fsf@anie.imag.fr> <ku0lqj$qvs$1@ger.gmane.org>
	<vpqk3jwcb1q.fsf@anie.imag.fr>
	<7v1u649e5m.fsf@alter.siamese.dyndns.org>
	<vpqbo57clnb.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Damien Robert <damien.olivier.robert+gmane@gmail.com>,
	git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Aug 09 19:29:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7qUq-0001Eh-Q2
	for gcvg-git-2@plane.gmane.org; Fri, 09 Aug 2013 19:29:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754878Ab3HIR3A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Aug 2013 13:29:00 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37047 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754073Ab3HIR27 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Aug 2013 13:28:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2F67B36D69;
	Fri,  9 Aug 2013 17:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MzfOL3KDD/LmAza8VGi2VCTW8mg=; b=eW5cWC
	mWRXeFbQ2QhITr/BxILt+lHgnYanYKfGAsu/9Ji2iWa2lpwrRXMrNXAdrkn8NFwq
	wKH4jsW7LsiBs7RMmX/2WcFrNWsZ5s5zdSrsA6vftAzxIPJyI/JUcZvCfSvSBVOD
	Tsv03t7QA7TWNbPxnrP3OgFUkA2liNnVmL7gM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kmyZYBxE9uIHq/1NGecg3wxA8KwqyqSE
	+YXL4wiIyQ2AyIFiH8tl99+TKPes6Pdq6Udax1ldq4QJD9dksQcxR007kPyU+KdD
	rLJ7lhHIt2/FxV6DmrEi5hfvO3rszPJ2Jwb6pDv+zVFsB4Scd6Hd/g41Co8SGQr6
	s0zi0rB0s4o=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7FDCD36D67;
	Fri,  9 Aug 2013 17:28:57 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 876C936D64;
	Fri,  9 Aug 2013 17:28:55 +0000 (UTC)
In-Reply-To: <vpqbo57clnb.fsf@anie.imag.fr> (Matthieu Moy's message of "Fri,
	09 Aug 2013 10:29:28 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2AD4DAD6-0119-11E3-BADE-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232000>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> It is meant to teach them "if you want to do your own 'git log', you
>> can do so with 'rev-list' piped to 'diff-tree --stdin'".  Changing
>> 'whatchanged' to 'log' in the latter statement is an improvement,
>> but dropping 'can be done by combining rev-list and diff-tree' goes
>> against the objective of the whole document.
>
> Then, we can keep the "In fact, together with the 'git rev-list'
> program ..." sentence, but drop "A trivial (but very useful)
> script ...", which is both technically incorrect (whatchanged is not a
> script anymore) and misleading because it advertises whatchanged.
>
> That would look like this:

Yeah, but I think we further can strip it down and remove "git log"
invocation that is done without argument.  This document is not
about teaching "the command you use to view the history is 'log'"
(the new tutorial and the user manuals are), and this subsection is
about diff-tree (in the section about "Inspecting Changes" with
plumbing in the diff family).

How about doing it like this?

-- >8 --
Subject: core-tutorial: trim the section on Inspecting Changes

Back when the core tutorial was written, `log` and `whatchanged`
were scripted Porcelains.  In the "Inspecting Changes" section that
talks about the plumbing commands in the diff family, it made sense
to use `log` and `whatchanged` as good examples of the use of these
plumbing commands, and because even these scripted Porcelains were
novelty (there wasn't the new end-user tutorial written), it made
some sense to illustrate uses of the `git log` (and `git
whatchanged`) scripted Porcelain commands.

But we no longer have scripted `log` and `whatchanged` to serve as
examples, and this document is not where the end users learn what
`git log` command is about.  Stop at briefly mentioning the
possibility of combining rev-list with diff-tree to build your own
log, and leave the end-user documentation of `log` to the new
tutorial and the user manual.

Also resurrect the last version of `git-log`, `git-whatchanged`, and
`git-show` to serve as examples to contrib/examples/ directory.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/gitcore-tutorial.txt  | 39 +++----------------------------------
 contrib/examples/git-log.sh         | 15 ++++++++++++++
 contrib/examples/git-whatchanged.sh | 28 ++++++++++++++++++++++++++
 3 files changed, 46 insertions(+), 36 deletions(-)

diff --git a/Documentation/gitcore-tutorial.txt b/Documentation/gitcore-tutorial.txt
index f538a87..3e83e1e 100644
--- a/Documentation/gitcore-tutorial.txt
+++ b/Documentation/gitcore-tutorial.txt
@@ -534,42 +534,9 @@ all, but just show the actual commit message.
 
 In fact, together with the 'git rev-list' program (which generates a
 list of revisions), 'git diff-tree' ends up being a veritable fount of
-changes. A trivial (but very useful) script called 'git whatchanged' is
-included with Git which does exactly this, and shows a log of recent
-activities.
-
-To see the whole history of our pitiful little git-tutorial project, you
-can do
-
-----------------
-$ git log
-----------------
-
-which shows just the log messages, or if we want to see the log together
-with the associated patches use the more complex (and much more
-powerful)
-
-----------------
-$ git whatchanged -p
-----------------
-
-and you will see exactly what has changed in the repository over its
-short history.
-
-[NOTE]
-When using the above two commands, the initial commit will be shown.
-If this is a problem because it is huge, you can hide it by setting
-the log.showroot configuration variable to false. Having this, you
-can still show it for each command just adding the `--root` option,
-which is a flag for 'git diff-tree' accepted by both commands.
-
-With that, you should now be having some inkling of what Git does, and
-can explore on your own.
-
-[NOTE]
-Most likely, you are not directly using the core
-Git Plumbing commands, but using Porcelain such as 'git add', `git-rm'
-and `git-commit'.
+changes.  You can emulate `git log` with a trivial script that pipes
+the output of `git rev-list` to `git diff-tree --stdin`, which was
+exactly how early versions of `git log` were implemented.
 
 
 Tagging a version
diff --git a/contrib/examples/git-log.sh b/contrib/examples/git-log.sh
new file mode 100755
index 0000000..c2ea71c
--- /dev/null
+++ b/contrib/examples/git-log.sh
@@ -0,0 +1,15 @@
+#!/bin/sh
+#
+# Copyright (c) 2005 Linus Torvalds
+#
+
+USAGE='[--max-count=<n>] [<since>..<limit>] [--pretty=<format>] [git-rev-list options]'
+SUBDIRECTORY_OK='Yes'
+. git-sh-setup
+
+revs=$(git-rev-parse --revs-only --no-flags --default HEAD "$@") || exit
+[ "$revs" ] || {
+	die "No HEAD ref"
+}
+git-rev-list --pretty $(git-rev-parse --default HEAD "$@") |
+LESS=-S ${PAGER:-less}
diff --git a/contrib/examples/git-whatchanged.sh b/contrib/examples/git-whatchanged.sh
new file mode 100755
index 0000000..1fb9feb
--- /dev/null
+++ b/contrib/examples/git-whatchanged.sh
@@ -0,0 +1,28 @@
+#!/bin/sh
+
+USAGE='[-p] [--max-count=<n>] [<since>..<limit>] [--pretty=<format>] [-m] [git-diff-tree options] [git-rev-list options]'
+SUBDIRECTORY_OK='Yes'
+. git-sh-setup
+
+diff_tree_flags=$(git-rev-parse --sq --no-revs --flags "$@") || exit
+case "$0" in
+*whatchanged)
+	count=
+	test -z "$diff_tree_flags" &&
+		diff_tree_flags=$(git-repo-config --get whatchanged.difftree)
+	diff_tree_default_flags='-c -M --abbrev' ;;
+*show)
+	count=-n1
+	test -z "$diff_tree_flags" &&
+		diff_tree_flags=$(git-repo-config --get show.difftree)
+	diff_tree_default_flags='--cc --always' ;;
+esac
+test -z "$diff_tree_flags" &&
+	diff_tree_flags="$diff_tree_default_flags"
+
+rev_list_args=$(git-rev-parse --sq --default HEAD --revs-only "$@") &&
+diff_tree_args=$(git-rev-parse --sq --no-revs --no-flags "$@") &&
+
+eval "git-rev-list $count $rev_list_args" |
+eval "git-diff-tree --stdin --pretty -r $diff_tree_flags $diff_tree_args" |
+LESS="$LESS -S" ${PAGER:-less}
