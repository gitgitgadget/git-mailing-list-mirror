Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3451D1F454
	for <e@80x24.org>; Mon,  4 Nov 2019 19:28:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728974AbfKDT2K (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Nov 2019 14:28:10 -0500
Received: from mout.web.de ([212.227.15.4]:36677 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728174AbfKDT2K (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Nov 2019 14:28:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1572895677;
        bh=woZRZ4I7DzExsKGmUG6wQceZhGWvDmACNDz69RySkZ4=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=dZYR2hdPXIJMVgEIReoWfMnIy6/YUTt4I0CZoz3+ROG6qH9pME4AZYwPN3ynlZtEY
         1Cr3RtW33ENdBuVjrKcCYCqZNzVKt+bYcmHKOnxStJirMyQnLQKUJDgai+RgRlOF5t
         igQfRFWjnAleqNXzfVCTmkNU6FSH6APs+w6ohl/4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([91.47.146.29]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MgqrQ-1iEQM13Lw8-00M6Cy; Mon, 04
 Nov 2019 20:27:57 +0100
X-Mozilla-News-Host: news://nntp.public-inbox.org:119
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] trace2: add dots directly to strbuf in perf_fmt_prepare()
Message-ID: <c4237b45-6faf-c1fc-eb13-b6c71b7fb6ef@web.de>
Date:   Mon, 4 Nov 2019 20:27:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:NFxa1JuZkcL6S5iWZy6POOwaEUkzF258m2iiocJThLXfXL3k0JF
 1hjSN/tzbWTW2fYXFlVW3fjAhpkX9IJiLllt0R45FKpEgR7WKKkdRRKVNly2UBrVcpYs6rb
 0M1ktTy8wWIOwV/BcZT9rCAMEbN1ykStmsANqgakozYyNI5LCFaI9Y2U/+EVEPLyo6M4Vri
 vFtZHEQzzLJApmbsuDJQw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:a1UyK/cP69I=:cmAlT5AaQHLBmbqL/wz1wX
 jGm/FuMZ4VylYc0G5v1rNRh5XFDHx0/ykE908ZNSF6xF6ZnzH57ZY9DhrO0kr/9LhgOUZGESG
 wI6PCPxCrVSH+aiMYoFmVtYpCXXUIHgyMd84wZL2Zd1vF0Ii+IHK4Vy+eQX30ZK2bqeUSWSo+
 Jmgu6laKfYgvtlRUGwK3PKjRGL1oc7YDEtIPP0p6iXaO3sGBw76OHOgdknhhB7W++Fl/S1XJn
 G6oKv4kLvlXCQSsYYpmc+eOuNC0kYwSPtnTYoSLFohfaGt8k0QIOdvNJL3AeI2I4YDTqQ1vS6
 r8S8nxzscPj/2YKuxqb7AAAHQSE5V6E0cq7VZIH0xs+nyqUJs2Nu2sy/cHIZx/CoxhZEIoAdl
 APCV4CRnfp6IDMq0hzXkOs1UE8f5HsJikQ4pBTjf2e2kRzsxm1BYs4aokC7DdjemTimuYkBwu
 JYFR9ORfVFUaDxmxgSuTAiFsBCjrf7a8XMVQJvUXPjrSV5QnyIAmro4xpiPN8RsL9fCcAaRUl
 x1E5NyL0QGd7XeKHnWCen0H4hOXF19sVilAHibF2zRJbWGO+7xCTg5mt3wEFwL+1NGGmCidTo
 CBacH8JDSNQfnXLsWzHPDeX1sn1w2JRnhMjLFRPx+NBrBK6EsDQ+tMMTOXRYJQdahneIcFi8V
 iBaSk7Pwwwofe+KZSTOTW/KOTE8KTNXYTdK+yIiXygjdpV5kWMJ904o+XAheXB9su/J8t73g0
 DGv0VZHHqVVC6sb7BlCyJXc+5MXU9SvZtYXHSvZjfrp3UFlmPyPpVDK+WQ9yuTr6A6ZkWC3Km
 vmWCDB0FPCz3/hVWk1kG3lwImgWiMJeefrFsOOy8oyagONJZ9Imdm/Ql7gHx+ui9j+8B/5xfT
 yATzi6Mvll1CG28zRI5ycg5GmDiwZTErbP831HK/EP7botxcU5k1yRD3h8txEJcR6ntrmrhhr
 ZT3hwQVbaTJf5N5PYYJWbHCOxSk9OXghTsA86GP5UQe2XtA5z+uj822xxiRCAiNoovAggjSZE
 IsL6k8cM4K6eyNDrUlCAl6AfD/rOmmAnrR/bHLQuGAeTaU7K7gQ0S7fE2OKM5JhqiimtcJ3JY
 6i8ZId2sFs7eh3JNgAOOiunQPPmYiiy6WtLIxObFF7oiLjmck1IBeUxnBHDFIwIsDzAwWxZ2N
 xpB9bm3Mw7HFQGNOA+n3ybFW2h3R0jX59KzEvPl9RMCJaytCktuEqyaqbB6Bn/rDW38F1Zcsq
 1jrACnmWPSoCU4n9t912JI85CT0yamKJCEDi2Ug==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The initialization function of the Trace2 performance format target sets
aside a stash of dots for indenting output.  Get rid of it and use
strbuf_addchars() to provide dots on demand instead.  This shortens the
code, gets rid of a small heap allocation and is a bit more efficient.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 trace2/tr2_tgt_perf.c | 17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

diff --git a/trace2/tr2_tgt_perf.c b/trace2/tr2_tgt_perf.c
index ffac8029ad..a8018f18cc 100644
=2D-- a/trace2/tr2_tgt_perf.c
+++ b/trace2/tr2_tgt_perf.c
@@ -26,12 +26,9 @@ static int tr2env_perf_be_brief;
 #define TR2FMT_PERF_REPO_WIDTH (3)
 #define TR2FMT_PERF_CATEGORY_WIDTH (12)

-#define TR2_DOTS_BUFFER_SIZE (100)
 #define TR2_INDENT (2)
 #define TR2_INDENT_LENGTH(ctx) (((ctx)->nr_open_regions - 1) * TR2_INDENT=
)

-static struct strbuf dots =3D STRBUF_INIT;
-
 static int fn_init(void)
 {
 	int want =3D tr2_dst_trace_want(&tr2dst_perf);
@@ -41,8 +38,6 @@ static int fn_init(void)
 	if (!want)
 		return want;

-	strbuf_addchars(&dots, '.', TR2_DOTS_BUFFER_SIZE);
-
 	brief =3D tr2_sysenv_get(TR2_SYSENV_PERF_BRIEF);
 	if (brief && *brief &&
 	    ((want_brief =3D git_parse_maybe_bool(brief)) !=3D -1))
@@ -54,8 +49,6 @@ static int fn_init(void)
 static void fn_term(void)
 {
 	tr2_dst_trace_disable(&tr2dst_perf);
-
-	strbuf_release(&dots);
 }

 /*
@@ -138,14 +131,8 @@ static void perf_fmt_prepare(const char *event_name,
 	strbuf_addf(buf, "%-*.*s | ", TR2FMT_PERF_CATEGORY_WIDTH,
 		    TR2FMT_PERF_CATEGORY_WIDTH, (category ? category : ""));

-	if (ctx->nr_open_regions > 0) {
-		int len_indent =3D TR2_INDENT_LENGTH(ctx);
-		while (len_indent > dots.len) {
-			strbuf_addbuf(buf, &dots);
-			len_indent -=3D dots.len;
-		}
-		strbuf_addf(buf, "%.*s", len_indent, dots.buf);
-	}
+	if (ctx->nr_open_regions > 0)
+		strbuf_addchars(buf, '.', TR2_INDENT_LENGTH(ctx));
 }

 static void perf_io_write_fl(const char *file, int line, const char *even=
t_name,
=2D-
2.24.0
