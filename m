From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Performance issue: initial git clone causes massive repack
Date: Sun, 5 Apr 2009 14:08:28 -0700
Message-ID: <20090405210828.GB23604@spearce.org>
References: <20090404220743.GA869@curie-int> <20090405000536.GA12927@vidovic> <20090405T001239Z@curie.orbis-terrarum.net> <20090405035453.GB12927@vidovic> <20090405070412.GB869@curie-int> <20090405190213.GA12929@vidovic> <20090405204325.GA31344@curie-int>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: "Robin H. Johnson" <robbat2@gentoo.org>
X-From: git-owner@vger.kernel.org Sun Apr 05 23:10:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqZbR-00040G-09
	for gcvg-git-2@gmane.org; Sun, 05 Apr 2009 23:10:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756808AbZDEVIb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Apr 2009 17:08:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755657AbZDEVIa
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Apr 2009 17:08:30 -0400
Received: from george.spearce.org ([209.20.77.23]:55531 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753913AbZDEVIa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Apr 2009 17:08:30 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 827FC38211; Sun,  5 Apr 2009 21:08:28 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20090405204325.GA31344@curie-int>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115709>

"Robin H. Johnson" <robbat2@gentoo.org> wrote:
> > >          The GSoC 2009 ideas contain a potential project for caching the
> > > generated packs, which, while having value in itself, could be partially
> > > avoided by sending suitable pre-built packs (if they exist) without any
> > > repacking.
> > Right. It could be an option to wait and see if the GSoC gives
> > something.
>
> How hard is it to just look at the git-upload-pack code and make it
> realize that it doesn't need to repack at all for this case.

I don't need to go look.  I know that code.

Its harder than you think.

I'll tell you what, *you* go look at the git-upload-pack code and
come back with a patch that doesn't need to repack at all for this
case, *and* which Junio will actually apply.  If its any good,
Junio would apply it pretty quickly.

Nobody else has managed to create such a patch just yet.  Because its
extremely non-trivial.  Its pretty much never the case that an active
repository is fully repacked, so we always have to enumerate some
number of loose objects and put them into a single outgoing pack
for the network.  Its also considered to be a security feature of
Git that we only transmit reachable objects.

-- 
Shawn.
