From: Stepan Kasal <kasal@ucw.cz>
Subject: [PATCH] Windows: Allow using UNC path for git repository
Date: Mon, 19 May 2014 15:23:34 +0200
Organization: <)><
Message-ID: <20140519132334.GA1435@camelia.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Erik Faye-Lund <kusmabite@gmail.com>, msysGit <msysgit@googlegroups.com>,
        Cezary Zawadka <czawadka@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
To: GIT Mailing-list <git@vger.kernel.org>
X-From: msysgit+bncBCU63DXMWULRBWUL5CNQKGQEWFFIJCY@googlegroups.com Mon May 19 15:23:39 2014
Return-path: <msysgit+bncBCU63DXMWULRBWUL5CNQKGQEWFFIJCY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wg0-f59.google.com ([74.125.82.59])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCU63DXMWULRBWUL5CNQKGQEWFFIJCY@googlegroups.com>)
	id 1WmNXX-0000x8-0U
	for gcvm-msysgit@m.gmane.org; Mon, 19 May 2014 15:23:39 +0200
Received: by mail-wg0-f59.google.com with SMTP id x12sf748533wgg.24
        for <gcvm-msysgit@m.gmane.org>; Mon, 19 May 2014 06:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:message-id:mime-version:organization
         :user-agent:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type
         :content-disposition;
        bh=rqmo+rHFb8TSAzGAtGScz+BfnfBuB+ayqUBJ7ZXXP7I=;
        b=Gjf5U4w2NQCQe0vSp2L5aCN223qJyG06tJ9+UKgQhFQscSkpDqUFH0HsLvkE6LXlB5
         Ay4nR7GJ5u13qvib4qfU7Xf1RcrecxvblBBzoqPFfJhfCucSAxJShiP8eRkE+MUkiVZC
         uvErEkTV/8RVGQ4zNFYjHXLidPx+0iNfOJSKark81XnlHicIsWLZ5ZBW/AdIGohL99nc
         7P0JUNa2cJJH522oagnWnUuhyZ0ebAXblcOZKyEE5PKVCXAM9doUGxKkvtRGg0BRVXgp
         jOjuPM8lKBfjtt8h/zFVCEIVtdsOuxoN7pDYtSFxSYcLi0XIkQhoubTwfeWfKtVVgC8f
         NUVQ==
X-Received: by 10.180.13.241 with SMTP id k17mr35845wic.0.1400505818686;
        Mon, 19 May 2014 06:23:38 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.21.230 with SMTP id y6ls451930wie.30.gmail; Mon, 19 May
 2014 06:23:37 -0700 (PDT)
X-Received: by 10.180.87.71 with SMTP id v7mr1036024wiz.2.1400505817491;
        Mon, 19 May 2014 06:23:37 -0700 (PDT)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz. [46.255.230.98])
        by gmr-mx.google.com with ESMTP id g42si468809eev.1.2014.05.19.06.23.36
        for <msysgit@googlegroups.com>;
        Mon, 19 May 2014 06:23:36 -0700 (PDT)
Received-SPF: none (google.com: kasal@ucw.cz does not designate permitted sender hosts) client-ip=46.255.230.98;
Received: from 49-117-207-85.strcechy.adsl-llu.static.bluetone.cz (84.64.broadband3.iol.cz [85.70.64.84])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	(Authenticated sender: kasal)
	by jabberwock.ucw.cz (Postfix) with ESMTPSA id 1DA591C00BE;
	Mon, 19 May 2014 15:23:36 +0200 (CEST)
Received: from camelia.ucw.cz (camelia.ucw.cz [127.0.0.1])
	by 49-117-207-85.strcechy.adsl-llu.static.bluetone.cz (8.14.3/8.14.3) with ESMTP id s4JDNZES001461;
	Mon, 19 May 2014 15:23:35 +0200
Received: (from kasal@localhost)
	by camelia.ucw.cz (8.14.3/8.14.3/Submit) id s4JDNY05001460;
	Mon, 19 May 2014 15:23:34 +0200
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249579>

