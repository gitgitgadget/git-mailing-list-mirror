From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] builtin-apply: Show a more descriptive error on failure
 when opening a patch
Date: Mon, 14 Apr 2008 15:03:45 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0804141502590.28504@racer>
References: <1208112991-21598-1-git-send-email-albertito@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Alberto Bertogli <albertito@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 14 16:09:54 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JlPIU-0004Tp-B5
	for gcvg-git-2@gmane.org; Mon, 14 Apr 2008 16:04:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755033AbYDNODx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Apr 2008 10:03:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754904AbYDNODx
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Apr 2008 10:03:53 -0400
Received: from mail.gmx.net ([213.165.64.20]:59983 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754419AbYDNODw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Apr 2008 10:03:52 -0400
Received: (qmail invoked by alias); 14 Apr 2008 14:03:50 -0000
Received: from unknown (EHLO racer.local) [138.251.11.74]
  by mail.gmx.net (mp029) with SMTP; 14 Apr 2008 16:03:50 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX187eT9iXXU7BeOS5iYH8vCuMjWzpaXVuvqrm8OASU
	sp1fj1zvurfnhR
X-X-Sender: gene099@racer
In-Reply-To: <1208112991-21598-1-git-send-email-albertito@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79503>

Hi,

On Sun, 13 Apr 2008, Alberto Bertogli wrote:

> diff --git a/builtin-apply.c b/builtin-apply.c
> index abe73a0..d80b231 100644
> --- a/builtin-apply.c
> +++ b/builtin-apply.c
> @@ -3120,8 +3120,11 @@ int cmd_apply(int argc, const char **argv, const char *unused_prefix)
>  			arg = prefix_filename(prefix, prefix_length, arg);
>  
>  		fd = open(arg, O_RDONLY);
> -		if (fd < 0)
> -			usage(apply_usage);
> +		if (fd < 0) {
> +			perror("Error opening patch");
> +			return 1;
> +		}

Would "return error("...: '%s'", arg);" not be much more appropriate and 
consistent with the resto of the source code?

Ciao,
Dscho
