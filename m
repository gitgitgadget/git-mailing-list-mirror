From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3] Documentation fix: git log -p does not imply -c.
Date: Mon, 7 Mar 2011 20:19:18 -0500
Message-ID: <20110308011917.GB21278@sigill.intra.peff.net>
References: <20110307191218.GA20930@sigill.intra.peff.net>
 <1299535063-1020-1-git-send-email-haircut@gmail.com>
 <7vsjuyzckd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Adam Monsen <haircut@gmail.com>, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 08 02:19:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PwlaD-0004wa-UC
	for gcvg-git-2@lo.gmane.org; Tue, 08 Mar 2011 02:19:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755161Ab1CHBTZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Mar 2011 20:19:25 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:53216 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754427Ab1CHBTY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Mar 2011 20:19:24 -0500
Received: (qmail 10327 invoked by uid 111); 8 Mar 2011 01:19:24 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Tue, 08 Mar 2011 01:19:24 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 07 Mar 2011 20:19:18 -0500
Content-Disposition: inline
In-Reply-To: <7vsjuyzckd.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168628>

On Mon, Mar 07, 2011 at 04:21:54PM -0800, Junio C Hamano wrote:

> > +produced a 'combined diff' when showing a merge. This is the default
> 
> s/produced/produce/, I think.

Oops.

> > +format when showing merge conflicts with linkgit:git-diff[1] or a merge
> > +commit with linkgit:git-show[1]. Note also that you can view the full
> > +diff with the `-m` option.
> 
> This "Note" is a bit unclear what command it applies to, isn't it?  I know
> it applies to all the commands mentioned in the previous sentence in the
> paragraph, but we are not writing the documentation for me, so perhaps 
> 
> 	Note also that you can give the `-m' option to any of these
> 	commands to force generation of diffs with individual parents of a
> 	merge.

Yeah, reading it again, I agree it is unclear. Yours is better.

> Also -c and --cc are technically _not_ about "showing merge conflicts".
> It is about "showing a merge commit".  I don't know if we want to teach
> the distinction in this part of the document, though.

Yeah, I almost said that, but I couldn't figure out a way to convince
"git diff" to show me a merge commit, and clearly it is one of the
interesting commands to mention as "defaults to --cc". Again, I think
this section would be better as "This is what combined diff looks like"
and leave the discussion of "this is how and when you trigger combined
diff" to the individual command manpages. But that is a much bigger
cleanup.

> If you resolve a conflicted merge taking the results from only one side
> for a given hunk, --cc won't show anything.  If on the other hand, you
> futz with a clean merge so that your result does not match with any
> parent, --cc will show it.

Right, that's the same as "diff-tree --cc" would show if you committed
it, no? Which makes sense to me.

-Peff
