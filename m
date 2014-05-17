From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 10/10] Documentation: replace: describe new --edit
 option
Date: Sat, 17 May 2014 03:23:47 -0400
Message-ID: <20140517072347.GF13003@sigill.intra.peff.net>
References: <20140517062418.18932.21200.chriscool@tuxfamily.org>
 <20140517064133.18932.96622.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Sat May 17 09:23:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WlYyG-0001V1-UY
	for gcvg-git-2@plane.gmane.org; Sat, 17 May 2014 09:23:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756990AbaEQHXt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 May 2014 03:23:49 -0400
Received: from cloud.peff.net ([50.56.180.127]:53691 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756642AbaEQHXt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 May 2014 03:23:49 -0400
Received: (qmail 11747 invoked by uid 102); 17 May 2014 07:23:49 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 17 May 2014 02:23:49 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 17 May 2014 03:23:47 -0400
Content-Disposition: inline
In-Reply-To: <20140517064133.18932.96622.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249456>

On Sat, May 17, 2014 at 08:41:32AM +0200, Christian Couder wrote:

> @@ -63,6 +64,14 @@ OPTIONS
>  --delete::
>  	Delete existing replace refs for the given objects.
>  
> +--edit <object>::
> +	Launch an editor to let the user change the content of
> +	<object>, then create a new object of the same type with the
> +	changed content, and create a replace ref to replace <object>
> +	with the new object. See linkgit:git-commit[1] and
> +	linkgit:git-var[1] for details about how the editor will be
> +	chosen.

I found the first sentence a little hard to parse, and there are a few
more details that might be worth mentioning:

  --edit <object>::
    Edit an object's content interactively. The existing content for
    <object> is pretty-printed into a temporary file, an editor is
    launched on the file, and the result is parsed to create a new
    object of the same type as <object>. A replacement ref is then
    created to replace <object> with the newly created object.

I do not know if it is worth mentioning git-commit and git-var here. But
if we want to, I think git-var is sufficient (git-commit seems to mostly
just points at git-var these days).

-Peff
