From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Documentation/git-diff: remove -r from --name-status
 example
Date: Sun, 29 Jul 2007 12:14:49 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707291214060.14781@racer.site>
References: <20070729002427.GA1566@coredump.intra.peff.net>
 <alpine.LFD.0.999.0707281905050.3442@woody.linux-foundation.org>
 <20070729041159.GA5544@coredump.intra.peff.net>
 <alpine.LFD.0.999.0707282119010.3442@woody.linux-foundation.org>
 <7vbqdvolww.fsf@assigned-by-dhcp.cox.net> <7vwswjmu08.fsf@assigned-by-dhcp.cox.net>
 <20070729094955.GA14915@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Jul 29 13:15:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IF6kG-0007Dy-Ml
	for gcvg-git@gmane.org; Sun, 29 Jul 2007 13:15:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761390AbXG2LPJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Jul 2007 07:15:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761392AbXG2LPI
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jul 2007 07:15:08 -0400
Received: from mail.gmx.net ([213.165.64.20]:57685 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1761159AbXG2LPH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jul 2007 07:15:07 -0400
Received: (qmail invoked by alias); 29 Jul 2007 11:15:05 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp037) with SMTP; 29 Jul 2007 13:15:05 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX194Whx7rPR4vgz8WeMEBGRPKZxAN+7pFHJRpyUiaG
	3al/3BMaMObsP3
X-X-Sender: gene099@racer.site
In-Reply-To: <20070729094955.GA14915@coredump.intra.peff.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54103>

Hi,

On Sun, 29 Jul 2007, Jeff King wrote:

> -- >8 --
> git-diff: turn on recursion by default
> 
> The tree recursion behavior of git-diff may appear
> inconsistent to the user because it depends on the format of
> the patch as well as whether one is diffing between trees or
> against the index.
> 
> Since git-diff is a porcelain wrapper for low-level diff
> commands, it makes sense for its behavior to be consistent
> no matter what is being diffed.  This patch turns on
> recursion in all cases.
> 
> diff --git a/builtin-diff.c b/builtin-diff.c
> index 7f367b6..b48121e 100644
> --- a/builtin-diff.c
> +++ b/builtin-diff.c
> @@ -233,6 +233,7 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
>  			die("diff_setup_done failed");
>  	}
>  	rev.diffopt.allow_external = 1;
> +	rev.diffopt.recursive = 1;

How about

	if (!rev.diffopt.quiet)
		rev.diffopt.recursive = 1;

instead?

Ciao,
Dscho