From: Cezary Zawadka <czawadka@gmail.com>
Date: Tue, 13 Jul 2010 16:17:43 +0200

[efl: moved MinGW-specific part to compat/]
[jes: fixed compilation on non-Windows]

Eric Sunshine fixed mingw_offset_1st_component() to return consistently "foo"
for UNC "//machine/share/foo", cf
http://groups.google.com/group/msysgit/browse_thread/thread/c0af578549b5dda0

Author: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Cezary Zawadka <czawadka@gmail.com>
Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Stepan Kasal <kasal@ucw.cz>
---

Hello,
this is another patch that lived in msysGit for years, at least from
Jul 13, 2010.  It was there in two parts, first sketch by Cezary and
a fix from Eric Sunshine, but I decided to submit the combined
version.

Let me note that this patch should not affect any non-Windows
platform.  The chnage of offset_1st_component() to a simple macro is
ok, because has_dos_drive_prefix() is 0 there.

Regards,
  Stepan

 cache.h           |  1 -
 compat/mingw.c    | 24 ++++++++++++++++++++++++
 compat/mingw.h    |  2 ++
 git-compat-util.h |  4 ++++
 path.c            |  7 -------
 5 files changed, 30 insertions(+), 8 deletions(-)

diff --git a/cache.h b/cache.h
index ebe9a40..0961fb5 100644
--- a/cache.h
+++ b/cache.h
@@ -781,7 +781,6 @@ int normalize_path_copy(char *dst, const char *src);
 int longest_ancestor_length(const char *path, struct string_list *prefixes);
 char *strip_path_suffix(const char *path, const char *suffix);
 int daemon_avoid_alias(const char *path);
-int offset_1st_component(const char *path);
 
 /* object replacement */
 #define LOOKUP_REPLACE_OBJECT 1
diff --git a/compat/mingw.c b/compat/mingw.c
index e9892f8..a0e13bc 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -1823,3 +1823,27 @@ pid_t waitpid(pid_t pid, int *status, int options)
 	errno = EINVAL;
 	return -1;
 }
+
+int mingw_offset_1st_component(const char *path)
+{
+	int offset = 0;
+	if (has_dos_drive_prefix(path))
+		offset = 2;
+
+	/* unc paths */
+	else if (is_dir_sep(path[0]) && is_dir_sep(path[1])) {
+
+		/* skip server name */
+		char *pos = strpbrk(path + 2, "\\/");
+		if (!pos)
+			return 0; /* Error: malformed unc path */
+
+		do {
+			pos++;
+		} while (*pos && !is_dir_sep(*pos));
+
+		offset = pos - path;
+	}
+
+	return offset + is_dir_sep(path[offset]);
+}
diff --git a/compat/mingw.h b/compat/mingw.h
index e033e72..3eaf822 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -339,6 +339,8 @@ static inline char *mingw_find_last_dir_sep(const char *path)
 	return ret;
 }
 #define find_last_dir_sep mingw_find_last_dir_sep
+int mingw_offset_1st_component(const char *path);
+#define offset_1st_component mingw_offset_1st_component
 #define PATH_SEP ';'
 #define PRIuMAX "I64u"
 #define PRId64 "I64d"
diff --git a/git-compat-util.h b/git-compat-util.h
index d493a8c..ec41cfb 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -270,6 +270,10 @@ extern char *gitbasename(char *);
 #define has_dos_drive_prefix(path) 0
 #endif
 
+#ifndef offset_1st_component
+#define offset_1st_component(path) (is_dir_sep((path)[0]))
+#endif
+
 #ifndef is_dir_sep
 #define is_dir_sep(c) ((c) == '/')
 #endif
diff --git a/path.c b/path.c
index f9c5062..bc804a3 100644
--- a/path.c
+++ b/path.c
@@ -823,10 +823,3 @@ int daemon_avoid_alias(const char *p)
 		}
 	}
 }
-
-int offset_1st_component(const char *path)
-{
-	if (has_dos_drive_prefix(path))
-		return 2 + is_dir_sep(path[2]);
-	return is_dir_sep(path[0]);
-}
-- 
1.9.2.msysgit.0.490.ga07b726

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
