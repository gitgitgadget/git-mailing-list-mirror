From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] http-push: making HTTP push more robust and more
 user-friendly
Date: Sat, 19 Jan 2008 23:18:59 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0801192316330.5731@racer.site>
References: <1200250979-19604-1-git-send-email-gb@gbarbier.org> <7vbq7ppbyh.fsf@gitster.siamese.dyndns.org> <47921582.4040708@gbarbier.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463811741-1269028956-1200784742=:5731"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Mike Hommey <mh@glandium.org>
To: =?ISO-8859-15?Q?Gr=E9goire_Barbier?= <gb@gbarbier.org>
X-From: git-owner@vger.kernel.org Sun Jan 20 00:19:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JGMyV-00073e-0m
	for gcvg-git-2@gmane.org; Sun, 20 Jan 2008 00:19:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751292AbYASXTO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Jan 2008 18:19:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751387AbYASXTO
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Jan 2008 18:19:14 -0500
Received: from mail.gmx.net ([213.165.64.20]:60000 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751057AbYASXTN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jan 2008 18:19:13 -0500
Received: (qmail invoked by alias); 19 Jan 2008 23:19:11 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp024) with SMTP; 20 Jan 2008 00:19:11 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/N3kUOWgPNgl5brVGub7EY/PxAUEgecziN0D61lm
	mQcxDQCcjigkF2
X-X-Sender: gene099@racer.site
In-Reply-To: <47921582.4040708@gbarbier.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71142>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811741-1269028956-1200784742=:5731
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi,

On Sat, 19 Jan 2008, Grégoire Barbier wrote:

> Johannes Schindelin a écrit :
> >  It gives a better warning if the URL cannot be accessed, alright. But
> >  I hate the fact that it introduces yet another function which does a
> >  bunch of curl_easy_setopt()s only to start an active slot and check
> >  for errors.
> > 
> >  Currently, I am not familiar enough with http-push.c to suggest a
> >  proper alternative, but I suspect that the return values of the
> >  _existing_ calls to curl should know precisely why the requests
> >  failed, and _this_ should be reported.
> 
> Mike Hommey a écrit :
> > FWIW, I have a work in progress refactoring the http code, avoiding a 
> > great amount of curl_easy_setopt()s and simplifying the whole thing. 
> > It's been sitting on my hard drive during my (quite long) vacation. I 
> > will probably start working again on this soonish.
> 
> 4) I agree with Johannes. However I am not familiar enough with curl to 
> write the proper alternative. I create the new function by copy/paste of 
> an existing one. I'm not 100% sure that it has no resource leaks or 
> other bugs, but it's called only once at http-push start, and thus is 
> likely not to do heavy damage...

I agree that it is too late in the rc cycle (actually, I cannot wait for 
the end of it...) to do heavy refactoring, and this function is small 
enough that it should not hurt the refactoring effort, especially given 
that you want to work on that end anyway.

So please strike this one of my objections.

Thanks for all your work,
Dscho

---1463811741-1269028956-1200784742=:5731--
