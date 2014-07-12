From: Karsten Blees <karsten.blees@gmail.com>
Subject: [PATCH v8 08/17] trace: disable additional trace output for
 unit tests
Date: Sat, 12 Jul 2014 02:03:01 +0200
Message-ID: <53C07B35.3090600@gmail.com>
References: <53C079C5.8090503@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>, 
 msysGit <msysgit@googlegroups.com>
X-From: msysgit+bncBCH3XYXLXQDBBMXWQGPAKGQETLYSTVA@googlegroups.com Sat Jul 12 02:02:58 2014
Return-path: <msysgit+bncBCH3XYXLXQDBBMXWQGPAKGQETLYSTVA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-lb0-f192.google.com ([209.85.217.192])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCH3XYXLXQDBBMXWQGPAKGQETLYSTVA@googlegroups.com>)
	id 1X5kmI-0003Pz-L9
	for gcvm-msysgit@m.gmane.org; Sat, 12 Jul 2014 02:02:58 +0200
Received: by mail-lb0-f192.google.com with SMTP id w7sf187300lbi.9
        for <gcvm-msysgit@m.gmane.org>; Fri, 11 Jul 2014 17:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=7hs2lW9r/Yb44yeTv7Fo/OfTBk2epML/dfmTUgSppCQ=;
        b=aC2jv8pHzZ0WqIIjfp/eZOQ8CtW/Ue4CRciIa/+x8NqC9G/X9kkXfqLcxcs2fUmJJ9
         giRi74gqxxI7oNrP0SFvuTlhZumvEcr8WPgIVKVGzVu2mWL9QoomVW/OItStsdpZGYdW
         uatpteeTKXlxmxVCnaoL2aEIWPby4swrjcDpuXZsgEb2/aEUFrIO6OKBcLq9d+D1GQl2
         5dKyZQHkQ0AsXZrYsYh1NTpQXu7a4jJMZE+6HpuqvX8LXJX9jSmAUIEglBNpirNitnrL
         GiwQazTi9Vl2dVC4WwW2VHJOhc+9SuVjihJpW9aqSOaqid+ouxtzhbZHrQjletn4DEd2
         wkog==
X-Received: by 10.180.107.162 with SMTP id hd2mr30482wib.0.1405123378431;
        Fri, 11 Jul 2014 17:02:58 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.87.168 with SMTP id az8ls162699wib.11.gmail; Fri, 11 Jul
 2014 17:02:57 -0700 (PDT)
X-Received: by 10.180.87.7 with SMTP id t7mr806154wiz.5.1405123377730;
        Fri, 11 Jul 2014 17:02:57 -0700 (PDT)
Received: from mail-wi0-x22e.google.com (mail-wi0-x22e.google.com [2a00:1450:400c:c05::22e])
        by gmr-mx.google.com with ESMTPS id cj4si6693wid.0.2014.07.11.17.02.57
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 11 Jul 2014 17:02:57 -0700 (PDT)
Received-SPF: pass (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c05::22e as permitted sender) client-ip=2a00:1450:400c:c05::22e;
Received: by mail-wi0-f174.google.com with SMTP id d1so21814wiv.7
        for <msysgit@googlegroups.com>; Fri, 11 Jul 2014 17:02:57 -0700 (PDT)
X-Received: by 10.194.104.97 with SMTP id gd1mr2539513wjb.77.1405123377645;
        Fri, 11 Jul 2014 17:02:57 -0700 (PDT)
Received: from [10.1.116.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id ev9sm293193wic.24.2014.07.11.17.02.56
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 11 Jul 2014 17:02:56 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <53C079C5.8090503@gmail.com>
X-Original-Sender: karsten.blees@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c05::22e
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253363>

Some unit-tests use trace output to verify internal state, and unstable
output such as timestamps and line numbers are not useful there.

Disable additional trace output if GIT_TRACE_BARE is set.

Signed-off-by: Karsten Blees <blees@dcon.de>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/test-lib.sh | 4 ++++
 trace.c       | 6 ++++++
 2 files changed, 10 insertions(+)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 81394c8..e37da5a 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -109,6 +109,10 @@ export GIT_AUTHOR_EMAIL GIT_AUTHOR_NAME
 export GIT_COMMITTER_EMAIL GIT_COMMITTER_NAME
 export EDITOR
 
+# Tests using GIT_TRACE typically don't want <timestamp> <file>:<line> output
+GIT_TRACE_BARE=1
+export GIT_TRACE_BARE
+
 if test -n "${TEST_GIT_INDEX_VERSION:+isset}"
 then
 	GIT_INDEX_VERSION="$TEST_GIT_INDEX_VERSION"
diff --git a/trace.c b/trace.c
index 3d02bcc..a194b16 100644
--- a/trace.c
+++ b/trace.c
@@ -87,11 +87,17 @@ static const char err_msg[] = "Could not trace into fd given by "
 
 static int prepare_trace_line(struct trace_key *key, struct strbuf *buf)
 {
+	static struct trace_key trace_bare = TRACE_KEY_INIT(BARE);
+
 	if (!trace_want(key))
 		return 0;
 
 	set_try_to_free_routine(NULL);	/* is never reset */
 
+	/* unit tests may want to disable additional trace output */
+	if (trace_want(&trace_bare))
+		return 1;
+
 	/* add line prefix here */
 
 	return 1;
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
