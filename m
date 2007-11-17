From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Rewrite some function exit paths to avoid "unreachable
	code" traps
Date: Sat, 17 Nov 2007 13:23:17 +0100
Message-ID: <20071117122317.GA2716@steel.home>
References: <Pine.LNX.4.64.0711152317140.7416@bianca.dialin.t-online.de> <Pine.LNX.4.64.0711162346270.7281@bianca.dialin.t-online.de> <20071117094617.GD4086@steel.home> <200711171139.32631.robin.rosenberg.lists@dewire.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Guido Ostkamp <git@ostkamp.fastmail.fm>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Sat Nov 17 13:23:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ItMi4-0003zo-8R
	for gcvg-git-2@gmane.org; Sat, 17 Nov 2007 13:23:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754449AbXKQMXX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 17 Nov 2007 07:23:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754847AbXKQMXX
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Nov 2007 07:23:23 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:54244 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754449AbXKQMXW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Nov 2007 07:23:22 -0500
Received: from tigra.home (Fcbd3.f.strato-dslnet.de [195.4.203.211])
	by post.webmailer.de (mrclete mo24) (RZmta 14.0)
	with ESMTP id v026b0jAH6t7RT ; Sat, 17 Nov 2007 13:23:18 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 3C514277AE;
	Sat, 17 Nov 2007 13:23:18 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id 94F0556D22; Sat, 17 Nov 2007 13:23:17 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <200711171139.32631.robin.rosenberg.lists@dewire.com>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaHqBg+Ffo=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65269>

Robin Rosenberg, Sat, Nov 17, 2007 11:39:32 +0100:
> l=F6rdag 17 november 2007 skrev Alex Riesen:
> > Noticed by Guido Ostkamp for Sun's Workshop cc.
> >=20
> > Originally-by: Guido Ostkamp <git@ostkamp.fastmail.fm>
> > Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
> > ---
> > Guido Ostkamp, Fri, Nov 16, 2007 23:52:01 +0100:
> > >
> > > What about the xdiff/xdiffi.c problem that should also be solved?
> > >
> >=20
>=20
> Please... This just looks bad. I'm sure we'll have fixup patches on t=
he list
> to fix those gotos.=20
>=20
> Do we support any such stupid compiler that requires a dummy goto?

It is more for the compilers we don't know about yet.

Userspace programming, especially with intent to be portable, often
means supporting *bugs* of the platform where it happens.
