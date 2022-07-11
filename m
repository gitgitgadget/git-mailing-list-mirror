Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F891C433EF
	for <git@archiver.kernel.org>; Mon, 11 Jul 2022 10:49:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbiGKKtD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Jul 2022 06:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbiGKKsl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jul 2022 06:48:41 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21C81F32C1
        for <git@vger.kernel.org>; Mon, 11 Jul 2022 02:55:14 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id i128-20020a1c3b86000000b003a2ce31b4f8so4691291wma.1
        for <git@vger.kernel.org>; Mon, 11 Jul 2022 02:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=G+ym12O2kqxWLDAeu/ko8buwNYBVFKg4eBgz4+c4UgQ=;
        b=FO7PWQLgYM9F3cfkgokbDFkt53uNaenOKp8qO6G5WEyArPTi5j3B+X+nKMuhsKGbrk
         Ys1KtHoc78hMxZLRJo8xwbKutD1awZA6p1gtUHQMMjVi1V8e1VRH9cPcsw7W1FETC7M3
         DgHPX7O2ve2XWXKoS7z0brcbicyd8UlTTRqBDl6/qrPSSFz7udr5GhNTAsT65PSKZ9gE
         fVTRlkO73cm9CXVfrRMG0T1nGCblNSCkYP0jcXh0dVrwUdFOBsA8CO4u2CuGFx3prYZp
         suLSbASdhemO8QSCNoKP6I5zq4ke00/ormCScELDggu8HCkxmxR+vOcbWjvX1DtykJ5o
         ryCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=G+ym12O2kqxWLDAeu/ko8buwNYBVFKg4eBgz4+c4UgQ=;
        b=2MBGVso/7xZTISyAFxMb282r7/q7ePSldLhx2y8b5nSDIVrzmyRAo45OoN1N1ZLjpy
         ObL+0wQh+myeFp3Br12psRn0jpAW73MZFUqjlL7geH4hDLa7UIzZoCCOhykChE0ZdhaD
         k8OY/hbC8vZ6+H0BDGzSU04hwuhhgx53grnZNm0RYXJWDYrbJNPHmZFuiL08lV5ccspd
         heOj+zPYLx7PPxLLKZBYhdECRlsUdajbg/pboIn4QQ0Gm/SdVWemvSjRN1qB+KoauehF
         Ad7UFDIkHD7iUFg1WQ4LSkLZeVN9lLSKjpFyBziex8Itka3V3kZgNlbCgkC8YHuM1zl5
         Y9AA==
X-Gm-Message-State: AJIora9Dj4+l53gbEPOBb0iswglIk2/2Y2WqpOjexPAZjkDFz4LGF+0K
        8n02VSbTUxNBeOAJ6oJZZRh1LfNwN4Y=
X-Google-Smtp-Source: AGRyM1viQ3lQPMDS+3uAuHw9sduWyrKPVwaD3BNBXiNQox+fJfOycxKj6pFKzptGt4Iyk8/r+d9dWQ==
X-Received: by 2002:a05:600c:c2:b0:3a2:e51a:78aa with SMTP id u2-20020a05600c00c200b003a2e51a78aamr8031262wmm.48.1657533313221;
        Mon, 11 Jul 2022 02:55:13 -0700 (PDT)
Received: from [192.168.1.201] ([31.185.185.192])
        by smtp.googlemail.com with ESMTPSA id q123-20020a1c4381000000b00397402ae674sm7066733wma.11.2022.07.11.02.55.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jul 2022 02:55:12 -0700 (PDT)
Message-ID: <81b1f792-f8e9-efa5-fb3f-856264b85287@gmail.com>
Date:   Mon, 11 Jul 2022 10:54:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 7/7] xdiff: remove xdl_free(), use free() instead
Content-Language: en-US
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>
References: <b34dcb93-df73-f5de-3c7c-7ab6c3250afe@gmail.com>
 <cover-0.7-00000000000-20220708T140354Z-avarab@gmail.com>
 <patch-7.7-a1bf9a94f0a-20220708T140354Z-avarab@gmail.com>
 <6b8fc0e8-c446-1275-12f3-e6520de9584d@gmail.com>
 <220708.86czef9t6y.gmgdl@evledraar.gmail.com>
 <dcde61a3-4d96-6cd5-f05e-45781599f8bd@gmail.com>
In-Reply-To: <dcde61a3-4d96-6cd5-f05e-45781599f8bd@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/07/2022 10:26, Phillip Wood wrote:
>> For the monkeypatching you do now of creating a "git-xdiff.h" I think it
>> would be very good to get a patch like what I managed to get
>> sha1collisiondetection.git to accept for our own use-case, which allows
>> us to use their upstream code as-is from a submodule:
>>
>>     https://github.com/cr-marcstevens/sha1collisiondetection/commit/b45fcef 
>>
> 
> Thanks for the link, That's a really good example where all the 
> identifiers are namespaced and the public include file does not pollute 
> the code that is including it. If you come up with something like that 
> where the client code can set up same #defines for malloc, calloc, 
> realloc and free that would be a good way forward.

To be clear those should be namespaced, so we'd have 
-Dxdl_malloc=xmalloc (or xmalloc_gently) and libgit2 would have
-D xdl_malloc=git__malloc

Best Wishes

Phillip

> I do not think we 
> should require projects to be defining there own versions of 
> [C]ALLOC_*() and BUG() just to use xdiff.
> 
> Best Wishes
> 
> Phillip
> 

