From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: [PATCH] stash: --keep option just saves
Date: Thu, 12 Feb 2009 17:17:42 +0900
Message-ID: <20090212171742.6117@nanako3.lavabit.com>
References: <20090212062514.6117@nanako3.lavabit.com> <7vljscbp60.fsf@gitster.siamese.dyndns.org>
 <buovdrgckpa.fsf@dhlpc061.dev.necel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Miles Bader <miles@gnu.org>
X-From: git-owner@vger.kernel.org Thu Feb 12 09:19:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXWnN-0007FD-DL
	for gcvg-git-2@gmane.org; Thu, 12 Feb 2009 09:19:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750968AbZBLISH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2009 03:18:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750748AbZBLISF
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Feb 2009 03:18:05 -0500
Received: from karen.lavabit.com ([72.249.41.33]:55437 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750776AbZBLISD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Feb 2009 03:18:03 -0500
Received: from c.earth.lavabit.com (c.earth.lavabit.com [192.168.111.12])
	by karen.lavabit.com (Postfix) with ESMTP id 2D8DE11BAA9;
	Thu, 12 Feb 2009 02:18:03 -0600 (CST)
Received: from 1625.lavabit.com (212.62.97.20)
	by lavabit.com with ESMTP id V4CE9VCNSI0Y; Thu, 12 Feb 2009 02:18:03 -0600
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=tPGbZvjegtAZAkWNxeWsG3Kf+8/50sVo27LDYQ3XtGo/cgFfqzBFrRySUV0XIb+BpNHZ7Ycib8vamA+TICyT3plmEIZDk1MfJsTB2VKNeMbswCH1BM+CNBdZUe0mwVj6hC7LJrnVhUSZ5hDS8/6xMvXy+H4rKHTKHWIAkpmzH70=;
  h=From:To:Cc:Subject:In-Reply-To:References:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <buovdrgckpa.fsf@dhlpc061.dev.necel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109582>

Quoting Miles Bader <miles@gnu.org>:

> Junio C Hamano <gitster@pobox.com> writes:
>> This one, the "snapshot", and various other related topics, are quite
>> different.  The workflow the --keep (and for that matter, "snapshot")
>> would support I can think of does not sound a very good one we would want
>> to recommend (--untracked is a different issue; I haven't formed an
>> opinion).
>>
>> You build on a branch, but you are forever in the state of indecision, and
>> instead of committing, you keep saying "save --keep" number of times to
>> leave a checkpoint on your stash.  After number of iterations, you may
>> have many stashes in "git stash list", but what you can do with them is
>> "git reset --hard && git stash apply stash@{$n}" to go back to any of the
>> state, but that is about it.
>
> Yeah, but that's a pretty useful thing.
>
> I often save checkpoints of my working state before starting a
> tentative/intrusive series of edits -- if they are clearly just part
> of a larger logical change, I may not want to make separate commits
> [or perhaps more commonly, I'm not entirely sure what the final commit
> will be like, and am still "exploring"].

I suspect you either didn't read or didn't understand the rest of Junio's message in which he explained why it isn't a good use of git.

"I am still exploring" is exactly why git already offers cheap branches, distributed operation that makes committing and sharing separate, and rich set of commands to rewrite history, so that you don't have to worry about creating a sequence of commits that may not be ideal. "Just part of a larger logical change" is a sign that they belong to the same branch, and being able to rewrite your local history means the boundary between parts doesn't have to be perfect in your original set of commits.

If you created five "checkpoints" while working on such a "tentative/intrusive series of edits", you will have five commits on your tentative branch that shouldn't be separated in the way they are separated. Maybe they should be squashed to a single commit in the end, or maybe you want to split them into two commits. When you finished with them, you have a much better understanding of the issues to base your decision on how to split the changes, and that is when you use history rewriting tools to finalize what you have achieved.

An important thing to understand is that in a distributed system, commits don't have to be cast in iron when you make them, and that you don't have to be afraid of making "separate commits" only because they belong to one topic while you are exploring. You can combine them later, and you are in control when to declare they are finished and make them visible to others.

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
