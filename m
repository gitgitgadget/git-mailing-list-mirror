From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git 1.7.9
Date: Fri, 27 Jan 2012 13:31:09 -0800
Message-ID: <7vipjwzvc2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
To: git@vger.kernel.org
X-From: linux-kernel-owner@vger.kernel.org Fri Jan 27 22:31:25 2012
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1RqtOH-0001Bd-3g
	for glk-linux-kernel-3@lo.gmane.org; Fri, 27 Jan 2012 22:31:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753696Ab2A0VbQ (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Fri, 27 Jan 2012 16:31:16 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37541 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751936Ab2A0VbN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2012 16:31:13 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 883286D8C;
	Fri, 27 Jan 2012 16:31:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:cc:date:message-id:mime-version:content-type; s=sasl;
	 bh=EzjLmRynLxfZkjKjO0qG8BCTqCM=; b=WqMDuOfxTyWUodJC4DP3sqluWwZS
	4QlY6ig3wAht98shs4QOYDUvDkgyuJ8WcKtkYF1L6e7qON0HoID3YO0HZkWwTDlb
	5N9qTX7pZzgNG6V4LCpsVgP5w8BM9GqX/aPfyOS79rC0z0MeRrzbFb3p2oFaUFqe
	NhUlVj4jDolnPvk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:cc:date:message-id:mime-version:content-type; q=dns; s=sasl; b=
	MUz1OmEoxaT9Vnhq6pFYJ6T5bQyzpyvnP+lFvlXwPMaG4ibULp+mie2JZB3O+Mkr
	1p/+BvKGUXf5kejW6FsVRkrZMTme7V14nfzks+cbq6GjuZBEQh+aqqXC5yy1hl8V
	yS4HLPIhxvocHzetEwMKMaX7x7blyzuRd1qIHDN8MgY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7F3796D8B;
	Fri, 27 Jan 2012 16:31:12 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 570EB6D8A; Fri, 27 Jan 2012
 16:31:11 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3B845752-492E-11E1-B255-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189234>

The latest feature release Git 1.7.9 is now available at the usual
places.

The release tarballs are found at:

    http://code.google.com/p/git-core/downloads/list

and their SHA-1 checksums are:

ed51ef5ef250daaa6e98515cf2641820cd268d4c  git-1.7.9.tar.gz
c7b1fa20dc501beb2cb5091dd24dbfd2a0013a0c  git-htmldocs-1.7.9.tar.gz
1ca1fc430b2814f9e9cf82ec3bf7f2eaf5209b7a  git-manpages-1.7.9.tar.gz

Also the following public repositories all have a copy of the v1.7.9
tag and the master branch that the tag points at:

  url = git://repo.or.cz/alt-git.git
  url = https://code.google.com/p/git-core/
  url = git://git.sourceforge.jp/gitroot/git-core/git.git
  url = git://git-core.git.sourceforge.net/gitroot/git-core/git-core
  url = https://github.com/gitster/git

Have fun.


Git v1.7.9 Release Notes
========================

Updates since v1.7.8
--------------------

 * gitk updates accumulated since early 2011.

 * git-gui updated to 0.16.0.

 * git-p4 (in contrib/) updates.

 * Git uses gettext to translate its most common interface messages
   into the user's language if translations are available and the
   locale is appropriately set. Distributors can drop new PO files
   in po/ to add new translations.

 * The code to handle username/password for HTTP transactions used in
   "git push" & "git fetch" learned to talk "credential API" to
   external programs to cache or store them, to allow integration with
   platform native keychain mechanisms.

 * The input prompts in the terminal use our own getpass() replacement
   when possible. HTTP transactions used to ask for the username without
   echoing back what was typed, but with this change you will see it as
   you type.

 * The internals of "revert/cherry-pick" have been tweaked to prepare
   building more generic "sequencer" on top of the implementation that
   drives them.

 * "git rev-parse FETCH_HEAD" after "git fetch" without specifying
   what to fetch from the command line will now show the commit that
   would be merged if the command were "git pull".

 * "git add" learned to stream large files directly into a packfile
   instead of writing them into individual loose object files.

 * "git checkout -B <current branch> <elsewhere>" is a more intuitive
   way to spell "git reset --keep <elsewhere>".

 * "git checkout" and "git merge" learned "--no-overwrite-ignore" option
   to tell Git that untracked and ignored files are not expendable.

 * "git commit --amend" learned "--no-edit" option to say that the
   user is amending the tree being recorded, without updating the
   commit log message.

 * "git commit" and "git reset" re-learned the optimization to prime
   the cache-tree information in the index, which makes it faster to
   write a tree object out after the index entries are updated.

 * "git commit" detects and rejects an attempt to stuff NUL byte in
   the commit log message.

 * "git commit" learned "-S" to GPG-sign the commit; this can be shown
   with the "--show-signature" option to "git log".

 * fsck and prune are relatively lengthy operations that still go
   silent while making the end-user wait. They learned to give progress
   output like other slow operations.

 * The set of built-in function-header patterns for various languages
   knows MATLAB.

 * "git log --format='<format>'" learned new %g[nNeE] specifiers to
   show information from the reflog entries when walking the reflog
   (i.e. with "-g").

 * "git pull" can be used to fetch and merge an annotated/signed tag,
   instead of the tip of a topic branch. The GPG signature from the
   signed tag is recorded in the resulting merge commit for later
   auditing.

 * "git log" learned "--show-signature" option to show the signed tag
   that was merged that is embedded in the merge commit. It also can
   show the signature made on the commit with "git commit -S".

 * "git branch --edit-description" can be used to add descriptive text
   to explain what a topic branch is about.

 * "git fmt-merge-msg" learned to take the branch description into
   account when preparing a merge summary that "git merge" records
   when merging a local branch.

 * "git request-pull" has been updated to convey more information
   useful for integrators to decide if a topic is worth merging and
   what is pulled is indeed what the requestor asked to pull,
   including:

   - the tip of the branch being requested to be merged;
   - the branch description describing what the topic is about;
   - the contents of the annotated tag, when requesting to pull a tag.

 * "git pull" learned to notice 'pull.rebase' configuration variable,
   which serves as a global fallback for setting 'branch.<name>.rebase'
   configuration variable per branch.

 * "git tag" learned "--cleanup" option to control how the whitespaces
   and empty lines in tag message are cleaned up.

 * "gitweb" learned to show side-by-side diff.

Also contains minor documentation updates and code clean-ups.


Fixes since v1.7.8
------------------

Unless otherwise noted, all the fixes since v1.7.8 in the maintenance
releases are contained in this release (see release notes to them for
details).
