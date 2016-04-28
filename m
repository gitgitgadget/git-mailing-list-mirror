From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v5 2/2] submodule: pass on http.extraheader config
 settings
Date: Thu, 28 Apr 2016 09:53:18 -0400
Message-ID: <20160428135317.GC25364@sigill.intra.peff.net>
References: <3b71deffa5d07cf73a793773cc3d60ff611843fa.1461759454.git.johannes.schindelin@gmx.de>
 <cover.1461837783.git.johannes.schindelin@gmx.de>
 <89d0024450b0e6e9997ad9e3d681248bde1bafc0.1461837783.git.johannes.schindelin@gmx.de>
 <20160428112912.GB11522@sigill.intra.peff.net>
 <alpine.DEB.2.20.1604281405540.2896@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jacob Keller <jacob.keller@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Apr 28 15:53:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avmNh-0002E8-TL
	for gcvg-git-2@plane.gmane.org; Thu, 28 Apr 2016 15:53:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752194AbcD1NxV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2016 09:53:21 -0400
Received: from cloud.peff.net ([50.56.180.127]:58337 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751578AbcD1NxU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2016 09:53:20 -0400
Received: (qmail 26329 invoked by uid 102); 28 Apr 2016 13:53:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 28 Apr 2016 09:53:20 -0400
Received: (qmail 9754 invoked by uid 107); 28 Apr 2016 13:53:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 28 Apr 2016 09:53:22 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 28 Apr 2016 09:53:18 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1604281405540.2896@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292884>

On Thu, Apr 28, 2016 at 02:19:37PM +0200, Johannes Schindelin wrote:

> > Should we consider just white-listing all of "http.*"?
> > 
> > That would help other cases which have come up, like:
> > 
> >   http://thread.gmane.org/gmane.comp.version-control.git/264840
> > 
> > which wants to turn off http.sslverify. That would mean it turns off for
> > every submodule, too, but if you want to be choosy about your http
> > variables, you should be using the "http.$URL.sslverify" form, to only
> > affect specific servers (whether they are in submodules or not).
> 
> I considered that, and thought that it might be dangerous, what with me
> not vetting carefully which http.* variables are safe to pass on to the
> submodules' update and which are not.

BTW, just in case you or anybody else ends up playing around with this
and finds your tests do not work as expected: the config pass-through
feature is somewhat broken for anything except cloning. I just posted
some fixes in:

  http://thread.gmane.org/gmane.comp.version-control.git/292466/focus=292875

-Peff
