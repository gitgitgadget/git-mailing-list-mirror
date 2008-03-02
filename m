From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Fix make_absolute_path() for parameters without a
 slash
Date: Sun, 2 Mar 2008 07:31:21 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0803020730170.22527@racer.site>
References: <alpine.LSU.1.00.0803020717060.22527@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Mar 02 08:32:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVigh-0001E6-HV
	for gcvg-git-2@gmane.org; Sun, 02 Mar 2008 08:32:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752016AbYCBHcM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Mar 2008 02:32:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751993AbYCBHcL
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Mar 2008 02:32:11 -0500
Received: from mail.gmx.net ([213.165.64.20]:53657 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751955AbYCBHcK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Mar 2008 02:32:10 -0500
Received: (qmail invoked by alias); 02 Mar 2008 07:32:08 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp021) with SMTP; 02 Mar 2008 08:32:08 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/G1VYcN3rG9RMRtCBEJnxzfU1z2s/mXja62Vffrj
	y2LR7dI6HeGeu4
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.LSU.1.00.0803020717060.22527@racer.site>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75739>

Hi,

On Sun, 2 Mar 2008, Johannes Schindelin wrote:

> diff --git a/path.c b/path.c
> index 4260952..bf3e469 100644
> --- a/path.c
> +++ b/path.c
> @@ -311,8 +311,10 @@ const char *make_absolute_path(const char *path)
>  			if (last_slash) {
>  				*last_slash = '\0';
>  				last_elem = xstrdup(last_slash + 1);
> -			} else
> +			} else {
> +				*buf = '\0';
>  				last_elem = xstrdup(buf);

Oh, my.  The *buf = '\0' must come _after the assignment to last_elem, of 
course.

Will stop posting patches for today, and fix tomorrow.

Ciao,
Dscho

