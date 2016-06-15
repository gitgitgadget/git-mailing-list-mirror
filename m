From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Jun 2012, #01; Sun, 3)
Date: Sun, 03 Jun 2012 17:23:13 -0700
Message-ID: <7vr4twudqm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 04 02:23:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SbL4r-0006bj-IP
	for gcvg-git-2@plane.gmane.org; Mon, 04 Jun 2012 02:23:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755316Ab2FDAXR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Jun 2012 20:23:17 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63934 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755302Ab2FDAXP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Jun 2012 20:23:15 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 69FA88919;
	Sun,  3 Jun 2012 20:23:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=e
	YCTTxAtk6e0P+TOXKChhTDE/Zs=; b=UWbW26LN5FA6MRsMBt1ybUZwPA22wAK2R
	p55OkuoX6J4NJbDQZe0DzGLC2hQbAppZOUPowfA4Nm08Rp1KbCDwBqVp+I5g1lTT
	LVr1iHluYhmcGGpbY61FY9A3IRCljsQ/ZaLU/oUSEZmDHFLpG8jJwggJD8rvlCI/
	t4XPkNxKEk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=Xu+
	mEOFA/ZVY/dxVgG1mWhnByV4pxuFqpkRnpCs1W/hdAnzxlCt0IIs82lt1v09krGz
	FvAjHEBDY8C1tygC7Ar7FSb+x0ZRe7k3+fydoKgTlzim/uI2QqrEkSt2VnNT6xZS
	6+mwbXev6QJmHHrFw5iQZ0ftHH3UXJFGzjxie624=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 61D318918;
	Sun,  3 Jun 2012 20:23:15 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 839BB8917; Sun,  3 Jun 2012
 20:23:14 -0400 (EDT)
X-master-at: 3fe4498197ced84886b4adaddf18f1109b477f8e
X-next-at: 281ad67c6ed0afb147ad426ff961c221b935af77
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 797CC302-ADDB-11E1-97F6-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199117>

What's cooking in git.git (Jun 2012, #01; Sun, 3)
--------------------------------------------------

Here are the topics that have been cooking.  Commits prefixed with '-' are
only in 'pu' (proposed updates) while commits prefixed with '+' are in 'next'.

v1.7.11-rc1 has been tagged.  Except for trivially obvious and small
fixes to older bugs and trivially obvious and small patches to
documentation, please consider we are in "regression fix only"
mode.  Finding and fixing since v1.7.10 is the top priority.

You can find the changes described here in the integration branches of the
repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[New Topics]

* jc/ls-files-i-dir (2012-06-03) 2 commits
 - ls-files -i: micro-optimize path_excluded()
 - ls-files -i: pay attention to exclusion of leading paths

"git ls-files --exclude=t -i" did not consider anything under t/
as excluded, as it did not pay attention to exclusion of leading
paths while walking the index.

* jc/request-pull-match-tagname (2012-06-01) 1 commit
 - request-pull: really favor a matching tag

"git request-pull $url dev" when the tip of "dev" branch was tagged
with "ext4-for-linus" used the contents from the tag in the output
but still asked the "dev" branch to be pulled, not the tag.

* db/vcs-svn (2012-06-01) 6 commits
 - vcs-svn: drop no-op reset methods
 - vcs-svn: fix signedness warnings
 - vcs-svn: prefer strstr over memmem
 - vcs-svn: prefer constcmp to prefixcmp
 - vcs-svn: simplify cleanup in apply_one_window()
 - vcs-svn: fix clang-analyzer error

* jk/version-string (2012-06-03) 3 commits
 - http: get default user-agent from git_user_agent
 - version: add git_user_agent function
 - move git_version_string into version.c

* mm/api-credentials-doc (2012-06-03) 3 commits
 - api-credentials.txt: mention credential.helper explicitly
 - api-credentials.txt: add "see also" section
 - api-credentials.txt: show the big picture first

--------------------------------------------------
[Graduated to "master"]

* ef/http-o-depends-on-gvf (2012-05-31) 1 commit
  (merged to 'next' on 2012-05-31 at 11af7cd)
 + Makefile: add missing GIT-VERSION-FILE dependency

A compilation fix.

