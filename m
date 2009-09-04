From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 0/8] VCS helpers
Date: Fri, 4 Sep 2009 12:22:20 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.0909041141020.28290@iabervon.org>
References: <alpine.LNX.2.00.0909032213120.28290@iabervon.org> <7v63bz198j.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 04 18:22:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MjbYk-0006q5-OH
	for gcvg-git-2@lo.gmane.org; Fri, 04 Sep 2009 18:22:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933323AbZIDQWY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Sep 2009 12:22:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932819AbZIDQWY
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Sep 2009 12:22:24 -0400
Received: from iabervon.org ([66.92.72.58]:58647 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932865AbZIDQWX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Sep 2009 12:22:23 -0400
Received: (qmail 31677 invoked by uid 1000); 4 Sep 2009 16:22:20 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 4 Sep 2009 16:22:20 -0000
In-Reply-To: <7v63bz198j.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127741>

On Fri, 4 Sep 2009, Junio C Hamano wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> > This is the next version of the db/vcs-helper series in pu.
> 
> Thanks.
> 
> > The first patch is new, a rework of the remote-curl build to produce
> > "remote-curl" and call it as a special case for the sorts of URLs that
> > we accept as indicating something that it now handled by this helper.
> >
> > The series is rebased onto current next, with some conflicts resolved.
> 
> Because the theme of the topic does not have anything to do with fixing
> the deepening of shallow clones nor giving an extended error message from
> non-fast-forward git-push, I queued the series after reverse-rebasing onto
> old db/vcs-helper~8, in order to keep the topic branch pure, instead of
> merging unrelated topics from maint, master or next into it.  The result
> merged in 'pu' obviously has to match what you expected by applying the
> patches on top of 'next', and I am reasonably sure it does.

I'd thought that topics in pu were carried as based on next, particularly 
once they depend on something (e.g., the beginning of the series) in next. 
I suppose there's better options, but what do you do to find them? (Feel 
free to refer me to the "note from the maintainer" if it's there, but I 
don't remember that detail)

FWIW, there was a semantic mismerge in the original basing of this series 
on 07a4a3b496, which I finally fixed in this version; the code to handle 
NULL urls in builtin-fetch was after a new conversion of the url.

In any case, I think both the reverse-rebase and merge are correct.

> > Two patches have been dropped: a memory leak fix for code that was
> > removed entirely by the first patch, and the "mark" helper capability,
> > which is not needed (I believe) due to the "option" fast-import command.
> 
> Johan's cvs-helper series were depending on the previous iteration of this
> series, but I thought it is being rerolled, so I'd drop it from pu for now.

You could probably stick the "mark" patch into the start of the cvs-helper 
series until it gets rerolled if you want to keep that series in pu 
meanwhile; it was at the end of the series, and doesn't have subtle 
interactions or interact with anything that's changed.

	-Daniel
*This .sig left intentionally blank*
