Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 55FC420248
	for <e@80x24.org>; Tue, 19 Mar 2019 17:13:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbfCSRNz (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Mar 2019 13:13:55 -0400
Received: from mout.web.de ([217.72.192.78]:54147 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726612AbfCSRNy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Mar 2019 13:13:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1553015629;
        bh=gwqBxoTsMLy7PFQwN0eRMwYAOcWCvN7nXzs401HBV+A=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=M38Ffo6bZ3s+0aiVeTmvcMDWvLgqIl+IvZCu1ywu4D+4aDP5g6tkiq56/eDH4Igem
         3KNRgRI8ZxXiN/gHd9wKrNnNzNFmEZnwf9d5pHSl17zagop5K/wkVYcCp8+m/chFcK
         CyxMOHra6J1S9dvmH6yjTHZ/e653cvPEYtfm0vrc=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost.localdomain ([195.198.252.176]) by smtp.web.de
 (mrweb101 [213.165.67.124]) with ESMTPSA (Nemesis) id
 0LlWKh-1gYbus10AZ-00bLUg; Tue, 19 Mar 2019 18:13:49 +0100
From:   tboegi@web.de
To:     git@vger.kernel.org, jeffhost@microsoft.com, mwelinder@gmail.com
Cc:     =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH v2 1/1] trace2: NULL is not allowed for va_list
Date:   Tue, 19 Mar 2019 17:13:46 +0000
Message-Id: <20190319171347.7677-1-tboegi@web.de>
X-Mailer: git-send-email 2.19.1.593.gc670b1f876
In-Reply-To: <20190316104616.27085-1-tboegi@web.de>
References: <20190316104616.27085-1-tboegi@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YT+YGZtjTdVRQGXl6GSpi0j9gf5Rr3enCI7fjSLS9r3+HaLD+wC
 qwXqVQEcY8N7ReUV+dDnQEjoksBBbZy9DdfZElSgMFaQIfczGSpe9QVGNSAmz0RVuEDicFc
 3SspsiwtlzJLnV5XpET8e1/lvjWorJ067igYjxVYyNm+AdWFiNPIpoUVAkVxP/49hyJsm2k
 Hg8UP8O4/vYnSUcBjQSVw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:oXCMxvCbXk4=:TxwE9Ts5FToFraVMooyQB2
 Cn/Q1qRHYyhYLCUstZ3oJtEmYb1lpxx22H0HnR3NLqrmk3g3YqWBtacBzXkDtXeXwHN4+ntuG
 KFvQACUOBu28783Dh/ac+KyjzgIX80Y9WhiQkmzIu9/XHPsdD8Oj52oj7tpQ1N3Bl1j2CnX6n
 ACpaQ0Bm1vB+2dWgmLB/zsHAwxQpmaEZ/CwC5t1/qFr12vrxQHQPYTZNtJrGvNWRFG6HZabI4
 v9Ma8h0E8RvZWel4vFKUL1dTs+g3+cmY6sD2Z8P/bBijUKbAAmvvfBDnHxcOfEGMzX/eI4JYt
 N+SbMDkboe23cbOANVOYvuNnjRayXUZMPyzhd4qgd4ryGZazEb7SD/pQsUUhaJ2NPNLOstFzu
 Qn1r6DpeDF2VH0xFWNJXyqfvAckpINWOySAWyDHyOUbe3QwRgskLXNkXmZMjHnY7VmdwUhxq2
 +lNEGxIEMTehGEczCdpl2gLh6Hf1+rU3ioWPcg+XQFmFY5BRPywHEbl0+cpyv2AiY6jbhKNQS
 /uAQBTiBo1o7hsjyDRTuFt1QYWwlijPDDPePfvM656dD8hJc2gyynX6nPYPniA6OhZMNqhWSG
 Sn8MsDrl+R5GO+L2Crtd8KZbmb4ZxFY6d4PelhGGGm1kAcgrJb6Hx6CaZhWTQr3NP7M5lHqLQ
 MIXJ0B//MjxSCoeakkvpfx6u4+6LrFVeNhRKtbecqUz53fBNgHt/HTniS0Cnybfhk3kPVrUhX
 6tAUsce7bCAYCCfz4aMTMdIAQt7WTlRn76vjUzbkHUq7PtwcBNIcf8v1NyEzfMbOmBSQIVztX
 xbVjuG8KS6SwTuOMAyoZ/z5DuIA9Jerh/S33Ay5+4b32/vFg9X6hu16dXtE9wEVcsskwba2el
 qRFBPaX+puzghaIaR6zyrKIzCdDY3/5o5d8Gq0GAn1tOdia1UuitigoY8k4usa
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Torsten B=C3=B6gershausen <tboegi@web.de>

Some compilers don't allow NULL to be passed for a va_list,
and e.g. "gcc (Raspbian 6.3.0-18+rpi1+deb9u1) 6.3.0 20170516"
errors out like this:
 trace2/tr2_tgt_event.c:193:18:
   error: invalid operands to binary &&
   (have =E2=80=98int=E2=80=99 and =E2=80=98va_list {aka __va_list}=E2=80=
=99)
    if (fmt && *fmt && ap) {
                       ^^
I couldn't find any hints that va_list and pointers can be mixed,
and no hints that they can't either. Morten Welinder comments:

"C99, Section 7.15, simply says that va_list "is an object type suitable f=
or
holding information needed by the macros va_start, va_end, and
va_copy". So clearly not guaranteed to be mixable with pointers...

The portable solution is to use "va_list" everywhere in the callchain.
As a consequence, both trace2_region_enter_fl() and trace2_region_leave_fl=
()
now take a variable argument list.

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

