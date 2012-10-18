From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/6] pretty: prepare notes message at a centralized place
Date: Thu, 18 Oct 2012 05:18:28 -0400
Message-ID: <20121018091828.GA14838@sigill.intra.peff.net>
References: <1350539128-21577-1-git-send-email-gitster@pobox.com>
 <1350539128-21577-4-git-send-email-gitster@pobox.com>
 <20121018074921.GC9999@sigill.intra.peff.net>
 <7vfw5cm96a.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 18 11:18:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TOmFY-0001Do-Re
	for gcvg-git-2@plane.gmane.org; Thu, 18 Oct 2012 11:18:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754808Ab2JRJSe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2012 05:18:34 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:37625 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753977Ab2JRJSd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2012 05:18:33 -0400
Received: (qmail 3494 invoked by uid 107); 18 Oct 2012 09:19:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 18 Oct 2012 05:19:10 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 18 Oct 2012 05:18:28 -0400
Content-Disposition: inline
In-Reply-To: <7vfw5cm96a.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207984>

On Thu, Oct 18, 2012 at 02:17:01AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > It's possible that switching it would create bugs elsewhere (there are
> > over 100 uses of strbuf_detach, so maybe somebody really does want this
> > NULL behavior), but I tend to think it is just as likely to be fixing
> > undiscovered bugs.
> 
> Yeah, I tend to agree.
> 
> This "format-patch --notes" is obviously a post 1.8.0 topic, and so
> is the strbuf_detach() clean-up.  Let me bookmark this thread in
> case it hasn't been resolved when I came back from my vacation, so
> that I won't forget ;-).

Actually, I have found a few segfaults, one of them remotely triggerable
in http-backend. I think it can probably wait until post-1.8.0 as it
does not have any security implications, though.

Details in a moment.

-Peff
