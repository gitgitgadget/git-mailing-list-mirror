X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Feb 2012, #02; Sun, 5)
Date: Sun, 05 Feb 2012 18:44:29 -0800
Message-ID: <7v7h00brzm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Mon, 6 Feb 2012 02:44:42 +0000 (UTC)
To: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=mZYJjdjXKO5t0cv5eGkHMOS8b
	Bw=; b=p3zk6foCdHVYvYV8hgisec0akGMGNI3W2h26zvSK43IuhFDzmqhOupNDg
	c0cDqb0WpvyM8nsE0bkKVMJHnpK7ai2ieFol47DoD4ElCYmyJvF9CBJNJckNXUpO
	bSsHFXcBgWwtoLeimN2j/o4EZgK1Zk4/1xVTZCo1PBRfsWkMMg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=MwxfWOXMzRN8oDUDH5J
	SpvC8pe5OXI6Ym3QDF509UZC0k+G+T7Bvmj+Jg9vAA2IhhuzkeIFSFVnIhFqctbG
	ftPoNdJNUIux9poBvvcbkKo8KQLwtAkZhTkyJRrqcdxSpahb//oPHkgH9NGf8rmR
	IsFKGgjV72Cr98OtHH/fHoKE=
X-master-at: f3fb07509c2e0b21b12a598fcd0a19a92fc38a9d
X-next-at: 055e4466df114c65a2c210423938673373746f3e
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7E6F87EA-506C-11E1-98B9-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190000>
Received: from vger.kernel.org ([209.132.180.67]) by plane.gmane.org with
 esmtp (Exim 4.69) (envelope-from <git-owner@vger.kernel.org>) id
 1RuEZM-0007mr-46 for gcvg-git-2@plane.gmane.org; Mon, 06 Feb 2012 03:44:40
 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752824Ab2BFCoe convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git-2@m.gmane.org>); Sun, 5 Feb 2012 21:44:34 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44796 "EHLO
 smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id
 S1751851Ab2BFCoc convert rfc822-to-8bit (ORCPT <rfc822;git@vger.kernel.org>);
 Sun, 5 Feb 2012 21:44:32 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1]) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTP id BB6F666F6; Sun,  5 Feb 2012
 21:44:31 -0500 (EST)
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1]) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTP id B32C666F5; Sun,  5 Feb 2012
 21:44:31 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 89FB666F4; Sun,  5 Feb 2012
 21:44:30 -0500 (EST)
Sender: git-owner@vger.kernel.org

Here are the topics that have been cooking.  Commits prefixed with '-' =
are
only in 'pu' (proposed updates) while commits prefixed with '+' are in
'next'.

Compared to the recent activity level on discussions of new features on
the list, some people may be wondering if the rate of advancement of th=
e
'master' and 'next' branches is getting throttled.

That is because it is.

