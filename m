From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv2 04/10] pkt-line: change error message for oversized
 packet
Date: Wed, 20 Feb 2013 03:47:54 -0500
Message-ID: <20130220084754.GA17055@sigill.intra.peff.net>
References: <20130218091203.GB17003@sigill.intra.peff.net>
 <20130218092221.GD5096@sigill.intra.peff.net>
 <7vd2vyarjy.fsf@alter.siamese.dyndns.org>
 <20130218094959.GA16408@sigill.intra.peff.net>
 <7v1ucdb9gw.fsf@alter.siamese.dyndns.org>
 <20130218213331.GA29200@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 20 09:48:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U85Lh-0001qq-3h
	for gcvg-git-2@plane.gmane.org; Wed, 20 Feb 2013 09:48:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758869Ab3BTIr5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Feb 2013 03:47:57 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:53573 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752454Ab3BTIr4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Feb 2013 03:47:56 -0500
Received: (qmail 8080 invoked by uid 107); 20 Feb 2013 08:49:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 20 Feb 2013 03:49:28 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Feb 2013 03:47:54 -0500
Content-Disposition: inline
In-Reply-To: <20130218213331.GA29200@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216694>

On Mon, Feb 18, 2013 at 04:33:31PM -0500, Jeff King wrote:

> On Mon, Feb 18, 2013 at 01:25:35PM -0800, Junio C Hamano wrote:
> 
> > Jeff King <peff@peff.net> writes:
> > 
> > > But it's easy to do (1), and it starts the clock ticking for
> > > the 1000-byte readers to become obsolete.
> > 
> > Yup, I agree with that goal.
> 
> Having just looked at the pkt-line callers a lot, I think most of them
> could go for something like:
> [...]
> 
> That would actually simplify the callers a bit, and would harmonize the
> buffer sizes at the same time. I'll look into doing a series tonight.

Just a quick update on this series. It ended up taking more nights than
I thought. :) The result looks much better than what I posted before, and
I found several other corner cases and bugs in packet parsing, too.

I'm going to hold off on posting it tonight, as I'm now up to 19
patches, and after several rounds of "rebase -i", I need to give it a
final read-through myself before inflicting it on anyone else. I'll do
that and post it tomorrow.

In the meantime, please hold off on what I've posted so far (that
includes the jk/smart-http-robustify topic).

-Peff
