From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git 1.7.10.1
Date: Tue, 01 May 2012 22:12:46 -0700
Message-ID: <7vk40vjhdd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 02 07:13:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPRsL-00088H-Og
	for gcvg-git-2@plane.gmane.org; Wed, 02 May 2012 07:13:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758559Ab2EBFMw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 May 2012 01:12:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63301 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756312Ab2EBFMt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 May 2012 01:12:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7922D8CCE;
	Wed,  2 May 2012 01:12:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:cc:date:message-id:mime-version:content-type; s=sasl;
	 bh=PwoZNOmfIJTRpf+mtCb0Z5VKap0=; b=x9Fu/GUUJq8clh7ASyzHRKkNDvy5
	fTgpwCG7j73xWc62QqlDfFJQZlf5XVQCB9VURUqnFcgc0zm0eZkNqHydBejdDEad
	/DIlUS9PMMmLeNKbTx7qjNxwyUTi2aNgvI/mNbRgNe+f1FkaBvjaLi7vSyjAYyoq
	fadthVyJJZ05Pj0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:cc:date:message-id:mime-version:content-type; q=dns; s=sasl; b=
	jivpGtkPNCRjDLli3O/TLcNgZizGDFgwaXMQQ7ISmnyysiYvat9bfPNXQrlYFxBO
	28+5l6x9Vw4G5uVv6ZOWiH5hzIIa05C82GpQS5mWJ+081Jax9mxIhBFw6C6iM63+
	2JQLVcmoldQ890idBPtvMIt6PR1sGCgIu6dkX/JKcvs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6F2578CCD;
	Wed,  2 May 2012 01:12:48 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CA4B78CCC; Wed,  2 May 2012
 01:12:47 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7524A7D2-9415-11E1-9FCE-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196784>

The latest maintenance release Git 1.7.10.1 is now available at
the usual places.

The release tarballs are found at:

    http://code.google.com/p/git-core/downloads/list

and their SHA-1 checksums are:

870361f93fad7999f121bc7bc91a743feda68bdb  git-1.7.10.1.tar.gz
29b79312482f9aaf92ee3d970caee5ed8ab96bba  git-htmldocs-1.7.10.1.tar.gz
5bff761bc40a6b3cfe35ba824357dcf611dbd5d2  git-manpages-1.7.10.1.tar.gz

Also the following public repositories all have a copy of the v1.7.10.1
tag and the maint branch that the tag points at:

  url = git://repo.or.cz/alt-git.git
  url = https://code.google.com/p/git-core/
  url = git://git.sourceforge.jp/gitroot/git-core/git.git
  url = git://git-core.git.sourceforge.net/gitroot/git-core/git-core
  url = https://github.com/gitster/git

Git v1.7.10.1 Release Notes
===========================

Additions since v1.7.10
-----------------------

Localization message files for Danish and German have been added.


Fixes since v1.7.10
-------------------

 * "git add -p" is not designed to deal with unmerged paths but did
   not exclude them and tried to apply funny patches only to fail.

 * "git blame" started missing quite a few changes from the origin
   since we stopped using the diff minimalization by default in v1.7.2
   era.

 * When PATH contains an unreadable directory, alias expansion code
   did not kick in, and failed with an error that said "git-subcmd"
   was not found.

 * "git clean -d -f" (not "-d -f -f") is supposed to protect nested
   working trees of independent git repositories that exist in the
   current project working tree from getting removed, but the
   protection applied only to such working trees that are at the
   top-level of the current project by mistake.

 * "git commit --author=$name" did not tell the name that was being
   recorded in the resulting commit to hooks, even though it does do
   so when the end user overrode the authorship via the
   "GIT_AUTHOR_NAME" environment variable.

 * When "git commit --template F" errors out because the user did not
   touch the message, it claimed that it aborts due to "empty
   message", which was utterly wrong.

 * The regexp configured with diff.wordregex was incorrectly reused
   across files.

 * An age-old corner case bug in combine diff (only triggered with -U0
   and the hunk at the beginning of the file needs to be shown) has
   been fixed.

 * Rename detection logic used to match two empty files as renames
   during merge-recursive, leading to unnatural mismerges.

 * The parser in "fast-import" did not diagnose ":9" style references
   that is not followed by required SP/LF as an error.

 * When "git fetch" encounters repositories with too many references,
   the command line of "fetch-pack" that is run by a helper
   e.g. remote-curl, may fail to hold all of them. Now such an
   internal invocation can feed the references through the standard
   input of "fetch-pack".

 * "git fetch" that recurses into submodules on demand did not check
   if it needs to go into submodules when non branches (most notably,
   tags) are fetched.

 * "log -p --graph" used with "--stat" had a few formatting error.

 * Running "notes merge --commit" failed to perform correctly when run
   from any directory inside $GIT_DIR/.  When "notes merge" stops with
   conflicts, $GIT_DIR/NOTES_MERGE_WORKTREE is the place a user edits
   to resolve it.

 * The 'push to upstream' implementation was broken in some corner
   cases. "git push $there" without refspec, when the current branch
   is set to push to a remote different from $there, used to push to
   $there using the upstream information to a remote unreleated to
   $there.

 * Giving "--continue" to a conflicted "rebase -i" session skipped a
   commit that only results in changes to submodules.

Also contains minor fixes and documentation updates.
