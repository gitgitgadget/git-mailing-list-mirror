Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E13951FE90
	for <e@80x24.org>; Tue, 25 Apr 2017 18:04:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1432216AbdDYSE5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Apr 2017 14:04:57 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33639 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S971581AbdDYSEz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2017 14:04:55 -0400
Received: by mail-pf0-f196.google.com with SMTP id c198so11852092pfc.0
        for <git@vger.kernel.org>; Tue, 25 Apr 2017 11:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8nYMLKUcMMwEhBl6yskCmITX0UBQQBYgcU2FM0hZzgA=;
        b=CTQZT5ub4Dltp1SvLqJgnBUzOCTV9JnYFpia2FmBGNo4gba5pAPdjshzb+bYpPxk54
         1SzCAZqilDx1w6w1KTOJvQZPUC5XrzUm5bZZZKN25Hgbt8DVjzB+f3ba3zHgoX+qIg32
         P1bI7W4pdjdjITw1Qz9Xahyv4mZrbirjMQ+JRIf6fjndIUoTm06VKNjjcR+fAEBXkQkp
         EQNLca1CPEmR6TAWYd0dNQyM2FJz+tnmUrJCGQ+26hbFJ9aqvULHkLEnDD4dMTwXOsJt
         Cwi9XeDpxp/6PdU9Xp3laSZ5JlFIbI+eh+OpAG0XsQ4WngHLhxiw+1FIp9BxnbVttfzo
         wPLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8nYMLKUcMMwEhBl6yskCmITX0UBQQBYgcU2FM0hZzgA=;
        b=Hlx2tbju9ILNbcTdhXFevRhT3/4GHur4gEAFrcodlPwIeSiROpGSLMZw1212IjES66
         H1aP0iRi/y92x2rLQz0raLgI8dDa/0FK0DiILOmJlz/DqSZ/OPb2GMdr1a6GglTFnyd5
         V6oOhRZuj1cGQHPFvIW/hPFypXfI0tVEfmtpstqsuHgQSuecPHNJcsZ9kLKiL/7NCHlE
         ptfMHvCk0S6+Ok34fs4Rb5t0alDFqR+Dk1IN2/1kd5unE+O8gG0S7HCL84c/l1Dide6O
         bsGUxAAJCg48ojNgH3ZKsSqZRMHHjfr6uxibEo+oAvkcNypjPUBVG1Mac1sHyFnLv9jN
         aNAg==
X-Gm-Message-State: AN3rC/4G0h0AW+Qid0L6ZGwXikYxBgNUBLw8gotUXe2f5T8RBJz6+u8d
        Shq4kbjAsHlefaY0Rgw=
X-Received: by 10.99.175.8 with SMTP id w8mr29663131pge.170.1493143494579;
        Tue, 25 Apr 2017 11:04:54 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:c0ea:3a03:d3a7:cb53])
        by smtp.gmail.com with ESMTPSA id m8sm16129810pgd.59.2017.04.25.11.04.53
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 25 Apr 2017 11:04:53 -0700 (PDT)
Date:   Tue, 25 Apr 2017 11:04:51 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, j6t@kdbg.org,
        sbeller@google.com, e@80x24.org, peff@peff.net
Subject: Re: [PATCH v7 1/2] exec_cmd: expose is_executable function
Message-ID: <20170425180451.GJ28740@aiede.svl.corp.google.com>
References: <20170424235042.26627-1-bmwill@google.com>
 <20170425175446.113553-1-bmwill@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170425175446.113553-1-bmwill@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Brandon Williams wrote:

> Move the logic for 'is_executable()' from help.c to exec_cmd.c and
> expose it so that callers from outside help.c can access the function.
> This is to enable run-command to be able to query if a file is
> executable in a future patch.
>
> Signed-off-by: Brandon Williams <bmwill@google.com>
> ---
>  exec_cmd.c | 42 ++++++++++++++++++++++++++++++++++++++++++
>  exec_cmd.h |  1 +
>  help.c     | 42 ------------------------------------------
>  3 files changed, 43 insertions(+), 42 deletions(-)

Makes sense.  Seems like as fine place for it.  (exec_cmd.c is mostly
an implementation detail of run_command, to hold the logic for
executing a git command.  This is another run_command helper, and it
doesn't feel illogical to find it there.  Another alternative place to
put t would be in run-command.c.)

