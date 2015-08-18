From: Thomas Koch <thomas@koch.ro>
Subject: list empty dirs in commit message trailer
Date: Tue, 18 Aug 2015 16:43 +0200
Message-ID: <2384709.cc1iR2nLxC@x121e>
Reply-To: thomas@koch.ro
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: nomeata@debian.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 18 16:47:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZRiBA-0005vR-3r
	for gcvg-git-2@plane.gmane.org; Tue, 18 Aug 2015 16:47:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753239AbbHROrw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Aug 2015 10:47:52 -0400
Received: from mx1.mailbox.org ([80.241.60.212]:40659 "EHLO mx1.mailbox.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753201AbbHROrv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Aug 2015 10:47:51 -0400
X-Greylist: delayed 547 seconds by postgrey-1.27 at vger.kernel.org; Tue, 18 Aug 2015 10:47:51 EDT
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.mailbox.org (Postfix) with ESMTPS id 39DC140080;
	Tue, 18 Aug 2015 16:38:43 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
	by gerste.heinlein-support.de (gerste.heinlein-support.de [91.198.250.173]) (amavisd-new, port 10030)
	with ESMTP id V3ojeFDcRtN5; Tue, 18 Aug 2015 16:38:42 +0200 (CEST)
User-Agent: KMail/4.14.1 (Linux/4.1.0-0.bpo.1-amd64; KDE/4.14.2; x86_64; ; )
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276126>

Hi,

I had an idea how to deal with tracking empty directories in git repositories 
when one does not want ".gitkeep" files. Just add a trailer like:

empty-dirs: a b/c a\nnewline exploit\" &&\ rm\ -rf \/ ..

this line would indicate that the worktree contained the empty directories a 
and b/c and contains examples for possible shell quoting problems or exploits.

So one can not just run mkdir -p and the content of the line but needs 
safeguards.

A pre-commit hook could add such a line to the commit message and another tool 
could create the directories for HEAD. There is no staging in this approach 
for empty directories and no ignore mechanism. But for my current use case 
(represent the content of debian source packages) this would be enough.

Do you like the idea?

Regards,

Thomas Koch
