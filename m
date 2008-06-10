From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Introduce get_octopus_merge_bases() in commit.c
Date: Tue, 10 Jun 2008 03:43:51 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806100341430.1783@racer>
References: <alpine.DEB.1.00.0806091458190.1783@racer> <1213051426-11530-1-git-send-email-vmiklos@frugalware.org> <7v8wxefbtn.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0806100024310.1783@racer> <7vlk1edvn1.fsf@gitster.siamese.dyndns.org>
 <20080610000340.GY29404@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Tue Jun 10 04:46:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5ts3-0001h2-L3
	for gcvg-git-2@gmane.org; Tue, 10 Jun 2008 04:46:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753499AbYFJCpK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jun 2008 22:45:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753762AbYFJCpK
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jun 2008 22:45:10 -0400
Received: from mail.gmx.net ([213.165.64.20]:48367 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753100AbYFJCpJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2008 22:45:09 -0400
Received: (qmail invoked by alias); 10 Jun 2008 02:45:07 -0000
Received: from pacific.mpi-cbg.de (EHLO [10.8.0.10]) [141.5.10.38]
  by mail.gmx.net (mp015) with SMTP; 10 Jun 2008 04:45:07 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/dHxkCbozdFx7AclQa11wv5+R606A73nxQeZHQ3V
	cvHjU35URvrXz7
X-X-Sender: gene099@racer
In-Reply-To: <20080610000340.GY29404@genesis.frugalware.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84471>

Hi,

On Tue, 10 Jun 2008, Miklos Vajna wrote:

> On Mon, Jun 09, 2008 at 04:41:06PM -0700, Junio C Hamano 
> <gitster@pobox.com> wrote:
>
> > Actually a quick glance at git-merge, a rather large case...esac after 
> > that "show-branch --merge-base" tells me that we do not really use the 
> > output from that operation and instead we check if we are fast-forward 
> > from all the other heads by iterating over them.  merge-octupos would 
> > accept it as the base but never looks at it.
> 
> I may be wrong but I think it would be still nice to pass a valid base 
> to the backend, even if _currently_ the only octopus implementation 
> ignores it.
> 
> Actually on "valid" I mean what my original get_octopus_merge_bases() 
> returned. :-)

IMO that is one of the advantages of making git-merge a builtin: you need 
not work around the lack of performance of shell scripts, but you can 
actually compute what you need to compute.

IOW I agree that we could give the proper list of merge bases to whatever 
octopus backend we use.  And since your original implementation is 
correct, if not super-optimal, I would like to stick to it.

Ciao,
Dscho
