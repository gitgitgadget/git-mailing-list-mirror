From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] 64-bit fix for date.c.
Date: Wed, 6 May 2009 12:49:01 -0400
Message-ID: <20090506164900.GA15160@sigill.intra.peff.net>
References: <20090406172637.GA17437@jenna.bytemine.net> <20090406190657.GC28120@coredump.intra.peff.net> <20090504142614.GE8658@jenna.bytemine.net> <20090504143112.GA14214@coredump.intra.peff.net> <7vvdoeye1c.fsf@alter.siamese.dyndns.org> <alpine.LSU.2.00.0905061523300.28199@hermes-2.csi.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Tony Finch <dot@dotat.at>
X-From: git-owner@vger.kernel.org Wed May 06 18:49:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M1kJC-0002z0-TN
	for gcvg-git-2@gmane.org; Wed, 06 May 2009 18:49:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755899AbZEFQtF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 May 2009 12:49:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755442AbZEFQtE
	(ORCPT <rfc822;git-outgoing>); Wed, 6 May 2009 12:49:04 -0400
Received: from peff.net ([208.65.91.99]:48377 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755193AbZEFQtD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 May 2009 12:49:03 -0400
Received: (qmail 2102 invoked by uid 107); 6 May 2009 16:49:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Wed, 06 May 2009 12:49:19 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 06 May 2009 12:49:01 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.00.0905061523300.28199@hermes-2.csi.cam.ac.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118355>

On Wed, May 06, 2009 at 03:26:36PM +0100, Tony Finch wrote:

> Jeff King [Mon, Apr 06, 2009 at 03:06:58PM -0400] wrote:
> >
> >Hmph. According to POSIX, tv_sec _is_ a time_t. But I see on FreeBSD,
> >also, it is actually a "long". So I think this fix makes sense.
> 
> FreeBSD-7 has time_t tv_sec.

Thanks for the data point (I had looked at FreeBSD 6). I think this fix
still makes sense, though, as it should work on either type (and we
need to support the older platforms, too).

-Peff
