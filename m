From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: How to move users from SEU (AS400) to Git?
Date: Tue, 12 May 2009 08:57:25 -0700
Message-ID: <20090512155725.GT30527@spearce.org>
References: <1CA7E776-B216-4AA5-BFE0-63C0B066980D@npcinternational.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jon Brisbin <jon.brisbin@npcinternational.com>
X-From: git-owner@vger.kernel.org Tue May 12 17:58:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3uMi-0005zU-Od
	for gcvg-git-2@gmane.org; Tue, 12 May 2009 17:58:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759670AbZELP50 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 May 2009 11:57:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759202AbZELP5Z
	(ORCPT <rfc822;git-outgoing>); Tue, 12 May 2009 11:57:25 -0400
Received: from george.spearce.org ([209.20.77.23]:60528 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758697AbZELP5Y (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 May 2009 11:57:24 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 48F24381D5; Tue, 12 May 2009 15:57:25 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1CA7E776-B216-4AA5-BFE0-63C0B066980D@npcinternational.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118907>

Jon Brisbin <jon.brisbin@npcinternational.com> wrote:
>
> I'm just wondering what the Git experts would say to someone wanting to 
> transition from say, Visual SourceSafe, and expecting the predictability 
> of having source files "locked out" while a developer is making changes 
> to them?

I had a really hard time with this "locked out" mentality at my last
employer.  They used PVCS Version Manager, and relied heavily on its
"lock out" feature to protect files while they were being edited.

But more often than not, what happened was a guy had a file locked
for a month at a time while doing some new feature change, he'd go
on vacation for a week, and a production issue would crop up that
need a fix in that file.

Half of the time, developers would try to fix the code somewhere
else.  They realized that was bad, e.g. putting in 85 if-then tests
at every call site because a function didn't tolerate a bad input,
but if they could lock the other 85 files, they'd do it over trying
to break the lock held by the first guy.

It took me a year to convince them that git's no-lock model is
better.  But they finally came over.  Most of it was about the fact
that they could now finally avoid that lock problem, and just do
the right change, and not need to do work arounds.  One of the guys
had trouble with that, he was OK with doing work arounds instead
of real fixes, but once we cleaned up most of his workarounds and
the code base practically got cut in half, he got on board.

Its an uphill battle.

-- 
Shawn.
