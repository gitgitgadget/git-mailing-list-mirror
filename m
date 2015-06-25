From: Philip Oakley <philipoakley@iee.org>
Subject: [PATCH 04/17] Makefile: a dry-run can error out if no perl.
 Document the issue
Date: Thu, 25 Jun 2015 01:03:40 +0100
Message-ID: <1435190633-2208-5-git-send-email-philipoakley@iee.org>
References: <1435190633-2208-1-git-send-email-philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: MsysGitList <msysgit@googlegroups.com>,
	Philip Oakley <philipoakley@iee.org>
To: GitList <git@vger.kernel.org>
X-From: msysgit+bncBDSOTWHYX4PBBAUKVWWAKGQEAT7SHKI@googlegroups.com Thu Jun 25 02:02:16 2015
Return-path: <msysgit+bncBDSOTWHYX4PBBAUKVWWAKGQEAT7SHKI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-la0-f59.google.com ([209.85.215.59])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDSOTWHYX4PBBAUKVWWAKGQEAT7SHKI@googlegroups.com>)
	id 1Z7ucN-0001KJ-DO
	for gcvm-msysgit@m.gmane.org; Thu, 25 Jun 2015 02:02:11 +0200
Received: by lams18 with SMTP id s18sf16781082lam.0
        for <gcvm-msysgit@m.gmane.org>; Wed, 24 Jun 2015 17:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:from:to:cc:subject:date:message-id:in-reply-to
         :references:x-original-sender:x-original-authentication-results
         :content-type:precedence:mailing-list:list-id
         :x-spam-checked-in-group:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe;
        bh=Y9MfKy2t51J48ifxSbDvWwR7fetrgFxGasszHvZRwhg=;
        b=j73tNve+Hmcn/JX5ayjlhMPVGkVNOcImOgben/9OM4euRd+Pa1QEYxzCj0g2/VX6zO
         9p+YwdM/f8+CXaC6kvz/gzEmO19k1HuVlKu0Vba6aNLdvlQwu9S6e8TW00bk8dEa7/A2
         qSyd9e+8VL5gSQTCINKe1QJbsr1lQLG4S/Ss6+kopZd5eQ9pJzx+t60pvXqHvSdK0mw6
         nmZpRYRVBdOrkw3l1lmUz2kfSXign2ekmZMfokun867Ao7An/Sji8GmeW4GsL2/KeX6k
         eZZ5ZbAR71xLoiRXq1n8Ei1sqN0pfDi/pR6+s0CHJZSCsXg2vielc3bQp4z8ry8Xk20u
         Hnrg==
X-Received: by 10.152.5.195 with SMTP id u3mr545175lau.11.1435190531102;
        Wed, 24 Jun 2015 17:02:11 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.184.168 with SMTP id ev8ls267125lac.44.gmail; Wed, 24 Jun
 2015 17:02:09 -0700 (PDT)
X-Received: by 10.152.6.103 with SMTP id z7mr67414laz.8.1435190529932;
        Wed, 24 Jun 2015 17:02:09 -0700 (PDT)
Received: from out1.ip01ir2.opaltelecom.net (out1.ip01ir2.opaltelecom.net. [62.24.128.237])
        by gmr-mx.google.com with ESMTP id da3si4921wib.1.2015.06.24.17.02.09
        for <msysgit@googlegroups.com>;
        Wed, 24 Jun 2015 17:02:09 -0700 (PDT)
Received-SPF: softfail (google.com: domain of transitioning philipoakley@iee.org does not designate 62.24.128.237 as permitted sender) client-ip=62.24.128.237;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: A2BZVwCSRItVPCWpEVxbgxGBM4FBhQuBWLBAjAwEAgKBTE0BAQEBAQEHAQEBAUE/QQWDXQEBBFYjEAhJOQoUBhMbiBjNagEBAQcikFAHhCsFjBOHcqQJgQmDGD0xgkgBAQE
X-IPAS-Result: A2BZVwCSRItVPCWpEVxbgxGBM4FBhQuBWLBAjAwEAgKBTE0BAQEBAQEHAQEBAUE/QQWDXQEBBFYjEAhJOQoUBhMbiBjNagEBAQcikFAHhCsFjBOHcqQJgQmDGD0xgkgBAQE
X-IronPort-AV: E=Sophos;i="5.13,673,1427756400"; 
   d="scan'208";a="784366770"
Received: from host-92-17-169-37.as13285.net (HELO localhost) ([92.17.169.37])
  by out1.ip01ir2.opaltelecom.net with ESMTP; 25 Jun 2015 01:01:54 +0100
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272617>

A 'make -n' dry-run is used as part of the /compat/vcbuild and
/contrib/buildsystems code. The commit ee9be06 (perl: detect new files
in MakeMaker builds, 2012-07-27) was not aware of that dry-run usage
and thus would not execute the target.

Add a comment to the make file stating the issue and the available
solutions of either NO_PERL or a '+recipe'.

Signed-off-by: Philip Oakley <philipoakley@iee.org>
---
 Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Makefile b/Makefile
index 149f1c7..22108bb 100644
--- a/Makefile
+++ b/Makefile
@@ -1746,6 +1746,9 @@ $(SCRIPT_PERL_GEN): perl/perl.mak
 
 perl/perl.mak: perl/PM.stamp
 
+# 'make -n' (dry-run) will not execute this target which creates/updates the PM.stamp file.
+# To avoid the error of failing to find the target PM.stamp, either use NO_PERL=1 (YesPlease),
+# or add a leading '+' to the recipe '+$(QUIET_GEN)$(FIND) perl ...' so that it is executed.
 perl/PM.stamp: FORCE
 	@$(FIND) perl -type f -name '*.pm' | sort >$@+ && \
 	{ cmp $@+ $@ >/dev/null 2>/dev/null || mv $@+ $@; } && \
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
