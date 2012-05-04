From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 5/6] http: Avoid limit of retrying request only twice
Date: Fri, 4 May 2012 03:24:27 -0400
Message-ID: <20120504072427.GE21895@sigill.intra.peff.net>
References: <4FA2B4FC.3030309@seap.minhap.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es>
X-From: git-owner@vger.kernel.org Fri May 04 09:24:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQCsV-0000Ux-Ci
	for gcvg-git-2@plane.gmane.org; Fri, 04 May 2012 09:24:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753135Ab2EDHYb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 May 2012 03:24:31 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:57627
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752319Ab2EDHYa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 May 2012 03:24:30 -0400
Received: (qmail 16227 invoked by uid 107); 4 May 2012 07:24:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 04 May 2012 03:24:47 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 04 May 2012 03:24:27 -0400
Content-Disposition: inline
In-Reply-To: <4FA2B4FC.3030309@seap.minhap.es>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197001>

On Thu, May 03, 2012 at 06:40:28PM +0200, Nelson Benitez Leon wrote:

> Current code, after receiving HTTP_REAUTH, only retried
> once, so couldn't do step 3 of the following sequence:
> 
>   1. We make a request; proxy returns 407, because we didn't give it a
>      password. We ask for the password and return HTTP_REAUTH.
> 
>   2. We make another request; the proxy passes it to the actual server,
>      who returns 401, because we didn't give an http password. We ask
>      for the password and return HTTP_REAUTH.
> 
>   3. We make a third request, but this time everybody is happy.
> 
> Now we retry as long as we keep receiving HTTP_REAUTH, so the previous
> sequence correctly completes.
> 
> Patch by Jeff King <peff@peff.net>

We usually spell that as:

  From: Jeff King <peff@peff.net>

at the beginning of the email body (which lets am set the author
appropriately).

Other than that, the patch looks good to me (unsurprisingly :) ).

-Peff
