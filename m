From: Jeff King <peff@peff.net>
Subject: Re: [RFC PATCH] git add -p: new "quit" command at the prompt.
Date: Thu, 16 Apr 2009 02:00:27 -0400
Message-ID: <20090416060027.GA2992@coredump.intra.peff.net>
References: <1239375421-2556-1-git-send-email-Matthieu.Moy@imag.fr> <7vws9rdmgd.fsf@gitster.siamese.dyndns.org> <vpqfxgevy58.fsf@bauges.imag.fr> <vpqtz4rynhp.fsf@bauges.imag.fr> <7v7i1lqz24.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 16 08:02:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LuKfp-0003JP-SS
	for gcvg-git-2@gmane.org; Thu, 16 Apr 2009 08:02:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752598AbZDPGAe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Apr 2009 02:00:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752501AbZDPGAd
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Apr 2009 02:00:33 -0400
Received: from peff.net ([208.65.91.99]:58081 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752334AbZDPGAd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Apr 2009 02:00:33 -0400
Received: (qmail 32618 invoked by uid 107); 16 Apr 2009 06:00:37 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 16 Apr 2009 02:00:37 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 16 Apr 2009 02:00:27 -0400
Content-Disposition: inline
In-Reply-To: <7v7i1lqz24.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116671>

On Wed, Apr 15, 2009 at 04:25:55PM -0700, Junio C Hamano wrote:

> Currently parse_diff_header() returns the mode line into $mode and the
> main loop treats $mode differently from @hunk, which is an array of hunks
> parsed by parse_diff().  Treating $mode as a "fake hunk" by unshifting it
> at the beginning of @hunk array and teaching the main loop minor details
> such as $mode "fake hunk" cannot be edited nor split, I suspect we _could_
> unify the two.
> 
> ca72468 (add--interactive: allow user to choose mode update, 2008-03-27)
> introduced this duplication.  Jeff, what do you think?  I am not sure if
> it is worth it.

Yeah, at least at one point I thought that was possible:

  http://article.gmane.org/gmane.comp.version-control.git/78340

Let me see how painful it would be.

-Peff
