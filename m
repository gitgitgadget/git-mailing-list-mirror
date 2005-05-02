From: Horst von Brand <vonbrand@inf.utfsm.cl>
Subject: Re: [PATCH] add git.spec and adapt Makefile for RPM build
Date: Mon, 02 May 2005 14:58:04 -0400
Message-ID: <200505021858.j42Iw4M1029427@laptop11.inf.utfsm.cl>
References: <chrisw@osdl.org>
Cc: Kay Sievers <kay.sievers@vrfy.org>, git@vger.kernel.org,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Mon May 02 20:53:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DSg1j-0007ur-Lo
	for gcvg-git@gmane.org; Mon, 02 May 2005 20:52:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261667AbVEBS6W (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 May 2005 14:58:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261656AbVEBS6W
	(ORCPT <rfc822;git-outgoing>); Mon, 2 May 2005 14:58:22 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:60643 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S261654AbVEBS6P (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 May 2005 14:58:15 -0400
Received: from laptop11.inf.utfsm.cl (fw.inf.utfsm.cl [200.1.19.2])
	by inti.inf.utfsm.cl (8.13.1/8.13.1) with ESMTP id j42Iu9wH015382
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 2 May 2005 14:56:10 -0400
Received: from laptop11.inf.utfsm.cl (localhost.localdomain [127.0.0.1])
	by laptop11.inf.utfsm.cl (8.13.4/8.13.1) with ESMTP id j42Iw4Bf029430;
	Mon, 2 May 2005 14:58:04 -0400
Received: from laptop11.inf.utfsm.cl (vonbrand@localhost)
	by laptop11.inf.utfsm.cl (8.13.4/8.13.4/Submit) with ESMTP id j42Iw4M1029427;
	Mon, 2 May 2005 14:58:04 -0400
To: Chris Wright <chrisw@osdl.org>
In-Reply-To: Message from Chris Wright <chrisw@osdl.org> 
   of "Mon, 02 May 2005 11:39:02 MST." <20050502183902.GD5324@shell0.pdx.osdl.net> 
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0b5 (inti.inf.utfsm.cl [200.1.19.1]); Mon, 02 May 2005 14:56:10 -0400 (CLT)
X-Virus-Scanned: ClamAV version 0.83, clamav-milter version 0.83 on localhost
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Chris Wright <chrisw@osdl.org> said:
> * Horst von Brand (vonbrand@inf.utfsm.cl) wrote:
> > Kay Sievers <kay.sievers@vrfy.org> said:
> > > On Mon, May 02, 2005 at 12:23:03PM +0200, Kay Sievers wrote:

> > > This version creates the git.spec from a git.spec.in with the version
> > > number from the Makefile.

> > Please don't. The spec file /controls/ the building of the package, it
> > can't be generated as part of the build process.

> It certainly can.

Yep. Maybe "can't" was a bit too strong. "Should never be" is right.

>                   It simply means a structured release process.  IOW,
> the git.spec would be generated for a release tarball.

Come on, you have to fix the spec file for the changelog and version by
hand anyway, autoconfiscating it doesn't help one iota there.

And yes, I've seen quite a few packages autogenerating the spec file. As a
result, you /can't/ build the package from pristine sources, you have to
unpack and configure to get enough for building. For me that just isn't
acceptable, as it completely misses the point of RPM.

(You can go "rpmbuild -ta whatever-2.3.1.tar.bz2" if the tarball is set up
correctly, your idea prevents that).
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
