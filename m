From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Link git-shell only to a subset of libgit.a
Date: Fri, 18 Jul 2008 12:55:16 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807181253080.3932@eeepc-johanness>
References: <20080718005814.GA4155@spearce.org> <1216343070-20237-1-git-send-email-s-beyer@gmx.net> <20080718060321.GJ2925@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Stephan Beyer <s-beyer@gmx.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 18 12:55:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJncd-0006HM-M1
	for gcvg-git-2@gmane.org; Fri, 18 Jul 2008 12:55:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754683AbYGRKye (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jul 2008 06:54:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755233AbYGRKyd
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jul 2008 06:54:33 -0400
Received: from mail.gmx.net ([213.165.64.20]:40876 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751577AbYGRKyd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jul 2008 06:54:33 -0400
Received: (qmail invoked by alias); 18 Jul 2008 10:54:31 -0000
Received: from 88-107-142-10.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.142.10]
  by mail.gmx.net (mp006) with SMTP; 18 Jul 2008 12:54:31 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18W0ftWsoIWkUctkQHzVbfpeH2JVl4fdbZJ5w24aL
	t3lQvWi5MYaQqa
X-X-Sender: user@eeepc-johanness
In-Reply-To: <20080718060321.GJ2925@dpotapov.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.65
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89029>

Hi,

On Fri, 18 Jul 2008, Dmitry Potapov wrote:

> On Fri, Jul 18, 2008 at 03:04:30AM +0200, Stephan Beyer wrote:
> > Commit 5b8e6f85 introduced stubs for three functions that make no 
> > sense for git-shell. But those stubs defined libgit.a functions a 
> > second time so that a linker can complain.
> > 
> > Now git-shell is only linked to a subset of libgit.a.
> > 
> > Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
> 
> I agree, it is probably better to specify explicitly what files to link 
> for git-shell if we want to keep it small and avoid the problem with 
> some linkers.

It is also more elegant in general, as it does not play tricks to do what 
we want, but it does explicitely what we want.

FWIW I only removed almost the exact launch_editor() patch Stephan posted 
from my personal Git fork because of this trickery (which I did not have 
the time to fix).

Ciao,
Dscho
