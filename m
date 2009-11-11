From: Junio C Hamano <junio@pobox.com>
Subject: excerpts from tomorrow's "What's cooking" draft
Date: Wed, 11 Nov 2009 01:34:07 -0800
Message-ID: <7vbpj9s8vk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 11 17:27:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8G25-0004wc-Qi
	for gcvg-git-2@lo.gmane.org; Wed, 11 Nov 2009 17:26:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752260AbZKKQ0r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Nov 2009 11:26:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755266AbZKKQ0q
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Nov 2009 11:26:46 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:59625 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754755AbZKKQ0p (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Nov 2009 11:26:45 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E4BD49A3A5;
	Wed, 11 Nov 2009 11:26:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:subject
	:from:date:message-id:mime-version:content-type; s=sasl; bh=jbfR
	KcTm9x5K2kJfeL6o3sMChUA=; b=VWr96qjeT+FmaAJfBUZN/XdkAoEUgJEgdA+6
	LFhRn89cnCO8YGGArJ8y5yBn7S5NxLgdQO5mB+BFlaZFueUHbor6NalAIc56BEC1
	FDrKV5p4cnOVWZyq3RM0OsT9cVNLvWaEdYrYuxc2APuyooWf0eM8orYsFKXptGfT
	qW7rOsY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:subject:from
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=ijN
	WNjbOCQNwQN1dltRTW9fDmJcR4ZcS9frOLMqgKJJddT2mngdSIZzmllIDEuQ0zAp
	n1keTcJa/y9V6D+VIGH+HuCwOp73L7ibYK6p2wtWpPSjtvIg4cg6IVWuAhcjNZbk
	4zEt10TOwI2jKkxaS3GxxNPihipk2k/4bh99SgLA=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D33939A397;
	Wed, 11 Nov 2009 11:26:48 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 0AEA69BCB5; Wed, 11 Nov 2009
 04:34:09 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 02D4B224-CEDF-11DE-BA0E-B888BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132668>

I'll do the full-list at the end of my git Wednesday, but here are the
current highlights I am sending out to hear opinions from people.

Please note that I haven't caught up with the patches from past 12 hours
or so.

----------------------------------------------------------------

[New Topics]

* jn/help-everywhere (2009-11-09) 21 commits
 - diff --no-index: make the usage string less scary
 - ...
 - Show usage string for 'git grep -h'
 (this branch uses jn/maint-http-fetch-mingw and jn/remove-fetch--tool.)

There were unrelated but still worthy fixes, so I reordered some of them;
also the "usage()" change is different from the one that was posted (see
my comment in $gmane/132592).

* jn/maint-http-fetch-mingw (2009-11-09) 1 commit.
 - http-fetch: add missing initialization of argv0_path
 (this branch is used by jn/help-everywhere.)

* jn/remove-fetch--tool (2009-11-09) 1 commit
 - Retire fetch--tool helper to contrib/examples
 (this branch is used by jn/help-everywhere.)

These two were originally part of the "help-everywhere" topic but
they can stand on their own.

* jc/log-stdin (2009-11-03) 1 commit
 - Teach --stdin option to "log" family

This is not signed-off (see $gmane/131971 for list of things you can do to
help advancing this topic).

--------------------------------------------------
[Stalled]

* sc/protocol-doc (2009-10-29) 1 commit
 - Update packfile transfer protocol documentation

* jl/submodule-add-noname (2009-09-22) 1 commit.
 - git submodule add: make the <path> parameter optional

Dscho started an interesting discussion regarding the larger workflow in
which the "submodule add" is used.  I think the patch itself makes sense
but at the same time it probably makes sense to also take the <path> and
infer the <repository> as Dscho suggested, probably in "git submodule
add", not in "git add" proper, at least initially.

Any objections against merging this to 'next'?

* jc/fix-tree-walk (2009-10-22) 11 commits.
  (merged to 'next' on 2009-10-22 at 10c0c8f)
 + Revert failed attempt since 353c5ee
 + read-tree --debug-unpack
  (merged to 'next' on 2009-10-11 at 0b058e2)
 + ...
 + diff-lib.c: fix misleading comments on oneway_diff()

This has some stupid bugs and temporarily reverted from 'next' until I can
fix it, but the "temporarily" turned out to be very loooong.  Sigh...

* jh/notes (2009-10-09) 22 commits.
 - fast-import: Proper notes tree manipulation using the notes API
 - ...
 - Notes API: get_commit_notes() -> format_note() + remove the commit restriction
  (merged to 'next' on 2009-11-01 at 948327a)
 + Add selftests verifying concatenation of multiple notes for the same commit
 + ...
 + Introduce commit notes

I somehow thought that the later API part was waiting for updates but
nothing seems to be happening.

* jn/gitweb-blame (2009-09-01) 5 commits.
 - gitweb: Minify gitweb.js if JSMIN is defined
 - gitweb: Create links leading to 'blame_incremental' using JavaScript
  (merged to 'next' on 2009-10-11 at 73c4a83)
 + gitweb: Colorize 'blame_incremental' view during processing
 + ...

Ajax-y blame.  Any progress or RFH?

* sr/gfi-options (2009-09-06) 6 commits.
 - fast-import: test the new option command
 - ...
 - fast-import: put option parsing code in separate functions

It seemed to be moving again soon, but nothing has happened yet...

* je/send-email-no-subject (2009-08-05) 1 commit.
  (merged to 'next' on 2009-10-11 at 1b99c56)
 + send-email: confirm on empty mail subjects

The existing tests cover the positive case (i.e. as long as the user says
"yes" to the "do you really want to send this message that lacks subject",
the message is sent) of this feature, but the feature itself needs its own
test to verify the negative case (i.e. does it correctly stop if the user
says "no"?)

--------------------------------------------------
[Cooking]

* bw/autoconf-more (2009-11-04) 2 commits
 - configure: add settings for gitconfig, editor and pager
 - configure: add macro to set arbitrary make variables

Looked sensible.  Any comments?

* bg/format-patch-doc-update (2009-11-07) 4 commits
 - format-patch: Add "--no-stat" as a synonym for "-p"
 - format-patch documentation: Fix formatting
 - format-patch documentation: Remove diff options that are not useful
 - format-patch: Always generate a patch

Looked sensible, even though this may want to wait for 1.7.0.  We'll see
when we merge this to 'next'.

* rj/maint-simplify-cygwin-makefile (2009-10-27) 1 commit.
 - Makefile: merge two Cygwin configuration sections into one
 (this branch is used by rj/cygwin-msvc.)

This is one of the most obviously correct bit from "Compiling on Cygwin
using MSVC fails" topic.

* rj/cygwin-msvc (2009-11-09) 3 commits.
 - Add explicit Cygwin check to guard WIN32 header inclusion
 - MSVC: Add support for building with NO_MMAP
 - Makefile: keep MSVC and Cygwin configuration separate
 (this branch uses rj/maint-simplify-cygwin-makefile.)

I think J6t was not happy with the tip one.

* cc/bisect-doc (2009-11-08) 1 commit
 - Documentation: add "Fighting regressions with git bisect" article

Any comments?  Should it go to Documentation/technical instead?

* jn/editor-pager (2009-10-30) 8 commits
 - Provide a build time default-pager setting
 - Provide a build time default-editor setting
 - am -i, git-svn: use "git var GIT_PAGER"
 - add -i, send-email, svn, p4, etc: use "git var GIT_EDITOR"
 - Teach git var about GIT_PAGER
 - Teach git var about GIT_EDITOR
 - Do not use VISUAL editor on dumb terminals
 - Handle more shell metacharacters in editor names

Any comments?

* sc/difftool-p4merge (2009-10-28) 1 commit
  (merged to 'next' on 2009-10-31 at 194b5c5)
 + mergetool--lib: add p4merge as a pre-configured mergetool option

I do not do p4 nor use difftool, so it's much easier for me to merge this
to 'master' and wait for anybody to scream if there is breakage.  I'll do
so, unless I hear objections in a few days.

* sr/vcs-helper (2009-11-06) 12 commits
 - Add Python support library for remote helpers
 - ...
 - Fix memory leak in helper method for disconnect

Re-rolled series that contains Daniel's and Johan's.
Any comments?  Is everybody happy?

* fc/doc-fast-forward (2009-10-24) 1 commit.
  (merged to 'next' on 2009-11-01 at faaad90)
 + Use 'fast-forward' all over the place

Soon in 'master'; carrying this in 'next' for too long is turning out to
be quite painful.

* ks/precompute-completion (2009-10-26) 3 commits.
  (merged to 'next' on 2009-10-28 at cd5177f)
 + completion: ignore custom merge strategies when pre-generating
  (merged to 'next' on 2009-10-22 at f46a28a)
 + bug: precomputed completion includes scripts sources
  (merged to 'next' on 2009-10-14 at adf722a)
 + Speedup bash completion loading

What's the status of this thing?  Last time I polled the list I had an
impression that it was not quite ready...

* sp/smart-http (2009-11-09) 34 commits
 - t5551-http-fetch: Work around broken Accept header in libcurl
 - t5551-http-fetch: Work around some libcurl versions
 - http-backend: Protect GIT_PROJECT_ROOT from /../ requests
 - Git-aware CGI to provide dumb HTTP transport
  (merged to 'next' on 2009-11-06 at 666837c)
 + http-backend: Test configuration options
 + ...
 + http-push: fix check condition on http.c::finish_http_pack_request()

The tip ones are workarounds to the issues identified by somebody without
a real name (I do not remember---I am bad at people's names even when they
are real).

* ef/msys-imap (2009-10-22) 9 commits.
  (merged to 'next' on 2009-10-31 at 8630603)
 + Windows: use BLK_SHA1 again
 + MSVC: Enable OpenSSL, and translate -lcrypto
 + mingw: enable OpenSSL
 + mingw: wrap SSL_set_(w|r)fd to call _get_osfhandle
 + imap-send: build imap-send on Windows
 + imap-send: fix compilation-error on Windows
 + imap-send: use run-command API for tunneling
 + imap-send: use separate read and write fds
 + imap-send: remove useless uid code

Soon in 'master', unless I hear objections from msys folks or imap-send
users.

* nd/sparse (2009-08-20) 19 commits.
 - sparse checkout: inhibit empty worktree
 - ...
 - update-index: refactor mark_valid() in preparation for new options

The latest update I didn't look at very closely but I had an impression
that it was touching very generic codepath that would affect non sparse
cases, iow the patch looked very scary (the entire series already is).
