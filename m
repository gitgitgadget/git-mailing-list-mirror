From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-fetch: Don't trigger a bus error when given the
 refspec "tag"
Date: Sat, 5 Apr 2008 19:33:22 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0804051931480.12583@eeepc-johanness>
References: <1207420133-23631-1-git-send-email-kevin@sb.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Sat Apr 05 20:34:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JiDDR-0001d6-77
	for gcvg-git-2@gmane.org; Sat, 05 Apr 2008 20:34:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753200AbYDESda (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Apr 2008 14:33:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752871AbYDESda
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Apr 2008 14:33:30 -0400
Received: from mail.gmx.net ([213.165.64.20]:34790 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753109AbYDESd3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Apr 2008 14:33:29 -0400
Received: (qmail invoked by alias); 05 Apr 2008 18:33:27 -0000
Received: from host86-165-92-90.range86-165.btcentralplus.com (EHLO eeepc-johanness.home) [86.165.92.90]
  by mail.gmx.net (mp007) with SMTP; 05 Apr 2008 20:33:27 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18vgKdtgoMvqAg00bW8Py+wgZ0ea781QmsjX6Ifte
	uiGMDv3vdwNGH5
X-X-Sender: user@eeepc-johanness
In-Reply-To: <1207420133-23631-1-git-send-email-kevin@sb.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78858>

Hi,

On Sat, 5 Apr 2008, Kevin Ballard wrote:

> diff --git a/builtin-fetch.c b/builtin-fetch.c
> index a11548c..5841b3e 100644
> --- a/builtin-fetch.c
> +++ b/builtin-fetch.c
> @@ -637,6 +637,8 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
>  			if (!strcmp(argv[i], "tag")) {
>  				char *ref;
>  				i++;
> +				if (i >= argc)
> +					die("You need to specify a tag name.");

Would it not be better to check in the if() above?  IOW

			if (i + 1 < argc && !strcmp(argv[i], "tag")) {

Hmm?

Ciao,
Dscho
