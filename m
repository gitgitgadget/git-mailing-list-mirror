From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-config: handle --file option with relative pathname
 properly
Date: Tue, 9 Oct 2007 14:14:33 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710091413500.4174@racer.site>
References: <20071009124932.1184.qmail@395d4a80f3eafd.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Gerrit Pape <pape@smarden.org>
X-From: git-owner@vger.kernel.org Tue Oct 09 15:15:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IfEvM-0008OI-QH
	for gcvg-git-2@gmane.org; Tue, 09 Oct 2007 15:15:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750722AbXJINOv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Oct 2007 09:14:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750718AbXJINOv
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Oct 2007 09:14:51 -0400
Received: from mail.gmx.net ([213.165.64.20]:35022 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750707AbXJINOv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Oct 2007 09:14:51 -0400
Received: (qmail invoked by alias); 09 Oct 2007 13:14:49 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp048) with SMTP; 09 Oct 2007 15:14:49 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19lK8wP/Gdlux0siuAuqIqHznsuaHTSIIVQfdEEvA
	TcIkt2whtOXIqo
X-X-Sender: gene099@racer.site
In-Reply-To: <20071009124932.1184.qmail@395d4a80f3eafd.315fe32.mid.smarden.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60406>

Hi,

On Tue, 9 Oct 2007, Gerrit Pape wrote:

> @@ -189,7 +189,11 @@ int cmd_config(int argc, const char **argv, const char *prefix)
>  		else if (!strcmp(argv[1], "--file") || !strcmp(argv[1], "-f")) {
>  			if (argc < 3)
>  				usage(git_config_set_usage);
> -			setenv(CONFIG_ENVIRONMENT, argv[2], 1);
> +			if (argv[2][0] == '/')

Please use is_absolute_path() instead.

Ciao,
Dscho
