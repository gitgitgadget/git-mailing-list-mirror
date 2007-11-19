From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: git merge no longer handles add/add
Date: Mon, 19 Nov 2007 13:46:57 -0500
Message-ID: <20071119184657.GE14295@fieldses.org>
References: <46a038f90711181918s2743137amc6a827db6d1a6a0@mail.gmail.com> <46a038f90711181929x4bf0794eue73a5dbac8e2688a@mail.gmail.com> <7vtznipweu.fsf@gitster.siamese.dyndns.org> <46a038f90711191033s4bc5ab50kd3e4f30d6b301e43@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git list <git@vger.kernel.org>
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 19 19:48:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IuBeW-0000ja-3h
	for gcvg-git-2@gmane.org; Mon, 19 Nov 2007 19:47:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753569AbXKSSrE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Nov 2007 13:47:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753418AbXKSSrD
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Nov 2007 13:47:03 -0500
Received: from mail.fieldses.org ([66.93.2.214]:57020 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753180AbXKSSrA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Nov 2007 13:47:00 -0500
Received: from bfields by fieldses.org with local (Exim 4.68)
	(envelope-from <bfields@fieldses.org>)
	id 1IuBe5-0004RZ-3E; Mon, 19 Nov 2007 13:46:57 -0500
Content-Disposition: inline
In-Reply-To: <46a038f90711191033s4bc5ab50kd3e4f30d6b301e43@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65486>

On Tue, Nov 20, 2007 at 07:33:27AM +1300, Martin Langhoff wrote:
> On Nov 19, 2007 7:43 PM, Junio C Hamano <gitster@pobox.com> wrote:
> > As far as the point of the merge is concerned, that's an add/add
> > of _different_ contents, and we have always left the conflict to
> > resolve for you since day one.  The only case we handle without
> > complaining is the accidental *clean* merge.  Both branches adds
> > the path *identically* compared to the common ancestor.
> 
> Even if the 2 paths did have matching content at one point? In fact,
> the 2 files here get added with identicaly content and one of them is
> later modified...
> 
> > The very initial implementation of merge may have used the total
> > emptyness as the common ancestor for the merge, and later we
> > made it a bit more pleasant to resolve by computing the common
> > part of the file from the two branches to be used as a fake
> > ancestor contents.  But the fact we left the result as conflict
> > for you to validate hasn't changed and will not change.
> 
> In this case, if you use the common part (100%) as the ancestor, then
> you get a _clean_ merge. The file is added on both sides identically,
> and then it changes on one side.

That sounds like an inevitable consequence of git's design--it only uses
a global (not a per-file) common ancestor.

--b.
