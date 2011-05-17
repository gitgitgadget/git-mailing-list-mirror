From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC] config: Give error message when not changing a
 multivar
Date: Tue, 17 May 2011 10:07:25 -0400
Message-ID: <20110517140725.GA17193@sigill.intra.peff.net>
References: <42ab57ae5a2cb7d6860e43e7c3061f9c38cf1b99.1305632091.git.git@drmicha.warpmail.net>
 <20110517123840.GB13176@sigill.intra.peff.net>
 <4DD28014.4090505@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue May 17 16:07:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QMKvs-0000mw-DG
	for gcvg-git-2@lo.gmane.org; Tue, 17 May 2011 16:07:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754983Ab1EQOH1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 May 2011 10:07:27 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:54285
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754788Ab1EQOH1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 May 2011 10:07:27 -0400
Received: (qmail 27618 invoked by uid 107); 17 May 2011 14:09:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 17 May 2011 10:09:28 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 17 May 2011 10:07:25 -0400
Content-Disposition: inline
In-Reply-To: <4DD28014.4090505@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173800>

On Tue, May 17, 2011 at 04:03:00PM +0200, Michael J Gruber wrote:

> >> warning: remote.repoor.push has multiple values
> >> error: Use a regexp, --add or --set-all to change remote.repoor.push.
> [...]
> OK, makes sense, I just wanted to request for comments early enough -
> someone might think we should remove the warning from the present site
> and make all callers deal with the return codes. But I don't think it's
> worth it, and we have other places where we warn first, then error out.

You could maybe make it a little more clear what is going on with:

  warning: remote.repoor.push has multiple values
  error: cannot overwrite multiple values with a single value
         Use a regexp, --add, or --set-all to change remote.repoor.push

Then the error stands on its own, but the warning is not a bad thing to
have, also.

-Peff
