From: Jeff King <peff@peff.net>
Subject: [PATCH 0/5] mixed bag of minor "git mv" fixes
Date: Mon, 12 Dec 2011 02:45:03 -0500
Message-ID: <20111212074503.GB16511@sigill.intra.peff.net>
References: <877h226bxe.fsf@picasso.cante.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jari Aalto <jari.aalto@cante.net>
X-From: git-owner@vger.kernel.org Mon Dec 12 08:45:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ra0ZT-0005c2-57
	for gcvg-git-2@lo.gmane.org; Mon, 12 Dec 2011 08:45:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751386Ab1LLHpG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Dec 2011 02:45:06 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:47995
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751036Ab1LLHpF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2011 02:45:05 -0500
Received: (qmail 29977 invoked by uid 107); 12 Dec 2011 07:51:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 12 Dec 2011 02:51:45 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Dec 2011 02:45:03 -0500
Content-Disposition: inline
In-Reply-To: <877h226bxe.fsf@picasso.cante.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186878>

On Sun, Dec 11, 2011 at 11:22:37PM +0200, Jari Aalto wrote:

> Every time I do:
> 
>     git mv -f FROM TO
> 
> Git displays:
> 
>     warning: destination exists; will overwrite!
> 
> Please don't display anything other than errors (no write permission....).
> 
> The "-f" is like with mv(1), cp(1); there is nothing than can be done
> afterwards, so the message is redundant and obstructing.

I'm inclined to agree. Outputting a warning just because we did what the
user asked us to is unnecessarily chatty.

When I looked into it, though, it seems that "git mv" is somewhat
neglected, and this trival one-line patch turned into a 5-patch series
of fixes.

  [1/5]: docs: mention "-k" for both forms of "git mv"
  [2/5]: mv: honor --verbose flag
  [3/5]: mv: make non-directory destination error more clear
  [4/5]: mv: improve overwrite warning
  [5/5]: mv: be quiet about overwriting

-Peff
