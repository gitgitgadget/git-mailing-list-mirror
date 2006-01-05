From: Alex Riesen <raa.lkml@gmail.com>
Subject: trivial: retval of waitpid is not errno
Date: Thu, 5 Jan 2006 09:56:37 +0100
Message-ID: <81b0412b0601050056p3b51ff7bt5c75802f6ba07092@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_9672_16386022.1136451397910"
Cc: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Jan 05 09:57:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EuQwJ-0004Hi-Id
	for gcvg-git@gmane.org; Thu, 05 Jan 2006 09:57:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752112AbWAEI5l (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Jan 2006 03:57:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752117AbWAEI5k
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jan 2006 03:57:40 -0500
Received: from zeus1.kernel.org ([204.152.191.4]:35482 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1752112AbWAEI5k (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Jan 2006 03:57:40 -0500
Received: from nproxy.gmail.com (nproxy.gmail.com [64.233.182.192])
	by zeus1.kernel.org (8.13.1/8.13.1) with ESMTP id k058vcIe019511
	for <git@vger.kernel.org>; Thu, 5 Jan 2006 00:57:39 -0800
Received: by nproxy.gmail.com with SMTP id p46so1121204nfa
        for <git@vger.kernel.org>; Thu, 05 Jan 2006 00:56:38 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type;
        b=D9N/e+QZkpyhaZutiOMINT6ISRx2Q0SHPTcdSc1og7RCiXz/xxNck4VU2IJN4UzEYRinPpWoLAKqC8l2uJ/FFwwhQLuvUZP/ls5zx39BRMTYKNiAi0VohNcJov+vu1EQQCLNpekMSQkpa5DVBXJOA8MCVfUjb59b+NBYdDS/YqM=
Received: by 10.48.49.20 with SMTP id w20mr675501nfw;
        Thu, 05 Jan 2006 00:56:37 -0800 (PST)
Received: by 10.48.248.4 with HTTP; Thu, 5 Jan 2006 00:56:37 -0800 (PST)
To: git@vger.kernel.org
X-Virus-Scanned: ClamAV version 0.85, clamav-milter version 0.85 on zeus1
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14184>

------=_Part_9672_16386022.1136451397910
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

...but is used as such and passed to strerror.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>

------=_Part_9672_16386022.1136451397910
Content-Type: text/plain; name=0003-retval-of-waitpid-is-not-errno.txt; 
	charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="0003-retval-of-waitpid-is-not-errno.txt"

Subject: [PATCH] retval of waitpid is not errno

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>


---

 fetch-clone.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

a1dd9ab6b49a6c4e7abb6519933bf2bb22594bd4
diff --git a/fetch-clone.c b/fetch-clone.c
index 2b2aa15..f46fe6e 100644
--- a/fetch-clone.c
+++ b/fetch-clone.c
@@ -47,7 +47,7 @@ static int finish_pack(const char *pack_
 		if (retval < 0) {
 			if (errno == EINTR)
 				continue;
-			error("waitpid failed (%s)", strerror(retval));
+			error("waitpid failed (%s)", strerror(errno));
 			goto error_die;
 		}
 		if (WIFSIGNALED(status)) {
-- 
1.0.GIT

------=_Part_9672_16386022.1136451397910--
