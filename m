Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 405C01FADF
	for <e@80x24.org>; Thu, 18 Jan 2018 18:25:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932269AbeARSZP (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Jan 2018 13:25:15 -0500
Received: from mail-qt0-f193.google.com ([209.85.216.193]:47047 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932219AbeARSZO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jan 2018 13:25:14 -0500
Received: by mail-qt0-f193.google.com with SMTP id o35so22461206qtj.13
        for <git@vger.kernel.org>; Thu, 18 Jan 2018 10:25:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=bgX54ntQJ2j8Sj6Hp+YN7OTl3y8FIOrMGLopvxXnhyY=;
        b=BvDNoFmdgUYnHKi6jD1DmGVeLPGkADFrtIeiaWJKqbWPa/In8cjf+jW3Aa0+DB5JLt
         91NEBdqVKKWxqHGbAxK7Epedu3A9CFRGrP4lsJssxRosU3AUs6xMMKm6CydJubQ3V3LU
         SUWuM58HifBuN4FwnZiz4rhHzYu6taTz9btd2w0Lzws7CM1VK2RiuxBVTybZEbBk7dYH
         OA79lnMgazI/ABa2usP5aKqHnq5EaGgkBzHL3i0jRmCHai9bT9j7cJN44Q37usjwJx7f
         CnvtWWTQ37PaV+ShUrNbTqpcZn7sl4XCidc9voG7KCQwxglhILAd6YW1w3zW8+kc4O1g
         8MZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=bgX54ntQJ2j8Sj6Hp+YN7OTl3y8FIOrMGLopvxXnhyY=;
        b=kokm7TvAoH5RBP9g6CqulLylWtS6dCiRHrGsoyPEkkaQ2hJG24xtP4Qn2BZpcDzRy4
         HntyBVubomeIUm4o2fB1r0S/1XeGpdiXY/ZmJCJrFgierc8NZKk/b5kt84PjHwnUVsfp
         dcnD6idivy+C0/+Z3lLPPp5AjsBT7TFalpo1n/pjLxSdtiqBh9F5MPtKg5a1X9xZ9swV
         YyEQkGl2bNzssQ+t4FQnugAOQK8BrlPiBkAxvFnual4mPY0aflF6fqpVTYiIY48+s99g
         EuqBPzEy3WlfvsHhAhNNudauiCymBaGmHkX48wuChaeo0dXazE/EiLJSGBM44LLkw/XC
         RUgw==
X-Gm-Message-State: AKwxytfCLJZ5iuWg32nBw63M+tEmrXbYeGM0VGwqKhkWm57BsU1D0QfH
        46xis83tewhknY4sjEvi72lm+6yoRyeHHd4un7mpVg==
X-Google-Smtp-Source: ACJfBovQp44j+vrrhaSD+Y0/uxCxOy9Rk5NaiVRXYaFK8j6s51/jSoL7Qp9RBGC5DUsHPhbDejKj5tGs5jN64Qa4TIc=
X-Received: by 10.55.104.17 with SMTP id d17mr22040109qkc.306.1516299913168;
 Thu, 18 Jan 2018 10:25:13 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.137.143 with HTTP; Thu, 18 Jan 2018 10:25:12 -0800 (PST)
In-Reply-To: <b0d7c8cbdd1c6e32f05f95ebde4612eb8bd16fdf.1516235197.git.jonathantanmy@google.com>
References: <cover.1516235197.git.jonathantanmy@google.com> <b0d7c8cbdd1c6e32f05f95ebde4612eb8bd16fdf.1516235197.git.jonathantanmy@google.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 18 Jan 2018 13:25:12 -0500
X-Google-Sender-Auth: UwZjmujhhG7Hwq15l0Bl30p71fw
Message-ID: <CAPig+cRyTL6LXk0JXTcotP8yco1-TxRVZxOWEu-YOnUfEhjr=g@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] http: support cookie redaction when tracing
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 17, 2018 at 7:34 PM, Jonathan Tan <jonathantanmy@google.com> wrote:
> When using GIT_TRACE_CURL, Git already redacts the "Authorization:" and
> "Proxy-Authorization:" HTTP headers. Extend this redaction to a
> user-specified list of cookies, specified through the
> "GIT_REDACT_COOKIES" environment variable.
>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
>  http.c                      | 55 +++++++++++++++++++++++++++++++++++++++++++++
>  t/t5551-http-fetch-smart.sh | 12 ++++++++++
>  2 files changed, 67 insertions(+)

Please document GIT_REDACT_COOKIES in Documentation/git.txt.

> diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
> @@ -364,5 +364,17 @@ test_expect_success 'custom http headers' '
> +test_expect_success 'GIT_REDACT_COOKIES redacts cookies' '
> +       rm -rf clone &&
> +       echo "Set-Cookie: NotSecret=Foo" >cookies &&
> +       echo "Set-Cookie: Secret=Bar" >>cookies &&
> +       GIT_TRACE_CURL=true GIT_REDACT_COOKIES=Secret,AnotherSecret \
> +               git -c "http.cookieFile=$(pwd)/cookies" clone \
> +               $HTTPD_URL/smart/repo.git clone 2>err &&
> +       grep "Cookie:.*NotSecret=Foo" err &&
> +       grep "Cookie:.*Secret=<redacted>" err &&
> +       ! grep "Cookie:.*Secret=Bar" err
> +'

The looseness of these grep expressions (/Cookie:.*Secret/ also
matches "Cookie: NotSecret", for instance) requires extra
concentration on the part of the reader to see that you do indeed
cover all cases. I wonder, therefore, if it would be better to tighten
them to instead match the exact string.

Also, after reading the implementation, I had expected to see testing
of the "Cookie: foo=bar; cow=moo" case, as well as the handled corner
cases, such as missing missing "=" and missing value after "=".
