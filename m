From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] execv_git_cmd(): also try PATH if everything else fails.
Date: Sun, 21 Oct 2007 23:02:46 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710212301490.25221@racer.site>
References: <1192867937.v2.fusewebmail-240137@f> <20071020205721.GA16291@srparish.net>
 <Pine.LNX.4.64.0710202258440.25221@racer.site> <20071021182150.GG16291@srparish.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Scott Parish <sRp@srparish.net>
X-From: git-owner@vger.kernel.org Mon Oct 22 00:03:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IjitF-0002wc-FV
	for gcvg-git-2@gmane.org; Mon, 22 Oct 2007 00:03:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750869AbXJUWDK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Oct 2007 18:03:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750865AbXJUWDJ
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Oct 2007 18:03:09 -0400
Received: from mail.gmx.net ([213.165.64.20]:33248 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750757AbXJUWDG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Oct 2007 18:03:06 -0400
Received: (qmail invoked by alias); 21 Oct 2007 22:03:04 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp010) with SMTP; 22 Oct 2007 00:03:04 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18jGs5LV28jPoP7P80/LlnBk2rZVeiAVMCOsFu5EU
	6XcC4+42xXCMZq
X-X-Sender: gene099@racer.site
In-Reply-To: <20071021182150.GG16291@srparish.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61914>

Hi,

On Sun, 21 Oct 2007, Scott Parish wrote:

> diff --git a/exec_cmd.c b/exec_cmd.c
> index 9b74ed2..374ffc9 100644
> --- a/exec_cmd.c
> +++ b/exec_cmd.c
> @@ -99,8 +103,8 @@ int execv_git_cmd(const char **argv)
>  
>  		trace_argv_printf(argv, -1, "trace: exec:");
>  
> -		/* execve() can only ever return if it fails */
> -		execve(git_command, (char **)argv, environ);
> +		/* execvp() can only ever return if it fails */
> +		execvp(git_command, (char **)argv);

I'd rather have it conditional upon *exec_dir (see the brown paper bag 
patch I just sent).

Ciao,
Dscho
