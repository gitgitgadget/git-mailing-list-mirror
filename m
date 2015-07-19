From: Philip Oakley <philipoakley@iee.org>
Subject: [PATCH v2 05/16] engine.pl: fix error message (lib->link)
Date: Sun, 19 Jul 2015 21:08:05 +0100
Message-ID: <1437336497-4072-6-git-send-email-philipoakley@iee.org>
References: <1437336497-4072-1-git-send-email-philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	MsysGit List <msysgit@googlegroups.com>,
	Yue Lin Ho <b8732003@student.nsysu.edu.tw>,
	Philip Oakley <philipoakley@iee.org>
To: Git List <git@vger.kernel.org>
X-From: msysgit+bncBDSOTWHYX4PBB2EGWCWQKGQENBQ3CMA@googlegroups.com Sun Jul 19 22:07:06 2015
Return-path: <msysgit+bncBDSOTWHYX4PBB2EGWCWQKGQENBQ3CMA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wg0-f63.google.com ([74.125.82.63])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDSOTWHYX4PBB2EGWCWQKGQENBQ3CMA@googlegroups.com>)
	id 1ZGurY-0002Hv-Lh
	for gcvm-msysgit@m.gmane.org; Sun, 19 Jul 2015 22:07:04 +0200
Received: by wgik5 with SMTP id k5sf789068wgi.1
        for <gcvm-msysgit@m.gmane.org>; Sun, 19 Jul 2015 13:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:from:to:cc:subject:date:message-id:in-reply-to
         :references:x-original-sender:x-original-authentication-results
         :content-type:precedence:mailing-list:list-id
         :x-spam-checked-in-group:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe;
        bh=yz5NhZZ+Ln6ceqOrW7xJ46WfcNbYFrx1ruaK2rD0sbg=;
        b=c5r05kKFp8422UngbzuYecUeD7mwDQWfThUpVuC8dYuuGXzeZdxFec0XHegyfpXrn0
         Oe4XZx3t6zIPrHsml5O7TcTyOIr3rjklbA6p5HKGx4v//J7ESFsxt5Q8PsZefvops8re
         a+cIr5ZP2lXciNNCdP3qyhXQ56rwwc3n1vEveI9Nfzn46AyPiC7t6sGnZ43zifCsZmXV
         lyg1bbSS7rCQQihtYXbqXPfFi5UjQU9f/qnvkAlY3EhKQxoRogLg2SliXovQGPpKkHXU
         4kIqBZXXEiXXpw+7kFPE/aSm+ADr/LsliKBqgpJU0h3rz+rPQRFuQIr5iejbjTyQD98j
         JuOg==
X-Received: by 10.180.216.4 with SMTP id om4mr27881wic.3.1437336424277;
        Sun, 19 Jul 2015 13:07:04 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.181.23.195 with SMTP id ic3ls685704wid.49.canary; Sun, 19 Jul
 2015 13:07:03 -0700 (PDT)
X-Received: by 10.194.2.169 with SMTP id 9mr13203800wjv.2.1437336423669;
        Sun, 19 Jul 2015 13:07:03 -0700 (PDT)
Received: from out1.ip02ir2.opaltelecom.net (out1.ip02ir2.opaltelecom.net. [62.24.128.238])
        by gmr-mx.google.com with ESMTP id gt9si270946wib.2.2015.07.19.13.07.03
        for <msysgit@googlegroups.com>;
        Sun, 19 Jul 2015 13:07:03 -0700 (PDT)
Received-SPF: softfail (google.com: domain of transitioning philipoakley@iee.org does not designate 62.24.128.238 as permitted sender) client-ip=62.24.128.238;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: A2CWCwCSAqxVPN4GFlxcgkFSVGmGUbUUCYFthXkEAgKBGjkUAQEBAQEBAQYBAQEBQAE/hCQBAQQnLyMQCEk5ChQGE4gyxGgBK40JAYJjZQeEKwWUUoRviTuWfoEJgTeBYz0xgQSBRwEBAQ
X-IPAS-Result: A2CWCwCSAqxVPN4GFlxcgkFSVGmGUbUUCYFthXkEAgKBGjkUAQEBAQEBAQYBAQEBQAE/hCQBAQQnLyMQCEk5ChQGE4gyxGgBK40JAYJjZQeEKwWUUoRviTuWfoEJgTeBYz0xgQSBRwEBAQ
X-IronPort-AV: E=Sophos;i="5.15,504,1432594800"; 
   d="scan'208";a="39118929"
Received: from host-92-22-6-222.as13285.net (HELO localhost) ([92.22.6.222])
  by out1.ip02ir2.opaltelecom.net with ESMTP; 19 Jul 2015 21:07:04 +0100
X-Mailer: git-send-email 2.3.1
In-Reply-To: <1437336497-4072-1-git-send-email-philipoakley@iee.org>
X-Original-Sender: philipoakley@iee.org
X-Original-Authentication-Results: gmr-mx.google.com;       spf=softfail
 (google.com: domain of transitioning philipoakley@iee.org does not designate
 62.24.128.238 as permitted sender) smtp.mail=philipoakley@iee.org
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274279>

Signed-off-by: Philip Oakley <philipoakley@iee.org>
---
 contrib/buildsystems/engine.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/buildsystems/engine.pl b/contrib/buildsystems/engine.pl
index 23da787..c8a5258 100755
--- a/contrib/buildsystems/engine.pl
+++ b/contrib/buildsystems/engine.pl
@@ -329,7 +329,7 @@ sub handleLinkLine
         } elsif ($part =~ /\.(o|obj)$/) {
             push(@objfiles, $part);
         } else {
-            die "Unhandled lib option @ line $lineno: $part";
+            die "Unhandled link option @ line $lineno: $part";
         }
     }
 #    print "AppOut: '$appout'\nLFlags: @lflags\nLibs  : @libs\nOfiles: @objfiles\n";
-- 
2.4.2.windows.1.5.gd32afb6

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
