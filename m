From: Philip Oakley <philipoakley@iee.org>
Subject: [PATCH v2 11/16] engine.pl: add debug line to capture the dry-run
Date: Sun, 19 Jul 2015 21:08:11 +0100
Message-ID: <1437336497-4072-12-git-send-email-philipoakley@iee.org>
References: <1437336497-4072-1-git-send-email-philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	MsysGit List <msysgit@googlegroups.com>,
	Yue Lin Ho <b8732003@student.nsysu.edu.tw>,
	Philip Oakley <philipoakley@iee.org>
To: Git List <git@vger.kernel.org>
X-From: msysgit+bncBDSOTWHYX4PBB3UGWCWQKGQECNGFQFA@googlegroups.com Sun Jul 19 22:07:18 2015
Return-path: <msysgit+bncBDSOTWHYX4PBB3UGWCWQKGQECNGFQFA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wg0-f62.google.com ([74.125.82.62])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDSOTWHYX4PBB3UGWCWQKGQECNGFQFA@googlegroups.com>)
	id 1ZGurk-0002Kd-2W
	for gcvm-msysgit@m.gmane.org; Sun, 19 Jul 2015 22:07:16 +0200
Received: by wgik5 with SMTP id k5sf789173wgi.1
        for <gcvm-msysgit@m.gmane.org>; Sun, 19 Jul 2015 13:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:from:to:cc:subject:date:message-id:in-reply-to
         :references:x-original-sender:x-original-authentication-results
         :content-type:precedence:mailing-list:list-id
         :x-spam-checked-in-group:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe;
        bh=7QcW1alhteJaAB/19qdnTAQeViX9gzwz9DMxryeXWEs=;
        b=UwOsaGy0ZqLKECPqtuy+BjepL9EZEwHsZL81iXA3noCfl4lROGwoojaFPUTlwRsRc+
         Dizqbpyg9ja9I+EeIWfs7wpmNuBZ0v9VC9IXa2Jw/HKiy1PhnRtRKPfIWrDN2vYx/hVk
         zBk0x8mAhMx/VVUnB7MamKbLqOFXIklOIWy1FRIdRtNqGY54Ql4VaJJe4gBKRvAxlzPJ
         lMKYqJ/s4/RrBpI22GLsg7//TMgkK1m9LZ3dXLmbVV67InMW65TYccaryjP+3LABQlQ/
         +531NGt2utejSKVvp5sN80pDRLzud+4+2bbaeGQnH8CVgSajfdL0myuXB7s3px4PRGWU
         dA7w==
X-Received: by 10.180.90.235 with SMTP id bz11mr28472wib.6.1437336430772;
        Sun, 19 Jul 2015 13:07:10 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.87.2 with SMTP id t2ls676985wiz.4.gmail; Sun, 19 Jul 2015
 13:07:10 -0700 (PDT)
X-Received: by 10.180.35.162 with SMTP id i2mr4472607wij.6.1437336430132;
        Sun, 19 Jul 2015 13:07:10 -0700 (PDT)
Received: from out1.ip02ir2.opaltelecom.net (out1.ip02ir2.opaltelecom.net. [62.24.128.238])
        by gmr-mx.google.com with ESMTP id gt9si270946wib.2.2015.07.19.13.07.10
        for <msysgit@googlegroups.com>;
        Sun, 19 Jul 2015 13:07:10 -0700 (PDT)
Received-SPF: softfail (google.com: domain of transitioning philipoakley@iee.org does not designate 62.24.128.238 as permitted sender) client-ip=62.24.128.238;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: A2CVCwCSAqxVPN4GFlxcgkFSVGmGUbUUCYFthXkEAgKBGjkUAQEBAQEBAQYBAQEBQAE/hCQBAQRWIxAISTkKFAYTiDLEaCyQUgeEKwWUUoRviTuWfoEJgxo9MYJLAQEB
X-IPAS-Result: A2CVCwCSAqxVPN4GFlxcgkFSVGmGUbUUCYFthXkEAgKBGjkUAQEBAQEBAQYBAQEBQAE/hCQBAQRWIxAISTkKFAYTiDLEaCyQUgeEKwWUUoRviTuWfoEJgxo9MYJLAQEB
X-IronPort-AV: E=Sophos;i="5.15,504,1432594800"; 
   d="scan'208";a="39118941"
Received: from host-92-22-6-222.as13285.net (HELO localhost) ([92.22.6.222])
  by out1.ip02ir2.opaltelecom.net with ESMTP; 19 Jul 2015 21:07:10 +0100
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274288>

Add a debug suggestion for capturing to file the stdout from the dry-run
of the make file used in determining the msvc-build structure for easy
debugging.

Signed-off-by: Philip Oakley <philipoakley@iee.org>
---
 contrib/buildsystems/engine.pl | 1 +
 1 file changed, 1 insertion(+)

diff --git a/contrib/buildsystems/engine.pl b/contrib/buildsystems/engine.pl
index 020776e..4a843f3 100755
--- a/contrib/buildsystems/engine.pl
+++ b/contrib/buildsystems/engine.pl
@@ -76,6 +76,7 @@ EOM
 # Capture the make dry stderr to file for review (will be empty for a release build).
 
 my $ErrsFile = "msvc-build-makedryerrors.txt";
+#@makedry = `cd $git_dir && make -n MSVC=1 V=1 1>makedry.txt 2>$ErrsFile`; # capture the dry run as a text file
 @makedry = `cd $git_dir && make -n MSVC=1 V=1 2>$ErrsFile` if !@makedry;
 # test for an empty Errors file and remove it
 for ($ErrsFile) {unlink $_ if (-f $_) && (!-s $_);}
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
