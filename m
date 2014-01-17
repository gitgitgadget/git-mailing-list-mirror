From: Jeff King <peff@peff.net>
Subject: Re: 'git log' escape symbols shown as ESC[33 and ESC[m
Date: Thu, 16 Jan 2014 22:21:51 -0500
Message-ID: <20140117032151.GA17311@sigill.intra.peff.net>
References: <52D87A79.6060600@rawbw.com>
 <20140117014758.GF7249@sigill.intra.peff.net>
 <52D88F30.4000807@rawbw.com>
 <20140117021320.GA12444@sigill.intra.peff.net>
 <20140117022921.GU18964@google.com>
 <20140117023548.GB13023@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Yuri <yuri@rawbw.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 17 04:22:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W400i-0007YZ-Bo
	for gcvg-git-2@plane.gmane.org; Fri, 17 Jan 2014 04:22:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751905AbaAQDVy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jan 2014 22:21:54 -0500
Received: from cloud.peff.net ([50.56.180.127]:33951 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751811AbaAQDVx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jan 2014 22:21:53 -0500
Received: (qmail 12272 invoked by uid 102); 17 Jan 2014 03:21:53 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 16 Jan 2014 21:21:53 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 16 Jan 2014 22:21:51 -0500
Content-Disposition: inline
In-Reply-To: <20140117023548.GB13023@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240568>

On Thu, Jan 16, 2014 at 09:35:48PM -0500, Jeff King wrote:

> I think we should make an effort to set MORE=R on FreeBSD. We can
> perhaps just set it unconditionally, and assume that primitive "more"
> will ignore it. And then assume that "more" will handle colors (either
> because of the R setting, or because it is too dumb to escape it).
> 
> I can prepare a patch series, but I happily no longer have any antique
> systems to test this kind of stuff on.

Meh. I figured I would have to go to an antique system to find breakage,
but it is easy to do it on Debian:

  $ MORE=R more
  more: unknown option -R

So we do need to make it conditional.

-Peff
