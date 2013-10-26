From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH 3/3] tests: undo special treatment of CRLF for Windows
Date: Sat, 26 Oct 2013 21:17:16 +0200
Message-ID: <0ad7f072a5ded97057660882e5a7a56649488a41.1382814437.git.j6t@kdbg.org>
References: <cover.1382814437.git.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: msysgit@googlegroups.com,
	Johannes Sixt <j6t@kdbg.org>
To: git@vger.kernel.org
X-From: msysgit+bncBCJYV6HBKQIM3KVQSMCRUBBWPOZ7Q@googlegroups.com Sat Oct 26 21:17:36 2013
Return-path: <msysgit+bncBCJYV6HBKQIM3KVQSMCRUBBWPOZ7Q@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-we0-f189.google.com ([74.125.82.189])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCJYV6HBKQIM3KVQSMCRUBBWPOZ7Q@googlegroups.com>)
	id 1Va9Mb-0004io-To
	for gcvm-msysgit@m.gmane.org; Sat, 26 Oct 2013 21:17:33 +0200
Received: by mail-we0-f189.google.com with SMTP id t60sf586551wes.26
        for <gcvm-msysgit@m.gmane.org>; Sat, 26 Oct 2013 12:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:from:to:cc:subject:date:message-id:in-reply-to
         :references:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=AJ/SyfCuTSf9g8peuFhK+gcY4wt6/3EBYKAKIsrF8xM=;
        b=LDhc3TSoiqnSTsIdVeSb1/VXXaSZLPIOIQFEBLjfwaSnxvKHxH2GeygUSO2vKds2xa
         2HckpoXcggjA5shti58po3IvB02Q1DTo4/I9DYaiZrLEvdbSezIYuyN5wpr21wXDpidG
         zh2s9Wt8zjwfNSqL3iHenBzfvRDtIppaxBODy/fv5E5OGdpBzjIG7ZvdXAuxTOie/GMo
         RgMtacKPMC+7M67tTPSrNLA5uNkgiH2Rpy2FUM+uAiai/0UDR2oGSrZj2S5eg4xLaaU0
         YSvI1VZlFKdkylPPAZeomy1MAuKOcDONeq2RMXr0w0xZWY91JN7S4Q3xUg7ybWjPe17b
         6/Yw==
X-Received: by 10.180.105.71 with SMTP id gk7mr34386wib.7.1382815053530;
        Sat, 26 Oct 2013 12:17:33 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.14.138 with SMTP id p10ls293706wic.8.gmail; Sat, 26 Oct
 2013 12:17:32 -0700 (PDT)
X-Received: by 10.180.21.137 with SMTP id v9mr1476068wie.7.1382815052735;
        Sat, 26 Oct 2013 12:17:32 -0700 (PDT)
Received: from bsmtp.bon.at (bsmtp5.bon.at. [195.3.86.187])
        by gmr-mx.google.com with ESMTP id a1si2127048ees.1.2013.10.26.12.17.32
        for <msysgit@googlegroups.com>;
        Sat, 26 Oct 2013 12:17:32 -0700 (PDT)
Received-SPF: neutral (google.com: 195.3.86.187 is neither permitted nor denied by best guess record for domain of j6t@kdbg.org) client-ip=195.3.86.187;
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 7FD7413004B;
	Sat, 26 Oct 2013 21:17:32 +0200 (CEST)
Received: from dx.sixt.local (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 1F67F19F671;
	Sat, 26 Oct 2013 21:17:32 +0200 (CEST)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236766>

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 t/lib-credential.sh          | 4 ----
 t/t7407-submodule-foreach.sh | 4 ----
 t/t9001-send-email.sh        | 1 -
 3 files changed, 9 deletions(-)

diff --git a/t/lib-credential.sh b/t/lib-credential.sh
index 3c43ff1..957ae93 100755
--- a/t/lib-credential.sh
+++ b/t/lib-credential.sh
@@ -18,10 +18,6 @@ check() {
 		cat stderr &&
 		false
 	fi &&
-	if test_have_prereq MINGW
-	then
-		dos2unix -q stderr
-	fi &&
 	test_cmp expect-stdout stdout &&
 	test_cmp expect-stderr stderr
 }
diff --git a/t/t7407-submodule-foreach.sh b/t/t7407-submodule-foreach.sh
index be93f10..b64c9ed 100755
--- a/t/t7407-submodule-foreach.sh
+++ b/t/t7407-submodule-foreach.sh
@@ -254,10 +254,6 @@ test_expect_success 'ensure "status --cached --recursive" preserves the --cached
 		) &&
 		git submodule status --cached --recursive -- nested1 > ../actual
 	) &&
-	if test_have_prereq MINGW
-	then
-		dos2unix actual
-	fi &&
 	test_cmp expect actual
 '
 
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 2813aa9..3119c8c 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -23,7 +23,6 @@ test_expect_success $PREREQ \
       echo do
       echo "  echo \"!\$a!\""
       echo "done >commandline\$output"
-      test_have_prereq MINGW && echo "dos2unix commandline\$output"
       echo "cat > msgtxt\$output"
       ) >fake.sendmail &&
      chmod +x ./fake.sendmail &&
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
