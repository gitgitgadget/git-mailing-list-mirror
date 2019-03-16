Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 95E3E20248
	for <e@80x24.org>; Sat, 16 Mar 2019 10:47:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726753AbfCPKrV (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Mar 2019 06:47:21 -0400
Received: from mout.web.de ([212.227.15.4]:58703 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726571AbfCPKrV (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Mar 2019 06:47:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1552733237;
        bh=5eBYpKCXIdu41Slv+n/vPqVgyBM3vM289573AK951vs=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=oz5wFOxwOPlq+FtbJncE5QrSsO7Fh9d7CMYDasNQRHEME3ZUoV9nm/kuKiMly8Bcr
         FbP9sPc5WkTdKZSTAe2fsK+MqMqshk0/oovaDBdUmJLbnXOW27VQqqGzES7/e+HBM/
         4fQlzrjq0fcKPiMUaNrlQz2q89lmliwJnckvEb28=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost.localdomain ([195.198.252.176]) by smtp.web.de
 (mrweb002 [213.165.67.108]) with ESMTPSA (Nemesis) id
 0LsyBm-1guV2d12vS-012X9L; Sat, 16 Mar 2019 11:47:17 +0100
From:   tboegi@web.de
To:     git@vger.kernel.org, jeffhost@microsoft.com
Cc:     =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH v1 1/1] trace2: NULL is not allowed for va_list
Date:   Sat, 16 Mar 2019 11:47:15 +0100
Message-Id: <20190316104715.27138-1-tboegi@web.de>
X-Mailer: git-send-email 2.21.0.135.g6e0cc67761
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BIjz/vLrxfoH4CJvDlFfCPr73Y3LTLqb8PiNa5hrQtTa2vttYYQ
 F/kVdiYUz1E+IyyCzUG7vcQFji5Km+EsW+aXeYC4UKWjT5pnu3xBbmzqgGwg4fWIPaiDfev
 Cv5CthKS+FXKVr0o/VrpaiP98mZq4Z9WNcFsx5winONE5bUuvna46Kltm0TJqQ0UdchIZxx
 EPCi+F/cW1EvtvHcY0+WA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Mw7yieCDbrg=:B3GO2FgfaEpaTSILZ7bpZI
 ZK66NesjfKaMOkJ0R7ZfGj52FbpFDJCDGzwwtEBe6yvg8CxGvEmzFwqDzQZi40g3NBDVdyksh
 +Yn+H0kAljORxVJEr8YiEMZ/qOOTygiNYk3gazkkjKxFAx6Fjj2FMavpUTAnzSaz2hXcHIMus
 xZerNYx8Xyv9OcCEQQiVopdHtFO2cI42wJYiVbsOpaLDmLyEklOEuxBTPt+0v9D5JTf0H/daW
 EviPYAT9prYZAC58Cy79/+pSxAQ7Dp0Sk2gj8WAK432zp0Ryy+MftQgK/S6+vMc2jXaMv0bdI
 kxfEa30+i0GfaNBkmXbHbXj+2f1Eo6WMhihgQJyB/669gVilWJq3x2W2fHbGAJpjlo/1hmw10
 M5m9HxbYJaxi8cTx6FPR/B1G2FpGVx/qiyJ0ZVWItjUGYf1gUYI4lv1PW32QbnmRF/oZ5j3YE
 SjfRZQ0AIl7aK1/zATXkqcTvsu4NrFrO+myGXodlYtcM8I9y0zDbCj4PS/48vMgPGWeXM1VaO
 BgZ/8r38oODgn5ffxPPOUsSFoM0tvegHHsB7VcYN8e0yv1aEXB7tR2xcfowQrjaEvUKsGLLAp
 VPRsgs7JqhJ1kKVWFr7fo8m6g/R/+xsiTebVHGh8RbcBiRmPr6BLjehf96gUP8M4i5RhEZmZG
 1619J7b3RYQGXfhaj85xk9f9lb7kuKWwXHuv+g/WReQRKON/+qgJPxXtvpUfq2nwleuhYe8jt
 ofUn4diRFRZaqDOYV15he+nePV35NbMD0q2NID1wqIKNHW5iGLwFdTSqe6zAkgVlPFl78KH03
 lOcUYaioe9ij6GC2sg1nj+InlO9CnYbC7htNNzNzYnXifT7yC9xjJR4hxnAaMrdFJ/gS5uU8d
 NmN+1RCPGzaLhDvxMm4VUe03C9ay+nTDBP9Tzhh2Uuqnx+OZiB+G8Wf+NVLuPD
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Torsten B=C3=B6gershausen <tboegi@web.de>

Some compilers don't allow NULL to be passed for a va_list.
Use va_list instead.

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
=2D--
 trace2.c                | 15 +++++++++++----
 trace2.h                |  4 ++--
 trace2/tr2_tgt_event.c  |  2 +-
 trace2/tr2_tgt_normal.c |  2 +-
 trace2/tr2_tgt_perf.c   |  2 +-
 5 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/trace2.c b/trace2.c
index ccccd4ef09..8bbad56887 100644
=2D-- a/trace2.c
+++ b/trace2.c
@@ -548,10 +548,14 @@ void trace2_region_enter_printf_va_fl(const char *fi=
le, int line,
 }

 void trace2_region_enter_fl(const char *file, int line, const char *categ=
ory,
-			    const char *label, const struct repository *repo)
+			    const char *label, const struct repository *repo, ...)
 {
+	va_list ap;
+	va_start(ap, repo);
 	trace2_region_enter_printf_va_fl(file, line, category, label, repo,
-					 NULL, NULL);
+					 NULL, ap);
+	va_end(ap);
+
 }

 void trace2_region_enter_printf_fl(const char *file, int line,
@@ -621,10 +625,13 @@ void trace2_region_leave_printf_va_fl(const char *fi=
le, int line,
 }

 void trace2_region_leave_fl(const char *file, int line, const char *categ=
ory,
-			    const char *label, const struct repository *repo)
+			    const char *label, const struct repository *repo, ...)
 {
+	va_list ap;
+	va_start(ap, repo);
 	trace2_region_leave_printf_va_fl(file, line, category, label, repo,
-					 NULL, NULL);
+					 NULL, ap);
+	va_end(ap);
 }

 void trace2_region_leave_printf_fl(const char *file, int line,
diff --git a/trace2.h b/trace2.h
index ae5020d0e6..b330a54a89 100644
=2D-- a/trace2.h
+++ b/trace2.h
@@ -238,7 +238,7 @@ void trace2_def_repo_fl(const char *file, int line, st=
ruct repository *repo);
  * on this thread.
  */
 void trace2_region_enter_fl(const char *file, int line, const char *categ=
ory,
-			    const char *label, const struct repository *repo);
+			    const char *label, const struct repository *repo, ...);

 #define trace2_region_enter(category, label, repo) \
 	trace2_region_enter_fl(__FILE__, __LINE__, (category), (label), (repo))
