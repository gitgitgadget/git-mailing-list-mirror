From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (topics)
Date: Sat, 19 Jul 2008 18:58:55 -0700
Message-ID: <7v3am5iae8.fsf@gitster.siamese.dyndns.org>
References: <7vlk4snpj3.fsf@gitster.siamese.dyndns.org>
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
 <7vlk01hqzz.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 20 04:00:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKODd-00014f-3S
	for gcvg-git-2@gmane.org; Sun, 20 Jul 2008 04:00:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755011AbYGTB7F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Jul 2008 21:59:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754956AbYGTB7E
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Jul 2008 21:59:04 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:39644 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754870AbYGTB7B (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jul 2008 21:59:01 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 3E35232F45;
	Sat, 19 Jul 2008 21:59:00 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id DD8AB32F44; Sat, 19 Jul 2008 21:58:57 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 6BAA3E72-55FF-11DD-ACBA-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89151>

Here are the topics that have been cooking.  Commits prefixed
with '-' are only in 'pu' while commits prefixed with '+' are
in 'next'.

The topics list the commits in reverse chronological order.  The topics
meant to be merged to the maintenance series have "maint-" in their names.

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

No real activity on 'next', as I was busy tending bugfixes and pushing out
v1.5.6.4 today.

----------------------------------------------------------------
[Will merge to "master" soon]

* ns/am-abort (Wed Jul 16 19:39:10 2008 +0900) 1 commit
 + git am --abort

This one is for Ted; builds on top of the recent "am and rebase leaves
ORIG_HEAD just like reset, merge and pull does" rather nicely.

* jc/rerere-auto-more (Wed Jul 16 20:25:18 2008 -0700) 1 commit
 + rerere.autoupdate: change the message when autoupdate is in effect

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
 + Reword "your branch has diverged..." lines to reduce line length

----------------------------------------------------------------
[Stalled/Needs more work]

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

* pb/submodule (Wed Jul 16 21:11:40 2008 +0200) 7 commits
 . t7403: Submodule git mv, git rm testsuite
 . git rm: Support for removing submodules
 . git mv: Support moving submodules
 . submodule.*: Introduce simple C interface for submodule lookup by
   path
 . git submodule add: Fix naming clash handling
 . t7400: Add short "git submodule add" testsuite
 . git-mv: Remove dead code branch

Long overdue usability improvement series for submodule.  Very much
welcomed.  It would be nice to have some submodule improvements in 1.6.0,
but it would take us a few more rounds to hit 'next' with this, and it
will not be in 'master' when 1.6.0 ships.

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

----------------------------------------------------------------
[Will drop]

* xx/merge-in-c-into-next (Wed Jul 9 13:51:46 2008 -0700) 4 commits
 + Teach git-merge -X<option> again.
 + Merge branch 'jc/merge-theirs' into xx/merge-in-c-into-next
 + builtin-merge.c: use parse_options_step() "incremental parsing"
   machinery
 + Merge branch 'ph/parseopt-step-blame' into xx/merge-in-c-into-next

* jc/merge-theirs (Fri Jul 18 02:43:00 2008 -0700) 6 commits
 - Document that merge strategies can now take their own options
 + Make "subtree" part more orthogonal to the rest of merge-
   recursive.
 + Teach git-pull to pass -X<option> to git-merge
 + Teach git-merge to pass -X<option> to the backend strategy module
 + git-merge-recursive-{ours,theirs}
 + git-merge-file --ours, --theirs

It appears nobody wants "theirs" nor "ours", so I'll soon apply a
wholesale revert for these series to 'next', and then these will be
dropped when we rewind 'next' after 1.6.0 final.

Please make sure next time somebody asks "ours/theirs" merge on the list
and #git s/he is quickly told that it was unanimously rejected so that
people do not have to waste time rehashing the topic ever again.

----------------------------------------------------------------
[On Hold]

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
