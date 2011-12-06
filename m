From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Set hard limit on delta chain depth
Date: Tue, 6 Dec 2011 13:56:36 -0500
Message-ID: <20111206185636.GC9492@sigill.intra.peff.net>
References: <1323068688-31481-1-git-send-email-pclouds@gmail.com>
 <CABPQNSaE=TWGbBRMnthEuT181=XbOafPfgx88_JQnnQ6TiYyqw@mail.gmail.com>
 <4EDE2C95.5040804@alum.mit.edu>
 <CACsJy8Btwn0=PGS+PJV-6DqYBmzOp7LTB2=R_kCx4SJHA2YDRw@mail.gmail.com>
 <CAJo=hJuy27Uagmubbv=RqAOMx03e6JBgZxObkjFLg9oG2x_UqA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>, kusmabite@gmail.com,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Dec 06 19:56:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RY0C3-0005TM-BE
	for gcvg-git-2@lo.gmane.org; Tue, 06 Dec 2011 19:56:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751836Ab1LFS4j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Dec 2011 13:56:39 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:41445
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751320Ab1LFS4i (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Dec 2011 13:56:38 -0500
Received: (qmail 7113 invoked by uid 107); 6 Dec 2011 19:03:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 06 Dec 2011 14:03:16 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 06 Dec 2011 13:56:36 -0500
Content-Disposition: inline
In-Reply-To: <CAJo=hJuy27Uagmubbv=RqAOMx03e6JBgZxObkjFLg9oG2x_UqA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186369>

On Tue, Dec 06, 2011 at 10:12:54AM -0800, Shawn O. Pearce wrote:

> > Normal creators (i.e. C Git) use default depth 50 so we should be safe.
> 
> JGit is also a "normal creator", and it sometimes produces chains
> deeper than 50. Junio identified a 255 deep chain a week or two ago.
> Some people have repacked their repositories very aggressively with
> deeper chains when they are trying to optimize for space and don't
> access historical revisions very often. I doubt anyone has packed
> deeper than 120ish intentionally... but we shouldn't assume that in
> the code.

"git gc --aggressive" will set the depth to 250.

-Peff
