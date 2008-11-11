From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-diff: Add --staged as a synonym for --cached.
Date: Mon, 10 Nov 2008 19:15:34 -0500
Message-ID: <20081111001534.GB26223@coredump.intra.peff.net>
References: <1225296936-1357-1-git-send-email-dsymonds@gmail.com> <20081029164253.GA3172@sigill.intra.peff.net> <ee77f5c20810290950k6d7acfcbt90b6280c290bd532@mail.gmail.com> <alpine.DEB.1.00.0810291804400.22125@pacific.mpi-cbg.de.mpi-cbg.de> <20081029171122.GA12167@sigill.intra.peff.net> <20081102123519.GA21251@atjola.homenet> <7vljw2yo93.fsf@gitster.siamese.dyndns.org> <20081103071420.GD10772@coredump.intra.peff.net> <ee77f5c20811101537u6061e5b4w420e9692e0cefad3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?QmrDtnJu?= Steinbrink <B.Steinbrink@gmx.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, Stephan Beyer <s-beyer@gmx.net>
To: David Symonds <dsymonds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 11 01:17:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KzgwB-0004Pn-LR
	for gcvg-git-2@gmane.org; Tue, 11 Nov 2008 01:16:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753470AbYKKAPj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Nov 2008 19:15:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753451AbYKKAPi
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Nov 2008 19:15:38 -0500
Received: from peff.net ([208.65.91.99]:4320 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753250AbYKKAPh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Nov 2008 19:15:37 -0500
Received: (qmail 9801 invoked by uid 111); 11 Nov 2008 00:15:35 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Mon, 10 Nov 2008 19:15:35 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 10 Nov 2008 19:15:34 -0500
Content-Disposition: inline
In-Reply-To: <ee77f5c20811101537u6061e5b4w420e9692e0cefad3@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100605>

On Tue, Nov 11, 2008 at 10:37:37AM +1100, David Symonds wrote:

> > And I am not proposing a change here (except to perhaps "git diff
> > --staged" instead of "--cached"). Just pointing out that it does not
> > follow the "--staged operates on both, --staged-only operates on just
> > the index" rule.
> 
> So apart from the wider discussion, I think this patch by itself is a
> nice step forward towards improving the UI of this part of git. Is
> there any further discussion on this one alone?

I think --staged for --cached is definitely an improvement. Even if we
don't have a set rule for "this is when you use --staged, and this is
when you use --staged-only", I think everyone so far agrees that any
such rule will have to incorporate "diff --staged" somehow, since it
reads pretty clearly.

So yes, I would like to see this applied.  However, there are two
possible improvements:

  1. Your documentation update says --staged is a synonym. Should
     --staged perhaps be the "new" way of doing this, and --cached is
     left as a historical alias? IOW, point users at the name we think
     is more sensible.

  2. Part of the point of this is to avoid using the world "cached" in
     instructional materials. The tutorial and user manual should
     probably be updated to use --staged (and it is reasonably safe to
     do so immediately, since they are tied to the installed git
     version; I hope Scott will update his materials eventually, but
     lagging makes sense there as people will still be using existing
     versions for some time).

     And of course, such updates would be a small part of any larger
     decision to call the index something else (the "stage" or
     whatever) in those materials, but I think your point is to do this
     one positive thing and not wait for the other bits.

-Peff
