From: Petr Baudis <pasky@suse.cz>
Subject: Re: What should I do to display the diff of even a simple merge
 commit?
Date: Wed, 10 Feb 2010 00:57:07 +0100
Message-ID: <20100209235707.GQ9553@machine.or.cz>
References: <46d6db661002091545j74f625ffr74ca70a0474948fc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
To: Christian MICHON <christian.michon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 10 00:57:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nezxe-0000PI-2Y
	for gcvg-git-2@lo.gmane.org; Wed, 10 Feb 2010 00:57:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754513Ab0BIX5N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Feb 2010 18:57:13 -0500
Received: from w241.dkm.cz ([62.24.88.241]:51659 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751672Ab0BIX5N (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Feb 2010 18:57:13 -0500
Received: by machine.or.cz (Postfix, from userid 2001)
	id BDA7886202A; Wed, 10 Feb 2010 00:57:07 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <46d6db661002091545j74f625ffr74ca70a0474948fc@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139463>

  Hi!

On Wed, Feb 10, 2010 at 12:45:44AM +0100, Christian MICHON wrote:
> I'm performing many merges between developpers branches these days,
> most of them not yielding into conflicts. (understand: simple merges)
> 
> All is good, but sometimes, I would like to really like what has been changed.
> 
> As I do not systematically do this "git merge --no-commit --stat
> <list_to_merge>" and then fire "git gui" to inspect the diffs before
> the real commit, I'm wondering: how could I do this using some
> plumbing ?
> 
> Right now, I've tried the obvious git log -c -p, git show -u --cc, but
> since the merge are simple merges, I cannot get any diff output. I
> believe this is by construction.
> 
> Any hints ?

  I'm not sure if there is any clever switch for this, but I usually
just use one of

	git diff mergecommit^1 mergecommit
	git diff mergecommit^2 mergecommit

depending on which parent I want the diff against. If you always do your
merges as "on mainline, merging in a topic" without fast-forwarding,
diff against the first parent will be probably the right one and you can
simply use:

	git diff mergecommit^ mergecommit

  Kind regards,

				Petr "Pasky" Baudis
