From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [PATCH] Colorized git log
Date: Fri, 22 Apr 2005 02:54:52 +0200
Message-ID: <20050422005452.GZ7443@pasky.ji.cz>
References: <3536.10.10.10.24.1114117965.squirrel@linux1> <20050421224229.GR7443@pasky.ji.cz> <f0796bb7050421174647943f0c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT Mailing Lists <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Apr 22 02:54:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOmQm-0004la-Mn
	for gcvg-git@gmane.org; Fri, 22 Apr 2005 02:54:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261900AbVDVA56 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Apr 2005 20:57:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261899AbVDVA55
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Apr 2005 20:57:57 -0400
Received: from w241.dkm.cz ([62.24.88.241]:56716 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261910AbVDVAyz (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Apr 2005 20:54:55 -0400
Received: (qmail 23865 invoked by uid 2001); 22 Apr 2005 00:54:52 -0000
To: Daniel Serpell <daniel.serpell@gmail.com>
Content-Disposition: inline
In-Reply-To: <f0796bb7050421174647943f0c@mail.gmail.com>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Fri, Apr 22, 2005 at 02:46:19AM CEST, I got a letter
where Daniel Serpell <daniel.serpell@gmail.com> told me that...
> Hi!

Hi,

> On 4/21/05, Petr Baudis <pasky@ucw.cz> wrote:
> > 
> > I made git log colorized if you pass it -c in current git-pasky. 
> > 
> 
> This has two problems, solved in two patches:

could you please sign them off?

> * A space is added in front of  header lines when you use color.

Oh, good catch, thanks.

> * It does not  work in my (Debian) xterm. This is because here 
>   "setterm" only works with TERM=linux.

Duh. And they say "Where possible terminfo is consulted to find the
string to use." in their manual page. :/

> gitlog.sh: 6d24d857fb6c2f7e810954adaca1990599906f07
> --- a/gitlog.sh
> +++ b/gitlog.sh
> @@ -11,11 +11,11 @@
>  
>  if [ "$1" = "-c" ]; then
>  	shift
> -	colheader=$(setterm -foreground green)
> -	colauthor=$(setterm -foreground cyan)
> -	colcommitter=$(setterm -foreground magenta)
> -	colsignoff=$(setterm -foreground yellow)
> -	coldefault=$(setterm -foreground default)
> +	colheader="$(tput setaf 2)"
> +	colauthor="$(tput setaf 6)"
> +	colcommitter="$(tput setaf 5)"
> +	colsignoff="$(tput setaf 3)"
> +	coldefault="$(tput op)"
>  else
>  	colheader=
>  	colauthor=

Please at least stick the colors in comments after the assignment.
Not everyone knows ANSI color codes off-hand (the last thing I've
memorized were BIOS color codes in the distant DOS days).

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
