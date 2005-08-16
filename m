From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [RFC] Patches exchange is bad?
Date: Tue, 16 Aug 2005 18:45:21 -0400 (EDT)
Message-ID: <Pine.LNX.4.63.0508161824140.23242@iabervon.org>
References: <20050816220923.42545.qmail@web26301.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: martin.langhoff@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 17 00:44:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E5A8I-0003W3-M3
	for gcvg-git@gmane.org; Wed, 17 Aug 2005 00:42:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750705AbVHPWmA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 16 Aug 2005 18:42:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750706AbVHPWmA
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Aug 2005 18:42:00 -0400
Received: from iabervon.org ([66.92.72.58]:13582 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S1750705AbVHPWmA (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Aug 2005 18:42:00 -0400
Received: (qmail 28755 invoked by uid 1000); 16 Aug 2005 18:45:21 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 16 Aug 2005 18:45:21 -0400
To: Marco Costalba <mcostalba@yahoo.it>
In-Reply-To: <20050816220923.42545.qmail@web26301.mail.ukl.yahoo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, 16 Aug 2005, Marco Costalba wrote:

> Martin Langhoff wrote:
>
> >>From what I understand, you'll want the StGIT infrastructure. If you
> >use git/cogito, there is an underlying  assumption that you'll want
> >all the patches merged across, and a simple cg-update will bring in
> >all the pending stuff.
> >
>
> My concerns are both metodologicals and practical:
>
> 1) Method: To use the 'free patching workflow' on git is something foreseen in
> git design, something coherent with the fork + develop + merge cycle that it
> seems, at least to me, THE way git is meant to be used. Or it is stretching
> the possibility of the tool to something technically allowed but not suggested.

Patches are definitely meant to be part of how git is used; they are the
primary way of getting clean history out of messy history (that is, saving
a content change while discarding some history that isn't applicable).
There's relatively little support in git itself, but that's because the
point is to go outside the system's tracking. There have been various
discussions of more explicit support, and nobody's been able to come up
with a need.

> 2) Practical: The round trip git-format-patch + git-applymbox is the logical and
> natural way to reach this goal or, also in this case, I intend to stretch some tools,
> designed for one thing, for something else?

I'd guess that git-diff-tree + git-apply (without the rest of the
scripting) would be more effective when you're not doing anything with the
intermediate files, since it saves doing a bunch of formatting and
parsing.

	-Daniel
*This .sig left intentionally blank*
