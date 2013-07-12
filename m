From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] t0008: avoid SIGPIPE race condition on fifo
Date: Fri, 12 Jul 2013 16:42:28 -0400
Message-ID: <20130712204228.GB5276@sigill.intra.peff.net>
References: <6050FACA-CAD4-4E41-B7DC-D7A2036AA233@gernhardtsoftware.com>
 <20130711133414.GF6015@sigill.intra.peff.net>
 <7vli5drsbw.fsf@alter.siamese.dyndns.org>
 <20130712103522.GA4750@sigill.intra.peff.net>
 <7vbo67oig5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Brian Gernhardt <brian@gernhardtsoftware.com>,
	"git@vger.kernel.org List" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 12 22:42:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UxkAl-0007Hs-79
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jul 2013 22:42:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965435Ab3GLUmb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jul 2013 16:42:31 -0400
Received: from cloud.peff.net ([50.56.180.127]:42225 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965377Ab3GLUma (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jul 2013 16:42:30 -0400
Received: (qmail 25561 invoked by uid 102); 12 Jul 2013 20:43:49 -0000
Received: from c-98-244-76-202.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (98.244.76.202)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 12 Jul 2013 15:43:49 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 12 Jul 2013 16:42:28 -0400
Content-Disposition: inline
In-Reply-To: <7vbo67oig5.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230252>

On Fri, Jul 12, 2013 at 09:23:54AM -0700, Junio C Hamano wrote:

> > In that case, check-ignore gets a SIGPIPE and dies. The
> > outer shell then tries to open the output fifo but blocks
> > indefinitely, because there is no writer.  We can fix it by
> > keeping a descriptor open through the whole procedure.
> 
> Ahh, figures.
> 
> I wish I were smart enough to figure that out immediately after
> seeing the test that does funny things to "in" with "9".

I wish I were smart enough to have figured it out when I was writing the
funny stuff with "in" and "9" in the first place. :)

-Peff
