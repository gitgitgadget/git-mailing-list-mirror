From: Jeff King <peff@peff.net>
Subject: Re: `git-send-email' doesn't specify `Content-Type'
Date: Sun, 11 Nov 2007 03:41:17 -0500
Message-ID: <20071111084117.GC30299@sigill.intra.peff.net>
References: <87ode3klc7.fsf@chbouib.org> <Pine.LNX.4.64.0711100052290.4362@racer.site> <20071110101420.GA21353@bulgaria> <20071110122528.GA4977@atjola.homenet> <20071110123505.GA24445@bulgaria> <20071110125126.GA7261@atjola.homenet> <20071111083224.GA30299@sigill.intra.peff.net> <20071111083915.GA18021@bulgaria>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Ludovic =?iso-8859-1?Q?Court=E8s?= <ludo@chbouib.org>,
	git@vger.kernel.org
To: Brian Swetland <swetland@google.com>
X-From: git-owner@vger.kernel.org Sun Nov 11 09:41:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ir8Nt-00065x-2T
	for gcvg-git-2@gmane.org; Sun, 11 Nov 2007 09:41:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752980AbXKKIlV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2007 03:41:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752747AbXKKIlV
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Nov 2007 03:41:21 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1351 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751809AbXKKIlU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2007 03:41:20 -0500
Received: (qmail 30275 invoked by uid 111); 11 Nov 2007 08:41:19 -0000
Received: from c-24-125-35-113.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (24.125.35.113)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Sun, 11 Nov 2007 03:41:19 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 11 Nov 2007 03:41:17 -0500
Content-Disposition: inline
In-Reply-To: <20071111083915.GA18021@bulgaria>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64433>

On Sun, Nov 11, 2007 at 12:39:15AM -0800, Brian Swetland wrote:

> This issue with the encoding of the author got me thinking...
> 
> What happens if the metadata has utf8 content and the patch itself has 
> some *other* non-ascii encoding (some iso-latin variant perhaps).
> 
> Is there any way to deal with that situation sanely other than indicate
> that it's 8bit content and not specify an encoding?  Is that what
> happens currently?

The body has to be in one encoding, so at the time that you know both
encodings, you have to pick one and convert the data from the discarded
encoding into the used encoding.

-Peff
