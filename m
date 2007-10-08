From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Make git-clean a builtin
Date: Sun, 7 Oct 2007 22:22:05 -0400
Message-ID: <20071008022205.GA21277@coredump.intra.peff.net>
References: <11917040461528-git-send-email-shawn.bohrer@gmail.com> <20071008020435.GA20050@coredump.intra.peff.net> <alpine.LFD.0.999.0710071916510.23684@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Shawn Bohrer <shawn.bohrer@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Oct 08 04:22:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IeiGC-0001Nk-Sn
	for gcvg-git-2@gmane.org; Mon, 08 Oct 2007 04:22:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752654AbXJHCWJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Oct 2007 22:22:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752974AbXJHCWI
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Oct 2007 22:22:08 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4501 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752388AbXJHCWH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Oct 2007 22:22:07 -0400
Received: (qmail 9176 invoked by uid 111); 8 Oct 2007 02:22:06 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sun, 07 Oct 2007 22:22:06 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 07 Oct 2007 22:22:05 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.999.0710071916510.23684@woody.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60279>

On Sun, Oct 07, 2007 at 07:17:50PM -0700, Linus Torvalds wrote:

> fchdir() is not portable.
> 
> I think it would be better to not chdir() at all. Yes, that means having 
> to prepend the prefix to the names, but that is what git generally does 
> (for that - and other - reasons).

I was using the "even Solaris has it!" test, but yes, it's not POSIX. I
don't know how common it actually is (for curiosity's sake, do you know
of a common platform that lacks it?). But I do agree that just building
up the path and avoiding the chdir at all is simple and portable.

-Peff
