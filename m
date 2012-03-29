From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] git: continue alias lookup on EACCES errors
Date: Thu, 29 Mar 2012 13:20:33 -0400
Message-ID: <20120329172033.GC12318@sigill.intra.peff.net>
References: <7vaa30wrjx.fsf@alter.siamese.dyndns.org>
 <20120328174841.GA27876@sigill.intra.peff.net>
 <20120328180404.GA9052@burratino>
 <7v1uocwpap.fsf@alter.siamese.dyndns.org>
 <20120328184014.GA8982@burratino>
 <20120328193909.GB29019@sigill.intra.peff.net>
 <20120328194516.GD8982@burratino>
 <20120328201851.GA29315@sigill.intra.peff.net>
 <20120328215704.GB10795@sigill.intra.peff.net>
 <CAH6sp9OcWUks_n1bD2n1KbePHeUX+FSY0+wLFu+zPik1Pwj3Aw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	James Pickens <jepicken@gmail.com>,
	Git ML <git@vger.kernel.org>
To: Frans Klaver <fransklaver@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 29 19:20:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDJ1f-0000yV-UA
	for gcvg-git-2@plane.gmane.org; Thu, 29 Mar 2012 19:20:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759747Ab2C2RUj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Mar 2012 13:20:39 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:39478
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759033Ab2C2RUh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Mar 2012 13:20:37 -0400
Received: (qmail 3322 invoked by uid 107); 29 Mar 2012 17:20:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 29 Mar 2012 13:20:37 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 29 Mar 2012 13:20:33 -0400
Content-Disposition: inline
In-Reply-To: <CAH6sp9OcWUks_n1bD2n1KbePHeUX+FSY0+wLFu+zPik1Pwj3Aw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194273>

On Thu, Mar 29, 2012 at 01:31:09PM +0200, Frans Klaver wrote:

> On Wed, Mar 28, 2012 at 11:57 PM, Jeff King <peff@peff.net> wrote:
> 
> > +static int exists_in_PATH(const char *file)
> [...]
> 
> I expect that if more post-mortem checking is done, this function is
> going to need a sibling that provides you with the first found entry
> in PATH, so you can do more checks on it.

It should be easy to write it that way. I'm not personally planning on
adding more checks, but I think it's worth considering future additions.

> One of the things I ran into while working on [1] is that quite some
> errors that are produced can also be caused by the interpreter.

Yeah, they can be confusing and hard to track down. I'll leave that
topic out of this round, and you can build on it if you like.

-Peff
