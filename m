From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git 1.7.10-rc0
Date: Wed, 07 Mar 2012 17:35:07 -0800
Message-ID: <7v7gyvkh84.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 08 02:36:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5SH3-00080F-LM
	for gcvg-git-2@plane.gmane.org; Thu, 08 Mar 2012 02:36:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753874Ab2CHBfO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Mar 2012 20:35:14 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54668 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752730Ab2CHBfL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Mar 2012 20:35:11 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 932596320;
	Wed,  7 Mar 2012 20:35:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:cc:date:message-id:mime-version:content-type; s=sasl;
	 bh=IqoZp90mdaxac8INQ4ZxW7PiT9c=; b=TE2HzAIjwvx2QO49Vla1d2KwD/ta
	XRHoiIT7HmoWiOgLUTeVyBTB/XQEc1At/DrvQuUfcQu8tHfC5C9FqaiITNvotwFp
	HB6SJ6hK6ZP4SGuRhXZlkaPO7WwcgTovNPDrfd3i+2RWOX/peFVGE04NE0d8dNrP
	w5AM5BOUCpFhnCo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:cc:date:message-id:mime-version:content-type; q=dns; s=sasl; b=
	twt+n5Ll37OslTPrXLphdEJk28pbFrI6H79Z9SiM6OtCUDCXsKDgxp6M1fGoID86
	V37XSXq5iK93Aiz2JLwQqxam/3pgvGY1Knaloi2fAzKu6drrurs8YrdogzwzsqRr
	wZhC4Y73/9ORt937GiLEZP8xPrcdWfCqUCqmbOTsY3s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 88D7D631F;
	Wed,  7 Mar 2012 20:35:09 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B86CD631E; Wed,  7 Mar 2012
 20:35:08 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F09C36BE-68BE-11E1-8C8B-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192515>


A release candidate Git 1.7.10-rc0 is now available for testing at
the usual places.

The release tarballs are found at:

    http://code.google.com/p/git-core/downloads/list

and their SHA-1 checksums are:

96d1d25fd4f681246009b24fcaa4e41d88223f5b  git-1.7.10.rc0.tar.gz
a8c76f12980a287e0f6a0f285768ab492caaed98  git-htmldocs-1.7.10.rc0.tar.gz
8f5f8aa4f692eb3d6e3549f6eb0fb0b5419c2f57  git-manpages-1.7.10.rc0.tar.gz

Also the following public repositories all have a copy of the v1.7.10.rc0
tag and the master branch that the tag points at:

  url = git://repo.or.cz/alt-git.git
  url = https://code.google.com/p/git-core/
  url = git://git.sourceforge.jp/gitroot/git-core/git.git
  url = git://git-core.git.sourceforge.net/gitroot/git-core/git-core
  url = https://github.com/gitster/git

The other day, soon after announcement of the 1.7.9.3 maintenance
release, there was a report that some tests did not pass on one
platform.  Even though it is better than not seeing one, such a late
report saddens us, especially because the exact test breakage has
been in the master and next branches for quite some time for people
to catch before it goes to any released versions.

Please test this and later pre-releases to make sure no such late
report has to come for the upcoming 1.7.10 final.

Thanks.


Git v1.7.10 Release Notes (draft)
=========================

Compatibility Notes
-------------------

 * From this release on, the "git merge" command in an interactive
   session will start an editor when it automatically resolves the
   merge for the user to explain the resulting commit, just like the
   "git commit" command does when it wasn't given a commit message.

   If you have a script that runs "git merge" and keeps its standard
   input and output attached to the user's terminal, and if you do not
   want the user to explain the resulting merge commits, you can
   export GIT_MERGE_AUTOEDIT environment variable set to "no", like
   this:

	#!/bin/sh
	GIT_MERGE_AUTOEDIT=no
	export GIT_MERGE_AUTOEDIT

   to disable this behaviour (if you want your users to explain their
   merge commits, you do not have to do anything).  Alternatively, you
   can give the "--no-edit" option to individual invocations of the
   "git merge" command if you know everybody who uses your script has
   Git v1.7.8 or newer.


Updates since v1.7.9
--------------------

