From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Apr 2013, #05; Mon, 15)
Date: Wed, 17 Apr 2013 16:10:56 -0400
Message-ID: <20130417201056.GA2914@sigill.intra.peff.net>
References: <7vhaj7r116.fsf@alter.siamese.dyndns.org>
 <87txn5xzdn.fsf@linux-k42r.v.cablecom.net>
 <7vd2ttgoyr.fsf@alter.siamese.dyndns.org>
 <87wqs1xi9h.fsf@hexa.v.cablecom.net>
 <7vk3o1f5kb.fsf@alter.siamese.dyndns.org>
 <7vwqs1dnxp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Rast <trast@inf.ethz.ch>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 17 22:11:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USYh5-0006NA-KE
	for gcvg-git-2@plane.gmane.org; Wed, 17 Apr 2013 22:11:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965509Ab3DQULA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Apr 2013 16:11:00 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:50245 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965338Ab3DQUK6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Apr 2013 16:10:58 -0400
Received: (qmail 3995 invoked by uid 107); 17 Apr 2013 20:12:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 17 Apr 2013 16:12:53 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 17 Apr 2013 16:10:56 -0400
Content-Disposition: inline
In-Reply-To: <7vwqs1dnxp.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221569>

On Wed, Apr 17, 2013 at 11:14:42AM -0700, Junio C Hamano wrote:

> > I think it is just the warning code avoiding extra complexity and
> > overhead, if you are talking about not getting warning in the
> > pre-2.0 step that is in 'next'.  Patches are very much welcomed,
> > especially the ones that come before I get around to it ;-)
> 
> I took a brief look at the code, and as you said "add" needs to know
> about submodules, and the best fix looks to me to take the same
> approach Jonathan came up with to de-noise the "add -u/-A" topic.
> 
> That is, to scan the working tree to actually see if we would record
> removals to the index in 2.0, but not remove them in this current
> version, and give the warning when the differences in the behaviours
> matter.

Yeah, I had the same thought, as this warning has been bugging me for
the last day or two. The worst part about it is that I finally trained
myself to type "git add ." to silence the _other_ warning, and now it
triggers this one. :)

-Peff
