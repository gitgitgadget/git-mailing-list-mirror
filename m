From: Jeff King <peff@peff.net>
Subject: Re: git-cvsimport bug
Date: Wed, 28 Nov 2007 11:57:46 -0500
Message-ID: <20071128165746.GC20308@coredump.intra.peff.net>
References: <20071127150136.GA50697@orion.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Emanuele Giaquinta <e.giaquinta@glauco.it>
X-From: git-owner@vger.kernel.org Wed Nov 28 17:58:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxQEk-0007pj-9F
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 17:58:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758934AbXK1Q5u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2007 11:57:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758869AbXK1Q5u
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 11:57:50 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2898 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755171AbXK1Q5t (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2007 11:57:49 -0500
Received: (qmail 12088 invoked by uid 111); 28 Nov 2007 16:57:48 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 28 Nov 2007 11:57:48 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 28 Nov 2007 11:57:46 -0500
Content-Disposition: inline
In-Reply-To: <20071127150136.GA50697@orion.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66381>

On Tue, Nov 27, 2007 at 04:01:36PM +0100, Emanuele Giaquinta wrote:

> a call to git-cvsimport after a 'git-pack-refs --all' seems to mess up
> the origin branch, because the first new change is committed with no
> parent (git-cvsimport reports 'Parent ID (empty)').
> It does not happen if I disable loose refs pruning with --no-prune. A
> tiny test repo you can use to reproduce the problem is
> mextli.tomaw.net/~exg/lzf.tar. Is it expected?

Some of git-cvsimport is quite old, and it accesses the ref files
directly. It should be fairly easy to fix; I will post a patch in a few
minutes.

-Peff
