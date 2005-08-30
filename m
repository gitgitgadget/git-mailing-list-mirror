From: A Large Angry SCM <gitzilla@gmail.com>
Subject: [PATCH] Documentation for git-daemon.
Date: Mon, 29 Aug 2005 22:31:22 -0400
Message-ID: <4313C4FA.7080906@gmail.com>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Aug 30 04:32:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E9vuM-000814-VU
	for gcvg-git@gmane.org; Tue, 30 Aug 2005 04:31:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751132AbVH3Cb1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 Aug 2005 22:31:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932077AbVH3Cb1
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Aug 2005 22:31:27 -0400
Received: from wproxy.gmail.com ([64.233.184.200]:25969 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751132AbVH3Cb0 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Aug 2005 22:31:26 -0400
Received: by wproxy.gmail.com with SMTP id i1so567296wra
        for <git@vger.kernel.org>; Mon, 29 Aug 2005 19:31:23 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:x-accept-language:mime-version:to:subject:content-type:content-transfer-encoding;
        b=empW7EpDQkqUJ9Td9PmmXhT4mkYnPVpQTIpgdF3n27/VWB+ygoZ1J0in7/3rd4QYSWRb1uJTfbQ1lm4c35JCJhRSaVEIXvXhivzE518nFUq4vh9cE8MaSVcW9qDme3o3H+eFquDkTAL7BA8t2SVxdZenk/rAkfZIuwp8CuM+TCk=
Received: by 10.54.47.36 with SMTP id u36mr7070688wru;
        Mon, 29 Aug 2005 19:31:23 -0700 (PDT)
Received: from ?10.0.0.6? ( [70.89.97.97])
        by mx.gmail.com with ESMTP id 44sm7310457wri.2005.08.29.19.31.23;
        Mon, 29 Aug 2005 19:31:23 -0700 (PDT)
User-Agent: Mozilla Thunderbird 1.0 (X11/20041207)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7942>

Copy & paste source comments into documentation.

Signed-off-by:  <gitzilla@gmail.com>


---

 Documentation/git-daemon.txt |   26 +++++++++++++++++---------
 1 files changed, 17 insertions(+), 9 deletions(-)

ea71ec7bde99f05a3766f5e1ad4ecc7bcb89ab13
diff --git a/Documentation/git-daemon.txt b/Documentation/git-daemon.txt
--- a/Documentation/git-daemon.txt
+++ b/Documentation/git-daemon.txt
@@ -3,26 +3,34 @@ git-daemon(1)
 
 NAME
 ----
-git-daemon - Some git command not yet documented.
-
+git-daemon - A really simple server for GIT repositories.
 
 SYNOPSIS
 --------
-'git-daemon' [ --option ] <args>...
+'git-daemon' [--inetd | --port=n]
 
 DESCRIPTION
 -----------
-Does something not yet documented.
+A really simple TCP git daemon that normally listens on port "DEFAULT_GIT_PORT"
+aka 9418. It waits for a connection, and will just execute "git-upload-pack"
+when it gets one.
+
+It's careful in that there's a magic request-line that gives the command and
+what directory to upload, and it verifies that the directory is ok.
+
+It verifies that the directory has the magic file "git-daemon-export-ok", and
+it will refuse to export any git directory that hasn't explicitly been marked
+for export this way.
 
+This is ideally suited for read-only updates, ie pulling from git repositories.
 
 OPTIONS
 -------
---option::
-	Some option not yet documented.
-
-<args>...::
-	Some argument not yet documented.
+--inetd::
+	Have the server run as an inetd service.
 
+--port::
+	Listen on an alternative port.
 
 Author
 ------
