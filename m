From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] inline constant return from error() function
Date: Mon, 12 May 2014 14:13:26 -0400
Message-ID: <20140512181326.GA31164@sigill.intra.peff.net>
References: <20140505212938.GA16715@sigill.intra.peff.net>
 <20140506151441.GA25768@sigill.intra.peff.net>
 <xmqqppjqczhq.fsf@gitster.dls.corp.google.com>
 <20140507030254.GC20726@sigill.intra.peff.net>
 <xmqqppjkut6s.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 12 20:13:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WjujG-00088Z-HN
	for gcvg-git-2@plane.gmane.org; Mon, 12 May 2014 20:13:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752414AbaELSNa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 May 2014 14:13:30 -0400
Received: from cloud.peff.net ([50.56.180.127]:50064 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751291AbaELSNa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 May 2014 14:13:30 -0400
Received: (qmail 15092 invoked by uid 102); 12 May 2014 18:13:29 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 12 May 2014 13:13:29 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 May 2014 14:13:26 -0400
Content-Disposition: inline
In-Reply-To: <xmqqppjkut6s.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248716>

On Sun, May 11, 2014 at 10:22:03AM -0700, Junio C Hamano wrote:

> The alternative you mentioned up-thread "... to write out "return
> error(...)"  as "error(...); return -1". In some ways that is more
> readable, though it is more verbose..." has one more downside you
> did not mention, and the approach to encapsulate it inside error()
> will not have it: new call-sites to error() do not have to worry
> about the issue with this approach.
> 
> Until it breaks, that is.  But that goes without saying with the
> "it's something we can count on" pre-condition in place ;-).

Yeah, I agree with this thinking. I'd rather not do something that
impacts each callsite until we have exhausted other options that hide
the complexity in the definition.

-Peff
