From: Jeff King <peff@peff.net>
Subject: Re: Okay to invoke merge-recursive with an empty workdir?
Date: Mon, 12 Sep 2011 23:59:27 -0400
Message-ID: <20110913035927.GB4828@sigill.intra.peff.net>
References: <CAG+J_Dyz-aeLYn43ARTG4GJz0+zRw_RyDr80bmPCayd9BjzCwg@mail.gmail.com>
 <20110913032900.GA3296@sigill.intra.peff.net>
 <7v4o0h14gv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jay Soffian <jaysoffian@gmail.com>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 13 05:59:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3K9n-0008Gk-3h
	for gcvg-git-2@lo.gmane.org; Tue, 13 Sep 2011 05:59:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753974Ab1IMD7a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Sep 2011 23:59:30 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:47605
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753801Ab1IMD7a (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Sep 2011 23:59:30 -0400
Received: (qmail 22843 invoked by uid 107); 13 Sep 2011 04:00:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 13 Sep 2011 00:00:22 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Sep 2011 23:59:27 -0400
Content-Disposition: inline
In-Reply-To: <7v4o0h14gv.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181267>

On Mon, Sep 12, 2011 at 08:55:12PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I'm not sure if we were ever using merge-recursive like that. Especially
> > with Elijah's latest patches to handle worktree dirtiness better, I
> > wouldn't be surprised if it has issues.
> 
> I am parsing the above as "seeing the need for such an extensive fix-up,
> it is not surprising if the base code is broken", and I have to agree.

Well, both. I assume that merge-recursive now cares more than ever about
what is in the working tree, because I seem to recall Elijah handling
some cases with untracked files. And also, his patches have given me no
faith whatsoever in the quality of the underlying code. :)

> In principle, "git merge" should be usable in an empty working tree in the
> sense that with correctly populated index the absense of the working tree
> file is _meant_ to be treated the same as having the file unchanged from
> the index and the HEAD version, but I suspect that "merge-recursive" is
> pretty much broken with that regard.
> 
> I have much more faith in "git merge -s resolve" performing correctly.

Agreed, though I haven't tried it.

-Peff
