From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (topics)
Date: Tue, 15 Jul 2008 20:33:13 -0700
Message-ID: <7vfxqawlja.fsf@gitster.siamese.dyndns.org>
References: <7vlk4snpj3.fsf@gitster.siamese.dyndns.org>
 <7vabjm1a0q.fsf@gitster.siamese.dyndns.org>
 <7vr6crj0jk.fsf@gitster.siamese.dyndns.org>
 <7vmyn4hr8f.fsf@gitster.siamese.dyndns.org>
 <7vmymsjz6x.fsf@gitster.siamese.dyndns.org>
 <7vabijxhk4.fsf@gitster.siamese.dyndns.org>
 <7vwslhg8qe.fsf@gitster.siamese.dyndns.org>
 <7vhccfiksy.fsf@gitster.siamese.dyndns.org>
 <7vod6k6zg4.fsf@gitster.siamese.dyndns.org>
 <7v4p7xwsfp.fsf@gitster.siamese.dyndns.org>
 <7v3anb19n7.fsf@gitster.siamese.dyndns.org>
 <7vwskjazql.fsf@gitster.siamese.dyndns.org>
 <7vk5ggipuw.fsf@gitster.siamese.dyndns.org>
 <7vej6l3lp7.fsf@gitster.siamese.dyndns.org>
 <7vod5kd3im.fsf@gitster.siamese.dyndns.org>
 <7v3amv1e8n.fsf@gitster.siamese.dyndns.org>
 <7vprpwhp7t.fsf@gitster.siamese.dyndns.org>
 <7vlk0ffhw3.fsf@gitster.siamese.dyndns.org>
 <7vtzf1w0rj.fsf@gitster.siamese.dyndns.org>
 <7vabgqsc37.fsf@gitster.siamese.dyndns.org>
 <7vtzetjbif.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 16 05:34:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIxmW-0001Am-Rx
	for gcvg-git-2@gmane.org; Wed, 16 Jul 2008 05:34:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754550AbYGPDdV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jul 2008 23:33:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754382AbYGPDdV
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jul 2008 23:33:21 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:53350 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750770AbYGPDdT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2008 23:33:19 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id C8B932D69F;
	Tue, 15 Jul 2008 23:33:18 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id BF2E52D69E; Tue, 15 Jul 2008 23:33:15 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: EEC9CEDC-52E7-11DD-896F-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88635>

Here are the topics that have been cooking.  Commits prefixed
with '-' are only in 'pu' while commits prefixed with '+' are
in 'next'.

The topics list the commits in reverse chronological order.  The topics
meant to be merged to the maintenance series have "maint-" in their names.

It so happens that the topics clearly separated between the ones that are
obviously ready for 1.6.0 and the others that aren't yet as of tonight.
It seems that it is a good time to draw that line and tag -rc0 tomorrow,
after merging the remaining topics in 'next'.

----------------------------------------------------------------
[New Topics]

I could apply these directly to master, but I am just playing it safe.

* sp/maint-index-pack (Tue Jul 15 04:45:34 2008 +0000) 4 commits
 + index-pack: Honor core.deltaBaseCacheLimit when resolving deltas
 + index-pack: Track the object_entry that creates each base_data
 + index-pack: Chain the struct base_data on the stack for traversal
 + index-pack: Refactor base arguments of resolve_delta into a struct

* rs/rebase-checkout-not-so-quiet (Mon Jul 14 14:05:35 2008 -0700) 1 commit
 + git-rebase: report checkout failure

* ag/blame (Wed Jul 16 02:00:58 2008 +0400) 2 commits
 + Do not try to detect move/copy for entries below threshold.
 + Avoid rescanning unchanged entries in search for copies.

This gives a drastic performance improvement to "git-blame -C -C" with
quite straightforward and obvious code change.

* rs/archive (Mon Jul 14 21:22:05 2008 +0200) 6 commits
 + archive: remove extra arguments parsing code
 + archive: unify file attribute handling
 + archive: centralize archive entry writing
 + archive: add baselen member to struct archiver_args
 + add context pointer to read_tree_recursive()
 + archive: remove args member from struct archiver

----------------------------------------------------------------
[Will merge to master soon]

* sb/dashless (Sun Jul 13 15:36:15 2008 +0200) 3 commits
 + Make usage strings dash-less
 + t/: Use "test_must_fail git" instead of "! git"
 + t/test-lib.sh: exit with small negagive int is ok with
   test_must_fail

