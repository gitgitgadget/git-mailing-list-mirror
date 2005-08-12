From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] Clean generated files a bit more.
Date: Fri, 12 Aug 2005 13:40:53 +0200
Message-ID: <20050812114053.GB29893@pasky.ji.cz>
References: <7v8xz75w6p.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 12 13:41:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E3XuH-0000ei-Rk
	for gcvg-git@gmane.org; Fri, 12 Aug 2005 13:41:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932164AbVHLLk7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 12 Aug 2005 07:40:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932184AbVHLLk7
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Aug 2005 07:40:59 -0400
Received: from w241.dkm.cz ([62.24.88.241]:17157 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S932164AbVHLLk6 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Aug 2005 07:40:58 -0400
Received: (qmail 31118 invoked by uid 2001); 12 Aug 2005 11:40:53 -0000
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v8xz75w6p.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Fri, Aug 12, 2005 at 11:41:34AM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> told me that...
> Also attempt to build a source package for debian.
> ---
> 
>  Makefile |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> b263f24ce4f12dd39cfcd922c56a32292c6232c9
> diff --git a/Makefile b/Makefile
> --- a/Makefile
> +++ b/Makefile
> @@ -238,14 +238,14 @@ rpm: dist
>  deb: dist
>  	rm -rf $(GIT_TARNAME)
>  	tar zxf $(GIT_TARNAME).tar.gz
> +	dpkg-source -b $(GIT_TARNAME)
>  	cd $(GIT_TARNAME) && fakeroot debian/rules binary
>  
>  ### Cleaning rules
>  
>  clean:
>  	rm -f *.o mozilla-sha1/*.o ppc/*.o $(PROG) $(LIB_FILE)
> -	rm -f $(GIT_TARNAME).tar.gz git-core.spec
> -	rm -f git-core_$(GIT_VERSION)-*.deb git-tk_$(GIT_VERSION)-*.deb
> +	rm -f git-core.spec *.deb *.dsc *.tar.gz 


This makes me a bit nervous - why are you making the rules more general?
make clean removing random tarballs of mine happenning to dwell in that
directory is fearsome.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
If you want the holes in your knowledge showing up try teaching
someone.  -- Alan Cox
