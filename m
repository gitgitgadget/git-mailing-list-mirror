From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] git-remote-mediawiki: better error message when
 HTTP(S) access fails
Date: Wed, 29 May 2013 11:26:53 -0400
Message-ID: <20130529152653.GB9072@sigill.intra.peff.net>
References: <vpqzjvej8p4.fsf@anie.imag.fr>
 <1369829189-27881-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Wed May 29 17:27:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhiHE-0001Fm-B8
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 17:27:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754171Ab3E2P04 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 May 2013 11:26:56 -0400
Received: from cloud.peff.net ([50.56.180.127]:39884 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752205Ab3E2P0z (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 May 2013 11:26:55 -0400
Received: (qmail 6894 invoked by uid 102); 29 May 2013 15:27:35 -0000
Received: from c-71-62-74-146.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.62.74.146)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 29 May 2013 10:27:35 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 29 May 2013 11:26:53 -0400
Content-Disposition: inline
In-Reply-To: <1369829189-27881-1-git-send-email-Matthieu.Moy@imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225835>

On Wed, May 29, 2013 at 02:06:29PM +0200, Matthieu Moy wrote:

> My use-case is an invalid SSL certificate. Pulling from the wiki with a
> recent version of libwww-perl fails, and git-remote-mediawiki gave no
> clue about the reason. Give the mediawiki API detailed error message, and
> since it is not so informative, hint the user about an invalid SSL
> certificate on https:// urls.
> 
> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>

Thanks, this looks like a reasonable stopping point for now.

There are still some calls that do not check the result of the mediawiki
calls at all, and I think they'll probably cause a perl error when they
fail (for dereferencing undef). But these ones are the initial contact,
so they should be the common ones to fail. Refactoring the whole error
handling is a bit larger task and can wait until somebody is interested.

-Peff
