From: Karsten Blees <karsten.blees@gmail.com>
Subject: [PATCH] t0110/MinGW: skip tests that pass arbitrary bytes
 on the command line
Date: Sat, 19 Jul 2014 21:37:19 +0200
Message-ID: <53CAC8EF.6020707@gmail.com>
References: <20140716092959.GA378@ucw.cz>	<1405611425-10009-1-git-send-email-kasal@ucw.cz>	<1405611425-10009-3-git-send-email-kasal@ucw.cz>	<53C813D2.8070701@gmail.com> <xmqqd2d2mskv.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Stepan Kasal <kasal@ucw.cz>, Johannes Sixt <j6t@kdbg.org>, 
 GIT Mailing-list <git@vger.kernel.org>,
 msysGit <msysgit@googlegroups.com>, 
 Johannes Schindelin <johannes.schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: msysgit+bncBCH3XYXLXQDBB34RVOPAKGQEQSFE4TA@googlegroups.com Sat Jul 19 21:37:21 2014
Return-path: <msysgit+bncBCH3XYXLXQDBB34RVOPAKGQEQSFE4TA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-lb0-f184.google.com ([209.85.217.184])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCH3XYXLXQDBB34RVOPAKGQEQSFE4TA@googlegroups.com>)
	id 1X8aRc-0002rE-NF
	for gcvm-msysgit@m.gmane.org; Sat, 19 Jul 2014 21:37:20 +0200
Received: by mail-lb0-f184.google.com with SMTP id c11sf581342lbj.1
        for <gcvm-msysgit@m.gmane.org>; Sat, 19 Jul 2014 12:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=ChUnJzibsVPX9vZq03JrpgQ3+DisuvZ1UBcPDJq3JRw=;
        b=n/q/8rJyxB9HiR/Qc6sMjf/eN7vRmRJ8D0LYRHrE9c7WIm1wnWME9qR0nFJo/3ABm5
         mprMmMP/LNl10lzC5OSTpHhkq/o3ABqbdgj4QcRwJKSsuV8LtneQELP1naUPB1HzTJdx
         7bA93cSPcY70rhW2giRFKKCjrfPBPJ3btwznynT9Z72pxDgAg6yO3FD3nOLLCbQIwzup
         uiU4FQBDy/kfAfl4lYdlNMrSXcdivBg//NY8FdTG2tu4UaLmiCFsK1gHTOynDCxDERzs
         yeMbusJSf4reyGm4Iu2PJjwfm5I3WvdFPctSdI9loetA9YrCuBwingYOS7XALgz4ofau
         RGGQ==
X-Received: by 10.152.207.76 with SMTP id lu12mr113482lac.2.1405798640375;
        Sat, 19 Jul 2014 12:37:20 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.42.134 with SMTP id o6ls375420lal.4.gmail; Sat, 19 Jul
 2014 12:37:18 -0700 (PDT)
X-Received: by 10.112.158.8 with SMTP id wq8mr309189lbb.12.1405798638642;
        Sat, 19 Jul 2014 12:37:18 -0700 (PDT)
Received: from mail-wg0-x232.google.com (mail-wg0-x232.google.com [2a00:1450:400c:c00::232])
        by gmr-mx.google.com with ESMTPS id d9si352294wie.3.2014.07.19.12.37.18
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 19 Jul 2014 12:37:18 -0700 (PDT)
Received-SPF: pass (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c00::232 as permitted sender) client-ip=2a00:1450:400c:c00::232;
Received: by mail-wg0-f50.google.com with SMTP id n12so4734009wgh.21
        for <msysgit@googlegroups.com>; Sat, 19 Jul 2014 12:37:18 -0700 (PDT)
X-Received: by 10.194.142.148 with SMTP id rw20mr7350186wjb.69.1405798638509;
        Sat, 19 Jul 2014 12:37:18 -0700 (PDT)
Received: from [10.1.116.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id hi4sm23996872wjc.27.2014.07.19.12.37.17
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 19 Jul 2014 12:37:17 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <xmqqd2d2mskv.fsf@gitster.dls.corp.google.com>
X-Original-Sender: karsten.blees@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c00::232
 as permitted sender) smtp.mail=karsten.blees@gmail.com;       dkim=pass
 header.i=@gmail.com;       dmarc=pass (p=NONE dis=NONE) header.from=gmail.com
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253907>

On Windows, the command line is a Unicode string, it is not possible to
pass arbitrary bytes to a program. Disable tests that try to do so.

Signed-off-by: Karsten Blees <blees@dcon.de>
---
 t/t0110-urlmatch-normalization.sh | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/t/t0110-urlmatch-normalization.sh b/t/t0110-urlmatch-normalization.sh
index 8d6096d..410d576 100755
--- a/t/t0110-urlmatch-normalization.sh
+++ b/t/t0110-urlmatch-normalization.sh
@@ -117,7 +117,7 @@ test_expect_success 'url general escapes' '
 	test "$(test-urlmatch-normalization -p "X://W?'\!'")" = "x://w/?'\!'"
 '
 
-test_expect_success 'url high-bit escapes' '
+test_expect_success !MINGW 'url high-bit escapes' '
 	test "$(test-urlmatch-normalization -p "$(cat "$tu-1")")" = "x://q/%01%02%03%04%05%06%07%08%0E%0F%10%11%12" &&
 	test "$(test-urlmatch-normalization -p "$(cat "$tu-2")")" = "x://q/%13%14%15%16%17%18%19%1B%1C%1D%1E%1F%7F" &&
 	test "$(test-urlmatch-normalization -p "$(cat "$tu-3")")" = "x://q/%80%81%82%83%84%85%86%87%88%89%8A%8B%8C%8D%8E%8F" &&
@@ -127,7 +127,10 @@ test_expect_success 'url high-bit escapes' '
 	test "$(test-urlmatch-normalization -p "$(cat "$tu-7")")" = "x://q/%C0%C1%C2%C3%C4%C5%C6%C7%C8%C9%CA%CB%CC%CD%CE%CF" &&
 	test "$(test-urlmatch-normalization -p "$(cat "$tu-8")")" = "x://q/%D0%D1%D2%D3%D4%D5%D6%D7%D8%D9%DA%DB%DC%DD%DE%DF" &&
 	test "$(test-urlmatch-normalization -p "$(cat "$tu-9")")" = "x://q/%E0%E1%E2%E3%E4%E5%E6%E7%E8%E9%EA%EB%EC%ED%EE%EF" &&
-	test "$(test-urlmatch-normalization -p "$(cat "$tu-10")")" = "x://q/%F0%F1%F2%F3%F4%F5%F6%F7%F8%F9%FA%FB%FC%FD%FE%FF" &&
+	test "$(test-urlmatch-normalization -p "$(cat "$tu-10")")" = "x://q/%F0%F1%F2%F3%F4%F5%F6%F7%F8%F9%FA%FB%FC%FD%FE%FF"
+'
+
+test_expect_success 'url utf-8 escapes' '
 	test "$(test-urlmatch-normalization -p "$(cat "$tu-11")")" = "x://q/%C2%80%DF%BF%E0%A0%80%EF%BF%BD%F0%90%80%80%F0%AF%BF%BD"
 '
 
-- 
2.0.2.906.g50cb2fc.dirty

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
