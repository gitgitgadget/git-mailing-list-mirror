From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (May 2016, #09; Tue, 31) t1308 broken
Date: Thu, 2 Jun 2016 17:39:20 -0400
Message-ID: <20160602213920.GA13356@sigill.intra.peff.net>
References: <xmqqzir53mdc.fsf@gitster.mtv.corp.google.com>
 <712e0755-6008-21f5-0ee6-25ed9d97fd45@web.de>
 <xmqq1t4ftheu.fsf@gitster.mtv.corp.google.com>
 <xmqqwpm7s2ex.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 02 23:39:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8aKt-0000O2-Fu
	for gcvg-git-2@plane.gmane.org; Thu, 02 Jun 2016 23:39:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932698AbcFBVjY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jun 2016 17:39:24 -0400
Received: from cloud.peff.net ([50.56.180.127]:48031 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932215AbcFBVjX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jun 2016 17:39:23 -0400
Received: (qmail 5427 invoked by uid 102); 2 Jun 2016 21:39:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 02 Jun 2016 17:39:23 -0400
Received: (qmail 14503 invoked by uid 107); 2 Jun 2016 21:39:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 02 Jun 2016 17:39:30 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 02 Jun 2016 17:39:20 -0400
Content-Disposition: inline
In-Reply-To: <xmqqwpm7s2ex.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296241>

On Thu, Jun 02, 2016 at 02:31:50PM -0700, Junio C Hamano wrote:

> Perhaps like this, taking hint from the log message of 6eafa6d0
> (submodules: don't stumble over symbolic links when cloning
> recursively, 2012-07-12)?
> 
>  t/t1308-config-set.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/t/t1308-config-set.sh b/t/t1308-config-set.sh
> index 065d5eb..1ba9ecb 100755
> --- a/t/t1308-config-set.sh
> +++ b/t/t1308-config-set.sh
> @@ -237,7 +237,7 @@ test_expect_success 'iteration shows correct origins' '
>  	key=foo.bar
>  	value=from-home
>  	origin=file
> -	name=$(pwd)/.gitconfig
> +	name=$TRASH_DIRECTORY/.gitconfig
>  	scope=global
>  
>  	key=foo.bar

Yeah, I think it is the same issue. I think the most accurate value
there would probably be $HOME, though.

-Peff
