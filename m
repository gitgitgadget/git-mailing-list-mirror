From: Ed Avis <eda@waniasset.com>
Subject: Re: Feature: git stash pop --always-drop
Date: Mon, 10 Aug 2015 14:01:23 +0000 (UTC)
Message-ID: <loom.20150810T155117-978@post.gmane.org>
References: <loom.20150810T124037-407@post.gmane.org> <20150810124125.GC32371@sigill.intra.peff.net> <loom.20150810T144849-152@post.gmane.org> <20150810133220.GA3559@sigill.intra.peff.net> <loom.20150810T153939-856@post.gmane.org> <20150810134957.GC6763@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 10 16:01:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZOne0-0006lm-K8
	for gcvg-git-2@plane.gmane.org; Mon, 10 Aug 2015 16:01:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754085AbbHJOBc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2015 10:01:32 -0400
Received: from plane.gmane.org ([80.91.229.3]:36845 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751914AbbHJOBa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Aug 2015 10:01:30 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1ZOndo-0006gQ-8a
	for git@vger.kernel.org; Mon, 10 Aug 2015 16:01:28 +0200
Received: from 80.169.169.174 ([80.169.169.174])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 10 Aug 2015 16:01:28 +0200
Received: from eda by 80.169.169.174 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 10 Aug 2015 16:01:28 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 80.169.169.174 (Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:39.0) Gecko/20100101 Firefox/39.0 Cyberfox/39.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275622>

>
Yes, my use case is that I get confused about whether the stash has been
dropped or not and whether I might have stashed something else in the
meantime.  So for me plain 'git stash drop' feels a bit dangerous.

Jeff King <peff <at> peff.net> writes:

>I also wondered if the "dropped" message is
>sufficiently clear to new users. The point of it, I think, is to allow a
>final "oops, I didn't mean to do that" moment. But there are no
>instructions for how one would re-create the same stash.

Right - myself I didn't even realize that recreating the stash was possible
(though I was vaguely aware that old stashes float around somewhere until
they are garbage collected many months later).

git stash is a relatively infrequent operation and quite exotic, so it
wouldn't hurt to add lots of chatter to it.

>>Another feature I would like to see is a kind of atomic stash apply, 

>I think that may be a bit harder, as the merge machinery would have to
>know how to be atomic.

If git merge-recursive had a --dry-run flag that might take care of it.

-- 
Ed Avis <eda@waniasset.com>
