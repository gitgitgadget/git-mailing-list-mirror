From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Implement pthread_cond_broadcast on Windows
Date: Sat, 30 Jan 2010 11:50:04 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1001301149030.4985@pacific.mpi-cbg.de>
References: <4B62CEAB.5050608@viscovery.net> <201001300054.05610.j6t@kdbg.org> <alpine.DEB.1.00.1001300328070.3749@intel-tinevez-2-302> <201001301030.36395.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	=?ISO-8859-15?Q?Zolt=E1n_F=FCzesi?= <zfuzesi@eaglet.hu>,
	git@vger.kernel.org,
	msysGit Mailinglist <msysgit@googlegroups.com>,
	Dmitry Potapov <dpotapov@gmail.com>,
	"Andrzej K. Haczewski" <ahaczewski@gmail.com>,
	Erik Faye-Lund <kusmabite@googlemail.com>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sat Jan 30 11:44:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NbAoB-00020F-EU
	for gcvg-git-2@lo.gmane.org; Sat, 30 Jan 2010 11:44:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752795Ab0A3Kn7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Jan 2010 05:43:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752776Ab0A3Kn7
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jan 2010 05:43:59 -0500
Received: from mail.gmx.net ([213.165.64.20]:46893 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751786Ab0A3Kn6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jan 2010 05:43:58 -0500
Received: (qmail invoked by alias); 30 Jan 2010 10:43:56 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp071) with SMTP; 30 Jan 2010 11:43:56 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19YQIkzO/VY/OVYcZbsbO0VQadPK5BijorP8g5dgA
	XRPwjgA4x4lALr
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <201001301030.36395.j6t@kdbg.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.56999999999999995
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138472>

Hi,

On Sat, 30 Jan 2010, Johannes Sixt wrote:

> On Samstag, 30. Januar 2010, Johannes Schindelin wrote:
>
> > On Sat, 30 Jan 2010, Johannes Sixt wrote:
> > > See http://www.cse.wustl.edu/~schmidt/win32-cv-1.html, section "The 
> > > SignalObjectAndWait solution". But note that this implementation 
> > > does not use SignalObjectAndWait (which is needed to achieve 
> > > fairness, but we do not need fairness).
> > >
> > > Note that our implementations of pthread_cond_broadcast and 
> > > pthread_cond_signal require that they are invoked with the mutex 
> > > held that is used in the pthread_cond_wait calls.
> > >
> > > Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> > > ---
> > >  Junio,
> > >
> > >  please queue this patch for 1.7.0-rc1 even though it has not 
> > >  undergone a lot of review - the result is better than a git that 
> > >  does not even build on Windows.
> >
> > As you Cc:ed the msysGit list, do you want this in 4msysgit.git, too?
> 
> I hope some clever people on the msysgit list can say aye or nay to this 
> patch. If you intend to release an msysgit that contains 5b594f4 
> (Threaded grep), then you need *something*, otherwise the build fails. 
> Whether you get that something via upstream or apply it directly is of 
> course secondary, but I prefer the former. ;)

Okay, I will just merge mingw.git's master, then, once you say that the 
fix is in.

Ciao,
Dscho
