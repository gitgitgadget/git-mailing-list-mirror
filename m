From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: [PATCH 2/8] t1402: Ignore a few cases that must fail due to
 DOS path expansion
Date: Fri, 14 Oct 2011 23:53:29 +0100
Message-ID: <1318632815-29945-3-git-send-email-patthoyts@users.sourceforge.net>
References: <1318632815-29945-1-git-send-email-patthoyts@users.sourceforge.net>
Mime-Version: 1.0
Cc: Junio C Hamano <gitster@pobox.com>,
	msysGit <msysgit@googlegroups.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Git <git@vger.kernel.org>
X-From: msysgit+bncCM7pyrzTCBDa--L0BBoEuDg-SA@googlegroups.com Sat Oct 15 00:55:52 2011
Return-path: <msysgit+bncCM7pyrzTCBDa--L0BBoEuDg-SA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wy0-f186.google.com ([74.125.82.186])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncCM7pyrzTCBDa--L0BBoEuDg-SA@googlegroups.com>)
	id 1REqfQ-0001EN-0v
	for gcvm-msysgit@m.gmane.org; Sat, 15 Oct 2011 00:55:52 +0200
Received: by wyg19 with SMTP id 19sf5251037wyg.3
        for <gcvm-msysgit@m.gmane.org>; Fri, 14 Oct 2011 15:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=mime-version:x-beenthere:received-spf:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:x-cloudmark-analysis
         :x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:x-google-group-id:list-post:list-help
         :list-archive:sender:list-subscribe:list-unsubscribe;
        bh=0kGPdaXBJFSob+10CQAaj712mq3PNxxvtImG7jIFcDk=;
        b=CBfxifDUaDK3s8sD9npAb7IlD24WnGrJkmgPq19dMP51tJb+Mzi2Nrup+qCT514OFU
         AyEG4ghLcQQdJp+USJSs4wnKdHqRl8ZVPMhIwatLbUxuJHWFCtagWkFAjL6bSxlHNyXQ
         LEQHHvd49p0sSV7jRCGA2zG88lvtSLIL6AHzg=
Received: by 10.216.134.135 with SMTP id s7mr1450942wei.4.1318632922216;
        Fri, 14 Oct 2011 15:55:22 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.227.207.213 with SMTP id fz21ls3798924wbb.5.gmail; Fri, 14 Oct
 2011 15:55:21 -0700 (PDT)
Received: by 10.216.221.89 with SMTP id q67mr267940wep.2.1318632921328;
        Fri, 14 Oct 2011 15:55:21 -0700 (PDT)
Received: by 10.216.223.82 with SMTP id u60mswep;
        Fri, 14 Oct 2011 15:54:04 -0700 (PDT)
Received: by 10.216.173.73 with SMTP id u51mr60029wel.0.1318632843834;
        Fri, 14 Oct 2011 15:54:03 -0700 (PDT)
Received: by 10.216.173.73 with SMTP id u51mr60028wel.0.1318632843817;
        Fri, 14 Oct 2011 15:54:03 -0700 (PDT)
Received: from mtaout01-winn.ispmail.ntl.com (mtaout01-winn.ispmail.ntl.com. [81.103.221.47])
        by gmr-mx.google.com with ESMTP id es13si5618830wbb.3.2011.10.14.15.54.03;
        Fri, 14 Oct 2011 15:54:03 -0700 (PDT)
Received-SPF: pass (google.com: domain of pat@patthoyts.tk designates 81.103.221.47 as permitted sender) client-ip=81.103.221.47;
Received: from know-smtpout-4.server.virginmedia.net ([62.254.123.1])
          by mtaout01-winn.ispmail.ntl.com
          (InterMail vM.7.08.04.00 201-2186-134-20080326) with ESMTP
          id <20111014225403.NDMP13501.mtaout01-winn.ispmail.ntl.com@know-smtpout-4.server.virginmedia.net>;
          Fri, 14 Oct 2011 23:54:03 +0100
