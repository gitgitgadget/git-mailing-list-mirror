From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] allow user aliases for the --author parameter
Date: Thu, 28 Aug 2008 17:33:22 -0400
Message-ID: <20080828213322.GB27867@coredump.intra.peff.net>
References: <20080822211902.GA31884@coredump.intra.peff.net> <48B3B8B0.4020609@fastmail.fm> <7vsksr1hgt.fsf@gitster.siamese.dyndns.org> <20080827001944.GA7347@coredump.intra.peff.net> <7v7ia3rnnq.fsf@gitster.siamese.dyndns.org> <48B52037.7030405@fastmail.fm> <20080827123656.GB11986@coredump.intra.peff.net> <7vmyiyqt08.fsf@gitster.siamese.dyndns.org> <20080827171846.GA14300@coredump.intra.peff.net> <48B66783.4050305@fastmail.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <michaeljgruber+gmane@fastmail.fm>
X-From: git-owner@vger.kernel.org Thu Aug 28 23:34:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYp8P-0005IK-Ox
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 23:34:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755193AbYH1VdZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2008 17:33:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754923AbYH1VdZ
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 17:33:25 -0400
Received: from peff.net ([208.65.91.99]:1560 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754645AbYH1VdY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 17:33:24 -0400
Received: (qmail 7917 invoked by uid 111); 28 Aug 2008 21:33:23 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 28 Aug 2008 17:33:23 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 28 Aug 2008 17:33:22 -0400
Content-Disposition: inline
In-Reply-To: <48B66783.4050305@fastmail.fm>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94182>

On Thu, Aug 28, 2008 at 10:53:23AM +0200, Michael J Gruber wrote:

> > Anyway, I think it is already not a good idea because of the semantics,
> > let alone the performance.
> 
> By "it" you are referring to
> - checking for uniqueness or
> - the whole approach combing through commits?

Sorry, I meant "checking for uniqueness." I think combing through is a
fine idea, but checking for uniqueness will come up with false
positives.

> I'd be happy with the patch as is (+"-i" maybe) now that I understand
> the template... (I tried --author=key with a key expanding to the
> (default) committer, in which case the commit template does not show
> author nor committer. Duh.)

You could pull the first from either (I think you will have to look at
the revision.c code at a little bit lower level -- look at how --author
adds grep fields). In a patch-by-mail repository like git.git, Junio is
almost always the committer. But other projects will have different
workflows.

> > PS Your message also didn't go to git@vger, so I think you are having
> > the same problem with Michael's message that I am.
> 
> OK: I send this To: Jeff, Cc: Junio, Nntp:
> gmane.comp.version-control.git (using Thunderbird 2). (This is the
> result of hitting "reply all" and deleting git@vger, because it's
> duplicated by gmane...git.)

Ah, OK. So your message ends up in my mailbox without a mention of
git@vger at all. It of course has a "newsgroups" header, but that is not
helpful for people who do not use gmane at all. And given that this is
primarily a mailing list which has a newsgroup interface, and not vice
versa, I think it makes sense to give priority to the mail interface.

Is there a reason to post through gmane at all? Why not just leave the
git@vger cc, and kill the nntp post?

-Peff
