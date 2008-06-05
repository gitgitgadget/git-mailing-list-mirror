From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [BUG?] "git rebase --interactive" forces me to edit message.
Date: Thu, 5 Jun 2008 05:40:48 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806050539360.21190@racer>
References: <200806050358.m553wgK9013230@mi0.bluebottle.com> <7v3ans5xit.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: =?ISO-2022-JP?Q?=1B$B$7$i$$$7$J$J$3=1B=28J?= 
	<nanako3@bluebottle.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 05 06:43:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K47JY-0003YA-Nv
	for gcvg-git-2@gmane.org; Thu, 05 Jun 2008 06:43:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751393AbYFEEmM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2008 00:42:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751364AbYFEEmM
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jun 2008 00:42:12 -0400
Received: from mail.gmx.net ([213.165.64.20]:34321 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751241AbYFEEmM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2008 00:42:12 -0400
Received: (qmail invoked by alias); 05 Jun 2008 04:42:10 -0000
Received: from unknown (EHLO racer.local) [128.177.17.254]
  by mail.gmx.net (mp025) with SMTP; 05 Jun 2008 06:42:10 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/e57BWaVjeO5Drlw0tVUCg7PN73wJTlBjV4FlKKR
	y5MrPO6ROG3C1I
X-X-Sender: gene099@racer
In-Reply-To: <7v3ans5xit.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83858>

Hi,

On Wed, 4 Jun 2008, Junio C Hamano wrote:

> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index 0ca986f..a6b6c9e 100755
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -390,11 +390,14 @@ do
>  				die "Cannot find the author identity"
>  			if test -f "$DOTEST"/amend
>  			then
> +				do_edit=-e
>  				git reset --soft HEAD^ ||
>  				die "Cannot rewind the HEAD"
> +			else
> +				do_edit=
>  			fi
>  			export GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL GIT_AUTHOR_DATE &&
> -			git commit --no-verify -F "$DOTEST"/message -e ||
> +			git commit --no-verify -F "$DOTEST"/message $do_edit ||
>  			die "Could not commit staged changes."
>  		fi

I guess with the recent changes, I do not count as author of rebase -i 
anymore.  Otherwise, I would say "NACK" for the reasons described in my 
other mail.

Ciao,
Dscho
