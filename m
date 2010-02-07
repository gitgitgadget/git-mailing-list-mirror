From: Jeff King <peff@peff.net>
Subject: Re: A generalization of git notes from blobs to trees - git
 metadata?
Date: Sun, 7 Feb 2010 14:18:36 -0500
Message-ID: <20100207191836.GA3185@coredump.intra.peff.net>
References: <2cfc40321002060532g4d22dd4dx403bf312708e1424@mail.gmail.com>
 <201002070236.12711.johan@herland.net>
 <7v1vgxlr9q.fsf@alter.siamese.dyndns.org>
 <20100207050255.GA17049@coredump.intra.peff.net>
 <7vsk9cdgpx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johan Herland <johan@herland.net>,
	Jon Seymour <jon.seymour@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 07 20:18:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NeCeZ-0006Ew-AG
	for gcvg-git-2@lo.gmane.org; Sun, 07 Feb 2010 20:18:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756579Ab0BGTSi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Feb 2010 14:18:38 -0500
Received: from peff.net ([208.65.91.99]:42336 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755973Ab0BGTSh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Feb 2010 14:18:37 -0500
Received: (qmail 22865 invoked by uid 107); 7 Feb 2010 19:18:42 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 07 Feb 2010 14:18:42 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 07 Feb 2010 14:18:36 -0500
Content-Disposition: inline
In-Reply-To: <7vsk9cdgpx.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139248>

On Sun, Feb 07, 2010 at 10:48:58AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > ... I think you would do better
> > to simply store a tree sha1 inside the note blob, and callers who were
> > interested in the tree contents could then dereference it and examine as
> > they saw fit.  The only caveat is that you need some way of telling git
> > that the referenced trees are reachable and not to be pruned.
> 
> Thanks for a good summary.  To paraphrase the idea, for the "pre-built
> binaries" use case, I could update the dodoc.sh script (in 'todo'---that
> is what autobuilds the html and man documentation and updates the
> corresponding branches at k.org when I push things out to the master
> branch) to add a note to the commit from 'master' the docs are generated
> from, and the note would say which commits on html and man branches
> correspond to that commit.  That way, the referenced "trees" are of course
> protected because they are reachable from html/man refs.
> 
> Right?

Yeah, I think that would work fine. I guess there are cases, though,
where somebody might not be keeping a linear history of noted trees in a
separate ref (the way you keep html/man refs). In which case they would
have to deal with the reachability problem separately. I can't think of
an example off the top of my head, though.

-Peff
