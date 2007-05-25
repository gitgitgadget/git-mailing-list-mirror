From: Joshua N Pritikin <jpritikin@pobox.com>
Subject: Re: [PATCH] Fix mishandling of $Id$ expanded in the repository copy in convert.c
Date: Fri, 25 May 2007 16:28:36 +0530
Message-ID: <20070525105836.GG6667@always.joy.eth.net>
References: <200705251150.09439.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 25 12:59:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HrXW3-0004b5-Ub
	for gcvg-git@gmane.org; Fri, 25 May 2007 12:59:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754360AbXEYK6t (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 25 May 2007 06:58:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754263AbXEYK6t
	(ORCPT <rfc822;git-outgoing>); Fri, 25 May 2007 06:58:49 -0400
Received: from sceptre.pobox.com ([207.106.133.20]:47511 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753437AbXEYK6s (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 May 2007 06:58:48 -0400
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id A58D32EF;
	Fri, 25 May 2007 06:59:08 -0400 (EDT)
Received: from emit.nirmalvihar.info (house.nirmalvihar.info [61.17.90.7])
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id B018D4FB61;
	Fri, 25 May 2007 06:59:03 -0400 (EDT)
Received: by emit.nirmalvihar.info (sSMTP sendmail emulation); Fri, 25 May 2007 16:28:36 +0530
Content-Disposition: inline
In-Reply-To: <200705251150.09439.andyparkins@gmail.com>
X-PGP-Key: 06E3 3D22 D307 AAE6 ACB4  6B44 A9CA A794 A4A6 0BBD
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48358>

On Fri, May 25, 2007 at 11:50:08AM +0100, Andy Parkins wrote:
> +			/*
> +			 * Throw away characters until either
> +			 *  - we reach a "$"
> +			 *  - we run out of bytes (rem == 0)
> +			 */
>  			do {
> -				ch = *cp++;
> +				ch = *cp;
>  				if (ch == '$')
>  					break;
> +				cp++;
>  				rem--;
>  			} while (rem);

Can this loop throw away newlines? Removing newlines seems like a bad 
idea.
