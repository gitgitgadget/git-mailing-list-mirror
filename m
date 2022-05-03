Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80FD9C433EF
	for <git@archiver.kernel.org>; Tue,  3 May 2022 07:21:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232081AbiECHYk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 May 2022 03:24:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232707AbiECHYM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 May 2022 03:24:12 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9966FF5
        for <git@vger.kernel.org>; Tue,  3 May 2022 00:20:15 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id e5so2317393pgc.5
        for <git@vger.kernel.org>; Tue, 03 May 2022 00:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1JXmWxzbhtTQCYUSr2ir/NKhGiq2f0u4eB+CeQrwdu0=;
        b=ODlR20O1rSeCpAkmbRKd+82vrMYYk2vkfmyPkDGceAc1to8hmsNpBKvegAkpucl2Qd
         BINpF4TLJ9v6FRspf4vSooAwDidNPluY/sqKVzN9qsEIc8DSKLqZXtlpz3oEOQzeSnIF
         JwRqZOOsXTa2kH665gWhKWtgH9fmKwKaMwf5DXRTb2hBOnntLsiMfSuxLiLWmscgtz66
         01AbcjA1pZlXx6CkVGHKD+hVUOTzptjsRqAJ+vo6wMHY29Dw6v0o1cYTnQuJr3f/o4he
         k1Kv7amX/hkCL2e8pdiPT5Ol2hHXzuzDLKYqsdOL+YIsOrWEpqQ+dh2oRjbDTpZ64yCE
         vwdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1JXmWxzbhtTQCYUSr2ir/NKhGiq2f0u4eB+CeQrwdu0=;
        b=nxabU/BzjqDs5dBlGUtgcx+GgWwTPvoqoeqtlxZDRfSSWQ+v6acT+/HsqY6kIGtccP
         yRi/cwvIG39LrkIDHpQ5Yz0h907tMu6lz/X+2BWszOCr/tdwD6WR+Mql67oUr9pVZxRy
         JrqXjxr5puEKjpOQOOTmxXsZ3GUgN9FzogRXNlPQEgnOpvZ6PUywfaxosoORdBoM3Z/f
         c4BpgcxFHmvSM69fcTwyWJ7JpamAq7smC//RO+KupuaVrEhMkN8XjgklBu+3N1XZwkhT
         4fejJuBvRkxZSGm+Fg//d1chRLjfjLek79D5J5P0WdPm1HiNfeRKEcClPDesjktM5i21
         Syiw==
X-Gm-Message-State: AOAM533GqC2C/Gh/FSo/YPisLhenrq3QTilAVYh1qAaG2ylJLqEAPaeX
        xI3goCdbRsGzjj5KLhheMY+e8tnQZqA=
X-Google-Smtp-Source: ABdhPJxupM2FbTTHrE1uD63mRpPhp/kBsEMMS6OqcXgtvPOxSggJxft+QK3ofz8+8SsI7rpd+UUaGQ==
X-Received: by 2002:a63:82c2:0:b0:3c2:8bd5:7238 with SMTP id w185-20020a6382c2000000b003c28bd57238mr404175pgd.440.1651562415198;
        Tue, 03 May 2022 00:20:15 -0700 (PDT)
Received: from localhost (subs32-116-206-28-55.three.co.id. [116.206.28.55])
        by smtp.gmail.com with ESMTPSA id bb8-20020a170902bc8800b0015e8d4eb208sm5655116plb.82.2022.05.03.00.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 00:20:14 -0700 (PDT)
Date:   Tue, 3 May 2022 14:20:11 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] proto-v2 doc: mark-up fix
Message-ID: <YnDXqzdiEGNkCrdu@debian.me>
References: <xmqqczgvsa7k.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqczgvsa7k.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 02, 2022 at 05:58:55PM -0700, Junio C Hamano wrote:
>  The provided options must not contain a NUL or LF character.
>  
> - object-format
> -~~~~~~~~~~~~~~~
> +object-format
> +~~~~~~~~~~~~~
>  
>  The server can advertise the `object-format` capability with a value `X` (in the
>  form `object-format=X`) to notify the client that the server is able to deal

LGTM.

The mistake fixed by this patch doesn't affect the asciidoc output (only
tested with html), since the subheading is correctly rendered.

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

-- 
An old man doll... just what I always wanted! - Clara
