From: Philip Oakley <philipoakley@iee.org>
Subject: [PATCH 08/17] engine.pl: Fix i18n -o option in msvc
 buildsystem generator
Date: Thu, 25 Jun 2015 01:03:44 +0100
Message-ID: <1435190633-2208-9-git-send-email-philipoakley@iee.org>
References: <1435190633-2208-1-git-send-email-philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: MsysGitList <msysgit@googlegroups.com>,
	Philip Oakley <philipoakley@iee.org>
To: GitList <git@vger.kernel.org>
X-From: msysgit+bncBDSOTWHYX4PBBAUKVWWAKGQEAT7SHKI@googlegroups.com Thu Jun 25 02:02:16 2015
Return-path: <msysgit+bncBDSOTWHYX4PBBAUKVWWAKGQEAT7SHKI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wi0-f183.google.com ([209.85.212.183])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDSOTWHYX4PBBAUKVWWAKGQEAT7SHKI@googlegroups.com>)
	id 1Z7ucN-0001KV-LS
	for gcvm-msysgit@m.gmane.org; Thu, 25 Jun 2015 02:02:11 +0200
Received: by wibbw19 with SMTP id bw19sf18076774wib.0
        for <gcvm-msysgit@m.gmane.org>; Wed, 24 Jun 2015 17:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:from:to:cc:subject:date:message-id:in-reply-to
         :references:x-original-sender:x-original-authentication-results
         :content-type:precedence:mailing-list:list-id
         :x-spam-checked-in-group:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe;
        bh=nZhVGQG68kFJNzJDhDbB0XMFqbC/WbqAxhwXJO5YUZQ=;
        b=uHxbigJSOgtTnu/1+cjMchoKrHp287SqULPfi+BFXz84gVeEOvqioi+TzIpw7wGCy4
         23Pz9IOBDmlqJud1TU3TBgGy/MEnDcIA9tyztpePrCPMPIaGuHUAKgkzvtv9iA4pSq/q
         vpiH7t0aHOJs38aeycFreUwagwGSnxcHHQ6TDZo8OSFb/hd8QgL8GyKiDFMU13F335eK
         P62sOwPAUUZWa+9Uk2GCff9AEipeuRzRn6gYiLEAwQbz76fKW5ab+2DcSEbU8dLsGi3R
         JFP58tC3v0QjXP2MIj7IISQB229vTm3DkCh2MB/naorPUQY2H/ieuKEqFk320+Rsd9iF
         OG4g==
X-Received: by 10.152.44.200 with SMTP id g8mr438957lam.41.1435190531377;
        Wed, 24 Jun 2015 17:02:11 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.42.206 with SMTP id q14ls238134lal.58.gmail; Wed, 24 Jun
 2015 17:02:10 -0700 (PDT)
X-Received: by 10.152.115.147 with SMTP id jo19mr2865371lab.7.1435190530238;
        Wed, 24 Jun 2015 17:02:10 -0700 (PDT)
Received: from out1.ip01ir2.opaltelecom.net (out1.ip01ir2.opaltelecom.net. [62.24.128.237])
        by gmr-mx.google.com with ESMTP id da3si4921wib.1.2015.06.24.17.02.10
        for <msysgit@googlegroups.com>;
        Wed, 24 Jun 2015 17:02:10 -0700 (PDT)
Received-SPF: softfail (google.com: domain of transitioning philipoakley@iee.org does not designate 62.24.128.237 as permitted sender) client-ip=62.24.128.237;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: A2BvVwCSRItVPCWpEVxbgxFUX4FBhQuBWLBAhhKFegQCAoFMTQEBAQEBAQcBAQEBQT9BBYNdAQEEViMQCEk5ChQGE4gzzWoBAQEHIpBQB4QrBZQFhFiIdZY8gQmDGD0xgkgBAQE
X-IPAS-Result: A2BvVwCSRItVPCWpEVxbgxFUX4FBhQuBWLBAhhKFegQCAoFMTQEBAQEBAQcBAQEBQT9BBYNdAQEEViMQCEk5ChQGE4gzzWoBAQEHIpBQB4QrBZQFhFiIdZY8gQmDGD0xgkgBAQE
X-IronPort-AV: E=Sophos;i="5.13,673,1427756400"; 
   d="scan'208";a="784366774"
Received: from host-92-17-169-37.as13285.net (HELO localhost) ([92.17.169.37])
  by out1.ip01ir2.opaltelecom.net with ESMTP; 25 Jun 2015 01:01:56 +0100
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272624>

The i18n 5e9637c (i18n: add infrastructure for translating
Git with gettext, 2011-11-18) introduced an extra '-o' option
into the make file.

If the msvc buildsystem is run without NO_GETTEXT being set
then this broke the engine.pl code for extracting the git.sln
for msvc gui-IDE. The setting of NO_GETTEXT was not fixed until
later, relative to the Msysgit project where this issue was being
investigated.

The presence of these options in the Makefile output should not
compromise the derived build structure. They should be ignored.

Add tests to remove these non linker options, in same vein as
74cf9bd (engine.pl: Fix a recent breakage of the buildsystem
generator, 2010-01-22).

Signed-off-by: Philip Oakley <philipoakley@iee.org>
---
 contrib/buildsystems/engine.pl | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/contrib/buildsystems/engine.pl b/contrib/buildsystems/engine.pl
index ccb59fd..73f2472 100755
--- a/contrib/buildsystems/engine.pl
+++ b/contrib/buildsystems/engine.pl
@@ -141,6 +141,12 @@ sub parseMakeOutput
             next;
         }
 
+        if ($text =~ /^(mkdir|msgfmt) /) {
+            # options to the Portable Object translations
+            # the line "mkdir ... && msgfmt ..." contains no linker options
+            next;
+        }
+
         if($text =~ / -c /) {
             # compilation
             handleCompileLine($text, $line);
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
