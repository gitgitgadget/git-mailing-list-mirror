From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (topics)
Date: Thu, 17 Jul 2008 01:08:48 -0700
Message-ID: <7vlk01hqzz.fsf@gitster.siamese.dyndns.org>
References: <7vlk4snpj3.fsf@gitster.siamese.dyndns.org>
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
 <7vfxqawlja.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 17 10:10:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJOYp-0001Hr-2y
	for gcvg-git-2@gmane.org; Thu, 17 Jul 2008 10:09:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752828AbYGQII7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jul 2008 04:08:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752945AbYGQII6
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jul 2008 04:08:58 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:57519 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752253AbYGQIIy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2008 04:08:54 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id D0ABA2F8C7;
	Thu, 17 Jul 2008 04:08:53 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 01E032F8C5; Thu, 17 Jul 2008 04:08:50 -0400 (EDT)
In-Reply-To: <7vfxqawlja.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue, 15 Jul 2008 20:33:13 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 98D974B4-53D7-11DD-AE04-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88816>

Here are the topics that have been cooking.  Commits prefixed
with '-' are only in 'pu' while commits prefixed with '+' are
in 'next'.

The topics list the commits in reverse chronological order.  The topics
meant to be merged to the maintenance series have "maint-" in their names.

Right now 'next' is very thin.  After today's new topics, perhaps except
for the submodule stuff by Pasky, are merged to 'master', we will have the
1.6.0-rc0, and from there the usual pre-release freeze begins.

Due to increased activity level from people including GSoC students, I
expect 'next' to stay somewhat more active than previous rounds during the
1.6.0-rc cycle.  The request for people who usually follow 'next' is the
same as usual, though.  After -rc1 is tagged, please run 'master' for your
daily git use instead, in order to make sure 'master' does what it claims
to do without regression.

Tentative schedule, my wishful thinking:

 - 1.6.0-rc0 (Jul 20)
 - 1.6.0-rc1 (Jul 23)
 - 1.6.0-rc2 (Jul 30)
 - 1.6.0-rc3 (Aug  6)
 - 1.6.0     (Aug 10)

----------------------------------------------------------------
[New Topics]

* jc/rerere-auto-more (Wed Jul 16 20:25:18 2008 -0700) 1 commit
 - rerere.autoupdate: change the message when autoupdate is in effect

This one is for Ingo.

This changes the message rerere issues after reusing previous conflict
resolution from "Resolved" to "Staged" when autoupdate option is in
effect.

It is envisioned that in practice, some auto resolutions are trickier and
iffier than others, and we would want to add a feature to mark individual
resolutions as "this is ok to autoupdate" or "do not autoupdate the result
using this resolution even when rerere.autoupdate is in effect" in the
future.  When that happens, these messages will make the distinction
clearer.

* ap/trackinfo (Wed Jul 16 15:19:27 2008 -0400) 1 commit
 - Reword "your branch has diverged..." lines to reduce line length

You saw the exchange on the list.  Queued is my "make it shorter and make
sure variable parts are closer to left edge of the screen" version but
better alternatives are welcome.  I suspect not many people would care too
much about details, as long as the message fits and does not waste screen
real estate.

* ns/am-abort (Wed Jul 16 19:39:10 2008 +0900) 1 commit
 - git am --abort

This one is for Ted; builds on top of the recent "am and rebase leaves
ORIG_HEAD just like reset, merge and pull does" rather nicely.

* pb/submodule (Wed Jul 16 21:11:40 2008 +0200) 7 commits
 - t7403: Submodule git mv, git rm testsuite
 - git rm: Support for removing submodules
 - git mv: Support moving submodules
 - submodule.*: Introduce simple C interface for submodule lookup by
   path
 - git submodule add: Fix naming clash handling
 - t7400: Add short "git submodule add" testsuite
 - git-mv: Remove dead code branch

Long overdue usability improvement series for submodule.  Very much
welcomed.  It would be nice to have some submodule improvements in 1.6.0.
Realistically speaking, however, I predict that it would take us a few
more rounds to hit 'next' with this, and it will not be in 'master' when
1.6.0 ships.

----------------------------------------------------------------
[Graduated to "master"]

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

This actually had a tiny regression I did not discover until I merged it
to 'master', where a fixup has already been applied.

----------------------------------------------------------------
[On Hold]

* rs/imap (Wed Jul 9 22:29:02 2008 +0100) 5 commits
 - Documentation: Improve documentation for git-imap-send(1)
 - imap-send.c: more style fixes
 - imap-send.c: style fixes
 - git-imap-send: Support SSL
 - git-imap-send: Allow the program to be run from subdirectories of
   a git tree

I said: "Some people seem to prefer having this feature available also
with gnutls.  If such a patch materializes soon, that would be good, but
otherwise I'll merge this as-is to 'next'.  Such an enhancement can be
done in-tree on top of this series."  Anybody?

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

The discussion suggested that the value of having the cache itself is
iffy, but I should pick up the updated one and look at it.

* lw/gitweb (Fri Jul 11 03:11:48 2008 +0200) 3 commits
 . gitweb: use new Git::Repo API, and add optional caching
 . Add new Git::Repo API
 . gitweb: add test suite with Test::WWW::Mechanize::CGI

* sb/sequencer (Tue Jul 1 04:38:34 2008 +0200) 4 commits
 . Migrate git-am to use git-sequencer
 . Add git-sequencer test suite (t3350)
 . Add git-sequencer prototype documentation
 . Add git-sequencer shell prototype

I haven't looked at the updated series yet.  I should, but nobody else
seems to be looking at these patches, which is somewhat depressing but
understandable.  Summer is slower ;-)

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

This is for peeling the line from the blamed version to see what's behind
it, which may or may not help applications like gitweb.
