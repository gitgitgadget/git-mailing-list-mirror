From: Petr Baudis <pasky@ucw.cz>
Subject: Re: update gitcancel.sh to handle modes as well
Date: Fri, 15 Apr 2005 00:57:22 +0200
Message-ID: <20050414225722.GR22699@pasky.ji.cz>
References: <1113519445.23299.119.camel@nosferatu.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT Mailing Lists <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Apr 15 00:58:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMDGt-0003MZ-Nn
	for gcvg-git@gmane.org; Fri, 15 Apr 2005 00:57:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261628AbVDNXAU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Apr 2005 19:00:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261629AbVDNXAU
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Apr 2005 19:00:20 -0400
Received: from w241.dkm.cz ([62.24.88.241]:37325 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261628AbVDNW5Y (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Apr 2005 18:57:24 -0400
Received: (qmail 17503 invoked by uid 2001); 14 Apr 2005 22:57:22 -0000
To: Martin Schlemmer <azarah@nosferatu.za.org>
Content-Disposition: inline
In-Reply-To: <1113519445.23299.119.camel@nosferatu.lan>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Fri, Apr 15, 2005 at 12:57:25AM CEST, I got a letter
where Martin Schlemmer <azarah@nosferatu.za.org> told me that...
> Hi,
> 
> gitcancel.sh do not handle mode changes:
> 
> ----
> $ chmod -x Makefile
> $ git cancel
> patch: **** Only garbage was found in the patch input.
> ----
> 
> Rather use checkout-cache to sync our tree, as should do the right thing
> instead of diffing (cancel imply just blow away everything).
> 
> Signed-off-by: Martin Schlemmer <azarah@nosferatu.za.org>
> 
> gittrack.sh:  03d6db1fb3a70605ef249c632c04e542457f0808
> --- 03d6db1fb3a70605ef249c632c04e542457f0808/gittrack.sh
> +++ uncommitted/gittrack.sh
> @@ -51,6 +51,7 @@
> 
>         read-tree $(tree-id "$name")
>         gitdiff.sh local "$name" | gitapply.sh
> +       update-cache --refresh
> 
>  else
>         [ "$tracking" ] || \
> @@ -61,6 +62,7 @@
>         if [ -s ".git/HEAD.local" ]; then
>                 gitdiff.sh "$tracking" local | gitapply.sh
>                 read-tree $(tree-id local)
> +               update-cache --refresh
> 
>                 head=$(cat .git/HEAD)
>                 branchhead=$(cat .git/heads/$tracking)

The patch looks familiar, but not right. ;-)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
