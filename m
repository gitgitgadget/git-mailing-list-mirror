From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Respect crlf attribute even if core.autocrlf has not
 been set
Date: Thu, 24 Jul 2008 18:14:09 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807241811580.8986@racer>
References: <alpine.DEB.1.00.0807222255450.8986@racer> <7vy73tihl6.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0807230203350.8986@racer> <7vej5kfs0w.fsf@gitster.siamese.dyndns.org> <20080724165335.GW2925@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 24 19:15:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KM4PF-0006N2-V0
	for gcvg-git-2@gmane.org; Thu, 24 Jul 2008 19:15:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752308AbYGXROK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jul 2008 13:14:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752406AbYGXROI
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jul 2008 13:14:08 -0400
Received: from mail.gmx.net ([213.165.64.20]:37225 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750930AbYGXROH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2008 13:14:07 -0400
Received: (qmail invoked by alias); 24 Jul 2008 17:14:06 -0000
Received: from grape.st-and.ac.uk (EHLO grape.st-and.ac.uk) [138.251.155.28]
  by mail.gmx.net (mp049) with SMTP; 24 Jul 2008 19:14:06 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/5UHkRVYr5XKxAdRI9f+P1nZIJpQUIIcFZScQh6l
	7OZSTu/kjH6Lu9
X-X-Sender: gene099@racer
In-Reply-To: <20080724165335.GW2925@dpotapov.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89916>

Hi,

On Thu, 24 Jul 2008, Dmitry Potapov wrote:

> If you do not have CRLF then there will be no conversion, so you pay 
> only the price of check. The relative cost of that check obviously 
> depends on what other operations are. I believe that the worst case for 
> this check will be when there is no other operations, just re-reading 
> files, so I did:
> 
> # touch all files to force git re-read them...
> git ls-files | xargs touch
> time git status
> 
> Here is the average based on 3 attempts:
> 0.232s with autocrlf=false
> 0.265s with autocrlf=input (14% increase)

And you tested... on git.git?  One of the smallest serious Git users?

If you want to come close to the hard cases (that you would punish with 
setting autocrlf = input, not yourself of course), test _at least_ the 
Linux kernel.

To come closer you should test on OpenOffice.org or KDE.

Hth,
Dscho
