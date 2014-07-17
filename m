From: Stepan Kasal <kasal@ucw.cz>
Subject: [PATCH 4/6] t4210: skip command-line encoding tests on mingw
Date: Thu, 17 Jul 2014 17:37:03 +0200
Message-ID: <1405611425-10009-5-git-send-email-kasal@ucw.cz>
References: <20140716092959.GA378@ucw.cz>
 <1405611425-10009-1-git-send-email-kasal@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>,
	GIT Mailing-list <git@vger.kernel.org>,
	msysGit <msysgit@googlegroups.com>,
	Pat Thoyts <patthoyts@users.sourceforge.net>,
	Stepan Kasal <kasal@ucw.cz>
To: Karsten Blees <karsten.blees@gmail.com>
X-From: msysgit+bncBCU63DXMWULRBMW3T6PAKGQE3LBL4ZY@googlegroups.com Thu Jul 17 17:37:30 2014
Return-path: <msysgit+bncBCU63DXMWULRBMW3T6PAKGQE3LBL4ZY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wg0-f59.google.com ([74.125.82.59])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCU63DXMWULRBMW3T6PAKGQE3LBL4ZY@googlegroups.com>)
	id 1X7nkI-00087C-UY
	for gcvm-msysgit@m.gmane.org; Thu, 17 Jul 2014 17:37:23 +0200
Received: by mail-wg0-f59.google.com with SMTP id a1sf269816wgh.4
        for <gcvm-msysgit@m.gmane.org>; Thu, 17 Jul 2014 08:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:from:to:cc:subject:date:message-id:in-reply-to
         :references:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=x8wO+jrDNinTTPu9mK3eHUQyklprpIdcePX7q8s8Lmk=;
        b=Vqz2n8S/JCN7SswwZfRcoycadVYTlVcO5TGkPTPwwipFyPN4lvRxFy5AJsBwWW0vGT
         2AtyN/lynfV0zX4fYNgY5e/WVob4BckzqY3HOiopxOyyRUfpOJm/uzcOZ8AZqg2c5YqB
         /WtadHGuOpmlpxBis3DoSZYool+tNTDc74O6aWJwt4WbLCLgFkiDieUQvGjVl62BBhWK
         J6dMlYI839fzl1lEGOq5Hp78vprHGpVD+5j+Rg7M8BaGadawcY1RhwndsWJi7KXdNELq
         zc/IMY3nkENjRfYovbX6vEVPKr5Bswvti+xBjIt/gOR/O82IMs59ZS0gMQsSGjVWdjrv
         kPmg==
X-Received: by 10.152.87.139 with SMTP id ay11mr9986lab.17.1405611442595;
        Thu, 17 Jul 2014 08:37:22 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.238.9 with SMTP id vg9ls199867lac.104.gmail; Thu, 17 Jul
 2014 08:37:21 -0700 (PDT)
X-Received: by 10.112.27.210 with SMTP id v18mr3851059lbg.4.1405611441280;
        Thu, 17 Jul 2014 08:37:21 -0700 (PDT)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz. [46.255.230.98])
        by gmr-mx.google.com with ESMTP id iz18si1071472wic.3.2014.07.17.08.37.21
        for <msysgit@googlegroups.com>;
        Thu, 17 Jul 2014 08:37:21 -0700 (PDT)
Received-SPF: none (google.com: kasal@ucw.cz does not designate permitted sender hosts) client-ip=46.255.230.98;
Received: by jabberwock.ucw.cz (Postfix, from userid 1042)
	id 0AA4A1C01A1; Thu, 17 Jul 2014 17:37:21 +0200 (CEST)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1405611425-10009-1-git-send-email-kasal@ucw.cz>
X-Original-Sender: kasal@ucw.cz
X-Original-Authentication-Results: gmr-mx.google.com;       spf=neutral
 (google.com: kasal@ucw.cz does not designate permitted sender hosts) smtp.mail=kasal@ucw.cz
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/msysgit/subscribe>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253744>

From: Pat Thoyts <patthoyts@users.sourceforge.net>

On Windows the application command line is provided as unicode and in
mingw-git we convert that to utf-8. So these tests that require a iso-8859-1
input are being subverted by the encoding transformations we perform and
should be skipped.

Signed-off-by: Pat Thoyts <patthoyts@users.sourceforge.net>
Signed-off-by: Stepan Kasal <kasal@ucw.cz>
---
 t/t4210-log-i18n.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t4210-log-i18n.sh b/t/t4210-log-i18n.sh
index 52a7472..9110404 100755
--- a/t/t4210-log-i18n.sh
+++ b/t/t4210-log-i18n.sh
@@ -34,7 +34,7 @@ test_expect_success 'log --grep searches in log output encoding (utf8)' '
 	test_cmp expect actual
 '
 
-test_expect_success 'log --grep searches in log output encoding (latin1)' '
+test_expect_success NOT_MINGW 'log --grep searches in log output encoding (latin1)' '
 	cat >expect <<-\EOF &&
 	latin1
 	utf8
@@ -43,7 +43,7 @@ test_expect_success 'log --grep searches in log output encoding (latin1)' '
 	test_cmp expect actual
 '
 
-test_expect_success 'log --grep does not find non-reencoded values (utf8)' '
+test_expect_success NOT_MINGW 'log --grep does not find non-reencoded values (utf8)' '
 	>expect &&
 	git log --encoding=utf8 --format=%s --grep=$latin1_e >actual &&
 	test_cmp expect actual
-- 
2.0.0.9635.g0be03cb

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
For more options, visit https://groups.google.com/d/optout.
