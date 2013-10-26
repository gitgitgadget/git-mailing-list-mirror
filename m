From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH 1/3] t5300-pack-object: do not compare binary data
 using test_cmp
Date: Sat, 26 Oct 2013 21:17:14 +0200
Message-ID: <f950a2a60c0798650646157b1785f8e9e558b7af.1382814437.git.j6t@kdbg.org>
References: <cover.1382814437.git.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: msysgit@googlegroups.com,
	Johannes Sixt <j6t@kdbg.org>
To: git@vger.kernel.org
X-From: msysgit+bncBCJYV6HBKQIM3KVQSMCRUBBWPOZ7Q@googlegroups.com Sat Oct 26 21:17:34 2013
Return-path: <msysgit+bncBCJYV6HBKQIM3KVQSMCRUBBWPOZ7Q@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-bk0-f63.google.com ([209.85.214.63])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCJYV6HBKQIM3KVQSMCRUBBWPOZ7Q@googlegroups.com>)
	id 1Va9Mb-0004im-Mj
	for gcvm-msysgit@m.gmane.org; Sat, 26 Oct 2013 21:17:33 +0200
Received: by mail-bk0-f63.google.com with SMTP id 6sf400523bkj.8
        for <gcvm-msysgit@m.gmane.org>; Sat, 26 Oct 2013 12:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:from:to:cc:subject:date:message-id:in-reply-to
         :references:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=AV6ISsOnQl42Us4ZZNr1xs4IXzQ3x2/nkxDmph+o8KA=;
        b=LWarbe9sS+SKR7+Z937cJKaua+VnP0tHNYX4J0eZ1+isygpMVdQxnvGfK+zf8vISpd
         7Zs8Cyz4EM7B0iA61Myl/2O4dvdpGlLiJU834Mmlf8M1/e2IM20/wHWYp5sbm5XyPVlg
         7pGJX1NcnXS6WBEFxYMdWXOFv3Cg/SQxVeBqIg+sY1pGyz6E6sN5Rfh7E4lmkV2EBdWg
         qe/FYziTd1w2Ril76V9qVR5OMVqzfj2nbYk7zQ+JOzi4DS2pgSwAQxrwygJo2L0KpmPg
         j62YralAqE/qGZlPuC6hNXQ+1ovntbY//VFNL1oo8rglkhDSBeUHLrA9lw6ExTClqohc
         Tbcw==
X-Received: by 10.152.4.41 with SMTP id h9mr32545lah.8.1382815053433;
        Sat, 26 Oct 2013 12:17:33 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.170.134 with SMTP id am6ls377910lac.22.gmail; Sat, 26 Oct
 2013 12:17:32 -0700 (PDT)
X-Received: by 10.112.11.20 with SMTP id m20mr3457353lbb.4.1382815052879;
        Sat, 26 Oct 2013 12:17:32 -0700 (PDT)
Received: from bsmtp.bon.at (bsmtp5.bon.at. [195.3.86.187])
        by gmr-mx.google.com with ESMTPS id a1si2127654ees.1.2013.10.26.12.17.32
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 26 Oct 2013 12:17:32 -0700 (PDT)
Received-SPF: neutral (google.com: 195.3.86.187 is neither permitted nor denied by best guess record for domain of j6t@kdbg.org) client-ip=195.3.86.187;
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 6BE92CDF82;
	Sat, 26 Oct 2013 21:17:32 +0200 (CEST)
Received: from dx.sixt.local (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id DFC0B19F64D;
	Sat, 26 Oct 2013 21:17:31 +0200 (CEST)
X-Mailer: git-send-email 1.8.4.33.gd68f7e8
In-Reply-To: <cover.1382814437.git.j6t@kdbg.org>
X-Original-Sender: j6t@kdbg.org
X-Original-Authentication-Results: gmr-mx.google.com;       spf=neutral
 (google.com: 195.3.86.187 is neither permitted nor denied by best guess
 record for domain of j6t@kdbg.org) smtp.mail=j6t@kdbg.org
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236764>

Users may set test_cmp to a comparison tool of their liking. The intent is
that the tool performs comparison of line-oriented texts. However, t5300
uses it also to compare binary data. Change those tests to use 'cmp'.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 t/t5300-pack-object.sh | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
index a07c871..61e787d 100755
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -151,7 +151,7 @@ test_expect_success \
 	    git cat-file $t $object || return 1
 	 done <obj-list
     } >current &&
-    test_cmp expect current'
+    cmp expect current'
 
 test_expect_success \
     'use packed deltified (REF_DELTA) objects' \
@@ -166,7 +166,7 @@ test_expect_success \
 	    git cat-file $t $object || return 1
 	 done <obj-list
     } >current &&
-    test_cmp expect current'
+    cmp expect current'
 
 test_expect_success \
     'use packed deltified (OFS_DELTA) objects' \
@@ -181,7 +181,7 @@ test_expect_success \
 	    git cat-file $t $object || return 1
 	 done <obj-list
     } >current &&
-    test_cmp expect current'
+    cmp expect current'
 
 unset GIT_OBJECT_DIRECTORY
 
@@ -195,9 +195,9 @@ test_expect_success 'survive missing objects/pack directory' '
 		rm -fr $GOP &&
 		git index-pack --stdin --keep=test <../test-3-${packname_3}.pack &&
 		test -f $GOP/pack-${packname_3}.pack &&
-		test_cmp $GOP/pack-${packname_3}.pack ../test-3-${packname_3}.pack &&
+		cmp $GOP/pack-${packname_3}.pack ../test-3-${packname_3}.pack &&
 		test -f $GOP/pack-${packname_3}.idx &&
-		test_cmp $GOP/pack-${packname_3}.idx ../test-3-${packname_3}.idx &&
+		cmp $GOP/pack-${packname_3}.idx ../test-3-${packname_3}.idx &&
 		test -f $GOP/pack-${packname_3}.keep
 	)
 '
-- 
1.8.4.33.gd68f7e8

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
You received this message because you are subscribed to the Google Groups "msysGit" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/groups/opt_out.
