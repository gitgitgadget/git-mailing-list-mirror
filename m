From: Jeff King <peff@peff.net>
Subject: Re: [PATCH resend] Do not create commits whose message contains NUL
Date: Wed, 14 Dec 2011 02:17:55 -0500
Message-ID: <20111214071755.GA19945@sigill.intra.peff.net>
References: <1323777368-19697-1-git-send-email-pclouds@gmail.com>
 <20111213175932.GA1663@sigill.intra.peff.net>
 <buomxavwwtq.fsf@dhlpc061.dev.necel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Miles Bader <miles@gnu.org>
X-From: git-owner@vger.kernel.org Wed Dec 14 08:18:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Raj6I-0004Qd-Ol
	for gcvg-git-2@lo.gmane.org; Wed, 14 Dec 2011 08:18:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753006Ab1LNHR6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Dec 2011 02:17:58 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:49947
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750996Ab1LNHR6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Dec 2011 02:17:58 -0500
Received: (qmail 27526 invoked by uid 107); 14 Dec 2011 07:24:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 14 Dec 2011 02:24:39 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 14 Dec 2011 02:17:55 -0500
Content-Disposition: inline
In-Reply-To: <buomxavwwtq.fsf@dhlpc061.dev.necel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187097>

On Wed, Dec 14, 2011 at 02:23:29PM +0900, Miles Bader wrote:

> Jeff King <peff@peff.net> writes:
> >      But maybe it would be nicer to say something like:
> >
> >        error: your commit message contains NUL characters.
> >        hint: This is often caused by using multibyte encodings such as
> >        hint: UTF-16. Please check your editor settings.
> 
> I think the error message with the hint is much better for users, but
> isn't the term "multibyte" a little misleading here?  It seems like
> it's really _wide_ encodings that are generally the culprit.

Yeah, wide is probably a better term. I'm not sure it is rigorously
defined anywhere, but in general I think it refers to the set of
encodings that do not care about the embedding of 8-bit ascii bytes as
subsets.

-Peff
