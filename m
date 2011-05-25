From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCHv2 1/2] Support multiple virtual repositories with a single
 object store and refs
Date: Wed, 25 May 2011 08:51:07 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.1105250847380.2701@bonsai2>
References: <1306274066-4092-1-git-send-email-jamey@minilop.net> <7v7h9f7kzx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jamey Sharp <jamey@minilop.net>, git@vger.kernel.org,
	Josh Triplett <josh@joshtriplett.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Sixt <johannes.sixt@telecom.at>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 25 08:51:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QP7w6-0007xy-8F
	for gcvg-git-2@lo.gmane.org; Wed, 25 May 2011 08:51:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753506Ab1EYGvM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 May 2011 02:51:12 -0400
Received: from mailout-de.gmx.net ([213.165.64.22]:35032 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753284Ab1EYGvL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2011 02:51:11 -0400
Received: (qmail invoked by alias); 25 May 2011 06:51:09 -0000
Received: from pD9EB28BC.dip0.t-ipconnect.de (EHLO noname) [217.235.40.188]
  by mail.gmx.net (mp024) with SMTP; 25 May 2011 08:51:09 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX195XIZbIG55uMPPZGXDJC0GedMOYX47nEtzFqHBUa
	/1fz8DcAtBWZ7J
X-X-Sender: gene099@bonsai2
In-Reply-To: <7v7h9f7kzx.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174373>

Hi,

On Tue, 24 May 2011, Junio C Hamano wrote:

> Jamey Sharp <jamey@minilop.net> writes:
> 
> > Given many repositories with copies of the same objects (such as 
> > branches of the same source), sharing a common object store will avoid 
> > duplication.  Alternates provide a single baseline, but don't handle 
> > ongoing activity in the various repositories.  Git safely handles 
> > concurrent accesses to the same object store across repositories, but 
> > operations such as gc need to know about all of the refs.
> >
> > This change adds support in upload-pack and receive-pack to simulate 
> > multiple virtual repositories within the object store and references 
> > of
> 
> Is it just me to read the above and then have to re-read the first 
> sentence of the second paragraph over and over again?  There seems to be 
> a huge gap in logic flow, probably largely due to the use of undefined 
> term "virtual repository".

I had to read the example call to understand that 'virtual repository' 
means 'one real catch-em-all repository'.

I wonder about two things, though:

1) Would teaching git clone to understand "-t this/repo/*" help?

2) You're extending the protocol by appending the prefix after the SHA-1, 
   and I stopped halfway through the patch trying to find information 
   which I now think should be in the commit message: a) why? b) why does 
   it not break when one of the two sides is a previous version?

Ciao,
Dscho
