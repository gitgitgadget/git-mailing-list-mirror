From: Mark Blakeney <markb@berlios.de>
Subject: git rebase stops on empty commits
Date: Wed, 22 Jul 2009 17:22:13 +1000
Message-ID: <33e2b2760907220022rbad30d7x255bcb63c5b8cc2f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 22 09:28:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTWG1-0002sk-VV
	for gcvg-git-2@gmane.org; Wed, 22 Jul 2009 09:28:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752486AbZGVH2v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jul 2009 03:28:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752362AbZGVH2u
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Jul 2009 03:28:50 -0400
Received: from an-out-0708.google.com ([209.85.132.250]:13997 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751562AbZGVH2u (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jul 2009 03:28:50 -0400
Received: by an-out-0708.google.com with SMTP id d40so7961and.1
        for <git@vger.kernel.org>; Wed, 22 Jul 2009 00:28:50 -0700 (PDT)
Received: by 10.100.12.17 with SMTP id 17mr800738anl.2.1248247353162; Wed, 22 
	Jul 2009 00:22:33 -0700 (PDT)
X-Google-Sender-Auth: 0d0e0b234213669f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123742>

I am new to git but think I have found a bug. I searched the git archives
and found the same issue reported by Michael Gruber about 1 year ago but it
was discounted by Stephan Beyer and the problem seems to be forgotten about.

See http://kerneltrap.org/mailarchive/git/2008/7/8/2388804

In short, I think git rebase needs a "--allow-empty" option. I have git
repo which I converted from an old system and which for various reasons
requires me to --allow-empty commits when I build it. The repo has about
3300 commits but now when I try to fix up some of the early commit
comments using git rebase -i I find I have to manually sit at the
terminal and dumbly type;

    git commit --allow-empty (then quit out of editor)
    git rebase --continue

ad nauseum for all the many empty commits ...

I'm only rebasing to change some commit messages which must be a trivial
git operation. Surely git rebase -i should be able to be told to
continue through empty commits itself? At the very least some kind of
message to the user would help - I only found that git commit
--allow-empty works around this rebase problem once I found the old
post above.

I am using the latest version 1.6.3.3 of git. This is the version used
to build the repo from scratch and for the git rebase -i etc.

--
Mark Blakeney
