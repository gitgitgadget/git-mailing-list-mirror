From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH ee/clean-remove-dirs] t7300-clean: require POSIXPERM
 for chmod 0 test
Date: Tue, 11 Aug 2015 22:29:48 +0200
Message-ID: <55CA5B3C.3010903@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>, msysGit <msysgit@googlegroups.com>
X-From: msysgit+bncBCJYV6HBKQIL3NVJVYCRUBGHXFF3U@googlegroups.com Tue Aug 11 22:29:51 2015
Return-path: <msysgit+bncBCJYV6HBKQIL3NVJVYCRUBGHXFF3U@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wi0-f185.google.com ([209.85.212.185])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCJYV6HBKQIL3NVJVYCRUBGHXFF3U@googlegroups.com>)
	id 1ZPGBC-0000S5-9f
	for gcvm-msysgit@m.gmane.org; Tue, 11 Aug 2015 22:29:50 +0200
Received: by wicul11 with SMTP id ul11sf18554950wic.0
        for <gcvm-msysgit@m.gmane.org>; Tue, 11 Aug 2015 13:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-type:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:x-spam-checked-in-group:list-post
         :list-help:list-archive:sender:list-subscribe:list-unsubscribe;
        bh=qWpwdDdIOinnAQOMPLCTNiRs/pQz48YjDcu+2L7yn6s=;
        b=Zk4bs18WX8O0yWPsZFua5hOL4Q35McjtW7p49gGtkNhFmwPna8l3RoAicNgDKhkPHJ
         w9lyCt/7wE4pRYOdVRI/Rb6qhsh5JCpbWo1aL62UCCG7Zn8npPEcdm60SVNJPpzl5zLt
         xz8YZ2M8bm0Eb6u+eEF2uSoHQnGzs18Iyv2AS7XV3YBNTQmTKqPuzptSt1TKDqxmSpRS
         PmbVvXALUR+cAEMlSJIhmnavLK/idB7+cC9FpqFWiuhEtrSXn31CCVhoZW3ByLdsAGwv
         K7P62y7AuWTz3vv9EYeeBvuld5fRYY7Ht5PqOq6gjLtZQu/5Dhz+RjbTT8epTODj6owK
         J7Rg==
X-Received: by 10.180.188.240 with SMTP id gd16mr76942wic.18.1439324989973;
        Tue, 11 Aug 2015 13:29:49 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.218.103 with SMTP id pf7ls626347wic.10.gmail; Tue, 11 Aug
 2015 13:29:49 -0700 (PDT)
X-Received: by 10.180.35.162 with SMTP id i2mr5896021wij.6.1439324989193;
        Tue, 11 Aug 2015 13:29:49 -0700 (PDT)
Received: from bsmtp8.bon.at (bsmtp8.bon.at. [213.33.87.20])
        by gmr-mx.google.com with ESMTPS id p7si136187wib.1.2015.08.11.13.29.49
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Aug 2015 13:29:49 -0700 (PDT)
Received-SPF: neutral (google.com: 213.33.87.20 is neither permitted nor denied by best guess record for domain of j6t@kdbg.org) client-ip=213.33.87.20;
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp8.bon.at (Postfix) with ESMTPSA id 3mrQkh55dnz5tlQ;
	Tue, 11 Aug 2015 22:29:48 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id 5FDF052D0;
	Tue, 11 Aug 2015 22:29:48 +0200 (CEST)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275721>

A test case introduced by 91479b9c (t7300: add tests to document
behavior of clean and nested git) uses 'chmod 0' to verify that a
subdirectory that has an unreadable .git file is not removed. This can
work only when the system pays attention to the permissions set with
'chmod'. Therefore, set the POSIXPERM prerequisite on the test case.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 This fixes a new failure in the test suite (t3404.8[67]) on Windows, but
 I got around to debug it only now.

 t/t7300-clean.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t7300-clean.sh b/t/t7300-clean.sh
index 32e96da..27557d6 100755
--- a/t/t7300-clean.sh
+++ b/t/t7300-clean.sh
@@ -499,7 +499,7 @@ test_expect_success 'should not clean submodules' '
 	test_path_is_missing to_clean
 '
 
-test_expect_success 'should avoid cleaning possible submodules' '
+test_expect_success POSIXPERM 'should avoid cleaning possible submodules' '
 	rm -fr to_clean possible_sub1 &&
 	mkdir to_clean possible_sub1 &&
 	test_when_finished "rm -rf possible_sub*" &&
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
