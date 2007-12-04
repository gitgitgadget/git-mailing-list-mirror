From: Junio C Hamano <gitster@pobox.com>
Subject: What's in git.git (stable)
Date: Tue, 04 Dec 2007 00:43:31 -0800
Message-ID: <7vsl2i6ea4.fsf@gitster.siamese.dyndns.org>
References: <20071022061115.GR14735@spearce.org>
	<7vodeecyni.fsf@gitster.siamese.dyndns.org>
	<7vpryqwtt7.fsf@gitster.siamese.dyndns.org>
	<7vk5ot40w9.fsf@gitster.siamese.dyndns.org>
	<7vy7d43ptc.fsf@gitster.siamese.dyndns.org>
	<7vabpg9x5k.fsf@gitster.siamese.dyndns.org>
	<7vy7cwsi3p.fsf@gitster.siamese.dyndns.org>
	<7vk5o6jbq9.fsf@gitster.siamese.dyndns.org>
	<7v63zjgoel.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 04 09:44:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzTNv-0005YE-AI
	for gcvg-git-2@gmane.org; Tue, 04 Dec 2007 09:44:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751978AbXLDIng (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Dec 2007 03:43:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751975AbXLDIng
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Dec 2007 03:43:36 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:37213 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751804AbXLDIne (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Dec 2007 03:43:34 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 24EA42F2;
	Tue,  4 Dec 2007 03:43:56 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 632CE9BB4B;
	Tue,  4 Dec 2007 03:43:54 -0500 (EST)
X-maint-at: 4e596e988abfd7ce0b4456cdbf27baa16fa7aab8
X-master-at: af055e0983170afdc7cbb989a59e6c738400ccd8
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67024>

Nothing exciting on 'maint' since 1.5.3.7.

On the 'master' front, we will soon be in feature freeze for 1.5.4.
Many topics that have been cooking in 'next' has been pushed out.  This
round it is a rather large batch but hopefully it will not destabilize
it too much.  Knock wood.

 * "git pull --rebase" is a different way to integrate what you fetched
   into your current branch.

 * "git fast-export" produces datastream that can be fed to fast-import
   to reproduce the history recorded in a git repository.

 * gitk is now merged as a subdirectory of git.git project, in
   preparation for its i18n.

 * Value "true" for color.diff and color.status configuration used to
   mean "always" (even when the output is not going to a terminal).
   This has been corrected to mean the same thing as "auto".

 * "git commit --allow-empty" allows you to create a single-parent
   commit that records the same tree as its parent, overriding the usual
   safety valve.

 * "git stash random-text" does not create a new stash anymore.  It was
   a UI mistake.  Use "git stash save random-text", or "git stash"
   (without extra args) for that.

 * HTTP proxy can be specified per remote repository using
   remote.*.proxy configuration, or global http.proxy configuration
   variable.

 * "git rebase -i" also triggers rerere to help you repeated merges.

 * "git prune --expire <time>" can exempt young loose objects from
   getting pruned.

 * "git branch --contains <commit>" can list branches that are
   descendants of a given commit.

----------------------------------------------------------------

* The 'maint' branch has these fixes since the last announcement.

Jeff King (1):
  t9600: test cvsimport from CVS working tree

Junio C Hamano (2):
  Fix typo in t4008 test title
  GIT 1.5.3.7


* The 'master' branch has these since the last announcement
  in addition to the above.

Andy Whitcroft (1):
  git-svn: add support for pulling author from From: and Signed-off-by:

Carlos Rica (1):
  Make builtin-tag.c use parse_options.

Christian Couder (2):
  Documentation: add a new man page for "git-help"
  Trace and quote with argv: get rid of unneeded count argument.

David D. Kilzer (1):
  git-svn: Remove unnecessary Git::SVN::Util package

David Symonds (1):
  Mention that git-rm can be an appropriate resolution as well as git-add.

Denis Cheng (1):
  gitweb: the commitdiff is very commonly used, it's needed on search page,
    too

Gustaf Hendeby (1):
  git-svn now reads settings even if called in subdirectory

Jakub Narebski (1):
  gitweb: Update and improve gitweb/README file

Jeff King (2):
  git-tag: test that -s implies an annotated tag
  Enable rewrite as well as rename detection in git-status

Johannes Schindelin (7):
  Replace instances of export VAR=VAL with VAR=VAL; export VAR
  Teach 'git pull' about --rebase
  rebase -i: give rerere a chance
  Add "--expire <time>" option to 'git prune'
  Add 'git fast-export', the sister of 'git fast-import'
  fast-export: rename the signed tag mode 'ignore' to 'verbatim'
  Allow ':/<oneline-prefix>' syntax to work with save_commit_buffer == 0

Johannes Sixt (1):
  git-commit: Allow to amend a merge commit that does not change the tree

Junio C Hamano (17):
  Move gitk to its own subdirectory
  git-branch --contains=commit
  git-branch --contains: doc and test
  builtin-tag: accept and process multiple -m just like git-commit
  "git-tag -s" should create a signed annotated tag
  "color.diff = true" is not "always" anymore.
  git-config --get-color: get configured color
  Update draft release notes for 1.5.4
  Resurrect peek-remote
  Consolidate command list to one.
  Update draft release notes for 1.5.4
  rename: Break filepairs with different types.
  git-am: catch missing author date early.
  git-commit --allow-empty
  git-commit documentation: fix unfinished sentence.
  Add git-fast-export to list of commands.
  Update draft release notes for 1.5.4

Kevin Leung (1):
  git-stash: Display help message if git-stash is run with wrong
    sub-commands

Pierre Habouzit (1):
  parse-options: Allow to hide options from the default usage.

Robert Schiele (1):
  install-sh from automake does not like -m without delimiting space

Sam Vilain (2):
  Allow HTTP proxy to be overridden in config
  Add remote.<name>.proxy

Steven Grimm (1):
  git-svn: Don't create a "master" branch every time rebase is run

Theodore Ts'o (2):
  Make the list of common commands more exclusive
  Remove hint to use "git help -a"

Vineet Kumar (1):
  git-svn: add a show-externals command.

Wincent Colaiuta (1):
  revert/cherry-pick: Allow overriding the help text by the calling
    Porcelain
