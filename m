From: Eric Wong <normalperson@yhbt.net>
Subject: Re: t9107-git-svn-migrate.sh fails
Date: Sat, 26 May 2007 02:35:34 -0700
Message-ID: <20070526093534.GB12639@muzzle>
References: <Pine.LNX.4.64.0705242315550.4648@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat May 26 11:35:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HrsgY-0007Ia-Vp
	for gcvg-git@gmane.org; Sat, 26 May 2007 11:35:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753955AbXEZJfg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 26 May 2007 05:35:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753515AbXEZJfg
	(ORCPT <rfc822;git-outgoing>); Sat, 26 May 2007 05:35:36 -0400
Received: from hand.yhbt.net ([66.150.188.102]:60991 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753955AbXEZJff (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 May 2007 05:35:35 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 3F1582DC032;
	Sat, 26 May 2007 02:35:34 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Sat, 26 May 2007 02:35:34 -0700
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0705242315550.4648@racer.site>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48465>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,
> 
> I recently wanted to use git-svn, and installed the svn perl bindings. 
> Since then, t9107 is failing:
> 
> -- snip --
> [...]
> Rebuilding .git/svn/git-svn/.rev_db.f944dda1-3e31-0410-9475-8f268450faf6 
> ...
> r1 = b9b82a419abdbb54f51a41bc8a3118b28c791ac1
> Done rebuilding 
> .git/svn/git-svn/.rev_db.f944dda1-3e31-0410-9475-8f268450faf6
> diff --git 
> a/home/gene099/my/git/t/trash/.git/svn/trunk/.rev_db.f944dda1-3e31-0410-9475-8f268450faf6 
> b/home/gene099/my/git/t/trash/.git/svn/trunk/.rev_db
> index d3f1b6e..01d8afd 100644
> --- 
> a/home/gene099/my/git/t/trash/.git/svn/trunk/.rev_db.f944dda1-3e31-0410-9475-8f268450faf6
> +++ b/home/gene099/my/git/t/trash/.git/svn/trunk/.rev_db
> @@ -1,2 +1 @@
> -0000000000000000000000000000000000000000
> -6aa651a66730888e854a8de54199d62ffa402739
> +.rev_db.f944dda1-3e31-0410-9475-8f268450faf6
> \ No newline at end of file
> * FAIL 7: .rev_db auto-converted to .rev_db.UUID
> 
>                 git-svn fetch -i trunk &&
> 		[...]
> -- snap --
> 
> Usually I try to fix things like this myself, but I really have to get 
> some dinner now. Besides, other people than me seem to be way more clever 
> with perl code.

.git/svn/trunk/.rev_db should be
a symlink to
.git/svn/trunk/.rev_db.f944dda1-3e31-0410-9475-8f268450faf6

I keep .rev_db around as a symlink for backwards compatibility in case
the user wants to downgrade.

I'm running cmp(1) to compare the file and symlink.  Are you running
diff2[1] replacements in your tree and it's not understanding symlinks?

> Anybody knows how to fix this?

Works for me(TM).

[1] - I think that's what you called it.  I have had trouble keeping
up-to-date with git things lately.

-- 
Eric Wong
