From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH] mingw_rmdir: do not prompt for retry when non-empty
Date: Tue,  4 Dec 2012 11:41:53 +0100
Message-ID: <1354617713-7436-1-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: msysgit@googlegroups.com,
	johannes.schindelin@gmx.de
To: git@vger.kernel.org
X-From: msysgit+bncBDR53PPJ7YHRBAFH66CQKGQES56PTFQ@googlegroups.com Tue Dec 04 11:42:22 2012
Return-path: <msysgit+bncBDR53PPJ7YHRBAFH66CQKGQES56PTFQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-fa0-f58.google.com ([209.85.161.58])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDR53PPJ7YHRBAFH66CQKGQES56PTFQ@googlegroups.com>)
	id 1TfpxF-0004IT-97
	for gcvm-msysgit@m.gmane.org; Tue, 04 Dec 2012 11:42:21 +0100
Received: by mail-fa0-f58.google.com with SMTP id v9sf1566170fav.3
        for <gcvm-msysgit@m.gmane.org>; Tue, 04 Dec 2012 02:42:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:x-beenthere:received-spf:from:to:cc:subject:date
         :message-id:x-mailer:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=q0m7+8l+KhYD48OSIw2cqRD49Iq08UYVKJO8XQlEbj0=;
        b=gV/VcGcwPqfeJIN3vSLWujAKEet1XNGZ5IMlyn9ltAA1byPjhJXEwmD1nYqH8Md467
         MKrYKdk0jEPqVmrmA3wOhBX39lQxxI+p/6mes5RsMkG2uQObqnv2HVjoQBkawQ2veaXA
         lscb4hm9D12VLlKJqECFaxNYmY/7txX7ITwqSG32ouej2NYpQEG/BZW2JgOByQ2sucRt
         ow3p19HbEY58t+Ni129cyEYXsDJhWa4QrP4X3n5vxFiNfT+GlXUzh3G5/8qqIImIWpgw
         J//JQSiR56RDKS8024N0M7YPo22ACtp8GeNOjHtvuF3oPlR2V/irpNGowZU+lN8aue8L
         9tCA==
Received: by 10.180.98.227 with SMTP id el3mr401091wib.10.1354617729489;
        Tue, 04 Dec 2012 02:42:09 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.87.7 with SMTP id t7ls1380348wiz.43.canary; Tue, 04 Dec
 2012 02:42:08 -0800 (PST)
Received: by 10.204.157.144 with SMTP id b16mr1860585bkx.4.1354617728725;
        Tue, 04 Dec 2012 02:42:08 -0800 (PST)
Received: by 10.204.157.144 with SMTP id b16mr1860583bkx.4.1354617728705;
        Tue, 04 Dec 2012 02:42:08 -0800 (PST)
Received: from mail-bk0-f54.google.com (mail-bk0-f54.google.com [209.85.214.54])
        by gmr-mx.google.com with ESMTPS id v18si84532bkw.1.2012.12.04.02.42.08
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 04 Dec 2012 02:42:08 -0800 (PST)
Received-SPF: pass (google.com: domain of kusmabite@gmail.com designates 209.85.214.54 as permitted sender) client-ip=209.85.214.54;
Received: by mail-bk0-f54.google.com with SMTP id je9so1509519bkc.41
        for <msysgit@googlegroups.com>; Tue, 04 Dec 2012 02:42:08 -0800 (PST)
Received: by 10.204.147.141 with SMTP id l13mr3807802bkv.43.1354617728537;
        Tue, 04 Dec 2012 02:42:08 -0800 (PST)
Received: from localhost ([77.40.159.131])
        by mx.google.com with ESMTPS id y11sm642378bkw.8.2012.12.04.02.42.06
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 04 Dec 2012 02:42:07 -0800 (PST)
X-Mailer: git-send-email 1.8.0.msysgit.0.3.g0262b9f.dirty
X-Original-Sender: kusmabite@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 domain of kusmabite@gmail.com designates 209.85.214.54 as permitted sender)
 smtp.mail=kusmabite@gmail.com; dkim=pass header.i=@gmail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post?hl=en>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=en>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=en>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211079>

in ab1a11be ("mingw_rmdir: set errno=ENOTEMPTY when appropriate"),
a check was added to prevent us from retrying to delete a directory
that is both in use and non-empty.

However, this logic was slightly flawed; since we didn't return
immediately, we end up falling out of the retry-loop, but right into
the prompting loop.

Fix this by simply returning from the function instead of breaking
the loop.

While we're at it, change the second break to a return as well; we
already know that we won't enter the prompting-loop, beacuse
is_file_in_use_error(GetLastError()) already evaluated to false.

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---

Here's a quick patch for a small issue I recently encountered; when
deleting a file from inside a directory, we currently end up
prompting the user if (s)he want us to retry deleting the directory
they are in.

 compat/mingw.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 1eb974f..2c29667 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -260,10 +260,10 @@ int mingw_rmdir(const char *pathname)
 
 	while ((ret = _wrmdir(wpathname)) == -1 && tries < ARRAY_SIZE(delay)) {
 		if (!is_file_in_use_error(GetLastError()))
-			break;
+			return ret;
 		if (!is_dir_empty(wpathname)) {
 			errno = ENOTEMPTY;
-			break;
+			return ret;
 		}
 		/*
 		 * We assume that some other process had the source or
-- 
1.8.0.msysgit.0.3.g0262b9f.dirty

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
