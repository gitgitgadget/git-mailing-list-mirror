From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Jul 2008, issue #10; Sat, 26)
Date: Sat, 26 Jul 2008 00:35:41 -0700
Message-ID: <7vwsj9jdwy.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 26 09:36:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMeKe-0004s4-P7
	for gcvg-git-2@gmane.org; Sat, 26 Jul 2008 09:36:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751285AbYGZHfs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jul 2008 03:35:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751161AbYGZHfs
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Jul 2008 03:35:48 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:53692 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750796AbYGZHfr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jul 2008 03:35:47 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 3FBE43C95F;
	Sat, 26 Jul 2008 03:35:46 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 5C0FE3C95E; Sat, 26 Jul 2008 03:35:43 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 75D7AFC0-5AE5-11DD-85AD-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90193>

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

 - 1.6.0-rc1 (Jul 27)
 - 1.6.0-rc2 (Aug  6)
 - 1.6.0-rc3 (Aug 10)

----------------------------------------------------------------
[New Topics]

* cc/bisect (Tue Jul 22 08:16:18 2008 +0200) 2 commits
 . bisect: only check merge bases when needed
 . bisect: test merge base if good rev is not an ancestor of bad rev

* jc/add-addremove (Tue Jul 22 22:30:40 2008 -0700) 2 commits
 + builtin-add.c: optimize -A option and "git add ."
 + builtin-add.c: restructure the code for maintainability

* jk/pager-swap (Tue Jul 22 03:14:12 2008 -0400) 2 commits
 + spawn pager via run_command interface
 + run-command: add pre-exec callback

* ph/enable-threaded (Mon Jul 21 11:23:43 2008 +0200) 1 commit
 + Enable threaded delta search on *BSD and Linux.

----------------------------------------------------------------
[Cooking]

* pb/sane-mv (Mon Jul 21 02:25:56 2008 +0200) 2 commits
 - git-mv: Keep moved index entries inact
 - git-mv: Remove dead code branch

Running "git mv A B" when you have local changes to A automatically staged
it while moving it to B, which was a longstanding nonsense.  This attempts
to fix it.  Pasky has other plans to build on a more solidified foundation
to enhance the command to work with submodules better on top of this.

I think this is of 'next' quality already.

* rs/imap (Wed Jul 9 22:29:02 2008 +0100) 5 commits
 + Documentation: Improve documentation for git-imap-send(1)
 + imap-send.c: more style fixes
 + imap-send.c: style fixes
 + git-imap-send: Support SSL
 + git-imap-send: Allow the program to be run from subdirectories of
   a git tree

Some people seem to prefer having this feature available also with gnutls.
Such an enhancement can be done in-tree on top of this series if they are
so inclined.

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
 . diff: enable "too large a rename" warning when -M/-C is explicitly
   asked for

This would be the right thing to do for command line use, but gitk will be
hit due to tcl/tk's limitation, so I am holding this back for now.

----------------------------------------------------------------
[Dropped]

There are a handful topics that used to be in 'pu' but tentatively dropped
for now.

*^ cc/bisect (Tue Jul 22 08:16:18 2008 +0200) 2 commits
*^ gi/cherry-cache (Sat Jul 12 20:14:51 2008 -0700) 1 commit
*^ jc/grafts (Wed Jul 2 17:14:12 2008 -0700) 1 commit
*^ sb/sequencer (Tue Jul 1 04:38:34 2008 +0200) 4 commits

I still hold onto their tips and intend to update them with newer versions
and/or merge them back to 'pu' when I have time, but not right now.
