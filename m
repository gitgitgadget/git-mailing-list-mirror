From: Petr Baudis <pasky@ucw.cz>
Subject: Re: Re: [patch pasky] update gitcancel.sh to handle modes as well
Date: Fri, 15 Apr 2005 01:07:12 +0200
Message-ID: <20050414230712.GT22699@pasky.ji.cz>
References: <1113519445.23299.119.camel@nosferatu.lan> <1113519890.23299.129.camel@nosferatu.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT Mailing Lists <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Apr 15 01:06:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMDPJ-0004Y8-Ei
	for gcvg-git@gmane.org; Fri, 15 Apr 2005 01:05:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261640AbVDNXIM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Apr 2005 19:08:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261648AbVDNXIM
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Apr 2005 19:08:12 -0400
Received: from w241.dkm.cz ([62.24.88.241]:48333 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261640AbVDNXHN (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Apr 2005 19:07:13 -0400
Received: (qmail 18522 invoked by uid 2001); 14 Apr 2005 23:07:12 -0000
To: Martin Schlemmer <azarah@nosferatu.za.org>
Content-Disposition: inline
In-Reply-To: <1113519890.23299.129.camel@nosferatu.lan>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Fri, Apr 15, 2005 at 01:04:50AM CEST, I got a letter
where Martin Schlemmer <azarah@nosferatu.za.org> told me that...
> Rather use checkout-cache to sync our tree, as should do the right thing
> instead of diffing (cancel imply just blow away everything).
> 
> Signed-off-by: Martin Schlemmer <azarah@nosferatu.za.org>
> 
> gitcancel.sh:  839b3c58f20f6eb8412f499a891e007e2e67d114
> --- 839b3c58f20f6eb8412f499a891e007e2e67d114/gitcancel.sh
> +++ uncommitted/gitcancel.sh
> @@ -10,9 +10,8 @@
>  #
>  # Takes no arguments. Takes the evil changes from the tree.
> 
> -# FIXME: Does not revert mode changes!
> 
> -show-diff | patch -p0 -R
>  rm -f .git/add-queue .git/rm-queue
> +checkout-cache -q -f -a
> 
>  update-cache --refresh

Why -q?

Never make things silent unless you really know what are you doing and
why. The same goes for popular throwing of -f to rm's of files which
should always exist or 2>/dev/null for cats.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
