From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Adding rebase merge strategy
Date: Mon, 1 Oct 2007 16:50:03 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710011647030.28395@racer.site>
References: <Pine.LNX.4.64.0709281751390.28395@racer.site>
 <11912513203420-git-send-email-tom@u2i.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: gitster@pobox.com, git@vger.kernel.org
To: Tom Clarke <tom@u2i.com>
X-From: git-owner@vger.kernel.org Mon Oct 01 17:51:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IcNYM-0005Sx-5l
	for gcvg-git-2@gmane.org; Mon, 01 Oct 2007 17:51:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752051AbXJAPvS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Oct 2007 11:51:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752049AbXJAPvR
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Oct 2007 11:51:17 -0400
Received: from mail.gmx.net ([213.165.64.20]:52961 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751935AbXJAPvR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Oct 2007 11:51:17 -0400
Received: (qmail invoked by alias); 01 Oct 2007 15:51:15 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp049) with SMTP; 01 Oct 2007 17:51:15 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18pv+BoLjApm9tqgofl2OsBJ/DAiUDQsBc+KT3JPc
	O5gyVKm6s/+vSH
X-X-Sender: gene099@racer.site
In-Reply-To: <11912513203420-git-send-email-tom@u2i.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59623>

Hi,

On Mon, 1 Oct 2007, Tom Clarke wrote:

> Incorporated comments from Johannes Schindlen.

Thanks.

> +# Give up if we are given two or more remotes -- not handling octopus.
> +test $# = 1 || exit 2

I think the user wants to know in this case, too.  How about

test $# = 1 || {
	echo "Cannot handle octopus." >&2
	exit 2
}

> diff --git a/t/t3031-merge-rebase.sh b/t/t3031-merge-rebase.sh
> new file mode 100755
> index 0000000..daa03b1
> --- /dev/null
> +++ b/t/t3031-merge-rebase.sh
>
> [...]
>
> +	( git log --pretty=oneline ) >actual &&

Please lose the parentheses here.

> +	(
> +		echo "4db7a5a013e67aa623d1fd294e8d46e89b3ace8f onbranch"
> +		echo "893371811dbd13e85c098b72d1ab42bcfd24c2db update"
> +		echo "0e960b10429bf3f1e168ee2cc7d531ac7c622580 initial"
> +	) >expected &&

Why not do it as is done elsewhere in the test suit: use a "cat << EOF" 
before "test_expect_success"?

> +	(
> +		echo "warning: Message is not used for rebase merge strategy"
> +	) >expected &&

Same here.

Other than that, I like it.

Ciao,
Dscho
