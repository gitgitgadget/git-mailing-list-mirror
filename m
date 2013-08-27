From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Aug 2013, #06; Tue, 27)
Date: Tue, 27 Aug 2013 14:51:06 -0700
Message-ID: <xmqqtxiaajlh.fsf@gitster.dls.corp.google.com>
References: <xmqqsixvaqh5.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 27 23:51:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VERAS-0008PC-13
	for gcvg-git-2@plane.gmane.org; Tue, 27 Aug 2013 23:51:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753667Ab3H0VvL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Aug 2013 17:51:11 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38297 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751652Ab3H0VvK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Aug 2013 17:51:10 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B6CFB3CC33;
	Tue, 27 Aug 2013 21:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MqUpCGm+s+zr2zDSnFxsrzd8gSY=; b=P2EVR1
	4JTbLVjmtQlxcrDz9zpUNcj8SlRTClKtaLUIphz1qNUU65/WcWfTGYe/9QJGiEUe
	MEPeuf5BxLct+XZcgQ7SwHio7G7NGbuDN2efLE+06I0MgIf6KIqKmK3fu/4MVrkX
	6N/mBAP6QELazoiSFJAcezeYmtCqau96GPS+k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hOXsWYpDMDrAb/V7CaU903wz73pz3orb
	pc+uy6ERKIXcMTu2DXuHhkFqe1bHE9wSQw567BnBPob/1dW6bWqTqwV4viS9bQ4H
	wPqMoiKQcKWv++5GQCx4hyUzN50jvU8oZI4OvR8HpnhwYzncfjXcEHNOSqlzNw7f
	SF2Ng4rv7Jo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A351F3CC32;
	Tue, 27 Aug 2013 21:51:09 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 996D13CC2E;
	Tue, 27 Aug 2013 21:51:08 +0000 (UTC)
In-Reply-To: <xmqqsixvaqh5.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Tue, 27 Aug 2013 12:22:30 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: C7E892AC-0F62-11E3-BF21-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233166>

Junio C Hamano <gitster@pobox.com> writes:

> What's cooking in git.git (Aug 2013, #06; Tue, 27)
> --------------------------------------------------
>
> Here are the topics that have been cooking.  Commits prefixed with
> '-' are only in 'pu' (proposed updates) while commits prefixed with
> '+' are in 'next'.
>
> Git 1.8.4 was tagged and released recently, and we will shortly go
> into a new development cycle for the next one, likely to be 1.8.5.
>
> In this issue of "What's cooking" report, I haven't started sifting
> the topics, most of which are marked as "will cook in next", into
> separate bins to indicate what order they would graduate yet.  After
> doing so, the tip of 'next' will be rewound, hopefully tomorrow but
> it may slip by a day or so.

I am nominating the following topics to graduate to 'master' by the
end of this week (or in the middle of the next week at the latest).

Those graduating earlier than others are:

 (1) trivially correct and safe;

 (2) of minor impact and even if they are broken, no real harm will
     be done; or

 (3) touch parts of the system that are so important that we would
     want to learn unforseen breakages sooner rather than later in
     the cycle, and we have done sufficient reviews and testing on
     'next' already.

The last category is of particular importance, as we seemed to have
seen a few regression reports _after_ topics that have been cooking
for a long time in 'next' graduated to 'master' during the latest
cycle.  We need to recruit more people from minority platforms and
with various different workflows to test 'next' more, but that will
not happen overnight, so the next best thing we can do is to feed
topics that are reasonably well cooked in 'next' early to 'master'.

* nd/fetch-pack-shallow-fix (2013-08-25) 1 commit
  (merged to 'next' on 2013-08-27 at 7c2a162)
 + fetch-pack: do not remove .git/shallow file when --depth is not specified

 Recent "short-cut clone connectivity check" topic broke a shallow
 repository when a fetch operation tries to auto-follow tags.

 Will merge to 'master', aiming to later apply to 1.8.4.x maintenance track.


* hv/config-from-blob (2013-08-26) 1 commit
  (merged to 'next' on 2013-08-27 at 7bc9019)
 + config: do not use C function names as struct members

 Portability fix.

 Will merge to 'master', aiming to later apply to 1.8.4.x maintenance track.


