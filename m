From: Greg KH <greg@kroah.com>
Subject: Re: git clone stable-2.6.25.y fails over HTTP
Date: Wed, 4 Jun 2008 21:03:15 -0700
Message-ID: <20080605040315.GA21798@kroah.com>
References: <200806041511.m54FBPL9006783@pogo.cesa.opbu.xerox.com> <20080604154523.GA25747@kroah.com> <7vr6bdxh3l.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andrew Klossner <andrew@cesa.opbu.xerox.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 05 06:06:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K46kD-0003Z2-F0
	for gcvg-git-2@gmane.org; Thu, 05 Jun 2008 06:06:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750981AbYFEEFK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2008 00:05:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750999AbYFEEFK
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jun 2008 00:05:10 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:44804 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750970AbYFEEFJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2008 00:05:09 -0400
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174] helo=localhost)
	by pentafluge.infradead.org with esmtpsa (Exim 4.68 #1 (Red Hat Linux))
	id 1K46il-00066n-FV; Thu, 05 Jun 2008 04:05:04 +0000
Content-Disposition: inline
In-Reply-To: <7vr6bdxh3l.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83851>

On Wed, Jun 04, 2008 at 10:09:02AM -0700, Junio C Hamano wrote:
> Greg KH <greg@kroah.com> writes:
> 
> >> Getting pack list for http://www.kernel.org/home/ftp/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/
> >> error: Unable to find fdcce40226d7d4273a08cc4ef84bb25755a710a4 under http://www.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.25.y.git
> > ...
> > It looks like git over http isn't following the link somehow to the main
> > repo?
> 
> Yeah, see above.  www.kernel.org does not like to serve /home/ftp/pub/scm
> path; it wants to serve it as /pub/scm/linux instead.
> 
> Your objects/info/alternates in 2.6.24.y points at /pub/scm/linux/kernel/git/torvalds/...
> but in 2.6.25.y it has extra /home/ftp in front of it.
> 
> A quick fix is obviously to remove the extra prefix but it makes me wonder
> how these two "stable" repositories were prepared differently.  Could this
> be a regression in "git clone"?  Or perhaps you "clone -s"'s Linus's
> repository slightly differently between them?

That's odd.

Chris was the one that created the .24 tree and I created the .25 tree,
so we must have done so differently, sorry.

I've edited the alternates file, so it should work now, sorry about
that.

thanks,

greg k-h