Now the obviously good bits that have been cooking during the feature
freeze are pushed out to 'master', I'd want to make sure we can have a
timely release of v1.7.9.1 so that people can start benefiting from the
features and fixes introduced in v1.7.9 more smoothly and sooner, and t=
hat
is where my focus lies at this moment. I've been picking up new topics =
and
adding them to 'pu' only "as time and attention permit" basis, and this
mode of operation probably will continue throughout the second week of =
the
post v1.7.9 cycle (cf. http://tinyurl.com/gitcal).

Here are the repositories that have my integration branches:

With maint, master, next, pu, todo:

        git://git.kernel.org/pub/scm/git/git.git
        git://repo.or.cz/alt-git.git
        https://code.google.com/p/git-core/
        https://github.com/git/git

With only maint and master:

        git://git.sourceforge.jp/gitroot/git-core/git.git
        git://git-core.git.sourceforge.net/gitroot/git-core/git-core

With all the topics and integration branches:

        https://github.com/gitster/git

The preformatted documentation in HTML and man format are found in:

        git://git.kernel.org/pub/scm/git/git-{htmldocs,manpages}.git/
        git://repo.or.cz/git-{htmldocs,manpages}.git/
        https://code.google.com/p/git-{htmldocs,manpages}.git/
        https://github.com/gitster/git-{htmldocs,manpages}.git/

--------------------------------------------------
[New Topics]

* bw/inet-pton-ntop-compat (2012-02-05) 1 commit
 - Drop system includes from inet_pton/inet_ntop compatibility wrappers

The inclusion order of header files bites Solaris again and this fixes =
it.

Will merge to 'next'.

* jc/branch-desc-typoavoidance (2012-02-05) 2 commits
 - branch --edit-description: protect against mistyped branch name
 + tests: add write_script helper function
 (this branch is tangled with jk/tests-write-script.)

Typo in "git branch --edit-description my-tpoic" was not diagnosed.

Will merge to 'next'.

* jc/checkout-out-of-unborn (2012-02-05) 1 commit
 - git checkout -b: allow switching out of an unborn branch

I am fairly negative on this one, as I think it is just shifting the
problem around.

* jc/maint-mailmap-output (2012-02-05) 1 commit
 - mailmap: do not leave '>' in the output when answering "we did somet=
hing"

map_user() was not rewriting its output correctly, which resulted in th=
e
user visible symptom that "git blame -e" sometimes showed excess '>' at
the end of email addresses.

* jc/merge-ff-only-stronger-than-signed-merge (2012-02-05) 1 commit
 - merge: do not create a signed tag merge under --ff-only option

"git merge --ff-only $tag" failed because it cannot record the required
mergetag without creating a merge, but this is so common operation for
branch that is used _only_ to follow the upstream, so it is allowed to
fast-forward without recording the mergetag.

* tt/profile-build-fix (2012-02-05) 1 commit
 - Fix build problems related to profile-directed optimization

--------------------------------------------------
[Stalled]

* jc/advise-push-default (2011-12-18) 1 commit
 - push: hint to use push.default=3Dupstream when appropriate

Peff had a good suggestion outlining an updated code structure so that
somebody new can try to dip his or her toes in the development. Any
takers?

* ss/git-svn-prompt-sans-terminal (2012-01-04) 3 commits
 - fixup! 15eaaf4
 - git-svn, perl/Git.pm: extend Git::prompt helper for querying users
 - perl/Git.pm: "prompt" helper to honor GIT_ASKPASS and SSH_ASKPASS

The bottom one has been replaced with a rewrite based on comments from
=C3=86var. The second one needs more work, both in perl/Git.pm and prom=
pt.c, to
give precedence to tty over SSH_ASKPASS when terminal is available.

* nd/commit-ignore-i-t-a (2012-01-16) 2 commits
 - commit, write-tree: allow to ignore CE_INTENT_TO_ADD while writing t=
rees
 - cache-tree: update API to take abitrary flags

May want to consider this as fixing an earlier UI mistake, and not as a
feature that devides the userbase.

* jc/split-blob (2012-01-24) 6 commits
 - chunked-object: streaming checkout
 - chunked-object: fallback checkout codepaths
 - bulk-checkin: support chunked-object encoding
 - bulk-checkin: allow the same data to be multiply hashed
 - new representation types in the packstream
 - varint-in-pack: refactor varint encoding/decoding

Not ready.

I finished the streaming checkout codepath, but as explained in 127b177
(bulk-checkin: support chunked-object encoding, 2011-11-30), these are
still early steps of a long and painful journey. At least pack-objects =
and
fsck need to learn the new encoding for the series to be usable locally=
,
and then index-pack/unpack-objects needs to learn it to be used remotel=
y.

Given that I heard a lot of noise that people want large files, and tha=
t I
was asked by somebody at GitTogether'11 privately for an advice on how =
to
pay developers (not me) to help adding necessary support, I am somewhat
dissapointed that the original patch series that was sent almost two
months ago still remains here without much comments and updates from th=
e
developer community. I even made the interface to the logic that decide=
s
where to split chunks easily replaceable, and I deliberately made the
logic in the original patch extremely stupid to entice others, especial=
ly
the "bup" fanboys, to come up with a better logic, thinking that giving
people an easy target to shoot for, they may be encouraged to help
out. The plan is not working :-(.

--------------------------------------------------
[Cooking]

* nd/diffstat-gramnum (2012-02-03) 1 commit
  (merged to 'next' on 2012-02-05 at 7335ecc)
 + Use correct grammar in diffstat summary line

The commands in the "git diff" family and "git apply --stat" that count
the number of files changed and the number of lines inserted/deleted ha=
ve
been updated to match the output from "diffstat".  This also opens the
door to i18n this line.

* jx/i18n-more-marking (2012-02-01) 2 commits
  (merged to 'next' on 2012-02-05 at 44e8cf6)
 + i18n: format_tracking_info "Your branch is behind" message
 + i18n: git-commit whence_s "merge/cherry-pick" message

Marks a few more messages we forgot to mark for i18n.

* jk/grep-binary-attribute (2012-02-02) 9 commits
  (merged to 'next' on 2012-02-05 at 9dffa7e)
 + grep: pre-load userdiff drivers when threaded
 + grep: load file data after checking binary-ness
 + grep: respect diff attributes for binary-ness
 + grep: cache userdiff_driver in grep_source
 + grep: drop grep_buffer's "name" parameter
 + convert git-grep to use grep_source interface
 + grep: refactor the concept of "grep source" into an object
 + grep: move sha1-reading mutex into low-level code
 + grep: make locking flag global

=46ixes a longstanding bug that there was no way to tell "git grep" tha=
t a
path may look like text but it is not, which "git diff" can do using th=
e
attributes system. Now "git grep" honors the same "binary" (or "-diff")
attribute.

* jc/parse-date-raw (2012-02-03) 2 commits
 - parse_date(): '@' prefix forces git-timestamp
 - parse_date(): allow ancient git-timestamp

"rebase" and "commit --amend" failed to work on commits with ancient
timestamps near year 1970.

Waiting for comments.

* jk/git-dir-lookup (2012-02-02) 1 commit
  (merged to 'next' on 2012-02-05 at 1856d74)
 + standardize and improve lookup rules for external local repos

When you have both .../foo and .../foo.git, "git clone .../foo" did not
favor the former but the latter.

* jk/prompt-fallback-to-tty (2012-02-03) 2 commits
 - prompt: fall back to terminal if askpass fails
 - prompt: clean up strbuf usage

The code to ask for password did not fall back to the terminal input wh=
en
GIT_ASKPASS is set but does not work (e.g. lack of X with GUI askpass
helper).

Will merge to 'next'.

* jk/tests-write-script (2012-02-03) 2 commits
  (merged to 'next' on 2012-02-05 at 4264ffa)
 + t0300: use write_script helper
 + tests: add write_script helper function
 (this branch is tangled with jc/branch-desc-typoavoidance.)

* jn/gitweb-search-utf-8 (2012-02-03) 1 commit
  (merged to 'next' on 2012-02-05 at 055e446)
 + gitweb: Allow UTF-8 encoded CGI query parameters and path_info

Search box in "gitweb" did not accept non-ASCII characters correctly.

* jn/rpm-spec (2012-02-03) 1 commit
  (merged to 'next' on 2012-02-05 at dba940b)
 + git.spec: Workaround localized messages not put in any RPM

=46ix breakage in v1.7.9 Makefile; rpmbuild notices an unpackaged but
installed *.mo file and fails.

* fc/zsh-completion (2012-02-03) 3 commits
 - completion: simplify __gitcomp and __gitcomp_nl implementations
 - completion: use ls -1 instead of rolling a loop to do that ourselves
 - completion: work around zsh option propagation bug

=46ix git subcommand completion for zsh (in contrib/completion).

Will merge to 'next'.

* jc/maint-request-pull-for-tag (2012-01-31) 1 commit
  (merged to 'next' on 2012-02-01 at 7649f18)
 + request-pull: explicitly ask tags/$name to be pulled

When asking for a tag to be pulled, "request-pull" shows the name of th=
e
tag prefixed with "tags/"

* nd/find-pack-entry-recent-cache-invalidation (2012-02-01) 2 commits
  (merged to 'next' on 2012-02-01 at e26aed0)
 + find_pack_entry(): do not keep packed_git pointer locally
 + sha1_file.c: move the core logic of find_pack_entry() into fill_pack=
_entry()

* nd/pack-objects-parseopt (2012-02-01) 3 commits
  (merged to 'next' on 2012-02-05 at d0dc25d)
 + pack-objects: convert to use parse_options()
 + pack-objects: remove bogus comment
 + pack-objects: do not accept "--index-version=3Dversion,"

"pack-objects" learned use parse-options, losing custom command line
parsing code.

* bl/gitweb-project-filter (2012-02-01) 8 commits
  (merged to 'next' on 2012-02-01 at 2c96ce7)
 + gitweb: Make project search respect project_filter
 + gitweb: improve usability of projects search form
 + gitweb: place links to parent directories in page header
 + gitweb: show active project_filter in project_list page header
 + gitweb: limit links to alternate forms of project_list to active pro=
ject_filter
 + gitweb: add project_filter to limit project list to a subdirectory
 + gitweb: prepare git_get_projects_list for use outside 'forks'.
 + gitweb: move hard coded .git suffix out of git_get_projects_list

"gitweb" allows intermediate entries in the directory hierarchy that le=
ads
to a projects to be clicked, which in turn shows the list of projects
inside that directory.

* rt/completion-branch-edit-desc (2012-01-29) 1 commit
  (merged to 'next' on 2012-02-01 at 0627ebf)
 + completion: --edit-description option for git-branch

Originally merged to 'next' on 2012-01-31.
Will merge to 'master'.

* jn/svn-fe (2012-02-02) 47 commits
  (merged to 'next' on 2012-02-05 at e9d3917)
 + vcs-svn: suppress a -Wtype-limits warning
 + vcs-svn: allow import of > 4GiB files
 + vcs-svn: rename check_overflow arguments for clarity
  (merged to 'next' on 2012-02-01 at 9288c95)
 + vcs-svn/svndiff.c: squelch false "unused" warning from gcc
 + Merge branch 'svn-fe' of git://repo.or.cz/git/jrn into jn/svn-fe
 + vcs-svn: reset first_commit_done in fast_export_init
 + Merge branch 'db/text-delta' into svn-fe
 + vcs-svn: do not initialize report_buffer twice
 + Merge branch 'db/text-delta' into svn-fe
 + vcs-svn: avoid hangs from corrupt deltas
 + vcs-svn: guard against overflow when computing preimage length
 + Merge branch 'db/delta-applier' into db/text-delta
 + vcs-svn: implement text-delta handling
 + Merge branch 'db/delta-applier' into db/text-delta
 + Merge branch 'db/delta-applier' into svn-fe
 + vcs-svn: cap number of bytes read from sliding view
 + test-svn-fe: split off "test-svn-fe -d" into a separate function
 + vcs-svn: let deltas use data from preimage
 + vcs-svn: let deltas use data from postimage
 + vcs-svn: verify that deltas consume all inline data
 + vcs-svn: implement copyfrom_data delta instruction
 + vcs-svn: read instructions from deltas
 + vcs-svn: read inline data from deltas
 + vcs-svn: read the preimage when applying deltas
 + vcs-svn: parse svndiff0 window header
 + vcs-svn: skeleton of an svn delta parser
 + vcs-svn: make buffer_read_binary API more convenient
 + vcs-svn: learn to maintain a sliding view of a file
 + Makefile: list one vcs-svn/xdiff object or header per line
 + Merge branch 'db/svn-fe-code-purge' into svn-fe
 + vcs-svn: drop obj_pool
 + vcs-svn: drop treap
 + vcs-svn: drop string_pool
 + vcs-svn: pass paths through to fast-import
 + Merge branch 'db/strbufs-for-metadata' into db/svn-fe-code-purge
 + Merge branch 'db/length-as-hash' (early part) into db/svn-fe-code-pu=
rge
 + Merge branch 'db/vcs-svn-incremental' into svn-fe
 + vcs-svn: avoid using ls command twice
 + vcs-svn: use mark from previous import for parent commit
 + vcs-svn: handle filenames with dq correctly
 + vcs-svn: quote paths correctly for ls command
 + vcs-svn: eliminate repo_tree structure
 + vcs-svn: add a comment before each commit
 + vcs-svn: save marks for imported commits
 + vcs-svn: use higher mark numbers for blobs
 + vcs-svn: set up channel to read fast-import cat-blob response
 + Merge commit 'v1.7.5' into svn-fe

Originally merged to 'next' on 2012-01-29.

"vcs-svn"/"svn-fe" learned to read dumps with svn-deltas and support
incremental imports.

Will merge to 'master'.
