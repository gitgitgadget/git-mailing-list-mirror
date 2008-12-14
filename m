From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Let git remote accept up as alias to update
Date: Sun, 14 Dec 2008 06:25:01 -0500
Message-ID: <20081214112501.GD6499@coredump.intra.peff.net>
References: <20081213181704.20126.4200.stgit@zaytsev.su>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Alexey Zaytsev <alexey.zaytsev@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 14 12:26:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LBp78-0005v0-9k
	for gcvg-git-2@gmane.org; Sun, 14 Dec 2008 12:26:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753015AbYLNLZF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Dec 2008 06:25:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753322AbYLNLZE
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Dec 2008 06:25:04 -0500
Received: from peff.net ([208.65.91.99]:2126 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753015AbYLNLZD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Dec 2008 06:25:03 -0500
Received: (qmail 29278 invoked by uid 111); 14 Dec 2008 11:25:02 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sun, 14 Dec 2008 06:25:02 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 14 Dec 2008 06:25:01 -0500
Content-Disposition: inline
In-Reply-To: <20081213181704.20126.4200.stgit@zaytsev.su>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103073>

On Sat, Dec 13, 2008 at 09:18:56PM +0300, Alexey Zaytsev wrote:

> Signed-off-by: Alexey Zaytsev <alexey.zaytsev@gmail.com>
> ---
> 
> Don't know why, but I keep typing remote up instead of
> remote update. As update is probably by far the most
> used remote action, can we please have this alias?

Hmm. The usual answer for requests like this is "make your own alias".
But usually they are for primary command aliases (e.g., "co" for
"checkout"), and this is a sub-command. So you are actually stuck doing:

  git config alias.rup "remote update"

which is maybe better (even less typing) but is not exactly what you
asked for.

I think even nicer than an explicit "up" alias would be to accept any
prefix as long as it was unique. However, I think a scheme like that
would only make sense if it was used fairly universally, and the current
code is not amenable to doing it for regular commands (it doesn't
actually have a complete list of commands -- it just tries to exec what
you tell it). However, it could be refactored to do so.

-Peff
