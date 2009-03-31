From: Magnus =?iso-8859-1?Q?B=E4ck?= <baeck@swipnet.se>
Subject: Re: Implementing stat() with FindFirstFile()
Date: Tue, 31 Mar 2009 22:32:48 +0200
Message-ID: <20090331203248.GE27249@jeeves.jpl.local>
References: <200903212055.15026.j6t@kdbg.org> <20090324215416.GB27249@jeeves.jpl.local> <49CB2BA5.1070100@viscovery.net> <20090326213907.GC27249@jeeves.jpl.local> <alpine.DEB.1.00.0903270320020.10279@pacific.mpi-cbg.de> <20090329224803.GD27249@jeeves.jpl.local> <alpine.DEB.1.00.0903300245080.6454@intel-tinevez-2-302> <20090330051118.GA2681@atjola.homenet> <20090330220709.GA68118@macbook.lan> <alpine.DEB.1.00.0903310128410.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Heiko Voigt <hvoigt@hvoigt.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>,
	Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Mar 31 22:34:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LokfC-0002r5-It
	for gcvg-git-2@gmane.org; Tue, 31 Mar 2009 22:34:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753985AbZCaUcz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 31 Mar 2009 16:32:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752841AbZCaUcz
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Mar 2009 16:32:55 -0400
Received: from proxy3.bredband.net ([195.54.101.73]:49084 "EHLO
	proxy3.bredband.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751957AbZCaUcy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Mar 2009 16:32:54 -0400
Received: from ironport2.bredband.com (195.54.101.122) by proxy3.bredband.net (7.3.139)
        id 49CB852D003015DA for git@vger.kernel.org; Tue, 31 Mar 2009 22:32:51 +0200
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AjYFANsa0klT4/BMPGdsb2JhbACBU5QtAQEBAR4iuECDegY
X-IronPort-AV: E=Sophos;i="4.39,304,1235948400"; 
   d="scan'208";a="469485159"
Received: from ua-83-227-240-76.cust.bredbandsbolaget.se (HELO elwood.jpl.local) ([83.227.240.76])
  by ironport2.bredband.com with ESMTP; 31 Mar 2009 22:32:51 +0200
Received: from jeeves.jpl.local (jeeves.jpl.local [192.168.7.3])
	by elwood.jpl.local (Postfix) with ESMTP id C2258422AF;
	Tue, 31 Mar 2009 22:32:49 +0200 (CEST)
Received: by jeeves.jpl.local (Postfix, from userid 100)
	id 1266F3C2D; Tue, 31 Mar 2009 22:32:48 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0903310128410.10279@pacific.mpi-cbg.de>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115312>

On Tuesday, March 31, 2009 at 01:29 CEST,
     Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:

> On Tue, 31 Mar 2009, Heiko Voigt wrote:
>=20
> > On Mon, Mar 30, 2009 at 07:11:18AM +0200, Bj=F6rn Steinbrink wrote:
> >
> > > Not official documentation, but at least from some MS guy it seem=
s:=20
> > > http://www.osronline.com/showThread.cfm?link=3D73086 (last messag=
e).
> > >=20
> > > Apparently, it was in NT3.x, but they document only what's actual=
ly=20
> > > defined in the header.
> >=20
> > How about runtime checking? You could do GetProcAddress(...) and if
> > you don't get it use the old behaviour. I mean if it really is
> > faster why not let Users of recent systems benefit from it.
>=20
> While my first reaction was negative, I have to admit that thinking
> about it longer, it does seem to make a whole lot of sense.

If anything worries me it's forward compatibility should Microsoft
change the function signature. Backwards compatibility can always
be guaranteed by using GetProcAddress(). Again, I would be very
surprised but IF it could be quite fatal.

Anyway, we don't know for sure if it's faster or if it fixes the DST
problem of FindFirstFile(). I'll write some code to try it out.

--=20
Magnus B=E4ck
baeck@swipnet.se
