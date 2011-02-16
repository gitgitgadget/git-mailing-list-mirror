From: Miles Bader <miles@gnu.org>
Subject: Re: [RFC/PATCH 0/2] CHERRY_HEAD
Date: Wed, 16 Feb 2011 10:48:28 +0900
Message-ID: <87oc6czr4j.fsf@catnip.gol.com>
References: <1297805034-3512-1-git-send-email-jaysoffian@gmail.com>
	<AANLkTik2NM+mxKgZy_9dCwydz+An4sFM_a4U9mdrJBq3@mail.gmail.com>
	<AANLkTinV+cY-fND2bemDGdShnfqQGMG3eUmZPXrpKayt@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 16 02:48:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PpWVa-0004Nc-BG
	for gcvg-git-2@lo.gmane.org; Wed, 16 Feb 2011 02:48:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756763Ab1BPBsl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Feb 2011 20:48:41 -0500
Received: from smtp12.dentaku.gol.com ([203.216.5.74]:59566 "EHLO
	smtp12.dentaku.gol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756478Ab1BPBsf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Feb 2011 20:48:35 -0500
Received: from 218.33.195.219.eo.eaccess.ne.jp ([218.33.195.219] helo=catnip.gol.com)
	by smtp12.dentaku.gol.com with esmtpa (Dentaku)
	(envelope-from <miles@gnu.org>)
	id 1PpWVJ-0004Hc-1Y; Wed, 16 Feb 2011 10:48:29 +0900
Received: by catnip.gol.com (Postfix, from userid 1000)
	id 0C6E3E065; Wed, 16 Feb 2011 10:48:28 +0900 (JST)
System-Type: x86_64-unknown-linux-gnu
In-Reply-To: <AANLkTinV+cY-fND2bemDGdShnfqQGMG3eUmZPXrpKayt@mail.gmail.com>
	(Jay Soffian's message of "Tue, 15 Feb 2011 17:11:36 -0500")
X-Virus-Scanned: ClamAV GOL (outbound)
X-Abuse-Complaints: abuse@gol.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166913>

Jay Soffian <jaysoffian@gmail.com> writes:
> 2. Given a rev-list. This is relatively recent addition to cherry-pick
> (7e2bfd3 revert: allow cherry-picking more than one commit,
> 2010-06-02). Here's where I'd expect to have a more rebase-like
> behavior, using --continue/abort to work through the sequence. But
> frankly, I consider 7e2bfd3 a mistake. I think a better implementation
> would be to make cherry-pick be plumbing, and re-use rebase's logic
> for walking through the series of commit.

I'd also love this functionality ... 

Can basically do it with:

  # remember current branch name CHERRY_PICK_TARGET
  git checkout REV_LIST_END
  git rebase --onto CHERRY_PICK_TARGET  REV_LIST_START
  [+ git rebase --continue etc]

but man, is that confusing to remember...

I wonder if a wrapper would be robust enough.

-Miles

-- 
Cannon, n. An instrument employed in the rectification of national boundaries.
