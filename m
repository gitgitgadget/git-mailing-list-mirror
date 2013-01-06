From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH jk/pathspec-literal] t6130-pathspec-noglob: Windows
 does not allow a file named "f*"
Date: Sun, 06 Jan 2013 15:07:43 +0100
Message-ID: <50E9852F.2060005@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, 
 Git Mailing List <git@vger.kernel.org>,
 msysGit <msysgit@googlegroups.com>
To: Jeff King <peff@peff.net>
X-From: msysgit+bncBCJYV6HBKQIK3CVGQ4CRUBFRY7NZU@googlegroups.com Sun Jan 06 15:08:00 2013
Return-path: <msysgit+bncBCJYV6HBKQIK3CVGQ4CRUBFRY7NZU@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wg0-f63.google.com ([74.125.82.63])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCJYV6HBKQIK3CVGQ4CRUBFRY7NZU@googlegroups.com>)
	id 1TrqtJ-0005G0-WF
	for gcvm-msysgit@m.gmane.org; Sun, 06 Jan 2013 15:07:58 +0100
Received: by mail-wg0-f63.google.com with SMTP id dq12sf7740100wgb.8
        for <gcvm-msysgit@m.gmane.org>; Sun, 06 Jan 2013 06:07:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=x-received:x-beenthere:x-received:x-received:received-spf
         :message-id:date:from:user-agent:mime-version:to:cc:subject
         :x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:x-google-group-id:list-post:list-help
         :list-archive:sender:list-subscribe:list-unsubscribe:content-type;
        bh=+NdWmm5v1sXj/5tao6WMg/HVKZmNUK2Rh7EAZhRHpZw=;
        b=BpdIXKxmZID7wliuH2ZmdIzJ1yRH1tgADuGUBL7xsQ1iHIx90N6CM6F+N8ZqCKH/jR
         +iKQfaDK00zSdf13ZK6Dp3P6dQXJS5OLdMnbxGH4uzy23D5vuNVLT1gKzZUjKm2D/K10
         UPf/1RuMUPBMZHA2GOdfg/Gev7nUCH6InwZjF5FLXbtTLyQ4/wF0dIP71ECXHROQ8lLP
         8VGrcO6Kag9l9eA9Y2N1hGiy6XH3xQ2WChYIc/Ap7IPbdYdhjopFowclqUEKolhmQclD
         yoTl2A/ZYiuLElwmQXaP17sgW/b42+c4vBBAujf+An5jhj7gRzEQKkk8oG9u5s3IMm46
      
X-Received: by 10.180.89.241 with SMTP id br17mr672315wib.4.1357481262499;
        Sun, 06 Jan 2013 06:07:42 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.75.72 with SMTP id a8ls657554wiw.17.canary; Sun, 06 Jan
 2013 06:07:41 -0800 (PST)
X-Received: by 10.14.224.201 with SMTP id x49mr73165200eep.5.1357481261429;
        Sun, 06 Jan 2013 06:07:41 -0800 (PST)
X-Received: by 10.14.224.201 with SMTP id x49mr73165197eep.5.1357481261417;
        Sun, 06 Jan 2013 06:07:41 -0800 (PST)
Received: from bsmtp.bon.at (bsmtp1.bon.at. [213.33.87.15])
        by gmr-mx.google.com with ESMTP id z44si20979225een.0.2013.01.06.06.07.41;
        Sun, 06 Jan 2013 06:07:41 -0800 (PST)
Received-SPF: neutral (google.com: 213.33.87.15 is neither permitted nor denied by best guess record for domain of j6t@kdbg.org) client-ip=213.33.87.15;
Received: from [192.168.0.207] (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id B2767130047;
	Sun,  6 Jan 2013 15:07:40 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/17.0 Thunderbird/17.0
X-Original-Sender: j6t@kdbg.org
X-Original-Authentication-Results: gmr-mx.google.com; spf=neutral (google.com:
 213.33.87.15 is neither permitted nor denied by best guess record for domain
 of j6t@kdbg.org) smtp.mail=j6t@kdbg.org
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post?hl=en>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=en>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=en>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212803>

Windows disallows file names that contain a star. Arrange the test setup
to insert the file name "f*" in the repository without the corresponding
file in the worktree.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 t/t6130-pathspec-noglob.sh | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/t/t6130-pathspec-noglob.sh b/t/t6130-pathspec-noglob.sh
index bb5e710..39ef619 100755
--- a/t/t6130-pathspec-noglob.sh
+++ b/t/t6130-pathspec-noglob.sh
@@ -6,7 +6,13 @@ test_description='test globbing (and noglob) of pathspec limiting'
 test_expect_success 'create commits with glob characters' '
 	test_commit unrelated bar &&
 	test_commit vanilla foo &&
-	test_commit star "f*" &&
+	# insert file "f*" in the commit, but in a way that avoids
+	# the name "f*" in the worktree, because it is not allowed
+	# on Windows (the tests below do not depend on the presence
+	# of the file in the worktree)
+	git update-index --add --cacheinfo 100644 "$(git rev-parse HEAD:foo)" "f*" &&
+	test_tick &&
+	git commit -m star &&
 	test_commit bracket "f[o][o]"
 '
 
-- 
1.8.1.1672.g5e2a3d4.dirty

-- 
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=en_US?hl=en
