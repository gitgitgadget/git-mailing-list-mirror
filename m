Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69847C4338F
	for <git@archiver.kernel.org>; Fri, 30 Jul 2021 22:50:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E9FA60F36
	for <git@archiver.kernel.org>; Fri, 30 Jul 2021 22:50:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232672AbhG3WuE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Jul 2021 18:50:04 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52129 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbhG3WuE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jul 2021 18:50:04 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E1FA11440CB;
        Fri, 30 Jul 2021 18:49:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=JPnHaEBll7lP
        M+KzG5Trm03QUyaNBfD1UB4+tw63WRE=; b=GbDzIvhH/pTjpD0muV48bWSK6Kkb
        TN5gtOx1Z4LCY4484D/6S1L5zF++s673AJLUjfNocESC1J3oM3PtViswYIYanQwo
        CveA1UE9GYEcKdfwLz3Ziq+EcZlLG1m9tAWzR9cD5662Iz8hC0pQ3nlmbFKXbLky
        NyD/YMq+Mp00+wY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CE7CA1440CA;
        Fri, 30 Jul 2021 18:49:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 0E0601440C8;
        Fri, 30 Jul 2021 18:49:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v4 0/5] drop support for ancient curl
References: <cover-v3-0.7-00000000000-20210730T092843Z-avarab@gmail.com>
        <cover-v4-0.5-00000000000-20210730T175650Z-avarab@gmail.com>
        <xmqq7dh71v5g.fsf@gitster.g> <xmqqy29nzila.fsf@gitster.g>
Date:   Fri, 30 Jul 2021 15:49:52 -0700
In-Reply-To: <xmqqy29nzila.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
        30 Jul 2021 12:50:57 -0700")
Message-ID: <xmqqa6m3zab3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 74B40920-F188-11EB-83C2-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>>>     +    The documentation[2] currently claims that it was introduced=
 in
>>>     +    7.16.4, but the symbols-in-versions file correctly states
>>>     +    7.17.0[3].
>>>     +
>>>     +    I've submitted an upstream
>>>     +    patch (<patch-1.1-953bab490-20210730T170510Z-avarab@gmail.co=
m>) to the
>>>     +    curl-library mailing list fix the documentation.
>>
>> I am not sure how to get to the patch, but I suspect you might be
>> misreading "up to X", which is different from "before X".  Once cURL
>> mailing list confirms my suspicion, we would need to come back and
>> update this patch again.
>
> Ah, I found it at https://curl.se/mail/lib-2021-07/0058.html
>
> Nobody seems to have responded yet, but I do think you are
> misreading what "X was known under a different name Y up to 7.16.4"
> means.  These places do not say "before 7.16.4", which would have
> implied that as of 7.16.4 you would be able to use X (not Y).
>
> But because "up to" is "less than or equal to but not more than"
> (e.g https://dictionary.cambridge.org/us/dictionary/english/up-to),
> what applies to 7.16.3 also applies to 7.16.4, but not to 7.17.0.
> IOW, the feature X was known as Y when 7.16.4 was current, so our
> use of X would not have worked with that exact version.  We would
> have needed to wait until the next version (7.17.0).

It seems that Daniel has exactly the same reaction as I did.

    https://curl.se/mail/lib-2021-07/0059.html

So, let's fix the log message for [4/5] on our end again.

-- >8 --
http: drop support for curl < 7.19.3 and < 7.17.0 (again)

Remove the conditional use of CURLAUTH_DIGEST_IE and
CURLOPT_USE_SSL. These two have been split from earlier simpler
checks against LIBCURL_VERSION_NUM for ease of review.

According to

  https://github.com/curl/curl/blob/master/docs/libcurl/symbols-in-versio=
ns

the CURLAUTH_DIGEST_IE flag became available in 7.19.3, and
CURLOPT_USE_SSL in 7.17.0.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>

diff --git a/http.c b/http.c
index 1f0d7664d3..e9446850a6 100644
--- a/http.c
+++ b/http.c
@@ -120,9 +120,7 @@ static int http_auth_methods_restricted;
 /* Modes for which empty_auth cannot actually help us. */
 static unsigned long empty_auth_useless =3D
 	CURLAUTH_BASIC
-#ifdef CURLAUTH_DIGEST_IE
 	| CURLAUTH_DIGEST_IE
-#endif
 	| CURLAUTH_DIGEST;
=20
 static struct curl_slist *pragma_header;
@@ -893,10 +891,8 @@ static CURL *get_curl_handle(void)
 	if (curl_ftp_no_epsv)
 		curl_easy_setopt(result, CURLOPT_FTP_USE_EPSV, 0);
=20
-#ifdef CURLOPT_USE_SSL
 	if (curl_ssl_try)
 		curl_easy_setopt(result, CURLOPT_USE_SSL, CURLUSESSL_TRY);
-#endif
=20
 	/*
 	 * CURL also examines these variables as a fallback; but we need to que=
ry
diff --git a/http.h b/http.h
index 19f19dbe74..3db5a0cf32 100644
--- a/http.h
+++ b/http.h
@@ -12,15 +12,6 @@
=20
 #define DEFAULT_MAX_REQUESTS 5
=20
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
