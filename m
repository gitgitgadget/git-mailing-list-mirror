From: Jeff King <peff@peff.net>
Subject: Re: git-archive and tar options
Date: Thu, 14 Jul 2011 17:25:02 -0400
Message-ID: <20110714212502.GA29848@sigill.intra.peff.net>
References: <ivla29$liu$1@dough.gmane.org>
 <20110714015656.GA20136@sigill.intra.peff.net>
 <4E1F2468.6080409@lsrfire.ath.cx>
 <20110714172718.GA21341@sigill.intra.peff.net>
 <7vei1s36bl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	Neal Kreitzinger <neal@rsss.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 14 23:25:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QhTPT-0001qU-Eb
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jul 2011 23:25:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932311Ab1GNVZH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jul 2011 17:25:07 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:33175
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932232Ab1GNVZE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2011 17:25:04 -0400
Received: (qmail 12642 invoked by uid 107); 14 Jul 2011 21:25:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 14 Jul 2011 17:25:29 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 14 Jul 2011 17:25:02 -0400
Content-Disposition: inline
In-Reply-To: <7vei1s36bl.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177179>

On Thu, Jul 14, 2011 at 02:23:10PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Couldn't you also do:
> >
> >   git archive --prefix=$prefix HEAD:$subdir >my.tar
> >
> > ? I guess that loses the pax header with the commit sha1 in it, though,
> > because you are feeding a straight tree instead of a commit.
> >
> > We didn't when git-archive was written, but these days we have
> > get_sha1_with_context to remember incidental things about an object we
> > look up. It should perhaps remember the commit (if any) we used to reach
> > a treeish, and then the above command line could still insert the pax
> > header.
> 
> Why?
> 
> The tree you are writing out that way look very different from what is
> recorded in the commit object. What's the point of introducing confusion
> by allowing many tarballs with different contents written from the same
> commits with such tweaks all labelled with the same pax header?

See my later message. I think it depends on how the embedded id is used.
Is it to say "this represents the tree of this git commit"? Or is it to
help people who later have a tarball and have no clue which commit it
might have come from?

I don't have a strong opinion either way. I've never used this feature
at all.

-Peff
