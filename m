Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E716C433EF
	for <git@archiver.kernel.org>; Mon,  6 Dec 2021 22:25:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353477AbhLFW3M (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Dec 2021 17:29:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242901AbhLFW3L (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Dec 2021 17:29:11 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51806C061746
        for <git@vger.kernel.org>; Mon,  6 Dec 2021 14:25:42 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id o4so11435965pfp.13
        for <git@vger.kernel.org>; Mon, 06 Dec 2021 14:25:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mv9M+kRDzI3sWX3FSjyrCCBhD1sE/qBGt4LLV5spvG0=;
        b=GfUX1uHyUaekBQmu2+xfWPBjzjnvcRPVOZBci7g0bn1mkjitGlstGsQgqQ2p7i1FAE
         SzLxpZbCTCaYXjxwG8m4Forq9WGO4bxvTJi94WXp9suYYgyobgr/66O09I12ArXsG1/B
         fbGm5dEaFA6/hhIu+GzX3/x7v6Wrlei1t979/juVKDs3KW/JAXKaFX5SqEjOU0ypDg0H
         g3TAyQQEry6MIdbRrdXNMOC71H+q6acaquVypQHz7ubMntQH4FLfX8F5FEdnuZKwgPpp
         SZWptOkhFHuAB4fwexIbggAXbABxd11aC27LD+O42LYGcN8MmeDoxrzFZBdexHVLc2no
         rwjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mv9M+kRDzI3sWX3FSjyrCCBhD1sE/qBGt4LLV5spvG0=;
        b=ztJyx7R+/FUEC1o84DQ5dqTu1FT4WSXZtRcW3FxOfyoQMubbJCpVI6cnPu+mRwvnMh
         /+EtmCjGmz0Yuv6WVxx8ed761t211ANPIxl3aWZyeDFtB+NAcXRE3pWxMsfj+cK52/a4
         KisNAHuiGFkWH35pKyRRcLMiUCAeDB29IxShx9o5hlkpp1e4VwcN0PZp9HKYUUdEiH6/
         sl5CeDknEZ02VChpaiTEL+l2Kqgal+CYoBGL77Fdu2xha5jiJrG4jxJ/3PmQodxM8YoX
         tZhNd7uFjzqyCN3npEVd+9kShEazwaW7UtidQlu5WxYDF6xpYwbvM3HhCWMGhcOH/p6S
         CsFQ==
X-Gm-Message-State: AOAM531ERrv4QKL+kBus5AqkmPysrbIbBrh0M0FoFo/5A+KyP+XHrrp+
        TyMJaxpy1shqGIQOKtHqIlM=
X-Google-Smtp-Source: ABdhPJxUHob76JZJ366WBEY1QPAFtrcVSQk/hFtOZ0ryAEtZUoVN0tOu3miAcU5mflEVmaJyVn1wsg==
X-Received: by 2002:a63:fd13:: with SMTP id d19mr12994743pgh.501.1638829541659;
        Mon, 06 Dec 2021 14:25:41 -0800 (PST)
Received: from neerajsi-x1.localdomain (c-24-56-226-231.customer.broadstripe.net. [24.56.226.231])
        by smtp.gmail.com with ESMTPSA id r16sm10828824pgk.45.2021.12.06.14.25.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 14:25:41 -0800 (PST)
Date:   Mon, 6 Dec 2021 14:25:39 -0800
From:   Neeraj Singh <nksingh85@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] git-compat-util(msvc): C11 does not imply support for
 zero-sized arrays
Message-ID: <20211206222539.GA27821@neerajsi-x1.localdomain>
References: <pull.1094.git.1638823724410.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.1094.git.1638823724410.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'm a little confused by this issue. Looks like an empty flex array
is supported here: https://godbolt.org/z/j3ndYTEfx. 
(Note that I'm passing /TC to force C compilation).

Also, heap_fsentry doesn't appear to use a flex array in current sources.

If it does start using it, there issue may actually be elsewhere besides
the struct definition (it could be just a badly targeted compiler error).
We have code like `struct heap_fsentry key[2];`.  That declaration can't
work with a flex array.

Thanks,
Neeraj
(wearing the ex-MSVC dev hat)
