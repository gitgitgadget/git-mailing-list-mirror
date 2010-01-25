From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git_connect: use use_shell instead of explicit "sh",
 "-c"
Date: Mon, 25 Jan 2010 08:01:26 -0500
Message-ID: <20100125130125.GA10036@coredump.intra.peff.net>
References: <4B5D8F6C.1040407@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Jan 25 14:01:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZOZR-0003OB-Fq
	for gcvg-git-2@lo.gmane.org; Mon, 25 Jan 2010 14:01:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753181Ab0AYNB3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jan 2010 08:01:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753164Ab0AYNB3
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jan 2010 08:01:29 -0500
Received: from peff.net ([208.65.91.99]:38860 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752398Ab0AYNB2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jan 2010 08:01:28 -0500
Received: (qmail 8218 invoked by uid 107); 25 Jan 2010 13:06:24 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 25 Jan 2010 08:06:24 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 25 Jan 2010 08:01:26 -0500
Content-Disposition: inline
In-Reply-To: <4B5D8F6C.1040407@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137958>

On Mon, Jan 25, 2010 at 01:32:44PM +0100, Johannes Sixt wrote:

> This is a followup to ac0ba18 (run-command: convert simple callsites to
> use_shell, 2009-12-30), for consistency.
> 
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> ---
>  Jeff,
> 
>  is there a reason that this was not part of the original patch?

No, I must have just missed it (I don't remember omitting it for a
particular reason at the time, and after looking at it now, it looks
sane to me).

After this, git grep '"sh"' turns up only two uses: one in the
run-command code use_shell code path, and the other in builtin-help.c.
The one in builtin-help is hard to change, as it relies on direct exec
instead of run-command.

-Peff
