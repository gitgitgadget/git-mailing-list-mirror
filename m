From: Bill Lear <rael@zopyra.com>
Subject: Fetching from peer's public repo
Date: Thu, 1 Feb 2007 09:24:34 -0600
Message-ID: <17858.1586.41833.597819@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 01 16:25:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCdo2-0004i3-Ib
	for gcvg-git@gmane.org; Thu, 01 Feb 2007 16:24:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422664AbXBAPYt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Feb 2007 10:24:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422677AbXBAPYt
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Feb 2007 10:24:49 -0500
Received: from mail.zopyra.com ([65.68.225.25]:60863 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422665AbXBAPYs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Feb 2007 10:24:48 -0500
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id l11FOm828380;
	Thu, 1 Feb 2007 09:24:48 -0600
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38362>

My fetch from a peer's public repo seems to be failing:

% git --bare fetch git://source/public/project topic:topic
remote: Generating pack...
remote: Done counting 48 objects.
remote: Result has 34 objects.
remote: Deltifying 34 objects.
remote:  100% (34/34) done
remote: Total 34, written 34 (delta 22), reused 24 (delta 12)
Unpacking 34 objects
 100% (34/34) done
* refs/heads/topic: not updating to non-fast forward branch 'topic' of git://source/public/project
  old...new: 1c332f5...f3b18ff

I assume that is because his public repo does not contain changes I
have pushed into my public repo.  So, I asked him to pull from
my public repo into his.  He did, and said that git blathered that
there were 12 changed files, etc.

I then tried the fetch again and it failed in the same way.  If I
look at the log output for the "old...new: 1c332f5...f3b18ff" line
above, I see the changes that he has that I want to get, but apparently
cannot (I tried to pull from my public to my private and it said
"Already up-to-date."):

% git log 1c332f5..f3b18ff
[... output looks reasonable ...]

Any ideas on how I can resolve this?

Also, what is the difference between:

% git log 1c332f5..f3b18ff

and

% git log 1c332f5...f3b18ff

with the latter having three dots instead of two?  It seems to show
much more output, but I don't know what the intent is.


Bill
