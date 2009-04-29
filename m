From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git config: error when editing a repo config and not
 being in one
Date: Thu, 30 Apr 2009 00:44:25 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0904300043030.10279@pacific.mpi-cbg.de>
References: <1241043939-29013-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Teemu Likonen <tlikonen@iki.fi>,
	Junio C Hamano <gitster@pobox.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 30 00:45:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LzIWo-0003Rc-Qo
	for gcvg-git-2@gmane.org; Thu, 30 Apr 2009 00:45:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763310AbZD2WoM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2009 18:44:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763308AbZD2WoK
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Apr 2009 18:44:10 -0400
Received: from mail.gmx.net ([213.165.64.20]:56257 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752884AbZD2WoI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2009 18:44:08 -0400
Received: (qmail invoked by alias); 29 Apr 2009 22:44:07 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp012) with SMTP; 30 Apr 2009 00:44:07 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+YLfclwmqYxXW+Xz76yHG3m1VWBQIyu9rCs7N4+G
	gu4gTFkR3aLPDc
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <1241043939-29013-1-git-send-email-felipe.contreras@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.53
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117971>

Hi,

On Thu, 30 Apr 2009, Felipe Contreras wrote:

> diff --git a/builtin-config.c b/builtin-config.c
> index d8da72c..6e936e1 100644
> --- a/builtin-config.c
> +++ b/builtin-config.c
> @@ -390,6 +390,8 @@ int cmd_config(int argc, const char **argv, const char *unused_prefix)
>  	}
>  	else if (actions == ACTION_EDIT) {
>  		check_argc(argc, 0, 0);
> +		if (!config_exclusive_filename && !is_inside_git_dir())
> +			die("not in a git directory");

Why not use the nongit variable?

Ciao,
Dscho
