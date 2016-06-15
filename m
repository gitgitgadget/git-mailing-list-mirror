From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Jun 2012, #02; Wed, 6)
Date: Wed, 06 Jun 2012 14:55:09 -0700
Message-ID: <7v62b4ksw2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 06 23:55:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ScOCI-0008TJ-AG
	for gcvg-git-2@plane.gmane.org; Wed, 06 Jun 2012 23:55:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758972Ab2FFVzQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jun 2012 17:55:16 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36858 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758674Ab2FFVzN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jun 2012 17:55:13 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 51C4E803E;
	Wed,  6 Jun 2012 17:55:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=N
	QbWn0y6nQyzBt5TiHsHKdev52o=; b=rwcRO4J/sM8MiaoO1OOtqj1UBCNkf3MmJ
	lvGNl/+HFivpZFasGNqmiZCc5ZjbICisjI06VbifWmzlHGhwLkjI15MT18C/OdNL
	5bruQH+7hWn63XsA17bpHj2BqLwwPjKD9Od0erc9WmpgV5zOgQidAsLYTZug0PBo
	Jt9Br/CJ+Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=El/
	EfDvFLVU8kHilEt9d0AL9FTP/VPRKuic3+PrEQd8w3r38q8xavvzgRpdxD3SuTYs
	EYr+z0GIAw7MVRR8bqffkSxkWNxsYNaUVkB0d1h1RaKMeIv2Efg7C5FDiiCuQPba
	Oa5Oc/vlgPSIdV6dN27+3c/JO8GwnNT3s3ri89Rk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 48E56803D;
	Wed,  6 Jun 2012 17:55:12 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5A68B803B; Wed,  6 Jun 2012
 17:55:11 -0400 (EDT)
X-master-at: f623ca1cae600e97cb0b38131fdd33e4fb669cf8
X-next-at: 8e148144574e6c6511b591286e44a677a260d760
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 49F21670-B022-11E1-98E1-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199358>

What's cooking in git.git (Jun 2012, #02; Wed, 6)
--------------------------------------------------

Here are the topics that have been cooking.  Commits prefixed with '-' are
only in 'pu' (proposed updates) while commits prefixed with '+' are in 'next'.

I'm planning to tag 1.7.11-rc2 tomorrow or Friday (we have slipped
by one week). Please concentrate on testing, finding and fixing
regressions introduced after 1.7.10 until 1.7.11 final.

You can find the changes described here in the integration branches of the
repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[New Topics]

* jc/bundle-complete-notice (2012-06-04) 1 commit
  (merged to 'next' on 2012-06-05 at ee25a35)
 + tweak "bundle verify" of a complete history

Running "git bundle verify" on a bundle that records a complete
history said "it requires these 0 commits".

Not urgent; probably early post 1.7.11.

* jc/svn-auth-providers-unusable-at-1.6.12 (2012-06-04) 1 commit
  (merged to 'next' on 2012-06-04 at c4ffe24)
 + git-svn: platform auth providers are working only on 1.6.15 or newer

Regression fix for people with libsvn between 1.6.12 and 1.6.15 on
which we tried to use non-working platform auth providers.

Will merge to master.

* lk/more-helpful-status-hints (2012-06-05) 4 commits
 - status: better advices when splitting a commit (during rebase -i)
 - status: don't suggest "git rm" or "git add" if not appropriate
 - t7512-status-help.sh: better advices for git status
 - wt-status.*: better advices for git status added

Almost there, modulo minor details pointed out by Matthieu.

* rr/maint-t3510-cascade-fix (2012-06-04) 1 commit
  (merged to 'next' on 2012-06-04 at 4c3368b)
 + t3510 (cherry-pick-sequence): add missing '&&'

Will merge to master.

* jc/merge-annotated-tag (2012-06-05) 2 commits
 - merge: allow fast-forwarding to an annotated but unsigned tag
 - merge: separte the logic to check for a signed tag

"git merge anno" created a merge commit even when anno is an
unsigned annotated tag that points at a commit that can be fast
forwarded to; this came from a laziness of the implementation of
merging of signed tags in 1.7.9, and can be worked around by saying
"git merge --ff-only anno", so it is not really necessariy, but is
here for completeness.

Not urgent.

* jk/no-more-pre-exec-callback (2012-06-05) 1 commit
 - pager: drop "wait for output to run less" hack

On hold for 6 months until ancient "less" goes extinct.

* jk/maint-t1304-setfacl (2012-06-06) 1 commit
 - t1304: improve setfacl prerequisite setup

Works around a false test failure caused by a bug in ecryptofs.

Not urgent; probably early post 1.7.11.

* lk/rebase-i-x (2012-06-06) 1 commit
 - rebase [-i --exec | -ix] <cmd>...

Adds -x <cmd> to "rebase -i" to insert "exec <cmd>" after each
commit in the resulting history.

