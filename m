From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: daemon.c broken on OpenBSD
Date: 25 Oct 2005 16:32:19 -0700
Message-ID: <86r7a9jhq4.fsf@blue.stonehenge.com>
References: <867jc336f4.fsf@blue.stonehenge.com>
	<7v64rnsd83.fsf@assigned-by-dhcp.cox.net>
	<86vezljhve.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 26 01:32:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EUYHJ-0000l6-1u
	for gcvg-git@gmane.org; Wed, 26 Oct 2005 01:32:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932477AbVJYXcV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 25 Oct 2005 19:32:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932478AbVJYXcV
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Oct 2005 19:32:21 -0400
Received: from blue.stonehenge.com ([209.223.236.162]:45653 "EHLO
	blue.stonehenge.com") by vger.kernel.org with ESMTP id S932477AbVJYXcU
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Oct 2005 19:32:20 -0400
Received: from localhost (localhost [127.0.0.1])
	by blue.stonehenge.com (Postfix) with ESMTP id 28CB48F91C;
	Tue, 25 Oct 2005 16:32:20 -0700 (PDT)
Received: from blue.stonehenge.com ([127.0.0.1])
 by localhost (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 29000-01-83; Tue, 25 Oct 2005 16:32:19 -0700 (PDT)
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id B8EC58F974; Tue, 25 Oct 2005 16:32:19 -0700 (PDT)
To: Junio C Hamano <junkio@cox.net>
x-mayan-date: Long count = 12.19.12.13.6; tzolkin = 3 Cimi; haab = 4 Zac
In-Reply-To: <86vezljhve.fsf@blue.stonehenge.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10631>

>>>>> "Randal" == Randal L Schwartz <merlyn@stonehenge.com> writes:

Randal> I can confirm that the following patch lets the current origin
Randal> compile on OpenBSD.  If you could apply this until you sort out the
Randal> rest of the namespace issue, I would be happy.  Thanks.

Actually, you probably want this instead:

Subject: [PATCH] openbsd patch

---

 daemon.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

applies-to: 6234aa4f7095054a137e030030f914dc6633f809
7666c6f2cf2fcf41fce1d0665b79e5cc2f7b73b5
diff --git a/daemon.c b/daemon.c
index 0c6182f..c3f8641 100644
--- a/daemon.c
+++ b/daemon.c
@@ -1,5 +1,3 @@
-#include "cache.h"
-#include "pkt-line.h"
 #include <signal.h>
 #include <sys/wait.h>
 #include <sys/socket.h>
@@ -9,6 +7,8 @@
 #include <netinet/in.h>
 #include <arpa/inet.h>
 #include <syslog.h>
+#include "pkt-line.h"
+#include "cache.h"
 
 static int log_syslog;
 static int verbose;
---
0.99.8.GIT


-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