* mv/dashless (Fri Jul 11 02:12:06 2008 +0200) 4 commits
 + make remove-dashes: apply to scripts and programs as well, not
   just to builtins
 + git-bisect: use dash-less form on git bisect log
 + t1007-hash-object.sh: use quotes for the test description
 + t0001-init.sh: change confusing directory name

* ls/mailinfo (Sun Jul 13 20:30:12 2008 +0200) 3 commits
 + git-mailinfo: use strbuf's instead of fixed buffers
 + Add some useful functions for strbuf manipulation.
 + Make some strbuf_*() struct strbuf arguments const.

----------------------------------------------------------------
[Graduated to "master"]

* sp/maint-bash-completion-optim (Mon Jul 14 00:22:03 2008 +0000) 1 commit
 + bash completion: Append space after file names have been completed

Early parts were already merged to 'master' and need to be merged down to
maint as well, as this is about a "performance bug" that has been with us
almost forever.

* ag/rewrite_one (Sat Jul 12 22:00:57 2008 +0400) 1 commit
 + Fix quadratic performance in rewrite_one.

* sp/win (Fri Jul 11 18:52:42 2008 +0200) 3 commits
 + We need to check for msys as well as Windows in add--interactive.
 + Convert CR/LF to LF in tag signatures
 + Fixed text file auto-detection: treat EOF character 032 at the end
   of file as printable

* js/merge-rr (Sat Jul 12 15:56:19 2008 +0100) 2 commits
 + Move MERGE_RR from .git/rr-cache/ into .git/
 + builtin-rerere: more carefully find conflict markers

* sb/rerere-lib (Wed Jul 9 14:58:57 2008 +0200) 2 commits
 + rerere: Separate libgit and builtin functions
 + builtin-rerere: more carefully find conflict markers

* js/maint-pretty-mailmap (Sat Jul 12 00:28:18 2008 +0100) 1 commit
 + Add pretty format %aN which gives the author name, respecting
   .mailmap

* js/more-win (Sun Jul 13 22:31:23 2008 +0200) 3 commits
 + help (Windows): Display HTML in default browser using Windows'
   shell API
 + help.c: Add support for htmldir relative to git_exec_path()
 + Move code interpreting path relative to exec-dir to new function
   system_path()

* jc/rebase-orig-head (Tue Jul 8 00:12:22 2008 -0400) 2 commits
 + Documentation: mention ORIG_HEAD in am, merge, and rebase
 + Teach "am" and "rebase" to mark the original position with
   ORIG_HEAD

* jc/branch-merged (Tue Jul 8 17:55:47 2008 -0700) 3 commits
 + branch --merged/--no-merged: allow specifying arbitrary commit
 + branch --contains: default to HEAD
 + parse-options: add PARSE_OPT_LASTARG_DEFAULT flag

* om/rerere-careful (Mon Jul 7 14:42:48 2008 +0200) 1 commit
 + builtin-rerere: more carefully find conflict markers

* ls/maint-mailinfo-patch-label (Thu Jul 10 23:41:33 2008 +0200) 1 commit
 + git-mailinfo: Fix getting the subject from the in-body [PATCH]
   line

* mv/merge-in-c (Mon Jul 14 00:09:41 2008 -0700) 20 commits
 + reduce_heads(): protect from duplicate input
 + reduce_heads(): thinkofix
 + Add a new test for git-merge-resolve
 + t6021: add a new test for git-merge-resolve
 + Teach merge.log to "git-merge" again
 + Build in merge
 + Fix t7601-merge-pull-config.sh on AIX
 + git-commit-tree: make it usable from other builtins
 + Add new test case to ensure git-merge prepends the custom merge
   message
 + Add new test case to ensure git-merge reduces octopus parents when
   possible
 + Introduce reduce_heads()
 + Introduce get_merge_bases_many()
 + Add new test to ensure git-merge handles more than 25 refs.
 + Introduce get_octopus_merge_bases() in commit.c
 + git-fmt-merge-msg: make it usable from other builtins
 + Move read_cache_unmerged() to read-cache.c
 + Add new test to ensure git-merge handles pull.twohead and
   pull.octopus
 + Move parse-options's skip_prefix() to git-compat-util.h
 + Move commit_list_count() to commit.c
 + Move split_cmdline() to alias.c

