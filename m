From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/1] Add --first-parent support to interactive rebase.
Date: Thu, 1 Nov 2007 00:14:08 -0400
Message-ID: <20071101041408.GA18646@coredump.intra.peff.net>
References: <20071031055303.GB3326@atjola.homenet> <20071031134358.GD15182@dpotapov.dyndns.org> <20071031140028.GA30207@diana.vm.bytemark.co.uk> <20071031143641.GF15182@dpotapov.dyndns.org> <20071031180557.GA12211@coredump.intra.peff.net> <7v8x5jgdck.fsf@gitster.siamese.dyndns.org> <20071031215625.GC14211@coredump.intra.peff.net> <7vzlxygblz.fsf@gitster.siamese.dyndns.org> <20071101032303.GA14495@coredump.intra.peff.net> <7vabpyfvwp.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dmitry Potapov <dpotapov@gmail.com>,
	Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>,
	=?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>,
	Johannes.Schindelin@gmx.de, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 01 05:14:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InRRo-0007bv-4B
	for gcvg-git-2@gmane.org; Thu, 01 Nov 2007 05:14:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752179AbXKAEON (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Nov 2007 00:14:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751818AbXKAEOL
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Nov 2007 00:14:11 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3786 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751810AbXKAEOK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Nov 2007 00:14:10 -0400
Received: (qmail 2957 invoked by uid 111); 1 Nov 2007 04:14:09 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 01 Nov 2007 00:14:09 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 01 Nov 2007 00:14:08 -0400
Content-Disposition: inline
In-Reply-To: <7vabpyfvwp.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62913>

On Wed, Oct 31, 2007 at 09:10:30PM -0700, Junio C Hamano wrote:

> I think assuming utf-8 and reencoding is actively wrong.
> Existing setups of people with names that cannot be expressed in
> ASCII would already have the commit encoding specified in the
> configuration and user.name stored in that encoding, so passing
> things through as we have always done is the right thing to do.

That will break any time somebody uses -s with a --encoding= that is
different from their usual encoding. My patch assumes the source is
utf-8, but should perhaps assume some other default encoding from the
config.

But if this is not a problem for people, I'm not going to push it. I
don't actually use any of these features; it was just something I
noticed while looking at the actual bug.

-Peff
