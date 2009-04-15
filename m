From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Documentation/CodingGuidelines: improve header
	includes rules
Date: Wed, 15 Apr 2009 03:58:19 -0400
Message-ID: <20090415075819.GC23332@coredump.intra.peff.net>
References: <20090414003433.39cbdea2.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Nathaniel P Dawson <nathaniel.dawson@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Nanako Shiraishi <nanako3@lavabit.com>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Wed Apr 15 10:01:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lu02K-0006vb-B0
	for gcvg-git-2@gmane.org; Wed, 15 Apr 2009 10:00:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752812AbZDOH6Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Apr 2009 03:58:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752443AbZDOH6Y
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Apr 2009 03:58:24 -0400
Received: from peff.net ([208.65.91.99]:33282 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751911AbZDOH6Y (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Apr 2009 03:58:24 -0400
Received: (qmail 14705 invoked by uid 107); 15 Apr 2009 07:58:28 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 15 Apr 2009 03:58:28 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 15 Apr 2009 03:58:19 -0400
Content-Disposition: inline
In-Reply-To: <20090414003433.39cbdea2.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116595>

On Tue, Apr 14, 2009 at 12:34:33AM +0200, Christian Couder wrote:

> 	- The third one means that for example if we have "revision.h"
> 	that includes "diff.h" and "commit.h", then it's ok to include
> 	"revision.h" in a C file, only if at least one feature from
> 	"revision.h" is actually used in the C file.
> 
> 	It is not ok to include "revision.h" if features from "diff.h"
> 	and "commit.h" are used but no feature from "revision.h" is
> 	used.

Why? I thought the guiding principle mentioned earlier was "don't waste
programmers' time figuring out what should and shouldn't be included".

Sure, I would not expect somebody to include a header that is totally
unrelated, but it seems that most of the source files lazily include
cache.h just to get "everything".

Stripping unnecessary includes doesn't even speed up compilation, as our
Makefile overspecifies the header dependencies anyway.

-Peff
