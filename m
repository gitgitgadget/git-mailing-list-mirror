From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: Clarify which paths git-clean will affect
Date: Tue, 05 May 2009 09:20:49 -0700
Message-ID: <7vk54v1py6.fsf@alter.siamese.dyndns.org>
References: <20090505091302.GB27900@frsk.net>
	<200905051155.28985.trast@student.ethz.ch>
	<20090505100506.GF27900@frsk.net>
	<200905051426.18814.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Fredrik Skolmli <fredrik@frsk.net>, git@vger.kernel.org,
	Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue May 05 18:21:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M1NOf-0007zd-9e
	for gcvg-git-2@gmane.org; Tue, 05 May 2009 18:21:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757093AbZEEQUv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 May 2009 12:20:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756270AbZEEQUv
	(ORCPT <rfc822;git-outgoing>); Tue, 5 May 2009 12:20:51 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:65449 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755849AbZEEQUu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 May 2009 12:20:50 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090505162049.MFOZ25927.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Tue, 5 May 2009 12:20:49 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo01.cox.net with bizsmtp
	id nsLp1b00H4aMwMQ03sLpzP; Tue, 05 May 2009 12:20:49 -0400
X-Authority-Analysis: v=1.0 c=1 a=jW5P4C6t7I8A:10 a=-ca1oWsSjK8A:10
 a=MeH5wu2jwkFpsIXnIDIA:9 a=ShZkh203koXBse_KyBQA:7
 a=6l9vJ_tCVRHC7svzT80IpPeUC5YA:4
X-CM-Score: 0.00
In-Reply-To: <200905051426.18814.trast@student.ethz.ch> (Thomas Rast's message of "Tue\, 5 May 2009 14\:26\:14 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118304>

Thomas Rast <trast@student.ethz.ch> writes:

>  Normally, only files unknown to git are removed, but if the '-x'
>  option is specified, ignored files are also removed. This can, for
>  example, be useful to remove all build products.
>  
> -If any optional `<path>...` arguments are given, only those paths
> -are affected.
> +If any optional `<path>...` arguments are given, those paths are
> +affected.  Otherwise, the cleaning starts at the current directory.

With or without path limiters, clean does not look outside the current
directory; I think the "otherwise" makes things worse than the original.

I'd suggest not touching this paragraph at all, but instead say something
like this at the beginning:

> diff --git i/Documentation/git-clean.txt w/Documentation/git-clean.txt
> index 43b2de7..3550fc0 100644
> --- i/Documentation/git-clean.txt
> +++ w/Documentation/git-clean.txt
> @@ -13,15 +13,15 @@ SYNOPSIS
>  DESCRIPTION
>  -----------
>  
> -This allows cleaning the working tree by removing files that are not
> +Cleans the working tree by recursively removing files that are not
>  under version control.

    Cleans the working tree by recursively removing files that are not
    under version control, starting from the current directory.
