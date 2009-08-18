From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] block-sha1: make the size member first in the context
 struct
Date: Tue, 18 Aug 2009 02:24:02 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0908180223280.8306@pacific.mpi-cbg.de>
References: <alpine.LFD.2.00.0908172012591.6044@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Tue Aug 18 02:23:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdCTx-0001uo-GH
	for gcvg-git-2@lo.gmane.org; Tue, 18 Aug 2009 02:23:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758452AbZHRAXN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2009 20:23:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758450AbZHRAXN
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 20:23:13 -0400
Received: from mail.gmx.net ([213.165.64.20]:44372 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758447AbZHRAXN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2009 20:23:13 -0400
Received: (qmail invoked by alias); 18 Aug 2009 00:23:13 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp070) with SMTP; 18 Aug 2009 02:23:13 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX189/dNZxPc9hYxkOOc2oYHgp766K6DCXlYg/OWhUX
	Aw+OzEyZOGv0On
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <alpine.LFD.2.00.0908172012591.6044@xanadu.home>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.58
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126327>

Hi,

On Mon, 17 Aug 2009, Nicolas Pitre wrote:

> This is a 64-bit value, hence having it first provides a better 
> alignment.
> 
> Signed-off-by: Nicolas Pitre <nico@cam.org>
> 
> diff --git a/block-sha1/sha1.h b/block-sha1/sha1.h
> index 6ff59b2..b864df6 100644
> --- a/block-sha1/sha1.h
> +++ b/block-sha1/sha1.h
> @@ -7,9 +7,9 @@
>   */
>  
>  typedef struct {
> +	unsigned long long size;
>  	unsigned int H[5];
>  	unsigned int W[16];
> -	unsigned long long size;
>  } blk_SHA_CTX;

By the reasoning suggested in the commit message, should H[5] not go to 
the end?

Ciao,
Dscho
