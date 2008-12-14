From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] pack-objects: don't use too many threads with few
	objects
Date: Sat, 13 Dec 2008 21:20:26 -0500
Message-ID: <20081214022025.GA22571@coredump.intra.peff.net>
References: <alpine.LFD.2.00.0812111524370.14328@xanadu.home> <20081213133238.GA6718@sigill.intra.peff.net> <alpine.LFD.2.00.0812131456040.30035@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Sun Dec 14 03:22:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LBgc5-00059K-Tc
	for gcvg-git-2@gmane.org; Sun, 14 Dec 2008 03:21:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752356AbYLNCU3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Dec 2008 21:20:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752357AbYLNCU2
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Dec 2008 21:20:28 -0500
Received: from peff.net ([208.65.91.99]:1527 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752334AbYLNCU2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Dec 2008 21:20:28 -0500
Received: (qmail 24228 invoked by uid 111); 14 Dec 2008 02:20:27 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sat, 13 Dec 2008 21:20:27 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 13 Dec 2008 21:20:26 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0812131456040.30035@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103044>

On Sat, Dec 13, 2008 at 03:06:40PM -0500, Nicolas Pitre wrote:

> If there are few objects to deltify, they might be split amongst threads 
> so that there is simply no other objects left to delta against within 
> the same thread.  Let's use the same 2*window treshold as used for the 
> final load balancing to allow extra threads to be created.
>
> This fixes the benign t5300 test failure.
 
I can confirm this fixes my t5300 failure. Thanks.

Tested-by: Jeff King <peff@peff.net>

-Peff
