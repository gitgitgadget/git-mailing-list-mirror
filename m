From: John Keeping <john@keeping.me.uk>
Subject: Re: Transfer notes when rebasing
Date: Wed, 4 Sep 2013 08:59:41 +0100
Message-ID: <20130904075941.GA2582@serenity.lan>
References: <CAC9WiBiSLMO+JM3aEHZ8xdwKE=jh+mDuo4REQ7rnQ-rTDNb9qA@mail.gmail.com>
 <20130904075310.GB9637@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Francis Moreau <francis.moro@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Sep 04 09:59:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VH80K-0006N0-BH
	for gcvg-git-2@plane.gmane.org; Wed, 04 Sep 2013 09:59:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762193Ab3IDH7w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Sep 2013 03:59:52 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:50305 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762121Ab3IDH7w (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Sep 2013 03:59:52 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id A2317CDA604;
	Wed,  4 Sep 2013 08:59:51 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -2.9
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9] autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id efkH0Bh9DVow; Wed,  4 Sep 2013 08:59:51 +0100 (BST)
Received: from serenity.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id B0E0BCDA57D;
	Wed,  4 Sep 2013 08:59:46 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <20130904075310.GB9637@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233815>

On Wed, Sep 04, 2013 at 03:53:10AM -0400, Jeff King wrote:
> On Wed, Sep 04, 2013 at 09:51:26AM +0200, Francis Moreau wrote:
> 
> > When rebasing a branch which contains commits with notes onto another
> > branch it happens that some commits are already presents in the target
> > branch.
> > 
> > In that case git-rebase correctly drops those (already present)
> > commits but it also drops the notes associated with them.
> > 
> > Can the notes be transfered somehow in the target branch on the
> > already present commits ?
> 
> Yes, see the notes.rewriteRef config option to enable this.

Does that actually work for this case?  It sounds like Francis has the
notes copying correctly when commits are rewritten but the notes are not
copied anywhere if the commit becomes empty.

I suspect it is difficult to do that in general as there is no clear way
to know which commit those notes should be copied to.
