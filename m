From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] logging branch deletion to help recovering from mistakes
Date: Tue, 7 Dec 2010 13:39:31 -0500
Message-ID: <20101207183930.GA27340@sigill.intra.peff.net>
References: <7vlj42siu5.fsf@alter.siamese.dyndns.org>
 <AANLkTikbsyFUzZeu8R6yAND6spV6OnvYL08gYZ+ZgJCh@mail.gmail.com>
 <7vmxoiqeoq.fsf@alter.siamese.dyndns.org>
 <20101207170623.GB21749@sigill.intra.peff.net>
 <AANLkTimnp3xCHp_3E7ry-5OQL3PFnYh=H8PhfzMN307C@mail.gmail.com>
 <20101207182040.GA26770@sigill.intra.peff.net>
 <20101207182342.GA3725@spearce.org>
 <20101207183507.GA27277@sigill.intra.peff.net>
 <20101207183739.GB3725@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Dec 07 19:39:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQ2Rs-0005Bp-Q1
	for gcvg-git-2@lo.gmane.org; Tue, 07 Dec 2010 19:39:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753884Ab0LGSje (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Dec 2010 13:39:34 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:58974 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753841Ab0LGSjd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Dec 2010 13:39:33 -0500
Received: (qmail 27033 invoked by uid 111); 7 Dec 2010 18:39:33 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Tue, 07 Dec 2010 18:39:33 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 07 Dec 2010 13:39:31 -0500
Content-Disposition: inline
In-Reply-To: <20101207183739.GB3725@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163109>

On Tue, Dec 07, 2010 at 10:37:39AM -0800, Shawn O. Pearce wrote:

> Yes, you are right.  We should instead let the normal reflog expire
> action do its work here, and delete the empty log file when it is
> finally empty.
> 
> I guess we also need repack and prune to enumerate these deleted
> reflogs and retain the objects their records point to.

Definitely. I sort of assumed all of those things just traversed
.git/logs blindly without regard to whether there was a ref, which would
handle this automagically. But maybe that is not the case.

Is there a reason to require that each log is specifically tied to a
ref?

-Peff
