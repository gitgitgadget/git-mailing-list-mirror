From: Jeff King <peff@peff.net>
Subject: Re: textconv not invoked when viewing merge commit
Date: Fri, 15 Apr 2011 21:47:59 -0400
Message-ID: <20110416014758.GB23306@sigill.intra.peff.net>
References: <201104111912.47547.kumbayo84@arcor.de>
 <4DA415AB.9020008@drmicha.warpmail.net>
 <20110414190901.GA1184@sigill.intra.peff.net>
 <7vipughbxh.fsf@alter.siamese.dyndns.org>
 <7vd3kohb5n.fsf@alter.siamese.dyndns.org>
 <7v8vvcha2s.fsf@alter.siamese.dyndns.org>
 <20110414202356.GB6525@sigill.intra.peff.net>
 <vpq62qg3sxy.fsf@bauges.imag.fr>
 <7v7havckgg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Peter Oberndorfer <kumbayo84@arcor.de>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 16 03:48:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QAucN-0006Sj-P9
	for gcvg-git-2@lo.gmane.org; Sat, 16 Apr 2011 03:48:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755776Ab1DPBsF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Apr 2011 21:48:05 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:59978
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753964Ab1DPBsD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2011 21:48:03 -0400
Received: (qmail 15975 invoked by uid 107); 16 Apr 2011 01:48:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 15 Apr 2011 21:48:52 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 15 Apr 2011 21:47:59 -0400
Content-Disposition: inline
In-Reply-To: <7v7havckgg.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171655>

On Fri, Apr 15, 2011 at 01:45:35PM -0700, Junio C Hamano wrote:

> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
> 
> >> I can't think of a case where it matters, though, so maybe it is just
> >> paranoia.
> >
> > A line-counting, statistics tool would think that 1 line has been
> > removed from both branches, and one new added by the merge.
> >
> > Well, I know no tool parsing combined diff actually, so it's indeed a
> > hypothetical case.
> 
> And the ones that have been parsing cdiff wouldn't have done anything good
> before this change on such a binary blob anyway, no?

No, but we can view the proposed change as fixing a bug for such a tool
Whereas turning it into:

  --Binary blob XXX
  + Binary blob YYY
   +Binary blob ZZZ

is codifying ambiguous output, and making the tool forever broken.

-Peff