UI, Workflows & Features

 * Teams for localizing the messages from the Porcelain layer of
   commands are starting to form, thanks to Jiang Xin who volunteered
   to be the localization coordinator.  An initial set of translated
   messages for simplified chinese is available.

 * The configuration mechanism learned an "include" facility; an
   assignment to the include.path pseudo-variable causes the named
   file to be included in-place when Git looks up configuration
   variables.

 * A content filter (clean/smudge) used to be just a way to make the
   recorded contents "more useful", and allowed to fail; a filter can
   new optionally be marked as "required".

 * Options whose names begin with "--no-" (e.g. the "--no-verify"
   option of the "git commit" command) can be negated by omitting
   "no-" from its name, e.g. "git commit --verify".

 * "git am" learned to pass "-b" option to underlying "git mailinfo", so
   that bracketed string other than "PATCH" at the beginning can be kept.

 * "git clone" learned "--single-branch" option to limit cloning to a
   single branch (surprise!).

 * "git clone" learned to detach the HEAD in the resulting repository
   when the source repository's HEAD does not point to a branch.

 * When showing a patch while ignoring whitespace changes, the context
   lines are taken from the postimage, in order to make it easier to
   view the output.

 * "git diff --stat" learned to adjust the width of the output on
   wider terminals, and give more columns to pathnames as needed.

 * "diff-highlight" filter (in contrib/) was updated to produce more
   aesthetically pleasing output.

 * "fsck" learned "--no-dangling" option to omit dangling object
   information.

 * "git log -G" learned to pay attention to the "-i" option and can
   find patch hunks that introduce or remove a string that matches the
   given pattern ignoring the case.

 * "git merge" in an interactive session learned to spawn the editor
   by default to let the user edit the auto-generated merge message,
   to encourage people to explain their merges better. Legacy scripts
   can export GIT_MERGE_AUTOEDIT=no to retain the historical behavior.
   Both "git merge" and "git pull" can be given --no-edit from the
   command line to accept the auto-generated merge message.

 * The advise message given when the user didn't give enough clue on
   what to merge to "git pull" and "git merge" has been updated to
   be more concise and easier to understand.

 * "git push" learned the "--prune" option, similar to "git fetch".

 * "git symbolic-ref" learned the "--short" option to abbreviate the
   refname it shows unambiguously.

 * "git tag --list" can be given "--points-at <object>" to limit its
   output to those that point at the given object.

 * "gitweb" allows intermediate entries in the directory hierarchy
   that leads to a projects to be clicked, which in turn shows the
   list of projects inside that directory.

 * "gitweb" learned to read various pieces of information for the
   repositories lazily, instead of reading everything that could be
   needed (including the ones that are not necessary for a specific
   task).

 * Project search in "gitweb" shows the substring that matched in the
   project name and description highlighted.

Foreign Interface

 * Improved handling of views, labels and branches in "git-p4" (in contrib).

 * "git-p4" (in contrib) suffered from unnecessary merge conflicts when
   p4 expanded the embedded $RCS$-like keywords; it can be now told to
   unexpand them.

 * Some "git-svn" updates.

 * "vcs-svn"/"svn-fe" learned to read dumps with svn-deltas and
   support incremental imports.

 * "git difftool/mergetool" learned to drive DeltaWalker.

Performance

 * Unnecessary calls to parse_object() "git upload-pack" makes in
   response to "git fetch", have been eliminated, to help performance
   in repositories with excessive number of refs.

Internal Implementation (please report possible regressions)

 * Recursive call chains in "git index-pack" to deal with long delta
   chains have been flattened, to reduce the stack footprint.

 * Use of add_extra_ref() API is now gone, to make it possible to
   cleanly restructure the overall refs API.

 * The command line parser of "git pack-objects" now uses parse-options
   API.

 * The test suite supports the new "test_pause" helper function.

 * Parallel to the test suite, there is a beginning of performance
   benchmarking framework.

 * t/Makefile is adjusted to prevent newer versions of GNU make from
   running tests in seemingly random order.

 * The code to check if a path points at a file beyond a symbolic link
   has been restructured to be thread-safe.

Also contains minor documentation updates and code clean-ups.


Fixes since v1.7.9
------------------

Unless otherwise noted, all the fixes since v1.7.9 in the maintenance
releases are contained in this release (see release notes to them for
details).

 * "git bundle" did not record boundary commits correctly when there
   are many of them.
   (merge efe4be1 tr/maint-bundle-boundary later to maint).

 * "git diff-index" and its friends at the plumbing level showed the
   "diff --git" header and nothing else for a path whose cached stat
   info is dirty without actual difference when asked to produce a
   patch. This was a longstanding bug that we could have fixed long
   time ago.
   (merge b3f01ff jc/maint-diff-patch-header later to maint).

 * The code to synthesize the fake ancestor tree used by 3-way merge
   fallback in "git am" was not prepared to read a patch created with
   a non-standard -p<num> value.
   (merge a61ba26 jc/am-3-nonstandard-popt later to maint).

 * "gitweb" used to drop warnings in the log file when "heads" view is
   accessed in a repository whose HEAD does not point at a valid
   branch.
