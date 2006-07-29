From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] pager: config variable pager.color
Date: Sun, 30 Jul 2006 01:15:31 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0607300112340.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <E1G6xHb-0008Rw-G2@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 30 01:15:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G6y1w-0007hu-Rs
	for gcvg-git@gmane.org; Sun, 30 Jul 2006 01:15:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750735AbWG2XPe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 29 Jul 2006 19:15:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750750AbWG2XPe
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Jul 2006 19:15:34 -0400
Received: from mail.gmx.de ([213.165.64.21]:14287 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750735AbWG2XPd (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 29 Jul 2006 19:15:33 -0400
Received: (qmail invoked by alias); 29 Jul 2006 23:15:32 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp043) with SMTP; 30 Jul 2006 01:15:32 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Matthias Lederhofer <matled@gmx.net>
In-Reply-To: <E1G6xHb-0008Rw-G2@moooo.ath.cx>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24440>

Hi,

On Sun, 30 Jul 2006, Matthias Lederhofer wrote:

> diff --git a/builtin-log.c b/builtin-log.c
> index 82c69d1..7fdefec 100644
> --- a/builtin-log.c
> +++ b/builtin-log.c
> @@ -34,7 +34,6 @@ static int cmd_log_walk(struct rev_info 
>  	struct commit *commit;
>  
>  	prepare_revision_walk(rev);
> -	setup_pager();
>  	while ((commit = get_revision(rev)) != NULL) {
>  		log_tree_commit(rev, commit);
>  		free(commit->buffer);
> @@ -49,6 +48,7 @@ int cmd_whatchanged(int argc, const char
>  {
>  	struct rev_info rev;
>  
> +	setup_pager();
>  	git_config(git_diff_ui_config);
>  	init_revisions(&rev, prefix);
>  	rev.diff = 1;
> @@ -64,6 +64,7 @@ int cmd_show(int argc, const char **argv
>  {
>  	struct rev_info rev;
>  
> +	setup_pager();
>  	git_config(git_diff_ui_config);
>  	init_revisions(&rev, prefix);
>  	rev.diff = 1;
> @@ -81,6 +82,7 @@ int cmd_log(int argc, const char **argv,
>  {
>  	struct rev_info rev;
>  
> +	setup_pager();
>  	git_config(git_diff_ui_config);
>  	init_revisions(&rev, prefix);
>  	rev.always_show_header = 1;

Why? The three users of cmd_log_walk() need to call setup_pager() 
explicitely, when cmd_log_walk() can do it for them?

Oh, and I do not really understand why you would enable color _at all_ if 
you want to disable it when paging. Do you have many instances when you 
want a color diff which is short enough not to be paged?

Ciao,
Dscho