@@ -278,7 +278,7 @@ void trace2_region_enter_printf(const char *category, =
const char *label,
  * in this nesting level.
  */
 void trace2_region_leave_fl(const char *file, int line, const char *categ=
ory,
-			    const char *label, const struct repository *repo);
+			    const char *label, const struct repository *repo, ...);

 #define trace2_region_leave(category, label, repo) \
 	trace2_region_leave_fl(__FILE__, __LINE__, (category), (label), (repo))
diff --git a/trace2/tr2_tgt_event.c b/trace2/tr2_tgt_event.c
index 107cb5317d..1cf4f62441 100644
=2D-- a/trace2/tr2_tgt_event.c
+++ b/trace2/tr2_tgt_event.c
@@ -190,7 +190,7 @@ static void fn_atexit(uint64_t us_elapsed_absolute, in=
t code)
 static void maybe_add_string_va(struct json_writer *jw, const char *field=
_name,
 				const char *fmt, va_list ap)
 {
-	if (fmt && *fmt && ap) {
+	if (fmt && *fmt) {
 		va_list copy_ap;
 		struct strbuf buf =3D STRBUF_INIT;

diff --git a/trace2/tr2_tgt_normal.c b/trace2/tr2_tgt_normal.c
index 547183d5b6..1a07d70abd 100644
=2D-- a/trace2/tr2_tgt_normal.c
+++ b/trace2/tr2_tgt_normal.c
@@ -126,7 +126,7 @@ static void fn_atexit(uint64_t us_elapsed_absolute, in=
t code)
 static void maybe_append_string_va(struct strbuf *buf, const char *fmt,
 				   va_list ap)
 {
-	if (fmt && *fmt && ap) {
+	if (fmt && *fmt) {
 		va_list copy_ap;

 		va_copy(copy_ap, ap);
diff --git a/trace2/tr2_tgt_perf.c b/trace2/tr2_tgt_perf.c
index f0746fcf86..2a866d701b 100644
=2D-- a/trace2/tr2_tgt_perf.c
+++ b/trace2/tr2_tgt_perf.c
@@ -211,7 +211,7 @@ static void fn_atexit(uint64_t us_elapsed_absolute, in=
t code)
 static void maybe_append_string_va(struct strbuf *buf, const char *fmt,
 				   va_list ap)
 {
-	if (fmt && *fmt && ap) {
+	if (fmt && *fmt) {
 		va_list copy_ap;

 		va_copy(copy_ap, ap);
=2D-
2.21.0.135.g6e0cc67761

