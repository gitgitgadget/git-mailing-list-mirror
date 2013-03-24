From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/4] transport: drop "int cmp = cmp" hack
Date: Sun, 24 Mar 2013 05:32:13 -0400
Message-ID: <20130324093212.GA28234@sigill.intra.peff.net>
References: <20130321110338.GA18552@sigill.intra.peff.net>
 <20130321111333.GD18819@sigill.intra.peff.net>
 <CAPc5daVOksx56js_ascEr348PTLAZB9OeBrf3sELJUpdyB_kMg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 24 10:33:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJhIV-0001Cy-I7
	for gcvg-git-2@plane.gmane.org; Sun, 24 Mar 2013 10:33:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753604Ab3CXJc1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Mar 2013 05:32:27 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:37749 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752382Ab3CXJc1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Mar 2013 05:32:27 -0400
Received: (qmail 14897 invoked by uid 107); 24 Mar 2013 09:34:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 24 Mar 2013 05:34:11 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 24 Mar 2013 05:32:13 -0400
Content-Disposition: inline
In-Reply-To: <CAPc5daVOksx56js_ascEr348PTLAZB9OeBrf3sELJUpdyB_kMg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218946>

On Sat, Mar 23, 2013 at 09:00:05PM -0700, Junio C Hamano wrote:

> On Thu, Mar 21, 2013 at 4:13 AM, Jeff King <peff@peff.net> wrote:
> >
> > According to 47ec794, this initialization is meant to
> > squelch an erroneous uninitialized variable warning from gcc
> > 4.0.1.  That version is quite old at this point, and gcc 4.1
> > and up handle it fine, with one exception. There seems to be
> > a regression in gcc 4.6.3, which produces the warning;
> > however, gcc versions 4.4.7 and 4.7.2 do not.
> >
> 
> transport.c: In function 'get_refs_via_rsync':
> transport.c:127:29: error: 'cmp' may be used uninitialized in this
> function [-Werror=uninitialized]
> transport.c:109:7: note: 'cmp' was declared here
> 
> gcc (Ubuntu/Linaro 4.6.3-1ubuntu5) 4.6.3

Right, that's the same version I noted above. Is 4.6.3 the default
compiler under a particular release of Ubuntu, or did you use their
gcc-4.6 package?

-Peff
