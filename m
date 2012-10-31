From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v4 00/13] New remote-hg helper
Date: Wed, 31 Oct 2012 06:27:13 -0400
Message-ID: <20121031102712.GB30879@sigill.intra.peff.net>
References: <20121029085045.GA5023@sigill.intra.peff.net>
 <CAMP44s0RVe6i4DpNmaV_n7_5KO_aq2WxCPVafjsTukExRSR5Jw@mail.gmail.com>
 <20121029212643.GA20513@sigill.intra.peff.net>
 <CAMP44s3L0ycSQFU9s157V7e-GryUdojtQ3Vk_-d2wtPf9NFtbg@mail.gmail.com>
 <20121029215631.GF20513@sigill.intra.peff.net>
 <alpine.DEB.1.00.1210301809060.7256@s15462909.onlinehome-server.info>
 <CAMP44s3CEGqUav-ijnzm7osD70LsjRLyOEeV3bF-LWYTCEPCSQ@mail.gmail.com>
 <alpine.DEB.1.00.1210302027410.7256@s15462909.onlinehome-server.info>
 <CAMP44s0akZ7_Nd1Q1AaZJuXnyTJv2MzNqDus76Y82y4LbWVO+Q@mail.gmail.com>
 <5090EFCA.7070606@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 31 11:27:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TTVWF-0000eq-MJ
	for gcvg-git-2@plane.gmane.org; Wed, 31 Oct 2012 11:27:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756438Ab2JaK1S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Oct 2012 06:27:18 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:44931 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756108Ab2JaK1R (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Oct 2012 06:27:17 -0400
Received: (qmail 12383 invoked by uid 107); 31 Oct 2012 10:27:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 31 Oct 2012 06:27:58 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 31 Oct 2012 06:27:13 -0400
Content-Disposition: inline
In-Reply-To: <5090EFCA.7070606@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208804>

On Wed, Oct 31, 2012 at 10:30:50AM +0100, Michael J Gruber wrote:

> For the record, Johannes is not the only one being kept from looking at
> this series (further) by the tone of this discussion. Per hominem
> attacks are neither professional nor helpful. We prefer to discuss code
> here, just code. From my comments on an earlier version of your series
> you can see I've tried. The way other comment threads on this series
> unfolded made me choose to be a mere by-stander again.

Me too. I really like some of the directions the series is taking, and
as the maintainer, I'd like to pick it up. But there is a big question
mark for me still about how it relates to the work in msysgit,
especially:

  - What advantages does this implementation have over the one in
    msysgit (i.e., new features that the other one does not have)?

  - What disadvantages? If this implementation goes into git.git,
    the msysgit one is likely to wane in popularity. What will we be
    losing by doing so? If the answer is not "nothing", how hard would
    it be to port over the missing bits?

  - The msysgit one got held up by fixes needed for fast-export. Why
    aren't those a problem for this implementation? If we are using a
    different strategy that avoids the issue, what are the limitations
    (if any) of that strategy?

I have a feeling that some of those answers are buried deep within the
discussion, but I have had a hard time following all of the back and
forth due to the volume and tone of the discussion. Are we at a point
now where some of the participants can try to summarize the situation?

I am not saying that this implementation must be 100% better than the
msysgit one. I do not want perfect to to be the enemy of good and end up
with nothing. But at the same time, there really are two competing
implementations, one of which has received substantially more field use.
Even though the msysgit one is not in git.git, it seems like the path
for making it happen exists (even if it has not been followed yet).
Before merging an alternative implementation, I would want to know what
we are potentially throwing away from the msysgit side, and make sure
that we are not following a wrong path that msysgit has already tried
and found to be lacking.

-Peff
