From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/9] builtin-verify-tag.c: use parse_options()
Date: Thu, 24 Jul 2008 18:08:26 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807241807550.8986@racer>
References: <1216849332-26813-1-git-send-email-barra_cuda@katamail.com> <1216849332-26813-2-git-send-email-barra_cuda@katamail.com> <4888B4E3.9000504@free.fr>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1833442365-1216919307=:8986"
Cc: Michele Ballabio <barra_cuda@katamail.com>, git@vger.kernel.org,
	gitster@pobox.com
To: Olivier Marin <dkr+ml.git@free.fr>
X-From: git-owner@vger.kernel.org Thu Jul 24 19:09:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KM4Jh-00046k-1C
	for gcvg-git-2@gmane.org; Thu, 24 Jul 2008 19:09:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751449AbYGXRIZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jul 2008 13:08:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750883AbYGXRIZ
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jul 2008 13:08:25 -0400
Received: from mail.gmx.net ([213.165.64.20]:49096 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750728AbYGXRIY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2008 13:08:24 -0400
Received: (qmail invoked by alias); 24 Jul 2008 17:08:22 -0000
Received: from grape.st-and.ac.uk (EHLO grape.st-and.ac.uk) [138.251.155.28]
  by mail.gmx.net (mp064) with SMTP; 24 Jul 2008 19:08:22 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18DUN9pHfcDtK6ES9whX4Wa/c1N5IaOd/cPSRAvGc
	3QkDCYYRpsO4cE
X-X-Sender: gene099@racer
In-Reply-To: <4888B4E3.9000504@free.fr>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.61
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89915>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1833442365-1216919307=:8986
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

On Thu, 24 Jul 2008, Olivier Marin wrote:

> Michele Ballabio a écrit :
> > 
> >  	if (argc == 1)
> > -		usage(builtin_verify_tag_usage);
> > +		usage_with_options(builtin_verify_tag_usage, options);
> 
> It seems this is broken since the C rewrite: "git verify-tag -v" just do
> nothing instead of printing usage message.
> 
> Moving the if() after parse_options() call with s/argc == 1/argc == 0/
> should do the trick.

That would be a bugfix.  As such, it belongs into a different commit.  
Care to provide a patch?

> > -	if (!strcmp(argv[i], "-v") || !strcmp(argv[i], "--verbose")) {
> > -		verbose = 1;
> > -		i++;
> > -	}
> > +	argc = parse_options(argc, argv, options, builtin_verify_tag_usage, 0);

Why did you quote this?

Ciao,
Dscho

--8323329-1833442365-1216919307=:8986--
