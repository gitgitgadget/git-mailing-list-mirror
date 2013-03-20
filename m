From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] index-pack: always zero-initialize object_entry list
Date: Wed, 20 Mar 2013 15:13:27 -0400
Message-ID: <20130320191327.GA31383@sigill.intra.peff.net>
References: <20130319102422.GB6341@sigill.intra.peff.net>
 <20130319105852.GA15182@sigill.intra.peff.net>
 <8738vr5rqh.fsf@pctrast.inf.ethz.ch>
 <20130319154353.GA10010@sigill.intra.peff.net>
 <20130319155244.GA16532@sigill.intra.peff.net>
 <20130319161722.GA17445@sigill.intra.peff.net>
 <CAPig+cQobu8GoqSNjVw8498e8D3vEJKU+UVUqkYbwypLyPTNhQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Rast <trast@inf.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>,
	Stefan Zager <szager@google.com>,
	Git List <git@vger.kernel.org>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Mar 20 20:14:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UIOSY-00058b-9q
	for gcvg-git-2@plane.gmane.org; Wed, 20 Mar 2013 20:14:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757791Ab3CTTNe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Mar 2013 15:13:34 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:60427 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756079Ab3CTTNe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Mar 2013 15:13:34 -0400
Received: (qmail 11737 invoked by uid 107); 20 Mar 2013 19:15:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 20 Mar 2013 15:15:17 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Mar 2013 15:13:27 -0400
Content-Disposition: inline
In-Reply-To: <CAPig+cQobu8GoqSNjVw8498e8D3vEJKU+UVUqkYbwypLyPTNhQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218661>

On Wed, Mar 20, 2013 at 03:12:07PM -0400, Eric Sunshine wrote:

> On Tue, Mar 19, 2013 at 12:17 PM, Jeff King <peff@peff.net> wrote:
> > To ensure that all depths start at 0, that commit changed
> > calls to xmalloc the object_entry list into calls to
> > xcalloc.  However, it forgot that we grow the list with
> > xrealloc later. These extra entries are used when we add an
> > object from elsewhere pack to complete a thin pack. If we
> 
> s/elsewhere pack/pack/

I think it is supposed to be s/elsewhere pack/elsewhere/.

Thanks for noticing.

-Peff
