From: "Michael S. Tsirkin" <mst@mellanox.co.il>
Subject: Re: git rebase: unexpected conflict
Date: Thu, 8 Feb 2007 15:39:21 +0200
Message-ID: <20070208133921.GB20183@mellanox.co.il>
References: <7vired64tp.fsf@assigned-by-dhcp.cox.net>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Feb 08 14:39:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HF9Uc-0003QH-Jw
	for gcvg-git@gmane.org; Thu, 08 Feb 2007 14:39:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423035AbXBHNi7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Feb 2007 08:38:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423041AbXBHNi7
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Feb 2007 08:38:59 -0500
Received: from dev.mellanox.co.il ([194.90.237.44]:33236 "EHLO
	dev.mellanox.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423035AbXBHNi6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Feb 2007 08:38:58 -0500
Received: from mellanox.co.il ([194.90.237.34])
	by dev.mellanox.co.il (8.13.1/8.13.1) with SMTP id l18DcmBU015575;
	Thu, 8 Feb 2007 15:38:49 +0200
Received: by mellanox.co.il (sSMTP sendmail emulation); Thu,  8 Feb 2007 15:39:21 +0200
Content-Disposition: inline
In-Reply-To: <7vired64tp.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39056>

> Quoting Junio C Hamano <junkio@cox.net>:
> Subject: Re: git rebase: unexpected conflict
> 
> "Michael S. Tsirkin" <mst@mellanox.co.il> writes:
> 
> >> > git-show can not limit its output to just the part of patch
> >> > that affects the list of files I give, the way git-diff can.
> >> > Would such an extension be a good idea?
> >> 
> >> It is a good idea and I think it is implemented.
> >> 
> >> 	$ git-show <commit>... --- <paths>
> >
> > Yes, this works. But this seems undocumented. Right?
> 
> Somehow I think I saw Linus's answer to this exact topic a few
> hours ago.
> 
> This manual page describes only the most frequently used options.

Yes but Linus discussed git-log, which is both complete and correct.
Unlike git-log, the man page foor git-show is correct but incomplete:
It does say 
> This manual page describes only the most frequently used options.

However where git-log man page says:
-----
The  command  takes options applicable to the git-rev-list(1) command to
control what is shown and how, and options applicable to the
git-diff-tree(1)  commands to control how the change each commit introduces
are shown.
-----

man git-show says nothing of the kind.


-------------------------------------------------------------------

Junio, is the following patch correct?

Signed-off-by: Michael S. Tsirkin <mst@mellanox.co.il>

---

diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index b802946..361eaec 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -16,7 +16,7 @@ Shows the commit logs.
 
 The command takes options applicable to the gitlink:git-rev-list[1]
 command to control what is shown and how, and options applicable to
-the gitlink:git-diff-tree[1] commands to control how the change
+the gitlink:git-diff-tree[1] commands to control how the changes
 each commit introduces are shown.
 
 This manual page describes only the most frequently used options.
diff --git a/Documentation/git-show.txt b/Documentation/git-show.txt
index 9051951..f56f164 100644
--- a/Documentation/git-show.txt
+++ b/Documentation/git-show.txt
@@ -25,6 +25,9 @@ with \--name-only).
 
 For plain blobs, it shows the plain contents.
 
+The command takes options applicable to the gitlink:git-diff-tree[1] command to
+control how the changes the commit introduces are shown.
+
 This manual page describes only the most frequently used options.
 
 
-- 
MST
