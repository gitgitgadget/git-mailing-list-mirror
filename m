From: A Large Angry SCM <gitzilla@gmail.com>
Subject: [PATCH] Fix off-by-one error.
Date: Fri, 25 Nov 2005 23:59:35 -0800
Message-ID: <438815E7.6060507@gmail.com>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sat Nov 26 09:00:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EfuyV-0005M7-RX
	for gcvg-git@gmane.org; Sat, 26 Nov 2005 09:00:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422649AbVKZH7l (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 26 Nov 2005 02:59:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422650AbVKZH7l
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Nov 2005 02:59:41 -0500
Received: from xproxy.gmail.com ([66.249.82.199]:45114 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1422649AbVKZH7k (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 26 Nov 2005 02:59:40 -0500
Received: by xproxy.gmail.com with SMTP id i30so1758175wxd
        for <git@vger.kernel.org>; Fri, 25 Nov 2005 23:59:37 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:x-accept-language:mime-version:to:subject:content-type:content-transfer-encoding;
        b=Cn35qysZ/hcTi4rH+1SBehNT8oU3ouiQFrZgWUYJ1D+TS2UtaZ8tqQiK0CXYX/ydyOzw0z69X9NRnTi4G+GVLW+Au7Bv4xo2cICp8wBvp6WW2dRxeYzpzG3hYMBAMGlsEZU2uKCsHigMhZSVLDbhAnKZYtN7TzvKPhhWZn/nrSo=
Received: by 10.70.128.6 with SMTP id a6mr1596270wxd;
        Fri, 25 Nov 2005 23:59:37 -0800 (PST)
Received: from ?10.0.0.6? ( [69.175.230.211])
        by mx.gmail.com with ESMTP id i33sm1048145wxd.2005.11.25.23.59.36;
        Fri, 25 Nov 2005 23:59:37 -0800 (PST)
User-Agent: Mozilla Thunderbird 1.0 (X11/20041207)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12768>


Signed-off-by: A Large Angry SCM <gitzilla@gmail.com>

---

Fixed the correct line and tested this time.

 name-rev.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

applies-to: 196314fa7461a36f09ad1bab9b76dd190ad1925d
0fdee45c794131cd4cc1a4914cc34ab90511d173
diff --git a/name-rev.c b/name-rev.c
index 817e36b..96a87d3 100644
--- a/name-rev.c
+++ b/name-rev.c
@@ -217,7 +217,7 @@ int main(int argc, char **argv)
 					if (!strcmp(name, "undefined"))
 						continue;
 
-					fwrite(p_start, p - p_start, 1, stdout);
+					fwrite(p_start, p - p_start + 1, 1, stdout);
 					fputc('(', stdout);
 					fputs(name, stdout);
 					fputc(')', stdout);
---
0.99.9.GIT
