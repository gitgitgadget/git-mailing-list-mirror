Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 347CF1F404
	for <e@80x24.org>; Fri, 23 Feb 2018 21:00:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751881AbeBWVAn (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Feb 2018 16:00:43 -0500
Received: from mout.web.de ([212.227.15.4]:58451 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751580AbeBWVAm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Feb 2018 16:00:42 -0500
Received: from [192.168.178.36] ([79.237.251.165]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M0w07-1ebnkU1OEJ-00v9MB; Fri, 23
 Feb 2018 22:00:33 +0100
Subject: Re: [PATCH] strbuf_read_file(): preserve errno across close() call
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
References: <6b58885c-b0f6-1687-3f2d-4594aacff9ac@web.de>
 <20180223064952.GB19791@sigill.intra.peff.net>
 <20180223070053.GC19791@sigill.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <f134c6bf-c147-4201-1217-b59bfb9f2288@web.de>
Date:   Fri, 23 Feb 2018 22:00:24 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180223070053.GC19791@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:r/zy5a14r54/GIg1OxyAViZtXPEnM5Gr3PYbTrtv8vL+HjSPeCp
 1ws15SzMgDl5sf4xWk8fbX0sSVZjLlPBE01wP2z8+9NWlMLNrvimCyB66v33l3CUgK/86po
 +BF/crdGMUhsdTVoZS356IPH5REO227+LJPuesiUcirNkCxVFZxJnQWvjGtE5bxwxZLCou7
 Vw7q9aQJVriUJr6MuqFQw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:32TywmSNJ14=:rGQK2DpJi8+gsUrXNPxE0c
 upIMiraZ5tcVPa4cEnpN7/AQmacTf2RlJvHuzE5qQ+WU0rZ+VrteFVptb2mycsqPqaNlUMtVu
 v49t7rbezOzOQuXxyNI6ii2EEExYfW6JAyz42I9m+igDidCxg1Kqs6NTlzeLoYCroPOhITyJk
 47yN8ElK8VwIrwMNG7ofi8MxPkoNHfQ+q/kEG/npRsGOzN+TNs3cG+AdMegItQSWdhsTR6kdR
 xvkSa6et33JemrBx0TnrJ3grlnsECm++ezUcoaO56hqDyQqAo631vp+H7ghFNI6HmkFwLW3Fo
 0f+f2dvt2OlDhATDLCfBWAPGHHOHhOvlytOPeIQCNLZecQJHHeWxukqmtjhXKK1yWVEgVHGBd
 AT/utVTmNijfvf4jNn1cJ3+wZ2DaVZEGLGJk7tTgDa8eWKYGH1RXjSSIYIMbCtWkFeVnl1Dho
 YFEb334rQGYwiGD9ZJiJAgaq4bHmaLtOXVN49sFmsgUSSE2MY/quX2NpvI1myo2IL0A8CqFQV
 xRMfdmI4FSpMgmyLO9/zkzUnTFEl1BzJUWm5KZPBLjQ+A0uLN+m5MxpPgTqMXqTupjlDc/KRf
 pvwxAyqMQNhHuQpEashU7EQKk8G6umFRSMmKuhdSW2l3jTKdLRW4sF/uehvfJ1cBvtgEYpAhX
 SyU3xV41ODZSUNP0PZwXviCScIrTJ8GmgGlX3r7RnLX/fto5cLmFdGDTHBF9VS2ZI4RMK4g+M
 7F0fBhZZHpL+QC5SQThwGc5SmtjRpCoilnApxxFY+kW4gjhZSAens57jwJNASIU5HsmAptR0p
 R134p9VTtPh4W7JLA7WMK4oouVCYl23DzZL9AW+cK1V82GlLlE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 23.02.2018 um 08:00 schrieb Jeff King:
> On Fri, Feb 23, 2018 at 01:49:52AM -0500, Jeff King wrote:
> Subject: [PATCH] strbuf_read_file(): preserve errno across close() call
> 
> If we encounter a read error, the user may want to report it
> by looking at errno. However, our close() call may clobber
> errno, leading to confusing results. Let's save and restore
> it in the error case.

Good idea.

> Signed-off-by: Jeff King <peff@peff.net>
> ---
>   strbuf.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/strbuf.c b/strbuf.c
> index 1df674e919..5f138ed3c8 100644
> --- a/strbuf.c
> +++ b/strbuf.c
> @@ -612,14 +612,18 @@ ssize_t strbuf_read_file(struct strbuf *sb, const char *path, size_t hint)
>   {
>   	int fd;
>   	ssize_t len;
> +	int saved_errno;
>   
>   	fd = open(path, O_RDONLY);
>   	if (fd < 0)
>   		return -1;
>   	len = strbuf_read(sb, fd, hint);
> +	saved_errno = errno;
>   	close(fd);
> -	if (len < 0)
> +	if (len < 0) {
> +		errno = saved_errno;
>   		return -1;
> +	}
>   
>   	return len;
>   }

How about adding a stealthy close_no_errno(), or do something like the
following to get shorter and more readable code?  (We could also keep
a single close() call, but would then set errno even on success.)

--- 
 strbuf.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/strbuf.c b/strbuf.c
index 1df674e919..c0066b1db9 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -2,6 +2,8 @@
 #include "refs.h"
 #include "utf8.h"
 
+#define IGNORE_ERROR(expr) do { int e_ = errno; expr; errno = e_; } while (0)
+
 int starts_with(const char *str, const char *prefix)
 {
 	for (; ; str++, prefix++)
@@ -391,7 +393,7 @@ ssize_t strbuf_read(struct strbuf *sb, int fd, size_t hint)
 
 		if (got < 0) {
 			if (oldalloc == 0)
-				strbuf_release(sb);
+				IGNORE_ERROR(strbuf_release(sb));
 			else
 				strbuf_setlen(sb, oldlen);
 			return -1;
@@ -617,9 +619,11 @@ ssize_t strbuf_read_file(struct strbuf *sb, const char *path, size_t hint)
 	if (fd < 0)
 		return -1;
 	len = strbuf_read(sb, fd, hint);
-	close(fd);
-	if (len < 0)
+	if (len < 0) {
+		IGNORE_ERROR(close(fd));
 		return -1;
+	}
+	close(fd);
 
 	return len;
 }
