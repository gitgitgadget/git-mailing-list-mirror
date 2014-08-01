From: Mike Stump <mikestump@comcast.net>
Subject: Re: cherry picking and merge
Date: Fri, 1 Aug 2014 16:06:10 -0700
Message-ID: <4E372CD5-33CA-4AF5-8647-F6BBC64BABA8@comcast.net>
References: <51C01AAA-3CFB-4110-BAE9-7D04CA8EE53A@comcast.net> <20140801024329.GA28914@vauxhall.crustytoothpaste.net> <53DBBFE8.8060607@gmail.com> <5AF18A76-DD3B-4B9A-BF70-EFE4BB852C3D@comcast.net> <53DBF4C9.2090905@vilain.net>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	git@vger.kernel.org
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Sat Aug 02 01:06:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XDLu9-0007iF-RJ
	for gcvg-git-2@plane.gmane.org; Sat, 02 Aug 2014 01:06:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755979AbaHAXG0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 1 Aug 2014 19:06:26 -0400
Received: from qmta06.emeryville.ca.mail.comcast.net ([76.96.30.56]:58317 "EHLO
	qmta06.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755889AbaHAXGZ convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Fri, 1 Aug 2014 19:06:25 -0400
Received: from omta01.emeryville.ca.mail.comcast.net ([76.96.30.11])
	by qmta06.emeryville.ca.mail.comcast.net with comcast
	id Zayx1o00A0EPchoA6b6RnF; Fri, 01 Aug 2014 23:06:25 +0000
Received: from [IPv6:2001:558:6045:a4:40c6:7199:cd03:b02d] ([IPv6:2001:558:6045:a4:40c6:7199:cd03:b02d])
	by omta01.emeryville.ca.mail.comcast.net with comcast
	id Zb6P1o00L2ztT3H8Mb6QHG; Fri, 01 Aug 2014 23:06:24 +0000
In-Reply-To: <53DBF4C9.2090905@vilain.net>
X-Mailer: Apple Mail (2.1878.6)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20140121; t=1406934385;
	bh=SD1NQu9TJB6Mtz8CJkDgcl9CbiQUhjPwjQhHUUrPLKA=;
	h=Received:Received:Content-Type:Mime-Version:Subject:From:Date:
	 Message-Id:To;
	b=iPzJTPIYUGM/OVWQswa26oem7/RtJKwbOu3fycRLaqLppJ5Mx8leMCaPTCRbULZAU
	 m0FsQKM3SciFlpFjrafUuL57Bibs3wz+6/p9SlybOOwJiYUTB504S2XHnIPDPvZ5rS
	 rYaJSXbbnICwSq0SYkH8NE7BKa/38tC9+Vk6my2PaWFqHasCHYIj1XtZOilB5z4LR6
	 yM3ZsrZ5CoehwvRO/VB3AthbPq9nNAnO9CQV/gG9w3iZ2yKYmR0YMl2ZG6uMb/suC6
	 /EgCybJzaw0ywCxYgTKCsz6QO/P0HGa5BPlua0V47tX3sl/PtJWHo49uh6+AZe7qZ/
	 WNBRKcXY2zawA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254680>

On Aug 1, 2014, at 1:12 PM, Sam Vilain <sam@vilain.net> wrote:
> Git merge has a notion of discrete "merge strategies=94.

> There's no particular reason that you couldn't implement a merge
> strategy which works more like SVN's approach, which essentially does=
 an
> internal rebase and then commits the result.

Well, being a simple user, wanting to do a simple thing, I want the def=
ault strategy to just work.  The expert that wants it to work faster, b=
ut less well, well, they can use a merge -s faster, or cherry-pick -s f=
aster.

> However, there are corresponding disadvantages to this strategy.  It'=
s
> just as easy to contrive a situation where this "internal rebasing"
> doesn't do the right thing, even without cheating by getting the
> metadata wrong.

I sketched a solution using branches=85  A large portion of the failure=
s that happen when a cherry is remerged are gone.  I feel that benefit =
easily swamps the problem you sketched.

> And besides, there's already a way to do this: do an actual rebase.

One problem is that rebase doesn=92t work with co-workers nicely=85  Th=
e other is that it isn=92t spelled merge.  I am a simple user.

>> I was curious if svn handles this better the same or worse, and it d=
id it just fine.  I know that a while ago, svn could not handle this, i=
t would do what git does currently.  Apparently they figured out it was=
 a bug and fixed it.  Have you guys figured out it is a bug yet?  The f=
irst step in solving a problem, is admitting you have a problem.
>=20
> So, I have to chuckle when I read this indignant comment.

:-)  Yeah, a chuckle, good.  Actually, no anger is involved.  I=92d jus=
t like for git to work better in this regard.