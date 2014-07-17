From: Stepan Kasal <kasal@ucw.cz>
Subject: [PATCH 1/6] MinGW: Skip test redirecting to fd 4
Date: Thu, 17 Jul 2014 17:37:00 +0200
Message-ID: <1405611425-10009-2-git-send-email-kasal@ucw.cz>
References: <20140716092959.GA378@ucw.cz>
 <1405611425-10009-1-git-send-email-kasal@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>,
	GIT Mailing-list <git@vger.kernel.org>,
	msysGit <msysgit@googlegroups.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stepan Kasal <kasal@ucw.cz>
To: Karsten Blees <karsten.blees@gmail.com>
X-From: msysgit+bncBCU63DXMWULRBMO3T6PAKGQEWZFM3IQ@googlegroups.com Thu Jul 17 17:37:24 2014
Return-path: <msysgit+bncBCU63DXMWULRBMO3T6PAKGQEWZFM3IQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wi0-f191.google.com ([209.85.212.191])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCU63DXMWULRBMO3T6PAKGQEWZFM3IQ@googlegroups.com>)
	id 1X7nkI-00087B-OW
	for gcvm-msysgit@m.gmane.org; Thu, 17 Jul 2014 17:37:22 +0200
Received: by mail-wi0-f191.google.com with SMTP id hi2sf293351wib.8
        for <gcvm-msysgit@m.gmane.org>; Thu, 17 Jul 2014 08:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:from:to:cc:subject:date:message-id:in-reply-to
         :references:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=0qJYHWud5nyX/U6zJ8qJtoJw61iQ8CuJd1r4yud8WLc=;
        b=chqQRnW9bhKp+wDwZRbBcp1aInAg4mhqZwA8gRNdMvuxrcAJfQUVabP6/GCphIb8u/
         T5osb4h/PxU5aOq7xlqBYhXoP+773qNR29l/Vv/5z1BWo7IwyeXgsSZOlk7MUy1C+esX
         bng6dxKHGMDCYyupodou8JLP+gXeVvaWX017fKry/LFfJQuSSGdAIZg7KVkx+9lwV6SE
         D2p3lRWl5OqCfirDO9SgDCE86SizOEsyVqiewad0hn9w3NUwYSSZ5s3cynkJ0/rZwA6f
         OISLv3Ov9aOQqhdy4HrNfQYhnzvQKzzb+EFW3lDxPo4BxDMZq8P4VG4LspJII9NC3SZ5
         rcBA==
X-Received: by 10.180.92.40 with SMTP id cj8mr94241wib.7.1405611442332;
        Thu, 17 Jul 2014 08:37:22 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.80.98 with SMTP id q2ls454892wix.38.gmail; Thu, 17 Jul
 2014 08:37:21 -0700 (PDT)
X-Received: by 10.180.91.73 with SMTP id cc9mr2133164wib.4.1405611441235;
        Thu, 17 Jul 2014 08:37:21 -0700 (PDT)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz. [46.255.230.98])
        by gmr-mx.google.com with ESMTP id o6si608124wij.1.2014.07.17.08.37.21
        for <msysgit@googlegroups.com>;
        Thu, 17 Jul 2014 08:37:21 -0700 (PDT)
Received-SPF: none (google.com: kasal@ucw.cz does not designate permitted sender hosts) client-ip=46.255.230.98;
Received: by jabberwock.ucw.cz (Postfix, from userid 1042)
	id F08221C0196; Thu, 17 Jul 2014 17:37:20 +0200 (CEST)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253740>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

... because that does not work in MinGW.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Stepan Kasal <kasal@ucw.cz>
---
 t/t0081-line-buffer.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t0081-line-buffer.sh b/t/t0081-line-buffer.sh
index bd83ed3..25dba00 100755
--- a/t/t0081-line-buffer.sh
+++ b/t/t0081-line-buffer.sh
@@ -29,7 +29,7 @@ test_expect_success '0-length read, send along greeting' '
 	test_cmp expect actual
 '
 
-test_expect_success 'read from file descriptor' '
+test_expect_success NOT_MINGW 'read from file descriptor' '
 	rm -f input &&
 	echo hello >expect &&
 	echo hello >input &&
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
