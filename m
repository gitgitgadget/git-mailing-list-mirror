Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B002B1F991
	for <e@80x24.org>; Wed,  9 Aug 2017 13:14:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752414AbdHINO1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Aug 2017 09:14:27 -0400
Received: from mail-wm0-f41.google.com ([74.125.82.41]:33503 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752403AbdHINO0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Aug 2017 09:14:26 -0400
Received: by mail-wm0-f41.google.com with SMTP id k20so13860772wmg.0
        for <git@vger.kernel.org>; Wed, 09 Aug 2017 06:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=zMykWFp7IP7TSKQF4nphodc8T1USkbyMA6gsq1cRBW8=;
        b=rC+ItwPb0Q5Z+oi3CeaKIIWwYolsVyRspCgLi6liZ62ghigx2HOvZVnLnuFuzduIzG
         I36bqUn/5Ngmon0yva7sVcY+RYCCSuyCGdODWqEbBxa6Kqr7blBvojCxPmAFWzO24ZeC
         XI76blQrOAYaAVlYkJGl9wmY5dmhhaJ8VvDLqEC16Xwmft8ng5vWYT+kWnI93g0OhrnE
         pr8+8Xh0BckHBirhyHKoXijKKkuuyQ0qGXXDcFYt5UJxay6ZW5kF3J3R5cD+1mxQSIt1
         KIQA3+InmoH+73RAvloXv189CADl75t0RPwVAuWyhBYn0v+pIR5QNE9weCvNmrUDi4FH
         aEPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=zMykWFp7IP7TSKQF4nphodc8T1USkbyMA6gsq1cRBW8=;
        b=pMKT5EuhM9okyl7irL9KtxUdESAGnXwyMrBlZzWIM8NjFYf68Oci6DjaJFzWIOiEJN
         lPD7Fz4SfBCTl8QNs071zsgDhPzFduLq9q93jy5fL5ch3WIbB/RRNU50JU6jVCbOWt3a
         P8Kr+Ky28Upl4Kgzr1JDksdcFZdpN5ilRAlI8yyT3hrov2H3QaWhrEmXmSKVO34I/f2u
         UjjcJbgMzIsAPr/slv1biWA88YY+h0Ad/rsobZcgZwF+d4Sm3MezE65EefQml8CRPweO
         Zu0wImJF3lkCF+i4l/ANSm+vIAcJKSkelisjiyIA8yoocZ2QLiKjhDVMcp5vGI1RMH1W
         AU/g==
X-Gm-Message-State: AHYfb5h4/V4QFZWva8puGjEO9rAlcFWzBm/byVd0pPqB4uijnPI5Fl1s
        t+q3zrAqEKuEjg==
X-Received: by 10.80.165.114 with SMTP id z47mr8149359edb.60.1502284465499;
        Wed, 09 Aug 2017 06:14:25 -0700 (PDT)
Received: from snth (157-157-140-194.dsl.dynamic.simnet.is. [157.157.140.194])
        by smtp.gmail.com with ESMTPSA id n12sm2047401edd.4.2017.08.09.06.14.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Aug 2017 06:14:24 -0700 (PDT)
Received: from avar by snth with local (Exim 4.84_2)
        (envelope-from <avarab@gmail.com>)
        id 1dfQoY-00044M-GK; Wed, 09 Aug 2017 15:14:22 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/4] http: drop support for curl < 7.19.4
References: <20170809120024.7phdjzjv54uv5dpz@sigill.intra.peff.net> <20170809120201.2eagzkljervqeusx@sigill.intra.peff.net>
User-agent: Debian GNU/Linux 8.9 (jessie); Emacs 25.1.1; mu4e 0.9.19
In-reply-to: <20170809120201.2eagzkljervqeusx@sigill.intra.peff.net>
Date:   Wed, 09 Aug 2017 15:14:22 +0200
Message-ID: <871sokhoi9.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Aug 09 2017, Jeff King jotted:

> Since v2.12.0, Git does not compile with versions of curl
> older than 7.19.4. That version of curl is about 8 years
> old. This means it may still be used in some distributions
> with long-running support periods. But the fact that we
> haven't received a single bug report about the compile-time
> breakage implies that nobody cares about building recent
> releases on such platforms.

This whole series looks good to me. As I commented on in the thread you
referenced in 0/4 I think this is the right trade-off, and people like
me who occasionally compile git on older systems can just easily package
a newer curl as well if we need it.

My reading of the curl history/docs is that you should squash this into
this last patch. It's code that's now dead since we require
7.19.4.

CURLAUTH_DIGEST_IE was added in 7.19.3, and as a comment this squash
removes indicates CURLOPT_USE_SSL hasn't been needed since 7.16.4:
https://curl.haxx.se/libcurl/c/CURLOPT_USE_SSL.html

diff --git a/http.c b/http.c
index 5280511c74..527bc56dc2 100644
--- a/http.c
+++ b/http.c
@@ -103,9 +103,7 @@ static int http_auth_methods_restricted;
 /* Modes for which empty_auth cannot actually help us. */
 static unsigned long empty_auth_useless =
        CURLAUTH_BASIC
-#ifdef CURLAUTH_DIGEST_IE
        | CURLAUTH_DIGEST_IE
-#endif
        | CURLAUTH_DIGEST;

 static struct curl_slist *pragma_header;
@@ -706,10 +704,8 @@ static CURL *get_curl_handle(void)
        if (curl_ftp_no_epsv)
                curl_easy_setopt(result, CURLOPT_FTP_USE_EPSV, 0);

-#ifdef CURLOPT_USE_SSL
        if (curl_ssl_try)
                curl_easy_setopt(result, CURLOPT_USE_SSL, CURLUSESSL_TRY);
-#endif

        /*
         * CURL also examines these variables as a fallback; but we need to query
diff --git a/http.h b/http.h
index 29acfe8c55..66d2d3c539 100644
--- a/http.h
+++ b/http.h
@@ -16,15 +16,6 @@

 #define DEFAULT_MAX_REQUESTS 5

-/*
- * CURLOPT_USE_SSL was known as CURLOPT_FTP_SSL up to 7.16.4,
- * and the constants were known as CURLFTPSSL_*
-*/
-#if !defined(CURLOPT_USE_SSL) && defined(CURLOPT_FTP_SSL)
-#define CURLOPT_USE_SSL CURLOPT_FTP_SSL
-#define CURLUSESSL_TRY CURLFTPSSL_TRY
-#endif
-
 struct slot_results {
        CURLcode curl_result;
        long http_code;
