From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] p5310: mend broken &&-chain
Date: Fri, 10 Jul 2015 16:50:29 -0400
Message-ID: <20150710205029.GA1181@peff.net>
References: <55A02DD9.3020909@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Fri Jul 10 22:50:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZDfFl-0004J6-Jj
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jul 2015 22:50:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932506AbbGJUue convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Jul 2015 16:50:34 -0400
Received: from cloud.peff.net ([50.56.180.127]:58739 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754508AbbGJUuc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jul 2015 16:50:32 -0400
Received: (qmail 32212 invoked by uid 102); 10 Jul 2015 20:50:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 10 Jul 2015 15:50:32 -0500
Received: (qmail 11570 invoked by uid 107); 10 Jul 2015 20:50:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 10 Jul 2015 16:50:31 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 10 Jul 2015 16:50:29 -0400
Content-Disposition: inline
In-Reply-To: <55A02DD9.3020909@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273834>

On Fri, Jul 10, 2015 at 10:40:57PM +0200, Ren=C3=A9 Scharfe wrote:

> diff --git a/t/perf/p5310-pack-bitmaps.sh b/t/perf/p5310-pack-bitmaps=
=2Esh
> index f8ed857..de2a224 100755
> --- a/t/perf/p5310-pack-bitmaps.sh
> +++ b/t/perf/p5310-pack-bitmaps.sh
> @@ -39,14 +39,14 @@ test_expect_success 'create partial bitmap state'=
 '
> =20
>  	# now kill off all of the refs and pretend we had
>  	# just the one tip
> -	rm -rf .git/logs .git/refs/* .git/packed-refs
> -	git update-ref HEAD $cutoff
> +	rm -rf .git/logs .git/refs/* .git/packed-refs &&
> +	git update-ref HEAD $cutoff &&

Thanks, this definitely is a problem, but we already have a fix in the
sb/p5310-and-chain topic. I thought that had been merged-up, but it
looks like it is only in "next" right now.

-Peff
