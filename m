From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/5] Builtin "git remote"
Date: Sun, 2 Mar 2008 15:40:52 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0803021531230.22527@racer.site>
References: <alpine.LSU.1.00.0802290144130.22527@racer.site> <7vwsoofrue.fsf@gitster.siamese.dyndns.org> <alpine.LNX.1.00.0802282104500.19665@iabervon.org> <alpine.LSU.1.00.0802291118540.22527@racer.site> <alpine.LSU.1.00.0803021511420.22527@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sun Mar 02 16:42:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVqKU-0002By-2M
	for gcvg-git-2@gmane.org; Sun, 02 Mar 2008 16:42:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752321AbYCBPlo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Mar 2008 10:41:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752215AbYCBPlo
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Mar 2008 10:41:44 -0500
Received: from mail.gmx.net ([213.165.64.20]:36488 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752064AbYCBPln (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Mar 2008 10:41:43 -0500
Received: (qmail invoked by alias); 02 Mar 2008 15:41:41 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp018) with SMTP; 02 Mar 2008 16:41:41 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+jEJIB2GWj0L0G2mayfr2qcnNOWZUUK2aydQPmFP
	Wjk+lTdjU0JxZP
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.LSU.1.00.0803021511420.22527@racer.site>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75787>

Hi,

On Sun, 2 Mar 2008, Johannes Schindelin wrote:

> diff --git a/builtin-log.c b/builtin-log.c
> index bbadbc0..17e491b 100644
> --- a/builtin-log.c
> +++ b/builtin-log.c
> @@ -694,7 +694,7 @@ static void make_cover_letter(struct rev_info *rev, int use_stdout,
>  	if (!origin)
>  		return;
>  
> -	diff_setup(&opts);
> +	memcpy(&opts, &rev->diffopt, sizeof(opts));
>  	opts.output_format |= DIFF_FORMAT_SUMMARY | DIFF_FORMAT_DIFFSTAT;
>  
>  	diff_setup_done(&opts);

Ooops, I forgot to "make test"!  And sure enough, t4013 breaks, because 
the "|=" was bogus to begin with.

Will resend, together with a patch to wrap the shortlog nicely.

... after "make test" ;-)

Ciao,
Dscho

