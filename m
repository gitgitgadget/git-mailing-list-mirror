From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/5] RFC: patterns for branch list
Date: Wed, 7 Sep 2011 15:53:19 -0400
Message-ID: <20110907195319.GC13364@sigill.intra.peff.net>
References: <4E5607E0.1050300@drmicha.warpmail.net>
 <cover.1314259226.git.git@drmicha.warpmail.net>
 <20110825175301.GC519@sigill.intra.peff.net>
 <4E5759B1.50705@drmicha.warpmail.net>
 <7vwre0dsdy.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org,
	Michael Schubert <mschub@elegosoft.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 07 21:53:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1OBb-0004BE-QY
	for gcvg-git-2@lo.gmane.org; Wed, 07 Sep 2011 21:53:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756338Ab1IGTxX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Sep 2011 15:53:23 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:37035
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756104Ab1IGTxW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Sep 2011 15:53:22 -0400
Received: (qmail 5169 invoked by uid 107); 7 Sep 2011 19:54:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 07 Sep 2011 15:54:10 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 07 Sep 2011 15:53:19 -0400
Content-Disposition: inline
In-Reply-To: <7vwre0dsdy.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180899>

On Fri, Aug 26, 2011 at 09:55:37AM -0700, Junio C Hamano wrote:

> As we use fnmatch() and not match_pathspec() for this pattern matching,
> "git branch peff/" will not list all the topics under the peff/ hierarchy
> (your example "git branch peff/\*" would be the way), but I would imagine
> that we may someday want to update it to allow the leading path match
> here. And at that point, distinction between
> 
> 	git branch peff  ;# to create a "peff" branch
>         git branch peff/ ;# to list "peff/" branches, as "peff/" itself is
>         		 ;# an invalid branch name and your auto listing
>                          ;# heuristic kicks in
> 
> while it might be very useful for experts, becomes too subtle and would
> confuse new people. We should instead require an explicit -l/--list, and
> not use the auto listing heuristics (it is fine for -v to imply -l).

Sorry, I'm atrociously behind on reviewing this topic. But FWIW, I
completely agree with this. Detecting invalid branch formats is much too
subtle and error prone, and we are better off making a short and
easy-to-type version of "--list".

-Peff
