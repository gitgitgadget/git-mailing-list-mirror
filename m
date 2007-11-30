From: Jeff King <peff@peff.net>
Subject: Re: [RFC] use typechange as rename source
Date: Thu, 29 Nov 2007 20:57:16 -0500
Message-ID: <20071130015716.GA15224@coredump.intra.peff.net>
References: <20071121171235.GA32233@sigill.intra.peff.net> <7vir3l2a1i.fsf@gitster.siamese.dyndns.org> <20071129141452.GA32670@coredump.intra.peff.net> <7vmyswsfl6.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 30 02:57:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ixv8Q-0006LF-HX
	for gcvg-git-2@gmane.org; Fri, 30 Nov 2007 02:57:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934715AbXK3B5T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Nov 2007 20:57:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934711AbXK3B5T
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Nov 2007 20:57:19 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4871 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934628AbXK3B5S (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Nov 2007 20:57:18 -0500
Received: (qmail 31206 invoked by uid 111); 30 Nov 2007 01:57:17 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 29 Nov 2007 20:57:17 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 29 Nov 2007 20:57:16 -0500
Content-Disposition: inline
In-Reply-To: <7vmyswsfl6.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66601>

On Thu, Nov 29, 2007 at 05:10:45PM -0800, Junio C Hamano wrote:

> > OK. What next? Did the patch I sent make sense? Do you want a cleaned up
> > version with a commit message and signoff, or does it need work?
> 
> It just hit me that breaking (as in diffcore-break) a filepair that is a
> typechange may yield the same result, and if it works, that would be
> conceptually cleaner.  After all, a typechange is the ultimate form of
> total rewriting (the similarity between the preimage and the postimage
> is very low -- even their types are different, let alone contents).
> 
> Compared to that, the rename_used++ in that codepath you touched feels
> more magic to me.

I have always been a bit confused about diffcore-break, so I am probably
misunderstanding what you mean. But are you saying that
diffcore-break.c:should_break should return 1 for typechanges? If so,
that does not have the desired effect.

-Peff
