From: Junio C Hamano <gitster@pobox.com>
Subject: git.git as of tonight
Date: Sun, 01 Nov 2015 18:58:51 -0800
Message-ID: <xmqqpoztf6ok.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 02 03:59:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zt5Kl-0008FM-MD
	for gcvg-git-2@plane.gmane.org; Mon, 02 Nov 2015 03:59:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751460AbbKBC6z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Nov 2015 21:58:55 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:59046 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750935AbbKBC6y (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Nov 2015 21:58:54 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 67EA528BD4;
	Sun,  1 Nov 2015 21:58:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=t
	7joxY83gmNkyCRhhG/TA0v20kw=; b=pUQDyh5yjmenYzaQfZDOQeHWrsoejFzIy
	bKGof11IAR891kY8IiLmSE7Cm7/pu00uSaLv3m8wC+hPrFsL3w0/Mp8gjSpnyuAQ
	RGWZ6/RqMZlnN4v0TjmsJNxuzUNDUk6+5kFXbg2YUJ6KtD5yOFBR1yUhzdX0muh5
	eTVu+F30Gs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=LA3
	oJomVoDMI+7t2dNr9fRqMfwuNKXmh/fwkSEIgDzBmgWfumqY7xvaMkvjUDF7QFJq
	VMURD4CPXzhbAkx3KwN6p6dUB5bg2P97yznvkOSTuyJqXD3XwWOggE3tfbsZeryO
	iWSkz06SlmN0Zsb0vtRiYNn3L8Q9vFneoFSr0OiQ=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5FC4228BD3;
	Sun,  1 Nov 2015 21:58:53 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id DE11228BD1;
	Sun,  1 Nov 2015 21:58:52 -0500 (EST)
X-master-at: 2635c2b8bfc9aec07b7f023d8e3b3d02df715344
X-next-at: 3dda608c19069845846bd7fd57000a99f97b9c9d
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A64C8850-810D-11E5-AA85-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280678>

I've merged a handful of topics to 'next', and hoping that many of
them can be merged to 'master' before I'll go offline for a few
weeks starting on the week #7 of the cycle (starting Nov 9th).

As I hate sending out the whole text back to back (the last one was
issued on the last Friday), here is an abbreviated update for the
"What's cooking" report, highlighting those topics that I want to
see in 'master' by the end of the week #6 (Nov 8th).

Thanks.


* kn/for-each-branch (2015-10-30) 1 commit
  (merged to 'next' on 2015-11-01 at 4249dc9)
 + ref-filter: fallback on alphabetical comparison

 Using the timestamp based criteria in "git branch --sort" did not
 tiebreak branches that point at commits with the same timestamp (or
 the same commit), making the resulting output unstable.

 Will merge to 'master'.


* jc/mailinfo-lib (2015-11-01) 1 commit
  (merged to 'next' on 2015-11-01 at 3ecaa28)
 + mailinfo: fix passing wrong address to git_mailinfo_config

 Hotfix for a topic already in 'master'.

 Will merge to 'master'.


* sb/submodule-parallel-fetch (2015-10-21) 14 commits
  (merged to 'next' on 2015-10-23 at 8f04bbd)
 + run-command: fix missing output from late callbacks
 + test-run-command: increase test coverage
 + test-run-command: test for gracefully aborting
 + run-command: initialize the shutdown flag
 + run-command: clear leftover state from child_process structure
 + run-command: fix early shutdown
  (merged to 'next' on 2015-10-15 at df63590)
 + submodules: allow parallel fetching, add tests and documentation
 + fetch_populated_submodules: use new parallel job processing
 + run-command: add an asynchronous parallel child processor
 + sigchain: add command to pop all common signals
 + strbuf: add strbuf_read_once to read without blocking
 + xread_nonblock: add functionality to read from fds without blocking
 + xread: poll on non blocking fds
 + submodule.c: write "Fetching submodule <foo>" to stderr
 (this branch is used by rs/daemon-leak-fix and sb/submodule-parallel-update.)

 Add a framework to spawn a group of processes in parallel, and use
 it to run "git fetch --recurse-submodules" in parallel.

 Will merge to 'master'.


* rs/daemon-leak-fix (2015-10-31) 3 commits
  (merged to 'next' on 2015-11-01 at 9b6c8f9)
 + daemon: plug memory leak
 + run-command: export child_process_clear()
 + run-command: name the cleanup function child_process_clear()
 (this branch is used by sb/submodule-parallel-update; uses sb/submodule-parallel-fetch.)

 "git daemon" uses "run_command()" without "finish_command()", so it
 needs to release resources itself, which it forgot to do.

 Will merge to 'master'.


* rs/wt-status-detached-branch-fix (2015-11-01) 5 commits
  (merged to 'next' on 2015-11-01 at cb23615)
 + wt-status: use skip_prefix() to get rid of magic string length constants
 + wt-status: don't skip a magical number of characters blindly
 + wt-status: avoid building bogus branch name with detached HEAD
 + wt-status: exit early using goto in wt_shortstatus_print_tracking()
 + t7060: add test for status --branch on a detached HEAD

 "git status --branch --short" accessed beyond the constant string
 "HEAD", which has been corrected.

 Will merge to 'master'.


* da/difftool (2015-10-29) 1 commit
  (merged to 'next' on 2015-11-01 at 4e5ab33)
 + difftool: ignore symbolic links in use_wt_file

 The code to prepare the working tree side of temporary directory
 for the "dir-diff" feature forgot that symbolic links need not be
 copied (or symlinked) to the temporary area, as the code already
 special cases and overwrites them.  Besides, it was wrong to try
 computing the object name of the target of symbolic link, which may
 not even exist or may be a directory.

 Will merge to 'master'.


* jk/initialization-fix-to-add-submodule-odb (2015-10-28) 1 commit
  (merged to 'next' on 2015-11-01 at da94b97)
 + add_submodule_odb: initialize alt_odb list earlier

 We peek objects from submodule's object store by linking it to the
 list of alternate object databases, but the code to do so forgot to
 correctly initialize the list.

 Will merge to 'master'.