* ef/maint-rebase-error-message (2012-05-30) 1 commit
  (merged to 'next' on 2012-05-30 at 5194fe3)
 + rebase: report invalid commit correctly

When "git rebase" was given a bad commit to replay the history on,
its error message did not correctly give the command line argument
it had trouble parsing.

* jl/submodule-report-new-path-once (2012-05-29) 1 commit
  (merged to 'next' on 2012-05-30 at e482dd9)
 + submodules: print "registered for path" message only once

"git submodule init" said "registered for path" even for a submodule
that was already registered.

* mm/levenstein-penalize-deletion-less (2012-05-29) 1 commit
  (merged to 'next' on 2012-05-30 at b2a0346)
 + Reduce cost of deletion in levenstein distance (4 -> 3)

"git tags" errored out, suggesting "git stage" while "git tag" is
a far more appropriate choice.

* nh/empty-rebase (2012-05-29) 1 commit
  (merged to 'next' on 2012-05-30 at 270703a)
 + cherry-pick: regression fix for empty commits

Fix for a new topic that happened in the 1.7.11 track.

* vr/rebase-autosquash-does-not-imply-i (2012-05-29) 1 commit
  (merged to 'next' on 2012-05-30 at 10dd3af)
 + Do not autosquash in case of an implied interactive rebase

"git rebase -p" should not pay attention to rebase.autosquash nor
"git rebase -p --autosquash".

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

It probably is a better idea to add a message that says that the
current was not pushed to address the problem in a more direct way.

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

* jc/apply-3way (2012-05-16) 12 commits
 - WIP: the message is bogus in apply:::check_patch()
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

* nd/exclude-workaround-top-heavy (2012-05-29) 2 commits
 - exclude: do strcmp as much as possible before fnmatch
 - Unindent excluded_from_list()

Attempts to optimize matching with an exclude pattern with a deep
directory hierarchy by taking the part that specifies leading path
without wildcard literally.

The code to check for wildcard needs to be redone.

* nd/stream-pack-objects (2012-05-29) 1 commit
 - pack-objects: use streaming interface for reading large loose blobs

* jk/clone-local (2012-05-30) 2 commits
 - clone: allow --no-local to turn off local optimizations
 - docs/clone: mention that --local may be ignored

"git clone --local $path" started its life as an experiment to
optionally use link/copy when cloning a repository on the disk, but
we didn't deprecate it after we made the option a no-op to always
use the optimization.

* jk/no-more-asciidoc7 (2012-05-30) 2 commits
 - docs: drop antique comment from Makefile
 - docs: drop asciidoc7compatible flag

* cr/persistent-https (2012-05-30) 1 commit
  (merged to 'next' on 2012-06-01 at c647464)
 + Add persistent-https to contrib

A remote helper that acts as a proxy that caches ssl session for the
https:// transport is added to the contrib/ area.

* nd/stream-index-pack (2012-05-24) 4 commits
 - index-pack: use streaming interface for collision test on large blobs
 - index-pack: factor out unpack core from get_data_from_pack
 - index-pack: use streaming interface on large blobs (most of the time)
 - index-pack: hash non-delta objects while reading from stream

Use streaming API to read from the object store to avoid having to hold
a large blob object in-core while running index-pack.

* js/submodule-relative (2012-06-03) 4 commits
 - submodule: fix handling of superproject origin URLs like foo, ./foo and ./foo/bar
 - submodule: fix sync handling of some relative superproject origin URLs
 - submodule: document failure to handle relative superproject origin URLs
 - submodule: additional regression tests for relative URLs

* mm/push-default-switch-warning (2012-04-26) 2 commits
 - t5541: warning message is given even with --quiet
 - push: start warning upcoming default change for push.default

Will squash the two, but this has to wait for a few release cycles.

--------------------------------------------------
[Discarded]

* cb/daemon-test-race-fix (2012-04-27) 2 commits
  (merged to 'next' on 2012-04-27 at 84bbcf8)
 + Revert "git-daemon wrapper to wait until daemon is ready"
  (merged to 'next' on 2012-04-24 at d5c30be)
 + git-daemon wrapper to wait until daemon is ready

Reverted from 'next' to replace it with js/daemon-test-race-fix.
