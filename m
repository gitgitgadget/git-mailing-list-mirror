From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] Added --mirror-all to git-fetch.
Date: Wed, 20 Sep 2006 01:41:08 +0200
Message-ID: <20060919234108.GH8259@pasky.or.cz>
References: <20060919232851.GA12195@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 20 01:41:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GPpDH-0004Rh-3J
	for gcvg-git@gmane.org; Wed, 20 Sep 2006 01:41:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750751AbWISXlL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Sep 2006 19:41:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750811AbWISXlL
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Sep 2006 19:41:11 -0400
Received: from w241.dkm.cz ([62.24.88.241]:17636 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1750751AbWISXlK (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Sep 2006 19:41:10 -0400
Received: (qmail 31049 invoked by uid 2001); 20 Sep 2006 01:41:08 +0200
To: Shawn Pearce <spearce@spearce.org>
Content-Disposition: inline
In-Reply-To: <20060919232851.GA12195@spearce.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27315>

Dear diary, on Wed, Sep 20, 2006 at 01:28:51AM CEST, I got a letter
where Shawn Pearce <spearce@spearce.org> said that...
> Currently local refs are not deleted even if they do not exist in the
> remote repository.  This may be taken as either a feature or a bug.

  It's a bug for my purposes, but a minor one.

>  pasky was asking about this on #git.  So here it is.

  Thanks!

> @@ -216,12 +220,45 @@ case "$update_head_ok" in
>  	;;
>  esac
>  
> -# If --tags (and later --heads or --all) is specified, then we are
> -# not talking about defaults stored in Pull: line of remotes or
> +# If --tags or -mirror_all (and later --heads) is specified, then we
                  ^^ missing dash ;-)
> +# are not talking about defaults stored in Pull: line of remotes or
>  # branches file, and just fetch those and refspecs explicitly given.
>  # Otherwise we do what we always did.
>  
> -reflist=$(get_remote_refs_for_fetch "$@")
> +if test "$mirror_all"
> +then
> +	tags=0;  # tags are implied in all 

  This should be tags=;

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Snow falling on Perl. White noise covering line noise.
Hides all the bugs too. -- J. Putnam
