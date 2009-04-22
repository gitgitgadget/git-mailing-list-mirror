From: Jeff King <peff@peff.net>
Subject: Re: Cryptic error messages?
Date: Wed, 22 Apr 2009 16:50:07 -0400
Message-ID: <20090422205006.GE14146@coredump.intra.peff.net>
References: <450196A1AAAE4B42A00A8B27A59278E70ACE0030@EXCHANGE.trad.tradestation.com> <20090422203251.GD14146@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: John Dlugosz <JDlugosz@TradeStation.com>
X-From: git-owner@vger.kernel.org Wed Apr 22 22:52:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LwjQ4-0006jB-42
	for gcvg-git-2@gmane.org; Wed, 22 Apr 2009 22:51:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754253AbZDVUuN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Apr 2009 16:50:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754313AbZDVUuM
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Apr 2009 16:50:12 -0400
Received: from peff.net ([208.65.91.99]:45587 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754089AbZDVUuL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Apr 2009 16:50:11 -0400
Received: (qmail 18316 invoked by uid 107); 22 Apr 2009 20:50:19 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 22 Apr 2009 16:50:19 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 22 Apr 2009 16:50:07 -0400
Content-Disposition: inline
In-Reply-To: <20090422203251.GD14146@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117258>

On Wed, Apr 22, 2009 at 04:32:51PM -0400, Jeff King wrote:

>   3. receive-pack notices that the unpacker failed, and spews
> 
>        error: unpack failed: unpacker exited with error code
> 
>      to stderr, in case unpack-objects didn't say anything.

Actually, this is not true. receive-pack actually passes the error code
back to send-pack, which prints it. I think it is doing so because we
get that status separate from the individual ref status. But if you look
at receive-pack, it doesn't even bother trying individual refs if the
unpack failed; every ref will just get the "unpack failed" message.

-Peff
