From: Thomas Rast <tr@thomasrast.ch>
Subject: [PATCH v3 0/3] Documentation: stuck arguments and gitk log -L
Date: Sat, 16 Nov 2013 18:37:54 +0100
Message-ID: <cover.1384622379.git.tr@thomasrast.ch>
References: <874n7ywpnd.fsf@thomasrast.ch>
Cc: Paul Mackerras <paulus@samba.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 16 18:38:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VhjpD-0007WZ-M0
	for gcvg-git-2@plane.gmane.org; Sat, 16 Nov 2013 18:38:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752786Ab3KPRiY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Nov 2013 12:38:24 -0500
Received: from psi.thgersdorf.net ([176.9.98.78]:38535 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751222Ab3KPRiM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Nov 2013 12:38:12 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id 990E54D65AA;
	Sat, 16 Nov 2013 18:38:10 +0100 (CET)
X-Virus-Scanned: amavisd-new at psioc.net
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id Ph2-JCr8_tSD; Sat, 16 Nov 2013 18:38:00 +0100 (CET)
Received: from linux-k42r.v.cablecom.net (unknown [213.55.184.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id 4B9BD4D659F;
	Sat, 16 Nov 2013 18:37:59 +0100 (CET)
X-Mailer: git-send-email 1.8.5.rc2.348.gb73b695
In-Reply-To: <874n7ywpnd.fsf@thomasrast.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237937>

This gathers three rather separate patches.

1/3 is an unrelated fix for a string comparison issue that I noticed
while surveying the state of stickiness.


2/3 is the "document" plan hinted at here:

> So my short-term plan just became: document instead of fix; clean up
> manpages towards the stuck form for long options; have gitk only parse
> -Lstuck.
> 
> Medium term we can move gitk to a different option parser, resolving at
> least that inconsistency.
> 
> Longer term we can see about moving some more of the remaining craziness
> towards parseopt, getting consistency for free.


3/3 is the change to gitk(1) to match the 'gitk -L' support that I'm
sending out separately (rebased to the gitk repo) and that will appear
here:

  http://mid.gmane.org/cover.1384622392.git.tr@thomasrast.ch

Of course it should only be applied once the corresponding code change
is in place.


Thomas Rast (3):
  commit-tree: use prefixcmp instead of memcmp(..., N)
  Documentation: convert to --option=arg form where possible
  Documentation/gitk: document -L option

 Documentation/blame-options.txt        |  4 ++--
 Documentation/fetch-options.txt        |  2 +-
 Documentation/git-branch.txt           |  6 +++---
 Documentation/git-checkout.txt         |  2 +-
 Documentation/git-cherry-pick.txt      |  2 +-
 Documentation/git-clone.txt            | 18 +++++++++---------
 Documentation/git-config.txt           |  4 ++--
 Documentation/git-credential-cache.txt |  4 ++--
 Documentation/git-cvsserver.txt        |  2 +-
 Documentation/git-describe.txt         |  2 +-
 Documentation/git-fmt-merge-msg.txt    |  4 ++--
 Documentation/git-format-patch.txt     |  4 ++--
 Documentation/git-grep.txt             | 10 +++++-----
 Documentation/git-notes.txt            |  2 +-
 Documentation/git-p4.txt               | 14 +++++++-------
 Documentation/git-prune.txt            |  4 ++--
 Documentation/git-rebase.txt           |  4 ++--
 Documentation/git-replace.txt          |  2 +-
 Documentation/git-revert.txt           |  6 +++---
 Documentation/gitk.txt                 | 16 ++++++++++++++++
 builtin/commit-tree.c                  |  2 +-
 git-cvsserver.perl                     |  2 +-
 22 files changed, 66 insertions(+), 50 deletions(-)

-- 
1.8.5.rc2.348.gb73b695
