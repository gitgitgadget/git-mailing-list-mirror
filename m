From: Ryan Anderson <ryan@michonline.com>
Subject: Re: More problems...
Date: Fri, 29 Apr 2005 15:50:55 -0400
Message-ID: <20050429195055.GE1233@mythryan2.michonline.com>
References: <20050429170127.A30010@flint.arm.linux.org.uk> <20050429182708.GB14202@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Russell King <rmk@arm.linux.org.uk>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 29 21:46:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRbRL-0002ap-Rd
	for gcvg-git@gmane.org; Fri, 29 Apr 2005 21:46:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262914AbVD2Tva (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Apr 2005 15:51:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262915AbVD2Tva
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Apr 2005 15:51:30 -0400
Received: from mail.autoweb.net ([198.172.237.26]:27274 "EHLO mail.autoweb.net")
	by vger.kernel.org with ESMTP id S262914AbVD2TvB (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Apr 2005 15:51:01 -0400
Received: from pcp01184054pcs.strl301.mi.comcast.net ([68.60.186.73] helo=michonline.com)
	by mail.autoweb.net with esmtp (Exim 4.44)
	id 1DRbVo-00056X-59; Fri, 29 Apr 2005 15:50:56 -0400
Received: from mythical ([10.254.251.11] ident=Debian-exim)
	by michonline.com with esmtp (Exim 3.35 #1 (Debian))
	id 1DRbVo-0002i2-00; Fri, 29 Apr 2005 15:50:56 -0400
Received: from ryan by mythical with local (Exim 4.50)
	id 1DRbVn-0008WS-Rq; Fri, 29 Apr 2005 15:50:55 -0400
To: Petr Baudis <pasky@ucw.cz>
Content-Disposition: inline
In-Reply-To: <20050429182708.GB14202@pasky.ji.cz>
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 29, 2005 at 08:27:08PM +0200, Petr Baudis wrote:
> Dear diary, on Fri, Apr 29, 2005 at 06:01:27PM CEST, I got a letter
> where Russell King <rmk@arm.linux.org.uk> told me that...
> > rmk@dyn-67:[linux-2.6-rmk]:<1049> cg-update origin
> > `../linux-2.6/.git/objects/00/78aeb85737197a84af1eeb0353dbef74427901' -> `.git/objects/00/78aeb85737197a84af1eeb0353dbef74427901'
> > cp: cannot create link `.git/objects/00/78aeb85737197a84af1eeb0353dbef74427901': File exists
> > 
> > By that time, the object files in the reference tree appear to have
> > a newer timestamp than the corresponding ones in my local tree, and
> > cp -lua fails.
> 
> I'm now away ,unfortunately, and no immediate idea stems to my mind on
> how to fix it. Ideas welcomed - I need to hardlink missing entries from
> one tree to another; it would be enough to be able to just tell cp to
> ignore already present files.
> 
> Could you please try to give cp the -f flag?

Why not just use "rsync" for both remote and local synchronization, and
provide a "relink" command to scan two .git/objects/ repositories and
hardlink matching files together?

With the SHA1 hash, you can even have a --unsafe option that just
compares the has names and does a link based purely off of that and the
stat(2) results of both files.  (I'd expect that a ... safer variant
would extract both files and compare them, but the --unsafe should be
sufficient, in practice, I would think.)

-- 

Ryan Anderson
  sometimes Pug Majere
