From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: [PATCH 0/5 v2] Introduce the .gitfile
Date: Mon, 18 Feb 2008 15:01:07 +0100
Message-ID: <8c5c35580802180601h5cf01c5h583458fee61caa7a@mail.gmail.com>
References: <1203331463-13857-1-git-send-email-hjemli@gmail.com>
	 <alpine.LSU.1.00.0802181214400.30505@racer.site>
	 <8c5c35580802180456s75c9f857of1f727aca4673374@mail.gmail.com>
	 <alpine.LSU.1.00.0802181330030.30505@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Junio C Hamano" <gitster@pobox.com>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Feb 18 15:02:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JR6Z0-00089O-UR
	for gcvg-git-2@gmane.org; Mon, 18 Feb 2008 15:01:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751705AbYBROBL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2008 09:01:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751612AbYBROBL
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Feb 2008 09:01:11 -0500
Received: from wa-out-1112.google.com ([209.85.146.181]:57461 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751367AbYBROBI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2008 09:01:08 -0500
Received: by wa-out-1112.google.com with SMTP id v27so2813608wah.23
        for <git@vger.kernel.org>; Mon, 18 Feb 2008 06:01:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=0tjrFocLQRDemEHeHRW+hVccXQWRXOj8wVnq5zgPoCU=;
        b=WA+DYY/KDZxZv44kVdl9wS5g8vIW95YS2FdP9mu4IblDz87UsQ3UFj8riVh0lmSNp6+TpjH2rog7RQr9YPPvqwVCCTWsbCiDRRbq6dhRQ5x2oaaWAdNPAiIdc71oCTK1/64TMdG7roeMM7jY8R36o/5ko/Ni2rso1gKjyUC1CGE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=xKEHl3mrmkSF5FsjQbB8aas5J0G5CgDcmGUQZK3zwcKmFaUgT3wtekIW4uqMhXhOBcTNk0PsEtFx8b8eKC5YH5lr5cvzLUglzYpYaVr3U5oBh6oxA6xe5lZXd6+wsQ2mTBiWsYsmifotWOhH5cBkWcULiDVdulKzjtx33KDxjXM=
Received: by 10.114.66.2 with SMTP id o2mr1589745waa.111.1203343267718;
        Mon, 18 Feb 2008 06:01:07 -0800 (PST)
Received: by 10.115.92.8 with HTTP; Mon, 18 Feb 2008 06:01:07 -0800 (PST)
In-Reply-To: <alpine.LSU.1.00.0802181330030.30505@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74291>

On Feb 18, 2008 2:31 PM, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Mon, 18 Feb 2008, Lars Hjemli wrote:
>
> > On Feb 18, 2008 1:17 PM, Johannes Schindelin wrote:
> > > In the case of patch "1/5 => 2/5", I would even have appreciated an
> > > interdiff...
> >
> > Sorry, but I don't think I understand what you mean by interdiff.
>
> The tool interdiff of patchutils is really nice: you can visualise what
> would be the diff between the state after applying the first patch, and
> the state after applying the second patch, without applying anything at
> all:
>
>         $ interdiff <patch1> <patch2>

Ok, that sounds useful (I was kind of confused since 'man interdiff'
gave me nothing: being on slackware I'm so spoiled with preinstalled
dev-tools that I see no point in consulting google ;).

Something like this (possibly mangled by gmail)?

$ interdiff prev-patch-2 curr-patch-1
diff -u b/git-sh-setup.sh b/git-sh-setup.sh
--- b/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -127,11 +127,7 @@
 # if we require to be in a git repository.
 if test -z "$NONGIT_OK"
 then
-       GIT_DIR=$(git rev-parse --git-dir) || {
-               exit=$?
-               echo >&2 "Failed to find a valid git directory."
-               exit $exit
-       }
+       GIT_DIR=$(git rev-parse --git-dir) || exit
        if [ -z "$SUBDIRECTORY_OK" ]
        then
                test -z "$(git rev-parse --show-cdup)" || {

$ interdiff prev-patch-1 curr-patch-2
diff -u b/Documentation/repository-layout.txt
b/Documentation/repository-layout.txt
--- b/Documentation/repository-layout.txt
+++ b/Documentation/repository-layout.txt
@@ -5,7 +5,7 @@
 directory for a repository associated with your working tree, or
 `'project'.git` directory for a public 'bare' repository. It is
 also possible to have a working tree where `.git` is a plain
-ascii file containing `gitdir: <path>\n`, i.e. the path to the
+ascii file containing `gitdir: <path>`, i.e. the path to the
 real git repository).

 objects::
diff -u b/environment.c b/environment.c
--- b/environment.c
+++ b/environment.c
@@ -45,42 +45,6 @@
 static const char *git_dir;
 static char *git_object_dir, *git_index_file, *git_refs_dir, *git_graft_file;

-/*
- * Try to read the location of the git directory from the .git file,
- * return path to git directory if found.
- * Format of the .git file is
- *    gitdir: <path>\n
- */
-const char *read_gitfile_gently(const char *path)
-{
-       static char buf[PATH_MAX + 9];  /* "gitdir: " + "\n" */
-       struct stat st;
-       int fd;
-       size_t len;
-
-       if (stat(path, &st))
-               return NULL;
-       if (!S_ISREG(st.st_mode) || st.st_size >= sizeof(buf))
-               return NULL;
-       fd = open(path, O_RDONLY);
-       if (fd < 0)
-               return NULL;
-       len = read_in_full(fd, buf, sizeof(buf));
-       close(fd);
-       if (len != st.st_size)
-               return NULL;
-       if (!len || buf[len - 1] != '\n')
-               return NULL;
-       buf[len - 1] = '\0';
-       if (prefixcmp(buf, "gitdir: "))
-               return NULL;
-/*
-       if (!is_git_directory(buf + 8))
-               return NULL;
-*/
-       return make_absolute_path(buf + 8);
-}
-
 static void setup_git_env(void)
 {
        git_dir = getenv(GIT_DIR_ENVIRONMENT);
diff -u b/setup.c b/setup.c
--- b/setup.c
+++ b/setup.c
@@ -239,6 +239,44 @@
 }

 /*
+ * Try to read the location of the git directory from the .git file,
+ * return path to git directory if found.
+ */
+const char *read_gitfile_gently(const char *path)
+{
+       char *buf;
+       struct stat st;
+       int fd;
+       size_t len;
+
+       if (stat(path, &st))
+               return NULL;
+       if (!S_ISREG(st.st_mode))
+               return NULL;
+       fd = open(path, O_RDONLY);
+       if (fd < 0)
+               die("Error opening %s: %s", path, strerror(errno));
+       buf = xmalloc(st.st_size + 1);
+       len = read_in_full(fd, buf, st.st_size);
+       close(fd);
+       if (len != st.st_size)
+               die("Error reading %s", path);
+       buf[len] = '\0';
+       if (prefixcmp(buf, "gitdir: "))
+               die("Invalid gitfile format: %s", path);
+       while (buf[len - 1] == '\n' || buf[len - 1] == '\r')
+               len--;
+       if (len < 9)
+               die("No path in gitfile: %s", path);
+       buf[len] = '\0';
+       if (!is_git_directory(buf + 8))
+               die("Not a git repository: %s", buf + 8);
+       path = make_absolute_path(buf + 8);
+       free(buf);
+       return path;
+}
+
+/*
  * We cannot decide in this function whether we are in the work tree or
  * not, since the config can only be read _after_ this function was called.
  */
@@ -294,10 +332,10 @@

        /*
         * Test in the following order (relative to the cwd):
-        * - .git (file containing "gitdir: <path>\n")
+        * - .git (file containing "gitdir: <path>")
         * - .git/
         * - ./ (bare)
-        * - ../.git (file containing "gitdir: <path>\n")
+        * - ../.git
         * - ../.git/
         * - ../ (bare)
         * - ../../.git/
@@ -306,9 +344,9 @@
        offset = len = strlen(cwd);
        for (;;) {
                gitfile_dir = read_gitfile_gently(DEFAULT_GIT_DIR_ENVIRONMENT);
-               if (gitfile_dir && is_git_directory(gitfile_dir)) {
+               if (gitfile_dir) {
                        if (set_git_dir(gitfile_dir))
-                               return NULL;
+                               die("Repository setup failed");
                        break;
                }
                if (is_git_directory(DEFAULT_GIT_DIR_ENVIRONMENT))


--
larsh
