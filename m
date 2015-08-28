From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 7/9] fetch: fetch submodules in parallel
Date: Fri, 28 Aug 2015 14:53:31 -0400
Message-ID: <20150828185330.GA18041@sigill.intra.peff.net>
References: <1440724495-708-8-git-send-email-sbeller@google.com>
 <CAGZ79kbTAVDVmw+MrXvky6tJWZcG97tT_KAxV7S-pKCiNqRp3g@mail.gmail.com>
 <20150828170141.GB8165@google.com>
 <xmqqfv332v84.fsf@gitster.mtv.corp.google.com>
 <20150828182008.GC8165@google.com>
 <xmqqpp271d6v.fsf@gitster.mtv.corp.google.com>
 <20150828183501.GA17222@sigill.intra.peff.net>
 <CAGZ79kZALSJ9oY+6ZwyQ9CPFiV-AAq7c-r9mxw3N+gvsDw8m4A@mail.gmail.com>
 <20150828184405.GA17721@sigill.intra.peff.net>
 <20150828185050.GF8165@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 28 20:53:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZVOmV-0001Zt-P9
	for gcvg-git-2@plane.gmane.org; Fri, 28 Aug 2015 20:53:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752361AbbH1Sxe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Aug 2015 14:53:34 -0400
Received: from cloud.peff.net ([50.56.180.127]:51670 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751725AbbH1Sxe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Aug 2015 14:53:34 -0400
Received: (qmail 26021 invoked by uid 102); 28 Aug 2015 18:53:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 28 Aug 2015 13:53:33 -0500
Received: (qmail 6984 invoked by uid 107); 28 Aug 2015 18:53:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 28 Aug 2015 14:53:35 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 28 Aug 2015 14:53:31 -0400
Content-Disposition: inline
In-Reply-To: <20150828185050.GF8165@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276755>

On Fri, Aug 28, 2015 at 11:50:50AM -0700, Jonathan Nieder wrote:

> > But what I meant was: the child will only show progress if stderr is a
> > tty, but here it is not.
> 
> For clone / fetch, we can pass --progress explicitly.
> 
> For some reason 'git checkout' doesn't support a --progress option.  I
> suppose it should. ;-)

Yeah, that will work for those tools, but I thought you could pass
arbitrary shell commands.  It would be nice if git sub-commands run
through those just magically worked, even though we don't have an
opportunity to change their command-line parameters.

-Peff
