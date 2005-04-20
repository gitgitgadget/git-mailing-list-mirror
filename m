From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [PATCH] gittrack.sh accepts invalid branch names
Date: Thu, 21 Apr 2005 01:21:10 +0200
Message-ID: <20050420232110.GA12962@pasky.ji.cz>
References: <1114026510.15186.15.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 21 01:17:11 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOORI-0005of-Dn
	for gcvg-git@gmane.org; Thu, 21 Apr 2005 01:17:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261834AbVDTXVS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Apr 2005 19:21:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261837AbVDTXVS
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Apr 2005 19:21:18 -0400
Received: from w241.dkm.cz ([62.24.88.241]:51680 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261834AbVDTXVP (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Apr 2005 19:21:15 -0400
Received: (qmail 13283 invoked by uid 2001); 20 Apr 2005 23:21:10 -0000
To: Pavel Roskin <proski@gnu.org>
Content-Disposition: inline
In-Reply-To: <1114026510.15186.15.camel@dv>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Wed, Apr 20, 2005 at 09:48:30PM CEST, I got a letter
where Pavel Roskin <proski@gnu.org> told me that...
> --- a/gittrack.sh
> +++ b/gittrack.sh
> @@ -35,7 +35,7 @@ die () {
>  mkdir -p .git/heads
>  
>  if [ "$name" ]; then
> -	grep -q $(echo -e "^$name\t" | sed 's/\./\\./g') .git/remotes || \
> +	sed -ne "/^$name\t/p" .git/remotes | grep -q . || \
>  		[ -s ".git/heads/$name" ] || \
>  		die "unknown branch \"$name\""

This fixes the acceptance, but not the choice.

What does the grep -q . exactly do? Just sets error code based on
whether the sed output is non-empty? What about [] instead?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
