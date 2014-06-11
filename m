From: Karsten Blees <karsten.blees@gmail.com>
Subject: [PATCH v5 06/11] trace: add current timestamp to all trace output
Date: Wed, 11 Jun 2014 09:59:42 +0200
Message-ID: <53980C6E.9000409@gmail.com>
References: <53980B83.9050409@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git List <git@vger.kernel.org>, msysGit <msysgit@googlegroups.com>, 
 Jeff King <peff@peff.net>
X-From: msysgit+bncBCH3XYXLXQDBB34Y4COAKGQEYKMC2DY@googlegroups.com Wed Jun 11 09:59:45 2014
Return-path: <msysgit+bncBCH3XYXLXQDBB34Y4COAKGQEYKMC2DY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wi0-f187.google.com ([209.85.212.187])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCH3XYXLXQDBB34Y4COAKGQEYKMC2DY@googlegroups.com>)
	id 1WudRg-0007Nm-Cx
	for gcvm-msysgit@m.gmane.org; Wed, 11 Jun 2014 09:59:44 +0200
Received: by mail-wi0-f187.google.com with SMTP id f8sf48749wiw.24
        for <gcvm-msysgit@m.gmane.org>; Wed, 11 Jun 2014 00:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=SbHvD96akCJq64Up+3TcUAwDXpjtnA7Kqvi+0s5FLLM=;
        b=ZO9V95MQK7ZbExX19zTIZpE5HiAW1JGCKAlXJ7Q80f7HP2IHHlsgu9soXKwadXfizX
         nrJuKOxaDIGiX89r2KgL67Tybnuf9Y0qFClJYIhBBI5vTMzda6EOkY1yWo9GGFPTylkq
         UbHTiyw4PnZ1197i3mWVwkGqgsn4obD001BdRQubf0EXDC6lD9Dx4u8w3j2t7rvpB1sq
         7UBCBstXUfYG5O5gQMnVbP1fxqTGksVGCgrJcPu62+AX4e9ZOp+sQYS0elD3eDTicMGw
         RuNBkGmB9zksQBXf3qKxDoTM4zMk4Use0pdIJzZT7a34c/B88Wlum3wyma27J4Rgh/W4
         Up+Q==
X-Received: by 10.180.37.107 with SMTP id x11mr4577wij.18.1402473584100;
        Wed, 11 Jun 2014 00:59:44 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.189.164 with SMTP id gj4ls213528wic.27.canary; Wed, 11 Jun
 2014 00:59:43 -0700 (PDT)
X-Received: by 10.194.94.129 with SMTP id dc1mr168889wjb.3.1402473583267;
        Wed, 11 Jun 2014 00:59:43 -0700 (PDT)
Received: from mail-wi0-x231.google.com (mail-wi0-x231.google.com [2a00:1450:400c:c05::231])
        by gmr-mx.google.com with ESMTPS id s1si1258912wiw.3.2014.06.11.00.59.43
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 11 Jun 2014 00:59:43 -0700 (PDT)
Received-SPF: pass (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c05::231 as permitted sender) client-ip=2a00:1450:400c:c05::231;
Received: by mail-wi0-x231.google.com with SMTP id f8so555503wiw.16
        for <msysgit@googlegroups.com>; Wed, 11 Jun 2014 00:59:43 -0700 (PDT)
X-Received: by 10.180.13.52 with SMTP id e20mr39915612wic.2.1402473583190;
        Wed, 11 Jun 2014 00:59:43 -0700 (PDT)
Received: from [10.1.116.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id w9sm57942941eev.4.2014.06.11.00.59.41
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 11 Jun 2014 00:59:42 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
In-Reply-To: <53980B83.9050409@gmail.com>
X-Original-Sender: karsten.blees@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c05::231
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251335>

This is useful to tell apart trace output of separate test runs.

It can also be used for basic, coarse-grained performance analysis. Note
that the accuracy is tainted by writing to the trace file, and you have to
calculate the deltas yourself (which is next to impossible if multiple
threads or processes are involved).

Signed-off-by: Karsten Blees <blees@dcon.de>
---
 trace.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/trace.c b/trace.c
index c920429..5a3393a 100644
--- a/trace.c
+++ b/trace.c
@@ -79,12 +79,21 @@ static void do_trace_print(const char *key, const struct strbuf *buf)
 
 static int prepare_trace_line(const char *key, struct strbuf *buf)
 {
+	struct timeval tv;
+	struct tm tm;
+	time_t secs;
+
 	if (!trace_want(key))
 		return 0;
 
 	set_try_to_free_routine(NULL);	/* is never reset */
 
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
1.9.2.msysgit.0.501.gaeecf09

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
