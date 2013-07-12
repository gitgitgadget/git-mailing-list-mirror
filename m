From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] wt-status: use "format" function attribute for
 status_printf
Date: Fri, 12 Jul 2013 16:44:37 -0400
Message-ID: <20130712204437.GC5276@sigill.intra.peff.net>
References: <20130710001659.GA11643@sigill.intra.peff.net>
 <20130710002328.GC19423@sigill.intra.peff.net>
 <7vmwpvt28j.fsf@alter.siamese.dyndns.org>
 <20130710052859.GA5339@sigill.intra.peff.net>
 <7vfvvjoj2h.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Matt Kraai <kraai@ftbfs.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 12 22:44:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UxkCp-0000Io-RV
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jul 2013 22:44:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965439Ab3GLUok (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jul 2013 16:44:40 -0400
Received: from cloud.peff.net ([50.56.180.127]:42241 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965377Ab3GLUoj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jul 2013 16:44:39 -0400
Received: (qmail 25706 invoked by uid 102); 12 Jul 2013 20:45:58 -0000
Received: from c-98-244-76-202.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (98.244.76.202)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 12 Jul 2013 15:45:58 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 12 Jul 2013 16:44:37 -0400
Content-Disposition: inline
In-Reply-To: <7vfvvjoj2h.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230253>

On Fri, Jul 12, 2013 at 09:10:30AM -0700, Junio C Hamano wrote:

> > You can "fix" it with -Wno-zero-format-length, so the hassle is not
> > huge. But I am also inclined to just drop this one. We have lived
> > without the extra safety for a long time, and list review does tend to
> > catch such problems in practice.
> 
> I am tempted to actually merge the original one as-is without any of
> the workaround, and just tell people to use -Wno-format-zero-length.

Yeah, I think the only downside is the cognitive burden on individual
developers who try -Wall and have to figure out that we need
-Wno-zero-format-length (and that the warnings are not interesting).

It would be nice to add it automatically to CFLAGS, but I do not know if
we can reliably detect from the Makefile that we are compiling under
gcc.

-Peff
