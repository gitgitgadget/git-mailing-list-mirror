From: Jeff King <peff@peff.net>
Subject: Re: 'git log' escape symbols shown as ESC[33 and ESC[m
Date: Thu, 16 Jan 2014 21:32:05 -0500
Message-ID: <20140117023205.GA13023@sigill.intra.peff.net>
References: <52D87A79.6060600@rawbw.com>
 <20140117014758.GF7249@sigill.intra.peff.net>
 <52D88F30.4000807@rawbw.com>
 <20140117021320.GA12444@sigill.intra.peff.net>
 <52D8953A.8010307@rawbw.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Yuri <yuri@rawbw.com>
X-From: git-owner@vger.kernel.org Fri Jan 17 03:32:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W3zED-0005Fl-Is
	for gcvg-git-2@plane.gmane.org; Fri, 17 Jan 2014 03:32:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751770AbaAQCcI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jan 2014 21:32:08 -0500
Received: from cloud.peff.net ([50.56.180.127]:33925 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751310AbaAQCcH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jan 2014 21:32:07 -0500
Received: (qmail 9685 invoked by uid 102); 17 Jan 2014 02:32:07 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 16 Jan 2014 20:32:07 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 16 Jan 2014 21:32:05 -0500
Content-Disposition: inline
In-Reply-To: <52D8953A.8010307@rawbw.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240563>

On Thu, Jan 16, 2014 at 06:28:10PM -0800, Yuri wrote:

> On 01/16/2014 18:13, Jeff King wrote:
> >Interesting. I take it that "more" does not pass through ANSI codes at
> >all, then.
> 
> Actually, 'more -R' also passes colors on FreeBSD. So maybe you can
> always add -R if PAGER=more on *BSD (any of them) ? This will fix
> this issue.

Ah, if "more" can handle the colors, then that is preferable.

I do think it would have to be system-specific, though. Unlike "less",
there are many implementations of "more", and quite a lot of them will
probably not support colors. We can make it a build-time option, and
set it to "on" for FreeBSD.

> I know, it is unpleasant when you add some new minor feature (like
> term colors), and people begin to complain about some related issues.
> But turning colors off isn't a good approach also. App just needs to
> be smarter about when and how to use them.

Agreed. It is simply that most people seem to either use "less", or not
set their "PAGER" at all. I think FreeBSD is the exception here.

> I would go even further, and convey even more information with
> colors. For example, make all dates which are less than 24 hours red.

That's an orthogonal issue. I'm not sure I agree, but if you are
interested, feel free to prepare a patch, which will get some discussion
going.

-Peff
