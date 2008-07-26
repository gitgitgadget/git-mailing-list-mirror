From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC/PATCH] merge-base: teach "git merge-base" to accept more
 than 2 arguments
Date: Sat, 26 Jul 2008 06:25:50 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807260624210.26810@eeepc-johanness>
References: <20080726055920.3a2fc8e7.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Miklos Vajna <vmiklos@frugalware.org>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Sat Jul 26 06:25:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMbLp-0003ww-OZ
	for gcvg-git-2@gmane.org; Sat, 26 Jul 2008 06:25:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751003AbYGZEYu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jul 2008 00:24:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750973AbYGZEYt
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Jul 2008 00:24:49 -0400
Received: from mail.gmx.net ([213.165.64.20]:39461 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750956AbYGZEYt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jul 2008 00:24:49 -0400
Received: (qmail invoked by alias); 26 Jul 2008 04:24:47 -0000
Received: from 88-107-142-10.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.142.10]
  by mail.gmx.net (mp039) with SMTP; 26 Jul 2008 06:24:47 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18O3ppoekkO1r7WpOwwMbi0BOnrXDW3VdRYmh96qs
	LEXqFFrsrT+Fw8
X-X-Sender: user@eeepc-johanness
In-Reply-To: <20080726055920.3a2fc8e7.chriscool@tuxfamily.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90169>

Hi,

On Sat, 26 Jul 2008, Christian Couder wrote:

> 	I suspect this patch may be usefull to simplify my
> 	"bisect: add merge bases check" series and perhaps
> 	also generally usefull.

s/usefull/useful/

> diff --git a/builtin-merge-base.c b/builtin-merge-base.c
> index 1cb2925..9c41849 100644
> --- a/builtin-merge-base.c
> +++ b/builtin-merge-base.c
> @@ -2,9 +2,14 @@
>  #include "cache.h"
>  #include "commit.h"
>  
> -static int show_merge_base(struct commit *rev1, struct commit *rev2, int show_all)
> +static struct commit *rev1, **prev2;
> +static size_t prev2_nr, prev2_alloc;
> +
> +
> +static int show_merge_base(int show_all)
>  {

Changing the arguments to be static variables?

NACK!

Ciao,
Dscho
