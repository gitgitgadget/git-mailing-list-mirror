From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/4] Honor core.ignorecase for attribute patterns
Date: Thu, 15 Sep 2011 14:12:58 -0400
Message-ID: <20110915181258.GA1227@sigill.intra.peff.net>
References: <5XXEFw0WjtXKd9dpXSxpkskCcgVyG9Db1_zzVSEBNey-kpXSBbmQfYaxZ2Szg6Pbck6hZZTQ5hHzBwG4rhKYXshrdmveEFLPZ9W0V8P_lw@cipher.nrlssc.navy.mil>
 <1316051979-19671-1-git-send-email-drafnel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com,
	bharrosh@panasas.com, trast@student.ethz.ch, zapped@mail.ru
To: Brandon Casey <drafnel@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 15 20:13:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R4GQs-00008Y-H4
	for gcvg-git-2@lo.gmane.org; Thu, 15 Sep 2011 20:13:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934377Ab1IOSNA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Sep 2011 14:13:00 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:51970
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934271Ab1IOSNA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Sep 2011 14:13:00 -0400
Received: (qmail 24216 invoked by uid 107); 15 Sep 2011 18:13:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 15 Sep 2011 14:13:53 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 15 Sep 2011 14:12:58 -0400
Content-Disposition: inline
In-Reply-To: <1316051979-19671-1-git-send-email-drafnel@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181483>

On Wed, Sep 14, 2011 at 08:59:35PM -0500, Brandon Casey wrote:

> > I haven't even tested that it runs. :)  No, I was hoping someone
> > who was more interested would finish it, and maybe even test on
> > an affected system.
> 
> Ok, I lied.  Here's a series that needs testing by people on a
> case-insensitive filesystem and some comments.

Thanks. I was trying to decide if I was interested enough to work on it,
but procrastination wins again.

I'm not sure I understand why you need a case-insensitive file system
for the final set of tests. If we have a case-sensitive system, we can
force the filesystem to show us whatever cases we want, and check
against them with both core.ignorecase off and on[1]. What are these
tests checking that requires the actual behavior of a case-insensitive
filesystem?

I'm sure there is something subtle that I'm missing. Can you explain it
either here or in the commit message?

-Peff

[1] Actually, I wondered at first if the other tests needed to be marked
for only case-sensitive systems, since we can't rely on the behavior of
insensitive ones (e.g., are they case-preserving, always downcasing,
etc). But looking at t0003, we don't seem to actually create the files
in the filesystem at all.
