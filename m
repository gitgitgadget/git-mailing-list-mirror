From: Jeff King <peff@peff.net>
Subject: Re: USE_NSEC bug?
Date: Wed, 20 Mar 2013 14:30:50 -0400
Message-ID: <20130320183049.GB29609@sigill.intra.peff.net>
References: <CABFQKmP6=Thhph4Ug+4LOBmzsVK42qBQYW2QHw87QD3019n+Kw@mail.gmail.com>
 <20130320075344.GA8159@sigill.intra.peff.net>
 <7vppyuf1f5.fsf@alter.siamese.dyndns.org>
 <20130320170957.GA21350@sigill.intra.peff.net>
 <7v620mf05l.fsf@alter.siamese.dyndns.org>
 <CABFQKmONh2dQ+dkt3MsSXtFyKh5mnfK1fQVyw6Ez6aWajo=BDg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Andrew Rodland <andrew@cleverdomain.org>
X-From: git-owner@vger.kernel.org Wed Mar 20 19:31:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UINnH-0003HF-Ji
	for gcvg-git-2@plane.gmane.org; Wed, 20 Mar 2013 19:31:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757404Ab3CTSa5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Mar 2013 14:30:57 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:60350 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756159Ab3CTSa4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Mar 2013 14:30:56 -0400
Received: (qmail 10912 invoked by uid 107); 20 Mar 2013 18:32:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 20 Mar 2013 14:32:39 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Mar 2013 14:30:50 -0400
Content-Disposition: inline
In-Reply-To: <CABFQKmONh2dQ+dkt3MsSXtFyKh5mnfK1fQVyw6Ez6aWajo=BDg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218641>

On Wed, Mar 20, 2013 at 02:22:27PM -0400, Andrew Rodland wrote:

> I think it would be good if NO_NSEC and USE_ST_TIMESPEC were
> controlled by configure instead of config.mak, and it doesn't seem
> like too tall of an order.

There is no "instead of" here. The Makefile provides knobs which you can
tweak on the command-line or via config.mak, and the configure script is
expected to set any of those knobs it wants. But as most of the regular
developers do not use the configure script themselves, it is often
missing support for many of the knobs.

So I think your real complaint is "configure does not set NO_NSEC
properly", which is something worth fixing.

-Peff
