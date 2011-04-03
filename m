From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: [GSoC 2011] Git Sequencer
Date: Sun, 03 Apr 2011 21:07:01 +0200
Message-ID: <1301857622.3448.134.camel@lambda>
References: <20110403172054.GA10220@kytes>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 03 21:07:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6Sdl-0005Me-Md
	for gcvg-git-2@lo.gmane.org; Sun, 03 Apr 2011 21:07:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753129Ab1DCTHG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Apr 2011 15:07:06 -0400
Received: from mailout-de.gmx.net ([213.165.64.22]:56640 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753044Ab1DCTHF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Apr 2011 15:07:05 -0400
Received: (qmail invoked by alias); 03 Apr 2011 19:07:02 -0000
Received: from erft-5d80a451.pool.mediaWays.net (EHLO [192.168.1.34]) [93.128.164.81]
  by mail.gmx.net (mp072) with SMTP; 03 Apr 2011 21:07:02 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX1/wmwpLrdXwD809lzzdJk3AdHrt3pFW/uu94fLFx/
	e26w414HcqS5DT
In-Reply-To: <20110403172054.GA10220@kytes>
X-Mailer: Evolution 2.30.3 
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170772>

Hi Ram,

first, some notes on my git-sequencer 2008 branches that can be found a=
t
http://repo.or.cz/w/git/sbeyer.git ... (Not sure if I remember
everything correctly)

I've settled to develop within the "seq-builtin-dev" branch and I
sometimes merged Junio's "master" into that branch to catch up.
The "seq-builtin-dev" branch is the important one.

Using git rebase -i (using git-sequencer) I sometimes remanaged the
branch to "seq-builtin-rfc" that should represent a snapshot of a
potential patch queue. My last rebase processes of the seq-builtin-rfc
branch were pretty unmotivated and hence messy.

I have not touched the repo very often after GSOC'08 and I stopped
touching it (as I stopped following recent Git development) "20 months
ago" apparently. Quite many things may have changed since then.

The file A_SEQUENCER_TODO_FILE (added 2009-08-03) in the repo describes
the missing and buggy pieces to fix so that _I_ (only me) would have
been 100 per cent satisfied with that git-sequencer.
http://repo.or.cz/w/git/sbeyer.git/blob/9e4b4d92f681a47e3d7ad2152d2391b=
2ab125a0c:/A_SEQUENCER_TODO_FILE
[Some notes are also "strategy notes" to get things accepted, like the
changes on "rebase -i -p" which are "not loved by everyone". ;-)]

On 2011-04-03, 22:50 +0530, Ramkumar Ramachandra wrote:=20
> * Is this a good change? Are there any forseeable issues?

I want to mention an issue that I have not foreseen before: merges.
(You need merges, for example, when doing rebase -i -p ... -p as in
--preserve-merges.)

When I began, there was code in the "next" branch that added the TODO
instructions "mark", "reset" and "merge" to do merges properly and I
based my work on it. The original pieces by J=C3=B6rg Sommer can still =
be
found here:
http://repo.or.cz/w/git/sbeyer.git/shortlog/6fabd85e8a777c26f3ae8ce11cb=
7f4265502ea7f

However, there have been strong opinions that the "mark"/"reset"/"merge=
"
instructions are ugly and unpleasant to users and not even necessary (a=
t
least for rebase--interactive... and for sequencer, maybe, maybe not).=20
Hence, the code in "next" has been rejected later.

During GSOC 2008 I regrettably underestimated the importance to
communicate with the Git folks about these things. That's one of the
main reasons the sequencer pieces did not get into master. And after
GSOC'08 I had too little time for this... :-/

Well, the merging thing is the only *real* issue I remember.

Good luck and regards,
  Stephan
