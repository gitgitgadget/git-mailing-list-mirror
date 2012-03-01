From: Jeff King <peff@peff.net>
Subject: Re: Question about credential api
Date: Thu, 1 Mar 2012 15:44:39 -0500
Message-ID: <20120301204439.GA17631@sigill.intra.peff.net>
References: <4F4F88F9.50302@seap.minhap.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es>
X-From: git-owner@vger.kernel.org Thu Mar 01 21:44:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3Crq-00047z-1j
	for gcvg-git-2@plane.gmane.org; Thu, 01 Mar 2012 21:44:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757879Ab2CAUon (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Mar 2012 15:44:43 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:34532
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757640Ab2CAUom (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2012 15:44:42 -0500
Received: (qmail 8692 invoked by uid 107); 1 Mar 2012 20:44:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 01 Mar 2012 15:44:46 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 01 Mar 2012 15:44:39 -0500
Content-Disposition: inline
In-Reply-To: <4F4F88F9.50302@seap.minhap.es>
 <4F4F7A94.2000804@seap.minhap.es>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191969>

On Thu, Mar 01, 2012 at 02:33:08PM +0100, Nelson Benitez Leon wrote:

> static struct credential proxy_auth = CREDENTIAL_INIT;
> credential_from_url(&proxy_auth, "http://proxy.server.com:8080");
> 
> will prox_auth.username and prox_auth.password be an empty string ? so
> that strcmp(proxy_auth.username,"") returns zero.. couldn't figure that
> out from api-credentials.txt 
> [...]
> Ok don't bother, I've already checked and seems to return NULL
>  in this case.

Right. It is NULL, which translates to "we don't know yet and it needs
to be filled in during credential_fill".

-Peff
