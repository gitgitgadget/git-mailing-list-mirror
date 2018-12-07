Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 29AE020A1E
	for <e@80x24.org>; Fri,  7 Dec 2018 17:05:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726095AbeLGRFC (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Dec 2018 12:05:02 -0500
Received: from mout.web.de ([212.227.15.14]:46441 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726083AbeLGRFB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Dec 2018 12:05:01 -0500
Received: from tor.lan ([195.198.252.176]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LilMD-1h3Xyj0Bcj-00d1Qs; Fri, 07
 Dec 2018 18:05:00 +0100
From:   tboegi@web.de
To:     git@vger.kernel.org, svnpenn@gmail.com
Cc:     =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH v2 2/3] offset_1st_component(), dos_drive_prefix() return size_t
Date:   Fri,  7 Dec 2018 18:04:58 +0100
Message-Id: <20181207170458.9036-1-tboegi@web.de>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05
In-Reply-To: <5bf18396.1c69fb81.20780.2b1d@mx.google.com>
References: <5bf18396.1c69fb81.20780.2b1d@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:KVxW49Od9hRlRHUbc7+XLCzLzLjl1xWkmQ1C/sfz96PSz39KXbm
 LR22wCM0nnizx8hrK1AnwsVfnnyEvYNWzIVVc9GD55sE1JS6CtiHKv2pIrAbofkr8UD3bp3
 j5fAVSBKGQLCTVlIkrmf6qfREAtSpJ5Spo2XUu2UNlub4hShZjES+NVqghV75EG3757bKI/
 Ws9SfGAvguKYhgi5oGPxA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:DCJWnKghJHY=:ybSDDojNgFpsm1fnyIUfCP
 qqvBw47Awe90TnP+6LzHIhaM8U0T+BN33kx/9aSsnYAV0dzA2PHUc0DEcRwMLrMDpPn9X+WOn
 d0nu6vZpCDCFYy29A+PUegBZkaLBo5Ql8BpQJ/V/VkuVtZ1kFk2KlVq3suywL0x/MNYF0GXmk
 OemJlk2FJoErXJermjKhWBWlm9GsVyX82fPfy8wa4ZwXc3cuaEZbLU5wis/xoV69yduBn1tcp
 dm0FlWbHsdWI4IcWd/OSPJuERX5FC9aG5cBUINcYYsUbE3t5SvJZt/Ptqn1fGJipWnc1stlrg
 1ZBlgO3VE72LirgABqzipyXMkd1ZQ2XxoKO1G1unnIOV05NP7OnaXg6eLBsnFyfYrmbGI5+Pw
 575bT0YdBuCM4u5KgG0ArR1WCoyR6V99J4aKY7zSe21Vx3U/kzsGicG2EINPRcs6EInTGpCr0
 otNInuSyQmO5qIK362lwLnLsfqx/wnX7jjUc1LZIs1p9rjW7wJMWpqhHmUcnQKLQSW0fRrTm/
 WheAleAYGLVxEedL/I5upMgoUdzSg1QfmUYnlIMlc5wIrnxxZgeBmFa+KdWLy1lX283lEOWWX
 DupKWAM/UlgYMCmQXTAhpAecYvlVimtdUAGWj5DJjRFmycMWHVou/W631M1fjgOKU5vzAb4XT
 0XqcohaxyEXovX8TgS0p6J0d4iwQ3u2cfT2MviPTJj/TY3u83ik8U+ucyodB2nervUnjAkeSR
 Ur6yEqNUP2bCg5KlJY4YiFGAcdHA1fUMkQqCoAyDbU5vJMfoBIh2cofTGVAL6aOzviqDb8doU
 sNMULAywXItpm0glyJvtuTQhWVK4C1Ta3sQNbLiC+fGG9TjPfGppLoEDzxY/xHhKXoEiKDzrc
 qUq9VRBZ45bmXkMbs/UEb1gR0b4KtKkyM9sCUlk5ZGU8SJ3oZW5XSzcY7ygFhz
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Torsten Bögershausen <tboegi@web.de>

Change the return value for offset_1st_component(),
has_dos_drive_prefix() and skip_dos_drive_prefix from int into size_t,
which is the natural type for length of data in memory.

While at it, remove possible "parameter not used" warnings in for the
non-Windows builds in git-compat-util.h

Signed-off-by: Torsten Bögershausen <tboegi@web.de>
---
 abspath.c             | 2 +-
 compat/mingw-cygwin.c | 6 +++---
 compat/mingw-cygwin.h | 4 ++--
 git-compat-util.h     | 8 +++++---
 setup.c               | 4 ++--
 5 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/abspath.c b/abspath.c
index 9857985329..12055a1d8f 100644
--- a/abspath.c
+++ b/abspath.c
@@ -51,7 +51,7 @@ static void get_next_component(struct strbuf *next, struct strbuf *remaining)
 /* copies root part from remaining to resolved, canonicalizing it on the way */
 static void get_root_part(struct strbuf *resolved, struct strbuf *remaining)
 {
-	int offset = offset_1st_component(remaining->buf);
+	size_t offset = offset_1st_component(remaining->buf);
 
 	strbuf_reset(resolved);
 	strbuf_add(resolved, remaining->buf, offset);
diff --git a/compat/mingw-cygwin.c b/compat/mingw-cygwin.c
index c63d7acb9c..5552c3ac20 100644
--- a/compat/mingw-cygwin.c
+++ b/compat/mingw-cygwin.c
@@ -1,13 +1,13 @@
 #include "../git-compat-util.h"
 
-int mingw_cygwin_skip_dos_drive_prefix(char **path)
+size_t mingw_cygwin_skip_dos_drive_prefix(char **path)
 {
-	int ret = has_dos_drive_prefix(*path);
+	size_t ret = has_dos_drive_prefix(*path);
 	*path += ret;
 	return ret;
 }
 
-int mingw_cygwin_offset_1st_component(const char *path)
+size_t mingw_cygwin_offset_1st_component(const char *path)
 {
 	char *pos = (char *)path;
 
diff --git a/compat/mingw-cygwin.h b/compat/mingw-cygwin.h
index 66ccc909ae..0e8a0c9074 100644
--- a/compat/mingw-cygwin.h
+++ b/compat/mingw-cygwin.h
@@ -1,6 +1,6 @@
 #define has_dos_drive_prefix(path) \
 	(isalpha(*(path)) && (path)[1] == ':' ? 2 : 0)
-int mingw_cygwin_skip_dos_drive_prefix(char **path);
+size_t mingw_cygwin_skip_dos_drive_prefix(char **path);
 #define skip_dos_drive_prefix mingw_cygwin_skip_dos_drive_prefix
 static inline int mingw_cygwin_is_dir_sep(int c)
 {
@@ -16,5 +16,5 @@ static inline char *mingw_cygwin_find_last_dir_sep(const char *path)
 	return ret;
 }
 #define find_last_dir_sep mingw_cygwin_find_last_dir_sep
-int mingw_cygwin_offset_1st_component(const char *path);
+size_t mingw_cygwin_offset_1st_component(const char *path);
 #define offset_1st_component mingw_cygwin_offset_1st_component
diff --git a/git-compat-util.h b/git-compat-util.h
index 7ece969b22..65eaaf0d50 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -355,16 +355,18 @@ static inline int noop_core_config(const char *var, const char *value, void *cb)
 #endif
 
 #ifndef has_dos_drive_prefix
-static inline int git_has_dos_drive_prefix(const char *path)
+static inline size_t git_has_dos_drive_prefix(const char *path)
 {
+	(void)path;
 	return 0;
 }
 #define has_dos_drive_prefix git_has_dos_drive_prefix
 #endif
 
 #ifndef skip_dos_drive_prefix
-static inline int git_skip_dos_drive_prefix(char **path)
+static inline size_t git_skip_dos_drive_prefix(char **path)
 {
+	(void)path;
 	return 0;
 }
 #define skip_dos_drive_prefix git_skip_dos_drive_prefix
@@ -379,7 +381,7 @@ static inline int git_is_dir_sep(int c)
 #endif
 
 #ifndef offset_1st_component
-static inline int git_offset_1st_component(const char *path)
+static inline size_t git_offset_1st_component(const char *path)
 {
 	return is_dir_sep(path[0]);
 }
diff --git a/setup.c b/setup.c
index 1be5037f12..538bc1ff99 100644
--- a/setup.c
+++ b/setup.c
@@ -29,7 +29,7 @@ static int abspath_part_inside_repo(char *path)
 	size_t len;
 	size_t wtlen;
 	char *path0;
-	int off;
+	size_t off;
 	const char *work_tree = get_git_work_tree();
 
 	if (!work_tree)
@@ -800,7 +800,7 @@ static const char *setup_bare_git_dir(struct strbuf *cwd, int offset,
 				      struct repository_format *repo_fmt,
 				      int *nongit_ok)
 {
-	int root_len;
+	size_t root_len;
 
 	if (check_repository_format_gently(".", repo_fmt, nongit_ok))
 		return NULL;
-- 
2.19.0.271.gfe8321ec05

