From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] Add an (optional, since expensive) test for >2g
	clones
Date: Thu, 5 Mar 2009 11:41:54 -0500
Message-ID: <20090305164153.GD4213@coredump.intra.peff.net>
References: <cover.1236268730u.git.johannes.schindelin@gmx.de> <96a26f3a883890b3e56c867e8183618784837d4d.1236268730u.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com,
	Johannes Sixt <j6t@kdbg.org>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Mar 05 17:47:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfGj7-0005ea-Gq
	for gcvg-git-2@gmane.org; Thu, 05 Mar 2009 17:47:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757108AbZCEQmA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Mar 2009 11:42:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757098AbZCEQl7
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Mar 2009 11:41:59 -0500
Received: from peff.net ([208.65.91.99]:59076 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756716AbZCEQl6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Mar 2009 11:41:58 -0500
Received: (qmail 32296 invoked by uid 107); 5 Mar 2009 16:41:58 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 05 Mar 2009 11:41:58 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 05 Mar 2009 11:41:54 -0500
Content-Disposition: inline
In-Reply-To: <96a26f3a883890b3e56c867e8183618784837d4d.1236268730u.git.johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112318>

On Thu, Mar 05, 2009 at 05:05:09PM +0100, Johannes Schindelin wrote:

> +	(while test $i -le $blobcount
> +	 do
> +		printf "Generating blob $i/$blobcount\r" >&2 &&
> +		printf "blob\nmark :$i\ndata $blobsize\n" &&
> +		#test-genrandom $i $blobsize &&
> +		printf "%-${blobsize}s" $i &&

Leftover cruft using genrandom? (I'm guessing you tried random at first
to avoid compression, but I think your pack.compression=0 technique is
more sensible).

-Peff
