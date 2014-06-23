From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv3 0/5] verify-commit: verify commit signatures
Date: Mon, 23 Jun 2014 17:09:31 -0400
Message-ID: <20140623210930.GB15766@sigill.intra.peff.net>
References: <cover.1402655838.git.git@drmicha.warpmail.net>
 <cover.1403506792.git.git@drmicha.warpmail.net>
 <20140623172805.GD4838@sigill.intra.peff.net>
 <xmqq61jrcy3d.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 23 23:09:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WzBUf-0006ka-Gj
	for gcvg-git-2@plane.gmane.org; Mon, 23 Jun 2014 23:09:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754115AbaFWVJd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2014 17:09:33 -0400
Received: from cloud.peff.net ([50.56.180.127]:49861 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751212AbaFWVJc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2014 17:09:32 -0400
Received: (qmail 14243 invoked by uid 102); 23 Jun 2014 21:09:32 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 23 Jun 2014 16:09:32 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 23 Jun 2014 17:09:31 -0400
Content-Disposition: inline
In-Reply-To: <xmqq61jrcy3d.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252369>

On Mon, Jun 23, 2014 at 10:52:38AM -0700, Junio C Hamano wrote:

> > The one thing that does give me pause is that we do not seem to have any
> > way of accessing mergetag signatures. We should perhaps stop and think
> > for a second about how we might expose those (and whether it would fit
> > into the "git-verify-{commit,tag}" paradigm). I am tempted to say that
> > "git verify-tag" on a commit should verify the mergetag (right now it
> > would simply be an error). But I haven't though that hard on it.
> 
> I agree that "verify-commit" that lives next to "verify-tag" is fine
> and does not have to wait for a unified "verify" that may not even
> be a good idea, but if we were to verify the mergetags in one of
> these "verify-$OBJECTTYPE" commands, I would think "verify-commit"
> should be the one to check them, for the simple reason that they
> appear in "commit" objects, not in "tag" objects.

My thinking was the opposite: it is a signature on a tag, but that
signature happens to be stuffed into a commit object. But I do not have
a strong feeling either way.

-Peff
