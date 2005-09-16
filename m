From: Petr Baudis <pasky@suse.cz>
Subject: Re: git fsck messages - what to do about it?
Date: Fri, 16 Sep 2005 13:01:44 +0200
Message-ID: <20050916110144.GB25169@pasky.or.cz>
References: <20050916101138.99906352682@atlas.denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 16 13:03:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EGDyn-0001kO-9v
	for gcvg-git@gmane.org; Fri, 16 Sep 2005 13:02:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932607AbVIPLBx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Sep 2005 07:01:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932631AbVIPLBx
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Sep 2005 07:01:53 -0400
Received: from w241.dkm.cz ([62.24.88.241]:64214 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932607AbVIPLBw (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Sep 2005 07:01:52 -0400
Received: (qmail 27201 invoked by uid 2001); 16 Sep 2005 13:01:44 +0200
To: Wolfgang Denk <wd@denx.de>
Content-Disposition: inline
In-Reply-To: <20050916101138.99906352682@atlas.denx.de>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8676>

Dear diary, on Fri, Sep 16, 2005 at 12:11:38PM CEST, I got a letter
where Wolfgang Denk <wd@denx.de> told me that...
> When running git fsck I get some messages:
> 
> -> git-fsck-cache --unreachable $(cat .git/HEAD .git/refs/heads/*)
> unreachable commit 08cf4121ad704faa5ae7c7ae7b3dca4476ef2770
> unreachable tree 29a4c18afd958cc6cee938f0fe7fa59764418097
> unreachable tree 3b722a7278e02b272ddc8aefbc7be22703d8a94f
> unreachable tree 4ebc50d240d99b4236952d13d5044691f9078e3c
> unreachable tree 63af5944e130b449338cc907ee77c51f4a69e339
> unreachable tree 79c9a6bb02a80df15c7d829bdac0901f88c5e301
> unreachable blob 85dcf4b5c4c0f6833cd63fa1d0fd29ef250162af
> unreachable commit c1b779fbce762c970e3ace4332bb6ddc0de65e61
> unreachable blob d70d1d44f12db7b2a3976c2a5313c90568a62c25
> unreachable commit e1bcd2a5d53bceef2679737474487e32d87e7f2c
> 
> I have to admit that I don't know what to do next...
> 
> a) I understand that these  messages  are  indications  of  problems,
>    right? What can I do to clean this up?
> 
> b) Is there any way to find out what I did wrong in the first place?

In case you were using Cogito, cg-admin-uncommit will leave unreachable
objects in the database - it's safe to prune them (unless you'll decide
later that you after all wanted the uncommitted stuff, of course).

But note that IT IS NOT SAFE to prune repositories cloned with -l or
_being_ cloned with -l. Perhaps one solution to this would be having
.git/objects/info/repousers/ or something, which would contain symlinks
back to all the repositories using the given objects database. Opinions?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
If you want the holes in your knowledge showing up try teaching
someone.  -- Alan Cox
