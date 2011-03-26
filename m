From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] HOME must be set before calling git-init when creating
 test repositories
Date: Sat, 26 Mar 2011 14:48:06 -0400
Message-ID: <20110326184806.GA4488@sigill.intra.peff.net>
References: <AANLkTimQzPVOWCUx1hr+DEmRfdFB8=UeY_xCaxzVSwFy@mail.gmail.com>
 <7voc4y6g6v.fsf@alter.siamese.dyndns.org>
 <AANLkTikO4=TtFtpsQ_JtmGKqQ1NzgTuo7e8cdaQca+T7@mail.gmail.com>
 <7vvcz64ygm.fsf@alter.siamese.dyndns.org>
 <AANLkTi=+SZGxLyP8vFPpmK8DZvke6-Tu-crwq5+89qWx@mail.gmail.com>
 <20110326141118.GA3475@sigill.intra.peff.net>
 <20110326182126.GA13496@blimp.localdomain>
 <20110326183102.GA3796@sigill.intra.peff.net>
 <AANLkTi=Pt_Pw9BvL6y8Wq34PeRHVOZpr6ZekRYqfDXq6@mail.gmail.com>
 <20110326184634.GB13496@blimp.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 26 19:48:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q3YX2-0008OJ-7B
	for gcvg-git-2@lo.gmane.org; Sat, 26 Mar 2011 19:48:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753685Ab1CZSsK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Mar 2011 14:48:10 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:43291
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753640Ab1CZSsJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Mar 2011 14:48:09 -0400
Received: (qmail 26039 invoked by uid 107); 26 Mar 2011 18:48:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 26 Mar 2011 14:48:48 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 26 Mar 2011 14:48:06 -0400
Content-Disposition: inline
In-Reply-To: <20110326184634.GB13496@blimp.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170068>

On Sat, Mar 26, 2011 at 07:46:34PM +0100, Alex Riesen wrote:

> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 7cc9a52..7965b74 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -984,14 +984,14 @@ rm -fr "$test" || {
>  	exit 1
>  }
>  
> +HOME="$TRASH_DIRECTORY"
> +export HOME
> +
>  test_create_repo "$test"
>  # Use -P to resolve symlinks in our working directory so that the cwd
>  # in subprocesses like git equals our $PWD (for pathname comparisons).
>  cd -P "$test" || exit 1
>  
> -HOME=$(pwd)
> -export HOME
> -

That looks right to me. Thanks.

-Peff
