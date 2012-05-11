From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git 1.7.10.2
Date: Fri, 11 May 2012 13:49:38 -0700
Message-ID: <7v4nrml9y5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 11 22:50:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSwms-0005pk-MJ
	for gcvg-git-2@plane.gmane.org; Fri, 11 May 2012 22:50:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758926Ab2EKUtn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 May 2012 16:49:43 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48289 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753457Ab2EKUtm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 May 2012 16:49:42 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 995497753;
	Fri, 11 May 2012 16:49:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:cc:date:message-id:mime-version:content-type; s=sasl;
	 bh=awGaE6WAZNytc1PwhZoEdjHcODE=; b=Ojm0OP7gz++F4CFTKCE1UD4Hp8RR
	HY5g0rAAFqFKjWxzdAbQNq8lP40M5C6FgrIKH+lXHbSMVSX4oN235795Tpe7TkOy
	WEkAIRlMD76LdSev+sZDdfKlIY4mk/ekZk3VbY618VdORgVhQbls0JSgnAM7EJR7
	ps6kFI6+qFqfpxY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:cc:date:message-id:mime-version:content-type; q=dns; s=sasl; b=
	ehoVLjyp+OVpeWJag6scbF3BY9sGcpEsvCjKmlsgteIpntMxEHCIfVpfVTYVVMdz
	wOkUfrRiD6TisKRCIhTBpzcE1FHE6q9yJNA8NDHuSh5OxLCDcAk//PopgQJc8UWj
	N/bVR7inydwTTofHmwlqXgurUNaobUvPoFKkAFtGPbw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 90C797752;
	Fri, 11 May 2012 16:49:41 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EFB347751; Fri, 11 May 2012
 16:49:40 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D482FCBE-9BAA-11E1-811F-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197696>

The latest maintenance release Git 1.7.10.2 is now available at
the usual places.

The release tarballs are found at:

    http://code.google.com/p/git-core/downloads/list

and their SHA-1 checksums are:

e4b7f746ff4e356baaddcad0b2911376efde031b  git-1.7.10.2.tar.gz
004a2bf989b935657e2e1e6000a748d83657649f  git-htmldocs-1.7.10.2.tar.gz
6cc3f80185bdd1a608cf373b05313b2adc82b898  git-manpages-1.7.10.2.tar.gz

Also the following public repositories all have a copy of the v1.7.10.2
tag and the maint branch that the tag points at:

  url = git://repo.or.cz/alt-git.git
  url = https://code.google.com/p/git-core/
  url = git://git.sourceforge.jp/gitroot/git-core/git.git
  url = git://git-core.git.sourceforge.net/gitroot/git-core/git-core
  url = https://github.com/gitster/git

Git v1.7.10.2 Release Notes
===========================

Fixes since v1.7.10.1
---------------------

 * The test scaffolding for git-daemon was flaky.

 * The test scaffolding for fast-import was flaky.

 * The filesystem boundary was not correctly reported when .git directory
   discovery stopped at a mount point.

 * HTTP transport that requires authentication did not work correctly when
   multiple connections are used simultaneously.

 * Minor memory leak during unpack_trees (hence "merge" and "checkout"
   to check out another branch) has been plugged.

 * In the older days, the header "Conflicts:" in "cherry-pick" and "merge"
   was separated by a blank line from the list of paths that follow for
   readability, but when "merge" was rewritten in C, we lost it by
   mistake. Remove the newline from "cherry-pick" to make them match
   again.

 * The command line parser choked "git cherry-pick $name" when $name can
   be both revision name and a pathname, even though $name can never be a
   path in the context of the command.

 * The "include.path" facility in the configuration mechanism added in
   1.7.10 forgot to interpret "~/path" and "~user/path" as it should.

 * "git config --rename-section" to rename an existing section into a
   bogus one did not check the new name.

 * The "diff --no-index" codepath used limited-length buffers, risking
   pathnames getting truncated.  Update it to use the strbuf API.

 * The report from "git fetch" said "new branch" even for a non branch
   ref.

 * The http-backend (the server side of the smart http transfer) used
   to overwrite GIT_COMMITTER_NAME and GIT_COMMITTER_EMAIL with the
   value obtained from REMOTE_USER unconditionally, making it
   impossible for the server side site-specific customization to use
   different identity sources to affect the names logged. It now uses
   REMOTE_USER only as a fallback value.

 * "log --graph" was not very friendly with "--stat" option and its
   output had line breaks at wrong places.

 * Octopus merge strategy did not reduce heads that are recorded in the
   final commit correctly.

 * "git push" over smart-http lost progress output a few releases ago;
   this release resurrects it.

 * The error and advice messages given by "git push" when it fails due
   to non-ff were not very helpful to new users; it has been broken
   into three cases, and each is given a separate advice message.

 * The insn sheet given by "rebase -i" did not make it clear that the
   insn lines can be re-ordered to affect the order of the commits in
   the resulting history.

 * "git repack" used to write out unreachable objects as loose objects
   when repacking, even if such loose objects will immediately pruned
   due to its age.

 * A contrib script "rerere-train" did not work out of the box unless
   user futzed with her $PATH.

 * "git rev-parse --show-prefix" used to emit nothing when run at the
   top-level of the working tree, but now it gives a blank line.

 * The i18n of error message "git stash save" was not properly done.

 * "git submodule" used a sed script that some platforms mishandled.

 * When using a Perl script on a system where "perl" found on user's
   $PATH could be ancient or otherwise broken, we allow builders to
   specify the path to a good copy of Perl with $PERL_PATH.  The
   gitweb test forgot to use that Perl when running its test.

Also contains minor fixes and documentation updates.
