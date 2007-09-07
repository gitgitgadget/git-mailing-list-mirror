From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 4/3] archive: specfile syntax change: "$Format:%PLCHLDR$"
 instead of just "%PLCHLDR"
Date: Fri, 7 Sep 2007 11:44:05 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709071142340.28586@racer.site>
References: <46DC4D45.4030208@lsrfire.ath.cx> <7vtzqb8fw2.fsf@gitster.siamese.dyndns.org>
 <46DCF0EF.9020604@op5.se> <Pine.LNX.4.64.0709041139140.28586@racer.site>
 <46DDE69C.1080908@lsrfire.ath.cx> <7vzm02klip.fsf@gitster.siamese.dyndns.org>
 <46E028B9.2090908@lsrfire.ath.cx> <Pine.LNX.4.64.0709061803590.28586@racer.site>
 <46E0647A.10000@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323584-1976060211-1189161845=:28586"
Cc: Junio C Hamano <gitster@pobox.com>, Andreas Ericsson <ae@op5.se>,
	Git Mailing List <git@vger.kernel.org>,
	Michael Gernoth <simigern@cip.informatik.uni-erlangen.de>,
	Thomas Glanzmann <thomas@glanzmann.de>
To: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Fri Sep 07 12:44:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITbK9-0003us-Qw
	for gcvg-git@gmane.org; Fri, 07 Sep 2007 12:44:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965112AbXIGKoY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Sep 2007 06:44:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965106AbXIGKoY
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Sep 2007 06:44:24 -0400
Received: from mail.gmx.net ([213.165.64.20]:49119 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965102AbXIGKoX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Sep 2007 06:44:23 -0400
Received: (qmail invoked by alias); 07 Sep 2007 10:44:21 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp021) with SMTP; 07 Sep 2007 12:44:21 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18eOApw6Jge4AlVEHdBIM1auV73CtzKc1P7HsjGte
	sGWmUzg9mdFdhR
X-X-Sender: gene099@racer.site
In-Reply-To: <46E0647A.10000@lsrfire.ath.cx>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58019>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323584-1976060211-1189161845=:28586
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi,

On Thu, 6 Sep 2007, René Scharfe wrote:

> Johannes Schindelin schrieb:
> >> +
> >> +		b = memchr(a, '$', len);
> >> +		if (!b || a + len < b + 9 || memcmp(b + 1, "Format:", 7))
> >> +			break;
> > 
> > Wouldn't memmem(buffer, len, "$Format:", 8) be better here?
> 
> Oh, that's a nice GNU extension, didn't know it before.

Oh sorry, I didn't even realise that this is a GNU extension...

> > A general comment: since you plan to output the result into a file 
> > anyway, it should be even easier to avoid realloc(), and do a 
> > print_formatted_specfile() instead of a format_specfile(), no?
> 
> Hmm, not sure what you mean.  At least archive-tar needs the expanded 
> contents in a buffer (not immediately written to stdout) because it 
> tries to mimic a real tar and always writes in blocks of 10k and 
> therefore needs to buffer the output.

Yeah, I missed that.  Thanks for explaining it to me!

Ciao,
Dscho

--8323584-1976060211-1189161845=:28586--
