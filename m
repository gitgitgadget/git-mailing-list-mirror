From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Jun 2012, #03; Wed, 13)
Date: Wed, 13 Jun 2012 16:01:55 -0700
Message-ID: <7vk3zag6jg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 14 01:02:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SewZi-0001cD-2Z
	for gcvg-git-2@plane.gmane.org; Thu, 14 Jun 2012 01:02:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754831Ab2FMXCA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jun 2012 19:02:00 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41475 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752648Ab2FMXB7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2012 19:01:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2C713962F;
	Wed, 13 Jun 2012 19:01:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=p
	CUcAX9zbeRdUgwBcxlLARjl718=; b=HQ9KSvHciDvnl4Fcei6MP7DPZma31bYbc
	EHbLo/WN4Djb+OmDK6ge9ZCB23WZSdWLxRo2kls8gebftA9rcBtau8HtL+ReX2/S
	o8bvO4kRSBKZ0QNSUTzyqvw19wzBewjvoSmyRCC882wRWxUBmy0XHYNgjQab57XQ
	15WczGiXo4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=KOn
	sMvD6EQ3w2+0kzNXYH5DeQ6/6wRC65sLQB+9da89aXJFal0m85RwMEXucA9hNsuQ
	pM2AynHATUSTjDAbSZGTN63S11C17XHmUcVO9W8GTEwwwXS47/kdkQ6tqK5FTWSi
	V4Z+4C+Pk5OB6PhhsNXZcB9Uq0qXzh0/Y+KBhdfY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 20CB8962E;
	Wed, 13 Jun 2012 19:01:58 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2B7B3962D; Wed, 13 Jun 2012
 19:01:57 -0400 (EDT)
X-master-at: 2ae48a9bb87193de9e9da10abd9e7286c0e4c43d
X-next-at: 8698a94dadcf25a536d802359376c8811d29a59d
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C67C03CA-B5AB-11E1-A70A-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199957>

Here are the topics that have been cooking.  Commits prefixed with '-' are
only in 'pu' (proposed updates) while commits prefixed with '+' are in 'next'.

Most likely, I'll tag 1.7.11 final this weekend.  It doesn't look
like there is any remaining topic that cannot wait for the next
cycle.  A few small regressions on the master front have been
patched up, and it seems we are good to go.

You can find the changes described here in the integration branches of the
repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[New Topics]

* nd/i18n-branch-lego (2012-06-07) 1 commit
 - Remove i18n legos in notifying new branch tracking setup

Restructure the way message strings are created, in preparation for
marking them for i18n.

* nd/i18n-misc (2012-06-07) 3 commits
 - rerere: remove i18n legos in result message
 - notes-merge: remove i18n legos in merge result message
 - reflog: remove i18n legos in pruning message

Restructure the way message strings are created, in preparation for
marking them for i18n.

* rr/doc-commit (2012-06-08) 1 commit
 - commit: document a couple of options

* hv/remote-end-hung-up (2012-06-11) 1 commit
 - lessen the impression of unexpectedness on remote hangup

* hv/submodule-checkout-nuke-submodules (2012-06-11) 1 commit
 - update-index: allow overwriting existing submodule index entries

* jc/rev-list-simplify-merges-first-parent (2012-06-13) 3 commits
 - revision: ignore side parents while running simplify-merges
 - revision: note the lack of free() in simplify_merges()
 - revision: "simplify" options imply topo-order sort

* jc/ustar-checksum-is-unsigned (2012-06-13) 1 commit
 - archive: ustar header checksum is computed unsigned

* rs/git-blame-mapcar-mapc (2012-06-10) 1 commit
 - git-blame.el: use mapc instead of mapcar

* rs/ipv6-ssh-url (2012-06-13) 1 commit
 - git: Wrong parsing of ssh urls with IPv6 literals ignores port

* vr/use-our-perl-in-tests (2012-06-12) 3 commits
 - t/README: add a bit more Don'ts
 - tests: enclose $PERL_PATH in duoble quotes
 - t: Replace 'perl' by $PERL_PATH

--------------------------------------------------
[Graduated to "master"]

* cr/persistent-https (2012-05-30) 1 commit
  (merged to 'next' on 2012-06-01 at c647464)
 + Add persistent-https to contrib

