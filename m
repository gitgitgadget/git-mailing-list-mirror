Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A734C433EF
	for <git@archiver.kernel.org>; Wed, 15 Jun 2022 13:30:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243950AbiFONa4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jun 2022 09:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232167AbiFONaz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jun 2022 09:30:55 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0F0F32EC6
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 06:30:54 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id x18so8139952qtj.3
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 06:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=oVT1OwQnaQ20+uJu2Gu3g5KbhetNQyKNFnvdINfUszs=;
        b=O0Zal4nKSXbQecFpgt/P97cVHlA1/UsWTomefj7bA5zzitBMPLN1dAb/GLFQbLgcpw
         KNBAxgxMh4SNJ4sGh5dPgOsTFItn6/ZSZMaCaRjCg30RV8dbn7zbcH7REGKa8C9ZfGft
         FVKJoyn3QcsQeqCVmK8GNYqW+QphVaK0bnNq+ZNLqKJlL4qaK60Qy0Sj8VH6nVjad2J8
         oeUDshrNoJsw/hZyI9z1MehY8jY2KKL4NfWXDLm4TwvhoH3FW8qv6Yg7WGK1qHKbU3dF
         Na9VuED0BLPveRc3nhw6IRZi79VrEWwctwJxI2MNO09eeiZzqRk6E+P1krelDVD2G4J3
         cy2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=oVT1OwQnaQ20+uJu2Gu3g5KbhetNQyKNFnvdINfUszs=;
        b=bT720pMRXjwPdSkcXMW6+54OXjEqVvNkxS0En7z4MhERgF7xph706JBvlJexsrQwBr
         V9Lqi923TEfAc8WATfghHjXzVh+6e/lwUpCBWpSWpwC34yUSjrBVrQhHyFIJYZ0+2b+P
         WbsjGA83nKS20ii9jhzdakXKdCnz4g7mHUJ9ejBpe/yUfhGryM08xpWyQtyToitF6mr1
         kfSmLRzJKNPO+vwsoEX0oJomUNM33jFnI65EDjtVZieRgN37gj/oIwHElFLI9FOYMQwh
         cb7Vkx/tUVq2czVN85VI0UikwCTvOPt45aZO9/2EEzPi3rHgJGrQHYSJ7j0Aw3UPZ+d4
         NLhA==
X-Gm-Message-State: AOAM530txj4CKL0mRIsndu67Y2W6Gwb5Aoc5dwhPXtVWjmpi/UF0K4uQ
        EQNo7O9MI0BrG1J73u1sPkEAGTNUfIYT
X-Google-Smtp-Source: ABdhPJx09dmPSnFXoMkmizJiJZRSIq5L+BsLM4u8n9wF/wG2mJrCo3LBhebYODUy7ezDBYy3+BezIA==
X-Received: by 2002:a05:622a:305:b0:305:f25:9350 with SMTP id q5-20020a05622a030500b003050f259350mr8747916qtw.507.1655299853897;
        Wed, 15 Jun 2022 06:30:53 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:900f:fa9e:132:1bde? ([2600:1700:e72:80a0:900f:fa9e:132:1bde])
        by smtp.gmail.com with ESMTPSA id l188-20020a37bbc5000000b006a6bbc2725esm11404352qkf.118.2022.06.15.06.30.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jun 2022 06:30:53 -0700 (PDT)
Message-ID: <a7c81b77-651d-3374-6db8-f46ad01a8319@github.com>
Date:   Wed, 15 Jun 2022 09:30:52 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.1
Subject: Re: [PATCH] pack-write.c: remove unused `mtimes_name` parameter
Content-Language: en-US
To:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Cc:     gitster@pobox.com
References: <f5bf68702d55b601ebd13bc4a6f1a34dc35abae5.1655253465.git.me@ttaylorr.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <f5bf68702d55b601ebd13bc4a6f1a34dc35abae5.1655253465.git.me@ttaylorr.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/14/22 8:37 PM, Taylor Blau wrote:
> `write_mtimes_file()` takes an optional parameter `mtimes_name`, which
> specifies where to write the mtimes file. If it is NULL, a location is
> generated with `odb_mkstemp()`.
> 
> This imitates the pattern in `write_idx_file()`, and `write_rev_file()`,
> both of which have callers from the `index-pack` builtin which specify
> an exact location instead of generating one.

I have a nearly-identical patch [1], but I'm happy to take Taylor's
instead. I'll plan on dropping that patch from my v2.

[1] https://lore.kernel.org/git/b67e110bf60e820874de94c64ee8c32d69413877.1655242070.git.gitgitgadget@gmail.com/

Thanks,
-Stolee
