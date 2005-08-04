From: Petr Baudis <pasky@suse.cz>
Subject: git: problems in read-only trees
Date: Thu, 4 Aug 2005 22:11:25 +0200
Message-ID: <20050804201125.GB24479@pasky.ji.cz>
References: <20050803074241.A2D1D3535F9@atlas.denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 04 22:12:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E0m41-0006vg-38
	for gcvg-git@gmane.org; Thu, 04 Aug 2005 22:11:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262654AbVHDULb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 4 Aug 2005 16:11:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262655AbVHDULb
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Aug 2005 16:11:31 -0400
Received: from w241.dkm.cz ([62.24.88.241]:6155 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262654AbVHDULa (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Aug 2005 16:11:30 -0400
Received: (qmail 16583 invoked by uid 2001); 4 Aug 2005 20:11:25 -0000
To: Wolfgang Denk <wd@denx.de>
Content-Disposition: inline
In-Reply-To: <20050803074241.A2D1D3535F9@atlas.denx.de>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Wed, Aug 03, 2005 at 09:42:41AM CEST, I got a letter
where Wolfgang Denk <wd@denx.de> told me that...
> Hello,
> 
> sometimes I have to  work  in  trees  for  which  I  have  only  read
> permissions; cogito has problems then - for example:
> 
> -> cg-diff 
> fatal: unable to create new cachefile
> fatal: unable to create temp-file
> 
> It would be nice if there was at least a way to specify  some  TMPDIR
> instead of the current directory in such a situation.

This is a bug in git-diff-* (producing the second error message; the first
error message means failed git-update-cache --refresh but that isn't
fatal). Any reason why prep_temp_blob() works in . instead of $TMPDIR?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
If you want the holes in your knowledge showing up try teaching
someone.  -- Alan Cox
