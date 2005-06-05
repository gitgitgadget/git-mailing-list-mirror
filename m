From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [COGITO PATCH] Small, simple and obvious cleanups (are they wanted at this stage?)
Date: Sun, 5 Jun 2005 22:25:27 +0200
Message-ID: <20050605202527.GO17462@pasky.ji.cz>
References: <429E0B08.5040603@gkhs.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 05 22:23:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Df1dY-0005Fj-0H
	for gcvg-git@gmane.org; Sun, 05 Jun 2005 22:22:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261507AbVFEUZj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Jun 2005 16:25:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261608AbVFEUZj
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Jun 2005 16:25:39 -0400
Received: from w241.dkm.cz ([62.24.88.241]:16289 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261507AbVFEUZa (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Jun 2005 16:25:30 -0400
Received: (qmail 24764 invoked by uid 2001); 5 Jun 2005 20:25:27 -0000
To: "C. Cooke" <ccooke@gkhs.net>
Content-Disposition: inline
In-Reply-To: <429E0B08.5040603@gkhs.net>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Wed, Jun 01, 2005 at 09:22:48PM CEST, I got a letter
where "C. Cooke" <ccooke@gkhs.net> told me that...
> This is a simple example - giving a nice error if you're in the wrong
> directory.
> 
> Is this sort of patch wanted? If so, I'm sure I can spare the time to
> look into some polishing.

Of course they are wanted. Thanks, applied.

> ------------------------------
> Add some sanity checking - does $_git exist, and is it writable.
> 
> ---
> commit 06afdeefff9fe02cd2a67f223e687646cacf736f
> tree cebc55541b89b5370335fc172814feb48456dc85
> parent 20e473c9afd8b5d2d549b0e7881473600beb9c37
> author C. Cooke <ccooke@slab.earth.gkhs.net> Wed, 01 Jun 2005 20:03:46 +0100
> committer C. Cooke <ccooke@slab.earth.gkhs.net> Wed, 01 Jun 2005
> 20:03:46 +0100
> 
>  cg-Xnormid |    9 +++++++++
>  1 files changed, 9 insertions(+), 0 deletions(-)
> 
> diff --git a/cg-Xnormid b/cg-Xnormid
> --- a/cg-Xnormid
> +++ b/cg-Xnormid
> @@ -16,6 +16,15 @@
> 
>  id="$1"
> 
> +# A little sanity checking.
> +if [ ! -d "$_git" ]; then
> +       echo "There is no Git repository here ($_git not found)" >&2
> +       exit 1
> +elif [ ! -r "$_git" ] || [ ! -x "$_git" ]; then
> +       echo "You do not have permission to access this git repository" >&2
> +       exit 1
> +fi
> +
>  if [ ! "$id" ] || [ "$id" = "this" ] || [ "$id" = "HEAD" ]; then
>         read id < "$_git/HEAD"

I removed the -r check. What is it good for?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
