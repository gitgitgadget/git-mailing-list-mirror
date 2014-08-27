From: Jeff King <peff@peff.net>
Subject: Re: mktree: multiple same-named objects
Date: Wed, 27 Aug 2014 12:24:25 -0400
Message-ID: <20140827162425.GA1432@peff.net>
References: <1409114517.13351.6.camel@leckie>
 <20140827051341.GB32141@peff.net>
 <xmqqk35uezd0.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: David Turner <dturner@twopensource.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git mailing list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 27 18:25:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMg1o-0004Kv-Tn
	for gcvg-git-2@plane.gmane.org; Wed, 27 Aug 2014 18:24:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935235AbaH0QY2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2014 12:24:28 -0400
Received: from cloud.peff.net ([50.56.180.127]:60148 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S935223AbaH0QY1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2014 12:24:27 -0400
Received: (qmail 8085 invoked by uid 102); 27 Aug 2014 16:24:27 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 27 Aug 2014 11:24:27 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 27 Aug 2014 12:24:25 -0400
Content-Disposition: inline
In-Reply-To: <xmqqk35uezd0.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256006>

On Wed, Aug 27, 2014 at 08:17:15AM -0700, Junio C Hamano wrote:

> I am somewhat against outright removing the capability to write out
> invalid objects deliberately from these low level tools, because we
> would need a way to easily reproduce bugs in end-user facing tools
> by other people who claim to produce Git objects, but I would agree
> that by default that should be forbidden.
> 
> In other words, two things must happen; improve checks when these
> low level debugging aid tools are creating objects, and allow
> bypassing these additional checks with "--experiment" option or
> something.

Yeah, definitely. I had imagined it as "--strict" and "--no-strict",
with flipping the default to "--strict" at some point (I do not see a
reason anybody would not want it in normal use, but if we are worried,
we can even go slowly on flipping the default).

-Peff