Not urgent; probably early post 1.7.11.

* vr/help-per-platform (2012-06-06) 1 commit
 - help: use HTML as the default help format on Windows

* jc/fmt-merge-msg-people (2012-06-06) 1 commit
 - fmt-merge-msg: make attribution into comment lines

--------------------------------------------------
[Stalled]

* nd/exclude-workaround-top-heavy (2012-05-29) 2 commits
 - exclude: do strcmp as much as possible before fnmatch
 - Unindent excluded_from_list()

Attempts to optimize matching with an exclude pattern with a deep
directory hierarchy by taking the part that specifies leading path
without wildcard literally.

The code to check for wildcard needs to be redone.

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

* fc/git-prompt-script (2012-05-22) 5 commits
 - completion: split __git_ps1 into a separate script
 - completion: remove executable mode
 - Merge branch 'fc/git-complete-helper' into fc/git-prompt-script
 - tests: add tests for the bash prompt functions in the completion script
 - tests: move code to run tests under bash into a helper library
 (this branch is tangled with sg/bash-prompt.)

The last remaining sticking point is what to do with the duplicated shell
function.

* sg/bash-prompt (2012-05-09) 4 commits
 - completion: respect $GIT_DIR
 - completion: use __gitdir() in _git_log()
 - tests: add tests for the bash prompt functions in the completion script
 - tests: move code to run tests under bash into a helper library
 (this branch is tangled with fc/git-prompt-script.)

This is only the "correction" bits taken from the beginning of a larger
series that is to be rerolled.  The first two are tangled with Felipe's
topic so a reroll, if comes, should build on top of them.

* jc/apply-3way (2012-06-06) 12 commits
 - apply: fix an incomplete message
 - apply: refactor "previous patch" logic
 - apply: a bit more comments on PATH_TO_BE_DELETED
 - apply: document --3way option
 - apply: allow rerere() upon --3way results
 - apply: register conflicted stages to the index
 - apply: plug the three-way merge logic in
 - apply: fall back on three-way merge
 - apply: accept -3/--3way command line option
 - apply: split load_preimage() helper function out
 - apply: refactor read_file_or_gitlink()
 - apply: clear_image() clears things a bit more

"git apply" learns to wiggle the base version and perform three-way merge
when a patch does not exactly apply to the version you have.

It turns out that it is somewhat unpleasant to handle add/add conflicts in
this code, but it seems necessary if we want to use "apply -3" to replace
the use of "apply --build-fake-ancestor" followed by the slow "merge" in
"am -3".

* jc/maint-push-refs-all (2012-05-04) 2 commits
 - get_fetch_map(): tighten checks on dest refs
 - fetch/push: allow refs/*:refs/*

Allows pushing and fetching refs/stash.
Not ready.
There still seem to be other bugs hiding (e.g. try pushing twice).

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

* jc/ls-files-i-dir (2012-06-05) 6 commits
 - dir.c: make excluded() file scope static
 - unpack-trees.c: use path_excluded() in check_ok_to_remove()
 - builtin/add.c: use path_excluded()
 - path_excluded(): update API to less cache-entry centric
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

I do not know the doneness of this series that came out of the
blue.  Are people involved in vcs-svn happy with this series?

* jk/version-string (2012-06-03) 3 commits
  (merged to 'next' on 2012-06-05 at b6f7266)
 + http: get default user-agent from git_user_agent
 + version: add git_user_agent function
 + move git_version_string into version.c

I am somewhat tempted to merge this to master before 1.7.11 final.
Thoughts?

* mm/api-credentials-doc (2012-06-04) 4 commits
  (merged to 'next' on 2012-06-05 at 8e14814)
 + api-credentials.txt: add "see also" section
 + api-credentials.txt: mention credential.helper explicitly
 + api-credentials.txt: show the big picture first
 + doc: fix xref link from api docs to manual pages

Will merge to master.

* nd/stream-pack-objects (2012-05-29) 1 commit
 - pack-objects: use streaming interface for reading large loose blobs

Not urgent; probably early post 1.7.11.

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

* cr/persistent-https (2012-05-30) 1 commit
  (merged to 'next' on 2012-06-01 at c647464)
 + Add persistent-https to contrib

A remote helper that acts as a proxy that caches ssl session for the
https:// transport is added to the contrib/ area.

Will merge to master.

* nd/stream-index-pack (2012-05-24) 4 commits
 - index-pack: use streaming interface for collision test on large blobs
 - index-pack: factor out unpack core from get_data_from_pack
 - index-pack: use streaming interface on large blobs (most of the time)
 - index-pack: hash non-delta objects while reading from stream

Use streaming API to read from the object store to avoid having to hold
a large blob object in-core while running index-pack.

Not urgent; probably early post 1.7.11.

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
