From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-bisect failure
Date: Sat, 10 Sep 2005 15:13:34 -0700
Message-ID: <7vu0gsefld.fsf@assigned-by-dhcp.cox.net>
References: <20050909011034.12f2bf64.akpm@osdl.org>
	<7virx9ir3a.fsf@assigned-by-dhcp.cox.net>
	<20050910022638.20832803.akpm@osdl.org>
	<Pine.LNX.4.58.0509101202070.30958@g5.osdl.org>
	<20050910141343.578649c7.akpm@osdl.org>
	<7vfyscfvoj.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 11 00:15:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EEDbr-0000cQ-T8
	for gcvg-git@gmane.org; Sun, 11 Sep 2005 00:14:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932321AbVIJWNl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Sep 2005 18:13:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932336AbVIJWNl
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Sep 2005 18:13:41 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:7903 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S932321AbVIJWNk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Sep 2005 18:13:40 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050910221335.RRZ3588.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 10 Sep 2005 18:13:35 -0400
To: Andrew Morton <akpm@osdl.org>
In-Reply-To: <7vfyscfvoj.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sat, 10 Sep 2005 14:40:44 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8264>

The one I am going to put in the "master" branch later today
will give you the attached transcript.

Highlights:

 * After bisecting and checking out a revision to try out, it
   tells you which revision you are about to test.

 * It keeps a log in $GIT_DIR/BISECT_LOG as you suggested.  This
   is a shell script so you can remove everything after you want
   to redo in an editor, save the result in a different file,
   and run it -- do not edit the file in place and run it
   because the re-run will overwrite the log file ;-).

 * Even better, 'git bisect' has a new command 'replay'.  After
   editing the log file from the previous run and saving it in a
   different file, run 'git bisect replay $that_file'.  This
   avoids checking things out repeatedly, only to overwrite with
   the next revision to be tested.

