From: Gerrit Pape <pape@smarden.org>
Subject: Re: [PATCH 2/2] git-completion.bash: prevent 'git help' from searching for git repository
Date: Fri, 4 Sep 2009 11:09:36 +0000
Message-ID: <20090904110936.6663.qmail@046e1bfbf7e41d.315fe32.mid.smarden.org>
References: <20090902095843.28914.qmail@3cd9dde586d86b.315fe32.mid.smarden.org> <fabb9a1e0909020447p212594cake8c6fe3a43b667ec@mail.gmail.com> <20090904092929.23208.qmail@00cf3567a0e8b4.315fe32.mid.smarden.org> <alpine.DEB.1.00.0909041217370.4605@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Sep 04 13:09:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MjWfq-0007qj-V9
	for gcvg-git-2@lo.gmane.org; Fri, 04 Sep 2009 13:09:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755695AbZIDLJi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Sep 2009 07:09:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754962AbZIDLJh
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Sep 2009 07:09:37 -0400
Received: from a.ns.smarden.org ([212.42.242.37]:1825 "HELO a.mx.smarden.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753432AbZIDLJh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Sep 2009 07:09:37 -0400
Received: (qmail 6664 invoked by uid 1000); 4 Sep 2009 11:09:36 -0000
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0909041217370.4605@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127721>

On Fri, Sep 04, 2009 at 12:22:36PM +0200, Johannes Schindelin wrote:
> -- snipsnap --
> [PATCH] git help -a: do not look for a repository

Perfect, thanks.

Acked-by: Gerrit Pape <pape@smarden.org>

> Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> 
> ---
> 
>  builtin-help.c |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/builtin-help.c b/builtin-help.c
> index e1eba77..719aa23 100644
> --- a/builtin-help.c
> +++ b/builtin-help.c
> @@ -416,9 +416,6 @@ int cmd_help(int argc, const char **argv, const char *prefix)
>  	const char *alias;
>  	load_command_list("git-", &main_cmds, &other_cmds);
>  
> -	setup_git_directory_gently(&nongit);
> -	git_config(git_help_config, NULL);
> -
>  	argc = parse_options(argc, argv, prefix, builtin_help_options,
>  			builtin_help_usage, 0);
>  
> @@ -429,6 +426,9 @@ int cmd_help(int argc, const char **argv, const char *prefix)
>  		return 0;
>  	}
>  
> +	setup_git_directory_gently(&nongit);
> +	git_config(git_help_config, NULL);
> +
>  	if (!argv[0]) {
>  		printf("usage: %s\n\n", git_usage_string);
>  		list_common_cmds_help();
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
