From: Karsten Blees <karsten.blees@gmail.com>
Subject: [PATCH v8 09/17] trace: add current timestamp to all trace output
Date: Sat, 12 Jul 2014 02:03:50 +0200
Message-ID: <53C07B66.5080200@gmail.com>
References: <53C079C5.8090503@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>, 
 msysGit <msysgit@googlegroups.com>
X-From: msysgit+bncBCH3XYXLXQDBBYXWQGPAKGQEV5M2UIQ@googlegroups.com Sat Jul 12 02:03:50 2014
Return-path: <msysgit+bncBCH3XYXLXQDBBYXWQGPAKGQEV5M2UIQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-we0-f192.google.com ([74.125.82.192])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCH3XYXLXQDBBYXWQGPAKGQEV5M2UIQ@googlegroups.com>)
	id 1X5kn5-0004EC-MN
	for gcvm-msysgit@m.gmane.org; Sat, 12 Jul 2014 02:03:47 +0200
Received: by mail-we0-f192.google.com with SMTP id u57sf184719wes.19
        for <gcvm-msysgit@m.gmane.org>; Fri, 11 Jul 2014 17:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=RQfAA2PmF/RQC4Qjdrg+viwzrTdGycqumy+V3jogDSU=;
        b=i2gzI3GNvZOHfPJ5hCfqbngMmVIeLX8iq+E3NXmh2KgdHVTSrorhbYd8Tw5isDIeR/
         c5NelV8n0zbhsmxRvaiipns0MMtykEO2+Yrfx0B6n+pQCfx3iEp5LLyNDu6hevJKhCKM
         3emu6qsA2IOpz8AQEexV2VIbh9Za6ADThHK3fWTQ8rc3t4ow+W4Z4Kep+6/AvmsfUAUt
         zrbKeEqapsKWP6D3LAhjvAONdcmaDat9qQnq1fkh7uJv+jRNFZ7kOCHcPDbb3VQUbVzj
         QKnHz9vAskmYOc2qOfbFK+YE+0FIEjnFHqB91Tjb/yIJzPpefhAnCMRGqPL3vspxDIY/
         Areg==
X-Received: by 10.152.20.162 with SMTP id o2mr16506lae.18.1405123427372;
        Fri, 11 Jul 2014 17:03:47 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.36.42 with SMTP id n10ls139261laj.1.gmail; Fri, 11 Jul
 2014 17:03:46 -0700 (PDT)
X-Received: by 10.112.140.170 with SMTP id rh10mr209435lbb.7.1405123426192;
        Fri, 11 Jul 2014 17:03:46 -0700 (PDT)
Received: from mail-we0-x22e.google.com (mail-we0-x22e.google.com [2a00:1450:400c:c03::22e])
        by gmr-mx.google.com with ESMTPS id x7si7163wiw.1.2014.07.11.17.03.46
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 11 Jul 2014 17:03:46 -0700 (PDT)
Received-SPF: pass (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c03::22e as permitted sender) client-ip=2a00:1450:400c:c03::22e;
Received: by mail-we0-f174.google.com with SMTP id u57so1802179wes.5
        for <msysgit@googlegroups.com>; Fri, 11 Jul 2014 17:03:46 -0700 (PDT)
X-Received: by 10.180.82.97 with SMTP id h1mr8920711wiy.30.1405123426094;
        Fri, 11 Jul 2014 17:03:46 -0700 (PDT)
Received: from [10.1.116.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id fw4sm317539wib.19.2014.07.11.17.03.44
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 11 Jul 2014 17:03:45 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <53C079C5.8090503@gmail.com>
X-Original-Sender: karsten.blees@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c03::22e
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253364>

This is useful to tell apart trace output of separate test runs.

It can also be used for basic, coarse-grained performance analysis. Note
that the accuracy is tainted by writing to the trace file, and you have to
calculate the deltas yourself (which is next to impossible if multiple
threads or processes are involved).

Signed-off-by: Karsten Blees <blees@dcon.de>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 trace.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/trace.c b/trace.c
index a194b16..18e5d93 100644
--- a/trace.c
+++ b/trace.c
@@ -88,6 +88,9 @@ static const char err_msg[] = "Could not trace into fd given by "
 static int prepare_trace_line(struct trace_key *key, struct strbuf *buf)
 {
 	static struct trace_key trace_bare = TRACE_KEY_INIT(BARE);
+	struct timeval tv;
+	struct tm tm;
+	time_t secs;
 
 	if (!trace_want(key))
 		return 0;
@@ -98,7 +101,12 @@ static int prepare_trace_line(struct trace_key *key, struct strbuf *buf)
 	if (trace_want(&trace_bare))
 		return 1;
 
-	/* add line prefix here */
+	/* print current timestamp */
+	gettimeofday(&tv, NULL);
+	secs = tv.tv_sec;
+	localtime_r(&secs, &tm);
+	strbuf_addf(buf, "%02d:%02d:%02d.%06ld ", tm.tm_hour, tm.tm_min,
+		    tm.tm_sec, (long) tv.tv_usec);
 
 	return 1;
 }
-- 
2.0.0.406.g2e9ef9b

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
