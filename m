From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 4/4] fast-export: make sure refs are updated properly
Date: Fri, 2 Nov 2012 11:19:55 -0400
Message-ID: <20121102151955.GA24622@sigill.intra.peff.net>
References: <1351623987-21012-1-git-send-email-felipe.contreras@gmail.com>
 <1351623987-21012-5-git-send-email-felipe.contreras@gmail.com>
 <20121031003721.GV15167@elie.Belkin>
 <20121102131255.GB2598@sigill.intra.peff.net>
 <alpine.DEB.1.00.1211021612320.7256@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Elijah Newren <newren@gmail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Nov 02 16:20:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TUJ2d-0001jm-LX
	for gcvg-git-2@plane.gmane.org; Fri, 02 Nov 2012 16:20:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757153Ab2KBPT6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Nov 2012 11:19:58 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:54616 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755802Ab2KBPT5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Nov 2012 11:19:57 -0400
Received: (qmail 5660 invoked by uid 107); 2 Nov 2012 15:20:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 02 Nov 2012 11:20:41 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 02 Nov 2012 11:19:55 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.1211021612320.7256@s15462909.onlinehome-server.info>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208948>

On Fri, Nov 02, 2012 at 04:17:14PM +0100, Johannes Schindelin wrote:

> > If so, then this series isn't regressing behavior; the only downside is
> > that it's an incomplete fix. In theory this could get in the way of the
> > full fix later on, but given the commit messages and the archive of this
> > discussion, it would be simple enough to revert it later in favor of a
> > more full fix. Is that accurate?
> 
> From my understanding, yes.
> 
> > Sorry if I am belaboring the discussion. I just want to make sure I
> > understand the situation before deciding what to do with the topic. It
> > sounds like the consensus at this point is "not perfect, but good enough
> > to make forward progress".
> 
> I appreciate that stance very much. The patch Sverre and I proposed was
> also an incomplete fix (although I suspect it would fix the issue you
> pointed out above), so I agree with the "perfect is the enemy of the good"
> approach, obviously.

Thanks for the response.

> May I just ask to include a summary of that rationale into the commit
> message rather than relying on people having internet access and knowing
> where to look? Adding the following to the commit message would be good
> enough for me:
> 
> 	Note that
> 
> 		$ git branch foo master~1
> 		$ git fast-export foo master~1..master
> 
> 	still does not update the "foo" ref, but a partial fix is better
> 	than no fix.

Yes, I think that makes a lot of sense.

Felipe, I notice that you sent out a big "fast-export improvements"
series. Does that supersede this?

-Peff
