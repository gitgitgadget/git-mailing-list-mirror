From: Jeff King <peff@peff.net>
Subject: Re: How do I run tests under Valgrind?
Date: Sat, 22 Sep 2012 13:47:42 -0400
Message-ID: <20120922174741.GA6722@sigill.intra.peff.net>
References: <20120917173531.GB1179@sigill.intra.peff.net>
 <CALkWK0kDPGY_3v5SLPtyf+azUwA7msvQOvA+MaCgueZ71i2yGw@mail.gmail.com>
 <20120917174439.GD1179@sigill.intra.peff.net>
 <CALkWK0mkBbY7dUyaZAqqKE3ZMfE_xU6em_KCOKM9nsTjUP-9pA@mail.gmail.com>
 <20120917182957.GF1179@sigill.intra.peff.net>
 <CALkWK0=nMxNfmAaBTmXeADQubTayC_2_ut5Nq3QXba9yfQr9yA@mail.gmail.com>
 <CALkWK0kWvrirPjXXzBBBQxKDcwpd_+nQ2eeT6SE8gDFW5T7WFQ@mail.gmail.com>
 <505CCA55.6030609@gmail.com>
 <20120921204907.GA22977@sigill.intra.peff.net>
 <505DB73E.2020108@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>
To: Stefano Lattarini <stefano.lattarini@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 22 19:48:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TFTom-0007vx-9i
	for gcvg-git-2@plane.gmane.org; Sat, 22 Sep 2012 19:48:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753143Ab2IVRsK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Sep 2012 13:48:10 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:54634 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753095Ab2IVRrt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Sep 2012 13:47:49 -0400
Received: (qmail 17628 invoked by uid 107); 22 Sep 2012 17:48:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 22 Sep 2012 13:48:13 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 22 Sep 2012 13:47:42 -0400
Content-Disposition: inline
In-Reply-To: <505DB73E.2020108@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206208>

On Sat, Sep 22, 2012 at 03:03:58PM +0200, Stefano Lattarini wrote:

> On 09/21/2012 10:49 PM, Jeff King wrote:
> >
> > Oh. It sounds like setting $SHELL to zsh is really the problem, then. If
> > it is not Bourne-compatible when called as "zsh", then it really should
> > be called in a way that turns on compatibility mode (bash will do this
> > when called as "sh", but you can also do it with "bash --posix").
> >
> AFAIK, if Zsh is called as "sh", it too will run in Bourne compatibility
> mode; not sure how to force this compatibility from the command line though
> (albeit I'd guess there is some way to do so).
> [...]

Thanks for digging. I think this case, though, is that we were simply
using the wrong variable ($SHELL instead of $SHELL_PATH). Your
workarounds would help if somebody put zsh into $SHELL_PATH, but
fundamentally that is not a sane thing to be doing, so I think we can
just consider doing so user error and not bother working around it.

-Peff
