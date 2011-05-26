From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCHv2 1/2] Support multiple virtual repositories with a single
 object store and refs
Date: Thu, 26 May 2011 02:40:49 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.1105260239480.2701@bonsai2>
References: <1306274066-4092-1-git-send-email-jamey@minilop.net> <7v7h9f7kzx.fsf@alter.siamese.dyndns.org> <alpine.DEB.1.00.1105250847380.2701@bonsai2> <20110525154405.GA4839@oh.minilop.net> <alpine.DEB.1.00.1105260152430.2701@bonsai2>
 <20110526000104.GA3439@leaf>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jamey Sharp <jamey@minilop.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Sixt <johannes.sixt@telecom.at>
To: Josh Triplett <josh@joshtriplett.org>
X-From: git-owner@vger.kernel.org Thu May 26 02:41:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPOe7-0003PL-7U
	for gcvg-git-2@lo.gmane.org; Thu, 26 May 2011 02:41:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754289Ab1EZAky (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 May 2011 20:40:54 -0400
Received: from mailout-de.gmx.net ([213.165.64.23]:35422 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754046Ab1EZAkx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2011 20:40:53 -0400
Received: (qmail invoked by alias); 26 May 2011 00:40:51 -0000
Received: from pD9EB28BC.dip0.t-ipconnect.de (EHLO noname) [217.235.40.188]
  by mail.gmx.net (mp059) with SMTP; 26 May 2011 02:40:51 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18m7K8Uzlgm3LyRoP1atStekTW2SM+JgCJUrE1HvG
	sR8e7I0nnfYQaJ
X-X-Sender: gene099@bonsai2
In-Reply-To: <20110526000104.GA3439@leaf>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174485>

Hi,

On Wed, 25 May 2011, Josh Triplett wrote:

> On Thu, May 26, 2011 at 01:53:42AM +0200, Johannes Schindelin wrote:
> > On Wed, 25 May 2011, Jamey Sharp wrote:
> > > On Wed, May 25, 2011 at 08:51:07AM +0200, Johannes Schindelin wrote:
> > > > 2) You're extending the protocol by appending the prefix after the 
> > > >    SHA-1, and I stopped halfway through the patch trying to find 
> > > >    information which I now think should be in the commit message: a)  
> > > >    why? b) why does it not break when one of the two sides is a 
> > > >    previous version?
> > > 
> > > I don't think we're changing the protocol in any way...?
> > 
> > Did your patch series not contain a change that sends a capability with 
> > the prefix appended?
> 
> Not that we know of.  Are we missing something?

This is a change of protocol by my understanding:

-- snip --
 	if (sent_capabilities)
-		packet_write(1, "%s %s\n", sha1_to_hex(sha1), path);
+		packet_write(1, "%s %s%s\n", sha1_to_hex(sha1), refnameprefix, path);
-- snap --

Of course, you're free to ignore my comments just like everybody else on 
the Git mailing list.

Ciao,
Johannes
