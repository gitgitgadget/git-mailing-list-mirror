From: Junio C Hamano <junio@pobox.com>
Subject: Incremental updates to "What's cooking"
Date: Thu, 19 Apr 2012 22:52:31 -0700
Message-ID: <7vzka7osps.fsf@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 20 07:53:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SL6mF-0003Bx-Rq
	for gcvg-git-2@plane.gmane.org; Fri, 20 Apr 2012 07:53:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752495Ab2DTFwm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Apr 2012 01:52:42 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39609 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752483Ab2DTFwg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Apr 2012 01:52:36 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AC30444BF;
	Fri, 20 Apr 2012 01:52:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=L
	phLh0DsXVlCaCTncvxBeJEQlxc=; b=WsLnI8oizcvGIdR/OkpZERpFIDwoahgvY
	NEHU7HDuVQNVkEoAMtHyq5M7ZDg8xAhwWfYp8QG7dQ0A2N6F8o2/H/7TRsusvPcG
	d4C7Ps0f5EmppZPjitrrRJUHWKs2dVg48opluAPr0EMP/xrEglBFflqOX0XmAOQA
	G2PzEWCbpg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=tiJ
	Jbx9ffxd5P1MPnFyCwj2I102TdTfNyUuV4L8xZs6Q0mYEgVKJ9nsQDJdeY3UlX8G
	sFxGAU9MEEddXVsBqDXcOOOen2Vw+oAozHKdYFOSLPMa+mB0l2JLhDLDx6WPWBno
	4OiLvca/w6UfnPvKCKcQZHVJMAruLlmwq9BQ4HsA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A312544BE;
	Fri, 20 Apr 2012 01:52:33 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F2E6D44BC; Fri, 20 Apr 2012
 01:52:32 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
X-Pobox-Relay-ID: 05DB306A-8AAD-11E1-85C0-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195981>

I was planning to have a handful of topics graduate to 'master'
today but there was a bit of accident, and I felt it would be safer
to postpone it for a few days.  Also I expect to be slower than
usual for several days.

Here is an incremental updates to "What's cooking", relative to the
issue #07 that was posted yesterday.

[New Topics]

* bw/test-fix-grep-gnuism (2012-04-19) 1 commit
 - t9400: fix gnuism in grep

Fix two places that were the only place in the test suite that gave "a\+"
to platform grep and expected it to mean one or more "a", which is a
blatant GNUism.

Will merge to 'next'.

* rt/cherry-revert-conflict-summary (2012-04-19) 1 commit
 - sequencer: remove additional blank line

In the older days, the header "Conflicts:" in "cherry-pick" and
"merge" was separated by a blank line from the list of paths that
follow for readability, but when "merge" was rewritten in C, we lost
it by mistake. Remove the newline from "cherry-pick" to make them
match again.

--------------------------------------------------
Moved from [New Topics] to [Cooking]

* js/spawn-via-shell-path-fix (2012-04-17) 1 commit
  (merged to 'next' on 2012-04-19 at 3e04ef6)
 + Do not use SHELL_PATH from build system in prepare_shell_cmd on Windows

Merged to 'next' to fast-track the fix for Windows.

* jc/merge-reduce-parents-early (2012-04-18) 5 commits
 - fmt-merge-msg: discard needless merge parents
 - builtin/merge.c: reduce parents early
 - builtin/merge.c: collect other parents early
 - builtin/merge.c: remove "remoteheads" global variable
 - merge tests: octopus with redundant parents
 (this branch is tangled with lt/octopus-simplify.)

I based this and Linus's on top of the same test script, but it
turns out that this is more correct way to deal with the issue, so
I'll drop the other one.

[Cooking]

* cb/daemon-test-race-fix (2012-04-19) 1 commit
 - git-daemon wrapper to wait until daemon is ready

Fix race condition between starting and waiting for git-daemon in the
test.

Re-queued with a fix.

* nl/http-proxy-more (2012-04-19) 7 commits
 - http: fix proxy password passing
 - http: fix proxy authentication
 - http: rename HTTP_REAUTH to HTTP_AUTH_RETRY
 - http: Avoid limit of retrying request only twice
 - http: handle proxy authentication failure (error 407)
 - http: handle proxy proactive authentication
 - http: try http_proxy env var when http.proxy config option is not set
 
Another microfix.  It is starting to look like this may have to be
moved to Stalled.

* nh/empty-rebase (2012-04-19) 5 commits
 - fixup! git-rebase: add keep_empty flag
 - git-rebase: add keep_empty flag
 - git-cherry-pick: add test to validate new options
 - git-cherry-pick: add "--keep-redundant-commits" option
 - git-cherry-pick: add allow-empty option

Added a fix-up.

* nd/threaded-index-pack (2012-04-19) 4 commits
 - index-pack: disable threading if NO_PREAD is defined
 - index-pack: support multithreaded delta resolving
 - index-pack: split second pass obj handling into own function
 - compat/win32/pthread.h: Add an pthread_key_delete() implementation

Added a fix-up.

 * jc/index-v4 (2012-04-04) 10 commits
+  (merged to 'next' on 2012-04-19 at 5e4b029)
+ + update-index: upgrade/downgrade on-disk index version
+ + read-cache.c: write prefix-compressed names in the index
+ + read-cache.c: read prefix-compressed names in index on-disk version v4
+ + read-cache.c: move code to copy incore to ondisk cache to a helper function
+ + read-cache.c: move code to copy ondisk to incore cache to a helper function
+ + read-cache.c: report the header version we do not understand
+ + read-cache.c: make create_from_disk() report number of bytes it consumed
+ + read-cache.c: allow unaligned mapping of the index file
+ + cache.h: hide on-disk index details
+ + varint: make it available outside the context of pack
  (this branch is tangled with jc/split-blob.)
 
Trivially shrinks the on-disk size of the index file to save both I/O and
checksum overhead.  The "v4" format represented here may not be what we
eventually want to have, but the preparatory refactoring steps and the way
how backward compatibility is retained should give plenty to learn to GSoC
student-hopefuls.
 
The bottom one makes use of "varint" encoding from the stalled
jc/split-blob topic.  Merged to 'next' as warned.
