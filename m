From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git v1.7.12-rc0
Date: Mon, 23 Jul 2012 22:08:48 -0700
Message-ID: <7vwr1thhjz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
To: git@vger.kernel.org
X-From: linux-kernel-owner@vger.kernel.org Tue Jul 24 07:09:04 2012
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1StXMj-0002Xs-H6
	for glk-linux-kernel-3@plane.gmane.org; Tue, 24 Jul 2012 07:09:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753538Ab2GXFIx (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Tue, 24 Jul 2012 01:08:53 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61938 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751229Ab2GXFIv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jul 2012 01:08:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B50AD8EEC;
	Tue, 24 Jul 2012 01:08:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=g
	B3y0mLOL6T2vMIQB23KPp08TvE=; b=NdlFJu68frEy0wowN0GmwiNYNc9xVj51S
	mPmXwfV4IhGV+FHOop9AnxrPMayx3GMXG2GnVk36gIK+HaOhFT6FU+cjaxRvelBJ
	WOf9EI2t+c6RMG0+hD42vlFQTsfRAejcU9XDTKcpLFm0qN7xE7xFtnjTj87JeMwZ
	YdBZ++07d4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; q=dns; s=
	sasl; b=Y7X2BkFQknrsIWVwI2eIjHkSPnvNTogf6dxJWnllNvMDtcxBhhcPj/IG
	GNmISKNGzKhz/3wV1LdT5XMUE7SEEngJlZA7HhWWhu89IGmlnXEE1Kgf0SRY4EYe
	8Jac/kkqxnfql856NzxWmxudQsvEzLXs5FfXkZGfshn7J4wCOPk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9DCAD8EEA;
	Tue, 24 Jul 2012 01:08:50 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9BFEB8EE8; Tue, 24 Jul 2012
 01:08:49 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A774B140-D54D-11E1-B032-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202008>

A release candidate Git v1.7.12-rc0 is now available for testing
at the usual places.

The release tarballs are found at:

    http://code.google.com/p/git-core/downloads/list

and their SHA-1 checksums are:

09016e819a69b49090756e9bc5c97a4df25c2f78  git-1.7.12.rc0.tar.gz
e85ad0780ff81eacdb05a10762060812bc9367dd  git-htmldocs-1.7.12.rc0.tar.gz
b641a9664c333518ede3b1d8b67d84d18f5b0e14  git-manpages-1.7.12.rc0.tar.gz

Also the following public repositories all have a copy of the v1.7.12-rc0
tag and the master branch that the tag points at:

  url = git://repo.or.cz/alt-git.git
  url = https://code.google.com/p/git-core/
  url = git://git.sourceforge.jp/gitroot/git-core/git.git
  url = git://git-core.git.sourceforge.net/gitroot/git-core/git-core
  url = https://github.com/gitster/git

Git v1.7.12 Release Notes (draft)
=========================

Updates since v1.7.11
---------------------

UI, Workflows & Features

 * Git can be told to normalize pathnames it read from readdir(3) and
   all arguments it got from the command line into precomposed UTF-8
   (assuming that they come as decomposed UTF-8), in order to work
   around issues on Mac OS.

   I think there still are other places that need conversion
   (e.g. paths that are read from stdin for some commands), but this
   should be a good first step in the right direction.

 * Per-user $HOME/.gitconfig file can optionally be stored in
   $HOME/.config/git/config instead, which is in line with XDG.

 * The value of core.attributesfile and core.excludesfile default to
   $HOME/.config/attributes and $HOME/.config/ignore respectively when
   these files exist.

 * Logic to disambiguate abbreviated object names have been taught to
   take advantage of object types that are expected in the context,
   e.g. XXXXXX in the "git describe" output v1.2.3-gXXXXXX must be a
   commit object, not a blob nor a tree.  This will help us prolong
   the lifetime of abbreviated object names.

 * "git apply" learned to wiggle the base version and perform three-way
   merge when a patch does not exactly apply to the version you have.

 * Scripted Porcelain writers now have access to the credential API via
   the "git credential" plumbing command.

 * "git help" used to always default to "man" format even on platforms
   where "man" viewer is not widely available.

 * "git clone --local $path" started its life as an experiment to
   optionally use link/copy when cloning a repository on the disk, but
   we didn't deprecate it after we made the option a no-op to always
   use the optimization.  The command learned "--no-local" option to
   turn this off, as a more explicit alternative over use of file://
   URL.

 * "git fetch" and friends used to say "remote side hung up
   unexpectedly" when they failed to get response they expect from the
   other side, but one common reason why they don't get expected
   response is that the remote repository does not exist or cannot be
   read. The error message in this case was updated to give better
   hints to the user.

 * git native protocol agents learned to show software version over
   the wire, so that the server log can be examined to see the vintage
   distribution of clients.

 * "git help -w $cmd" can show HTML version of documentation for
   "git-$cmd" by setting help.htmlpath to somewhere other than the
   default location where the build procedure installs them locally;
   the variable can even point at a http:// URL.

 * "git rebase [-i] --root $tip" can now be used to rewrite all the
   history leading to "$tip" down to the root commit.

 * "git rebase -i" learned "-x <cmd>" to insert "exec <cmd>" after
   each commit in the resulting history.

 * "git status" gives finer classification to various states of paths
   in conflicted state and offer advice messages in its output.

 * "git submodule" learned to deal with nested submodule structure
   where a module is contained within a module whose origin is
   specified as a relative URL to its superproject's origin.

 * A rather heavy-ish "git completion" script has been split to create
   a separate "git prompting" script, to help lazy-autoloading of the
   completion part while making prompting part always available.

 * "gitweb" pays attention to various forms of credits that are
   similar to "Signed-off-by:" lines in the commit objects and
   highlights them accordingly.


Foreign Interface

 * "mediawiki" remote helper (in contrib/) learned to handle file
   attachments.

 * "git p4" now uses "Jobs:" and "p4 move" when appropriate.

 * vcs-svn has been updated to clean-up compilation, lift 32-bit
   limitations, etc.


Performance, Internal Implementation, etc. (please report possible regressions)

 * Some tests showed false failures caused by a bug in ecryptofs.

 * We no longer use AsciiDoc7 syntax in our documentation and favor a
   more modern style.

 * "git am --rebasing" codepath was taught to grab authorship, log
   message and the patch text directly out of existing commits.  This
   will help rebasing commits that have confusing "diff" output in
   their log messages.

 * "git index-pack" and "git pack-objects" use streaming API to read
   from the object store to avoid having to hold a large blob object
   in-core while they are doing their thing.

 * Code to match paths with exclude patterns learned to avoid calling
   fnmatch() by comparing fixed leading substring literally when
   possible.

 * "git log -n 1 -- rarely-touched-path" was spending unnecessary
   cycles after showing the first change to find the next one, only to
   discard it.


Also contains minor documentation updates and code clean-ups.


Fixes since v1.7.11
-------------------

Unless otherwise noted, all the fixes since v1.7.11 in the maintenance
releases are contained in this release (see release notes to them for
details).

 * "git commit-tree" learned a more natural "-p <parent> <tree>" order
   of arguments long time ago, but recently forgot it by mistake.
   (merge 4b7518a kk/maint-commit-tree later to maint).

 * "git diff --no-ext-diff" did not output anything for a typechange
   filepair when GIT_EXTERNAL_DIFF is in effect.
   (merge c12f82a jv/maint-no-ext-diff later to maint).

 * When "git am" failed, old timers knew to check .git/rebase-apply/patch
   to see what went wrong, but we never told the users about it.
   (merge 14bf2d5 pg/maint-1.7.9-am-where-is-patch later to maint).

 * When "git submodule add" clones a submodule repository, it can get
   confused where to store the resulting submodule repository in the
   superproject's .git/ directory when there is a symbolic link in the
   path to the current directory.
   (merge 6eafa6d jl/maint-1.7.10-recurse-submodules-with-symlink later to maint).

 * In 1.7.9 era, we taught "git rebase" about the raw timestamp format
   but we did not teach the same trick to "filter-branch", which rolled
   a similar logic on its own.
   (merge 44b85e89 jc/maint-filter-branch-epoch-date later to maint).
