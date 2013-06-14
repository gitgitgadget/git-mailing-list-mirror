From: Jeff King <peff@peff.net>
Subject: Re: [RFH/PATCH 0/4] git http tests with apache 2.4
Date: Fri, 14 Jun 2013 17:58:01 -0400
Message-ID: <20130614215801.GC29138@sigill.intra.peff.net>
References: <20130609080722.GA31699@sigill.intra.peff.net>
 <7v61xgpph2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 14 23:58:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Unc0a-0003is-Gv
	for gcvg-git-2@plane.gmane.org; Fri, 14 Jun 2013 23:58:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752656Ab3FNV6I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Jun 2013 17:58:08 -0400
Received: from cloud.peff.net ([50.56.180.127]:59464 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751699Ab3FNV6H (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jun 2013 17:58:07 -0400
Received: (qmail 23068 invoked by uid 102); 14 Jun 2013 21:59:00 -0000
Received: from c-71-62-74-146.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.62.74.146)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 14 Jun 2013 16:59:00 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 14 Jun 2013 17:58:01 -0400
Content-Disposition: inline
In-Reply-To: <7v61xgpph2.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227925>

On Fri, Jun 14, 2013 at 10:32:57AM -0700, Junio C Hamano wrote:

> > However, the final patch is very unsatisfactory. We have to pick an MPM
> > module to mention in the config, but we don't have any idea what's
> > available. I suspect what I have provided will work on most Unix-ish
> > systems. Under Windows, there is a totally different MPM. But I am not
> > sure that our http tests run at all on Windows, as we seem to check in
> > lib-httpd.sh for a Unix-ish apache module path.
> 
> Thanks.  I think the final one, while it may be unsatisfactory, is a
> reasonable (or "least bad") compromise, at least for now.  I do not
> think of a better way, without adding "if you want customization,
> write a snippet to be included in the configuration used during the
> test", which feels way overkill.

Yeah, we may have to go there. My feeling on it (and why I posted it
as-is) is that it improves the situation for some people, and should be
no worse for anyone else. Therefore people who are on 2.4 and are still
broken after this series can speak up and show us the exact breakage and
fix they need without us having to guess.

-Peff
