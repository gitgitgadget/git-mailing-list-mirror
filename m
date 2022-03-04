Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8767C433EF
	for <git@archiver.kernel.org>; Fri,  4 Mar 2022 15:35:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233371AbiCDPg0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Mar 2022 10:36:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240384AbiCDPgZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Mar 2022 10:36:25 -0500
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 461401C60F7
        for <git@vger.kernel.org>; Fri,  4 Mar 2022 07:35:37 -0800 (PST)
Received: by mail-oo1-xc35.google.com with SMTP id 6-20020a4a0906000000b0031d7eb98d31so9762991ooa.10
        for <git@vger.kernel.org>; Fri, 04 Mar 2022 07:35:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=I7bNq28LjzcXDPHynt1cUTKPUI6c1O/xN5Hty2ZIcdU=;
        b=MFsgVuVrUrL9a+zervbEdiXteAtLD/vBlRDORJn2el5CDjhhuDiXOznLNmnHz3aidU
         +Z2UKMdCu4VsDaZkh7RsajMis+ByrESev7wIIkvgIvqGB9mARaQtG3LOciHEEwK6Ok5m
         dvRZLpqLDaEcmxBr3L5QPGOPMOpB9toqnBlfuqJYi4E93hUc1IIpwuZ5VA4LH8aN9Z0M
         8EYMZ9zifTSFMfLDI+q4dzSIGmfdf1LOPviUlpyZRgaz8xvuQDkQAncv8A+VTFXuOVUs
         09eNpmnEqUj91mDw0ChWIolDPBZKO3CPIYsTtfE28ncuFFBE3FsqrfrlK08BmG7aD4Xo
         Zkgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=I7bNq28LjzcXDPHynt1cUTKPUI6c1O/xN5Hty2ZIcdU=;
        b=l20lpD5Ri5k1rtI/vKDoZU93e0GpayJFqCle1D4+HEUCVcQdJxEj97xrOAYZsIKI60
         0tKQ+pUG4UySufrcuGqSQMeSwMHvaTXgLM4EEHRFZsOPvRTEXJ3mTMc9x31Rwth5k9+a
         Su5M8upq5phrJPUem25PHcPvesB+CO03pI6IlkAlpNKGo7JSC7Nm0h1zJkbIOmClLIKd
         xzmkzGnmTUugy1MnOi7F/Nj3BVJS2bf40dZjPNuRD0ckYDxugLvPCSnlekVDZDRVE7pB
         TeoU3jElXCPe2jDdgp3hLpTqHLubS0k3u/EJWRRKLyHVguf6efa1TEPFS8NQA4pl299V
         Ry8Q==
X-Gm-Message-State: AOAM533J07bTKJZsnylIDfRaZgo3w+YekHz5hS3hc/GNdNwrREw3OVvG
        WRvpkysrQfG2kHcNSuBDvmdAOePUzTxa
X-Google-Smtp-Source: ABdhPJwUshm2zoBLtMqsgL49TSbwrqSYYKxJiclcyWVJqxPOTkyHQVXnymgDUHXUMo0SHehLArZRkA==
X-Received: by 2002:a4a:c506:0:b0:31c:ce0a:717e with SMTP id i6-20020a4ac506000000b0031cce0a717emr21836352ooq.72.1646408136615;
        Fri, 04 Mar 2022 07:35:36 -0800 (PST)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id i28-20020a056808055c00b002d51e377248sm2770394oig.33.2022.03.04.07.35.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Mar 2022 07:35:36 -0800 (PST)
Message-ID: <0870b8f0-976a-cf2f-f34f-7e966b9c426f@github.com>
Date:   Fri, 4 Mar 2022 10:35:34 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: tb/cruft-packs (was Re: What's cooking in git.git (Mar 2022, #01;
 Thu, 3))
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFz?= =?UTF-8?Q?on?= 
        <avarab@gmail.com>
References: <xmqqv8wu2vag.fsf@gitster.g>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqqv8wu2vag.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/3/2022 11:31 PM, Junio C Hamano wrote:
> * tb/cruft-packs (2022-03-02) 17 commits
>  - sha1-file.c: don't freshen cruft packs
>  - builtin/gc.c: conditionally avoid pruning objects via loose
>  - builtin/repack.c: add cruft packs to MIDX during geometric repack
>  - builtin/repack.c: use named flags for existing_packs
>  - builtin/repack.c: allow configuring cruft pack generation
>  - builtin/repack.c: support generating a cruft pack
>  - builtin/pack-objects.c: --cruft with expiration
>  - reachable: report precise timestamps from objects in cruft packs
>  - reachable: add options to add_unseen_recent_objects_to_traversal
>  - builtin/pack-objects.c: --cruft without expiration
>  - builtin/pack-objects.c: return from create_object_entry()
>  - t/helper: add 'pack-mtimes' test-tool
>  - pack-mtimes: support writing pack .mtimes files
>  - chunk-format.h: extract oid_version()
>  - pack-write: pass 'struct packing_data' to 'stage_tmp_packfiles'
>  - pack-mtimes: support reading .mtimes files
>  - Documentation/technical: add cruft-packs.txt
> 
>  A mechanism to pack unreachable objects into a "cruft pack",
>  instead of ejecting them into loose form to be reclaimed later, has
>  been introduced.
> 
>  Will merge to 'next'?
>  source: <cover.1646266835.git.me@ttaylorr.com>

This version looks good to me. There were some other comments that
seem to have resolved without a need to change the patches.

Thanks,
-Stolee

