From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 03/12] xmerge.c: minimum readability fixups
Date: Sat, 30 Aug 2008 11:31:17 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0808301130250.24820@pacific.mpi-cbg.de.mpi-cbg.de>
References: <1220056963-2352-1-git-send-email-gitster@pobox.com> <1220056963-2352-2-git-send-email-gitster@pobox.com> <1220056963-2352-3-git-send-email-gitster@pobox.com> <1220056963-2352-4-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 30 11:27:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZMji-0004tZ-BS
	for gcvg-git-2@gmane.org; Sat, 30 Aug 2008 11:27:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752409AbYH3J0J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Aug 2008 05:26:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752887AbYH3J0I
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Aug 2008 05:26:08 -0400
Received: from mail.gmx.net ([213.165.64.20]:37003 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750911AbYH3J0H (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Aug 2008 05:26:07 -0400
Received: (qmail invoked by alias); 30 Aug 2008 09:26:05 -0000
Received: from pacific.mpi-cbg.de (EHLO [141.5.10.38]) [141.5.10.38]
  by mail.gmx.net (mp021) with SMTP; 30 Aug 2008 11:26:05 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18wt0xisA0wW5i3TYFYk6/Q1qP1/W4/ulrdeODv4T
	8ucvHKPlJ+U/xd
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <1220056963-2352-4-git-send-email-gitster@pobox.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.55
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94366>

Hi,

On Fri, 29 Aug 2008, Junio C Hamano wrote:

> diff --git a/xdiff/xmerge.c b/xdiff/xmerge.c
> index 29cdbea..7dcd405 100644
> --- a/xdiff/xmerge.c
> +++ b/xdiff/xmerge.c
> @@ -427,7 +427,7 @@ static int xdl_do_merge(xdfenv_t *xe1, xdchange_t *xscr1, const char *name1,
>  			xscr2 = xscr2->next;
>  			continue;
>  		}
> -		if (level < 1 || xscr1->i1 != xscr2->i1 ||
> +		if (level == XDL_MERGE_MINIMAL || xscr1->i1 != xscr2->i1 ||

Yeah, okay, sorry.

> @@ -449,12 +449,11 @@ static int xdl_do_merge(xdfenv_t *xe1, xdchange_t *xscr1, const char *name1,
>  			chg0 = xscr1->i1 + xscr1->chg1 - i0;
>  			chg1 = xscr1->i2 + xscr1->chg2 - i1;
>  			chg2 = xscr2->i2 + xscr2->chg2 - i2;
> -			if (ffo > 0)
> -				chg2 += ffo;
> -			else {
> +			if (ffo < 0) {
>  				chg0 -= ffo;
>  				chg1 -= ffo;
> -			}
> +			} else
> +				chg2 += ffo;

I do not understand why the order was changed, but hey, I do not care that 
deeply.

Ciao,
Dscho
