From: Jeff King <peff@peff.net>
Subject: Re: git diff - no newline after @@ ?
Date: Fri, 18 Aug 2006 08:44:28 -0400
Message-ID: <20060818124428.GA22328@sigio.intra.peff.net>
References: <44E5AE42.6090506@scssoft.com> <81b0412b0608180525t284d3124j867a9461bf14ed91@mail.gmail.com> <44E5B496.3070901@scssoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 18 14:44:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GE3iE-0005oa-Ad
	for gcvg-git@gmane.org; Fri, 18 Aug 2006 14:44:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932386AbWHRMoa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Aug 2006 08:44:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932452AbWHRMoa
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Aug 2006 08:44:30 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1478 "HELO
	peff.net") by vger.kernel.org with SMTP id S932386AbWHRMoa (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Aug 2006 08:44:30 -0400
Received: (qmail 31908 invoked from network); 18 Aug 2006 08:43:59 -0400
Received: from unknown (HELO sigio.intra.peff.net) (10.0.0.10)
  by segfault.intra.peff.net with SMTP; 18 Aug 2006 08:43:59 -0400
Received: by sigio.intra.peff.net (sSMTP sendmail emulation); Fri, 18 Aug 2006 08:44:28 -0400
To: Petr Sebor <petr@scssoft.com>
Content-Disposition: inline
In-Reply-To: <44E5B496.3070901@scssoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25658>

On Fri, Aug 18, 2006 at 02:37:42PM +0200, Petr Sebor wrote:

> >>has anyone noticed that the 'git diff' output somehow lacks the newline
> >>after the @@ tag?
> >Why should it? It's hunk comment.
> Hunk comment? Maybe we don't understand each other...

The intent of a hunk comment is to give the user some context. Note how
it's usually the C function name, even if the declaration of that
function isn't the line right before the context lines?

> check another example:
> 
> --- a/include/linux/kernel.h
> +++ b/include/linux/kernel.h
> @@ -13,6 +13,7 @@ #include <linux/stddef.h>
> #include <linux/types.h>
> #include <linux/compiler.h>
> #include <linux/bitops.h>
> +#include <linux/memleak.h>
> #include <asm/byteorder.h>
> #include <asm/bug.h>

The function detection is very simple (I believe it just looks for the
closest preceding line without any prior whitespace).

> whereas gnu diff would output

Try diff -p to get a hunk comment.

-Peff