A remote helper that acts as a proxy that caches ssl session for the
https:// transport is added to the contrib/ area.

* jc/fmt-merge-msg-people (2012-06-06) 1 commit
  (merged to 'next' on 2012-06-08 at 7d8f4b6)
 + fmt-merge-msg: make attribution into comment lines

* jc/svn-auth-providers-unusable-at-1.6.12 (2012-06-04) 1 commit
  (merged to 'next' on 2012-06-04 at c4ffe24)
 + git-svn: platform auth providers are working only on 1.6.15 or newer

Regression fix for people with libsvn between 1.6.12 and 1.6.15 on
which we tried to use non-working platform auth providers.

* mm/api-credentials-doc (2012-06-07) 5 commits
 + docs: fix cross-directory linkgit references
  (merged to 'next' on 2012-06-05 at 8e14814)
 + api-credentials.txt: add "see also" section
 + api-credentials.txt: mention credential.helper explicitly
 + api-credentials.txt: show the big picture first
 + doc: fix xref link from api docs to manual pages

* rr/maint-t3510-cascade-fix (2012-06-04) 1 commit
  (merged to 'next' on 2012-06-04 at 4c3368b)
 + t3510 (cherry-pick-sequence): add missing '&&'

--------------------------------------------------
[Stalled]

* nl/http-proxy-more (2012-05-11) 2 commits
 - http: rename HTTP_REAUTH to HTTP_AUTH_RETRY
 - http: Avoid limit of retrying request only twice

I queued only the later two patches from this series, even though they do
not make much sense without the first one that seems to need a bit more
work, so that we won't forget.

* jk/no-op-push-message (2012-05-30) 1 commit
 - improve no-op push output

Rewords the status message of "git push" that pushed only one ref
differently from "Everything up-to-date", to give a bit more help to
people who get the message when their current branch is not pushed.

I had an impression after the discussion thread that a redesign is
coming, but it hasn't happened yet.

* fc/git-prompt-script (2012-06-10) 6 commits
 - completion: warn people about duplicated function
 - completion: split __git_ps1 into a separate script
 - completion: remove executable mode
 - Merge branch 'fc/git-complete-helper' into fc/git-prompt-script
 - tests: add tests for the bash prompt functions in the completion script
 - tests: move code to run tests under bash into a helper library
 (this branch is tangled with sg/bash-prompt.)

The last remaining sticking point is what to do with the duplicated
shell function.  Together with the warning patch at the tip, if we
side port the tip commit from sg/bash-prompt, I think this will be
ready for testing.

* sg/bash-prompt (2012-05-09) 4 commits
 - completion: respect $GIT_DIR
 - completion: use __gitdir() in _git_log()
 - tests: add tests for the bash prompt functions in the completion script
 - tests: move code to run tests under bash into a helper library
 (this branch is tangled with fc/git-prompt-script.)

This is only the "correction" bits taken from the beginning of a larger
series that is to be rerolled.  The first two are tangled with Felipe's
topic so a reroll, if comes, should build on top of them.

