From: Jeff King <peff@peff.net>
Subject: Re: [BUG] in rev-parse
Date: Sat, 17 Dec 2011 07:02:10 -0500
Message-ID: <20111217120210.GB31152@sigill.intra.peff.net>
References: <20111214184926.GB18335@llunet.cs.wisc.edu>
 <20111214210157.GA8990@sigill.intra.peff.net>
 <7vk45yplkm.fsf@alter.siamese.dyndns.org>
 <20111215070521.GB1327@sigill.intra.peff.net>
 <4EEA7A7E.4070109@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, nathan.panike@gmail.com,
	git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Sat Dec 17 13:02:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rbsy3-00080Z-82
	for gcvg-git-2@lo.gmane.org; Sat, 17 Dec 2011 13:02:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752116Ab1LQMCP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Dec 2011 07:02:15 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:44853
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752073Ab1LQMCO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Dec 2011 07:02:14 -0500
Received: (qmail 13716 invoked by uid 107); 17 Dec 2011 12:08:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 17 Dec 2011 07:08:56 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 17 Dec 2011 07:02:10 -0500
Content-Disposition: inline
In-Reply-To: <4EEA7A7E.4070109@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187380>

On Thu, Dec 15, 2011 at 11:53:50PM +0100, Michael Haggerty wrote:

> I believe that the OP was more inconvenienced that "git rev-parse
> --short" chokes on multiple objects than by the fact that it insists
> that the objects exist.  (And shortening the SHA1s of non-existent
> objects doesn't sound very useful anyway.)  So I think that a useful
> compromise would be for "git rev-parse --short" to accept multiple args
> but continue to insist that each of the args is a valid object.

Part of the guarantee of "--verify" is that it returns a single object.
I don't know how many callers rely on "--short" implying "--verify"
implying a single object.

I agree in practice it would probably be an OK change, and it's very
easy to do. I just don't think it's an important enough problem to worry
about, given the available workaround. But if you want to write the
patch, be my guest. :)

-Peff
