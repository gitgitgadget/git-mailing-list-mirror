Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EE66ECAAD1
	for <git@archiver.kernel.org>; Thu, 25 Aug 2022 22:21:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244357AbiHYWVI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Aug 2022 18:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244346AbiHYWVG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Aug 2022 18:21:06 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 065C9C2751
        for <git@vger.kernel.org>; Thu, 25 Aug 2022 15:21:05 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id n21so16341048qkk.3
        for <git@vger.kernel.org>; Thu, 25 Aug 2022 15:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=Kgzh/cuOCA8POMmW17ncdCL8sS/9StWTnHLD8Yw7T48=;
        b=PHlLIckDgmdszcsaLnMXCnCuGiU4kVGw+smOhsFc61BLv0dpBfZfMvXnuaOSc2Tse9
         wWybb/Nhtr7tgyGr9kS1aIyfPuF3OfK34u9b02P5M3rA+TYKCVhblyTmC45XDV4zVau5
         Qf9z+7Le4gdAFxy8V7wnhoj1NCxPNgO/PmcpjA/2TnbUaHhIHc6VU+6dL8TItwfpMDrA
         BJgcijReTEaHIpfYMy6dwl3eys4Qt+1NGb6CjzR2kFv0PUyM0BYENsUMRyJ29Xyytmf3
         L329xaiC1kTqUwtrT7Fv6U2rwsjslJaX1dul5z/eIWiIN2QtAr2ifgw+HVs+SSwS0WHX
         wgkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=Kgzh/cuOCA8POMmW17ncdCL8sS/9StWTnHLD8Yw7T48=;
        b=BkqNCMcq5mumEz4vqUfVAjCw+MrWWGISZaBxW050MCgpWwYHwNoGJ37kthli8zslcl
         LtZqIa0hlRfL2A6rPWuV5ZPMzfiL+244Ln6ZYpcRQPat4ZNr4JVvZDZgkYRctbjT19bR
         whHZqBohQmUXBjktEKUNFJYypsOgF0x/WsvaiT/2jaO3NWV73LS2S2RR2q4uUIFmlBK7
         0RP2tc7GKCbYL9OUfNTMoi59LM/odqY8l95EIhTP9d1fOp0sJZUzhrBCyOK62S7z1+aW
         gjIry4nSbEZ2C7hPUiAtZ7xiztqKkA2Fg40Obs5Lhlzgayp207CZlDRJiBEgSrEKx9W+
         pd9A==
X-Gm-Message-State: ACgBeo1nTY3bvGg6gS+0515kXKeJeHvikhvm/wec2CcLrioXPIrNhuaI
        1gsB9WcGu4JqbpGGk+nak6e4BQ==
X-Google-Smtp-Source: AA6agR7QdINoD9EcYBaOStoOPom4syQWDIHqUchnSiX/61XRJ74+uCMtwBO1pRY9pGDkO/s6JKF4Fw==
X-Received: by 2002:a37:bb04:0:b0:6b8:f051:924b with SMTP id l4-20020a37bb04000000b006b8f051924bmr4679577qkf.32.1661466064046;
        Thu, 25 Aug 2022 15:21:04 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id w30-20020a05620a0e9e00b006bb619a6a85sm494991qkm.48.2022.08.25.15.21.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 15:21:03 -0700 (PDT)
Date:   Thu, 25 Aug 2022 18:21:02 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Aug 2022, #08; Wed, 24)
Message-ID: <Ywf1zngpKknCmGYl@nand.local>
References: <xmqqa67s5275.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqa67s5275.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 24, 2022 at 10:20:30PM -0700, Junio C Hamano wrote:
> * ac/bitmap-lookup-table (2022-08-14) 6 commits
>  - bitmap-lookup-table: add performance tests for lookup table
>  - pack-bitmap: prepare to read lookup table extension
>  - pack-bitmap-write: learn pack.writeBitmapLookupTable and add tests
>  - pack-bitmap-write.c: write lookup table extension
>  - bitmap: move `get commit positions` code to `bitmap_writer_finish`
>  - Documentation/technical: describe bitmap lookup table extension
>
>  The pack bitmap file gained a bitmap-lookup table to speed up
>  locating the necessary bitmap for a given commit.
>
>  Needs review.
>  cf. <YwOXIE8K0GJRLuDT@nand.local>
>  source: <pull.1266.v6.git.1660496112.gitgitgadget@gmail.com>

I took a careful look at the latest version of this series (v6) and was
happy with the results. My review is here:

    https://lore.kernel.org/git/Ywf01YqJKNsGfffx@nand.local

and I think that this is ready to start cooking in next. Well done,
Abhradeep!

> * tb/midx-with-changing-preferred-pack-fix (2022-08-22) 7 commits
>  - midx.c: avoid adding preferred objects twice
>  - midx.c: include preferred pack correctly with existing MIDX
>  - midx.c: extract `midx_fanout_add_pack_fanout()`
>  - midx.c: extract `midx_fanout_add_midx_fanout()`
>  - midx.c: extract `struct midx_fanout`
>  - t/lib-bitmap.sh: avoid silencing stderr
>  - t5326: demonstrate potential bitmap corruption
>
>  Multi-pack index got corrupted when preferred pack changed from one
>  pack to another in a certain way, which has been corrected.
>
>  Will merge to 'next'?
>  cf. <be9c7c72-ba24-3e1a-8428-58a2e2afa09a@github.com>
>  source: <cover.1661197803.git.me@ttaylorr.com>

Yeah, this one is ready to go. Stolee gave it a look in the email that
you linked, and said it looked good to him.

Abhradeep took a brief look and didn't notice any problems (but I think
he is quite busy outside of GSoC right now and so didn't appear to spend
a significant amount of time reviewing it).

This should probably be taken to next at the same time or before
ac/bitmap-lookup-table, since that topic seems to tickle the bug more
often than not.

> * tb/show-ref-count (2022-06-06) 2 commits
>  - builtin/show-ref.c: limit output with `--count`
>  - builtin/show-ref.c: rename `found_match` to `matches_nr`
>
>  "git show-ref" learned to stop after emitting N refs with the new
>  "--count=N" option.
>
>  Expecting a reroll.
>  cf. <xmqqczfl4ce1.fsf@gitster.g>
>  source: <cover.1654552560.git.me@ttaylorr.com>

Feel free to discard for now. I put this topic down, and don't think
that it's essential to get back to anytime soon-ish.

Thanks,
Taylor
