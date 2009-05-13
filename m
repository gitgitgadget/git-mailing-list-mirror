From: Daniel Trstenjak <Daniel.Trstenjak@science-computing.de>
Subject: Re: [PATCH] Showing stash state in bash prompt
Date: Wed, 13 May 2009 13:25:35 +0200
Message-ID: <20090513112535.GD2106@bug.science-computing.de>
References: <20090513094448.GC2106@bug.science-computing.de> <fabb9a1e0905130353u416086b8i5b685e750ec4b5a5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spearce@spearce.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 13 13:26:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4CbD-0001bt-Qz
	for gcvg-git-2@gmane.org; Wed, 13 May 2009 13:26:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757981AbZEML0B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2009 07:26:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756344AbZEML0A
	(ORCPT <rfc822;git-outgoing>); Wed, 13 May 2009 07:26:00 -0400
Received: from smtp1.belwue.de ([129.143.2.12]:34272 "EHLO smtp1.belwue.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753016AbZEML0A (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2009 07:26:00 -0400
Received: from mx3.science-computing.de (mx3.science-computing.de [193.197.16.20])
	by smtp1.belwue.de with ESMTP id n4DBPxFe023652
	for <git@vger.kernel.org>; Wed, 13 May 2009 13:25:59 +0200 (MEST)
	env-from (prvs=37790d091=D.Trstenjak@science-computing.de)
X-IronPort-AV: E=Sophos;i="4.41,187,1241388000"; 
   d="scan'208";a="4680452"
Received: from unknown (HELO scmail.science-computing.de) ([192.168.2.1])
  by mx3.science-computing.de with ESMTP; 13 May 2009 13:25:40 +0200
Received: from localhost (localhost [127.0.0.1])
	by scmail.science-computing.de (Postfix) with ESMTP id C19E2414003;
	Wed, 13 May 2009 13:25:39 +0200 (CEST)
X-Virus-Scanned: amavisd-new
Received: from scmail.science-computing.de ([127.0.0.1])
	by localhost (obitest.science-computing.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YBJygQDR6ebT; Wed, 13 May 2009 13:25:35 +0200 (CEST)
Received: from bug.science-computing.de (bug.science-computing.de [10.10.8.89])
	by scmail.science-computing.de (Postfix) with ESMTP id C9116414001;
	Wed, 13 May 2009 13:25:35 +0200 (CEST)
Received: by bug.science-computing.de (Postfix, from userid 1014)
	id A9A1B128540; Wed, 13 May 2009 13:25:35 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <fabb9a1e0905130353u416086b8i5b685e750ec4b5a5@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119033>


Showing stash state in bash prompt.

Signed-off-by: Daniel Trstenjak <daniel.trstenjak@science-computing.de>
---
 contrib/completion/git-completion.bash |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 1683e6d..86e39a5 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -117,6 +117,7 @@ __git_ps1 ()
 
 		local w
 		local i
+		local s
 		local c
 
 		if [ "true" = "$(git rev-parse --is-inside-git-dir 2>/dev/null)" ]; then
@@ -136,15 +137,19 @@ __git_ps1 ()
 					else
 						i="#"
 					fi
+					stash_list=`git stash list`
+					if [ -n "$stash_list" ]; then
+					        s="$"
+				        fi
 				fi
 			fi
 		fi
 
 		if [ -n "$b" ]; then
 			if [ -n "${1-}" ]; then
-				printf "$1" "$c${b##refs/heads/}$w$i$r"
+				printf "$1" "$c${b##refs/heads/}$w$i$s$r"
 			else
-				printf " (%s)" "$c${b##refs/heads/}$w$i$r"
+				printf " (%s)" "$c${b##refs/heads/}$w$i$s$r"
 			fi
 		fi
 	fi
-- 
1.6.2

-- 
Vorstand/Board of Management:
Dr. Bernd Finkbeiner, Dr. Roland Niemeier, 
Dr. Arno Steitz, Dr. Ingrid Zech
Vorsitzender des Aufsichtsrats/
Chairman of the Supervisory Board:
Michel Lepert
Sitz/Registered Office: Tuebingen
Registergericht/Registration Court: Stuttgart
Registernummer/Commercial Register No.: HRB 382196 
