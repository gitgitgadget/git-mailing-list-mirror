From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Python scripts audited for minimum compatible version
 and checks added.
Date: Thu, 20 Dec 2012 09:48:13 -0500
Message-ID: <20121220144813.GA27211@sigill.intra.peff.net>
References: <20121220141855.05DAA44105@snark.thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: "Eric S. Raymond" <esr@thyrsus.com>
X-From: git-owner@vger.kernel.org Thu Dec 20 15:48:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TlhQS-0000vl-9q
	for gcvg-git-2@plane.gmane.org; Thu, 20 Dec 2012 15:48:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751735Ab2LTOs0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Dec 2012 09:48:26 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:59663 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751427Ab2LTOsY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Dec 2012 09:48:24 -0500
Received: (qmail 9463 invoked by uid 107); 20 Dec 2012 14:49:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 20 Dec 2012 09:49:27 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Dec 2012 09:48:13 -0500
Content-Disposition: inline
In-Reply-To: <20121220141855.05DAA44105@snark.thyrsus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211891>

On Thu, Dec 20, 2012 at 09:13:37AM -0500, Eric S. Raymond wrote:

> diff --git a/contrib/ciabot/ciabot.py b/contrib/ciabot/ciabot.py
> index bd24395..b55648f 100755
> --- a/contrib/ciabot/ciabot.py
> +++ b/contrib/ciabot/ciabot.py
> @@ -50,6 +50,11 @@
>  import os, sys, commands, socket, urllib
>  from xml.sax.saxutils import escape
>  
> +if sys.hexversion < 0x02000000:
> +	# The limiter is the xml.sax module
> +        sys.stderr.write("import-zips.py: requires Python 2.0.0 or later.")
> +        sys.exit(1)

Should the error message say ciabot.py?

-Peff
