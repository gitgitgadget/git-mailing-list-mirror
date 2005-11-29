From: Jan Andres <jandres@gmx.net>
Subject: Re: [PATCH] Fix typo in http-push.c
Date: Tue, 29 Nov 2005 14:35:37 +0100
Message-ID: <20051129133537.GA490@pitr.home.jan>
References: <20051129005154.GA3076@pitr.home.jan> <Pine.LNX.4.63.0511290923390.16927@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 29 15:13:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eh5e3-0006P5-QQ
	for gcvg-git@gmane.org; Tue, 29 Nov 2005 14:35:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751134AbVK2Nfk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 29 Nov 2005 08:35:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751178AbVK2Nfk
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Nov 2005 08:35:40 -0500
Received: from mail.gmx.de ([213.165.64.20]:56983 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751134AbVK2Nfk (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Nov 2005 08:35:40 -0500
Received: (qmail invoked by alias); 29 Nov 2005 13:35:38 -0000
Received: from e182065135.adsl.alicedsl.de (EHLO pitr.home.jan) [85.182.65.135]
  by mail.gmx.net (mp011) with SMTP; 29 Nov 2005 14:35:38 +0100
X-Authenticated: #11648398
Received: by pitr.home.jan (Postfix, from userid 500)
	id E0C432135FE; Tue, 29 Nov 2005 14:35:37 +0100 (MET)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0511290923390.16927@wbgn013.biozentrum.uni-wuerzburg.de>
User-Agent: Mutt/1.4.2.1i
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12941>

Hi,

On Tue, 29. Nov. 2005 at 09:24:47 +0100, Johannes Schindelin wrote:
> Hi,
> 
> On Tue, 29 Nov 2005, Jan Andres wrote:
> 
> > -				lock->token = xmalloc(strlen(ctx->cdata - 15));
> > +				lock->token = xmalloc(strlen(ctx->cdata) - 15);
> >  				strcpy(lock->token, ctx->cdata + 16);
> 
> Why not
> 
> +				lock->token = xmalloc(strlen(ctx->cdata + 16));

Looks more efficient indeed, but wouldn't we have to use

+				lock->token = xmalloc(strlen(ctx->cdata + 16) + 1);

so as to account for the trailing NUL?

Regards
-- 
Jan Andres <jandres@gmx.net>
