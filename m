From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] bisect: test merge base if good rev is not an ancestor
 of bad rev
Date: Thu, 10 Jul 2008 12:04:35 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807101201210.3135@eeepc-johanness>
References: <20080710054152.b051989c.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Thu Jul 10 12:05:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGt1k-0002nb-DM
	for gcvg-git-2@gmane.org; Thu, 10 Jul 2008 12:05:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752638AbYGJKEa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jul 2008 06:04:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752682AbYGJKEa
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jul 2008 06:04:30 -0400
Received: from mail.gmx.net ([213.165.64.20]:43409 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752419AbYGJKE3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2008 06:04:29 -0400
Received: (qmail invoked by alias); 10 Jul 2008 10:04:28 -0000
Received: from 88-107-253-132.dynamic.dsl.as9105.com (EHLO eeepc-johanness) [88.107.253.132]
  by mail.gmx.net (mp030) with SMTP; 10 Jul 2008 12:04:28 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/c/wMRe+fcK8veZd9vwMuqgdiSFsb9dHLry1LbTv
	gxXq5fHzHv6CA0
X-X-Sender: user@eeepc-johanness
In-Reply-To: <20080710054152.b051989c.chriscool@tuxfamily.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.74
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87964>

Hi,

On Thu, 10 Jul 2008, Christian Couder wrote:

> Before this patch, "git bisect", when it was given some good revs that 
> are not ancestor of the bad rev, didn't check if the merge bases were 
> good. "git bisect" just supposed that the user knew what he was doing, 
> and that, when he said the revs were good, he knew that it meant that 
> all the revs in the history leading to the good revs were also 
> considered good.

Well, it is not completely relying on the user.

The common scenario before a bisect is this: something used to work _all 
the time_, and all of a sudden, it does not anymore.

So it is expected that there is no fix in the history.  Not in the current 
branch, not in the "good" branch, not wherever.

In that case, you are literally guaranteed that all ancestors of a good 
commit are good, too, because if there was a bad one, there would be a 
fix, too.

The whole idea of "bisect" relies on that idea, that any ancestor of a 
good commit is good.  Otherwise you'd have to check the commits one by 
one, not in a bisecting manner.

Ciao,
Dscho
