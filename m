From: Karsten Blees <karsten.blees@gmail.com>
Subject: [PATCH v7 09/16] trace: add current timestamp to all trace output
Date: Wed, 02 Jul 2014 01:00:51 +0200
Message-ID: <53B33DA3.2070106@gmail.com>
References: <53B33C05.5090900@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git List <git@vger.kernel.org>, msysGit <msysgit@googlegroups.com>
X-From: msysgit+bncBCH3XYXLXQDBBI73ZSOQKGQEDIJU7BA@googlegroups.com Wed Jul 02 01:00:53 2014
Return-path: <msysgit+bncBCH3XYXLXQDBBI73ZSOQKGQEDIJU7BA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-la0-f62.google.com ([209.85.215.62])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCH3XYXLXQDBBI73ZSOQKGQEDIJU7BA@googlegroups.com>)
	id 1X272i-0003iN-Hs
	for gcvm-msysgit@m.gmane.org; Wed, 02 Jul 2014 01:00:52 +0200
Received: by mail-la0-f62.google.com with SMTP id gf5sf975919lab.7
        for <gcvm-msysgit@m.gmane.org>; Tue, 01 Jul 2014 16:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=EGcqZT5am4PKCCrS1unmI+I53D2qH4gYwdX8Rpi2adE=;
        b=opR161o9MuuE5YNpAtrEPDSE/9lbqLrUSzt9mgqDDU7nItC4cbjqv6v0XDl9f/kTY9
         DcID2BtghHVvdHAE6dGjnCizERkgA5qYu6KVLyj/xur3ANksI6GFLpesJR3U2xcefMyV
         0T/y5dzL9aQ7CvhF1SAU02wWg/BzgRe0I+iNwvOROiW9jeauEMWjEIKSu3E/H+EhEQpc
         MIn2b4k4nxs7Ib60Jt3M4aCsvO973WVlbm4p9IC5sMIdiKOvoFoF1N9bWtH3akKXBxAU
         uSNrnEGX3C127DN2sd7txqNdBTI3nbTSEcERPBBzhZecOGSRU8YoqTXqGCpDGP2IACpD
         ab2A==
X-Received: by 10.152.87.84 with SMTP id v20mr40367laz.8.1404255652414;
        Tue, 01 Jul 2014 16:00:52 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.20.3 with SMTP id j3ls412573lae.99.gmail; Tue, 01 Jul 2014
 16:00:51 -0700 (PDT)
X-Received: by 10.112.140.170 with SMTP id rh10mr5333450lbb.7.1404255651284;
        Tue, 01 Jul 2014 16:00:51 -0700 (PDT)
Received: from mail-wi0-x232.google.com (mail-wi0-x232.google.com [2a00:1450:400c:c05::232])
        by gmr-mx.google.com with ESMTPS id gc5si880352wic.1.2014.07.01.16.00.51
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 01 Jul 2014 16:00:51 -0700 (PDT)
Received-SPF: pass (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c05::232 as permitted sender) client-ip=2a00:1450:400c:c05::232;
Received: by mail-wi0-x232.google.com with SMTP id n15so8595970wiw.11
        for <msysgit@googlegroups.com>; Tue, 01 Jul 2014 16:00:51 -0700 (PDT)
X-Received: by 10.194.238.168 with SMTP id vl8mr5732765wjc.133.1404255651200;
        Tue, 01 Jul 2014 16:00:51 -0700 (PDT)
Received: from [10.1.116.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id q11sm48219232wib.14.2014.07.01.16.00.50
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 01 Jul 2014 16:00:50 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <53B33C05.5090900@gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252758>

This is useful to tell apart trace output of separate test runs.

It can also be used for basic, coarse-grained performance analysis. Note
that the accuracy is tainted by writing to the trace file, and you have to
calculate the deltas yourself (which is next to impossible if multiple
threads or processes are involved).

Signed-off-by: Karsten Blees <blees@dcon.de>
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
2.0.0.406.ge74f8ff

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
