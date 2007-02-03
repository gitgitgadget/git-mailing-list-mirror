From: Matthias Kestenholz <lists@spinlock.ch>
Subject: Re: newbie questions about git design and features (some wrt hg)
Date: Sat, 03 Feb 2007 22:37:04 +0100
Message-ID: <1170538625.7564.12.camel@localhost.localdomain>
References: <3c6c07c20701300820l42cfc8dbsb80393fc1469f667@mail.gmail.com>
	 <200702010058.43431.jnareb@gmail.com> <20070201003429.GQ10108@waste.org>
	 <200702021055.49428.jnareb@gmail.com>
	 <slrnes6mmr.3l6.mdw@metalzone.distorted.org.uk>
	 <epvnln$fmn$1@sea.gmane.org>
	 <Pine.LNX.4.64.0702020835550.15057@woody.linux-foundation.org>
	 <20070202175923.GA6304@xanadu.kublai.com>
	 <20070202182709.GA3861@kobe.laptop>
	 <Pine.LNX.4.64.0702021050350.15057@woody.linux-foundation.org>
	 <20070203212030.GA91453@kobe.laptop>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>, jnareb@gmail.com,
	mercurial@selenic.com, git@vger.kernel.org
To: Giorgos Keramidas <keramida@ceid.upatras.gr>
X-From: git-owner@vger.kernel.org Sat Feb 03 22:37:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDSZZ-0007kq-Eb
	for gcvg-git@gmane.org; Sat, 03 Feb 2007 22:37:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751034AbXBCVhV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Feb 2007 16:37:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751065AbXBCVhV
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Feb 2007 16:37:21 -0500
Received: from elephant.oekohosting.ch ([80.74.144.79]:36061 "EHLO
	elephant.oekohosting.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751034AbXBCVhU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Feb 2007 16:37:20 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by elephant.oekohosting.ch (Postfix) with ESMTP id F411A62C09A;
	Sat,  3 Feb 2007 22:37:04 +0100 (CET)
Received: from elephant.oekohosting.ch ([127.0.0.1])
	by localhost (elephant.oekohosting.ch [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 04054-06; Sat, 3 Feb 2007 22:37:02 +0100 (CET)
Received: from [192.168.1.7] (58.98.79.83.cust.bluewin.ch [83.79.98.58])
	by elephant.oekohosting.ch (Postfix) with ESMTP id 9E59462C089;
	Sat,  3 Feb 2007 22:37:01 +0100 (CET)
In-Reply-To: <20070203212030.GA91453@kobe.laptop>
X-Mailer: Evolution 2.8.2.1 
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38608>

On Sat, 2007-02-03 at 23:20 +0200, Giorgos Keramidas wrote:
> Ok, maybe CVS was not so good as an example of why versioned tags *are*
> useful, but my comment came from the experience I have with the tagging
> of FreeBSD release builds.  The -STABLE branch os FreeBSD may be tagged
> with RELENG_X_Y_Z_RELEASE at a particular point in time.  If we find
> that some important bug fix has to go in, the fix is committed, and the
> tag can 'slide' forward for only a particular file or set of files.
> 

This operation is seriously broken. The Z number should be incremented,
the tag should continue pointing at the (now known to be) broken
version. That's exactly what the patchlevel number is for.

If users want to know if there are important security updates around,
they will look at the version number. If you change the revision which
the tag points to you will _seriously_ confuse users, a lot more than a
long list of patchlevel versions will ever do.

Matthias
