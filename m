From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] Windows: improve performance by avoiding a static 
 dependency on ws2_32.dll and advapi32.dll
Date: Thu, 28 Jan 2010 11:38:31 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1001281137550.3380@intel-tinevez-2-302>
References: <1264666525-4956-1-git-send-email-michael.lukashov@gmail.com>  <4B61543F.6020904@viscovery.net> <63cde7731001280218g29a63094od4f5a8135c6986a4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Michael Lukashov <michael.lukashov@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 28 11:38:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NaRln-00045y-Ec
	for gcvg-git-2@lo.gmane.org; Thu, 28 Jan 2010 11:38:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752680Ab0A1Kie (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jan 2010 05:38:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751877Ab0A1Kie
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jan 2010 05:38:34 -0500
Received: from mail.gmx.net ([213.165.64.20]:41425 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751185Ab0A1Kid (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jan 2010 05:38:33 -0500
Received: (qmail invoked by alias); 28 Jan 2010 10:38:32 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp043) with SMTP; 28 Jan 2010 11:38:32 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+kiE03J+Gk1MraKWTbDo8FIJqhBfAq5VDJkXq6pV
	SLsMk3/bICEFmy
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <63cde7731001280218g29a63094od4f5a8135c6986a4@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67000000000000004
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138245>

Hi,

On Thu, 28 Jan 2010, Michael Lukashov wrote:

> > Thanks. Due to the size of the change, I would acknowledge it only if you
> > have a proof that the reduced startup costs are noticable, for example, by
> > running the test suite.
> >
> > What's the deal with bswap? Isn't it an unrelated change? It needs some
> > better justification. It is unobvious because it is not straight-forward
> > "use pointer to function that was looked up instead of function".
> >
> > Will the result not break the MSVC build?
> >
> > -- Hannes
> >
> 
> "git status" calls ntohs function, which was loaded from ws2_32.dll
> I've noticed that bswap.h contains implementation of ntohl htonl functions,
> so I decided to add implementation of ntohs htons functions, which is
> pretty trivial.
> After that call to "git status" doesn't load ws2_32.dll

I am still not convinced of that patch, because the timings are still 
missing.

Ciao,
Dscho
