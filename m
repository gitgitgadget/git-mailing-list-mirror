From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH bc/connect-plink] t5601-clone: remove broken and
 pointless check for plink.exe
Date: Tue, 11 Aug 2015 22:51:50 +0200
Message-ID: <55CA6066.5070500@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>, msysGit <msysgit@googlegroups.com>
X-From: msysgit+bncBCJYV6HBKQIORQFJVYCRUBFOAYP3O@googlegroups.com Tue Aug 11 22:51:53 2015
Return-path: <msysgit+bncBCJYV6HBKQIORQFJVYCRUBFOAYP3O@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wi0-f183.google.com ([209.85.212.183])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCJYV6HBKQIORQFJVYCRUBFOAYP3O@googlegroups.com>)
	id 1ZPGWX-0001Zu-Gk
	for gcvm-msysgit@m.gmane.org; Tue, 11 Aug 2015 22:51:53 +0200
Received: by wicxr16 with SMTP id xr16sf170816wic.1
        for <gcvm-msysgit@m.gmane.org>; Tue, 11 Aug 2015 13:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-type:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:x-spam-checked-in-group:list-post
         :list-help:list-archive:sender:list-subscribe:list-unsubscribe;
        bh=cuMI/kJtfw1U9Glv9F+572P4SKTQhDQW+Kc5AYQ+LrI=;
        b=BAIsq27IfMmSq4gdB9wQIWv6exbohBuMgGeVK7EDf7CcQOBvWLzgsPUz+DAelcTJsH
         jCb5k1LWF9qUZulSnuEaxvvaH7y8DSiU9/ID7W9PbDz8Gt3HT8vxNTbOmY/0YzU3lYqq
         cc7IZnS+/kjPSe3f31E9C/sPa1trGUrpksgt+6tqztkc6XIgE0Ld2wYAaXCuuaePHVU0
         gmdbvO8tUuLSWtCrop09yCNJe83u4A/TwUHdRe51ZP8ggddxJiEqBrJi14gkkbg0wiKt
         snZL1LG5Qq0jRSNUbZAYzH2xOZ2DXtODhDhEz7hcRxhBSHs5LJ2Fqr8cTqfpx3O+uEo1
         ZGTQ==
X-Received: by 10.152.3.38 with SMTP id 6mr188527laz.27.1439326313203;
        Tue, 11 Aug 2015 13:51:53 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.37.196 with SMTP id a4ls800203lak.27.gmail; Tue, 11 Aug
 2015 13:51:52 -0700 (PDT)
X-Received: by 10.112.149.39 with SMTP id tx7mr4463551lbb.11.1439326312102;
        Tue, 11 Aug 2015 13:51:52 -0700 (PDT)
Received: from bsmtp8.bon.at (bsmtp8.bon.at. [213.33.87.20])
        by gmr-mx.google.com with ESMTPS id c3si547291wiz.2.2015.08.11.13.51.52
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Aug 2015 13:51:52 -0700 (PDT)
Received-SPF: neutral (google.com: 213.33.87.20 is neither permitted nor denied by best guess record for domain of j6t@kdbg.org) client-ip=213.33.87.20;
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp8.bon.at (Postfix) with ESMTPSA id 3mrRD74KsYz5tlC;
	Tue, 11 Aug 2015 22:51:51 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id CD13852D0;
	Tue, 11 Aug 2015 22:51:50 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
X-Original-Sender: j6t@kdbg.org
X-Original-Authentication-Results: gmr-mx.google.com;       spf=neutral
 (google.com: 213.33.87.20 is neither permitted nor denied by best guess
 record for domain of j6t@kdbg.org) smtp.mailfrom=j6t@kdbg.org
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Spam-Checked-In-Group: msysgit@googlegroups.com
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/msysgit/subscribe>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275723>

Invoking plink requires special treatment, and we have support and even
test cases for the commands 'plink' and 'tortoiseplink'. We also support
.exe variants for these two and there is a test for 'plink.exe'.

On Windows, however, where support for plink.exe would be relevant, the
test case fails because it is not possible to execute a file with a .exe
extension that is actually not a binary executable---it is a shell
script in our test. We have to disable the test case on Windows.

Considering, that 'plink.exe' is irrelevant on non-Windows, let's just
remove the test and assume that the code "just works".

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 t/t5601-clone.sh | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index 9b34f3c..df69bf6 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -353,12 +353,6 @@ test_expect_success 'plink is treated specially (as putty)' '
 	expect_ssh "-P 123" myhost src
 '
 
-test_expect_success 'plink.exe is treated specially (as putty)' '
-	copy_ssh_wrapper_as "$TRASH_DIRECTORY/plink.exe" &&
-	git clone "[myhost:123]:src" ssh-bracket-clone-plink-1 &&
-	expect_ssh "-P 123" myhost src
-'
-
 test_expect_success 'tortoiseplink is like putty, with extra arguments' '
 	copy_ssh_wrapper_as "$TRASH_DIRECTORY/tortoiseplink" &&
 	git clone "[myhost:123]:src" ssh-bracket-clone-plink-2 &&
-- 
2.3.2.245.gb5bf9d3

-- 
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

--- 
You received this message because you are subscribed to the Google Groups "Git for Windows" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
