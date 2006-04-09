From: Francois Romieu <romieu@fr.zoreil.com>
Subject: Re: Fixes to parsecvs
Date: Mon, 10 Apr 2006 01:17:54 +0200
Message-ID: <20060409231754.GB13138@electric-eye.fr.zoreil.com>
References: <1144305392.2303.240.camel@neko.keithp.com> <20060406120812.GO13324@lug-owl.de> <1144334896.2303.259.camel@neko.keithp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jan-Benedict Glaw <jbglaw@lug-owl.de>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 10 01:22:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FSjEw-0002jG-R3
	for gcvg-git@gmane.org; Mon, 10 Apr 2006 01:22:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750787AbWDIXWe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 9 Apr 2006 19:22:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750826AbWDIXWe
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Apr 2006 19:22:34 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:48539 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S1750787AbWDIXWe
	(ORCPT <rfc822;git@vger.kernel.org>); Sun, 9 Apr 2006 19:22:34 -0400
Received: from electric-eye.fr.zoreil.com (localhost.localdomain [127.0.0.1])
	by fr.zoreil.com (8.13.4/8.12.1) with ESMTP id k39NHtO8019146;
	Mon, 10 Apr 2006 01:17:55 +0200
Received: (from romieu@localhost)
	by electric-eye.fr.zoreil.com (8.13.4/8.12.1) id k39NHsCo019145;
	Mon, 10 Apr 2006 01:17:54 +0200
To: Keith Packard <keithp@keithp.com>
Content-Disposition: inline
In-Reply-To: <1144334896.2303.259.camel@neko.keithp.com>
User-Agent: Mutt/1.4.2.1i
X-Organisation: Land of Sunshine Inc.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18571>

Keith Packard <keithp@keithp.com> :
[...]
> > How well does this work with even larger repositories?
> 
> postgresql is the largest I've run; starting with a 615M CVS repository,
> it built a 1.7G .git tree, which packed down to 125M.

As a datapoint, I gave parsecvs a try on a local CVS repository.
The repository weights 3.28 Go. It contains 53k files (45k non-attic).

.git/objets grew from ~100k files at the end of the first pass to
199k files (~11k commit). It took 18h on a 3GHz PIV with 2Go RAM.
After 6 hours, 400 Mo were pushed to swap and parsecvs took 1.95 Go
of RAM for itself. No significant swap activity. Swap grew to 900 Mo
at end of run. A tarball (5 Mo) containing vmstat + size of objects
is available at http://www.cogenit.fr/linux/misc/cvsparse-debug.tar.bz2

I have interrupted 'git repack -a -d' after 6 hours.

-- 
Ueimor
