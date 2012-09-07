From: "Joachim Schmitz" <jojo@schmitz-digital.de>
Subject: RE: poll() emulation in git
Date: Fri, 7 Sep 2012 09:23:59 +0200
Message-ID: <000d01cd8cc9$c027a070$4076e150$@schmitz-digital.de>
References: <00c001cd8b59$028e41c0$07aac540$@schmitz-digital.de> <50474001.5030407@gnu.org> <00d801cd8b6b$844bbcd0$8ce33670$@schmitz-digital.de> <50476EFD.2000500@gnu.org> <010301cd8c38$4256bb90$c70432b0$@schmitz-digital.de> <5048B3D0.2070809@gnu.org> <010a01cd8c3e$25609500$7021bf00$@schmitz-digital.de> <5048BDF6.2000602@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>, "'Junio C Hamano'" <gitster@pobox.com>,
	"'Erik Faye-Lund'" <kusmabite@gmail.com>, <bug-gnulib@gnu.org>,
	<rsbecker@nexbridge.com>
To: "'Paolo Bonzini'" <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Fri Sep 07 09:24:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T9svK-0007hw-SM
	for gcvg-git-2@plane.gmane.org; Fri, 07 Sep 2012 09:24:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756914Ab2IGHYM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Sep 2012 03:24:12 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:58951 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756896Ab2IGHYK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Sep 2012 03:24:10 -0400
Received: from DualCore (dsdf-4d0a1723.pool.mediaWays.net [77.10.23.35])
	by mrelayeu.kundenserver.de (node=mrbap1) with ESMTP (Nemesis)
	id 0LnDqv-1Tm01S1R53-00hqaQ; Fri, 07 Sep 2012 09:24:07 +0200
In-Reply-To: <5048BDF6.2000602@gnu.org>
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQIgUOmy4ZEsU7RI7VRx80YFphUkTAI89tULAgLpIAgCxd+aWgIK9t7YAl1Rw+0BjE2xCwK1qp9/lltxVzA=
Content-Language: de
X-Provags-ID: V02:K0:u47k5ox4TWJuYuVduVROBtL7jveahNmzBgpnDotBt2t
 TrZ0c/CAMS76cpWrVJYuO62yxUY1tLGltfN6Jb9R7C2Sbl+Thf
 TH3lPeBqryYaopUtsb9Gz9ikvZAukis3FWcLlGv6/6PPq0gVGV
 tqGymDS/ED3yIqIYumV/CkX1Dvid6tiWGTQ2YW+OrJ60jmR+th
 Ky/Fp9Xh27fmrOXC3n4jsulmCp4pR74JKy/6nsOoWEmJhM3wUb
 ma7PqAFSW29/FBvJ+a8ShJIff4KSVL/64iBcau67lQR7ylY+kZ
 I/oMfePRbBBKW7isHRpCiXRhUPZgIJdJE9nAvHgqWz/wYaz64r
 EhipfcqbcvSzZjHXDNtce5+7bAJRSR57eM+5Ugx0krsOhVGHef
 +WtGBHuj3kApw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204949>

> From: Paolo Bonzini [mailto:paolo.bonzini@gmail.com] On Behalf Of Paolo Bonzini
> Sent: Thursday, September 06, 2012 5:15 PM
> To: Joachim Schmitz
> Cc: git@vger.kernel.org; 'Junio C Hamano'; 'Erik Faye-Lund'; bug-gnulib@gnu.org; rsbecker@nexbridge.com
> Subject: Re: poll() emulation in git
> 
> Il 06/09/2012 16:44, Joachim Schmitz ha scritto:
> >> > Yes, it's an usleep(autocorrect * 100000) basically (poll takes
> >> > milliseconds, not micro).
> > OK, it is _supposed_ to do this usleep(), but is does not, as poll() returns early with EFAULT in this case:
> >   /* EFAULT is not necessary to implement, but let's do it in the
> >      simplest case. */
> >   if (!pfd)
> >     {
> >       errno = EFAULT;
> >       return -1;
> >     }
> >
> > poll() is doing this before calling select(), so won't sleep.
> > So there's a bug in {gnulib|git}'s poll(), right?
> >
> 
> Yes, it should be "if (!pfd && nfd)".

Are you going to fix this in gnulib?

Bye, Jojo
