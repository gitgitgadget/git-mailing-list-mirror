Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46563ECAAD5
	for <git@archiver.kernel.org>; Fri,  9 Sep 2022 16:41:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbiIIQlC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Sep 2022 12:41:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232051AbiIIQkm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Sep 2022 12:40:42 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FAAB14342E
        for <git@vger.kernel.org>; Fri,  9 Sep 2022 09:40:40 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id c9so1581632qkk.6
        for <git@vger.kernel.org>; Fri, 09 Sep 2022 09:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=Y420dyD0blwaKEj7slamWrMg06ASSpppMV3X1jdN5kQ=;
        b=HG68reLvNVcrOuXWiJCM/f7zYyrPOn28TSX0KDQLtXXIlVn/Xg2GbmEX+gV+jpSv/f
         uU84cDx6o0A/y9L2hYg/J5ScEnxg8bicQAUMLvnMWvySBO+yoP41ca9/nWky81s/Abpz
         Sade5eD/01IjAzWOYBpijylJ4GS+4TIBf+Yu4Dd9sggbx2kOLgAyWDwLaZwVgqJAfrRf
         xl+TReZ/8gpvkEw0aUK0ixAhkJvCFF91hWtUjGjt5FjG62xX0JJ6SiGSP4FqvliODznG
         OloR7WvqLXOBS2ntphVYdHpjDJf6IgjzcYUop3DH0+TUBXbAW9q64ID/B+2rjTGkzH1j
         stoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=Y420dyD0blwaKEj7slamWrMg06ASSpppMV3X1jdN5kQ=;
        b=UDOaUBix9G0Xr409Jy4nzdvs4h4Er4sMNbPrOP37uYffnjfUdkUF+PBFwXsjqTw80Z
         ftgzVBzv/bD3S2uQSe2a6NuxbawRoyl+FKJhGqvHlx0DGK0E1Bl5Em5pJ2tf+FWGXt1G
         sUxw9VKuEgVi4XgnZOzwriTQgVSsc+Ir4ZoeYmQy73bJVL6VDVIyfQA6Eay5yHrIrC+s
         76F++ZUpJOy+wzo/aHqcJkpn9DVWLDjpfObrWs+EXgJcWlOCo0htViGndb6w5pEGcTMW
         k0KD5iEvuqHBKELG39qkDa6Zf4fSyTzlI+6VSaqes6Gme3Y0RcFvH/2jUYT+prKhq4N+
         +MGA==
X-Gm-Message-State: ACgBeo1JwzBfieIMMnji6sLXjvinqmShR1RYDiDGujmClglyIv82KH/9
        nf75Qut5nH3dNTIKBWkGeD8R
X-Google-Smtp-Source: AA6agR68MIuHX13EXhNVBLwC11yIf1paXs66Fm5JQwPuoHd92Hm/ZzVWv4D2Iot+ulV4Pl75qzR7pg==
X-Received: by 2002:a05:620a:1788:b0:6bb:75c3:ba06 with SMTP id ay8-20020a05620a178800b006bb75c3ba06mr10067686qkb.686.1662741639986;
        Fri, 09 Sep 2022 09:40:39 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id l16-20020a05622a175000b00342f8143599sm784847qtk.13.2022.09.09.09.40.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Sep 2022 09:40:39 -0700 (PDT)
Message-ID: <d0d0836c-9d2f-53fe-dda1-a8c61e3acd9f@github.com>
Date:   Fri, 9 Sep 2022 12:40:37 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v3 07/11] log: add default decoration filter
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Glen Choo <chooglen@google.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com, vdye@github.com,
        steadmon@google.com,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
References: <pull.1301.v2.git.1659122979.gitgitgadget@gmail.com>
 <pull.1301.v3.git.1659722323.gitgitgadget@gmail.com>
 <c249bface2a6dcd0355620f92579b42a6fa4ea58.1659722324.git.gitgitgadget@gmail.com>
 <kl6lr10l8t7y.fsf@chooglen-macbookpro.roam.corp.google.com>
 <42db9da3-3f69-1bf0-6d88-692e18eb74c1@github.com>
 <xmqqbkromsfx.fsf@gitster.g>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqqbkromsfx.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/9/2022 12:19 PM, Junio C Hamano wrote:

> But during bisection, there is a specific command to give them
> exactly that information: "bisect visualize".  It is roughly
> equilvalent to:
> 
>     git log refs/bisect/bad \
> 	$(git for-each-ref --format='^%(refname)' refs/bisect/good-\*
> 
> i.e. show the history surrounded by all the known-to-be-good commits
> and the known-to-be-bad commit we currently are chasing.  Bad and good
> commits are at the boundary you can tell them without decoration.

Thank you for recommending this as the expected behavior.
 
> But if we still want to see bisect/bad and bisect/good-* in a larger
> graph (i.e. showing descendants of bad and ancestors of good), then
> I do not think good-<object name> being a long label is something we
> should special case and shorten.  Especially because the user is not
> using "bisect visualize", which is readable without decoration, they
> may be seeking more information in the names, perhaps cutting and
> pasting the object names to feed "git show" running on a separate
> terminal, or something.

The object names should be visible as part of the "git log" output
(perhaps abbreviated) and that provides a way to get that information
without needing an unabbreviated hash showing up in a decoration slot.

Thanks,
-Stolee
