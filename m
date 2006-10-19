From: Alexander Belchenko <bialix@ukr.net>
Subject: Re: Alternate revno proposal (Was: Re: VCS comparison table)
Date: Thu, 19 Oct 2006 11:19:30 +0300
Message-ID: <eh7c5t$gd1$1@sea.gmane.org>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com> <200610170119.09066.jnareb@gmail.com> <45346290.6050300@utoronto.ca> <200610171120.09747.jnareb@gmail.com> <1161078035.9020.73.camel@localhost.localdomain> <Pine.LNX.4.64.0610170921540.3962@g5.osdl.org> <1161124078.9020.88.camel@localhost.localdomain> <20061017191838.1c36499b.seanlkml@sympatico.ca> <20061017233305.GG20017@pasky.or.cz> <1161149200.3423.34.camel@localhost.localdomain> <20061018214623.GA32725@artax.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: bazaar-ng@lists.canonical.com
X-From: git-owner@vger.kernel.org Thu Oct 19 10:20:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GaT8b-0001q5-Br
	for gcvg-git@gmane.org; Thu, 19 Oct 2006 10:20:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423100AbWJSIUV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 19 Oct 2006 04:20:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423258AbWJSIUV
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Oct 2006 04:20:21 -0400
Received: from main.gmane.org ([80.91.229.2]:55996 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1423100AbWJSIUT (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Oct 2006 04:20:19 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1GaT8F-0001kz-Hm
	for git@vger.kernel.org; Thu, 19 Oct 2006 10:20:03 +0200
Received: from 213.154.202.109 ([213.154.202.109])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 19 Oct 2006 10:20:03 +0200
Received: from bialix by 213.154.202.109 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 19 Oct 2006 10:20:03 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 213.154.202.109
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
In-Reply-To: <20061018214623.GA32725@artax.karlin.mff.cuni.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29330>

Jan Hudec =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
=2E..
>=20
> Reading this thread I came to think, that the revnos should be assign=
ed
> to _all_ revisions _available_, in order of when they entered the
> repository (there are some possible variations I will mention below)
>=20
=2E..
>  - They would be the same as subversion and svk, and IIRC mercurial a=
s
>    well, use, so:
>    - They would already be familiar to users comming from those syste=
ms.
>    - They are known to be useful that way. In fact for svk it's the o=
nly
>      way to refer to revisions and seem to work satisfactorily (thoug=
h
>      note that svk is not really suitable to ad-hoc topologies).

I think that SVN model of revision numbers is wrong. And apply it to bz=
r
break many UI habits. Per example, when ones use svn and their repo has
many branches you never could say what revisions belongs to mainline. S=
o
things like
bzr diff -rM..N
(where M and N absolute revisions numbers, and N =3D M+1(+2) etc.)
will more complicated, because in this case you first need to run log
command, remember actual numbers of those revisions.
And I each time frustrating to see that after mainline svn revision 100=
0
might be mainline revision 1020. It's very-very-very confusing. May be
only for me.

There is 2 things why I don't want to switch to svn (if I can do my own
choice): their strange tags implementation (their tags is the same as
branches, so what difference?) and their revisions numbers.

I also think that dotted revisions is not answer in this case, but it
looks very logical and nice.

I think bzr need to have a switch, a flag, probably in .bazaar.conf to
show revno to user or revid. And user can easily select what model is
more appropriate for him:

* decentralized (with revno)
* or distrubuted (with revid i.e. UUID)

> Comments?

-1 to make revno as in svn.

--
Alexander
