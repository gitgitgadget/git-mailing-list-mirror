From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 3/3] Enable parallel tests
Date: Fri, 8 Aug 2008 12:37:25 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0808081236010.9611@pacific.mpi-cbg.de.mpi-cbg.de>
References: <alpine.DEB.1.00.0808080752210.9611@pacific.mpi-cbg.de.mpi-cbg.de> <alpine.DEB.1.00.0808080754230.9611@pacific.mpi-cbg.de.mpi-cbg.de> <489BF95F.1070000@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1523327906-1218191847=:9611"
Cc: git@vger.kernel.org, gitster@pobox.com
To: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Fri Aug 08 12:33:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRPIC-0004KE-Ec
	for gcvg-git-2@gmane.org; Fri, 08 Aug 2008 12:33:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753066AbYHHKcy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Aug 2008 06:32:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753153AbYHHKcx
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Aug 2008 06:32:53 -0400
Received: from mail.gmx.net ([213.165.64.20]:33302 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752779AbYHHKcx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Aug 2008 06:32:53 -0400
Received: (qmail invoked by alias); 08 Aug 2008 10:32:51 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp019) with SMTP; 08 Aug 2008 12:32:51 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+JqMwqDlGJLIBq55JogqfNqMX1YeA+YYqxwZHlwG
	6ej/IonsTwJbZJ
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <489BF95F.1070000@lsrfire.ath.cx>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.5600000000000001
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91650>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1523327906-1218191847=:9611
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

On Fri, 8 Aug 2008, René Scharfe wrote:

> Johannes Schindelin schrieb:
> 
> > This commit does so, by inspecting the MAKEFLAGS variable to detect if 
> > the option "-j" or "--jobs" was passed to make.  In that case, the 
> > test is run with the new "--parallel" option.
> 
> How about making the test harness be able to run multiple tests in
> parallel by default, i.e. always use a different trash directory name
> for each test, without adding the new option?  The implementation would
> be a bit simpler (no -j detection needed) and the documentation would be
> simpler, too.

I am totally opposed to dropping the -j detection.  This is what cost me 3 
hours to research/implement.  *sighs*

> >  	*)
> >  		break ;;
> >  	esac
> > @@ -449,6 +454,11 @@ test_done () {
> >  		# we will leave things as they are.
> >  
> >  		say_color pass "passed all $msg"
> > +
> > +		test ! -z = "$remove_trash" &&
> 
> This test succeeds always, because = is not an empty string.

Thanks.

Ciao,
Dscho

--8323329-1523327906-1218191847=:9611--
