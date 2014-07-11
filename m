From: Karsten Blees <karsten.blees@gmail.com>
Subject: [PATCH] fixup! symlinks: remove PATH_MAX limitation
Date: Sat, 12 Jul 2014 01:02:34 +0200
Message-ID: <53C06D0A.2000704@gmail.com>
References: <53B72DAA.5050007@gmail.com>	<xmqqsimdc988.fsf@gitster.dls.corp.google.com>	<53C036DB.7000505@gmail.com> <xmqqd2db35dm.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>, msysGit <msysgit@googlegroups.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: msysgit+bncBCH3XYXLXQDBBB62QGPAKGQEGOO64IY@googlegroups.com Sat Jul 12 01:02:35 2014
Return-path: <msysgit+bncBCH3XYXLXQDBBB62QGPAKGQEGOO64IY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wi0-f190.google.com ([209.85.212.190])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCH3XYXLXQDBBB62QGPAKGQEGOO64IY@googlegroups.com>)
	id 1X5jpq-0001Yz-W3
	for gcvm-msysgit@m.gmane.org; Sat, 12 Jul 2014 01:02:35 +0200
Received: by mail-wi0-f190.google.com with SMTP id n15sf53042wiw.7
        for <gcvm-msysgit@m.gmane.org>; Fri, 11 Jul 2014 16:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=mK1tSRa7mGkV5Xi58H5Tn4y/JI34VHRQtVGoAxpjnw0=;
        b=Ig3S3p57BEQ74O/Jxp0l6ZzBWUJe0viodOEnhatwjiFKHzWTpNQh/oNCiZAaNnnnJ3
         tJwfr3kitKk9AgwLIz84tjM6VUbtjJDZu10s1nEHg5xlbWc9fPKPGnsf0LeXXWm2wtdm
         K6reoMIT1lD7TF0qJKREpRGzmlRTOMXRipbot6UpcI2FkR18b2MeNdq4JdnKwbjF5Ehd
         /3DEnnDwdN7jrILOgoFV3Zguq0UpJMWd5B/f2Cw5PhhqUqY1KhFFsKoCYsZcszMKZXSR
         UVuOdy2ZxHgRlSovdrLXGBg7sLdrvt3iQUCZWwvXfyj3bjyF3+t1WaptXc61PO+OFyb6
         hd9A==
X-Received: by 10.180.8.36 with SMTP id o4mr29637wia.3.1405119752169;
        Fri, 11 Jul 2014 16:02:32 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.102.33 with SMTP id fl1ls143675wib.44.canary; Fri, 11 Jul
 2014 16:02:31 -0700 (PDT)
X-Received: by 10.180.87.7 with SMTP id t7mr786940wiz.5.1405119751010;
        Fri, 11 Jul 2014 16:02:31 -0700 (PDT)
Received: from mail-wi0-x22c.google.com (mail-wi0-x22c.google.com [2a00:1450:400c:c05::22c])
        by gmr-mx.google.com with ESMTPS id gc5si308717wic.1.2014.07.11.16.02.30
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 11 Jul 2014 16:02:31 -0700 (PDT)
Received-SPF: pass (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c05::22c as permitted sender) client-ip=2a00:1450:400c:c05::22c;
Received: by mail-wi0-f172.google.com with SMTP id n3so393614wiv.11
        for <msysgit@googlegroups.com>; Fri, 11 Jul 2014 16:02:30 -0700 (PDT)
X-Received: by 10.194.157.195 with SMTP id wo3mr2477290wjb.130.1405119750934;
        Fri, 11 Jul 2014 16:02:30 -0700 (PDT)
Received: from [10.1.116.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id eo4sm12366111wid.4.2014.07.11.16.02.29
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 11 Jul 2014 16:02:30 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <xmqqd2db35dm.fsf@gitster.dls.corp.google.com>
X-Original-Sender: karsten.blees@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c05::22c
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253347>

Rename cache_def_free to cache_def_clear as it doesn't free the struct
cache_def, but just clears its content.

Signed-off-by: Karsten Blees <blees@dcon.de>
---
 cache.h         | 2 +-
 preload-index.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/cache.h b/cache.h
index 44aa439..378ee7f 100644
--- a/cache.h
+++ b/cache.h
@@ -1096,7 +1096,7 @@ struct cache_def {
 	int prefix_len_stat_func;
 };
 #define CACHE_DEF_INIT { STRBUF_INIT, 0, 0, 0 }
-static inline void cache_def_free(struct cache_def *cache)
+static inline void cache_def_clear(struct cache_def *cache)
 {
 	strbuf_release(&cache->path);
 }
diff --git a/preload-index.c b/preload-index.c
index 79ce8a9..c1fe3a3 100644
--- a/preload-index.c
+++ b/preload-index.c
@@ -63,7 +63,7 @@ static void *preload_thread(void *_data)
 			continue;
 		ce_mark_uptodate(ce);
 	} while (--nr > 0);
-	cache_def_free(&cache);
+	cache_def_clear(&cache);
 	return NULL;
 }
 
-- 
2.0.1.563.g66f467c.dirty

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
