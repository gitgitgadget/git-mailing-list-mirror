Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 46D3F1F424
	for <e@80x24.org>; Wed,  9 May 2018 12:11:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934565AbeEIMLs (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 May 2018 08:11:48 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:55986 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756236AbeEIMLq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 May 2018 08:11:46 -0400
Received: by mail-wm0-f65.google.com with SMTP id a8so24279671wmg.5
        for <git@vger.kernel.org>; Wed, 09 May 2018 05:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=9gYS6YZyC8UCO86yPoNMnG1Z+KJfSLqfjFldBdIruWQ=;
        b=T8RadoGeCiFC2K9AcZKmtXehxHcQ4c8VjR0dZDv/cIloMNnh7Sxpa23jp5vO/D+qvZ
         mY/kIwUIRQZN1jrEl32fJFlCcPusjWX1Le/8QD9pN3asCoMYcjy1/v5Se2KlOP5EwL5y
         ZxIXLkcx3c1FqVc/QG/XTbwVYFhg9d6bfT0+houfBM5RiTAtprpxt0UJj/9QeH4w2E5O
         AmDw4M0UdFPXz9oOUfLQK3rqZ7W0I4mo/7IW9a212pT9j3OAsRBgriDray6YiM3wLe7n
         vLogWNIIC3L7iAXyWPVsVO48LC4+L1abQojjnB0f4pqQdW/Qk5I8qtjZ9Zf38dl5ntNM
         WcPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=9gYS6YZyC8UCO86yPoNMnG1Z+KJfSLqfjFldBdIruWQ=;
        b=i5BdK7Tbh0UiDfxWf7CnbrkxcO8mgI1JQZrNNdu0K/tbZ7T/ltbUoibxuDz3/lvabK
         FkIu6N2Mgg3vIKUXVKHoIB6rTs0114GY7o8FmygWLz/+QBLRQZ+0u+yO4WNw3SQbUW6i
         5erUuR7BUgBCS2iMin+XLP/7I7yO5NWDlTu3p0hEyh3rUvMetuE96dgDq1BkLYdZynWL
         o0WKioF0RGaexRwlNq9S4ag+QgIjppQGRB4ZJlZuLBYlY5UeHjqt3ArtXY20X3g0bYjd
         w412kbbuX6vdGTDMtLoc+LT2PKSNxmnsRJAaG6/XHnHm6MYiA5QCtf4IEwo9dkBzNnss
         7nfA==
X-Gm-Message-State: ALQs6tAwg/yt5JdQgCIw0sGt8ypf+etbaRkhM0ShuNazYmoFCoRP0Nov
        1w00bgAAve6w9RyZyKJYJqy+FBXn
X-Google-Smtp-Source: AB8JxZrDts1j5wNiIPrKfo0HDzQ94JOrZ7azhyHWwgcLAzmmtQVuiFqkOXWjdZp8A3tenc0yeSsAeQ==
X-Received: by 2002:a50:93c4:: with SMTP id o62-v6mr59561221eda.169.1525867905631;
        Wed, 09 May 2018 05:11:45 -0700 (PDT)
Received: from evledraar (proxy-gw-a.booking.com. [5.57.21.8])
        by smtp.gmail.com with ESMTPSA id f11-v6sm16552018edf.68.2018.05.09.05.11.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 09 May 2018 05:11:44 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     jens persson <jens@persson.cx>
Cc:     git <git@vger.kernel.org>
Subject: Re: [PATCH] sha1dc: fix for compiling on AIX using IBM XLC compiler
References: <CAEoyyNJPZXUKi3W=Gs=3v8i4YnTL47G9oaHDoV5pvCLx78jUVQ@mail.gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <CAEoyyNJPZXUKi3W=Gs=3v8i4YnTL47G9oaHDoV5pvCLx78jUVQ@mail.gmail.com>
Date:   Wed, 09 May 2018 14:11:43 +0200
Message-ID: <87603xxc3k.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, May 09 2018, jens persson wrote:

> Hello, first patch. I'm having trouble compiling on AIX using IBMs
> compiler, leading to
> unusable binaries. The following patch solved the problem for 2.17.0.
> The patch below is cut&pasted via gmail to allow for firewalls, but
> exists in an unmolested form on github:
> https://github.com/MrShark/git/commit/44bfcaca6637e24548ec06f46fb6035a846b14af
>
> Best regards
> /jp
>
> Building on AIX using XLC every checkout gives an error:
> fatal: pack is corrupted (SHA1 mismatch)
> fatal: index-pack failed
>
> Back tracking it was introduced in 2.13.2, most likely in [1]
>
> Add a #ifdef guard based on macros defined at [2] and [3].
>
> Should perhaps __xlc__ should should be changed to or combined with _AIX
> based on the behavour of GCC on AIX or XL C on Linux.
>
> 1. https://github.com/git/git/commit/6b851e536b05e0c8c61f77b9e4c3e7cedea39ff8
> 2. https://www.ibm.com/support/knowledgecenter/SSGH2K_13.1.3/com.ibm.xlc1313.aix.doc/compiler_ref/macros_platform.html
> 3. https://www.ibm.com/support/knowledgecenter/SSGH2K_13.1.3/com.ibm.xlc1313.aix.doc/compiler_ref/xlmacros.html
>
> Signed-off-by: jens persson <jens@persson.cx>
> ---
>  sha1dc/sha1.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/sha1dc/sha1.c b/sha1dc/sha1.c
> index 25eded139..68a8a0180 100644
> --- a/sha1dc/sha1.c
> +++ b/sha1dc/sha1.c
> @@ -84,7 +84,7 @@
>  /* Not under GCC-alike or glibc or *BSD or newlib */
>  #elif (defined(__ARMEB__) || defined(__THUMBEB__) ||
> defined(__AARCH64EB__) || \
>         defined(__MIPSEB__) || defined(__MIPSEB) || defined(_MIPSEB) || \
> -       defined(__sparc))
> +       defined(__sparc) || (defined(__powerpc) && defined(__xlc__)))
>  /*
>   * Should define Big Endian for a whitelist of known processors. See
>   * https://sourceforge.net/p/predef/wiki/Endianness/ and

This patch looks sane to me, but we don't manage this software but
instead try to pull it as-is from upstream at
https://github.com/cr-marcstevens/sha1collisiondetection

Which we could apply this, it would be much better if you could submit a
pull request with this to upstream, and then we can update our copy as I
did in e.g. 9936c1b52a ("sha1dc: update from upstream", 2017-07-01).
