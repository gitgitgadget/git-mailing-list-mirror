From: Krzysztof Halasa <khc@pm.waw.pl>
Subject: Re: [PATCH] multi item packed files
Date: Fri, 22 Apr 2005 11:48:48 +0200
Message-ID: <m3r7h3rvjz.fsf@defiant.localdomain>
References: <200504211113.13630.mason@suse.com>
	<Pine.LNX.4.58.0504210832490.2344@ppc970.osdl.org>
	<m3u0m0q69a.fsf@defiant.localdomain>
	<200504211622.48065.mason@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 22 11:45:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOuhz-0006GZ-LC
	for gcvg-git@gmane.org; Fri, 22 Apr 2005 11:44:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262016AbVDVJsw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Apr 2005 05:48:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262017AbVDVJsw
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Apr 2005 05:48:52 -0400
Received: from khc.piap.pl ([195.187.100.11]:17668 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S262016AbVDVJsu (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Apr 2005 05:48:50 -0400
Received: by khc.piap.pl (Postfix, from userid 500)
	id 0C43A1082A; Fri, 22 Apr 2005 11:48:49 +0200 (CEST)
To: Chris Mason <mason@suse.com>
In-Reply-To: <200504211622.48065.mason@suse.com> (Chris Mason's message of
 "Thu, 21 Apr 2005 16:22:46 -0400")
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Chris Mason <mason@suse.com> writes:

> Shrug, we shouldn't need help from the kernel for something like this.
>  git as 
> a database hits worst case scenarios for almost every FS.

Not sure.

> 1) subdirectories with lots of files

Correct. But git doesn't search dirs so it's not that bad.

> 2) wasted space for tiny files

... depends on block size. With 2 KB:

defiant:~$ du -s /pub/mirror/linux-2.6.git
88366   /pub/mirror/linux-2.6.git
defiant:~$ du -s --apparent-size /pub/mirror/linux-2.6.git
63400   /pub/mirror/linux-2.6.git

Not bad, is it?

> 3) files that are likely to be accessed together spread across the whole disk

... across the whole filesystem.

Well, probably it isn't best to have git and .iso archives on the same
filesystem.
-- 
Krzysztof Halasa
