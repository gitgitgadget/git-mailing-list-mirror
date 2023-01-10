Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D710C61DB3
	for <git@archiver.kernel.org>; Tue, 10 Jan 2023 22:45:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234830AbjAJWpB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Jan 2023 17:45:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234489AbjAJWo7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jan 2023 17:44:59 -0500
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78E715EC02
        for <git@vger.kernel.org>; Tue, 10 Jan 2023 14:44:58 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id l18so8735021qvt.13
        for <git@vger.kernel.org>; Tue, 10 Jan 2023 14:44:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KDiA+pozdKv/9ZaKf/r/GdOsslImxB8W+LL1WM5E8eg=;
        b=TYnrc/WsEUWwPb+SsFrPtNmPmQ2tpgie/5iBmEAHwFagiUxPXYMHFiGuw22Ktt1wIi
         3exVHwIE9ubbkFI4Wkc2ie5mr3T+vK+m3oirj7IQl1kmNafBMDCABBCcT/9WmuAxVoBm
         4wTmJiNq6oCcGaWqkjB/8CS5DKrMZkLn2gmvgfh1NvYjFHgZbTD37hZr9yMrNtoYr85P
         l2p28D9MzjxktkR60c4OptQ1FLga0c6qZamIDdPnFJmP5QkzC4DCNdrb+3HsAnLUUw9F
         WCcKvfkcj5FdE1jpRPYAsupcUsT/cHRc7eQqOxT0JcfttNPtACUzCEEe6hvK/zSdOt2k
         Moxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KDiA+pozdKv/9ZaKf/r/GdOsslImxB8W+LL1WM5E8eg=;
        b=x3TKqHIIaRCn+JqVO88e8EmkFicLJChnymXzgN6tfPAc6PIlpolj+CtXBN/8ll8Ufl
         PMmIYM5HqOtYa8QWRa5gjcc0t+d6CLHrk9+cDZLepHR/lDeRzcB5AQD5eoZWpol7LYgI
         c8KIeA2dM+uNHGpPePEqM+JxvpSTu/2zFaI1OVucvjDkT7LRY3cFEBY76qP+Vxo4dAM8
         lX/bcu70UJ/jfxr3CDkFnPvNJl+kMNER0ZwONcGZTQx5j9gwiLnUlJYP2qTB5vRF3ClS
         H5CfFHD01TbRYWt9tL0qR0OXst/rKsChV7xxd/ZuxbZBQBSa08YNzab5bcmJ4mU7Ku81
         2ppQ==
X-Gm-Message-State: AFqh2kpULXEjDFoaC9SVAvB69keR6OcnplYwb/CZmNApdGnQa7ksKh4e
        GERIGnsdp8oD9WX7E35TBrYE0c6oSCI=
X-Google-Smtp-Source: AMrXdXvD9+JCGwRdj5wHST1vv/7RMeGtW38a12JpKHKuOKzzLVgPqVWpvZ09LpH1SUb+M3aXHUdiQw==
X-Received: by 2002:ad4:4f14:0:b0:532:2a64:80d3 with SMTP id fb20-20020ad44f14000000b005322a6480d3mr14146231qvb.24.1673390697362;
        Tue, 10 Jan 2023 14:44:57 -0800 (PST)
Received: from [192.168.1.127] (173-246-5-136.qc.cable.ebox.net. [173.246.5.136])
        by smtp.gmail.com with ESMTPSA id cx15-20020a05620a51cf00b00704c62638f4sm7813106qkb.89.2023.01.10.14.44.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jan 2023 14:44:56 -0800 (PST)
Subject: pb/doc-orig-head (was: Re: What's cooking in git.git (Jan 2023, #03;
 Mon, 9))
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqlembu551.fsf@gitster.g>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <a7aa0282-ef3a-0165-dd7c-8a4b004e53f1@gmail.com>
Date:   Tue, 10 Jan 2023 17:44:55 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <xmqqlembu551.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

Le 2023-01-09 à 09:58, Junio C Hamano a écrit :
> * pb/doc-orig-head (2023-01-08) 5 commits
>  - git-rebase.txt: add a note about 'ORIG_HEAD' being overwritten
>  - revisions.txt: be explicit about commands writing 'ORIG_HEAD'
>  - git-merge.txt: mention 'ORIG_HEAD' in the Description
>  - git-reset.txt: mention 'ORIG_HEAD' in the Description
>  - git-cherry-pick.txt: do not use 'ORIG_HEAD' in example
> 
>  Document ORIG_HEAD a bit more.
> 
>  Will merge to 'next'?
>  source: <pull.1456.git.1673120359.gitgitgadget@gmail.com>

I've sent a v2 with an added link to the mailing list thread
that initiated the series.
