From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: [PATCH] fix cg-fetch so that it doesn't use -d (to work with POSIX cp)
Date: 20 Nov 2005 20:10:38 -0800
Message-ID: <863blq4p4x.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Nov 21 05:11:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ee31B-0000Ww-Uq
	for gcvg-git@gmane.org; Mon, 21 Nov 2005 05:11:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750958AbVKUEKp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 Nov 2005 23:10:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750961AbVKUEKo
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Nov 2005 23:10:44 -0500
Received: from blue.stonehenge.com ([209.223.236.162]:32599 "EHLO
	blue.stonehenge.com") by vger.kernel.org with ESMTP
	id S1750958AbVKUEKo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Nov 2005 23:10:44 -0500
Received: from localhost (localhost [127.0.0.1])
	by blue.stonehenge.com (Postfix) with ESMTP id 8A8188F2CE
	for <git@vger.kernel.org>; Sun, 20 Nov 2005 20:10:39 -0800 (PST)
Received: from blue.stonehenge.com ([127.0.0.1])
 by localhost (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 11664-01 for <git@vger.kernel.org>;
 Sun, 20 Nov 2005 20:10:39 -0800 (PST)
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id 0505B8F2CF; Sun, 20 Nov 2005 20:10:38 -0800 (PST)
To: git@vger.kernel.org
x-mayan-date: Long count = 12.19.12.14.12; tzolkin = 3 Eb; haab = 10 Ceh
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12418>


I simply removed -d, since I don't know how necessary it is to make
it work better, but it seems to work fine on OSX now.

remove -d flag from cp

---
commit 3e7bc5b605f58376688f1cf195f51965becd5c3f
tree 1c53f8753ff9c31f0ff2692b64754ad48e45f143
parent 22ff47e9b3c5fc8aa2efbc5ac8690b06b868ef6f
author Randal L. Schwartz <merlyn@localhost.(none)> Sun, 20 Nov 2005 20:01:38 -0800
committer Randal L. Schwartz <merlyn@localhost.(none)> Sun, 20 Nov 2005 20:01:38 -0800

 cg-fetch |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/cg-fetch b/cg-fetch
index 5a2039f..eb89ebe 100755
--- a/cg-fetch
+++ b/cg-fetch
@@ -158,7 +158,7 @@ get_local()
 		cp_flags_l="$cp_flags_l -L"
 		shift
 	else
-		cp_flags_l="$cp_flags_l -dpR"
+		cp_flags_l="$cp_flags_l -pR"
 	fi
 
 	[ "$1" = "-i" ] && shift


-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
