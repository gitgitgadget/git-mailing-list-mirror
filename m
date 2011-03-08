From: Jeff King <peff@peff.net>
Subject: Re: how to list commits on branch since last merge
Date: Tue, 8 Mar 2011 12:12:51 -0500
Message-ID: <20110308171251.GA1823@sigill.intra.peff.net>
References: <AANLkTi=zW9hOhnddw6HsjQwV2qLf_R_qeNna+XeN6U6x@mail.gmail.com>
 <4D75ED72.8030203@drmicha.warpmail.net>
 <AANLkTinOEutM92k4SUGEXbfTpzGcQitpW4CZbcQbg0R4@mail.gmail.com>
 <AANLkTikK8Uc8=wKROYWWxZ_6OtQtqBmFCZN760M1LO+c@mail.gmail.com>
 <4D75FB7B.70403@drmicha.warpmail.net>
 <AANLkTim_h6vbvnmy7oUNYmV82vCzLLfWKq=3_UY9kPYw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	git <git@vger.kernel.org>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 08 18:19:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Px0ZR-0000ZK-IJ
	for gcvg-git-2@lo.gmane.org; Tue, 08 Mar 2011 18:19:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755081Ab1CHRTf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Mar 2011 12:19:35 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:35075
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754924Ab1CHRTe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Mar 2011 12:19:34 -0500
X-Greylist: delayed 398 seconds by postgrey-1.27 at vger.kernel.org; Tue, 08 Mar 2011 12:19:34 EST
Received: (qmail 859 invoked by uid 107); 8 Mar 2011 17:13:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 08 Mar 2011 12:13:20 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 08 Mar 2011 12:12:51 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTim_h6vbvnmy7oUNYmV82vCzLLfWKq=3_UY9kPYw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168667>

On Tue, Mar 08, 2011 at 05:11:16AM -0500, Jay Soffian wrote:

> Going back to my original picture, I mean commit m:
> 
>   o---o---x---o---...    foo
>    \       \
>     o---o---m---o---...  bar
> 
> merge-base foo bar gives me x; to get m I then need to grep the output
> of rev-list --parents for x.

Isn't the merge the first commit in bar that is not in foo? IOW:

  git rev-list foo..bar | tail -n 1

?

I admit it's not particularly elegant, though. And I haven't given
enough thought to decide whether that happens to work in your case, or
if it is more general. :)

-Peff
