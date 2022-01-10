Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECDA5C433EF
	for <git@archiver.kernel.org>; Mon, 10 Jan 2022 18:57:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242791AbiAJS5Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Jan 2022 13:57:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242641AbiAJS5X (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jan 2022 13:57:23 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B07FC06173F
        for <git@vger.kernel.org>; Mon, 10 Jan 2022 10:57:23 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id u23so3459531qku.5
        for <git@vger.kernel.org>; Mon, 10 Jan 2022 10:57:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=QFgTb2YwgacS0UvhL2rk8sXalU4vhuqWlTfgXM6I5n4=;
        b=GiOf49d0WrPmESTY2XmV78ry/TAMZMlK0PQHycxdf+4wSoo94A2uKZOB6UkGuO3piG
         AI1g8wSit6HBVc3H7BQbv9lXON3NRXMZpkJLhN0S+9SMAzy1AnCFrU907IUTiCIb9CVx
         BGF2mk0wv1UKLcWSeAY1F1x60la4NFMAq94RsbnpXR/W99Oeowrti3msicNkmXR1uEFR
         RLNGs8qFJ2BiYEscYMQwCI0KPBFQsVKrCVnm3SJzBSfNUsyUQCEWOX2mETKzrwkbL6vq
         yN3clP9EVr/nlxgduikJDbRqdzTXW5PZ6hoddQBs2pMh5ZX01LdWdIn6Mw/9V7fhzKvu
         6K1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=QFgTb2YwgacS0UvhL2rk8sXalU4vhuqWlTfgXM6I5n4=;
        b=wNt9WkzZnjSV9Disx5Q2lMbuUuWyz8yfqcyo8x/Z48X0ltiHON8GOgsEohPeFnrlDG
         AkUBeoeTh47JFO+pCj750vLmXJwrJdsaA1MmUFHLB2AFEcM87f8UhiYWTiD38RBnLYJ0
         cWF7XJ1Iw0a+MSw5n5kXWzVWCUi/+MsT9GhjVnb6bXqwUjx6VwIE9DNOTBEdidreVwN5
         jjVezNrbARHOuwkMi51f/FxBK1o0ImeD+1ohdvejTYa/qOJPfB2/dq5Xo0+NefUMIF+y
         iVo2LcR0u/zpwAiRAh7TU53ImpFrQcG4M2/OSVxaj9w8Wx7xnr35/3OJJ1ECeN9rR3rK
         K/Ow==
X-Gm-Message-State: AOAM532HJWTE1xxWw8ouSLj1wij7cK6ExWrjjb2TSzasIMxM+phF21Ky
        KjshFZ6ocus2vEa8RzAInq0Q
X-Google-Smtp-Source: ABdhPJy0oAPAHk2STPT+o2lzSP0SPd4WwGgmqLsWpNQfdDyj2T8AyiY+AqK5nVV47jSEOo9tf5k06Q==
X-Received: by 2002:a37:9d2:: with SMTP id 201mr813532qkj.9.1641841042221;
        Mon, 10 Jan 2022 10:57:22 -0800 (PST)
Received: from [192.168.0.105] (70.15.20.152.res-cmts.sm.ptd.net. [70.15.20.152])
        by smtp.gmail.com with ESMTPSA id l9sm4905958qkj.37.2022.01.10.10.57.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jan 2022 10:57:21 -0800 (PST)
Message-ID: <c0a0798d-96fb-936b-3234-88e500eb86d0@github.com>
Date:   Mon, 10 Jan 2022 13:57:21 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
Subject: Re: [PATCH] cache.h: drop duplicate `ensure_full_index()` declaration
Content-Language: en-US
To:     =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>
References: <20220110184134.18675-1-martin.agren@gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <20220110184134.18675-1-martin.agren@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin Ågren wrote:
> There are two identical declarations of `ensure_full_index()` in
> cache.h.
> 
> Commit 3964fc2aae ("sparse-index: add guard to ensure full index",
> 2021-03-30) provided an empty implementation of `ensure_full_index()`,
> declaring it in a new file sparse-index.h. When commit 4300f8442a
> ("sparse-index: implement ensure_full_index()", 2021-03-30) fleshed out
> the implementation, it added an identical declaration to cache.h.
> 
> Then 118a2e8bde ("cache: move ensure_full_index() to cache.h",
> 2021-04-01) favored having the declaration in cache.h. Because of the
> double declaration, at that point we could have just dropped the one in
> sparse-index.h, but instead it got moved to cache.h.
> 
> As a result, cache.h contains the exact same function declaration twice.
> Drop the one under "/* Name hashing */", in favor of the one under
> "/* Initialize and use the cache information */".
> 
> Signed-off-by: Martin Ågren <martin.agren@gmail.com>
> ---
>  cache.h | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/cache.h b/cache.h
> index 5d7463e6fb..281f00ab1b 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -350,8 +350,6 @@ void add_name_hash(struct index_state *istate, struct cache_entry *ce);
>  void remove_name_hash(struct index_state *istate, struct cache_entry *ce);
>  void free_name_hash(struct index_state *istate);
>  
> -void ensure_full_index(struct index_state *istate);
> -
>  /* Cache entry creation and cleanup */
>  
>  /*

Thanks for cleaning up the duplicate, looks good to me!
