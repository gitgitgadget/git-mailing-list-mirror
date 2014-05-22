From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 7/9] remote-curl: recognize text/plain with a charset
 parameter
Date: Thu, 22 May 2014 05:05:57 -0400
Message-ID: <20140522090557.GB29669@sigill.intra.peff.net>
References: <20140521102524.GA30301@sigill.intra.peff.net>
 <20140521103301.GG30464@sigill.intra.peff.net>
 <90CE006F-EE74-40D2-8847-507E37021D84@gmail.com>
 <alpine.DEB.2.00.1405220809370.10958@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Kyle J. McKay" <mackyle@gmail.com>, git@vger.kernel.org
To: Peter Krefting <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Thu May 22 11:06:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WnOwu-0002MM-EH
	for gcvg-git-2@plane.gmane.org; Thu, 22 May 2014 11:06:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754103AbaEVJGA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 May 2014 05:06:00 -0400
Received: from cloud.peff.net ([50.56.180.127]:57215 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752114AbaEVJF7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 May 2014 05:05:59 -0400
Received: (qmail 10099 invoked by uid 102); 22 May 2014 09:05:59 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 22 May 2014 04:05:59 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 22 May 2014 05:05:57 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1405220809370.10958@ds9.cixit.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249883>

On Thu, May 22, 2014 at 08:12:58AM +0100, Peter Krefting wrote:

> Kyle J. McKay:
> 
> >I think that a strict reading of RFC 2616 allows "text/plain ;
> >charset=utf-8" as well as "text/plain;charset=utf-8" and "text/plain;
> >charset=utf-8".
> 
> It does indeed, and I have seen servers send both variants, so they do need
> to be catered for.
> 
> The number of servers that would actually send the charset attribute here
> (for error messages) are probably not that many. It is probably a good idea
> to make the default user-configurable (I know the specs state that anything
> undeclared is iso-8859-1, but the real world doesn't agree to that).

I was really hoping to avoid getting into all of the real-world
messiness that a real http client needs to deal with (as opposed to just
following the standards). This is only used for an optional relay of
error messages from the server. Most servers will send back text/html by
default, and only those which specifically configure text/plain will
have their messages shown. IOW, I expect this to be configured
specifically for git messages, and the server admin can make sure they
are following the standard and that it works with git.

-Peff