Received: from [94.171.235.235] (helo=fox.patthoyts.tk)
	by know-smtpout-4.server.virginmedia.net with esmtpa (Exim 4.63)
	(envelope-from <pat@patthoyts.tk>)
	id 1REqdf-0006ZO-9j; Fri, 14 Oct 2011 23:54:03 +0100
Received: by fox.patthoyts.tk (Postfix, from userid 1000)
	id B58B720A65; Fri, 14 Oct 2011 23:54:02 +0100 (BST)
X-Mailer: git-send-email 1.7.5
In-Reply-To: <1318632815-29945-1-git-send-email-patthoyts@users.sourceforge.net>
X-Cloudmark-Analysis: v=1.1 cv=JvdXmxIgLJv2/GthKqHpGJEEHukvLcvELVXUanXFreg= c=1 sm=0 a=xGBK89QPo58A:10 a=axb06tfE-4VaNrAIEFEA:9 a=_RhRFcbxBZMA:10 a=HpAAvcLHHh0Zw7uRqdWCyQ==:117
X-Original-Sender: patthoyts@users.sourceforge.net
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 domain of pat@patthoyts.tk designates 81.103.221.47 as permitted sender) smtp.mail=pat@patthoyts.tk
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post?hl=en_US>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=en_US>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=en_US>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, <mailto:msysgit+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183623>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t1402-check-ref-format.sh |   15 +++++++++------
 1 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/t/t1402-check-ref-format.sh b/t/t1402-check-ref-format.sh
index 710fcca..1a5e343 100755
--- a/t/t1402-check-ref-format.sh
+++ b/t/t1402-check-ref-format.sh
@@ -36,7 +36,7 @@ invalid_ref 'refs///heads/foo'
 valid_ref 'refs///heads/foo' --normalize
 invalid_ref 'heads/foo/'
 invalid_ref '/heads/foo'
-valid_ref '/heads/foo' --normalize
+test_have_prereq MINGW || valid_ref '/heads/foo' --normalize
 invalid_ref '///heads/foo'
 valid_ref '///heads/foo' --normalize
 invalid_ref './foo'
@@ -120,9 +120,12 @@ invalid_ref "$ref" --allow-onelevel
 invalid_ref "$ref" --refspec-pattern
 invalid_ref "$ref" '--refspec-pattern --allow-onelevel'
 invalid_ref "$ref" --normalize
-valid_ref "$ref" '--allow-onelevel --normalize'
-invalid_ref "$ref" '--refspec-pattern --normalize'
-valid_ref "$ref" '--refspec-pattern --allow-onelevel --normalize'
+if test_have_prereq NOT_MINGW
+then
+	valid_ref "$ref" '--allow-onelevel --normalize'
+	invalid_ref "$ref" '--refspec-pattern --normalize'
+	valid_ref "$ref" '--refspec-pattern --allow-onelevel --normalize'
+fi
 
 test_expect_success "check-ref-format --branch @{-1}" '
 	T=$(git write-tree) &&
@@ -166,10 +169,10 @@ invalid_ref_normalized() {
 
 valid_ref_normalized 'heads/foo' 'heads/foo'
 valid_ref_normalized 'refs///heads/foo' 'refs/heads/foo'
-valid_ref_normalized '/heads/foo' 'heads/foo'
+test_have_prereq MINGW || valid_ref_normalized '/heads/foo' 'heads/foo'
 valid_ref_normalized '///heads/foo' 'heads/foo'
 invalid_ref_normalized 'foo'
-invalid_ref_normalized '/foo'
+test_have_prereq MINGW || invalid_ref_normalized '/foo'
 invalid_ref_normalized 'heads/foo/../bar'
 invalid_ref_normalized 'heads/./foo'
 invalid_ref_normalized 'heads\foo'
-- 
1.7.7.1.gbba15
