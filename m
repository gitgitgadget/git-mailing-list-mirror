From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] write_or_die: remove the unused write_or_whine() function
Date: Thu, 9 Jun 2016 20:01:07 -0400
Message-ID: <20160610000107.GA25874@sigill.intra.peff.net>
References: <5759F326.9080101@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
X-From: git-owner@vger.kernel.org Fri Jun 10 02:01:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bB9sx-00089w-6n
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jun 2016 02:01:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752123AbcFJABL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jun 2016 20:01:11 -0400
Received: from cloud.peff.net ([50.56.180.127]:52210 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751016AbcFJABL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jun 2016 20:01:11 -0400
Received: (qmail 9564 invoked by uid 102); 10 Jun 2016 00:01:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 09 Jun 2016 20:01:10 -0400
Received: (qmail 28837 invoked by uid 107); 10 Jun 2016 00:01:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 09 Jun 2016 20:01:20 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 09 Jun 2016 20:01:07 -0400
Content-Disposition: inline
In-Reply-To: <5759F326.9080101@ramsayjones.plus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296941>

On Thu, Jun 09, 2016 at 11:52:22PM +0100, Ramsay Jones wrote:

> 
> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> ---
> 
> Hi Junio,
> 
> Commit f0bca72d ("send-pack: use buffered I/O to talk to pack-objects",
> 08-06-2016) removed the last use of write_or_whine(). I had intended to
> include this 'commit citation' in the commit message, but until it reaches
> the next branch, I don't know how stable that information will be.
> 
> Anyway, on reflection, the subject line says everything that needs to be
> said. However, you need to know which commit this one depends on. ;-)

IMHO, it's a good idea for removal patches to reflect on why the thing
is appropriate to remove. Obviously there are no callers, but do we
expect any to come back? I think probably not, because this function is
doing very little that a regular if() does not besides obfuscating the
error message (and if we ever did want something like it, we would
probably prefer the function to come back with more "normal" return
value semantics).

-Peff
