From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Check for -amend as a common wrong usage of --amend.
Date: Thu, 24 Jan 2008 18:20:00 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0801241818441.5731@racer.site>
References: <1201198439-3516-1-git-send-email-pascal@obry.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com,
	Pascal Obry <pascal@obry.net>
To: Pascal Obry <pascal.obry@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 24 19:20:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JI6gp-00083e-AX
	for gcvg-git-2@gmane.org; Thu, 24 Jan 2008 19:20:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753844AbYAXSUM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jan 2008 13:20:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753886AbYAXSUL
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jan 2008 13:20:11 -0500
Received: from mail.gmx.net ([213.165.64.20]:57551 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753807AbYAXSUK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jan 2008 13:20:10 -0500
Received: (qmail invoked by alias); 24 Jan 2008 18:20:08 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp023) with SMTP; 24 Jan 2008 19:20:08 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19S650Jl65Sa1HFSdNuJKdEjW7Jw4x66oOvUqKD6I
	MPZURaw3fNEZ7W
X-X-Sender: gene099@racer.site
In-Reply-To: <1201198439-3516-1-git-send-email-pascal@obry.net>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71643>

Hi,

On Thu, 24 Jan 2008, Pascal Obry wrote:

> diff --git a/parse-options.c b/parse-options.c
> index 7a08a0c..248515d 100644
> --- a/parse-options.c
> +++ b/parse-options.c
> @@ -233,6 +233,13 @@ int parse_options(int argc, const char **argv, const struct option *options,
>  			continue;
>  		}
>  
> +		if (!strcmp(arg + 1, "amend")) {
> +		        error("-amend looks suspicious, don't you meant --amend\n");
> +		        args.argc--;
> +		        args.argv++;
> +		        break;
> +		}
> +
>  		if (arg[1] != '-') {
>  			args.opt = arg + 1;
>  			do {

That is ugly.  In a source file which is by no means specific to 
git-commit, you cannot possibly mean to check for "amend".

I don't like it,
Dscho
