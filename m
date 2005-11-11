From: Junio C Hamano <junkio@cox.net>
Subject: Re: The host:remote syntax mess
Date: Thu, 10 Nov 2005 17:46:20 -0800
Message-ID: <7vfyq4vtw3.fsf@assigned-by-dhcp.cox.net>
References: <20051111012216.GJ30496@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 11 02:48:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EaO07-0007a7-F8
	for gcvg-git@gmane.org; Fri, 11 Nov 2005 02:46:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932116AbVKKBqX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 Nov 2005 20:46:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932291AbVKKBqX
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Nov 2005 20:46:23 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:9903 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S932116AbVKKBqW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Nov 2005 20:46:22 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051111014525.SAE11356.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 10 Nov 2005 20:45:25 -0500
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20051111012216.GJ30496@pasky.or.cz> (Petr Baudis's message of
	"Fri, 11 Nov 2005 02:22:16 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11551>

Petr Baudis <pasky@ucw.cz> writes:

>   I've just noticed that host:remote syntax seems to have been hijacked
> again and is now attached to the GIT protocol in
>
> 	Documentation/pull-fetch-param.txt
>
> (which BTW misses git+ssh). I said "seems", because connect.c still
> appears to assume it is SSH. So what is the plan?

Sorry about that.  Thanks for noticing.

There is no plan to change that.  This documentation gotcha was
just that yours truly stupidly merged documentation changes
without reading every single line.

-- >8 -- cut here -- >8 --
[PATCH] Documentation: "host:path/to/repo" is git native over ssh.

You could also spell it ssh://host:/path/to/repo (or git+ssh,
ssh+git), but without method:// is shorter to type, so mention
only that one in the short and sweet list.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
diff --git a/Documentation/pull-fetch-param.txt b/Documentation/pull-fetch-param.txt
index 5c2888e..ddd5823 100644
--- a/Documentation/pull-fetch-param.txt
+++ b/Documentation/pull-fetch-param.txt
@@ -8,7 +8,7 @@
 - Rsync URL:		rsync://remote.machine/path/to/repo.git/
 - HTTP(s) URL:		http://remote.machine/path/to/repo.git/
 - git URL:		git://remote.machine/path/to/repo.git/
-			or remote.machine:/path/to/repo.git/
+- ssh URL:		remote.machine:/path/to/repo.git/
 - Local directory:	/path/to/repo.git/
 ===============================================================
 +
