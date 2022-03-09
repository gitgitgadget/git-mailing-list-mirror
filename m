Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA0C2C433F5
	for <git@archiver.kernel.org>; Wed,  9 Mar 2022 18:40:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236617AbiCISlf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Mar 2022 13:41:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235364AbiCISle (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Mar 2022 13:41:34 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74B6E170D61
        for <git@vger.kernel.org>; Wed,  9 Mar 2022 10:40:35 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id v15so2495279qkg.8
        for <git@vger.kernel.org>; Wed, 09 Mar 2022 10:40:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=BIyoCBjn7gmqlJxaJaXoSsTAq8g4u9x82qgi4m7cc/U=;
        b=jzQpB7Rjm4PF5HO3GhtdpCZsNIgjDd1dHcLqCTlM+ZNkSIie79OYUUO9du8NxJ83QM
         2mo0zCNmUd9j2eySWFKUfLxJ/g5pPzC7Rb+LkgX7q38RdaIMiR7tCgaVA9I5F4dQ8L4b
         lsZ9p/+Z7qBcftDnXObmd+No3AmHRi/bdy6mIdA5i30l8m8cf4FYo8WbLvov2ddoa445
         esS8ygoq2LJyLihbP5QPtQmlIxRZ0AAKjGA7dKLdQrt/ewdeEbbBW4ySbN4wjRk+aJXL
         5CBKSfxMPtavz1T22q9aC2l/OANYM0sS6QgAjy5OaMch4KIY9pdAceLZ3wZWIDMenNon
         4VlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=BIyoCBjn7gmqlJxaJaXoSsTAq8g4u9x82qgi4m7cc/U=;
        b=oGLQUX08XJ12F6akjdqN9Gybtq2F+HXRyLLyEGd3zyVCUuZ34IUBiofE/Hs0Citmgc
         SUrGUNbxjjLQmD2sNSRXbYTpv00FJ+yWlzM5M3lWlp38rxuvb70sGyLO/LNDPiyyywUp
         PB3LQh7krtHPqRmyqLFSF8wy16jJQpJamxxbpcOaiGbg9ljiq8SesBBOWUL/bxpJyDSo
         ogKhKLEhjbXIfhkmFOfiYr9unsZXmV8owu+m6/jnj7w27xf6QREwmoOc0G57HO8vvRoV
         xHFf1wpgU/ijHJYbvQe2+SeoWlomsds7iEVysamlHG8kq1pwai2huMDTMkDsxKnFGicB
         DBOA==
X-Gm-Message-State: AOAM530VP3NwYFHrKVnyvmRraulJuUyqklaVDu95o5QvDSxt9lKIrH6J
        YeA7ML26hmKA7sMAvJb+QE2KG5N/5zLp
X-Google-Smtp-Source: ABdhPJzjHgD8cqF3VjjnjAQE4SaYmpc6Nz3TyJAK/JUD212dluyoeYYgJjTwYMTqYlK9OO+hwO6pQQ==
X-Received: by 2002:a37:54f:0:b0:67d:4926:5c49 with SMTP id 76-20020a37054f000000b0067d49265c49mr673007qkf.507.1646851234533;
        Wed, 09 Mar 2022 10:40:34 -0800 (PST)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id m10-20020a05622a054a00b002e049ff99f2sm1736263qtx.7.2022.03.09.10.40.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Mar 2022 10:40:34 -0800 (PST)
Message-ID: <af6c456a-d49f-e0f2-50ae-f44fdb6351e3@github.com>
Date:   Wed, 9 Mar 2022 13:40:32 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v2 25/27] t/lib-unicode-nfc-nfd: helper prereqs for
 testing unicode nfc/nfd
Content-Language: en-US
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Torsten =?unknown-8bit?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.1143.git.1644940773.gitgitgadget@gmail.com>
 <pull.1143.v2.git.1646777727.gitgitgadget@gmail.com>
 <5a0c1b7a2873accc6db4b34493962378819eacd4.1646777728.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <5a0c1b7a2873accc6db4b34493962378819eacd4.1646777728.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/8/2022 5:15 PM, Jeff Hostetler via GitGitGadget wrote:
> From: Jeff Hostetler <jeffhost@microsoft.com>
> 
> Create a set of prereqs to help understand how file names
> are handled by the filesystem when they contain NFC and NFD
> Unicode characters.

Prereqs look good and are well documented.

> +if test $unicode_debug = 1

Is this $unicode_debug something I should know from a previous
patch? or is it a leftover from local debugging?

Thanks,
-Stolee
