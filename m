From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/6] t9107: use "return 1" instead of "exit 1"
Date: Sat, 14 May 2016 15:51:50 -0400
Message-ID: <20160514195150.GA24206@sigill.intra.peff.net>
References: <20160513204654.GA10684@sigill.intra.peff.net>
 <20160513204721.GC15391@sigill.intra.peff.net>
 <CAPig+cQKkkP=Go=w65mGcgqZN6ckz21kG2=KCJS8L+0D3mgC+g@mail.gmail.com>
 <20160513234704.GA20238@sigill.intra.peff.net>
 <xmqqbn488rss.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Armin Kunaschik <megabreit@googlemail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 14 21:52:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b1fbR-0000o0-Pz
	for gcvg-git-2@plane.gmane.org; Sat, 14 May 2016 21:51:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932292AbcENTvy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 May 2016 15:51:54 -0400
Received: from cloud.peff.net ([50.56.180.127]:39690 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753790AbcENTvx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 May 2016 15:51:53 -0400
Received: (qmail 18816 invoked by uid 102); 14 May 2016 19:51:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 14 May 2016 15:51:53 -0400
Received: (qmail 28446 invoked by uid 107); 14 May 2016 19:51:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 14 May 2016 15:51:52 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 14 May 2016 15:51:50 -0400
Content-Disposition: inline
In-Reply-To: <xmqqbn488rss.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294627>

On Sat, May 14, 2016 at 10:37:07AM -0700, Junio C Hamano wrote:

> Thanks for sharp eyes.  Let's squash this in, perhaps?
> 
>  t/t9107-git-svn-migrate.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/t/t9107-git-svn-migrate.sh b/t/t9107-git-svn-migrate.sh
> index 2908aef..b6a99b8 100755
> --- a/t/t9107-git-svn-migrate.sh
> +++ b/t/t9107-git-svn-migrate.sh
> @@ -80,12 +80,12 @@ test_expect_success 'multi-fetch works on partial urls + paths' '
>  		git rev-parse --verify refs/remotes/origin/$i^0 || return 1;
>  	done >refs.out &&
>  	test -z "$(sort <refs.out | uniq -d)" &&
> -	>expect &&
>  	for i in $refs
>  	do
>  		for j in $refs
>  		do
> -			git diff --exit-code refs/remotes/origin/$i refs/remotes/origin/$j ||
> +			git diff --exit-code refs/remotes/origin/$i \
> +					     refs/remotes/origin/$j ||
>  				return 1
>  		done
>  	done

Yeah, that looks perfect. Thanks.

-Peff
