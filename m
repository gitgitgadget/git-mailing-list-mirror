From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 0/5] gitweb: git_patchset_body fixes
Date: Sun,  7 Jan 2007 02:52:22 +0100
Message-ID: <1168134747394-git-send-email-jnareb@gmail.com>
References: <100171.86639.qm@web31814.mail.mud.yahoo.com>
Cc: Luben Tuikov <ltuikov@yahoo.com>
X-From: git-owner@vger.kernel.org Sun Jan 07 02:52:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H3NDI-0001C8-Nc
	for gcvg-git@gmane.org; Sun, 07 Jan 2007 02:52:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932310AbXAGBwd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 6 Jan 2007 20:52:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932314AbXAGBwd
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Jan 2007 20:52:33 -0500
Received: from nf-out-0910.google.com ([64.233.182.190]:5038 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932310AbXAGBwb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Jan 2007 20:52:31 -0500
Received: by nf-out-0910.google.com with SMTP id o25so8960301nfa
        for <git@vger.kernel.org>; Sat, 06 Jan 2007 17:52:30 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=YOeC8O18kIW86sfYeS2BWCFBajtcUTicaiFelgDGBIhMMjrGJyZFHJcef6MCCQPikMfb9ZUufzzXzKRVCGDgOYyMnIh6HL36dAuL0i+zwKj7XCqtvSL5QlzEEHLcFGHBDVjH88nl6jxv5LGiKCSFzJXUSo0ilK2XG3k1Gnz2AEI=
Received: by 10.48.217.11 with SMTP id p11mr18015460nfg.1168134750190;
        Sat, 06 Jan 2007 17:52:30 -0800 (PST)
Received: from roke.D-201 ( [81.190.18.145])
        by mx.google.com with ESMTP id k9sm14383212nfc.2007.01.06.17.52.29;
        Sat, 06 Jan 2007 17:52:29 -0800 (PST)
Received: from roke.D-201 (localhost.localdomain [127.0.0.1])
	by roke.D-201 (8.13.4/8.13.4) with ESMTP id l071qTPZ007238;
	Sun, 7 Jan 2007 02:52:30 +0100
Received: (from jnareb@localhost)
	by roke.D-201 (8.13.4/8.13.4/Submit) id l071qRsn007237;
	Sun, 7 Jan 2007 02:52:27 +0100
To: git@vger.kernel.org
X-Mailer: git-send-email 1.4.4.3
In-Reply-To: <100171.86639.qm@web31814.mail.mud.yahoo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36112>

Luben Tuikov wrote:

> gitweb has two bugs in git_patchset_body (now you know who
> you are without data-mining with git-blame).
> 
> The first bug is a missing "</div>" on commitdiff.
> Saw this one a couple of days ago, but was swamped
> and had no time to post.

Could you please provide either minimal example from
scratch, or parameters for git.git repository view, or
an URL? I could not reproduce this...

> The second bug is displaying a renamed file with the
> same name as the one of the preceding "patch". Saw
> this one today when I pulled.
> 
> To exhibit these, you need to "commitdiff" a commit
> which has at least one rename and at least one regular
> diff preceding the rename.

Haven't found this one, but I hope one of those patches
would fix this.

[...]
> "And while at it" can you please actually *do* "refactor"
> git_patchset_body *into smaller functions each one doing
> a single particular task*.
> 
> It is sad to see git_patchset_body in such despicable state
> all the while seeing words like "refactor" in the commit logs
> of that function.

(Perhaps I overuse word "refactor").

> git_patchset_body is grossly overloaded for what it is
> supposed to do to, and being one single huge blob, it is
> hard to maintain.

I'm not sure if splitting git_patchset_body into smaller functions
would be worth doing, as 1) such functions would be used only
by git_patchset_body, 2) quite I bit of info has to be passed.

-- >8 --

Table of contents
 [PATCH 1/5] gitweb: Fix error in git_patchest_body for file
             creation/deletion patch 
 [PATCH 2/5] gitweb: Fix error in "rename to"/"copy to" git diff
             header output 
 [PATCH 3/5] gitweb: Fix errors in git_patchset_body for empty patches
 [PATCH 4/5] Revert "gitweb: There can be empty patches
             (in git_patchset_body)"
 [PATCH 5/5] gitweb: Fix split patches output (e.g. file to symlink)

Diffstat:
 gitweb/gitweb.perl |   22 ++++++++++++++--------
 1 files changed, 14 insertions(+), 8 deletions(-)

-- 
Jakub Narebski
Poland
