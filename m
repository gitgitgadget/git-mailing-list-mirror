From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: Trying to use git-filter-branch to compress history by
	removing large, obsolete binary files
Date: Mon, 8 Oct 2007 15:05:14 -0400
Message-ID: <20071008190514.GM2902@fieldses.org>
References: <Pine.LNX.4.64.0710080018270.4174@racer.site> <51419b2c0710071624v79dc02d2g35a265add50dd46d@mail.gmail.com> <Pine.LNX.4.64.0710080028301.4174@racer.site> <51419b2c0710071638p6dcc0c7cm2a813c22758e6f32@mail.gmail.com> <Pine.LNX.4.64.0710080129480.4174@racer.site> <20071008010033.GA25654@fieldses.org> <Pine.LNX.4.64.0710080204140.4174@racer.site> <4709CCB2.4000202@viscovery.net> <20071008143650.GC2902@fieldses.org> <20071008163701.GA5868@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Elijah Newren <newren@gmail.com>,
	Frank Lichtenheld <frank@lichtenheld.de>, git@vger.kernel.org
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Mon Oct 08 21:05:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iexv6-00084l-L5
	for gcvg-git-2@gmane.org; Mon, 08 Oct 2007 21:05:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755445AbXJHTFY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Oct 2007 15:05:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755197AbXJHTFX
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Oct 2007 15:05:23 -0400
Received: from mail.fieldses.org ([66.93.2.214]:56338 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754750AbXJHTFW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Oct 2007 15:05:22 -0400
Received: from bfields by fieldses.org with local (Exim 4.67)
	(envelope-from <bfields@fieldses.org>)
	id 1Iexuk-0005sO-EP; Mon, 08 Oct 2007 15:05:14 -0400
Content-Disposition: inline
In-Reply-To: <20071008163701.GA5868@thunk.org>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60334>

On Mon, Oct 08, 2007 at 12:37:01PM -0400, Theodore Tso wrote:
> I think what makes git-filter-branch different is that you can change
> a large amount of history with git-filter-branch, including large
> numbers of tags, etc.  The reflog is quite sufficient to recover from
> a screwed up "git commit --amend".  But I don't think the reflog is
> going to be sufficient given the kinds of changes that
> git-filter-branch can potentially do to your repository.  Maybe
> default of --backup vs --no-backup could be changed via a config
> parameter, but I think the default is of backing up refs is a good
> think....

Yeah, it's clearly designed with rewriting a whole repo in mind.

It might also be handy, though, as a quick way to rewrite a single
branch.  (E.g., "add 'Acked-by: Joe' to everything in 'for-upstream' not
in 'origin'", or "rename foo to bar in every commit in 'topic' not in
'origin'".).

I find the current defaults awkward for that case.  Maybe it'd make
sense to treat the two cases differently.

> Perhaps a solution would be to add "git-filter-branch --cleanup" that
> that clears the reflog and wipes the backed up tags; perhaps first
> asking interactively if the user is really sure he/she wants to do
> this.

Maybe.

--b.
