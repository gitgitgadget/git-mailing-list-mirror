From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Odd logic in rebase--interactive
Date: Sun, 17 Feb 2008 21:41:41 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802172139370.30505@racer.site>
References: <alpine.LNX.1.00.0802171620060.5816@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sun Feb 17 22:42:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQrHH-0002V5-Sg
	for gcvg-git-2@gmane.org; Sun, 17 Feb 2008 22:42:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751356AbYBQVlw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Feb 2008 16:41:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751054AbYBQVlw
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Feb 2008 16:41:52 -0500
Received: from mail.gmx.net ([213.165.64.20]:45634 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750852AbYBQVlw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Feb 2008 16:41:52 -0500
Received: (qmail invoked by alias); 17 Feb 2008 21:41:50 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp014) with SMTP; 17 Feb 2008 22:41:50 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18orp9qFXcoCjB9vRO/kY0QQbzkGLLfl1smNSlfls
	tHoWG38xs1NwyF
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.LNX.1.00.0802171620060.5816@iabervon.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74185>

Hi,

On Sun, 17 Feb 2008, Daniel Barkalow wrote:

> In 1d25c8cf, you made pick_one not use the code for current and parent 
> being the same if no_ff is set, which is true if -n is given. This looks 
> like it makes the "git reset --soft $current_sha1" line dead code. Did 
> you just forget to remove it, is there some other situation in which it 
> would be wanted, or am I misunderstanding the code somehow?

No, you're correct, I just forgot to remove it.

The reset tried to have a fast track for the fast-forwarding case in the 
case of squash.  But that was not enough, and 1d25c8cf really fixed the 
issue, making the reset code path unreachable.

Thanks,
Dscho
