From: Petr Baudis <pasky@suse.cz>
Subject: Re: master^ is not a local branch -- huh?!?
Date: Tue, 2 Feb 2010 00:01:50 +0100
Message-ID: <20100201230150.GK9553@machine.or.cz>
References: <31a97741002010352x1ad27f26ia4d51857bb2d2d4f@mail.gmail.com>
 <7vpr4o3lg9.fsf@alter.siamese.dyndns.org>
 <87aavsu9b3.fsf@osv.gnss.ru>
 <ron1-6F8B85.14520801022010@news.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ron Garret <ron1@flownet.com>
X-From: git-owner@vger.kernel.org Tue Feb 02 00:02:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nc5HL-0004If-T6
	for gcvg-git-2@lo.gmane.org; Tue, 02 Feb 2010 00:02:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752885Ab0BAXBy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Feb 2010 18:01:54 -0500
Received: from w241.dkm.cz ([62.24.88.241]:51363 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752091Ab0BAXBx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Feb 2010 18:01:53 -0500
Received: by machine.or.cz (Postfix, from userid 2001)
	id 6FFD186202A; Tue,  2 Feb 2010 00:01:50 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <ron1-6F8B85.14520801022010@news.gmane.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138656>

On Mon, Feb 01, 2010 at 02:52:08PM -0800, Ron Garret wrote:
> In article <87aavsu9b3.fsf@osv.gnss.ru>, Sergei Organov <osv@javad.com> 
> wrote:
> 
> > Junio C Hamano <gitster@pobox.com> writes:
> > > Steve Diver <squelch2@googlemail.com> writes:
> > 
> > [...]
> > 
> > > If read carefully (some may argue that it does not need a very careful
> > > reading to get it, though), this hints that "detached HEAD" state is a
> > > substitute for using a temporary branch, but it may not be strong
> > > enough.
> > 
> > For my rather fresh eye it looks more like unnamed (anonymous?) branch
> > than a temporary one. Doesn't detached HEAD behave exactly like a
> > regular HEAD but pointing to the tip of an unnamed branch?
> 
> I strongly concur with this.
> 
> And as long as I'm weighing in, it would also help to prevent confusion 
> if it were made clear that this unnamed branch doesn't actually come 
> into existence unless and until you do a commit.

That statement is not quite consistent with the Git model. A branch is a
pointer. Detached HEAD is "unnamed" branch pointer (as in, you can refer
to it by the default HEAD alias, but not by any other name). In this
sense, the moment you create detached HEAD, you created the anonymous
branch, and the moment you check out something else, it is gone in a
wisp of smoke again.

The act of committing does not come into the picture at all. Committing
is the act of saving a commit to the database and *updating* the current
branch pointer to point at it. However, it does not affect what branch
pointer is the current one. It is important to realize that:

	* Branches refer to commits.
	* Commits do not refer to branches!

That is, when you create a commit, it is not _tied_ to a particular
branch. Thus, when you create a commit, you could not have created any
branch, and creating a branch [pointer] is unrelated to creating any
commits.

-- 
				Petr "Pasky" Baudis
If you can't see the value in jet powered ants you should turn in
your nerd card. -- Dunbal (464142)
