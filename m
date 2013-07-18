From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Fix some sparse warnings
Date: Thu, 18 Jul 2013 16:36:41 -0400
Message-ID: <20130718203640.GB15735@sigill.intra.peff.net>
References: <51E84F4E.3050600@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Thu Jul 18 22:36:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UzuwT-0008S6-Md
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jul 2013 22:36:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759371Ab3GRUgq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jul 2013 16:36:46 -0400
Received: from cloud.peff.net ([50.56.180.127]:42500 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759356Ab3GRUgp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jul 2013 16:36:45 -0400
Received: (qmail 26789 invoked by uid 102); 18 Jul 2013 20:36:45 -0000
Received: from c-98-244-76-202.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (98.244.76.202)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 18 Jul 2013 15:36:45 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 18 Jul 2013 16:36:41 -0400
Content-Disposition: inline
In-Reply-To: <51E84F4E.3050600@ramsay1.demon.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230741>

On Thu, Jul 18, 2013 at 09:25:50PM +0100, Ramsay Jones wrote:

> Sparse issues some "Using plain integer as NULL pointer" warnings.
> Each warning relates to the use of an '{0}' initialiser expression
> in the declaration of an 'struct object_info'. The first field of
> this structure has pointer type. Thus, in order to suppress these
> warnings, we replace the initialiser expression with '{NULL}'.
> 
> Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>

Acked-by: Jeff King <peff@peff.net>

I thought at first we would need one more for the new callsite I added
in my series, but we use memset() in that instance, so it is fine.

-Peff
