From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
Subject: Re: Submodule object store
Date: Tue, 27 Mar 2007 13:50:29 +0200
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <20070327115029.GC12178@informatik.uni-freiburg.de>
References: <1174825838.12540.5.camel@localhost> <1174930688.5662.20.camel@localhost> <20070326183523.GG22773@admingilde.org> <200703262133.44520.Josef.Weidendorfer@gmx.de> <20070326220302.GH22773@admingilde.org> <7vfy7rvct2.fsf@assigned-by-dhcp.cox.net> <20070326231637.GJ22773@admingilde.org> <7vy7ljtwir.fsf@assigned-by-dhcp.cox.net> <20070326233603.GL22773@admingilde.org> <20070327112549.GA12178@informatik.uni-freiburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Martin Waitz <tali@admingilde.org>,
	Junio C Hamano <junkio@cox.net>,
	Josef Weidendorfer <Josef.Weidendorfer@gmx.de>,
	Eric Lesh <eclesh@ucla.edu>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 27 13:50:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWACI-00086o-CI
	for gcvg-git@gmane.org; Tue, 27 Mar 2007 13:50:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753821AbXC0Luh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 27 Mar 2007 07:50:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753823AbXC0Lug
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Mar 2007 07:50:36 -0400
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:47002 "EHLO
	atlas.informatik.uni-freiburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753821AbXC0Lug (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Mar 2007 07:50:36 -0400
Received: from login.informatik.uni-freiburg.de ([132.230.151.6])
	by atlas.informatik.uni-freiburg.de with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.66)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1HWAC8-0005xj-GQ; Tue, 27 Mar 2007 13:50:32 +0200
Received: from login.informatik.uni-freiburg.de (localhost [127.0.0.1])
	by login.informatik.uni-freiburg.de (8.13.8+Sun/8.12.11) with ESMTP id l2RBoTij013445;
	Tue, 27 Mar 2007 13:50:29 +0200 (MEST)
Received: (from zeisberg@localhost)
	by login.informatik.uni-freiburg.de (8.13.8+Sun/8.12.11/Submit) id l2RBoTpP013444;
	Tue, 27 Mar 2007 13:50:29 +0200 (MEST)
Mail-Followup-To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@informatik.uni-freiburg.de>,
	Martin Waitz <tali@admingilde.org>, Junio C Hamano <junkio@cox.net>,
	Josef Weidendorfer <Josef.Weidendorfer@gmx.de>,
	Eric Lesh <eclesh@ucla.edu>, Matthieu Moy <Matthieu.Moy@imag.fr>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20070327112549.GA12178@informatik.uni-freiburg.de>
User-Agent: Mutt/1.5.14+cvs20070315 (2007-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43269>

Hallo again,

Uwe Kleine-K=F6nig wrote:
> > I want to be able to list all objects which are not reachable in th=
e
> > object store, without traversing all submodules at the same time.
> > The only way I can think of to achieve this is to have one separate
> > object store per submodule and then do the traversal per submodule.
> I might have understood something wrongly, but to list objects that a=
re
> not reachable you need to traverse all trees anyhow, don't you. =20
>=20
> Then how big is the difference between a directory and an submodule?
> I'd expect it's not so big if the submodules included in different
> revisions of the supermodule share most of their history.  Of course =
you
> need to exploit that.  Thinking again that might be the problem?
I didn't look at the code, but an other issue might be:

If you separate the odbs e.g by the pathname of the subproject, what
happens if I choose to move the linux kernel in my embedded Linux
project from /linux to /kernel/linux?

Or maybe worse:  If I currently track the Kernel in a tree (because of
git lacking submodule support) and switch to submodule.  Then
linux/Makefile has to exist in both the supermodule's and the
submodule's odb.

Best regards
Uwe

--=20
Uwe Kleine-K=F6nig

http://www.google.com/search?q=3D30+hours+and+4+days+in+seconds
