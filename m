From: Matt Porter <mporter@kernel.crashing.org>
Subject: Re: [PATCH] Add exclude file support to cg-status
Date: Mon, 2 May 2005 19:33:43 -0700
Message-ID: <20050502193343.A25462@cox.net>
References: <20050502171042.A24299@cox.net> <7vd5s9nmio.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@ucw.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 03 04:30:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DSnAe-0004A2-FZ
	for gcvg-git@gmane.org; Tue, 03 May 2005 04:30:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261301AbVECCgB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 May 2005 22:36:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261311AbVECCgB
	(ORCPT <rfc822;git-outgoing>); Mon, 2 May 2005 22:36:01 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:31154 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S261301AbVECCfx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 May 2005 22:35:53 -0400
Received: from liberty.homelinux.org ([68.2.41.86]) by fed1rmmtao12.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050503023550.MPHJ550.fed1rmmtao12.cox.net@liberty.homelinux.org>;
          Mon, 2 May 2005 22:35:50 -0400
Received: (from mmporter@localhost)
	by liberty.homelinux.org (8.9.3/8.9.3/Debian 8.9.3-21) id TAA25552;
	Mon, 2 May 2005 19:33:43 -0700
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <7vd5s9nmio.fsf@assigned-by-dhcp.cox.net>; from junkio@cox.net on Mon, May 02, 2005 at 06:09:19PM -0700
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Mon, May 02, 2005 at 06:09:19PM -0700, Junio C Hamano wrote:
> >>>>> "MP" == Matt Porter <mporter@kernel.crashing.org> writes:
> 
> MP> Adds a trivial per-repository exclude file implementation for
> MP> cg-status on top of the new git-ls-files option.
> 
>  
> MP> +EXCLUDEFILE=.git/exclude
> 
> Good intentions, but shouldn't the file be .git/info/exclude
> (i.e. under .git/info)?

My reasoning for not doing something like this was that there is
only ever one exclude file.  In other instances of cogito specific
data in the .git directory, there is a subdir named for the class
of data being stored there (i.e. branches, refs).  In this case,
it didn't seem necessary.  On the other hand, this made me
wonder whether there should just be a .git/cginfo subdir where
exclude, branches, refs, etc. all live under since they are
cogito specfic functionality. Something like:

.git/cginfo/

	    exclude
	    branches/
	    refs/

and so on...

-Matt
