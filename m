From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] commit.c - provide commit-type to the
 hooks/pre-commit script
Date: Mon, 7 Jun 2010 02:38:17 -0400
Message-ID: <20100607063817.GA23361@coredump.intra.peff.net>
References: <1275759590-16342-1-git-send-email-mlevedahl@gmail.com>
 <20100606221037.GE6993@coredump.intra.peff.net>
 <4C0C912D.9080404@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Mark Levedahl <mlevedahl@gmail.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Jun 07 08:38:25 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OLVya-0007tC-Hg
	for gcvg-git-2@lo.gmane.org; Mon, 07 Jun 2010 08:38:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754620Ab0FGGiU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jun 2010 02:38:20 -0400
Received: from peff.net ([208.65.91.99]:35061 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754466Ab0FGGiT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jun 2010 02:38:19 -0400
Received: (qmail 18182 invoked by uid 107); 7 Jun 2010 06:38:29 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 07 Jun 2010 02:38:29 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 07 Jun 2010 02:38:17 -0400
Content-Disposition: inline
In-Reply-To: <4C0C912D.9080404@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148579>

On Mon, Jun 07, 2010 at 08:26:53AM +0200, Johannes Sixt wrote:

> > Is there a reason to use the magic "amend" and "normal" words, if
> > scripts are just going to end up changing them back into HEAD~1 and HEAD
> > anyway?
> 
> pre-commit might act differently when a commit is amended, the most likely
> reason I can think of is to always allow to amend. When you have only a
> SHA1, you can get that information only with an additional process.

Actually, I meant to provide the hook with the literal words "HEAD~1"
and "HEAD", not the sha1. So they are effectively magic words, but they
also happen to be useful for directly feeding to git commands.

It also extends naturally to indicating a merge commit ("HEAD" or
"HEAD~1" followed by some other ref). I don't know if that is useful or
not, but it seems like the same realm of information as whether or not
we are amending.

-Peff
