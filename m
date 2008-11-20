From: Roger Leigh <rleigh@codelibre.net>
Subject: Re: git and mtime
Date: Thu, 20 Nov 2008 13:35:46 +0000
Message-ID: <20081120133546.GA6023@codelibre.net>
References: <20081119113752.GA13611@ravenclaw.codelibre.net> <20081120132107.GA27571@piper.oerlikon.madduck.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: martin f krafft <madduck@madduck.net>
X-From: git-owner@vger.kernel.org Thu Nov 20 14:37:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L39iR-0000T8-Ug
	for gcvg-git-2@gmane.org; Thu, 20 Nov 2008 14:37:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754131AbYKTNft (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Nov 2008 08:35:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754075AbYKTNft
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Nov 2008 08:35:49 -0500
Received: from nagini.codelibre.net ([80.68.93.164]:42619 "EHLO
	nagini.codelibre.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752677AbYKTNfs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Nov 2008 08:35:48 -0500
Received: by nagini.codelibre.net (Postfix, from userid 1000)
	id C7F4B18852; Thu, 20 Nov 2008 13:35:46 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <20081120132107.GA27571@piper.oerlikon.madduck.net>
X-GPG-Key: 0x25BFB848
X-Debian: testing/unstable
X-OS-Uptime: 13:26:52 up 13 days,  1:44,  3 users,  load average: 0.01,
	0.11, 0.09
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101428>

On Thu, Nov 20, 2008 at 02:21:07PM +0100, martin f krafft wrote:
> also sprach Roger Leigh <rleigh@codelibre.net> [2008.11.19.1237 +0100]:
> > These are provided by upstream so that end users don't need these tools
> > installed (particularly docbook, since the toolchain is so flaky on
> > different systems).  However, the fact that git isn't storing the
> > mtime of the files confuses make, so it then tries to regenerate these
> > (already up-to-date) files, and fails in the process since the tools
> > aren't available.
> 
> I don't get it. Why are end users running make in the first place?
> Why aren't those in the build-dependencies?

By end user, I mean person downloading and building the sources.

They are optional build depdendencies.  They are provided pre-built,
and won't be rebuilt unless they get outdated.  In the release
tarball, the timestamps are correct, ensuring this never happens.
When checking out with git, the timestamps are incorrect, and it
attempts to rebuild something that's *already built*.


Regards,
Roger

-- 
  .''`.  Roger Leigh
 : :' :  Debian GNU/Linux             http://people.debian.org/~rleigh/
 `. `'   Printing on GNU/Linux?       http://gutenprint.sourceforge.net/
   `-    GPG Public Key: 0x25BFB848   Please GPG sign your mail.
