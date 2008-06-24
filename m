From: Teemu Likonen <tlikonen@iki.fi>
Subject: Re: Segmentation fault on http clone, post-1.5.6
Date: Tue, 24 Jun 2008 21:57:23 +0300
Message-ID: <20080624185723.GA3368@mithlond.arda.local>
References: <20080624130457.GB13696@mithlond.arda.local> <20080624164034.GB4654@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Nicolas Pitre <nico@cam.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 24 20:58:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBDip-00083H-L5
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 20:58:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751068AbYFXS5f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 14:57:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751072AbYFXS5f
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 14:57:35 -0400
Received: from mta-out.inet.fi ([195.156.147.13]:58560 "EHLO
	jenni1.rokki.sonera.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750752AbYFXS5e (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 14:57:34 -0400
Received: from mithlond.arda.local (80.220.180.140) by jenni1.rokki.sonera.fi (8.5.014)
        id 483E82F10135CC39; Tue, 24 Jun 2008 21:57:24 +0300
Received: from dtw by mithlond.arda.local with local (Exim 4.63)
	(envelope-from <tlikonen@iki.fi>)
	id 1KBDhj-0001Z7-AA; Tue, 24 Jun 2008 21:57:23 +0300
Content-Disposition: inline
In-Reply-To: <20080624164034.GB4654@sigill.intra.peff.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86106>

Jeff King wrote (2008-06-24 12:40 -0400):

> On Tue, Jun 24, 2008 at 04:04:57PM +0300, Teemu Likonen wrote:
> 
> > With the current "master" branch version (29b0d0191) I get
> > segmentation fault when trying to clone a git repo with http
> > protocol. Tried a couple of times and it's always reproducible. You
> > can test with the following repository (about 5.5 MB):
> > 
> >   git clone http://www.iki.fi/tlikonen/voikko.git
> 
> I can't reproduce the segfault here.
> 
> > I also build git from the tag v1.5.6 and it seems to work fine, so
> > I guess the bug was introduced after 1.5.6.
> 
> That sounds like an excellent opportunity to learn about git-bisect.
> Can you try bisecting the bug and reporting back the problematic
> commit?

Indeed. I have now officially bisected the problem and the first bad or
problematic commit is 8eca0b47 "implement some resilience against pack
corruptions" (hence Cc to Nicolas, the author). This is always
reproducible in my Debian 4.0 box.
