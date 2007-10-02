From: Eygene Ryabinkin <rea-git@codelabs.ru>
Subject: Re: git-http-push / webDAV
Date: Tue, 2 Oct 2007 14:46:46 +0400
Message-ID: <20071002104646.GY975@void.codelabs.ru>
References: <4700F6BC.2070701@jentro.com> <20071001155454.GU975@void.codelabs.ru> <47020603.3080000@jentro.com> <20071002085416.GW975@void.codelabs.ru> <470215F6.2060105@jentro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Cc: git@vger.kernel.org
To: Thomas Pasch <thomas.pasch@jentro.com>
X-From: git-owner@vger.kernel.org Tue Oct 02 12:47:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IcfHP-0006In-0b
	for gcvg-git-2@gmane.org; Tue, 02 Oct 2007 12:47:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752049AbXJBKq6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Oct 2007 06:46:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751924AbXJBKq6
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Oct 2007 06:46:58 -0400
Received: from pobox.codelabs.ru ([144.206.177.45]:64680 "EHLO
	pobox.codelabs.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751755AbXJBKq5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Oct 2007 06:46:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=simple; s=one; d=codelabs.ru;
	h=Received:Date:From:To:Cc:Message-ID:References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:Sender:X-Spam-Status:Subject;
	b=VXHHQ0nmRXunmug4OOVU6QxJ+UwuHoyhAMsuhDvv3xjejf5EaiRlOvQNKaOvQOULPQ5c29wVPB2s3e6+2mPwloSZdOkSbmUlq0xgOx0l5Hv2fEE9fGGzacd3oKyIistKkeGvEodSeue2JOiO7EkEvV7tVM4iRahNzwjvo/wWTrU=;
Received: from void.codelabs.ru (void.codelabs.ru [144.206.177.25])
	by pobox.codelabs.ru with esmtpsa (TLSv1:AES256-SHA:256)
	id 1IcfH9-0002At-7R; Tue, 02 Oct 2007 14:46:51 +0400
Content-Disposition: inline
In-Reply-To: <470215F6.2060105@jentro.com>
X-Spam-Status: No, score=-1.8 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_40,
	NORMAL_HTTP_TO_IP
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59681>

Thomas,

Tue, Oct 02, 2007 at 11:57:10AM +0200, Thomas Pasch wrote:
> well, *somewhat* better with the trailing slash:
> 
> > echo "modified" >>grep.c
> > git commit -a
> Created commit e147e54: mod
>  1 files changed, 1 insertions(+), 0 deletions(-)
> > git push -v
> Pushing to http://test@192.1.1.184/git/git.git/
> Fetching remote heads...
>   refs/
>   refs/heads/
>   refs/tags/
> updating 'refs/heads/master'
>   from 34c6dbdef439f7cd93d3fe22493a3c1496ce96f7
>   to   e147e54b14828fa2e88e88907e0ca4dc3d694448
>     sending 3 objects
>     done
> Updating remote server info
> 
> There's no more error message.

OK, that's fine: the previous error was tied to the fact that
when you're getting /git/git.git from the Web-server, it notices
that it is a directory and redirects you to the /git/git.git/.
But (IIRC) curl does not follow such redirections.

> However, push has still
> not worked. If I try to check out the new HEAD:
> 
> > git clone http://test@192.1.1.184/git/git.git/
> Initialized empty Git repository in /home/tpasch/tmp/git/.git/
> Getting alternates list for http://test@192.1.1.184/git/git.git
> Getting pack list for http://test@192.1.1.184/git/git.git
> Getting index for pack 563e2090185692c7d765775569a0ce986840fd17
> Getting pack 563e2090185692c7d765775569a0ce986840fd17
>  which contains 3af9d3e08da868c3a7687ab38d72f4296a99005d
> [...]
> walk 24778e335a6450e34257a311d0bf4a12bdb3006c
> walk 19b2860cba5742ab31fd682b80fefefac19be141
> walk bf0c6e839c692142784caf07b523cd69442e57a5
> walk e497ea2a9b6c378f01d092c210af20cbee762475
> walk 8bc9a0c769ac1df7820f2dbf8f7b7d64835e3c68
> walk e83c5163316f89bfbde7d9ab23ca2e25604af290
> Getting alternates list for http://test@192.1.1.184/git/git.git
> Getting pack list for http://test@192.1.1.184/git/git.git
> error: Unable to find e147e54b14828fa2e88e88907e0ca4dc3d694448 under
> http://test@192.1.1.184/git/git.git
> Cannot obtain needed object e147e54b14828fa2e88e88907e0ca4dc3d694448

OK, I will try to do this on my server with 2.2.6.  How big
is your repository?  Both size and commit number.

Thanks.
-- 
Eygene
