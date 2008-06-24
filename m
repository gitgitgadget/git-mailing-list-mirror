From: Mike Hommey <mh@glandium.org>
Subject: Re: Segmentation fault on http clone, post-1.5.6
Date: Tue, 24 Jun 2008 21:34:41 +0200
Organization: glandium.org
Message-ID: <20080624193441.GC28574@glandium.org>
References: <20080624130457.GB13696@mithlond.arda.local> <20080624164034.GB4654@sigill.intra.peff.net> <20080624185723.GA3368@mithlond.arda.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Nicolas Pitre <nico@cam.org>
To: Teemu Likonen <tlikonen@iki.fi>
X-From: git-owner@vger.kernel.org Tue Jun 24 21:36:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBEJ5-0003oE-Iz
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 21:35:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753295AbYFXTez (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 15:34:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752830AbYFXTez
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 15:34:55 -0400
Received: from vuizook.err.no ([194.24.252.247]:34370 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752828AbYFXTey (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 15:34:54 -0400
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1KBEHq-00062e-CC; Tue, 24 Jun 2008 21:34:48 +0200
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1KBEHp-0007WZ-GW; Tue, 24 Jun 2008 21:34:41 +0200
Content-Disposition: inline
In-Reply-To: <20080624185723.GA3368@mithlond.arda.local>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86125>

On Tue, Jun 24, 2008 at 09:57:23PM +0300, Teemu Likonen wrote:
> Jeff King wrote (2008-06-24 12:40 -0400):
> 
> > On Tue, Jun 24, 2008 at 04:04:57PM +0300, Teemu Likonen wrote:
> > 
> > > With the current "master" branch version (29b0d0191) I get
> > > segmentation fault when trying to clone a git repo with http
> > > protocol. Tried a couple of times and it's always reproducible. You
> > > can test with the following repository (about 5.5 MB):
> > > 
> > >   git clone http://www.iki.fi/tlikonen/voikko.git
> > 
> > I can't reproduce the segfault here.
> > 
> > > I also build git from the tag v1.5.6 and it seems to work fine, so
> > > I guess the bug was introduced after 1.5.6.
> > 
> > That sounds like an excellent opportunity to learn about git-bisect.
> > Can you try bisecting the bug and reporting back the problematic
> > commit?
> 
> Indeed. I have now officially bisected the problem and the first bad or
> problematic commit is 8eca0b47 "implement some resilience against pack
> corruptions" (hence Cc to Nicolas, the author). This is always
> reproducible in my Debian 4.0 box.

Does it crash in verify_packfile() ?

Mike
