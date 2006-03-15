From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: [patch] fix imap-send for OSX
Date: 15 Mar 2006 15:35:06 -0800
Message-ID: <86slpj5ljp.fsf@blue.stonehenge.com>
References: <7vk6avgxva.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 16 00:35:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FJfWR-0001Pf-Jf
	for gcvg-git@gmane.org; Thu, 16 Mar 2006 00:35:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752165AbWCOXfO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 15 Mar 2006 18:35:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752168AbWCOXfO
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Mar 2006 18:35:14 -0500
Received: from blue.stonehenge.com ([209.223.236.162]:33640 "EHLO
	blue.stonehenge.com") by vger.kernel.org with ESMTP
	id S1752166AbWCOXfL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Mar 2006 18:35:11 -0500
Received: from localhost (localhost [127.0.0.1])
	by blue.stonehenge.com (Postfix) with ESMTP id 1E8348F556;
	Wed, 15 Mar 2006 15:35:07 -0800 (PST)
Received: from blue.stonehenge.com ([127.0.0.1])
 by localhost (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 28889-01-29; Wed, 15 Mar 2006 15:35:06 -0800 (PST)
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id 9F6E68F557; Wed, 15 Mar 2006 15:35:06 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
x-mayan-date: Long count = 12.19.13.2.7; tzolkin = 1 Manik; haab = 5 Cumku
In-Reply-To: <7vk6avgxva.fsf@assigned-by-dhcp.cox.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17622>


This patch works... I've been using it to stay current.

---

 imap-send.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

ba458b49b860488c25cf57dabbb5db97f12e41f2
diff --git a/imap-send.c b/imap-send.c
index 1b38b3a..e33c78b 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -372,7 +372,7 @@ free_generic_messages( message_t *msgs )
 }
 
 static int
-vasprintf( char **strp, const char *fmt, va_list ap )
+git_vasprintf( char **strp, const char *fmt, va_list ap )
 {
 	int len;
 	char tmp[1024];
@@ -402,7 +402,7 @@ nfsnprintf( char *buf, int blen, const c
 static int
 nfvasprintf( char **str, const char *fmt, va_list va )
 {
-	int ret = vasprintf( str, fmt, va );
+	int ret = git_vasprintf( str, fmt, va );
 	if (ret < 0)
 		die( "Fatal: Out of memory\n");
 	return ret;
-- 
1.2.4.g5593



-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
