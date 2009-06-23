From: Jeff King <peff@peff.net>
Subject: Re: [BUG] malloc error when using large file.
Date: Tue, 23 Jun 2009 14:42:08 -0400
Message-ID: <20090623184208.GA8165@coredump.intra.peff.net>
References: <B03A893ADFE80748942D13AFAF2845190C2D5D388A@ITSVLEX06.it.maxim-ic.internal>
 <20090622211542.GA19364@coredump.intra.peff.net>
 <B03A893ADFE80748942D13AFAF2845190C2D5D3BDC@ITSVLEX06.it.maxim-ic.internal>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Emmanuel Puerto <emmanuel.puerto@maxim-ic.com>
X-From: git-owner@vger.kernel.org Tue Jun 23 20:43:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MJAxp-0007nT-Mj
	for gcvg-git-2@gmane.org; Tue, 23 Jun 2009 20:43:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755490AbZFWSmN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Jun 2009 14:42:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755353AbZFWSmL
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Jun 2009 14:42:11 -0400
Received: from peff.net ([208.65.91.99]:38647 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755313AbZFWSmJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jun 2009 14:42:09 -0400
Received: (qmail 13817 invoked by uid 107); 23 Jun 2009 18:43:59 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 23 Jun 2009 14:43:59 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 23 Jun 2009 14:42:08 -0400
Content-Disposition: inline
In-Reply-To: <B03A893ADFE80748942D13AFAF2845190C2D5D3BDC@ITSVLEX06.it.maxim-ic.internal>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122109>

On Tue, Jun 23, 2009 at 12:05:11AM -0700, Emmanuel Puerto wrote:

> Yes I have more that 2 Go available when a do it, and after this
> allocation error if I try to do a 'git add' with a 9Go file, I did not
> have any issue.

It may be that doing a whole bunch of files in one process is leading to
some memory fragmentation that doesn't let malloc get a contiguous 2G
slice. I'm not sure what else to suggest trying, except perhaps to
search the list archives for past discussions on memory fragmentation.

Maybe somebody else has suggestions.

-Peff
