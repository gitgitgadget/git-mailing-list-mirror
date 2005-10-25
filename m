From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: daemon.c broken on OpenBSD
Date: 25 Oct 2005 16:29:09 -0700
Message-ID: <86vezljhve.fsf@blue.stonehenge.com>
References: <867jc336f4.fsf@blue.stonehenge.com>
	<7v64rnsd83.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 26 01:30:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EUYEL-0007qK-2E
	for gcvg-git@gmane.org; Wed, 26 Oct 2005 01:29:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932475AbVJYX3M (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 25 Oct 2005 19:29:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932477AbVJYX3L
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Oct 2005 19:29:11 -0400
Received: from blue.stonehenge.com ([209.223.236.162]:59310 "EHLO
	blue.stonehenge.com") by vger.kernel.org with ESMTP id S932475AbVJYX3K
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Oct 2005 19:29:10 -0400
Received: from localhost (localhost [127.0.0.1])
	by blue.stonehenge.com (Postfix) with ESMTP id 746648F7C0;
	Tue, 25 Oct 2005 16:29:10 -0700 (PDT)
Received: from blue.stonehenge.com ([127.0.0.1])
 by localhost (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 29000-01-78; Tue, 25 Oct 2005 16:29:10 -0700 (PDT)
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id 125578F7CF; Tue, 25 Oct 2005 16:29:10 -0700 (PDT)
To: Junio C Hamano <junkio@cox.net>
x-mayan-date: Long count = 12.19.12.13.6; tzolkin = 3 Cimi; haab = 4 Zac
In-Reply-To: <7v64rnsd83.fsf@assigned-by-dhcp.cox.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10630>


I can confirm that the following patch lets the current origin
compile on OpenBSD.  If you could apply this until you sort out the
rest of the namespace issue, I would be happy.  Thanks.

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


-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
