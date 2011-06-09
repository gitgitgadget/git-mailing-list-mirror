From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCHv4 2/4] Add infrastructure for ref namespaces
Date: Wed, 8 Jun 2011 20:38:17 -0700
Message-ID: <20110609033817.GB6167@leaf>
References: <1306887870-3875-1-git-send-email-jamey@minilop.net>
 <m3sjrrwbyp.fsf@localhost.localdomain>
 <20110603210156.GA1806@leaf>
 <201106081141.26994.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jamey Sharp <jamey@minilop.net>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <johannes.sixt@telecom.at>,
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 09 05:39:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUW5X-0000rx-70
	for gcvg-git-2@lo.gmane.org; Thu, 09 Jun 2011 05:39:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756128Ab1FIDid (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2011 23:38:33 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:52858 "EHLO
	relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755523Ab1FIDid (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2011 23:38:33 -0400
X-Originating-IP: 217.70.178.134
Received: from mfilter4-d.gandi.net (mfilter4-d.gandi.net [217.70.178.134])
	by relay4-d.mail.gandi.net (Postfix) with ESMTP id 4F35D172055;
	Thu,  9 Jun 2011 05:38:31 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at #File managed by puppet, do not edit
	locally
Received: from relay4-d.mail.gandi.net ([217.70.183.196])
	by mfilter4-d.gandi.net (mfilter4-d.gandi.net [10.0.15.180]) (amavisd-new, port 10024)
	with ESMTP id xNxBt5R9KqoS; Thu,  9 Jun 2011 05:38:29 +0200 (CEST)
X-Originating-IP: 50.43.15.19
Received: from leaf (static-50-43-15-19.bvtn.or.frontiernet.net [50.43.15.19])
	(Authenticated sender: josh@joshtriplett.org)
	by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 77968172079;
	Thu,  9 Jun 2011 05:38:19 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <201106081141.26994.jnareb@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175487>

On Wed, Jun 08, 2011 at 11:41:25AM +0200, Jakub Narebski wrote:
> On Fri, 3 June 2011, Josh Triplett wrote:
> > On Fri, Jun 03, 2011 at 01:35:34AM -0700, Jakub Narebski wrote:
> > > Jamey Sharp <jamey@minilop.net> writes:
> > > 
> > > > From: Josh Triplett <josh@joshtriplett.org>
> > > > 
> > > > Add support for dividing the refs of a single repository into multiple
> > > > namespaces, each of which can have its own branches, tags, and HEAD.
> > > > Git can expose each namespace as an independent repository to pull from
> > > > and push to, while sharing the object store, and exposing all the refs
> > > > to operations such as git-gc.
> > > [...]
> > > 
> > > By the way, after this feature is merged in, would you like for gitweb
> > > to understand ref namespaces and offer browsing of separate namespaces
> > > (sub-repositories)?
> > 
> > Yes, definitely!  We'd love to see gitweb handling namespaces
> > transparently, and presenting them identically to top-level
> > repositories.  (Also, gitweb would need to present the appropriate
> > repository URIs for cloning.)
> 
> Note that for gitweb support we would need some easy way to list all
> namespaces that given repository provides.  But that is for the future.
> 
> BTW. what do you think about treating repository with own refs and with
> namespaces similarly to how "forks" are handled in gitweb now?

Different namespaces won't necessarily represent forks of the same
repository; they may represent entirely separate repositories, with the
use of namespaces merely a server-side implementation detail to save
space.  I'd suggest presenting them as separate repositories.

- Josh Triplett
