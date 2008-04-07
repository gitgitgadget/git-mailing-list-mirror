From: Jeff King <peff@peff.net>
Subject: Re: Achieving efficient storage of weirdly structured repos
Date: Sun, 6 Apr 2008 20:18:34 -0400
Message-ID: <20080407001833.GA16558@sigill.intra.peff.net>
References: <7BE3E865-C30D-49B8-A1D9-898109514990@sun.com> <alpine.LFD.1.00.0804031402530.14670@woody.linux-foundation.org> <1207351858.13123.52.camel@work.sfbay.sun.com> <alpine.LFD.1.00.0804041634180.14670@woody.linux-foundation.org> <4A31E284-E7F1-4748-A2CB-D8682748D3D6@sun.com> <alpine.LFD.1.00.0804051729230.11277@woody.linux-foundation.org> <20080406161003.GA24358@coredump.intra.peff.net> <alpine.LFD.1.00.0804062000240.2947@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Roman Shaposhnik <rvs@sun.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Mon Apr 07 02:19:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jif59-0007DC-KJ
	for gcvg-git-2@gmane.org; Mon, 07 Apr 2008 02:19:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755516AbYDGASh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Apr 2008 20:18:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755501AbYDGASh
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Apr 2008 20:18:37 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4598 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755495AbYDGASg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Apr 2008 20:18:36 -0400
Received: (qmail 26199 invoked by uid 111); 7 Apr 2008 00:18:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Sun, 06 Apr 2008 20:18:35 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 06 Apr 2008 20:18:34 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.00.0804062000240.2947@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78943>

On Sun, Apr 06, 2008 at 08:13:10PM -0400, Nicolas Pitre wrote:

> Well, in your example, the large image part should already be common to 
> many objects due to deltas if they're really the same: different objects 
> will only have different EXIF data plus a delta reference to the same 
> base image object. So in a way the split is already there.  Needs only 
> that some applications exploit this information at runtime.

Yes, the resulting packfiles find the deltas and are pretty efficient
(although it is quite slow to pack).  However, the delta information is
not used at all for inexact rename detection. Are you proposing to make
that information available to the rename detector?

-Peff
