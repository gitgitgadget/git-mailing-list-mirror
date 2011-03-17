From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] pretty.c: Make user defined format honor color option
Date: Thu, 17 Mar 2011 15:49:53 -0400
Message-ID: <20110317194952.GF20508@sigill.intra.peff.net>
References: <4D81C741.8060108@secunet.com>
 <1300354791.3269.19.camel@wpalmer.simply-domain>
 <4D81F860.2070703@secunet.com>
 <1300366792.3269.24.camel@wpalmer.simply-domain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Egerer <thomas.egerer@secunet.com>, git@vger.kernel.org
To: Will Palmer <wmpalmer@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 17 20:50:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0JCp-0005KN-Pe
	for gcvg-git-2@lo.gmane.org; Thu, 17 Mar 2011 20:50:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754331Ab1CQTtz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Mar 2011 15:49:55 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:34773
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752188Ab1CQTty (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Mar 2011 15:49:54 -0400
Received: (qmail 26798 invoked by uid 107); 17 Mar 2011 19:50:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 17 Mar 2011 15:50:29 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 17 Mar 2011 15:49:53 -0400
Content-Disposition: inline
In-Reply-To: <1300366792.3269.24.camel@wpalmer.simply-domain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169267>

On Thu, Mar 17, 2011 at 12:59:52PM +0000, Will Palmer wrote:

> Perhaps --color=auto, specified on the command-line, should behave
> differently to the various color options specified via config. That
> might make both sides happy, as one could always specify --color=auto to
> explicitly tell git to only color if it thinks it should.
> 
> Can anyone else refresh my memory regarding the use-case where
> hand-specified colors really should have an effect even with
> --color=never?

Without doing any digging on the list and just from the top of my head,
I don't think it was ever really an intentional feature that format
should ignore color settings. It simply wasn't bothered with because in
the beginning, the only way to specify a format was on the command line.
Now as we see them used in aliases, it probably makes sense to respect
the color setting. If one wants the current behavior, they can always
use --color=always.

So I think the intent of Thomas' patch is a good change, though I
haven't really looked closely at the patch itself.

-Peff
