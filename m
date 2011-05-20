From: "George Spelvin" <linux@horizon.com>
Subject: Re: git  --  how to revert build to as-originally-cloned?
Date: 20 May 2011 16:22:20 -0400
Message-ID: <20110520202220.24482.qmail@science.horizon.com>
References: <4DD6BE8D.4080708@hotmail.com>
Cc: git@vger.kernel.org, timmazid@hotmail.com
To: johnlumby@hotmail.com, linux@horizon.com
X-From: git-owner@vger.kernel.org Fri May 20 22:22:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QNWDM-0003rL-27
	for gcvg-git-2@lo.gmane.org; Fri, 20 May 2011 22:22:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964801Ab1ETUWW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 May 2011 16:22:22 -0400
Received: from science.horizon.com ([71.41.210.146]:37458 "HELO
	science.horizon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S964789Ab1ETUWW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 May 2011 16:22:22 -0400
Received: (qmail 24483 invoked by uid 1000); 20 May 2011 16:22:20 -0400
In-Reply-To: <4DD6BE8D.4080708@hotmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174078>

> I have tried gitk.  Can you or someone tell me what the colours of
> the nodes in the top left signifies?  Specifically, a commit of mine
> (done since all the merging I've been asking about) shows as yellow,
> whereas all the ones prior to that show as blue.

Nothing.  It just tries to use different colours so you can tell the
lines apart.  But the specific colour is no more meaningful than
shadings on a map.

> So what would be the correct way,  before doing my fast-forward merge,
> to have made some kind of mark pointing at "a",  which I could then have
> used to undo the fast-forward,  without having to calculate the number
> of commits in between?  (supposing my branch was not anchored at "a"
> but at some much earlier point)?

The basic tool to do that is "git tag <name>", which creates a tag with
the given name.  (The difference between a tag and a branch is simply
that a branch is updated when you commit.)

However, most people don't bother with an explicit name; see the man page
for git-rev-parse for a list of all the ways to refer to old revisions.
@{1} is the usual syntax for "the current branch before the last change",
or you can use the older name ORIG_HEAD, too.

"git reflog" will show an extended history.
