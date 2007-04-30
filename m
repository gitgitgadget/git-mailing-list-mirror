From: Alexander Klink <ak-git@cynops.de>
Subject: Re: git-svn failure when symlink added in svn
Date: Mon, 30 Apr 2007 02:24:00 +0200
Message-ID: <20070430.d5c3a79fadd867d739e056ce9bc80eea@cynops.de>
References: <alpine.LFD.0.98.0704271100321.9964@woody.linux-foundation.org> <loom.20070428T144858-521@post.gmane.org> <7virbgjthr.fsf@assigned-by-dhcp.cox.net> <m2odl8fjv1.fsf@ziti.fhcrc.org> <7v7irwjql6.fsf@assigned-by-dhcp.cox.net> <m2k5vwfbf6.fsf@ziti.fhcrc.org> <7vwszwi0h2.fsf@assigned-by-dhcp.cox.net> <20070429183136.GE12375@untitled> <7vr6q2dhex.fsf@assigned-by-dhcp.cox.net> <20070429222136.GA1800@untitled>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <junkio@cox.net>,
	Seth Falcon <sethfalcon@gmail.com>,
	Alexander Klink <ak-git@cynops.de>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Mon Apr 30 02:57:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HiKDA-0002TR-G5
	for gcvg-git@gmane.org; Mon, 30 Apr 2007 02:57:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422675AbXD3A5q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 29 Apr 2007 20:57:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422710AbXD3A5q
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Apr 2007 20:57:46 -0400
Received: from cynops.eu ([82.149.225.69]:41420 "EHLO mail.cynops.de"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1422707AbXD3A5p (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Apr 2007 20:57:45 -0400
X-Greylist: delayed 1989 seconds by postgrey-1.27 at vger.kernel.org; Sun, 29 Apr 2007 20:57:44 EDT
Received: from cy10loc.cynops.de (cy10loc [172.16.0.10])
	by mail.cynops.de (Postfix) with ESMTP id 8856B6C89F;
	Mon, 30 Apr 2007 02:24:31 +0200 (CEST)
Received: from localhost (unknown [172.16.0.6])
	by cy10loc.cynops.de (Postfix) with ESMTP id 12BD3C8041;
	Mon, 30 Apr 2007 02:24:31 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070429222136.GA1800@untitled>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45850>

Hi,

On Sun, Apr 29, 2007 at 03:21:36PM -0700, Eric Wong wrote:
> >  	my $path =3D $self->git_path($fb->{path});
> >  	if (my $fh =3D $fb->{fh}) {
> > -		seek($fh, 0, 0) or croak $!;
> > +		sysseek($fh, 0, 0) or croak $!;
> >  		my $md5 =3D Digest::MD5->new;
> >  		$md5->addfile($fh);
>=20
> We may want to keep the plain seek() here and do both seek and syssee=
k,
> I'm not sure if $md5->addfile() uses read or sysread internally.
I've just had a quick look: it uses read.
Junio: I'll test the patch tomorrow or the day after tommorow and
let you know whether it works for me. Thanks for the quick fix(es) ...

Best regards,
    Alex
--=20
Dipl.-Math. Alexander Klink | IT-Security Engineer |    a.klink@cynops.=
de
 mobile: +49 (0)178 2121703 |          Cynops GmbH | http://www.cynops.=
de
----------------------------+----------------------+-------------------=
--
      HRB 7833, Amtsgericht | USt-Id: DE 213094986 |     Gesch=E4ftsf=FC=
hrer:
     Bad Homburg v. d. H=F6he |                      |      Martin Bart=
osch
