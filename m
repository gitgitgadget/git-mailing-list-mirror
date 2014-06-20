From: Karsten Blees <karsten.blees@gmail.com>
Subject: [PATCH v6 06/11] trace: add current timestamp to all trace output
Date: Fri, 20 Jun 2014 23:07:14 +0200
Message-ID: <53A4A282.20209@gmail.com>
References: <53A4A195.1070502@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>, 
 msysGit <msysgit@googlegroups.com>
X-From: msysgit+bncBCH3XYXLXQDBBAOFSKOQKGQENNFRVKY@googlegroups.com Fri Jun 20 23:07:15 2014
Return-path: <msysgit+bncBCH3XYXLXQDBBAOFSKOQKGQENNFRVKY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wi0-f189.google.com ([209.85.212.189])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCH3XYXLXQDBBAOFSKOQKGQENNFRVKY@googlegroups.com>)
	id 1Wy61i-0006MO-Ri
	for gcvm-msysgit@m.gmane.org; Fri, 20 Jun 2014 23:07:14 +0200
Received: by mail-wi0-f189.google.com with SMTP id n15sf117583wiw.26
        for <gcvm-msysgit@m.gmane.org>; Fri, 20 Jun 2014 14:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=Cw7GmdIHNfFJy4bhE449qT89ScbNaRGTvsTRQWHx1rc=;
        b=kze2SoVxf6lPMew4WB2guURvjJkzjpDXWfrtSQ0OZp+kQ4RP9vdmAZPa6cq+qrkJTQ
         WTYOf+kXZz5feOtLwsqk7sbcmMh0snxKW6QuBpS2JtjjolQDkVuFOMUvvGsyvTUz3g1C
         FbZWr6janINzx8Q+bwrnysXmntMomJ87ILO92ngS0QOQ0UQsXpSMP8vMdhKVKykx1xDI
         aTXAsF2hldhOF+JTp2mTH3Lt4t9/DGtaaYbGI1QuElM4DaAtiX94ImWuTAjKI13ze5AV
         ApAdbH1ltJ4BH19Acza29xPdQVQm8hInpqjB3bLQd5xfziR/BCbnvJr7sY9vQmLQ9muN
         W0oA==
X-Received: by 10.152.43.134 with SMTP id w6mr4lal.41.1403298434413;
        Fri, 20 Jun 2014 14:07:14 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.170.201 with SMTP id ao9ls181277lac.77.gmail; Fri, 20 Jun
 2014 14:07:13 -0700 (PDT)
X-Received: by 10.112.50.203 with SMTP id e11mr2809lbo.23.1403298433206;
        Fri, 20 Jun 2014 14:07:13 -0700 (PDT)
Received: from mail-wi0-x232.google.com (mail-wi0-x232.google.com [2a00:1450:400c:c05::232])
        by gmr-mx.google.com with ESMTPS id s1si222122wiw.3.2014.06.20.14.07.13
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 20 Jun 2014 14:07:13 -0700 (PDT)
Received-SPF: pass (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c05::232 as permitted sender) client-ip=2a00:1450:400c:c05::232;
Received: by mail-wi0-f178.google.com with SMTP id n15so1438091wiw.11
        for <msysgit@googlegroups.com>; Fri, 20 Jun 2014 14:07:13 -0700 (PDT)
X-Received: by 10.194.222.230 with SMTP id qp6mr7355273wjc.23.1403298433119;
        Fri, 20 Jun 2014 14:07:13 -0700 (PDT)
Received: from [10.1.116.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id jb16sm6730050wic.10.2014.06.20.14.07.11
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 20 Jun 2014 14:07:12 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <53A4A195.1070502@gmail.com>
X-Original-Sender: karsten.blees@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c05::232
 as permitted sender) smtp.mail=karsten.blees@gmail.com;       dkim=pass
 header.i=@gmail.com;       dmarc=pass (p=NONE dis=NONE) header.from=gmail.com
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252285>

This is useful to tell apart trace output of separate test runs.

It can also be used for basic, coarse-grained performance analysis. Note
that the accuracy is tainted by writing to the trace file, and you have to
calculate the deltas yourself (which is next to impossible if multiple
threads or processes are involved).

Signed-off-by: Karsten Blees <blees@dcon.de>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 trace.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/trace.c b/trace.c
index 9fa406e..9fa6cc7 100644
--- a/trace.c
+++ b/trace.c
@@ -81,6 +81,10 @@ static int trace_bare = -1;
 
 static int prepare_trace_line(const char *key, struct strbuf *buf)
 {
+	struct timeval tv;
+	struct tm tm;
+	time_t secs;
+
 	if (!trace_want(key))
 		return 0;
 
@@ -92,7 +96,12 @@ static int prepare_trace_line(const char *key, struct strbuf *buf)
 	if (trace_bare)
 		return 1;
 
-	/* add line prefix here */
+	/* print current timestamp */
+	gettimeofday(&tv, NULL);
+	secs = tv.tv_sec;
+	localtime_r(&secs, &tm);
+	strbuf_addf(buf, "%02d:%02d:%02d.%06ld ", tm.tm_hour, tm.tm_min,
+		    tm.tm_sec, tv.tv_usec);
 
 	return 1;
 }
-- 
2.0.0.402.g13b8b25

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
