Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B2334202D7
	for <e@80x24.org>; Wed,  8 Mar 2017 18:13:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754038AbdCHSM5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Mar 2017 13:12:57 -0500
Received: from mout.web.de ([212.227.17.11]:52576 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751460AbdCHSMy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2017 13:12:54 -0500
Received: from [192.168.178.36] ([79.213.126.222]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M8hsl-1c0BzG1Vp5-00wByi; Wed, 08
 Mar 2017 19:12:33 +0100
Subject: Re: [PATCH 2/2] Fix callsites of real_pathdup() that wanted it to die
 on error
To:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
References: <cover.1488987786.git.johannes.schindelin@gmx.de>
 <0c0abc667d9b8dff299aa61aeb29a7e9e7316b66.1488987786.git.johannes.schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <81f1e30b-e0e1-d587-4a4b-4848beffd38c@web.de>
Date:   Wed, 8 Mar 2017 19:12:22 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <0c0abc667d9b8dff299aa61aeb29a7e9e7316b66.1488987786.git.johannes.schindelin@gmx.de>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:DVrvUa2bPklDoUjZk+ONXJbmYLFIPG/6YFH0dbezQ9SA5tddTu7
 T7pFMBHRsWL4vF5u/SXbFr0TSX0sSfUiWvnMPPkUOv7NqwPLBVieTcvGMPtBwaZSh8OfR41
 coCkvHKYQd2uZebBuk+CyPG+FQvF/J/JHNC7Aax4QX/d6ZYF9epPaWDA8upaYpPa/i/pPOm
 i/K+tDFqymMFbhu78+ANg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:RLrR5QQzCi4=:z9kqp/x1b6dwiNAZ84N6ln
 XQKzXhKrGsZ3keDGKNw7p/KECc5v49/h+zb6lXyd9Ora7Eur4x9t5+pdg1sxqPUxoZ5IgFU4l
 xLhlwzIxmLejbVleu42MIjDzQg57TKxBBpwPH3t0UKPZgfBISZorSXXVZYMg+16z6HKe9fnOU
 /tfeyD3NVvOhk6B+RGsxLifxx25RQHpbnnG12aJG0FE1p05mDdrEO4u8BkfCxkt53Us3/zaET
 O6zU0LDQFi9+K0e8UAUK5lT9stYwcBxhpm1h+66iY4oNQ2bX9/01L7HWThVXeC48/WhdRJUMl
 zZrXfOzerlnWaMkvWFhc4FGNQ7E+3DMQyGVq6POrV4bl+J1WpUCB0plh8JeJYqVKqu80A+ON3
 LiB+gtYAobbSwe17tPl2QuL1JqVSh46Vx8XowxmvIOsvC/rucs+RMVx/ZsQEw8tqnLhbqXWhS
 ZsriEJMlq15T+PsB5CfPGG2+O88g/EilV6Gm36xNezsVEOlPya0Id520c7Rn6IEijHhrH/arG
 7LRQp9I8pUuPsZTVhQW12RvgCUVj0M7XX91QvgG7OoQ9QS7AF1fxm2BpgvGDRiu7q97F54fsZ
 CZUsNp6Ljb5WK4ONWo3wli9Rk7yRDEDvj7HOS7lQNVeyjnngcGmxS3fGdue3W6h6Xb9mXEoS6
 N4awZrtsAnSLLXKV7PVVonaNAjbfpsOr9Ov+cOAHoEZ+vJS1ZwT3RZGVmoXU3chi2UBqzvQQa
 nTWyGkpMnNO4ZuSF+y2KtynWCb0oNSTko5RymQCpsoqD59Y8mJLwDE+6SJ4GTbh9B2KMMwXDf
 WbHaLpL
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 08.03.2017 um 16:43 schrieb Johannes Schindelin:
> In 4ac9006f832 (real_path: have callers use real_pathdup and
> strbuf_realpath, 2016-12-12), we changed the xstrdup(real_path())
> pattern to use real_pathdup() directly.
> 
> The only problem with this change is that real_path() calls
> strbuf_realpath() with die_on_error = 1 while real_pathdup() calls it
> with die_on_error = 0. Meaning that in cases where real_path() causes
> Git to die() with an error message, real_pathdup() is silent and returns
> NULL instead.
> 
> The callers, however, are ill-prepared for that change, as they expect
> the return value to be non-NULL.
> 
> This patch fixes that by extending real_pathdup()'s signature to accept
> the die_on_error flag and simply pass it through to strbuf_realpath(),
> and then adjust all callers after a careful audit whether they would
> handle NULLs well.
> 
> Note: this fix not only prevents NULL pointer accesses, but it also
> reintroduces the error messages that were lost with the change to
> real_pathdup().
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  abspath.c            |  4 ++--
>  builtin/init-db.c    |  6 +++---
>  cache.h              |  2 +-
>  dir.c                |  4 ++--
>  environment.c        |  2 +-
>  setup.c              |  4 ++--
>  submodule.c          | 10 +++++-----
>  t/t1501-work-tree.sh |  2 +-
>  worktree.c           |  2 +-
>  9 files changed, 18 insertions(+), 18 deletions(-)
> 
> diff --git a/abspath.c b/abspath.c
> index 2f0c26e0e2c..b02e068aa34 100644
> --- a/abspath.c
> +++ b/abspath.c
> @@ -214,12 +214,12 @@ const char *real_path_if_valid(const char *path)
>  	return strbuf_realpath(&realpath, path, 0);
>  }
>  
> -char *real_pathdup(const char *path)
> +char *real_pathdup(const char *path, int die_on_error)

Adding a gentle variant (with the current implementation) and making
real_pathdup() die on error would be nicer, as it doesn't require
callers to pass magic flag values.  Most cases use the dying variant,
so such a patch would have to touch less places:
---
 abspath.c            | 7 +++++++
 cache.h              | 1 +
 setup.c              | 2 +-
 t/t1501-work-tree.sh | 2 +-
 4 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/abspath.c b/abspath.c
index 2f0c26e0e2..f3fcff8b1b 100644
--- a/abspath.c
+++ b/abspath.c
@@ -217,6 +217,13 @@ const char *real_path_if_valid(const char *path)
 char *real_pathdup(const char *path)
 {
 	struct strbuf realpath = STRBUF_INIT;
+	strbuf_realpath(&realpath, path, 1);
+	return strbuf_detach(&realpath, NULL);
+}
+
+char *real_pathdup_gently(const char *path)
+{
+	struct strbuf realpath = STRBUF_INIT;
 	char *retval = NULL;
 
 	if (strbuf_realpath(&realpath, path, 0))
diff --git a/cache.h b/cache.h
index 80b6372cf7..9dfbce702e 100644
--- a/cache.h
+++ b/cache.h
@@ -1154,6 +1154,7 @@ char *strbuf_realpath(struct strbuf *resolved, const char *path,
 const char *real_path(const char *path);
 const char *real_path_if_valid(const char *path);
 char *real_pathdup(const char *path);
+char *real_pathdup_gently(const char *path);
 const char *absolute_path(const char *path);
 char *absolute_pathdup(const char *path);
 const char *remove_leading_path(const char *in, const char *prefix);
diff --git a/setup.c b/setup.c
index f14cbcd338..398ea8a913 100644
--- a/setup.c
+++ b/setup.c
@@ -806,7 +806,7 @@ static int canonicalize_ceiling_entry(struct string_list_item *item,
 		/* Keep entry but do not canonicalize it */
 		return 1;
 	} else {
-		char *real_path = real_pathdup(ceil);
+		char *real_path = real_pathdup_gently(ceil);
 		if (!real_path) {
 			return 0;
 		}
diff --git a/t/t1501-work-tree.sh b/t/t1501-work-tree.sh
index 046d9b7909..b06210ec5e 100755
--- a/t/t1501-work-tree.sh
+++ b/t/t1501-work-tree.sh
@@ -423,7 +423,7 @@ test_expect_success '$GIT_WORK_TREE overrides $GIT_DIR/common' '
 	)
 '
 
-test_expect_failure 'error out gracefully on invalid $GIT_WORK_TREE' '
+test_expect_success 'error out gracefully on invalid $GIT_WORK_TREE' '
 	(
 		GIT_WORK_TREE=/.invalid/work/tree &&
 		export GIT_WORK_TREE &&
-- 
2.12.0

