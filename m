From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git svn: make empty directory creation gc-aware
Date: Sat, 19 Dec 2009 23:21:42 -0800
Message-ID: <20091220072015.GB8141@dcvr.yhbt.net>
References: <8BB233FB-4269-4B14-8703-A4FF1E25FB0D@gmail.com> <20091217200852.GA5797@dcvr.yhbt.net> <20091219222738.GA20331@dcvr.yhbt.net> <7vzl5e3yx3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Sam Vilain <sam@vilain.net>,
	Robert Zeh <robert.a.zeh@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Dec 20 08:23:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NMG6u-0001DN-TJ
	for gcvg-git-2@lo.gmane.org; Sun, 20 Dec 2009 08:21:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751313AbZLTHVo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Dec 2009 02:21:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751302AbZLTHVn
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Dec 2009 02:21:43 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:48322 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751260AbZLTHVn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Dec 2009 02:21:43 -0500
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id 04BEF1F516;
	Sun, 20 Dec 2009 07:21:43 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <7vzl5e3yx3.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135521>

Junio C Hamano <gitster@pobox.com> wrote:
> >   More pushes hopefully coming as Sam and Andrew work out the mergeinfo
> >   performance problems and I look into crossing svn-remote boundaries
> >   for parent lookups.
> 
> Thanks.
> 
> This particular patch should be in 1.6.6 final, because mkdirs first
> appeared in 1.6.6-rc0 at 6111b93 (git svn: attempt to create empty dirs on
> clone+rebase, 2009-11-15), and 1.6.5.X series does not have the command,
> so this seems like a new feature that never existed in any tagged release,
> and if we shipped 1.6.6 without this patch, we will be shipping it with a
> know breakage, while if we shipped it with this, even if this patch
> somehow had an unintended side effect, at worst we'd be exchanging a bug
> with some other bug, so it wouldn't be worse.

I agree completely.

> Is mkdirs the only "noteworthy" feature that should be mentioned in the
> Release Notes in your area?  It would be really nice if you can give a
> patch to Documentation/RelNotes-1.6.6.txt in a few days to turn a single
> liner I have there to something more helpful.  The current shortlog since
> 1.6.5 indicates there weren't that much activity during this release.

Sam's merge handling work is definitely noteworthy, but it's already in
the release notes, hopefully the performance regression there is worked
out.  I'll definitely send you a patch to the release notes after I get
a chance to figure out the other issue with multiple svn-remotes
tonight/tomorrow.

-- 
Eric Wong