> diff --git a/exec_cmd.c b/exec_cmd.c
> index fb94aeba9..6d9481e26 100644
> --- a/exec_cmd.c
> +++ b/exec_cmd.c
> @@ -149,3 +149,45 @@ int execl_git_cmd(const char *cmd,...)
>  	argv[argc] = NULL;
>  	return execv_git_cmd(argv);
>  }
> +
> +int is_executable(const char *name)

nit: it's a good practice to find a logical place for a new function in
the existing file, instead of defaulting to the end.  That way, the file
is easier to read sequentially, and if two different patches want to
add a function to the same file then they are less likely to conflict.

This could go before prepare_git_cmd, for example.

With or without such a tweak,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

diff --git i/exec_cmd.c w/exec_cmd.c
index 6d9481e26d..601fbc43bc 100644
--- i/exec_cmd.c
+++ w/exec_cmd.c
@@ -104,6 +104,48 @@ void setup_path(void)
 	strbuf_release(&new_path);
 }
 
+int is_executable(const char *name)
+{
+	struct stat st;
+
+	if (stat(name, &st) || /* stat, not lstat */
+	    !S_ISREG(st.st_mode))
+		return 0;
+
+#if defined(GIT_WINDOWS_NATIVE)
+	/*
+	 * On Windows there is no executable bit. The file extension
+	 * indicates whether it can be run as an executable, and Git
+	 * has special-handling to detect scripts and launch them
+	 * through the indicated script interpreter. We test for the
+	 * file extension first because virus scanners may make
+	 * it quite expensive to open many files.
+	 */
+	if (ends_with(name, ".exe"))
+		return S_IXUSR;
+
+{
+	/*
+	 * Now that we know it does not have an executable extension,
+	 * peek into the file instead.
+	 */
+	char buf[3] = { 0 };
+	int n;
+	int fd = open(name, O_RDONLY);
+	st.st_mode &= ~S_IXUSR;
+	if (fd >= 0) {
+		n = read(fd, buf, 2);
+		if (n == 2)
+			/* look for a she-bang */
+			if (!strcmp(buf, "#!"))
+				st.st_mode |= S_IXUSR;
+		close(fd);
+	}
+}
+#endif
+	return st.st_mode & S_IXUSR;
+}
+
 const char **prepare_git_cmd(struct argv_array *out, const char **argv)
 {
 	argv_array_push(out, "git");
@@ -149,45 +191,3 @@ int execl_git_cmd(const char *cmd,...)
 	argv[argc] = NULL;
 	return execv_git_cmd(argv);
 }
-
-int is_executable(const char *name)
-{
-	struct stat st;
-
-	if (stat(name, &st) || /* stat, not lstat */
-	    !S_ISREG(st.st_mode))
-		return 0;
-
-#if defined(GIT_WINDOWS_NATIVE)
-	/*
-	 * On Windows there is no executable bit. The file extension
-	 * indicates whether it can be run as an executable, and Git
-	 * has special-handling to detect scripts and launch them
-	 * through the indicated script interpreter. We test for the
-	 * file extension first because virus scanners may make
-	 * it quite expensive to open many files.
-	 */
-	if (ends_with(name, ".exe"))
-		return S_IXUSR;
-
-{
-	/*
-	 * Now that we know it does not have an executable extension,
-	 * peek into the file instead.
-	 */
-	char buf[3] = { 0 };
-	int n;
-	int fd = open(name, O_RDONLY);
-	st.st_mode &= ~S_IXUSR;
-	if (fd >= 0) {
-		n = read(fd, buf, 2);
-		if (n == 2)
-			/* look for a she-bang */
-			if (!strcmp(buf, "#!"))
-				st.st_mode |= S_IXUSR;
-		close(fd);
-	}
-}
-#endif
-	return st.st_mode & S_IXUSR;
-}
diff --git i/exec_cmd.h w/exec_cmd.h
index 48dd18a0d4..5e8200b952 100644
--- i/exec_cmd.h
+++ w/exec_cmd.h
@@ -7,11 +7,11 @@ extern void git_set_argv_exec_path(const char *exec_path);
 extern void git_extract_argv0_path(const char *path);
 extern const char *git_exec_path(void);
 extern void setup_path(void);
+extern int is_executable(const char *name);
 extern const char **prepare_git_cmd(struct argv_array *out, const char **argv);
 extern int execv_git_cmd(const char **argv); /* NULL terminated */
 LAST_ARG_MUST_BE_NULL
 extern int execl_git_cmd(const char *cmd, ...);
 extern char *system_path(const char *path);
-extern int is_executable(const char *name);
 
 #endif /* GIT_EXEC_CMD_H */
