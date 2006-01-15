From: Pavel Roskin <proski@gnu.org>
Subject: Re: [PATCH] cg-seek should not complain if run twice
Date: Sun, 15 Jan 2006 01:03:35 -0500
Message-ID: <20060115010335.dj4swocs000k008o@webmail.spamcop.net>
References: <1135054536.3815.14.camel@dv>
	<20060114233037.GA28365@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jan 15 07:04:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ey0zj-00027W-4l
	for gcvg-git@gmane.org; Sun, 15 Jan 2006 07:04:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751744AbWAOGDm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Jan 2006 01:03:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751861AbWAOGDm
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jan 2006 01:03:42 -0500
Received: from mailgate.cesmail.net ([216.154.195.36]:11489 "HELO
	mailgate.cesmail.net") by vger.kernel.org with SMTP
	id S1751744AbWAOGDm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jan 2006 01:03:42 -0500
Received: (qmail 17101 invoked from network); 15 Jan 2006 06:03:35 -0000
Received: from unknown (HELO delta.cesmail.net) (192.168.1.30)
  by mailgate.cesmail.net with SMTP; 15 Jan 2006 06:03:35 -0000
Received: (qmail 15108 invoked by uid 99); 15 Jan 2006 06:03:35 -0000
Received: from static-68-161-241-229.ny325.east.verizon.net
	(static-68-161-241-229.ny325.east.verizon.net [68.161.241.229]) by
	webmail.spamcop.net (Horde) with HTTP for <proski@spamcop.net@cesmail.net>;
	Sun, 15 Jan 2006 01:03:35 -0500
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20060114233037.GA28365@pasky.or.cz>
Content-Disposition: inline
User-Agent: Internet Messaging Program (IMP) 4.0-cvs
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14694>

Hello, Petr!

Quoting Petr Baudis <pasky@suse.cz>:

> It seems cleaner to just make cg-seek fail with a sensible error message
> if it's already unseeked.

I don't like this.  What if "cvs up -A" would fail if run twice?  What if
cg-clean would fail if there was nothing to clean?  What if sync would fail if
it didn't cause a single disk write?  Idempotent operations are easier to work
with.  Please see http://en.wikipedia.org/wiki/Idempotent_(software)

I could make an exception for the case when the command invocation indicates
that the user is unaware of something, and that it would endanger the user's
data.  But it's not the case for cg-seek without arguments on non-seeked
repository.  The intention is clear, and the knowledge of the current state of
the repository doesn't matter, since there will be no merge or something.

--
Regards,
Pavel Roskin
