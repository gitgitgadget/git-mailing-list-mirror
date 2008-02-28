From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 13/40] Windows: Fix PRIuMAX definition.
Date: Thu, 28 Feb 2008 12:21:35 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802281220470.22527@racer.site>
References: <1204138503-6126-1-git-send-email-johannes.sixt@telecom.at> <1204138503-6126-14-git-send-email-johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Thu Feb 28 13:22:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUhmi-0003mp-6r
	for gcvg-git-2@gmane.org; Thu, 28 Feb 2008 13:22:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752216AbYB1MWL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Feb 2008 07:22:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753181AbYB1MWK
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Feb 2008 07:22:10 -0500
Received: from mail.gmx.net ([213.165.64.20]:47338 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752237AbYB1MWJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Feb 2008 07:22:09 -0500
Received: (qmail invoked by alias); 28 Feb 2008 12:22:05 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp021) with SMTP; 28 Feb 2008 13:22:05 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+lIWge8JOlifVm4jI4FusXfBjF5fOe/vosNU4jN7
	vrWQWgc9m9p6Lc
X-X-Sender: gene099@racer.site
In-Reply-To: <1204138503-6126-14-git-send-email-johannes.sixt@telecom.at>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75392>

Hi,

On Wed, 27 Feb 2008, Johannes Sixt wrote:

> diff --git a/git-compat-util.h b/git-compat-util.h
> index 3b57464..c576f5a 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -103,7 +103,11 @@
>  #endif
>  
>  #ifndef PRIuMAX
> +#ifndef __MINGW32__
>  #define PRIuMAX "llu"
> +#else
> +#define PRIuMAX "I64u"
> +#endif
>  #endif

Would this not be better as a patch to Makefile, extending the 
COMPAT_CFLAGS with -DPRIuMAX=\"I64u\"?

Ciao,
Dscho
