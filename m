From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] rerere: Separate libgit and builtin functions
Date: Wed, 9 Jul 2008 14:03:53 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807091356050.5277@eeepc-johanness>
References: <alpine.DEB.1.00.0807090230560.5277@eeepc-johanness> <1215598683-9685-1-git-send-email-s-beyer@gmx.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Wed Jul 09 14:05:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGYPY-0006nI-6d
	for gcvg-git-2@gmane.org; Wed, 09 Jul 2008 14:04:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752914AbYGIMDm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jul 2008 08:03:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752141AbYGIMDm
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Jul 2008 08:03:42 -0400
Received: from mail.gmx.net ([213.165.64.20]:41415 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752085AbYGIMDl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jul 2008 08:03:41 -0400
Received: (qmail invoked by alias); 09 Jul 2008 12:03:39 -0000
Received: from 88-107-253-132.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.253.132]
  by mail.gmx.net (mp052) with SMTP; 09 Jul 2008 14:03:39 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/eF0ox9ovenwihFgCgghydpCDh2OcFJjIfoiZFWi
	umKA7NbinXtuX0
X-X-Sender: user@eeepc-johanness
In-Reply-To: <1215598683-9685-1-git-send-email-s-beyer@gmx.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87874>

Hi,

On Wed, 9 Jul 2008, Stephan Beyer wrote:

>  Makefile                     |    2 +
>  builtin-rerere.c             |  324 +++---------------------------------------
>  builtin-rerere.c => rerere.c |  133 +-----------------
>  rerere.h                     |    9 ++
>  4 files changed, 32 insertions(+), 436 deletions(-)

Heh, that sounds nice!  Deleting way more lines than adding!  :-)

>  copy builtin-rerere.c => rerere.c (66%)

Oh, well :-)

> diff --git a/builtin-rerere.c b/rerere.c
> similarity index 66%
> copy from builtin-rerere.c
> copy to rerere.c
> index 85222d9..5c22bed 100644
> --- a/builtin-rerere.c
> +++ b/rerere.c
> @@ -1,18 +1,11 @@
> -#include "builtin.h"
>  #include "cache.h"
>  #include "path-list.h"
> +#include "rerere.h"
>  #include "xdiff/xdiff.h"
>  #include "xdiff-interface.h"
>  
>  #include <time.h>

No longer necessary, is it?

> diff --git a/rerere.h b/rerere.h
> new file mode 100644
> index 0000000..35b0fa8
> --- /dev/null
> +++ b/rerere.h
> @@ -0,0 +1,9 @@
> +#ifndef RERERE_H
> +#define RERERE_H
> +
> +#include "path-list.h"
> +
> +extern int setup_rerere(struct path_list *);

Why?

Ah, it is needed for "gc".  Maybe this needs documentation, since it cause 
some minutes of head scratching with yours truly.

Ciao,
Dscho
