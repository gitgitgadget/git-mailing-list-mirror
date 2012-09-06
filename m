From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 7/7] t0000: verify that real_path() removes
 extra slashes
Date: Thu, 6 Sep 2012 12:44:07 +0700
Message-ID: <20120906054407.GA25981@duynguyen-vnpc.dek-tpc.internal>
References: <1346746470-23127-1-git-send-email-mhagger@alum.mit.edu>
 <1346746470-23127-8-git-send-email-mhagger@alum.mit.edu>
 <7v1uihbqhf.fsf@alter.siamese.dyndns.org>
 <CACsJy8DAbp1uDsNFFk1g9tuEV1qMnM2DZtxOwp5H9_VE7VwO1g@mail.gmail.com>
 <7v1uif7s1d.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: mhagger@alum.mit.edu, Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
	Orgad and Raizel Shaneh <orgads@gmail.com>,
	msysGit <msysgit@googlegroups.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: msysgit+bncCLWW9eeFGBDG8KCCBRoEA4WqWw@googlegroups.com Thu Sep 06 07:44:45 2012
Return-path: <msysgit+bncCLWW9eeFGBDG8KCCBRoEA4WqWw@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ie0-f186.google.com ([209.85.223.186])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncCLWW9eeFGBDG8KCCBRoEA4WqWw@googlegroups.com>)
	id 1T9UtP-0002Vf-BW
	for gcvm-msysgit@m.gmane.org; Thu, 06 Sep 2012 07:44:43 +0200
Received: by ieak13 with SMTP id k13sf699163iea.3
        for <gcvm-msysgit@m.gmane.org>; Wed, 05 Sep 2012 22:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=x-beenthere:received-spf:date:from:to:cc:subject:message-id
         :references:mime-version:in-reply-to:user-agent:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type:content-disposition;
        bh=htIaINF2rJ+cVECJO6B22xU7Ra5ij0eaGkrPAqV7+Ec=;
        b=cERobyW2jjruyJskO+jmHCZgTrWshu9PZ0Fe1muXQ4YvdvCatOjOtHM44SkFUCKGZu
         YaDw/3scBUVLYTo7REQIW2w2ZqRp7oo2bW0IEbTMQZF3IKSkYgvZxxZ62ZOwxTcrYV2J
         doIe6pokSmxbDsShUxz9QlwgG6HImlQFHaORPCyfIGEEfyuF1IBDQ9uxjgfdxOlN8XCR
         G6RRg2zzwls4Pt47myktR6Lm3E0BU1BCD84NweMc2+srZvVvw5iIV+fs2GcK/sn7jtnQ
         8HIf7wWdX5a2DwijOlMKDexljA5pcqt7DFl3HF9A2jZe0e9akAlqqINTMGgUOmBA 
Received: by 10.68.212.225 with SMTP id nn1mr215302pbc.18.1346910279559;
        Wed, 05 Sep 2012 22:44:39 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.68.210.197 with SMTP id mw5ls1369726pbc.7.gmail; Wed, 05 Sep
 2012 22:44:38 -0700 (PDT)
Received: by 10.66.82.98 with SMTP id h2mr204644pay.27.1346910278819;
        Wed, 05 Sep 2012 22:44:38 -0700 (PDT)
Received: by 10.66.82.98 with SMTP id h2mr204643pay.27.1346910278808;
        Wed, 05 Sep 2012 22:44:38 -0700 (PDT)
Received: from mail-pb0-f50.google.com (mail-pb0-f50.google.com [209.85.160.50])
        by gmr-mx.google.com with ESMTPS id p7si497575pby.0.2012.09.05.22.44.38
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 05 Sep 2012 22:44:38 -0700 (PDT)
Received-SPF: pass (google.com: domain of pclouds@gmail.com designates 209.85.160.50 as permitted sender) client-ip=209.85.160.50;
Received: by pbcmd12 with SMTP id md12so2211355pbc.37
        for <msysgit@googlegroups.com>; Wed, 05 Sep 2012 22:44:38 -0700 (PDT)
Received: by 10.68.220.201 with SMTP id py9mr3136863pbc.137.1346910278540;
        Wed, 05 Sep 2012 22:44:38 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id rm9sm770262pbc.72.2012.09.05.22.44.33
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 05 Sep 2012 22:44:37 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 06 Sep 2012 12:44:07 +0700
In-Reply-To: <7v1uif7s1d.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Original-Sender: pclouds@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 domain of pclouds@gmail.com designates 209.85.160.50 as permitted sender)
 smtp.mail=pclouds@gmail.com; dkim=pass header.i=@gmail.com
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
Content-Disposition: inline
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204866>

