From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] Change "refs/" references to symbolic constants
Date: Tue, 2 Oct 2007 11:58:01 -0400
Message-ID: <20071002155800.GA6828@coredump.intra.peff.net>
References: <200709291359.59147.andyparkins@gmail.com> <200710012141.44459.andyparkins@gmail.com> <20071002011659.GA7938@coredump.intra.peff.net> <200710020941.05288.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 02 17:58:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ick8U-0004fr-P2
	for gcvg-git-2@gmane.org; Tue, 02 Oct 2007 17:58:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751152AbXJBP6G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Oct 2007 11:58:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752170AbXJBP6F
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Oct 2007 11:58:05 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2157 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750843AbXJBP6E (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Oct 2007 11:58:04 -0400
Received: (qmail 28105 invoked by uid 111); 2 Oct 2007 15:58:02 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Tue, 02 Oct 2007 11:58:02 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 02 Oct 2007 11:58:01 -0400
Content-Disposition: inline
In-Reply-To: <200710020941.05288.andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59696>

On Tue, Oct 02, 2007 at 09:41:03AM +0100, Andy Parkins wrote:

> Excellent!  Well done.  I spent a couple of hours last night going through 
> every changed line and have spotted the TAGS mistake but didn't spot the 
> STRLEN being wrong.  Amazing how easy it is to become blind to these things.  
> There were a couple of errors in "/" placement too, but I don't think they 
> were causing any trouble, just doubled up "/" characters.

I wonder if you could check the patch mechanically (i.e., write a script
to confirm that '5' got replaced by tokens equal to '5'), though that
might require some tricky parsing of C.

If you a post an updated version, I will try to read through it
carefully, as two eyes are better than one (er, four eyes, I guess).

> I noticed a couple of places where memcmp() has been used where prefixcmp() 
> would work fine.  I'm tempted to change them too - what do you think?  
> Perhaps a separate patch?

When in doubt, I would suggest a separate patch, as it makes the review
easier.

> I'm happy to do prepare a patch against any revision, I was really
> waiting for feedback from Junio as to how he'd like to manage it.
> Last time I submitted this patch he (quite correctly) asked that I
> delay until after the next point release; of course I promptly found
> other things to do and never resubmitted :-)

Yes, you should definitely listen to Junio on such issues, and not me.
:)

-Peff
