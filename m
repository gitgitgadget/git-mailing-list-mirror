From: Jeff King <peff@peff.net>
Subject: Re: irc usage..
Date: Tue, 23 May 2006 02:52:32 -0400
Message-ID: <20060523065232.GA6180@coredump.intra.peff.net>
References: <Pine.LNX.4.64.0605212132570.3697@g5.osdl.org> <46a038f90605220042v369e9ff5o3dc7841472171d02@mail.gmail.com> <Pine.LNX.4.64.0605220203200.3697@g5.osdl.org> <46a038f90605220554y569c11b9p24027772bd2ee79a@mail.gmail.com> <44720C66.6040304@gentoo.org> <46a038f90605221241x58ffa2a4o26159d38d86a8092@mail.gmail.com> <Pine.LNX.4.64.0605221256090.3697@g5.osdl.org> <20060522214128.GE16677@kiste.smurf.noris.de> <7v8xotadm3.fsf@assigned-by-dhcp.cox.net> <46a038f90605221615j59583bcdqf128bab31603148e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Matthias Urlichs <smurf@smurf.noris.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 23 08:52:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FiQky-0006Ie-9v
	for gcvg-git@gmane.org; Tue, 23 May 2006 08:52:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751268AbWEWGwh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 May 2006 02:52:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751287AbWEWGwh
	(ORCPT <rfc822;git-outgoing>); Tue, 23 May 2006 02:52:37 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:51681 "EHLO
	peff.net") by vger.kernel.org with ESMTP id S1751268AbWEWGwg (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 May 2006 02:52:36 -0400
Received: (qmail 12660 invoked from network); 23 May 2006 06:52:33 -0000
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 0 with SMTP; 23 May 2006 06:52:33 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 23 May 2006 02:52:32 -0400
To: Martin Langhoff <martin.langhoff@gmail.com>
Mail-Followup-To: Martin Langhoff <martin.langhoff@gmail.com>,
	Junio C Hamano <junkio@cox.net>,
	Matthias Urlichs <smurf@smurf.noris.de>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <46a038f90605221615j59583bcdqf128bab31603148e@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20566>

On Tue, May 23, 2006 at 11:15:07AM +1200, Martin Langhoff wrote:

> >I think cvsimport predates that option, but these days that loop
> >can be optimized by feeding --index-info from standard input.
> Oh, yep, that'd be a good addition. I think we can also cut down on

This patch is relatively simple, and I'll post it in a moment.

I also made a few other cleanups to commit() which apply on top of that;
I'll post it also.

> - Stop abusing globals in commit() -- pass the commit data as parameters.

Some of the globals actually get modified in commit() (e.g., @old and
@new get cleared).  So we need to either pass them in as references or
remember to do that cleanup each time it is called (which is really only
twice, I think).

> Will be trying to do those things in the next few days, don't mind if
> someone jumps in as well.

I can look at the line/block CVS file slurping, but not tonight.

-Peff
