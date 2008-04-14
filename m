From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [RFC/PATCH 2/3] Prepare testsuite for a "git clone" that packs
 refs
Date: Mon, 14 Apr 2008 02:10:50 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0804140205040.19665@iabervon.org>
References: <200803220210.30957.johan@herland.net> <200803220213.06359.johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Mon Apr 14 08:11:38 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JlHui-0003x8-SK
	for gcvg-git-2@gmane.org; Mon, 14 Apr 2008 08:11:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753407AbYDNGKw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Apr 2008 02:10:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753083AbYDNGKv
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Apr 2008 02:10:51 -0400
Received: from iabervon.org ([66.92.72.58]:35848 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752421AbYDNGKv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Apr 2008 02:10:51 -0400
Received: (qmail 4938 invoked by uid 1000); 14 Apr 2008 06:10:50 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 14 Apr 2008 06:10:50 -0000
In-Reply-To: <200803220213.06359.johan@herland.net>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79460>

On Sat, 22 Mar 2008, Johan Herland wrote:

> diff --git a/t/t5515-fetch-merge-logic.sh b/t/t5515-fetch-merge-logic.sh
> index 31c1081..4569a13 100755
> --- a/t/t5515-fetch-merge-logic.sh
> +++ b/t/t5515-fetch-merge-logic.sh
> @@ -143,6 +143,7 @@ do
>  			rm -f .git/refs/heads/*
>  			rm -f .git/refs/remotes/rem/*
>  			rm -f .git/refs/tags/*
> +			rm -f .git/packed-refs
>  			git fetch "$@" >/dev/null
>  			cat .git/FETCH_HEAD
>  		} >"$actual" &&

I was just looking over this again, and it doesn't actually work, because 
it removes the copies of refs/remotes/origin/*, which the tests are 
expecting to find.

	-Daniel
*This .sig left intentionally blank*
