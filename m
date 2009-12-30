From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] bash completion: add space between branch name and
	status flags
Date: Wed, 30 Dec 2009 06:57:51 -0800
Message-ID: <20091230145751.GE6914@spearce.org>
References: <200911201309.16193.roman.fietze@telemotive.de> <7v4oopxeuf.fsf@alter.siamese.dyndns.org> <20091230224129.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Roman Fietze <roman.fietze@telemotive.de>
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Wed Dec 30 15:58:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NPzzt-0001rI-V2
	for gcvg-git-2@lo.gmane.org; Wed, 30 Dec 2009 15:58:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753014AbZL3O55 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Dec 2009 09:57:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753012AbZL3O55
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Dec 2009 09:57:57 -0500
Received: from mail-yw0-f176.google.com ([209.85.211.176]:58820 "EHLO
	mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752993AbZL3O54 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Dec 2009 09:57:56 -0500
Received: by ywh6 with SMTP id 6so12115686ywh.4
        for <git@vger.kernel.org>; Wed, 30 Dec 2009 06:57:55 -0800 (PST)
Received: by 10.90.62.10 with SMTP id k10mr2980878aga.112.1262185073950;
        Wed, 30 Dec 2009 06:57:53 -0800 (PST)
Received: from localhost (george.spearce.org [209.20.77.23])
        by mx.google.com with ESMTPS id 22sm12934743iwn.8.2009.12.30.06.57.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 30 Dec 2009 06:57:52 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20091230224129.6117@nanako3.lavabit.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135904>

Nanako Shiraishi <nanako3@lavabit.com> wrote:
> Junio, could you tell us what happened to this thread?
> 
> In response to a patch from Roman Fietze to outline a better way
> to do it.  Nothing happened.

Junio responded with a suggestion on how to improve the patch when
GIT_PS1_SHOWDIRTYSTATE was not set, but Roman Fietze didn't send
a revised patch, so it got dropped.

Here is the revised patch, Junio, still think its a good idea?

--8<--
From: Roman Fietze <roman.fietze@telemotive.de>
Subject: [PATCH] bash completion: add space between branch name and status flags

Improve the readability of the bash prompt by adding a space between
the branch name and the status flags (dirty, stash, untracked).

Signed-off-by: Roman Fietze <roman.fietze@telemotive.de>
Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 contrib/completion/git-completion.bash |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index fbfa5f2..3c8b6df 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -163,10 +163,12 @@ __git_ps1 ()
 			fi
 		fi
 
+		local f="$w$i$s$u"
+		f="${f:+ $f}$r"
 		if [ -n "${1-}" ]; then
-			printf "$1" "$c${b##refs/heads/}$w$i$s$u$r"
+			printf "$1" "$c${b##refs/heads/}$f"
 		else
-			printf " (%s)" "$c${b##refs/heads/}$w$i$s$u$r"
+			printf " (%s)" "$c${b##refs/heads/}$f"
 		fi
 	fi
 }
-- 
1.6.6.307.gba67


-- 
Shawn.
