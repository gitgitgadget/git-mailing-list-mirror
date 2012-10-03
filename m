From: Jeff King <peff@peff.net>
Subject: Re: upload-pack is slow with lots of refs
Date: Wed, 3 Oct 2012 14:55:42 -0400
Message-ID: <20121003185542.GA3635@sigill.intra.peff.net>
References: <CACBZZX70NTic2WtrXooTg+yBbiFFDAEX_Y-b=W=rAkcYKJ3T2g@mail.gmail.com>
 <20121003180324.GB27446@sigill.intra.peff.net>
 <7vobkj4cb4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 04 23:49:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJtIH-0001DP-6D
	for gcvg-git-2@plane.gmane.org; Thu, 04 Oct 2012 23:49:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933220Ab2JCSzp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2012 14:55:45 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:39345 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932723Ab2JCSzo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2012 14:55:44 -0400
Received: (qmail 11336 invoked by uid 107); 3 Oct 2012 18:56:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 03 Oct 2012 14:56:14 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 03 Oct 2012 14:55:42 -0400
Content-Disposition: inline
In-Reply-To: <7vobkj4cb4.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206923>

On Wed, Oct 03, 2012 at 11:53:35AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> >> Has there been any work on extending the protocol so that the client
> >> tells the server what refs it's interested in?
> >
> > I don't think so. It would be hard to do in a backwards-compatible way,
> > because the advertisement is the first thing the server says, before it
> > has negotiated any capabilities with the client at all.
> 
> That is being discussed but hasn't surfaced on the list.

Out of curiosity, how are you thinking about triggering such a new
behavior in a backwards-compatible way? Invoke git-upload-pack2, and
fall back to reconnecting to start git-upload-pack if it fails?

-Peff
