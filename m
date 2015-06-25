From: Philip Oakley <philipoakley@iee.org>
Subject: [PATCH 06/17] engine.pl: Avoid complications with perl support
Date: Thu, 25 Jun 2015 01:03:42 +0100
Message-ID: <1435190633-2208-7-git-send-email-philipoakley@iee.org>
References: <1435190633-2208-1-git-send-email-philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: MsysGitList <msysgit@googlegroups.com>,
	Philip Oakley <philipoakley@iee.org>
To: GitList <git@vger.kernel.org>
X-From: msysgit+bncBDSOTWHYX4PBBAUKVWWAKGQEAT7SHKI@googlegroups.com Thu Jun 25 02:02:12 2015
Return-path: <msysgit+bncBDSOTWHYX4PBBAUKVWWAKGQEAT7SHKI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wg0-f56.google.com ([74.125.82.56])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDSOTWHYX4PBBAUKVWWAKGQEAT7SHKI@googlegroups.com>)
	id 1Z7ucN-0001KU-LC
	for gcvm-msysgit@m.gmane.org; Thu, 25 Jun 2015 02:02:11 +0200
Received: by wggx12 with SMTP id x12sf16726525wgg.1
        for <gcvm-msysgit@m.gmane.org>; Wed, 24 Jun 2015 17:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:from:to:cc:subject:date:message-id:in-reply-to
         :references:x-original-sender:x-original-authentication-results
         :content-type:precedence:mailing-list:list-id
         :x-spam-checked-in-group:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe;
        bh=I6loKpIjx/RIOXbSWwNhQ+i5uFdM+nus39YMf9v2TMs=;
        b=cSwNd5MZi2O8bBD88scQfburSa1Ntg5bf2cFDuScS0XmVPN01toe/y/rwJKl5HNf/r
         jai2/VqFUVRNjrb7EhzKBQeA+on59L3Oo/pHgxmOMErdOdIXa1BhDKlCBg+vKhfM7Szz
         3qlTl7l2aevge8E+Bx3qjR622DxT7eiSBCHZNsB0ujcYzdX+bXklNvgpAaalnpWEN2yB
         zrTq/fI0uukRrdjiSavG6H2unB1zAVIC2PcafqPhimNjrAxuPwQQvcqPONE7vEggB+A6
         +CttxM2FLk0zVFXWU9rYGKA4pC62Kb28/1+ivtSBa95dUEec+qflis4BMfC4k8yrqHCX
         SPGA==
X-Received: by 10.152.244.131 with SMTP id xg3mr557718lac.0.1435190531334;
        Wed, 24 Jun 2015 17:02:11 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.170.227 with SMTP id ap3ls278201lac.21.gmail; Wed, 24 Jun
 2015 17:02:10 -0700 (PDT)
X-Received: by 10.152.5.2 with SMTP id o2mr37773798lao.0.1435190530133;
        Wed, 24 Jun 2015 17:02:10 -0700 (PDT)
Received: from out1.ip01ir2.opaltelecom.net (out1.ip01ir2.opaltelecom.net. [62.24.128.237])
        by gmr-mx.google.com with ESMTP id da3si4921wib.1.2015.06.24.17.02.10
        for <msysgit@googlegroups.com>;
        Wed, 24 Jun 2015 17:02:10 -0700 (PDT)
Received-SPF: softfail (google.com: domain of transitioning philipoakley@iee.org does not designate 62.24.128.237 as permitted sender) client-ip=62.24.128.237;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: A2C1DwCSRItVPCWpEVxbgxFUX4ZMgViwQIYShXoEAgKBTE0BAQEBAQEHAQEBAUE/QQWDXQEBBFYjEAhJOQoUBhOIM81qASuPa2UHhCsFlAWEWIh1ljyBCYEpHIFTPTGBA4FFAQEB
X-IPAS-Result: A2C1DwCSRItVPCWpEVxbgxFUX4ZMgViwQIYShXoEAgKBTE0BAQEBAQEHAQEBAUE/QQWDXQEBBFYjEAhJOQoUBhOIM81qASuPa2UHhCsFlAWEWIh1ljyBCYEpHIFTPTGBA4FFAQEB
X-IronPort-AV: E=Sophos;i="5.13,673,1427756400"; 
   d="scan'208";a="784366772"
Received: from host-92-17-169-37.as13285.net (HELO localhost) ([92.17.169.37])
  by out1.ip01ir2.opaltelecom.net with ESMTP; 25 Jun 2015 01:01:55 +0100
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272612>

ee9be06 (perl: detect new files in MakeMaker builds, 2012-07-27)
did not include dry-run support for the generation of the PM.stamp
file, though the dry-run output is used by the build engine.

Disable the perl processing during the dry-run to avoid the issue.

Signed-off-by: Philip Oakley <philipoakley@iee.org>
---
 contrib/buildsystems/engine.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/buildsystems/engine.pl b/contrib/buildsystems/engine.pl
index 5398315..4d0a616 100755
--- a/contrib/buildsystems/engine.pl
+++ b/contrib/buildsystems/engine.pl
@@ -72,7 +72,7 @@ Running GNU Make to figure out build structure...
 EOM
 
 # Pipe a make --dry-run into a variable, if not already loaded from file
-@makedry = `cd $git_dir && make -n MSVC=1 V=1 2>/dev/null` if !@makedry;
+@makedry = `cd $git_dir && make -n MSVC=1 NO_PERL=1 V=1 2>/dev/null` if !@makedry;
 
 # Parse the make output into usable info
 parseMakeOutput();
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