: siamese; git-bisect reset 
: siamese; git-bisect good 02b3e4e2d71b6058ec11cc01c72ac651eb3ded2b
You need to start by "git bisect start"
Do you want me to do it for you [Y/n]? y
: siamese; git-bisect bad 4e1491847ef5ca1c5a661601d5f96dcb7d90d2f0
Bisecting: 901 revisions left to test after this
[b749bfcd1be72f8cb8310e1cac12825bda029432] ppc64: update xmon helptext
: siamese; git-bisect good b749bfcd1be72f8cb8310e1cac12825bda029432
Bisecting: 451 revisions left to test after this
[439c430e3d448b16112de3f3d92bef6ee2639d89] arm26: one -g is enough for everyone
: siamese; git-bisect bad 439c430e3d448b16112de3f3d92bef6ee2639d89
Bisecting: 219 revisions left to test after this
[fae91e72b79ba9a21f0ce7551a1fd7e8984c85a6] I2C: Drop I2C_DEVNAME and i2c_clientname
: siamese; git-bisect bad fae91e72b79ba9a21f0ce7551a1fd7e8984c85a6
Bisecting: 110 revisions left to test after this
[4c139862b8831261d57de02716b92f82e5fb463b] xtensa: delete accidental file
: siamese; git-bisect bad 4c139862b8831261d57de02716b92f82e5fb463b
Bisecting: 55 revisions left to test after this
[4ad8d38342430f8b52f7a8458dce90caf8c8ca64] i386 boottime for_each_cpu broken
: siamese; git-bisect bad 4ad8d38342430f8b52f7a8458dce90caf8c8ca64
Bisecting: 28 revisions left to test after this
[6fe7f2578fb4903af79abeb29bb9b9ab5eace1b5] mips: remove timex.h for vr41xx
: siamese; git-bisect good 245067d1674d451855692fcd4647daf9fd47f82d
Bisecting: 7 revisions left to test after this
[0998e4228aca046fbd747c3fed909791d52e88eb] x86: privilege cleanup
: siamese; git-bisect good 0998e4228aca046fbd747c3fed909791d52e88eb
Bisecting: 3 revisions left to test after this
[f2f30ebca6c0c95e987cb9a1fd1495770a75432e] x86: introduce a write acessor for updating the current LDT
: siamese; git-bisect bad f2f30ebca6c0c95e987cb9a1fd1495770a75432e
Bisecting: 2 revisions left to test after this
[e9f86e351fda5b3c40192fc3990453613f160779] x86: remove redundant TSS clearing
: siamese; cat .git/BISECT_LOG 
git-bisect start
# good: [02b3e4e2d71b6058ec11cc01c72ac651eb3ded2b] Linux v2.6.13
git-bisect good 02b3e4e2d71b6058ec11cc01c72ac651eb3ded2b
# bad: [4e1491847ef5ca1c5a661601d5f96dcb7d90d2f0] Fix up ARM serial driver compile failure
git-bisect bad 4e1491847ef5ca1c5a661601d5f96dcb7d90d2f0
# good: [b749bfcd1be72f8cb8310e1cac12825bda029432] ppc64: update xmon helptext
git-bisect good b749bfcd1be72f8cb8310e1cac12825bda029432
# bad: [439c430e3d448b16112de3f3d92bef6ee2639d89] arm26: one -g is enough for everyone
git-bisect bad 439c430e3d448b16112de3f3d92bef6ee2639d89
# bad: [fae91e72b79ba9a21f0ce7551a1fd7e8984c85a6] I2C: Drop I2C_DEVNAME and i2c_clientname
git-bisect bad fae91e72b79ba9a21f0ce7551a1fd7e8984c85a6
# bad: [4c139862b8831261d57de02716b92f82e5fb463b] xtensa: delete accidental file
git-bisect bad 4c139862b8831261d57de02716b92f82e5fb463b
# bad: [4ad8d38342430f8b52f7a8458dce90caf8c8ca64] i386 boottime for_each_cpu broken
git-bisect bad 4ad8d38342430f8b52f7a8458dce90caf8c8ca64
# good: [245067d1674d451855692fcd4647daf9fd47f82d] i386: cleanup serialize msr
git-bisect good 245067d1674d451855692fcd4647daf9fd47f82d
# good: [0998e4228aca046fbd747c3fed909791d52e88eb] x86: privilege cleanup
git-bisect good 0998e4228aca046fbd747c3fed909791d52e88eb
# bad: [f2f30ebca6c0c95e987cb9a1fd1495770a75432e] x86: introduce a write acessor for updating the current LDT
git-bisect bad f2f30ebca6c0c95e987cb9a1fd1495770a75432e
: siamese; sed -e '$d' .git/BISECT_LOG >./++bisect-replay ;# botched the last one
: siamese; git-bisect reset
: siamese; sh ./++bisect-replay ;# we could replay with shell
Bisecting: 901 revisions left to test after this
[b749bfcd1be72f8cb8310e1cac12825bda029432] ppc64: update xmon helptext
Bisecting: 451 revisions left to test after this
[439c430e3d448b16112de3f3d92bef6ee2639d89] arm26: one -g is enough for everyone
Bisecting: 219 revisions left to test after this
[fae91e72b79ba9a21f0ce7551a1fd7e8984c85a6] I2C: Drop I2C_DEVNAME and i2c_clientname
Bisecting: 110 revisions left to test after this
[4c139862b8831261d57de02716b92f82e5fb463b] xtensa: delete accidental file
Bisecting: 55 revisions left to test after this
[4ad8d38342430f8b52f7a8458dce90caf8c8ca64] i386 boottime for_each_cpu broken
Bisecting: 28 revisions left to test after this
[6fe7f2578fb4903af79abeb29bb9b9ab5eace1b5] mips: remove timex.h for vr41xx
Bisecting: 7 revisions left to test after this
[0998e4228aca046fbd747c3fed909791d52e88eb] x86: privilege cleanup
Bisecting: 3 revisions left to test after this
[f2f30ebca6c0c95e987cb9a1fd1495770a75432e] x86: introduce a write acessor for updating the current LDT
: siamese; git-bisect reset
: siamese; git-bisect replay ./++bisect-replay ;# but replay command is faster.
Bisecting: 3 revisions left to test after this
[f2f30ebca6c0c95e987cb9a1fd1495770a75432e] x86: introduce a write acessor for updating the current LDT
: siamese; exit
