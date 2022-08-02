Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1D63C00140
	for <git@archiver.kernel.org>; Tue,  2 Aug 2022 12:40:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236230AbiHBMkz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Aug 2022 08:40:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236063AbiHBMkx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Aug 2022 08:40:53 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 402EB6415
        for <git@vger.kernel.org>; Tue,  2 Aug 2022 05:40:51 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id s11so6017214edd.13
        for <git@vger.kernel.org>; Tue, 02 Aug 2022 05:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=jCjZ+OJr3790iYOaysmVnPTrfuCmtk6hjKECRKKx6l4=;
        b=OdE2gIRqudAHRBmxUTlKSA/WywCPmKHMje9Y2ojckEu/ZNcrY4lsHJt6afp2ckwpJw
         xvZl7soQsxnWe/1DYNfeNLrFgCa8BSLX1YEGaYA5ZFXf845YiImu1T7Zzw6WF50yRVxq
         KjTwacLxZZlJ8HsZiDFta8t2qZD7crpThLANs6wBRDvMV1Qx0nSiaqpxbw2HF9CKlHTq
         JviXZNEnlIjkYu1DtSEQXy5h/VqsPGLRZj/HEzSXxxtZLkiL1QLZGbUuwxZHyqGS52nu
         Vf0v9XPdrchhEb6muCcsK0QsnUJXnXjL0qsbLl1JWphUGfENRPNUpH9+wwvKsyDg/Kle
         e4Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=jCjZ+OJr3790iYOaysmVnPTrfuCmtk6hjKECRKKx6l4=;
        b=exHlGneeXajP8JMXyJgAdGaly8ZQbyfCZdgFQFyG5+tcJc+910ewlEns69EQKeO6r5
         /OrHiLJ4PNHA45z9Qveh2d92wIzecABKKxyJJhHpyg365Fd+ishXjkVXPSifhVGWC6x0
         qXaKPZUo/HLLv+WpbbStvwyKhhMWcBqai7Uf7ZJ8UCeK2wVGLVm7QEf/LWdW+JBBLwFY
         /1dZz0cFS9O/teWtq+fCjrGQ8LM/xQrmRsGUvTC4UC0ANizXtPCeR0djQM1XIe2kv0TB
         p8EU1e2YItS0QPMdb3Zx7jhBCE4nEgLUnEPDl6iXVnfYAAAKm2/uKfgzEcnw5jHC5wmT
         xa0A==
X-Gm-Message-State: ACgBeo3La9TFFoo3AiEpijkAhZf5Ba3aKmJ9EV6/BFyhwAnl/g0ruuCu
        0NpYbFyr9jK3Us24XCzyRiEzZnH5j5W5ETypkiY=
X-Google-Smtp-Source: AA6agR5V3uf0SkH8Ws3Ft6XEYqVxIBd8lRwkCpKFdbhZYdea8utr1+nTVoRP5MMWTeXJ+LOkY1WosOZpA2644yByYLE=
X-Received: by 2002:a05:6402:612:b0:43d:5049:4d0f with SMTP id
 n18-20020a056402061200b0043d50494d0fmr15364460edv.127.1659444049619; Tue, 02
 Aug 2022 05:40:49 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1266.v4.git.1658325913.gitgitgadget@gmail.com>
 <pull.1266.v5.git.1658342304.gitgitgadget@gmail.com> <59b465e5a7817c145172f25e73ad807c7ba67e84.1658342304.git.gitgitgadget@gmail.com>
 <p3r70610-8n52-s8q0-n641-onp4ps01330n@tzk.qr>
In-Reply-To: <p3r70610-8n52-s8q0-n641-onp4ps01330n@tzk.qr>
From:   Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Date:   Tue, 2 Aug 2022 18:10:38 +0530
Message-ID: <CAPOJW5xBUaAJtOvrefwbXv_WDTLa=6PTL5kEoOpRQfqqFAx3oA@mail.gmail.com>
Subject: Re: [PATCH v5 3/6] pack-bitmap-write: learn pack.writeBitmapLookupTable
 and add tests
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Abhradeep Chakraborty via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Taylor Blau <me@ttaylorr.com>,
        Kaartic Sivaram <kaartic.sivaraam@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Philip Oakley <philipoakley@iee.email>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 29, 2022 at 12:52 AM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> That's quite a large a change, and unfortunately I pinpointed a flake to
> this patch when running with GIT_TEST_DEFAULT_HASH=sha256. The symptom is
> this:

Hi Dscho, sorry for this long delay in response. I was quite busy for
3-4 days in hostel room shifting. So, I couldn't work properly during
this time.

> -- snip --
> [...]
> + diff -u expect.normalized actual.normalized
> + rm -f expect.normalized actual.normalized
> ok 317 - enumerate --objects (full bitmap, other)
>
> expecting success of 5326.318 'bitmap --objects handles non-commit objects (full bitmap, other)':
>                 git rev-list --objects --use-bitmap-index $branch tagged-blob >actual &&
>                 grep $blob actual
>
> + git rev-list --objects --use-bitmap-index other tagged-blob
> + grep bff4ed5e839bd73e821f78b45a7fa34208aa85596535ec8e9ac5eab477ca6f81 actual
> bff4ed5e839bd73e821f78b45a7fa34208aa85596535ec8e9ac5eab477ca6f81
> ok 318 - bitmap --objects handles non-commit objects (full bitmap, other)
>
> expecting success of 5326.319 'clone from bitmapped repository':
>                 rm -fr clone.git &&
>                 git clone --no-local --bare . clone.git &&
>                 git rev-parse HEAD >expect &&
>                 git --git-dir=clone.git rev-parse HEAD >actual &&
>                 test_cmp expect actual
>
> + rm -fr clone.git
> + git clone --no-local --bare . clone.git
> Cloning into bare repository 'clone.git'...
> remote: Enumerating objects: 756, done.
> remote: Counting objects: 100% (754/754), done.
> remote: Compressing objects: 100% (281/281), done.
> remote: Total 756 (delta 245), reused 740 (delta 234), pack-reused 2
> Receiving objects: 100% (756/756), 77.50 KiB | 8.61 MiB/s, done.
> fatal: REF_DELTA at offset 221 already resolved (duplicate base 4d332072f161629ffe4652ecd3ce377ef88447bec73f05ab0f3515f98bd061cf?)
> fatal: fetch-pack: invalid index-pack output
> error: last command exited with $?=128
> not ok 319 - clone from bitmapped repository
> #
> #                       rm -fr clone.git &&
> #                       git clone --no-local --bare . clone.git &&
> #                       git rev-parse HEAD >expect &&
> #                       git --git-dir=clone.git rev-parse HEAD >actual &&
> #                       test_cmp expect actual
> #
> 1..319
> -- snap --
>
> On a hunch, I ran this through valgrind (took a while) but it did not
> point out the problem.
>
> Again, this is only with SHA-256 (and somewhat flaky), it passes every
> time with SHA-1. Maybe you can reproduce on your side with that
> information?

Yeah, I can reproduce it on my side. But I am sure it is not related
to the lookup table implementation code. Because when I swap the order
of calling  `test_midx_bitmap_cases "pack.writeBitmapLookupTable"` and
`test_midx_bitmap_cases` (in t5326-multi-pack-bitmaps.sh), in that
case, the error is being generated in  `test_midx_bitmap_cases` call.
Generally speaking, the error is always being generated in the second
call.

For now, my understanding says that there is something fishy in the
test script. I am still not able to figure out the problem here. But
let me further investigate.

If anyone has some idea about what could be the culprit, I will be
very happy to know.

Thanks :)
