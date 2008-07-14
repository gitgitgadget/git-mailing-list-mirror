From: Jean-Luc Herren <jlh@gmx.ch>
Subject: Re: Git describe question
Date: Tue, 15 Jul 2008 00:29:35 +0200
Message-ID: <487BD34F.4080201@gmx.ch>
References: <20080714085557.246f52b9@crow>	<7vvdz8hp3d.fsf@gitster.siamese.dyndns.org> <20080714092040.4090046b@crow>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Mark Burton <markb@ordern.com>
X-From: git-owner@vger.kernel.org Tue Jul 15 00:30:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIWZ5-0001cF-Nv
	for gcvg-git-2@gmane.org; Tue, 15 Jul 2008 00:30:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756043AbYGNW3k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jul 2008 18:29:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756029AbYGNW3j
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jul 2008 18:29:39 -0400
Received: from mail.gmx.net ([213.165.64.20]:44974 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756013AbYGNW3j (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2008 18:29:39 -0400
Received: (qmail invoked by alias); 14 Jul 2008 22:29:37 -0000
Received: from 5-177.0-85.cust.bluewin.ch (EHLO [192.168.123.202]) [85.0.177.5]
  by mail.gmx.net (mp042) with SMTP; 15 Jul 2008 00:29:37 +0200
X-Authenticated: #14737133
X-Provags-ID: V01U2FsdGVkX19NGBwMJAxNhE1m9pGV6sM9Az7V2Gm6RReh+NeT/9
	ep87u8yGokka2Y
User-Agent: Thunderbird 2.0.0.14 (X11/20080505)
In-Reply-To: <20080714092040.4090046b@crow>
X-Enigmail-Version: 0.95.6
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.61
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88473>

Mark Burton wrote:
> Ok, I understand what it's doing now - but that makes me wonder if it
> would be useful/possible to be able to specify that git describe only
> considers the commits on top of the tag for the current (or some
> specified branch). i.e. at the moment, gitk shows 8 commits on top of
> v1.5.6.3 in the master branch.

Are you saying "git describe" should output v1.5.6.3-8-g10ce020?
That would be misleading and even wrong.  This would be like
saying that there are only 8 commits of difference between
v1.5.6.3 and 10ce20, which is not true.  The differences between
those two commits are over 300 single commits and that's also what
"git (log|diff) v1.5.6.3..10ce20" will tell you.  All 300+ commits
that have been made to the branch master since the branch maint
forked off are part of 10ce20, but not part of v1.5.6.3.  It seems
fine to me that "git describe" reflects this difference.

> As the master branch is the checked out branch and the v1.5.6.3 tag
> tags a commit in that branch (via the merge) [...]

I don't think people usually say "tag X is on branch Y", excepted
maybe if Y has never been merged anywhere.  Specifically, nobody
would say v1.5.6.3 is *on* branch master.  But it's part of its
history.  v1.5.6.3 is *on* maint, at best.

jlh