On Wed, Sep 05, 2012 at 08:23:58PM -0700, Junio C Hamano wrote:
> Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:
> 
> > diff --git a/path.c b/path.c
> > index 66acd24..ad2881c 100644
> > --- a/path.c
> > +++ b/path.c
> > @@ -503,6 +503,10 @@ int normalize_path_copy(char *dst, const char *src)
> >                 *dst++ = *src++;
> >                 *dst++ = *src++;
> >         }
> > +#ifdef WIN32
> > +       else if (src[0] == '/' && src[1] == '/')
> > +               *dst++ = *src++;
> > +#endif
> 
> The two-byte copy we see above the context is conditional on a nice
> abstraction "has_dos_drive_prefix()" so that we do not have to
> suffer from these ugly ifdefs.  Could we do something similar?

Just an idea. We could unify "[a-z]:" and "//host" into "dos root"
concept. That would teach other code paths about UNC paths too.

Replace has_dos_drive_prefix() with has_dos_root_prefix(). Because the
root component's length is not fixed, offset_1st_component() should be
used instead of hard coding "2".

Something like this. Totally untested.

-- 8< --
diff --git a/cache.h b/cache.h
index 67f28b4..7946489 100644
--- a/cache.h
+++ b/cache.h
@@ -711,7 +711,7 @@ extern char *expand_user_path(const char *path);
 const char *enter_repo(const char *path, int strict);
 static inline int is_absolute_path(const char *path)
 {
-	return is_dir_sep(path[0]) || has_dos_drive_prefix(path);
+	return is_dir_sep(path[0]) || has_dos_root_prefix(path);
 }
 int is_directory(const char *);
 const char *real_path(const char *path);
@@ -721,7 +721,7 @@ int normalize_path_copy(char *dst, const char *src);
 int longest_ancestor_length(const char *path, const char *prefix_list);
 char *strip_path_suffix(const char *path, const char *suffix);
 int daemon_avoid_alias(const char *path);
-int offset_1st_component(const char *path);
+int offset_1st_component(const char *path, int keep_root);
 
 /* object replacement */
 #define READ_SHA1_FILE_REPLACE 1
