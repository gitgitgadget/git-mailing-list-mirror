From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/4] diff/xdiff: refactor EOF-EOL detection
Date: Sun, 6 Jun 2010 18:03:05 -0400
Message-ID: <20100606220304.GC6993@coredump.intra.peff.net>
References: <cover.1275575236.git.git@drmicha.warpmail.net>
 <08e635cee993d97e2a38d7766ced11c064ef7d87.1275575236.git.git@drmicha.warpmail.net>
 <7vsk537p8k.fsf@alter.siamese.dyndns.org>
 <4C08AD75.6040307@drmicha.warpmail.net>
 <7vpr060ys0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 07 00:03:15 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OLNw2-0007eL-W9
	for gcvg-git-2@lo.gmane.org; Mon, 07 Jun 2010 00:03:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755228Ab0FFWDJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jun 2010 18:03:09 -0400
Received: from peff.net ([208.65.91.99]:58807 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754396Ab0FFWDI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jun 2010 18:03:08 -0400
Received: (qmail 12369 invoked by uid 107); 6 Jun 2010 22:03:15 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 06 Jun 2010 18:03:15 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 06 Jun 2010 18:03:05 -0400
Content-Disposition: inline
In-Reply-To: <7vpr060ys0.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148549>

On Fri, Jun 04, 2010 at 11:38:39PM -0700, Junio C Hamano wrote:

> It can be done by defining a custom textconv filter that adds a trailing
> LF to a blob that ends in an incomplete line, and what your patch 3/4 does
> is essentially to create such a built-in textconv filter and *force* users
> to use it unconditionally for all paths unless the user explicitly asks
> not to use *any* textconv.

Side note: it would be kind of cool to have .gitattributes selectable on
file mode, so you could implement this feature entirely as a textconv on
symlinks.  And then you could pretty-print them however you liked.

That may be going overboard, though.

-Peff
