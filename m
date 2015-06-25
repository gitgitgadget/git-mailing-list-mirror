From: Philip Oakley <philipoakley@iee.org>
Subject: [PATCH 09/17] engine.pl: ignore invalidcontinue.obj which
 is known to MSVC
Date: Thu, 25 Jun 2015 01:03:45 +0100
Message-ID: <1435190633-2208-10-git-send-email-philipoakley@iee.org>
References: <1435190633-2208-1-git-send-email-philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: MsysGitList <msysgit@googlegroups.com>,
	Philip Oakley <philipoakley@iee.org>
To: GitList <git@vger.kernel.org>
X-From: msysgit+bncBDSOTWHYX4PBBAUKVWWAKGQEAT7SHKI@googlegroups.com Thu Jun 25 02:02:22 2015
Return-path: <msysgit+bncBDSOTWHYX4PBBAUKVWWAKGQEAT7SHKI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-lb0-f189.google.com ([209.85.217.189])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDSOTWHYX4PBBAUKVWWAKGQEAT7SHKI@googlegroups.com>)
	id 1Z7ucN-0001Ji-9F
	for gcvm-msysgit@m.gmane.org; Thu, 25 Jun 2015 02:02:11 +0200
Received: by lbiv13 with SMTP id v13sf16791837lbi.0
        for <gcvm-msysgit@m.gmane.org>; Wed, 24 Jun 2015 17:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:from:to:cc:subject:date:message-id:in-reply-to
         :references:x-original-sender:x-original-authentication-results
         :content-type:precedence:mailing-list:list-id
         :x-spam-checked-in-group:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe;
        bh=JsUoUgdhyqTkFsYh14nYH8GJhEI7FXz4MXY6HicmRzA=;
        b=R6sJx3KVBOxHbKN2m0wtUnc3bDGlA22IXgD8U/4bcKY+3cMLQjJYlmKtBrnvKoYki6
         CJ3nqPFbE/7xrn3Jp53/ZkgO/ZwvZHS4PjJ5brHwBFNWeb3LvqCpGAQhH0A9wDTyPosK
         iBe+K5sP3bhWHdMZCtix2EMZmRPKb97wBc0SgE7lk9kmxxTAT7IXoSRZplcmR5y8QgFy
         zzBAqBP5gMkdXHBIQwd0MfdSIoP5u9WWfhlQDWwUDjN6KUllHptWkD3Qfojio6bRk2P0
         872/dwOKiWDV/8CuoGgFncpXi67zybKIMA2t2eHrId3NlfdZD9hKRzO7xlEcIpX8CD2G
         84QQ==
X-Received: by 10.180.11.239 with SMTP id t15mr66wib.1.1435190531002;
        Wed, 24 Jun 2015 17:02:11 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.99.3 with SMTP id em3ls515495wib.48.gmail; Wed, 24 Jun
 2015 17:02:10 -0700 (PDT)
X-Received: by 10.180.89.231 with SMTP id br7mr309222wib.0.1435190530251;
        Wed, 24 Jun 2015 17:02:10 -0700 (PDT)
Received: from out1.ip01ir2.opaltelecom.net (out1.ip01ir2.opaltelecom.net. [62.24.128.237])
        by gmr-mx.google.com with ESMTP id t6si17968wiz.0.2015.06.24.17.02.10
        for <msysgit@googlegroups.com>;
        Wed, 24 Jun 2015 17:02:10 -0700 (PDT)
Received-SPF: softfail (google.com: domain of transitioning philipoakley@iee.org does not designate 62.24.128.237 as permitted sender) client-ip=62.24.128.237;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: A2CYBwCSRItVPCWpEVxbgxFUX4ZMgViwQIYShXoEAgKBTE0BAQEBAQEHAQEBAUE/hCMBAQRWIxAISTkKFAYTiDPNagErkFAHhCsFlAWEWIh1ljyBCYMYPTGCSAEBAQ
X-IPAS-Result: A2CYBwCSRItVPCWpEVxbgxFUX4ZMgViwQIYShXoEAgKBTE0BAQEBAQEHAQEBAUE/hCMBAQRWIxAISTkKFAYTiDPNagErkFAHhCsFlAWEWIh1ljyBCYMYPTGCSAEBAQ
X-IronPort-AV: E=Sophos;i="5.13,673,1427756400"; 
   d="scan'208";a="784366775"
Received: from host-92-17-169-37.as13285.net (HELO localhost) ([92.17.169.37])
  by out1.ip01ir2.opaltelecom.net with ESMTP; 25 Jun 2015 01:01:57 +0100
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272625>

Commit 4b623d8 (MSVC: link in invalidcontinue.obj for better
POSIX compatibility, 2014-03-29) is not processed correctly
by the buildsystem. Ignore it.

Also split the .o and .obj processing; 'make' does not produce .obj
files. Only substitute filenames ending with .o when generating the
source .c filename.

Signed-off-by: Philip Oakley <philipoakley@iee.org>
---
 contrib/buildsystems/engine.pl | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/contrib/buildsystems/engine.pl b/contrib/buildsystems/engine.pl
index 73f2472..e8aa8ea 100755
--- a/contrib/buildsystems/engine.pl
+++ b/contrib/buildsystems/engine.pl
@@ -289,7 +289,7 @@ sub handleLibLine
 #    exit(1);
     foreach (@objfiles) {
         my $sourcefile = $_;
-        $sourcefile =~ s/\.o/.c/;
+        $sourcefile =~ s/\.o$/.c/;
         push(@sources, $sourcefile);
         push(@cflags, @{$compile_options{"${sourcefile}_CFLAGS"}});
         push(@defines, @{$compile_options{"${sourcefile}_DEFINES"}});
@@ -333,8 +333,12 @@ sub handleLinkLine
         } elsif ($part =~ /\.(a|lib)$/) {
             $part =~ s/\.a$/.lib/;
             push(@libs, $part);
-        } elsif ($part =~ /\.(o|obj)$/) {
+        } elsif ($part eq 'invalidcontinue.obj') {
+            # ignore - known to MSVC
+        } elsif ($part =~ /\.o$/) {
             push(@objfiles, $part);
+        } elsif ($part =~ /\.obj$/) {
+            # do nothing, 'make' should not be producing .obj, only .o files
         } else {
             die "Unhandled link option @ line $lineno: *$part*";
         }
@@ -343,7 +347,7 @@ sub handleLinkLine
 #    exit(1);
     foreach (@objfiles) {
         my $sourcefile = $_;
-        $sourcefile =~ s/\.o/.c/;
+        $sourcefile =~ s/\.o$/.c/;
         push(@sources, $sourcefile);
         push(@cflags, @{$compile_options{"${sourcefile}_CFLAGS"}});
         push(@defines, @{$compile_options{"${sourcefile}_DEFINES"}});
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
