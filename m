From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCHv2] git-web--browse: avoid the use of eval
Date: Tue, 20 Sep 2011 14:49:39 -0400
Message-ID: <20110920184939.GA17322@sigill.intra.peff.net>
References: <20110918183846.GA31176@sigill.intra.peff.net>
 <1316424415-11156-1-git-send-email-judge.packham@gmail.com>
 <20110919183408.GB26115@sigill.intra.peff.net>
 <4E78572E.6030105@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	chriscool@tuxfamily.org, jepler@unpythonic.net
To: Chris Packham <judge.packham@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 20 20:49:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R65O6-0007rj-1B
	for gcvg-git-2@lo.gmane.org; Tue, 20 Sep 2011 20:49:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752584Ab1ITStl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Sep 2011 14:49:41 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:38369
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752411Ab1ITStl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Sep 2011 14:49:41 -0400
Received: (qmail 22426 invoked by uid 107); 20 Sep 2011 18:54:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 20 Sep 2011 14:54:39 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 20 Sep 2011 14:49:39 -0400
Content-Disposition: inline
In-Reply-To: <4E78572E.6030105@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181777>

On Tue, Sep 20, 2011 at 09:04:46PM +1200, Chris Packham wrote:

> > Although other projects do use "cc" in the commit message, I think we
> > don't usually bother adding this noise in the git project. The cc
> > headers in your email are enough.
> 
> That's more for git send-email's benefit than anything else. I'm working
> on a laptop with a touchpad (and a cat) so the less switching between
> editor and MUA the better. Any better suggestions for tracking Cc's for
> git send-email?

It would depend on your workflow, I think. You can use --cc to add
headers to format-patch. You could get very fancy and store them in
git-notes or somewhere else, and then pull them in with send-email's
cc-cmd option. But I suspect you just want to stick them in the commit
message one time and then have it used each time.

If put them after the double-dash line in your commit message, like:

  subject

  body
  ---
  cc: whoever

Then that will be included verbatim in the mail by format-patch,
send-email will respect the cc line, and those lines will be dropped by
"git am" when Junio applies the patch (they are still a slight noise to
readers of the mail, but at least they don't make it into the commit
history).

> The example in t/README has has a copyright notice which is why I put
> one in but I don't consider the test (or the fix itself) to actually be
> copyrightable. If I wasn't creating a new file I wouldn't have bothered
> putting anything in (other than the testcase).

Yeah, that's why I said I don't know if we have a policy. We clearly
have a lot of copyright statements, but they are all horribly out of
date. I was hoping Junio might weigh in.

-Peff