diff --git a/compat/basename.c b/compat/basename.c
index d8f8a3c..178b60d 100644
--- a/compat/basename.c
+++ b/compat/basename.c
@@ -5,8 +5,7 @@ char *gitbasename (char *path)
 {
 	const char *base;
 	/* Skip over the disk name in MSDOS pathnames. */
-	if (has_dos_drive_prefix(path))
-		path += 2;
+	path += offset_1st_component(path, 0);
 	for (base = path; *path; path++) {
 		if (is_dir_sep(*path))
 			base = path + 1;
diff --git a/compat/mingw.h b/compat/mingw.h
index 61a6521..1ca3e19 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -302,7 +302,9 @@ int winansi_fprintf(FILE *stream, const char *format, ...) __attribute__((format
  * git specific compatibility
  */
 
-#define has_dos_drive_prefix(path) (isalpha(*(path)) && (path)[1] == ':')
+#define has_dos_root_prefix(path) \
+	((is_dir_sep[(path)[0]] && is_dir_sep[(path)[1]]) \
+	 || (isalpha(*(path)) && (path)[1] == ':'))
 #define is_dir_sep(c) ((c) == '/' || (c) == '\\')
 static inline char *mingw_find_last_dir_sep(const char *path)
 {
diff --git a/connect.c b/connect.c
index 55a85ad..3d9f7fe 100644
--- a/connect.c
+++ b/connect.c
@@ -521,7 +521,7 @@ struct child_process *git_connect(int fd[2], const char *url_orig,
 		end = host;
 
 	path = strchr(end, c);
-	if (path && !has_dos_drive_prefix(end)) {
+	if (path && (!isalpha(*end) || end[1] != ':')) {
 		if (c == ':') {
 			protocol = PROTO_SSH;
 			*path++ = '\0';
diff --git a/git-compat-util.h b/git-compat-util.h
index 35b095e..c6656e2 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -216,8 +216,8 @@ extern char *gitbasename(char *);
 #define STRIP_EXTENSION ""
 #endif
 
-#ifndef has_dos_drive_prefix
-#define has_dos_drive_prefix(path) 0
+#ifndef has_dos_root_prefix
+#define has_dos_root_prefix(path) 0
 #endif
 
 #ifndef is_dir_sep
diff --git a/path.c b/path.c
index 66acd24..0e4e2d7 100644
--- a/path.c
+++ b/path.c
@@ -498,11 +498,12 @@ const char *relative_path(const char *abs, const char *base)
 int normalize_path_copy(char *dst, const char *src)
 {
 	char *dst0;
+	int i, len;
 
-	if (has_dos_drive_prefix(src)) {
+	len = offset_1st_component(src, 1);
+	for (i = 0; i < len; i++)
 		*dst++ = *src++;
-		*dst++ = *src++;
-	}
+
 	dst0 = dst;
 
 	if (is_dir_sep(*src)) {
@@ -702,9 +703,18 @@ int daemon_avoid_alias(const char *p)
 	}
 }
 
-int offset_1st_component(const char *path)
+int offset_1st_component(const char *path, int keep_root)
 {
-	if (has_dos_drive_prefix(path))
-		return 2 + is_dir_sep(path[2]);
-	return is_dir_sep(path[0]);
+	if (has_dos_root_prefix(path)) {
+		if (path[1] == ':')
+			return 2 + (keep_root ? 0 : is_dir_sep(path[2]));
+		else {
+			const char *s = strchr(path + 2, '/');
+			/* //host is considered a "drive" */
+			if (s)
+				return s - path + (keep_root ? 0 : 1);
+		}
+	}
+
+	return keep_root ? 0 : is_dir_sep(path[0]);
 }
diff --git a/read-cache.c b/read-cache.c
index 2f8159f..d4d339a 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -755,7 +755,7 @@ int verify_path(const char *path)
 {
 	char c;
 
-	if (has_dos_drive_prefix(path))
+	if (has_dos_root_prefix(path))
 		return 0;
 
 	goto inside;
diff --git a/setup.c b/setup.c
index 9139bee..e010cf8 100644
--- a/setup.c
+++ b/setup.c
@@ -26,7 +26,7 @@ static char *prefix_path_gently(const char *prefix, int len, const char *path)
 		if (!work_tree)
 			goto error_out;
 		len = strlen(work_tree);
-		root_len = offset_1st_component(work_tree);
+		root_len = offset_1st_component(work_tree, 0);
 		total = strlen(sanitized) + 1;
 		if (strncmp(sanitized, work_tree, len) ||
 		    (len > root_len && sanitized[len] != '\0' && sanitized[len] != '/')) {
@@ -587,7 +587,7 @@ static const char *setup_bare_git_dir(char *cwd, int offset, int len, int *nongi
 	if (offset != len) {
 		if (chdir(cwd))
 			die_errno("Cannot come back to cwd");
-		root_len = offset_1st_component(cwd);
+		root_len = offset_1st_component(cwd, 0);
 		cwd[offset > root_len ? offset : root_len] = '\0';
 		set_git_dir(cwd);
 	}
@@ -654,7 +654,7 @@ static const char *setup_git_directory_gently_1(int *nongit_ok)
 		return setup_explicit_git_dir(gitdirenv, cwd, len, nongit_ok);
 
 	ceil_offset = longest_ancestor_length(cwd, env_ceiling_dirs);
-	if (ceil_offset < 0 && has_dos_drive_prefix(cwd))
+	if (ceil_offset < 0 && has_dos_root_prefix(cwd))
 		ceil_offset = 1;
 
 	/*
diff --git a/sha1_file.c b/sha1_file.c
index af5cfbd..21ce020 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -102,7 +102,7 @@ int mkdir_in_gitdir(const char *path)
 
 int safe_create_leading_directories(char *path)
 {
-	char *pos = path + offset_1st_component(path);
+	char *pos = path + offset_1st_component(path, 0);
 	struct stat st;
 
 	while (pos) {
diff --git a/transport.c b/transport.c
index 1811b50..5141e8f 100644
--- a/transport.c
+++ b/transport.c
@@ -869,7 +869,7 @@ static int is_local(const char *url)
 	const char *colon = strchr(url, ':');
 	const char *slash = strchr(url, '/');
 	return !colon || (slash && slash < colon) ||
-		has_dos_drive_prefix(url);
+		has_dos_root_prefix(url);
 }
 
 static int is_file(const char *url)
-- 8< --

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
