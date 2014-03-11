From: Chris Packham <judge.packham@gmail.com>
Subject: [PATCH] Documentation/git-am: Document supported --patch-format options
Date: Tue, 11 Mar 2014 16:51:57 +1300
Message-ID: <1394509917-9679-1-git-send-email-judge.packham@gmail.com>
Cc: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
	Chris Packham <judge.packham@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 11 04:52:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNDjn-0005dB-9O
	for gcvg-git-2@plane.gmane.org; Tue, 11 Mar 2014 04:52:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753679AbaCKDwO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2014 23:52:14 -0400
Received: from mail-pd0-f175.google.com ([209.85.192.175]:55060 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753146AbaCKDwN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Mar 2014 23:52:13 -0400
Received: by mail-pd0-f175.google.com with SMTP id x10so7984030pdj.20
        for <git@vger.kernel.org>; Mon, 10 Mar 2014 20:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=kJh9+YXuGIXFsZ/SSja77KtNtBnuf/4j2zu/BX6Ie1E=;
        b=akavjUqPiYvK0wIB6Fr0pbNK6zQjkoBrHuwwqwVozoVkQkL5BCtnIMoSuiOjkzSffd
         WxSRQZy9maUsDmJmznQKzN+SWEucC8smnuBoZCAqzKhFWWOesB7J3A7WOPlCg1tRTwSI
         DnCB6v/3WkqVv1bpHatM61Lfw8o4k2G0uLMqgd6Wrk1/YwQ6PuRBC7aSM4bTeM1iLQeU
         jmP8q6fFcOf+uoNp3oLZrmy5cQgtqwn/ZNjNkAPPYUWEbSGxSDiaK63R92l3uK7wHvrg
         Mcj0xi9Q5WBV11sX+7d6CTADCbiU+mDbd3brjumONlo028P8SzHBWAKvIzfr1N3EIfPo
         VMIw==
X-Received: by 10.68.164.4 with SMTP id ym4mr45193277pbb.53.1394509933326;
        Mon, 10 Mar 2014 20:52:13 -0700 (PDT)
Received: from chrisp3-dl.ws.atlnz.lc (2-163-36-202-static.alliedtelesis.co.nz. [202.36.163.2])
        by mx.google.com with ESMTPSA id ja8sm69475514pbd.3.2014.03.10.20.52.11
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 10 Mar 2014 20:52:12 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243841>

The --patch-format option has been supported for a while but it is not
mentioned in the man page and the short help cannot tell the user what
the supported formats are. Add the option to the man page along with the
supported options.

Signed-off-by: Chris Packham <judge.packham@gmail.com>
---
I've not bothered to actually explain what the options mean. I'm not
sure if readers will care aside from just trying them until one works
(that's all I did when I had a patch that failed detection).

 Documentation/git-am.txt |   12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
index 54d8461..76bd359 100644
--- a/Documentation/git-am.txt
+++ b/Documentation/git-am.txt
@@ -12,9 +12,9 @@ SYNOPSIS
 'git am' [--signoff] [--keep] [--[no-]keep-cr] [--[no-]utf8]
 	 [--3way] [--interactive] [--committer-date-is-author-date]
 	 [--ignore-date] [--ignore-space-change | --ignore-whitespace]
-	 [--whitespace=<option>] [-C<n>] [-p<n>] [--directory=<dir>]
-	 [--exclude=<path>] [--include=<path>] [--reject] [-q | --quiet]
-	 [--[no-]scissors]
+	 [--whitespace=<option>] [-C<n>] [-p<n>] [--patch-format=<format>]
+	 [--directory=<dir>] [--exclude=<path>] [--include=<path>]
+	 [--reject] [-q | --quiet] [--[no-]scissors]
 	 [(<mbox> | <Maildir>)...]
 'git am' (--continue | --skip | --abort)
 
@@ -97,6 +97,12 @@ default.   You can use `--no-utf8` to override this.
 	program that applies
 	the patch.
 
+--patch-format::
+	By default the command will try to detect the patch format
+	automatically. This option allows the user to bypass the automatic
+	detection and specify the patch format that the patch(es) should be
+	intepreted as. Valid formats are mbox, stgit, stgit-series and hg.
+
 -i::
 --interactive::
 	Run interactively.
-- 
1.7.9.5
