From: Stepan Kasal <kasal@ucw.cz>
Subject: [PATCH 2/2] mingw: avoid const warning
Date: Thu, 29 May 2014 12:47:16 +0200
Organization: <)><
Message-ID: <20140529104716.GC24021@camelia.ucw.cz>
References: <20140529104329.GA24021@camelia.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Erik Faye-Lund <kusmabite@gmail.com>, msysgit@googlegroups.com,
        Karsten Blees <karsten.blees@gmail.com>
To: GIT Mailing-list <git@vger.kernel.org>
X-From: msysgit+bncBCU63DXMWULRBNVATSOAKGQEGXO66JQ@googlegroups.com Thu May 29 12:47:21 2014
Return-path: <msysgit+bncBCU63DXMWULRBNVATSOAKGQEGXO66JQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-lb0-f187.google.com ([209.85.217.187])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCU63DXMWULRBNVATSOAKGQEGXO66JQ@googlegroups.com>)
	id 1Wpxrj-0005Xv-6q
	for gcvm-msysgit@m.gmane.org; Thu, 29 May 2014 12:47:19 +0200
Received: by mail-lb0-f187.google.com with SMTP id z11sf13405lbi.14
        for <gcvm-msysgit@m.gmane.org>; Thu, 29 May 2014 03:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :in-reply-to:organization:user-agent:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type:content-disposition;
        bh=UFS0KLPp0kLnUD34CbctF0+4Sm+znYIaFCx6gKmox4c=;
        b=gvlvMVgruXe6mdI8mjv0CG8Kxyjp+QBcE6Le7QIR1LPVN3XK2uG11Yi0m/hBLTbN2V
         un5AEh89PIwlqHBUFCn55kD3VBvdjYAGL9cFSeStLkbl852Xqm6ufaWhboWjfvE9oO6J
         LU/2rD0VBZxOO+kpRy6VlW+78P/ertOaj7DA7cPrI0XSP9ZhA/6wqoQPiiD1EE4mvf3P
         HpStb07BTkFhhBMbUdTO/Dq6lJP+GExfXx+AuB6IBEu0GnsVOl/8PzfTng06sE3Sbz9e
         iQ9zKQsf09UuY7+vn7iVl2Ptqh0FYpTqIt9GmZtaznAyGCzpqzLyBXzz1NNATKil1PzG
         FuWg==
X-Received: by 10.180.109.161 with SMTP id ht1mr25575wib.6.1401360439028;
        Thu, 29 May 2014 03:47:19 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.86.98 with SMTP id o2ls172940wiz.46.gmail; Thu, 29 May
 2014 03:47:18 -0700 (PDT)
X-Received: by 10.180.219.42 with SMTP id pl10mr772282wic.5.1401360438227;
        Thu, 29 May 2014 03:47:18 -0700 (PDT)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz. [46.255.230.98])
        by gmr-mx.google.com with ESMTP id r49si390642eep.0.2014.05.29.03.47.17
        for <msysgit@googlegroups.com>;
        Thu, 29 May 2014 03:47:17 -0700 (PDT)
Received-SPF: none (google.com: kasal@ucw.cz does not designate permitted sender hosts) client-ip=46.255.230.98;
Received: from 49-117-207-85.strcechy.adsl-llu.static.bluetone.cz (84.64.broadband3.iol.cz [85.70.64.84])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	(Authenticated sender: kasal)
	by jabberwock.ucw.cz (Postfix) with ESMTPSA id E8EFC1C00EF;
	Thu, 29 May 2014 12:47:16 +0200 (CEST)
Received: from camelia.ucw.cz (camelia.ucw.cz [127.0.0.1])
	by 49-117-207-85.strcechy.adsl-llu.static.bluetone.cz (8.14.3/8.14.3) with ESMTP id s4TAlGuE024140;
	Thu, 29 May 2014 12:47:16 +0200
Received: (from kasal@localhost)
	by camelia.ucw.cz (8.14.3/8.14.3/Submit) id s4TAlG7w024139;
	Thu, 29 May 2014 12:47:16 +0200
In-Reply-To: <20140529104329.GA24021@camelia.ucw.cz>
User-Agent: Mutt/1.5.19 (2009-01-05)
X-Original-Sender: kasal@ucw.cz
X-Original-Authentication-Results: gmr-mx.google.com;       spf=neutral
 (google.com: kasal@ucw.cz does not designate permitted sender hosts) smtp.mail=kasal@ucw.cz
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
Content-Disposition: inline
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250358>

Fix const warnings in http-fetch.c and remote-curl.c main() where is
argv declared as const.

The fix should work for all future declarations of main, no matter
whether the second parameter's type is "char**", "const char**", or
"char *[]".

Signed-off-by: Stepan Kasal <kasal@ucw.cz>
---
 compat/mingw.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/compat/mingw.h b/compat/mingw.h
index 15f0c9d..8745d19 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -369,10 +369,11 @@ extern CRITICAL_SECTION pinfo_cs;
 void mingw_startup();
 #define main(c,v) dummy_decl_mingw_main(); \
 static int mingw_main(c,v); \
-int main(int argc, char **argv) \
+int main(c, char **main_argv_not_used) \
 { \
+	typedef v, **argv_type; \
 	mingw_startup(); \
-	return mingw_main(__argc, __argv); \
+	return mingw_main(__argc, (argv_type)__argv); \
 } \
 static int mingw_main(c,v)
 
-- 
1.9.2.msysgit.0.496.g23aa553

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