* rj/doc-rev-parse (2013-07-22) 2 commits
  (merged to 'next' on 2013-07-22 at 8188667)
 + rev-parse(1): logically group options
 + rev-parse: remove restrictions on some options

 Will merge to 'master'.


* mb/docs-favor-en-us (2013-08-01) 1 commit
  (merged to 'next' on 2013-08-06 at 763d868)
 + Provide some linguistic guidance for the documentation.

 Declare that the official grammar & spelling of the source of this
 project is en_US, but strongly discourage patches only to "fix"
 existing en_UK strings to avoid unnecessary churns.

 Will merge to 'master'.


* nd/sq-quote-buf (2013-07-30) 3 commits
  (merged to 'next' on 2013-08-01 at dc7934a)
 + quote: remove sq_quote_print()
 + tar-tree: remove dependency on sq_quote_print()
 + for-each-ref, quote: convert *_quote_print -> *_quote_buf

 Code simplification as a preparatory step to something larger.

 Will merge to 'master'.


* mm/no-shell-escape-in-die-message (2013-08-07) 1 commit
  (merged to 'next' on 2013-08-08 at bddff86)
 + die_with_status: use "printf '%s\n'", not "echo"

 Fixes a minor bug in "git rebase -i" (there could be others, as the
 root cause is pretty generic) where the code feeds a random, data
 dependeant string to 'echo' and expects it to come out literally.

 Will merge to 'master'.


* sb/parseopt-boolean-removal (2013-08-07) 9 commits
  (merged to 'next' on 2013-08-08 at b138a2d)
 + revert: use the OPT_CMDMODE for parsing, reducing code
 + checkout-index: fix negations of even numbers of -n
 + config parsing options: allow one flag multiple times
 + hash-object: replace stdin parsing OPT_BOOLEAN by OPT_COUNTUP
 + branch, commit, name-rev: ease up boolean conditions
 + checkout: remove superfluous local variable
 + log, format-patch: parsing uses OPT__QUIET
 + Replace deprecated OPT_BOOLEAN by OPT_BOOL
 + Remove deprecated OPTION_BOOLEAN for parsing arguments
 (this branch uses jc/parseopt-command-modes.)

 Convert most uses of OPT_BOOLEAN/OPTION_BOOLEAN that can use
 OPT_BOOL/OPTION_BOOLEAN which have much saner semantics, and turn
 remaining ones into OPT_SET_INT, OPT_COUNTUP, etc. as necessary.

 Will merge to 'master'.


* ap/remote-hg-tilde-is-home-directory (2013-08-09) 1 commit
  (merged to 'next' on 2013-08-14 at cd963e3)
 + remote-hg: fix path when cloning with tilde expansion

 Will merge to 'master'.


* rt/doc-merge-file-diff3 (2013-08-09) 1 commit
  (merged to 'next' on 2013-08-14 at 1e5847b)
 + Documentation/git-merge-file: document option "--diff3"

 Will merge to 'master'.


* sb/misc-cleanup (2013-08-09) 3 commits
  (merged to 'next' on 2013-08-14 at 9e7ff9a)
 + rm: remove unneeded null pointer check
 + diff: fix a possible null pointer dereference
 + diff: remove ternary operator evaluating always to true

 Will merge to 'master'.


* mm/war-on-whatchanged (2013-08-13) 2 commits
  (merged to 'next' on 2013-08-14 at fe77c11)
 + whatchanged: document its historical nature
 + core-tutorial: trim the section on Inspecting Changes

 Will merge to 'master'.


* sb/diff-delta-remove-needless-comparison (2013-08-18) 1 commit
  (merged to 'next' on 2013-08-20 at c35730b)
 + create_delta_index: simplify condition always evaluating to true

 Will merge to 'master'.


* sg/bash-prompt-lf-in-cwd-test (2013-08-18) 1 commit
  (merged to 'next' on 2013-08-20 at 5544f62)
 + bash prompt: test the prompt with newline in repository path

 Will merge to 'master'.


* jl/some-submodule-config-are-not-boolean (2013-08-19) 1 commit
  (merged to 'next' on 2013-08-20 at 140c2e4)
 + avoid segfault on submodule.*.path set to an empty "true"

 Will merge to 'master'.


* sp/doc-smart-http (2013-08-21) 1 commit
  (merged to 'next' on 2013-08-22 at 4a16937)
 + Document the HTTP transport protocols

 Will merge to 'master'.


