From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] log --oneline: put decoration at the end of the line
Date: Wed, 19 Sep 2012 16:05:26 -0400
Message-ID: <20120919200526.GA22650@sigill.intra.peff.net>
References: <1348055540-13774-1-git-send-email-pclouds@gmail.com>
 <20120919182039.GE11699@sigill.intra.peff.net>
 <7vr4pxg507.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 19 22:05:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TEQWg-0004YV-UY
	for gcvg-git-2@plane.gmane.org; Wed, 19 Sep 2012 22:05:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751408Ab2ISUF3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Sep 2012 16:05:29 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:49964 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751366Ab2ISUF2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Sep 2012 16:05:28 -0400
Received: (qmail 5025 invoked by uid 107); 19 Sep 2012 20:05:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 19 Sep 2012 16:05:53 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 19 Sep 2012 16:05:26 -0400
Content-Disposition: inline
In-Reply-To: <7vr4pxg507.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205990>

On Wed, Sep 19, 2012 at 12:57:28PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > We should also consider briefly whether anybody is relying on --oneline
> > for machine parsing. I think "log --oneline" is fair game, but I wonder
> > if people calling "rev-list --decorate --oneline" should be considered.
> > It seems kind of unlikely to me, considering that the decorate output is
> > ambiguous to parse anyway (if you see parentheses, you cannot tell if it
> > is decorate output or part of the commit subject).
> 
> Yeah, I do not think it is likely.  Among the in-tree scripts,
> git-stash does use rev-list --oneline but the purpose of the call
> exactly is to grab a human readable one line summary, and it will be
> happy with any change to make --oneline more human readble.

Yeah, that makes sense.

> t4202 has many invocations of "log --oneline --decorate", though;
> these things do get tested.

I think it is just trying to compare the "log.decorate" variable to the
"--decorate" command-line option. Notice that it generates the expected
output by running the latter. So I think it would be OK (and if not,
I think it would make sense to update the test, as it does not care
about the specific format).

Google Code Search doesn't show anything interesting, though I suppose
its results are getting continually out of date (they claim to have shut
it down, though you can still query it if you use the right URL).

-Peff
