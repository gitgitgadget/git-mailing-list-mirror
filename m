From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-diff: Add --staged as a synonym for --cached.
Date: Wed, 12 Nov 2008 14:15:13 -0500
Message-ID: <20081112191512.GA21401@coredump.intra.peff.net>
References: <alpine.DEB.1.00.0810291804400.22125@pacific.mpi-cbg.de.mpi-cbg.de> <20081029171122.GA12167@sigill.intra.peff.net> <20081102123519.GA21251@atjola.homenet> <7vljw2yo93.fsf@gitster.siamese.dyndns.org> <20081103071420.GD10772@coredump.intra.peff.net> <32541b130811102004n54a47331v48ba8d299039897f@mail.gmail.com> <20081112083353.GB3817@coredump.intra.peff.net> <alpine.DEB.1.00.0811121205100.30769@pacific.mpi-cbg.de> <20081112110629.GA20473@coredump.intra.peff.net> <32541b130811120739t95455d8n9b8056a8033491c3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?QmrDtnJu?= Steinbrink <B.Steinbrink@gmx.de>,
	David Symonds <dsymonds@gmail.com>, git@vger.kernel.org,
	Stephan Beyer <s-beyer@gmx.net>
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 12 20:16:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0LCp-0000IV-Oa
	for gcvg-git-2@gmane.org; Wed, 12 Nov 2008 20:16:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752766AbYKLTPR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Nov 2008 14:15:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752203AbYKLTPR
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Nov 2008 14:15:17 -0500
Received: from peff.net ([208.65.91.99]:1404 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752072AbYKLTPP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Nov 2008 14:15:15 -0500
Received: (qmail 21508 invoked by uid 111); 12 Nov 2008 19:15:14 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 12 Nov 2008 14:15:14 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 12 Nov 2008 14:15:13 -0500
Content-Disposition: inline
In-Reply-To: <32541b130811120739t95455d8n9b8056a8033491c3@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100803>

On Wed, Nov 12, 2008 at 10:39:21AM -0500, Avery Pennarun wrote:

> > I thought about that at first, too, but the working tree is even more
> > painful. You would have to hash every changed file on the filesystem to
> > create the tree object.
> 
> Is that so bad?  You have to read all those files anyway in order to
> do a diff.

I don't know for sure, as I haven't tried it. But you would need to read
them twice (once to hash, and then once to diff) plus the extra
computation time of hashing. So assuming you have a decent cache, you
pay the disk access only once.

Maybe it would be negligible, but I would have to see numbers to be
convinced either way.

-Peff
