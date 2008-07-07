From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: git-clone --quiet broken?
Date: Sun, 6 Jul 2008 21:40:50 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0807062131100.19665@iabervon.org>
References: <20080705211616.GA3874@codemonkey.org.uk> <7vmykvrfta.fsf@gitster.siamese.dyndns.org> <20080706225649.GD17659@steel.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Dave Jones <davej@codemonkey.org.uk>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 07 03:41:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFfji-0005vU-57
	for gcvg-git-2@gmane.org; Mon, 07 Jul 2008 03:41:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752533AbYGGBkx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jul 2008 21:40:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753081AbYGGBkw
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Jul 2008 21:40:52 -0400
Received: from iabervon.org ([66.92.72.58]:45122 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752205AbYGGBkw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jul 2008 21:40:52 -0400
Received: (qmail 14455 invoked by uid 1000); 7 Jul 2008 01:40:50 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 7 Jul 2008 01:40:50 -0000
In-Reply-To: <20080706225649.GD17659@steel.home>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87571>

On Mon, 7 Jul 2008, Alex Riesen wrote:

> While at it, could we please have the first "Initialize" message
> removed?
> 
>     Initialize git/.git
>     Initialized empty Git repository in /home/davej/git-trees/git/.git/
> 
> The default output looks redundant (that of init_db too, but the full
> path can be useful sometimes). Something like this, perhaps:
> 
> diff --git a/builtin-clone.c b/builtin-clone.c
> index 643c7d4..4a0f1ab 100644
> --- a/builtin-clone.c
> +++ b/builtin-clone.c
> @@ -421,7 +421,6 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>  		die("could not create leading directories of '%s'", git_dir);
>  	set_git_dir(make_absolute_path(git_dir));
>  
> -	fprintf(stderr, "Initialize %s\n", git_dir);
>  	init_db(option_template, option_quiet ? INIT_DB_QUIET : 0);
>  
>  	/*

Yeah, that's clearly left-over debugging, and I think that's the only one 
left from this conversion, anyway.

Acked-by: Daniel Barkalow <barkalow@iabervon.org>
