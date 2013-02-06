From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Verify Content-Type from smart HTTP servers
Date: Wed, 6 Feb 2013 17:47:01 -0500
Message-ID: <20130206224701.GH27507@sigill.intra.peff.net>
References: <7v38xhf1i3.fsf@alter.siamese.dyndns.org>
 <51122F69.9060704@elegosoft.com>
 <20130206103952.GA5267@sigill.intra.peff.net>
 <7v4nhpo2qv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Schubert <mschub@elegosoft.com>,
	Shawn Pearce <spearce@spearce.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 06 23:47:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3Dm5-0005Xf-BF
	for gcvg-git-2@plane.gmane.org; Wed, 06 Feb 2013 23:47:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758005Ab3BFWrG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2013 17:47:06 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:37189 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756368Ab3BFWrF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2013 17:47:05 -0500
Received: (qmail 11707 invoked by uid 107); 6 Feb 2013 22:48:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 06 Feb 2013 17:48:31 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 06 Feb 2013 17:47:01 -0500
Content-Disposition: inline
In-Reply-To: <7v4nhpo2qv.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215658>

On Wed, Feb 06, 2013 at 07:56:08AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Is it worth having a strbuf_set* family of functions to match the
> > strbuf_add*? We seem to have these sorts of errors with strbuf from time
> > to time, and I wonder if that would make it easier (and more readable)
> > to do the right thing.
> 
> Possibly.
> 
> The callsite below may be a poor example, though; you would need the
> _reset() even if you change the _addstr() we can see in the context
> to _setstr() to make sure later strbuf_*(type) will start from a
> clean slate when !t anyway, no?

Ah, true. Let's not worry about it, then.

-Peff
