From: Ivan Pozdeev <vano@mail.mipt.ru>
Subject: [PATCH] comment for a long #ifdef
Date: Mon, 4 Apr 2016 04:00:49 +0300
Message-ID: <5701BCC1.9050306@mail.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 04 03:10:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1amt1u-00009O-B6
	for gcvg-git-2@plane.gmane.org; Mon, 04 Apr 2016 03:10:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753501AbcDDBKF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Apr 2016 21:10:05 -0400
Received: from relay1.telecom.mipt.ru ([81.5.91.10]:51048 "EHLO
	relay1.telecom.mipt.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753019AbcDDBKD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Apr 2016 21:10:03 -0400
X-Greylist: delayed 523 seconds by postgrey-1.27 at vger.kernel.org; Sun, 03 Apr 2016 21:10:03 EDT
Received: from localhost (localhost [127.0.0.1])
	by relay1.telecom.mipt.ru (Postfix) with ESMTP id 4A6C0122EA6
	for <git@vger.kernel.org>; Mon,  4 Apr 2016 04:01:18 +0300 (MSK)
X-Virus-Scanned: Debian amavisd-new at relay1.telecom.mipt.ru
Received: from relay1.telecom.mipt.ru ([127.0.0.1])
	by localhost (relay1.telecom.mipt.ru [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 9i3i8OYtnZ16 for <git@vger.kernel.org>;
	Mon,  4 Apr 2016 04:01:17 +0300 (MSK)
Received: from mail.mipt.ru (mail.mipt.ru [81.5.91.32])
	by relay1.telecom.mipt.ru (Postfix) with ESMTPS id E90C1122EA3
	for <git@vger.kernel.org>; Mon,  4 Apr 2016 04:01:15 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mipt.ru; s=mail;
	t=1459731676; i=@mipt.ru;
	bh=+fxQd9dBbZ+ohGAvIWox6RCSJFoZlkt+5TsyxM2d0/g=;
	h=From:To:Subject:Date:From;
	b=TAlREEiZ0lYHyYNJcXkCp+u61AcUOFVKLCDevHsJ9FbUz7TPhnfSxtft7C9AcJvHF
	 +SFrwaET7D06AyTW7pzHI1dvqgV5pwMfFyFqU+TybFfLAq5klaNhwcv6Fx8sluAKHb
	 7WCspni63GXsKGR5ZltBNrw7348vAvc6qmponJIU=
Received: from mail.mipt.ru (localhost [127.0.0.1])
	by mail.mipt.ru (Postfix) with ESMTPS id DB0C1B64C6E
	for <git@vger.kernel.org>; Mon,  4 Apr 2016 04:01:15 +0300 (MSK)
Received: from localhost (localhost [127.0.0.1])
	by mail.mipt.ru (Postfix) with ESMTP id CDE1BB64C5D
	for <git@vger.kernel.org>; Mon,  4 Apr 2016 04:01:15 +0300 (MSK)
Received: from mail.mipt.ru ([127.0.0.1])
	by localhost (mail.mipt.ru [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Aoz8S9EfJTRc for <git@vger.kernel.org>;
	Mon,  4 Apr 2016 04:01:15 +0300 (MSK)
Received: from [109.184.14.38] (109-184-14-38.dynamic.mts-nn.ru [109.184.14.38])
	by mail.mipt.ru (Postfix) with ESMTPSA id 986F1B64BB2
	for <git@vger.kernel.org>; Mon,  4 Apr 2016 04:01:15 +0300 (MSK)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101
 Thunderbird/38.7.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290666>

---
compat/poll/poll.c | 4 ++--
1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/compat/poll/poll.c b/compat/poll/poll.c
index db4e03e..5eb0280 100644
--- a/compat/poll/poll.c
+++ b/compat/poll/poll.c
@@ -441,7 +441,7 @@ poll (struct pollfd *pfd, nfds_t nfd, int timeout)
}

return rc;
-#else
+#else /* #ifndef WIN32_NATIVE */
static struct timeval tv0;
static HANDLE hEvent;
WSANETWORKEVENTS ev;
@@ -622,5 +622,5 @@ restart:
}

return rc;
-#endif
+#endif /* #ifndef WIN32_NATIVE */
}
-- 
1.9.5.msysgit.1


-- 
Regards,
Ivan