* bc/completion-for-bash-3.0 (2013-08-22) 3 commits
  (merged to 'next' on 2013-08-22 at 46c5bb2)
 + contrib/git-prompt.sh: handle missing 'printf -v' more gracefully
 + t9902-completion.sh: old Bash still does not support array+=('') notation
 + git-completion.bash: use correct Bash/Zsh array length syntax

 Some people still use rather old versions of bash, which cannot
 grok some constructs like 'printf -v varname' the prompt and
 completion code started to use recently.

 Will merge to 'master'.


* km/svn-1.8-serf-only (2013-07-18) 3 commits
  (merged to 'next' on 2013-07-19 at ab8d034)
 + Git.pm: revert _temp_cache use of temp_is_locked
  (merged to 'next' on 2013-07-12 at 70e0b95)
 + git-svn: allow git-svn fetching to work using serf
 + Git.pm: add new temp_is_locked function

 Subversion 1.8.0 that was recently released breaks older subversion
 clients coming over http/https in various ways.

 Will merge to 'master'.


* jc/check-x-z (2013-07-11) 4 commits
  (merged to 'next' on 2013-07-15 at 62751bc)
 + check-attr -z: a single -z should apply to both input and output
 + check-ignore -z: a single -z should apply to both input and output
 + check-attr: the name of the character is NUL, not NULL
 + check-ignore: the name of the character is NUL, not NULL

 "git check-ignore -z" applied the NUL termination to both its input
 (with --stdin) and its output, but "git check-attr -z" ignored the
 option on the output side.

 This is potentially a backward incompatible fix.  Let's see if
 anybody screams before deciding if we want to do anything to help
 existing users (there may be none).

 Will merge to 'master'.


* rr/feed-real-path-to-editor (2013-07-29) 1 commit
  (merged to 'next' on 2013-07-30 at 72c9bcb)
 + editor: use canonicalized absolute path

 Will merge to 'master'.


* jk/fast-import-empty-ls (2013-06-23) 4 commits
  (merged to 'next' on 2013-07-22 at d26dab6)
 + fast-import: allow moving the root tree
 + fast-import: allow ls or filecopy of the root tree
 + fast-import: set valid mode on root tree in "ls"
 + t9300: document fast-import empty path issues

 Will merge to 'master'.


* da/darwin (2013-08-05) 3 commits
  (merged to 'next' on 2013-08-05 at 5c54cfa)
 + OS X: Fix redeclaration of die warning
 + Makefile: Fix APPLE_COMMON_CRYPTO with BLK_SHA1
  (merged to 'next' on 2013-08-01 at d151a94)
 + imap-send: use Apple's Security framework for base64 encoding

 Will merge to 'master'.


* bc/unuse-packfile (2013-08-02) 2 commits
  (merged to 'next' on 2013-08-06 at 01aa4fd)
 + Don't close pack fd when free'ing pack windows
 + sha1_file: introduce close_one_pack() to close packs on fd pressure

 Handle memory pressure and file descriptor pressure separately when
 deciding to release pack windows to honor resource limits.

 Will merge to 'master'.


* tr/fd-gotcha-fixes (2013-08-06) 1 commit
  (merged to 'next' on 2013-08-08 at f452c5b)
 + t0070: test that git_mkstemps correctly checks return value of open()

 Finishing touches to an earlier fix already in 'master'.

 Will merge to 'master'.


* nd/gc-lock-against-each-other (2013-08-09) 1 commit
  (merged to 'next' on 2013-08-14 at 6999651)
 + gc: reject if another gc is running, unless --force is given

 Will merge to 'master'.


* fc/remote-hg-shared-setup (2013-08-11) 2 commits
  (merged to 'next' on 2013-08-14 at aae6858)
 + remote-hg: add shared repo upgrade
 + remote-hg: ensure shared repo is initialized

 Will merge to 'master'.


* aj/p4-symlink-lose-nl (2013-08-12) 1 commit
  (merged to 'next' on 2013-08-14 at a4959b7)
 + git-p4: Fix occasional truncation of symlink contents.

 Will merge to 'master'.


* fc/unpack-trees-leakfix (2013-08-13) 1 commit
  (merged to 'next' on 2013-08-14 at 989f329)
 + unpack-trees: plug a memory leak

 Will merge to 'master'.