----------------------------------------------------------------
[On Hold]

* rs/imap (Wed Jul 9 22:29:02 2008 +0100) 5 commits
 - Documentation: Improve documentation for git-imap-send(1)
 - imap-send.c: more style fixes
 - imap-send.c: style fixes
 - git-imap-send: Support SSL
 - git-imap-send: Allow the program to be run from subdirectories of
   a git tree

Some people seem to prefer having this feature available also with gnutls.
If such a patch materializes soon, that would be good, but otherwise I'll
merge this as-is to 'next'.  Such an enhancement can be done in-tree on
top of this series.

* xx/merge-in-c-into-next (Wed Jul 9 13:51:46 2008 -0700) 4 commits
 + Teach git-merge -X<option> again.
 + Merge branch 'jc/merge-theirs' into xx/merge-in-c-into-next
 + builtin-merge.c: use parse_options_step() "incremental parsing"
   machinery
 + Merge branch 'ph/parseopt-step-blame' into xx/merge-in-c-into-next

This needs to be merged to master iff/when merge-theirs gets merged,
but I do not think this series is widely supported, so both are on hold.

* jc/merge-theirs (Mon Jun 30 22:18:57 2008 -0700) 5 commits
 + Make "subtree" part more orthogonal to the rest of merge-
   recursive.
 + Teach git-pull to pass -X<option> to git-merge
 + Teach git-merge to pass -X<option> to the backend strategy module
 + git-merge-recursive-{ours,theirs}
 + git-merge-file --ours, --theirs

Punting a merge by discarding your own work in conflicting parts but still
salvaging the parts that are cleanly automerged.  It is likely that this
will result in nonsense mishmash, but somehow often people want this, so
here they are.  The interface to the backends is updated so that you can
say "git merge -Xours -Xsubtree=foo/bar/baz -s recursive other" now.

* sg/merge-options (Sun Apr 6 03:23:47 2008 +0200) 1 commit
 + merge: remove deprecated summary and diffstat options and config
   variables

This was previously in "will be in master soon" category, but it turns out
that the synonyms to the ones this one deletes are fairly new invention
that happend in 1.5.6 timeframe, and we cannot do this just yet.  Perhaps
in 1.7.0.

* jc/dashless (Thu Jun 26 16:43:34 2008 -0700) 2 commits
 + Revert "Make clients ask for "git program" over ssh and local
   transport"
 + Make clients ask for "git program" over ssh and local transport

This is the "botched" one.  Will be resurrected during 1.7.0 or 1.8.0
timeframe.

* jk/renamelimit (Sat May 3 13:58:42 2008 -0700) 1 commit
 - diff: enable "too large a rename" warning when -M/-C is explicitly
   asked for

This would be the right thing to do for command line use, but gitk will be
hit due to tcl/tk's limitation, so I am holding this back for now.

----------------------------------------------------------------
[Stalled/Needs more work]

* gi/cherry-cache (Sat Jul 12 20:14:51 2008 -0700) 1 commit
 . cherry: cache patch-ids to avoid repeating work

* lw/gitweb (Fri Jul 11 03:11:48 2008 +0200) 3 commits
 . gitweb: use new Git::Repo API, and add optional caching
 . Add new Git::Repo API
 . gitweb: add test suite with Test::WWW::Mechanize::CGI

* sb/sequencer (Tue Jul 1 04:38:34 2008 +0200) 4 commits
 . Migrate git-am to use git-sequencer
 . Add git-sequencer test suite (t3350)
 . Add git-sequencer prototype documentation
 . Add git-sequencer shell prototype

* jc/grafts (Wed Jul 2 17:14:12 2008 -0700) 1 commit
 - [BROKEN wrt shallow clones] Ignore graft during object transfer

Cloning or fetching from a repository from grafts did not send objects
that are hidden by grafts, but the commits in the resulting repository do
need these to pass fsck.  This fixes object transfer to ignore grafts.

Another fix is needed to git-prune so that it ignores grafts but treats
commits that are mentioned in grafts as reachable.

* jc/blame (Wed Jun 4 22:58:40 2008 -0700) 2 commits
 - blame: show "previous" information in --porcelain/--incremental
   format
 - git-blame: refactor code to emit "porcelain format" output

This is for peeling to see what's behind the blamed commit, which may or
may not help applications like gitweb.
