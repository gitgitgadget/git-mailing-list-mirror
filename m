From: Philip Oakley <philipoakley@iee.org>
Subject: [PATCH v2 07/16] engine.pl: Fix i18n -o option in msvc
 buildsystem generator
Date: Sun, 19 Jul 2015 21:08:07 +0100
Message-ID: <1437336497-4072-8-git-send-email-philipoakley@iee.org>
References: <1437336497-4072-1-git-send-email-philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	MsysGit List <msysgit@googlegroups.com>,
	Yue Lin Ho <b8732003@student.nsysu.edu.tw>,
	Philip Oakley <philipoakley@iee.org>
To: Git List <git@vger.kernel.org>
X-From: msysgit+bncBDSOTWHYX4PBB24GWCWQKGQEBX26O5I@googlegroups.com Sun Jul 19 22:07:08 2015
Return-path: <msysgit+bncBDSOTWHYX4PBB24GWCWQKGQEBX26O5I@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-la0-f62.google.com ([209.85.215.62])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDSOTWHYX4PBB24GWCWQKGQEBX26O5I@googlegroups.com>)
	id 1ZGurb-0002Iv-QB
	for gcvm-msysgit@m.gmane.org; Sun, 19 Jul 2015 22:07:07 +0200
Received: by lagw2 with SMTP id w2sf52350639lag.0
        for <gcvm-msysgit@m.gmane.org>; Sun, 19 Jul 2015 13:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:from:to:cc:subject:date:message-id:in-reply-to
         :references:x-original-sender:x-original-authentication-results
         :content-type:precedence:mailing-list:list-id
         :x-spam-checked-in-group:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe;
        bh=L5VS3RCjP2vzRMz9gJ+OL9IsuIAqifmMHsM+34FQLp8=;
        b=QViQo62rbtjZVyP2SjyiMPf4trP9JTmRo9jOTD/rdJtvBGgz0/K94MOBbxhgbMtKXK
         zpcxKLKLgWxDpmk406Z12wvlhv8jE41ifljTooXFFN6Xlrt2YhWJlWMJ9x6aGGUTvhNX
         rRuKx0jdAUvKS6r+v6RyVUPUgx4Eka8s5HhHAPWs/fBKosUnC5Hkessxnhq8/Kk4lF0M
         5BOMB8bz5cwUyhDdr+u7hGsUZuaS/VZW1ngjsjF21H9sGhEXsO0zqRH4PthtesYXDn9w
         gOugKfj7xrXoQj+HEP4yUb1hspk4BlvDt77MRgeWcKwTxyqF/m0sLnwRqgCaMP/wKIa7
         XvXA==
X-Received: by 10.180.188.240 with SMTP id gd16mr28456wic.18.1437336427549;
        Sun, 19 Jul 2015 13:07:07 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.181.27.230 with SMTP id jj6ls671038wid.20.canary; Sun, 19 Jul
 2015 13:07:06 -0700 (PDT)
X-Received: by 10.180.75.49 with SMTP id z17mr4454455wiv.7.1437336426896;
        Sun, 19 Jul 2015 13:07:06 -0700 (PDT)
Received: from out1.ip02ir2.opaltelecom.net (out1.ip02ir2.opaltelecom.net. [62.24.128.238])
        by gmr-mx.google.com with ESMTP id gt9si270946wib.2.2015.07.19.13.07.06
        for <msysgit@googlegroups.com>;
        Sun, 19 Jul 2015 13:07:06 -0700 (PDT)
Received-SPF: softfail (google.com: domain of transitioning philipoakley@iee.org does not designate 62.24.128.238 as permitted sender) client-ip=62.24.128.238;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: A2C7LACSAqxVPN4GFlxcgkFSVGmBRYUMtRQJgW2FeQQCAoEaORQBAQEBAQEBBgEBAQFAAT+EJAEBBFYjEAhJOQoUBhOIMsRoASuQUgeEKwWUUoRviTuWfoEJgxo9MYJLAQEB
X-IPAS-Result: A2C7LACSAqxVPN4GFlxcgkFSVGmBRYUMtRQJgW2FeQQCAoEaORQBAQEBAQEBBgEBAQFAAT+EJAEBBFYjEAhJOQoUBhOIMsRoASuQUgeEKwWUUoRviTuWfoEJgxo9MYJLAQEB
X-IronPort-AV: E=Sophos;i="5.15,504,1432594800"; 
   d="scan'208";a="39118935"
Received: from host-92-22-6-222.as13285.net (HELO localhost) ([92.22.6.222])
  by out1.ip02ir2.opaltelecom.net with ESMTP; 19 Jul 2015 21:07:07 +0100
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274281>

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
index 24b8992..60c7a7d 100755
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
