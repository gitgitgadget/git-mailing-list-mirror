From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] git-daemon: timeout, eliminate double DWIM
Date: Thu, 20 Oct 2005 02:28:45 +0200
Message-ID: <20051020002845.GT30889@pasky.or.cz>
References: <4356966A.8010401@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Oct 20 02:30:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ESOIe-0002OU-0R
	for gcvg-git@gmane.org; Thu, 20 Oct 2005 02:28:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751662AbVJTA2s (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 19 Oct 2005 20:28:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751663AbVJTA2s
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Oct 2005 20:28:48 -0400
Received: from w241.dkm.cz ([62.24.88.241]:59026 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751661AbVJTA2r (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Oct 2005 20:28:47 -0400
Received: (qmail 22622 invoked by uid 2001); 20 Oct 2005 02:28:45 +0200
To: "H. Peter Anvin" <hpa@zytor.com>
Content-Disposition: inline
In-Reply-To: <4356966A.8010401@zytor.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10329>

Dear diary, on Wed, Oct 19, 2005 at 08:54:34PM CEST, I got a letter
where "H. Peter Anvin" <hpa@zytor.com> told me that...
> diff --git a/daemon.c b/daemon.c
> --- a/daemon.c
> +++ b/daemon.c
> @@ -13,7 +13,9 @@
>  static int log_syslog;
>  static int verbose;
>  
> -static const char daemon_usage[] = "git-daemon [--verbose] [--syslog] [--inetd | --port=n] [--export-all] [directory...]";
> +static const char daemon_usage[] =
> +"git-daemon [--verbose] [--syslog] [--inetd | --port=n] [--export-all]\n"
> +"           [--timeout=n] [--init-timeout=n] [directory...]";
>  
>  /* List of acceptable pathname prefixes */
>  static char **ok_paths = NULL;

You didn't update Documentation/git-daemon.txt.

> diff --git a/upload-pack.c b/upload-pack.c
> --- a/upload-pack.c
> +++ b/upload-pack.c
> @@ -4,13 +4,19 @@
>  #include "tag.h"
>  #include "object.h"
>  
> -static const char upload_pack_usage[] = "git-upload-pack <dir>";
> +static const char upload_pack_usage[] = "git-upload-pack [--strict] [--timeout=nn] <dir>";

Ditto.


After being confronted with incomplete documentation again just minutes
ago (will send patch soon), I think I'm going to start to be annoying
and watch patches for this issue specifically. ;-)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
