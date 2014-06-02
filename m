From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] sideband.c: Get rid of ANSI sequences for non-terminal
 shell
Date: Mon, 2 Jun 2014 02:30:00 -0400
Message-ID: <20140602062959.GA27254@sigill.intra.peff.net>
References: <81E85F13A4BE084BAF4B1AA24173EDA0144E14B7@JWPKEXMBX03.corp.checkfree.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
	"spearce@spearce.org" <spearce@spearce.org>,
	"j6t@kdbg.org" <j6t@kdbg.org>, "nico@cam.org" <nico@cam.org>,
	"junkio@cox.net" <junkio@cox.net>,
	"kusmabite@gmail.com" <kusmabite@gmail.com>,
	"mnaoumov@gmail.com" <mnaoumov@gmail.com>
To: "Naumov, Michael (North Sydney)" <Michael.Naumov@Fiserv.com>
X-From: git-owner@vger.kernel.org Mon Jun 02 08:31:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WrLm7-0001SJ-JT
	for gcvg-git-2@plane.gmane.org; Mon, 02 Jun 2014 08:31:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752299AbaFBGbL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jun 2014 02:31:11 -0400
Received: from cloud.peff.net ([50.56.180.127]:35705 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752067AbaFBGbL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jun 2014 02:31:11 -0400
Received: (qmail 31310 invoked by uid 102); 2 Jun 2014 06:31:10 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 02 Jun 2014 01:31:10 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 02 Jun 2014 02:30:00 -0400
Content-Disposition: inline
In-Reply-To: <81E85F13A4BE084BAF4B1AA24173EDA0144E14B7@JWPKEXMBX03.corp.checkfree.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250553>

On Fri, May 30, 2014 at 11:10:51PM +0000, Naumov, Michael (North Sydney) wrote:

> Some git tools such as GitExtensions for Windows use environment
> variable TERM=msys which causes the weird ANSI sequence shown for the
> messages returned from server-side hooks
> We add those ANSI sequences to help format sideband data on the user's
> terminal. However, GitExtensions is not using a terminal, and the ANSI
> sequences just confuses it. We can recognize this use by checking
> isatty().
> See https://github.com/gitextensions/gitextensions/issues/1313 for
> more details
> 
> NOTE: I considered to cover the case that a pager has already been
> started. But decided that is probably not worth worrying about here,
> though, as we shouldn't be using a pager for commands that do network
> communications (and if we do, omitting the magic line-clearing signal
> is probably a sane thing to do).
> 
> Signed-off-by: Michael Naumov <mnaoumov@gmail.com>
> Thanks-to: Erik Faye-Lund <kusmabite@gmail.com>
> Thanks-to: Jeff King <peff@peff.net>

This version looks fine to me.

-Peff
