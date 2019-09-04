Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 14B551F461
	for <e@80x24.org>; Wed,  4 Sep 2019 11:09:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729658AbfIDLJv (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Sep 2019 07:09:51 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:32798 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbfIDLJv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Sep 2019 07:09:51 -0400
Received: by mail-pf1-f195.google.com with SMTP id q10so7968139pfl.0
        for <git@vger.kernel.org>; Wed, 04 Sep 2019 04:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kEl/zNscGUYUsfKU6oVGLUsZJ8xdtUyXNgxqyXmQ9BM=;
        b=On+kkuh+HfujLuhO0TClFF0vtg5C7vPDgzyqDtqr+2REKrvhgNhr6KsEmTnyfx6XcD
         kvK5fuIfmUyNcaQqkWkf+OJrloYaBgjzt21UPHm+jL/1JZHnWF52xjBwW+OJe/glCbBr
         HH8cz1UEbu/z6qIZJIpRjJSonvD7o4v+GdU/wl/lF89mTRzLKfSRTtzwiCXOPGSBndv+
         vh7c+0peuTEP5erqzL8GnJgMZV2JrdDqKPMaIRF8u8jSqF8iROq5BgBi/VW76vAG5MwD
         ePBmjlauMOr5xnNrY6M8VrLa4WmRlb9BdAqvB9pqyhQB0lBuqPLWnmZoVVDHyq1Q4IYC
         mB9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kEl/zNscGUYUsfKU6oVGLUsZJ8xdtUyXNgxqyXmQ9BM=;
        b=tn1skVH7RQfEIrgnKfTkd0wgBwa0u08pqbbvEi9h6MQXmlHKzXqScO/lnlqECJmwwp
         uN+QbTwvjkV7rhJL0JEU2qSIFeNHvWB8dxXwGBnQ57FsOizDBI23tZ5OwvmGW6WOmkcX
         k9VMdo/ZtfE3dC+pJfny2c8xH9WDVYNWRwD768u2M+hto3ugkvWpuM58bVNX8jveEEyN
         QFOEGesd49IprBaUZ7g5U59/rledxivj/bNFHED0LWXEPc0j8QlUMi1V3VsEqwjjRnlQ
         kitjYc9LXZ5Q4HEyTIM0dup/1hHwKuUGFldX6MqWO1MoGessehJsSAWP93GzziZeOMrs
         O7KQ==
X-Gm-Message-State: APjAAAUxsC5cMilQsVjAeg4AC7zgIcB3Olucwv8WRDswzPe5t939Q5M9
        /QvhI4nHS6RxZZ7uXjuRZb7bw79bMZY=
X-Google-Smtp-Source: APXvYqwI/7gjqW4d6/bXlpMFQ0dj0iSM3GPlEKQ+FHXu91fbkPWUsbJ/C5PbZd/viYV6EjC3ar2K1w==
X-Received: by 2002:a17:90a:9512:: with SMTP id t18mr4385775pjo.129.1567595390052;
        Wed, 04 Sep 2019 04:09:50 -0700 (PDT)
Received: from archbookpro.localdomain ([2601:646:280:1b30::6486])
        by smtp.gmail.com with ESMTPSA id d69sm13154276pfd.175.2019.09.04.04.09.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2019 04:09:49 -0700 (PDT)
Date:   Wed, 4 Sep 2019 04:09:48 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 2/2] compat/*.[ch]: remove extern from function declarations
 using spatch
Message-ID: <3c08556231576d8dfe496b87ae8cdcb87c00df24.1567595331.git.liu.denton@gmail.com>
References: <cover.1567595331.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1567595331.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In 554544276a (*.[ch]: remove extern from function declarations using
spatch, 2019-04-29), we removed externs from function declarations using
spatch but we intentionally excluded files under compat/ since some are
directly copied from an upstream and we should avoid churning them so
that manually merging future updates will be simpler.

In the last commit, we determined the files which taken from an upstream
so we can exclude them and run spatch on the remainder.

This was the Coccinelle patch used:

	@@
	type T;
	identifier f;
	@@
	- extern
	  T f(...);

and it was run with:

	$ git ls-files compat/\*\*.{c,h} |
		xargs spatch --sp-file contrib/coccinelle/noextern.cocci --in-place
	$ git checkout -- \
		compat/regex/ \
		compat/inet_ntop.c \
		compat/inet_pton.c \
		compat/nedmalloc/ \
		compat/obstack.{c,h} \
		compat/poll/

Coccinelle has some trouble dealing with `__attribute__` and varargs so
we ran the following to ensure that no remaining changes were left
behind:

	$ git ls-files compat/\*\*.{c,h} |
		xargs sed -i'' -e 's/^\(\s*\)extern \([^(]*([^*]\)/\1\2/'
	$ git checkout -- \
		compat/regex/ \
		compat/inet_ntop.c \
		compat/inet_pton.c \
		compat/nedmalloc/ \
		compat/obstack.{c,h} \
		compat/poll/

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 compat/mingw.h         | 6 +++---
 compat/win32/pthread.h | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/compat/mingw.h b/compat/mingw.h
index a03e40e6e2..9ad204c57c 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -11,7 +11,7 @@ typedef _sigset_t sigset_t;
 #undef _POSIX_THREAD_SAFE_FUNCTIONS
 #endif
 
-extern int mingw_core_config(const char *var, const char *value, void *cb);
+int mingw_core_config(const char *var, const char *value, void *cb);
 #define platform_core_config mingw_core_config
 
 /*
@@ -443,7 +443,7 @@ static inline void convert_slashes(char *path)
 			*path = '/';
 }
 #define PATH_SEP ';'
-extern char *mingw_query_user_email(void);
+char *mingw_query_user_email(void);
 #define query_user_email mingw_query_user_email
 #if !defined(__MINGW64_VERSION_MAJOR) && (!defined(_MSC_VER) || _MSC_VER < 1800)
 #define PRIuMAX "I64u"
@@ -580,4 +580,4 @@ int main(int argc, const char **argv);
 /*
  * Used by Pthread API implementation for Windows
  */
-extern int err_win_to_posix(DWORD winerr);
+int err_win_to_posix(DWORD winerr);
diff --git a/compat/win32/pthread.h b/compat/win32/pthread.h
index c6cb8dd219..f1cfe73de9 100644
--- a/compat/win32/pthread.h
+++ b/compat/win32/pthread.h
@@ -50,7 +50,7 @@ typedef struct {
 	DWORD tid;
 } pthread_t;
 
-extern int pthread_create(pthread_t *thread, const void *unused,
+int pthread_create(pthread_t *thread, const void *unused,
 			  void *(*start_routine)(void*), void *arg);
 
 /*
@@ -59,10 +59,10 @@ extern int pthread_create(pthread_t *thread, const void *unused,
  */
 #define pthread_join(a, b) win32_pthread_join(&(a), (b))
 
-extern int win32_pthread_join(pthread_t *thread, void **value_ptr);
+int win32_pthread_join(pthread_t *thread, void **value_ptr);
 
 #define pthread_equal(t1, t2) ((t1).tid == (t2).tid)
-extern pthread_t pthread_self(void);
+pthread_t pthread_self(void);
 
 static inline void NORETURN pthread_exit(void *ret)
 {
-- 
2.23.0.248.g3a9dd8fb08

