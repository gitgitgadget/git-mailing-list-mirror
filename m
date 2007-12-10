From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] Add support for URLs to git-apply
Date: Mon, 10 Dec 2007 11:16:15 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0712101113160.27959@racer.site>
References: <1197194672-28568-1-git-send-email-mh@glandium.org>
 <1197194672-28568-2-git-send-email-mh@glandium.org> <475C5869.4080900@op5.se>
 <7vhciro4vx.fsf@gitster.siamese.dyndns.org> <20071210064659.GA4148@glandium.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, Andreas Ericsson <ae@op5.se>,
	git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Mon Dec 10 12:17:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1gdW-0006vP-9L
	for gcvg-git-2@gmane.org; Mon, 10 Dec 2007 12:17:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751294AbXLJLQ6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Dec 2007 06:16:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751337AbXLJLQ5
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Dec 2007 06:16:57 -0500
Received: from mail.gmx.net ([213.165.64.20]:47737 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751294AbXLJLQ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Dec 2007 06:16:57 -0500
Received: (qmail invoked by alias); 10 Dec 2007 11:16:55 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp030) with SMTP; 10 Dec 2007 12:16:55 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+DTsR5coeDsk4yWVkHAKxCriqYeSdEjMH4dXoL4G
	xJyV60S3LHgYTl
X-X-Sender: gene099@racer.site
In-Reply-To: <20071210064659.GA4148@glandium.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67702>

Hi,

On Mon, 10 Dec 2007, Mike Hommey wrote:

> On Sun, Dec 09, 2007 at 02:54:58PM -0800, Junio C Hamano wrote:
> > Andreas Ericsson <ae@op5.se> writes:
> > 
> > > Mike Hommey wrote:
> > >> Instead of doing several "wget -O - url | git-apply -" in a raw, 
> > >> you now can just git-apply url1 url2 ...
> > >>
> > >
> > > I seriously like this idea. Combined with gitweb (or cgit), it could 
> > > be used as a cherry-pick from someone else's repo :)
> > 
> > FWIW, my initial impression is that I seriously dislike this.  It may 
> > be good if the patch were to git-am, but when git-apply rejects an 
> > inapplicable patch, there won't be nothing left for you to recover 
> > with and you need to re-download the patch anyway.
> 
> There are some usecase differences between git-apply and git-am. 
> Probably, this change would be good to have on both.

But what about Junio's comments about a failed patch?  You really want to 
hammer that poor webserver?

My first thought when seeing your patch was: this would give us a chance 
to "clone" via gitweb.  And while doing so, all but kill those webservers.  
So I thought it was wrong.

When Junio mentioned git-am it was obvious to me that this is the "right" 
solution.

I mean, we go out of our way to be nice to the servers, putting more load 
onto the clients, because there are many clients, but only one server 
(which is unfair).

Please address these issues before further arguing that both apply and am 
should learn about URLs.

Ciao,
Dscho
