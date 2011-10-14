From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: [PATCH 5/8] t9901: fix line-ending dependency on windows
Date: Fri, 14 Oct 2011 23:53:32 +0100
Message-ID: <1318632815-29945-6-git-send-email-patthoyts@users.sourceforge.net>
References: <1318632815-29945-1-git-send-email-patthoyts@users.sourceforge.net>
Mime-Version: 1.0
Cc: Junio C Hamano <gitster@pobox.com>,
	msysGit <msysgit@googlegroups.com>,
	Pat Thoyts <patthoyts@users.sourceforge.net>
To: Git <git@vger.kernel.org>
X-From: msysgit+bncCM7pyrzTCBDa--L0BBoEuDg-SA@googlegroups.com Sat Oct 15 00:55:55 2011
Return-path: <msysgit+bncCM7pyrzTCBDa--L0BBoEuDg-SA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wy0-f186.google.com ([74.125.82.186])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncCM7pyrzTCBDa--L0BBoEuDg-SA@googlegroups.com>)
	id 1REqfQ-0001EO-04
	for gcvm-msysgit@m.gmane.org; Sat, 15 Oct 2011 00:55:52 +0200
Received: by wyg19 with SMTP id 19sf5251039wyg.3
        for <gcvm-msysgit@m.gmane.org>; Fri, 14 Oct 2011 15:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=mime-version:x-beenthere:received-spf:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:x-cloudmark-analysis
         :x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:x-google-group-id:list-post:list-help
         :list-archive:sender:list-subscribe:list-unsubscribe;
        bh=D8i6tbyKok6I+qap+nOgagb3s3i0IA38VKhnpKWv6No=;
        b=rHE+pzye6Pmyyzx/JHjhtJYH2KxZTM3VgliwCfLLrNXMgR9UAZ0HcxAbWuM4Kqp/Ef
         +daKEAWukDqcL0zjArkLNDCgsVOxu44nvwQFjJ00e8y0gcntG43bY2ZMPJonS6ILMmbW
         cAgFJV11alnf8dSIm2aEfsWG6BL2ct8v3ju9A=
Received: by 10.216.176.2 with SMTP id a2mr1443026wem.12.1318632922248;
        Fri, 14 Oct 2011 15:55:22 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.227.91.77 with SMTP id l13ls3891734wbm.4.gmail; Fri, 14 Oct
 2011 15:55:21 -0700 (PDT)
Received: by 10.216.163.19 with SMTP id z19mr21062wek.7.1318632921522;
        Fri, 14 Oct 2011 15:55:21 -0700 (PDT)
Received: by 10.216.223.82 with SMTP id u60mswep;
        Fri, 14 Oct 2011 15:54:06 -0700 (PDT)
Received: by 10.216.163.19 with SMTP id z19mr20980wek.7.1318632846045;
        Fri, 14 Oct 2011 15:54:06 -0700 (PDT)
Received: by 10.216.163.19 with SMTP id z19mr20979wek.7.1318632846028;
        Fri, 14 Oct 2011 15:54:06 -0700 (PDT)
Received: from mtaout01-winn.ispmail.ntl.com (mtaout01-winn.ispmail.ntl.com. [81.103.221.47])
        by gmr-mx.google.com with ESMTP id v20si3219585wbn.1.2011.10.14.15.54.05;
        Fri, 14 Oct 2011 15:54:06 -0700 (PDT)
Received-SPF: pass (google.com: domain of pat@patthoyts.tk designates 81.103.221.47 as permitted sender) client-ip=81.103.221.47;
Received: from know-smtpout-4.server.virginmedia.net ([62.254.123.1])
          by mtaout01-winn.ispmail.ntl.com
          (InterMail vM.7.08.04.00 201-2186-134-20080326) with ESMTP
          id <20111014225405.NDNV13501.mtaout01-winn.ispmail.ntl.com@know-smtpout-4.server.virginmedia.net>;
          Fri, 14 Oct 2011 23:54:05 +0100
Received: from [94.171.235.235] (helo=fox.patthoyts.tk)
	by know-smtpout-4.server.virginmedia.net with esmtpa (Exim 4.63)
	(envelope-from <pat@patthoyts.tk>)
	id 1REqdh-0006aW-Gx; Fri, 14 Oct 2011 23:54:05 +0100
Received: by fox.patthoyts.tk (Postfix, from userid 1000)
	id 181EF20A65; Fri, 14 Oct 2011 23:54:05 +0100 (BST)
X-Mailer: git-send-email 1.7.5
In-Reply-To: <1318632815-29945-1-git-send-email-patthoyts@users.sourceforge.net>
X-Cloudmark-Analysis: v=1.1 cv=R50lirqlHffDPPkwUlkuVa99MrvKdVWo//yz83qex8g= c=1 sm=0 a=KTA09MSCTMUA:10 a=FP58Ms26AAAA:8 a=A1X0JdhQAAAA:8 a=igSemhJz925PCHaI57YA:9 a=4CtekVjYI_q4X3BU09EA:7 a=HpAAvcLHHh0Zw7uRqdWCyQ==:117
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183626>

Signed-off-by: Pat Thoyts <patthoyts@users.sourceforge.net>
---
 t/t9901-git-web--browse.sh |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/t/t9901-git-web--browse.sh b/t/t9901-git-web--browse.sh
index 7906e5d..1185b42 100755
--- a/t/t9901-git-web--browse.sh
+++ b/t/t9901-git-web--browse.sh
@@ -12,7 +12,7 @@ test_expect_success \
 	echo http://example.com/foo\&bar >expect &&
 	git config browser.custom.cmd echo &&
 	git web--browse --browser=custom \
-		http://example.com/foo\&bar >actual &&
+		http://example.com/foo\&bar | tr -d "\r" >actual &&
 	test_cmp expect actual
 '
 
@@ -21,7 +21,7 @@ test_expect_success \
 	echo http://example.com/foo\;bar >expect &&
 	git config browser.custom.cmd echo &&
 	git web--browse --browser=custom \
-		http://example.com/foo\;bar >actual &&
+		http://example.com/foo\;bar | tr -d "\r" >actual &&
 	test_cmp expect actual
 '
 
@@ -30,7 +30,7 @@ test_expect_success \
 	echo http://example.com/foo#bar >expect &&
 	git config browser.custom.cmd echo &&
 	git web--browse --browser=custom \
-		http://example.com/foo#bar >actual &&
+		http://example.com/foo#bar | tr -d "\r" >actual &&
 	test_cmp expect actual
 '
 
@@ -44,7 +44,7 @@ test_expect_success \
 	chmod +x "fake browser" &&
 	git config browser.w3m.path "`pwd`/fake browser" &&
 	git web--browse --browser=w3m \
-		http://example.com/foo >actual &&
+		http://example.com/foo | tr -d "\r" >actual &&
 	test_cmp expect actual
 '
 
@@ -59,7 +59,7 @@ test_expect_success \
 		}
 		f" &&
 	git web--browse --browser=custom \
-		http://example.com/foo >actual &&
+		http://example.com/foo | tr -d "\r" >actual &&
 	test_cmp expect actual
 '
 
-- 
1.7.7.1.gbba15
