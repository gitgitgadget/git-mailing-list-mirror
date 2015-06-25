From: Philip Oakley <philipoakley@iee.org>
Subject: [PATCH 12/17] engine.pl: add debug line to capture the dry-run
Date: Thu, 25 Jun 2015 01:03:48 +0100
Message-ID: <1435190633-2208-13-git-send-email-philipoakley@iee.org>
References: <1435190633-2208-1-git-send-email-philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: MsysGitList <msysgit@googlegroups.com>,
	Philip Oakley <philipoakley@iee.org>
To: GitList <git@vger.kernel.org>
X-From: msysgit+bncBDSOTWHYX4PBBAUKVWWAKGQEAT7SHKI@googlegroups.com Thu Jun 25 02:02:21 2015
Return-path: <msysgit+bncBDSOTWHYX4PBBAUKVWWAKGQEAT7SHKI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wg0-f60.google.com ([74.125.82.60])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDSOTWHYX4PBBAUKVWWAKGQEAT7SHKI@googlegroups.com>)
	id 1Z7ucN-0001KK-E3
	for gcvm-msysgit@m.gmane.org; Thu, 25 Jun 2015 02:02:11 +0200
Received: by wggx12 with SMTP id x12sf16726480wgg.1
        for <gcvm-msysgit@m.gmane.org>; Wed, 24 Jun 2015 17:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:from:to:cc:subject:date:message-id:in-reply-to
         :references:x-original-sender:x-original-authentication-results
         :content-type:precedence:mailing-list:list-id
         :x-spam-checked-in-group:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe;
        bh=3QYlDahlz0Kxg1LqOGGq4aJ8VYiuszW0cUBh2r8s4V8=;
        b=zRpUyMRXszriyhvqgbCTb3lDN9r4vdB69ZkEFgtnyA5WCtiNRTFAbYjNuFst5S+QkF
         YVvdkl1iiojpqoZbJhf67ZgdrWGLR5XqiEE27Mhs05imbIMz/mnvGdUHbSsaRxHetsRr
         SkyC/HKI6k+6VQ8GFWw2T8glc/jqCGfYlFzbbKGNtTG1lP4DXowMABh1gEizBE8xvKzF
         61srjXzpQBmh5TURFobOgqhAWe12dgnyYC+JC8/yX+UmYHiRTkUrIHmb+dcqCUC1v9V+
         HaOlCm8iY9LPnf+U+QhAvTXNofheN1O7byoBb+USCeiAxP25aFCmdFwVsvUlPxqD7Iyy
         DiCg==
X-Received: by 10.180.149.168 with SMTP id ub8mr2064wib.17.1435190531128;
        Wed, 24 Jun 2015 17:02:11 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.24.135 with SMTP id u7ls513979wif.42.gmail; Wed, 24 Jun
 2015 17:02:10 -0700 (PDT)
X-Received: by 10.180.90.106 with SMTP id bv10mr292891wib.6.1435190530390;
        Wed, 24 Jun 2015 17:02:10 -0700 (PDT)
Received: from out1.ip01ir2.opaltelecom.net (out1.ip01ir2.opaltelecom.net. [62.24.128.237])
        by gmr-mx.google.com with ESMTP id t6si17968wiz.0.2015.06.24.17.02.10
        for <msysgit@googlegroups.com>;
        Wed, 24 Jun 2015 17:02:10 -0700 (PDT)
Received-SPF: softfail (google.com: domain of transitioning philipoakley@iee.org does not designate 62.24.128.237 as permitted sender) client-ip=62.24.128.237;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: A2C1DwCSRItVPCWpEVxbgxFUX4ZMgViwQIYShXoEAgKBTE0BAQEBAQEHAQEBAUE/QQWDXQEBBFYjEAhJOQoUBhOIM81qLJBQB4QrBZQFhFiIdZY8gQmDGD0xgkgBAQE
X-IPAS-Result: A2C1DwCSRItVPCWpEVxbgxFUX4ZMgViwQIYShXoEAgKBTE0BAQEBAQEHAQEBAUE/QQWDXQEBBFYjEAhJOQoUBhOIM81qLJBQB4QrBZQFhFiIdZY8gQmDGD0xgkgBAQE
X-IronPort-AV: E=Sophos;i="5.13,673,1427756400"; 
   d="scan'208";a="784366780"
Received: from host-92-17-169-37.as13285.net (HELO localhost) ([92.17.169.37])
  by out1.ip01ir2.opaltelecom.net with ESMTP; 25 Jun 2015 01:01:59 +0100
X-Mailer: git-send-email 2.3.1
In-Reply-To: <1435190633-2208-1-git-send-email-philipoakley@iee.org>
X-Original-Sender: philipoakley@iee.org
X-Original-Authentication-Results: gmr-mx.google.com;       spf=softfail
 (google.com: domain of transitioning philipoakley@iee.org does not designate
 62.24.128.237 as permitted sender) smtp.mail=philipoakley@iee.org
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272620>

Add a debug suggestion for capturing to file the stdout from the dry-run
of the make file used in determining the msvc-build structure for easy
debugging.

Signed-off-by: Philip Oakley <philipoakley@iee.org>
---
 contrib/buildsystems/engine.pl | 1 +
 1 file changed, 1 insertion(+)

diff --git a/contrib/buildsystems/engine.pl b/contrib/buildsystems/engine.pl
index 27884f7..7a2aeef 100644
--- a/contrib/buildsystems/engine.pl
+++ b/contrib/buildsystems/engine.pl
@@ -76,6 +76,7 @@ EOM
 # Capture the make dry stderr to file for review (will be empty for a release build).
 
 my $ErrsFile = "msvc-build-makedryerrors.txt";
+#@makedry = `cd $git_dir && make -n MSVC=1 NO_PERL=1 V=1 1>makedry.txt 2>$ErrsFile`; # capture the dry run as a text file
 @makedry = `cd $git_dir && make -n MSVC=1 NO_PERL=1 V=1 2>$ErrsFile` if !@makedry;
 # test for an empty Errors file and remove it
 for ($ErrsFile) {unlink $_ if (-f $_) && (!-s $_);}
-- 
2.3.1

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
