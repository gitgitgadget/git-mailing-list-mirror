From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: Commit ID in exported Tar Ball
Date: Sun, 20 May 2007 13:20:23 +0200
Message-ID: <46502EF7.6000708@lsrfire.ath.cx>
References: <20070517163803.GE4095@cip.informatik.uni-erlangen.de> <200705171857.22891.johan@herland.net> <20070517171150.GL5272@planck.djpig.de> <464F5CA2.3070809@lsrfire.ath.cx> <7vd50wv88t.fsf@assigned-by-dhcp.cox.net> <20070520035752.GG3141@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <junkio@cox.net>,
	Frank Lichtenheld <frank@lichtenheld.de>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Thomas Glanzmann <thomas@glanzmann.de>,
	Michael Gernoth <simigern@cip.informatik.uni-erlangen.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 20 13:21:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpjTH-0004gX-Hy
	for gcvg-git@gmane.org; Sun, 20 May 2007 13:21:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754783AbXETLVE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 20 May 2007 07:21:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755097AbXETLVE
	(ORCPT <rfc822;git-outgoing>); Sun, 20 May 2007 07:21:04 -0400
Received: from main.gmane.org ([80.91.229.2]:38369 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754783AbXETLVC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 May 2007 07:21:02 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HpjSt-0003JI-Lq
	for git@vger.kernel.org; Sun, 20 May 2007 13:20:43 +0200
Received: from p508e617b.dip.t-dialin.net ([80.142.97.123])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 20 May 2007 13:20:43 +0200
Received: from rene.scharfe by p508e617b.dip.t-dialin.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 20 May 2007 13:20:43 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: p508e617b.dip.t-dialin.net
User-Agent: Thunderbird 2.0.0.0 (Windows/20070326)
In-Reply-To: <20070520035752.GG3141@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47828>

Shawn O. Pearce schrieb:
> Junio C Hamano <junkio@cox.net> wrote:
>> Ren=E9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:
>>
>>> Something like the following patch?  Since we're already embedding =
the
>>> commit ID in a comment, we might as well offer creating a synthetic=
 file
>>> for it, too, if that solves a user's problem that might be difficul=
t to
>>> work around otherwise.
>=20
> What about being able to get the output of git-describe embedded
> into an archive file?  Doesn't git.git do that in its Makefile?  ;-)
>=20
> git-describe is more human-friendly than a SHA-1...

Yes, and the Makefile does even more than that: it adds a version file,
a spec file and another version file for git-gui.

The first two are probably useful for most projects that actually do
versioned releases.  We could have a simple parser that reads a
template, replaces @@VERSION@@ with a git-describe output string and
adds the result as a synthetic file to the archive.  It's not exactly
trivial -- e.g., how to specify git-describe options, template file and
synthetic name, all in one command line parameter? -- but it's doable.

I'm not sure how the git-gui version file fits in.  I guess it's just a
special case and doesn't need git-archive support?

Ren=E9
