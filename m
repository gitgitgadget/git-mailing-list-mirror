From: Jeff King <peff@peff.net>
Subject: Re: Giving command line parameter to textconv command?
Date: Tue, 15 Dec 2009 20:13:31 -0500
Message-ID: <20091216011330.GA28523@coredump.intra.peff.net>
References: <20091215071735.6117@nanako3.lavabit.com>
 <7vvdg9ceud.fsf@alter.siamese.dyndns.org>
 <20091215121110.6117@nanako3.lavabit.com>
 <7vfx7c3hmb.fsf@alter.siamese.dyndns.org>
 <20091215164959.GA21322@coredump.intra.peff.net>
 <7vljh3wwwf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 16 02:15:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NKiT7-0001Cl-Qm
	for gcvg-git-2@lo.gmane.org; Wed, 16 Dec 2009 02:14:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934415AbZLPBNk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Dec 2009 20:13:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934414AbZLPBNi
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Dec 2009 20:13:38 -0500
Received: from peff.net ([208.65.91.99]:51420 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934412AbZLPBNg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Dec 2009 20:13:36 -0500
Received: (qmail 32056 invoked by uid 107); 16 Dec 2009 01:18:10 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 15 Dec 2009 20:18:10 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 15 Dec 2009 20:13:31 -0500
Content-Disposition: inline
In-Reply-To: <7vljh3wwwf.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135312>

On Tue, Dec 15, 2009 at 05:05:52PM -0800, Junio C Hamano wrote:

> > There is also diff.*.command, which I think people _do_ set manually (I
> > used to, until I wrote textconv. :) ).
> 
> I had to spend fair amount of time to find where "diff.*.command" is
> described.  We may want to update the documentation.

Yeah, I think textconv is similarly hard to find. We should probably
have a pointer in "git-diff.txt" to the attributes documentation.

I also think it would be much more obvious as "diff.*.external", but it
is probably not worth changing at this point.

> > .... I agree that people almost certainly have to write a shell-script
> > wrapper anyway. But I wonder if we should pass it through the shell,
> > just for the sake of consistency with the other variables (in
> > particular, if textconv changes,
> 
> This covers GIT_EXTERNAL_DIFF, diff.external, and diff.<driver>.command
> trio, if I am not mistaken.

It does cover all three. We could do them separately, I guess, but I
think that is just making things confusingly more inconsistent.

> If we changed run_external_diff(), in practice nobody would notice, except
> for people who have installed the difftool helper in a directory with IFS
> in the path.  That's one downside but I don't offhand see a use case where
> the change would make somebody vastly happier.

Yeah, the only upside I can see is consistency. Which I do value, but it
will be a hard sell to somebody whose setup has been broken. ;P

> But maybe people will find good uses and we'll never know until we try.
> Care to roll a patch for that as well, to be queued for 1.7.0 (which will
> be the one after 1.6.6)?

Will do, but it will probably be a few days as I'm about to do some
holiday traveling. I'll do the textconv change with it as a series.

-Peff
