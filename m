From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] log --pretty: do not accept bogus "--prettyshort"
Date: Mon, 26 May 2008 11:05:51 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0805261105090.30431@racer>
References: <7vy75xeoql.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 26 12:07:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K0Zbe-0003eX-6E
	for gcvg-git-2@gmane.org; Mon, 26 May 2008 12:07:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751627AbYEZKFs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 May 2008 06:05:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752106AbYEZKFs
	(ORCPT <rfc822;git-outgoing>); Mon, 26 May 2008 06:05:48 -0400
Received: from mail.gmx.net ([213.165.64.20]:35077 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751542AbYEZKFs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 May 2008 06:05:48 -0400
Received: (qmail invoked by alias); 26 May 2008 10:05:45 -0000
Received: from R4980.r.pppool.de (EHLO racer.local) [89.54.73.128]
  by mail.gmx.net (mp023) with SMTP; 26 May 2008 12:05:45 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/qYCEAbKDqUFvDMtkBhn9NL/wtDyK8EojF3YCCr6
	6K4ny3baWtI+0T
X-X-Sender: gene099@racer
In-Reply-To: <7vy75xeoql.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82912>

Hi,

On Sun, 25 May 2008, Junio C Hamano wrote:

> diff --git a/revision.c b/revision.c
> index ac057e1..fc66755 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -1197,11 +1197,16 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, const ch
>  				revs->verbose_header = 1;
>  				continue;
>  			}
> -			if (!prefixcmp(arg, "--pretty")) {
> +			if (!strcmp(arg, "--pretty")) {
>  				revs->verbose_header = 1;
>  				get_commit_format(arg+8, revs);

Does "args+8" really make sense, still?  Okay, it is the same as "", but 
the latter would not make me go "Hum?!".

Ciao,
Dscho
