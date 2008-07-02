From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH 01/12] Fake reencoding success under NO_ICONV
 instead of returning NULL.
Date: Wed,  2 Jul 2008 10:32:01 +0200
Message-ID: <1214987532-23640-1-git-send-email-prohaska@zib.de>
References: <15FB2EE9-298D-41D1-B66A-DDC786282ECB@zib.de>
Reply-To: prohaska@zib.de
Cc: git@vger.kernel.org, msysgit@googlegroups.com, Junio C Hamano <gitster@pobox.com>, Johannes Sixt <johannes.sixt@telecom.at>, Steffen Prohaska <prohaska@zib.de>
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Wed Jul 02 10:33:27 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from wa-out-0708.google.com ([209.85.146.251])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDxmC-0001F7-Pv
	for gcvm-msysgit@m.gmane.org; Wed, 02 Jul 2008 10:33:22 +0200
Received: by wa-out-0708.google.com with SMTP id n36so6980882wag.21
        for <gcvm-msysgit@m.gmane.org>; Wed, 02 Jul 2008 01:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received-spf:authentication-results:received
         :received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:reply-to:sender:precedence:x-google-loop:mailing-list
         :list-id:list-post:list-help:list-unsubscribe:x-beenthere;
        bh=pkU14ruYi8NwC9eHgC2sbMH34x1UtAbKTQSaIFWUeWs=;
        b=q3NEkuMgwpvMxRy1iWPLajQz2p7AOIYTSOV99sgzUDYW67N//EEesAJhABSLQssxAU
         GJaOdOz8K4TiDSl2XtQMf/j+iw2jLQtC+aE7wfhMsl56erpcZH/WLT4p4nuxIheBIRpm
         NHd16jyiuLmY/Ih23Eol20zXIHoKiVFi2U51Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:from
         :to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :reply-to:sender:precedence:x-google-loop:mailing-list:list-id
         :list-post:list-help:list-unsubscribe:x-beenthere;
        b=SLiAcplv5wmjQIFMT6NHt20or7yemlu/IHwUccJ+BtxRW6J5BPaAaGiQeQjTtpqrWv
         cJGeuCgwpAIpdwT813PnamAnsW+a3Oigtt0tGGbM3KLEq3kyBlTmn7yf2Ke4RqDYc8cI
         kRAltMJTfQpP5GfdkH17TE03gxQX1s4YGCYwk=
Received: by 10.114.204.7 with SMTP id b7mr544933wag.2.1214987540325;
        Wed, 02 Jul 2008 01:32:20 -0700 (PDT)
Received: by 10.107.13.30 with SMTP id q30gr2544pri.0;
	Wed, 02 Jul 2008 01:32:20 -0700 (PDT)
X-Sender: prohaska@zib.de
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.90.66.5 with SMTP id o5mr8837757aga.20.1214987539460; Wed, 02 Jul 2008 01:32:19 -0700 (PDT)
Received: from mailer.zib.de (mailer.zib.de [130.73.108.11]) by mx.google.com with ESMTP id 22si7829120yxr.2.2008.07.02.01.32.18; Wed, 02 Jul 2008 01:32:19 -0700 (PDT)
Received-SPF: pass (google.com: best guess record for domain of prohaska@zib.de designates 130.73.108.11 as permitted sender) client-ip=130.73.108.11;
Authentication-Results: mx.google.com; spf=pass (google.com: best guess record for domain of prohaska@zib.de designates 130.73.108.11 as permitted sender) smtp.mail=prohaska@zib.de
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31]) by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m628WCS3019110; Wed, 2 Jul 2008 10:32:17 +0200 (CEST)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7]) by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m628WC0I017527; Wed, 2 Jul 2008 10:32:12 +0200 (MEST)
X-Mailer: git-send-email 1.5.4.4
In-Reply-To: <15FB2EE9-298D-41D1-B66A-DDC786282ECB@zib.de>
Sender: msysgit@googlegroups.com
Precedence: bulk
X-Google-Loop: groups
Mailing-List: list msysgit@googlegroups.com;
	contact msysgit-owner@googlegroups.com
List-Id: <msysgit.googlegroups.com>
List-Post: <mailto:msysgit@googlegroups.com>
List-Help: <mailto:msysgit-help@googlegroups.com>
List-Unsubscribe: <http://googlegroups.com/group/msysgit/subscribe>,
	<mailto:msysgit-unsubscribe@googlegroups.com>
X-BeenThere: msysgit@googlegroups.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87107>


From: Johannes Sixt <johannes.sixt@telecom.at>

git-am when invoked from git-rebase seems to rely on successful conversion.

Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 utf8.c |    7 +++++++
 utf8.h |    4 ----
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/utf8.c b/utf8.c
index dc37353..b07d43e 100644
--- a/utf8.c
+++ b/utf8.c
@@ -388,4 +388,11 @@ char *reencode_string(const char *in, const char *out_encoding, const char *in_e
 	iconv_close(conv);
 	return out;
 }
+#else
+char *reencode_string(const char *in, const char *out_encoding, const char *in_encoding)
+{
+	if (!in_encoding)
+		return NULL;
+	return xstrdup(in);
+}
 #endif
diff --git a/utf8.h b/utf8.h
index 98cce1b..f22ef31 100644
--- a/utf8.h
+++ b/utf8.h
@@ -10,10 +10,6 @@ int is_encoding_utf8(const char *name);
 
 int print_wrapped_text(const char *text, int indent, int indent2, int len);
 
-#ifndef NO_ICONV
 char *reencode_string(const char *in, const char *out_encoding, const char *in_encoding);
-#else
-#define reencode_string(a,b,c) NULL
-#endif
 
 #endif
-- 
1.5.6.1.255.g32571