* jc/maint-push-refs-all (2012-05-04) 2 commits
 - get_fetch_map(): tighten checks on dest refs
 - fetch/push: allow refs/*:refs/*

Allows pushing and fetching refs/stash.
There still seem to be other bugs hiding (e.g. try pushing twice).

Not ready.

* jc/run-hook-env-1 (2012-03-11) 1 commit
 - run_hook(): enhance the interface to pass arbitrary environment

Not urgent.

Updates run_hook() API to be much less specific to "commit".  It would
only be useful if people start doing more interesting things with hooks.

* jc/split-blob (2012-04-03) 6 commits
 - chunked-object: streaming checkout
 - chunked-object: fallback checkout codepaths
 - bulk-checkin: support chunked-object encoding
 - bulk-checkin: allow the same data to be multiply hashed
 - new representation types in the packstream
 - packfile: use varint functions

Not ready.

I finished the streaming checkout codepath, but as explained in
127b177 (bulk-checkin: support chunked-object encoding, 2011-11-30),
these are still early steps of a long and painful journey. At least
pack-objects and fsck need to learn the new encoding for the series
to be usable locally, and then index-pack/unpack-objects needs to
learn it to be used remotely.

Given that I heard a lot of noise that people want large files, and
that I was asked by somebody at GitTogether'11 privately for an
advice on how to pay developers (not me) to help adding necessary
support, I am somewhat dissapointed that the original patch series
that was sent almost two months ago still remains here without much
comments and updates from the developer community. I even made the
interface to the logic that decides where to split chunks easily
replaceable, and I deliberately made the logic in the original patch
extremely stupid to entice others, especially the "bup" fanboys, to
come up with a better logic, thinking that giving people an easy
target to shoot for, they may be encouraged to help out. The plan is
not working :-(.

--------------------------------------------------
[Cooking]

* jc/apply-3way (2012-06-13) 19 commits
 - apply --3way: tests
 - apply: document --3way option
 - apply: allow rerere() upon --3way results
 - apply: register conflicted stages to the index
 - apply: --3way with add/add conflict
 - apply: move verify_index_match() higher
 - apply: plug the three-way merge logic in
 - apply: fall back on three-way merge
 - apply: accept -3/--3way command line option
 - apply: move "already exists" logic to check_to_create()
 - apply: move check_to_create_blob() closer to its sole caller
 - apply: further split load_preimage()
 - apply: refactor "previous patch" logic
 - apply: split load_preimage() helper function out
 - apply: factor out checkout_target() helper function
 - apply: refactor read_file_or_gitlink()
 - apply: clear_image() clears things a bit more
 - apply: a bit more comments on PATH_TO_BE_DELETED
 - apply: fix an incomplete comment in check_patch()

"git apply" learns to wiggle the base version and perform three-way merge
when a patch does not exactly apply to the version you have.


* nd/exclude-workaround-top-heavy (2012-06-07) 3 commits
 - exclude: do strcmp as much as possible before fnmatch
 - dir.c: get rid of the wildcard symbol set in no_wildcard()
 - Unindent excluded_from_list()

Attempts to optimize matching with an exclude pattern with a deep
directory hierarchy by taking the part that specifies leading path
without wildcard literally.

* jc/bundle-complete-notice (2012-06-04) 1 commit
  (merged to 'next' on 2012-06-05 at ee25a35)
 + tweak "bundle verify" of a complete history

Running "git bundle verify" on a bundle that records a complete
history said "it requires these 0 commits".

Not urgent; probably early post 1.7.11.

* lk/more-helpful-status-hints (2012-06-11) 5 commits
 - fixup! status: better advices when splitting a commit (during rebase -i)
 - status: better advices when splitting a commit (during rebase -i)
 - status: don't suggest "git rm" or "git add" if not appropriate
 - t7512-status-help.sh: better advices for git status
 - wt-status.*: better advices for git status added

Almost there, modulo minor details pointed out by Matthieu.

* jk/no-more-pre-exec-callback (2012-06-05) 1 commit
 - pager: drop "wait for output to run less" hack

On hold for 6 months until ancient "less" goes extinct.

* jk/maint-t1304-setfacl (2012-06-07) 1 commit
  (merged to 'next' on 2012-06-08 at ebba27c)
 + t1304: improve setfacl prerequisite setup

Works around a false test failure caused by a bug in ecryptofs.

Not urgent; probably early post 1.7.11.

* lk/rebase-i-x (2012-06-13) 1 commit
 - rebase -i: teach "--exec <cmd>"

Adds -x <cmd> to "rebase -i" to insert "exec <cmd>" after each
commit in the resulting history.

Will merge to next after 1.7.11.

* vr/help-per-platform (2012-06-06) 1 commit
  (merged to 'next' on 2012-06-08 at f4b2b0b)
 + help: use HTML as the default help format on Windows

Not urgent; probably early post 1.7.11.

* jc/ls-files-i-dir (2012-06-05) 6 commits
  (merged to 'next' on 2012-06-08 at 2b5a256)
 + dir.c: make excluded() file scope static
 + unpack-trees.c: use path_excluded() in check_ok_to_remove()
 + builtin/add.c: use path_excluded()
 + path_excluded(): update API to less cache-entry centric
  (merged to 'next' on 2012-06-05 at 8f35db3)
 + ls-files -i: micro-optimize path_excluded()
 + ls-files -i: pay attention to exclusion of leading paths

"git ls-files --exclude=t -i" did not consider anything under t/
as excluded, as it did not pay attention to exclusion of leading
paths while walking the index.  Other two users of excluded() are
also updated.

Not urgent; probably early post 1.7.11.

* jc/request-pull-match-tagname (2012-06-01) 1 commit
  (merged to 'next' on 2012-06-05 at f0dc420)
 + request-pull: really favor a matching tag

"git request-pull $url dev" when the tip of "dev" branch was tagged
with "ext4-for-linus" used the contents from the tag in the output
but still asked the "dev" branch to be pulled, not the tag.

Not urgent; probably early post 1.7.11.

* db/vcs-svn (2012-06-01) 6 commits
 - vcs-svn: drop no-op reset methods
 - vcs-svn: fix signedness warnings
 - vcs-svn: prefer strstr over memmem
 - vcs-svn: prefer constcmp to prefixcmp
 - vcs-svn: simplify cleanup in apply_one_window()
 - vcs-svn: fix clang-analyzer error

I'd take Jonathan's clean-up offer and keep this on hold until
1.7.11 final.

* jk/version-string (2012-06-03) 3 commits
  (merged to 'next' on 2012-06-05 at b6f7266)
 + http: get default user-agent from git_user_agent
 + version: add git_user_agent function
 + move git_version_string into version.c

Will merge to master early post 1.7.11.

* nd/stream-pack-objects (2012-05-29) 1 commit
 - pack-objects: use streaming interface for reading large loose blobs

Will merge to next after 1.7.11.

* jk/clone-local (2012-05-30) 2 commits
  (merged to 'next' on 2012-06-05 at b819eb5)
 + clone: allow --no-local to turn off local optimizations
 + docs/clone: mention that --local may be ignored

"git clone --local $path" started its life as an experiment to
optionally use link/copy when cloning a repository on the disk, but
we didn't deprecate it after we made the option a no-op to always
use the optimization.

Not urgent; probably early post 1.7.11.

* jk/no-more-asciidoc7 (2012-05-30) 2 commits
  (merged to 'next' on 2012-06-05 at 3f117df)
 + docs: drop antique comment from Makefile
 + docs: drop asciidoc7compatible flag

Not urgent; probably early post 1.7.11.

* nd/stream-index-pack (2012-05-24) 4 commits
 - index-pack: use streaming interface for collision test on large blobs
 - index-pack: factor out unpack core from get_data_from_pack
 - index-pack: use streaming interface on large blobs (most of the time)
 - index-pack: hash non-delta objects while reading from stream

Use streaming API to read from the object store to avoid having to hold
a large blob object in-core while running index-pack.

Will merge to next after 1.7.11.

* js/submodule-relative (2012-06-06) 4 commits
 - submodule: fix handling of superproject origin URLs like foo, ./foo and ./foo/bar
 - submodule: fix sync handling of some relative superproject origin URLs
 - submodule: document failure to handle relative superproject origin URLs
 - submodule: additional regression tests for relative URLs

Makes "git submodule" deal with nested submodule structure where a
module is contained within a module whose origin is specified as a
relative URL to its superproject's origin.

Not urgent; probably early post 1.7.11.

* mm/push-default-switch-warning (2012-06-06) 1 commit
 - push: start warning upcoming default change for push.default

Will merge to next after 1.7.11.

Hopwefully we can have a solidly tested series early in 1.7.12 or
1.7.13 at the latest.

--------------------------------------------------
[Discarded]

* cb/daemon-test-race-fix (2012-04-27) 2 commits
  (merged to 'next' on 2012-04-27 at 84bbcf8)
 + Revert "git-daemon wrapper to wait until daemon is ready"
  (merged to 'next' on 2012-04-24 at d5c30be)
 + git-daemon wrapper to wait until daemon is ready

Reverted from 'next' to replace it with js/daemon-test-race-fix.

* jc/merge-annotated-tag (2012-06-05) 2 commits
 . merge: allow fast-forwarding to an annotated but unsigned tag
 . merge: separte the logic to check for a signed tag

"git merge anno" created a merge commit even when anno is an
unsigned annotated tag that points at a commit that can be fast
forwarded to; this came from a laziness of the implementation of
merging of signed tags in 1.7.9.  People may have different opinion
on making signed and unsigned annotated tag behave differently, but
I tend to agree that it is probably not a good idea.
