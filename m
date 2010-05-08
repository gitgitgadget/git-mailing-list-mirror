From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC] Add [] as an alias for a reference to the empty
 tree
Date: Sat, 8 May 2010 01:34:05 -0400
Message-ID: <20100508053405.GH14998@coredump.intra.peff.net>
References: <1273250247-20762-1-git-send-email-pkj@axis.com>
 <20100508045319.GD14998@coredump.intra.peff.net>
 <7vhbmjc6dy.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Peter Kjellerstedt <peter.kjellerstedt@axis.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 08 07:34:17 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OAcg3-0007Ot-NW
	for gcvg-git-2@lo.gmane.org; Sat, 08 May 2010 07:34:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751258Ab0EHFeJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 May 2010 01:34:09 -0400
Received: from peff.net ([208.65.91.99]:43543 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751201Ab0EHFeI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 May 2010 01:34:08 -0400
Received: (qmail 2964 invoked by uid 107); 8 May 2010 05:34:22 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 08 May 2010 01:34:22 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 08 May 2010 01:34:05 -0400
Content-Disposition: inline
In-Reply-To: <7vhbmjc6dy.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146642>

On Fri, May 07, 2010 at 10:24:57PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Based on past discussions, I suspect other people would be interested
> > in:
> >
> >   $ git diff [index] HEAD
> >   $ git diff HEAD [index]
> >   $ git diff [working-tree] [index]
> >
> > etc. I don't think I would want to type those all the time,...
> 
> If you go that route, why not use INDEX and WORKTREE (all caps) to at
> least avoid the brackets?  I am not personally interested in [] at all,
> but as part of that repertoire of syntactic sugar tokens EMPTY might be
> able to sneak in [*1*]

Yeah, I would be fine with that (and I think I even suggested it the
last time this came up). In theory we can be breaking somebody's repo by
stealing from the valid ref namespace, but it really is not all that
likely (and I suppose we could prefer user refs).

> *1* Without that "[]" syntax, the feature is "Meh" for me, but with the
> syntax, it becomes "Yuck".  The reason I am not interested in the feature
> is because I don't see much value in running "git diff EMPTY <anything>".
> Perhaps "git archive" might be what the user really wants to find.

Somehow it comes up for me every once in a while, and I go look up the
empty tree sha1 in the source and use it, think "it would be nice if
there was a handy syntax", and then realize that it is the sort of thing
that only comes up infrequently, and even then only when you are trying
to do something a little odd, so it probably isn't worth caring about. I
wish I could remember the reason for the last time I needed it, but I
can't.

-Peff
