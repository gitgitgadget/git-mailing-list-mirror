From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 4/5] t3301: use test_must_fail instead of !
Date: Wed, 18 Feb 2009 05:16:15 -0500
Message-ID: <20090218101615.GA23035@coredump.intra.peff.net>
References: <8c50889d27e5baec1cbbd9a5775fa80b986c6df6.1234642638.git.trast@student.ethz.ch> <7vvdrcnnl0.fsf@gitster.siamese.dyndns.org> <200902151711.45099.trast@student.ethz.ch> <20090215181818.GA2291@coredump.intra.peff.net> <e2b179460902170129s7ae613cehe237619be5e84936@mail.gmail.com> <20090217163413.GB31297@sigill.intra.peff.net> <e2b179460902171000s605675dct1f499a9425c3ebb2@mail.gmail.com> <20090217202731.GA16586@coredump.intra.peff.net> <20090218064121.GA16611@coredump.intra.peff.net> <alpine.DEB.1.00.0902181113210.6274@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Mike Ralphson <mike.ralphson@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Feb 18 11:17:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZjUw-0003QF-08
	for gcvg-git-2@gmane.org; Wed, 18 Feb 2009 11:17:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751913AbZBRKQT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Feb 2009 05:16:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751905AbZBRKQS
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Feb 2009 05:16:18 -0500
Received: from peff.net ([208.65.91.99]:44318 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751898AbZBRKQS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Feb 2009 05:16:18 -0500
Received: (qmail 13177 invoked by uid 107); 18 Feb 2009 10:16:38 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 18 Feb 2009 05:16:38 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 18 Feb 2009 05:16:15 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0902181113210.6274@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110521>

On Wed, Feb 18, 2009 at 11:14:10AM +0100, Johannes Schindelin wrote:

> > I can now get as far as t3404, which seems to have problems due to
> > rebase-interactive using parentheses, "-a", and "-o" with "test".
> 
> The parentheses will be fixed soon, but "-a" and "-o" really are 
> necessary.

Really? Are they not easily replaced with

-test cond1 -a cond2 -o cond3
+test cond1 && test cond2 || test cond3

? The trickier part is the grouping, but that is what the parentheses
are doing.

-Peff
