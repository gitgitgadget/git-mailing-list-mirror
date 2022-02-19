Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00818C433EF
	for <git@archiver.kernel.org>; Sat, 19 Feb 2022 01:53:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236839AbiBSBx1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Feb 2022 20:53:27 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232650AbiBSBx0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Feb 2022 20:53:26 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D82E2192F2D
        for <git@vger.kernel.org>; Fri, 18 Feb 2022 17:53:08 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id u12so8454127plf.13
        for <git@vger.kernel.org>; Fri, 18 Feb 2022 17:53:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3scPUrNTQHe+A+MnKVMUzFKMXtcZWV9lidXLESm1qhw=;
        b=UiO2zZwZscYyPEL+T+zX0yBkbCQqPuGsZe379dEbIIkr3+1YyBiAbRYvzcOLxHhAaj
         rgKdExtpR5EX0CfpXyxkCjuzL2Yde/HfI9c0pnzyo9NbdC3r+yYYdQmM1uLnFJrxfvMO
         L1D9TYT/kisn9FM1tM1QR+WsaoQhn6h3AldA1Z9BwaB74KJLE0Yqch454Q6me9nkKHaj
         iAvD+LYElc7FYNrIfgCDL4yjoOdklzVo5sw+1qajwfshIAw6Y8ccrucrpyKR4Pcbemv+
         4GZ8FI557rc+0yooxIDmLbLeHIzqRf4bXSb3AKptK/7SvozUd2+wCnfQV8MjyXREq8Fy
         92nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3scPUrNTQHe+A+MnKVMUzFKMXtcZWV9lidXLESm1qhw=;
        b=vvyv8eB3SNMACYdO+N0Qk8f7+46ZgsFJb/k9ym0klytAFlJsaKa1eRKeKWF02D7RUu
         EJyf2sOf0mg+zGT8BloO3By8T/C7m/+KSMUcptcNaEHWcLpwe1QCn0Z38nwAnqBfxig7
         eZk0RtDoEo6QjShdbUlASbAeeKimihKRF+terSYjKbIjGGeM4OGLJHVh6lEmMCZiQ0wI
         DCpRZNfuvWLvKMfEIGEVFhe5QJhwVUo2JFyWlOZCFOuLKrycnn+pUauZZ/xEzvVp2n+H
         n6hMEkmihA9f59yM+MtuNRmVDJdv9lsA0szpl1M8L3/a4+Qf6KOPUsdQweP1qjXeWDAl
         oDKQ==
X-Gm-Message-State: AOAM5338pSp2ueqMM/TISDsmtTJ5XciBrFMv0BmROHo/+/9rZOj5iQWQ
        FoYEr3W0tseCmUariPoYyUM=
X-Google-Smtp-Source: ABdhPJxdunyqJAOgeI+ghqs2+tm+w2bxjEm75sCEFp7gtfe+12fKeUeg/uaEPrGQbaihpkJQzA2FQQ==
X-Received: by 2002:a17:903:22d1:b0:14a:1b37:9f2b with SMTP id y17-20020a17090322d100b0014a1b379f2bmr10155350plg.85.1645235588266;
        Fri, 18 Feb 2022 17:53:08 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:ff0a:b48a:1cb8:3654])
        by smtp.gmail.com with ESMTPSA id e30sm11559198pge.34.2022.02.18.17.53.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 17:53:07 -0800 (PST)
Date:   Fri, 18 Feb 2022 17:53:05 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: en/present-despite-skipped (Re: What's cooking in git.git (Feb 2022,
 #05; Thu, 17))
Message-ID: <YhBNgUFnujFGVcRo@google.com>
References: <xmqqley93rkw.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqley93rkw.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Junio C Hamano wrote:

> * en/present-despite-skipped (2022-01-14) 6 commits
>   (merged to 'next' on 2022-02-15 at 960873fdad)
>  + Accelerate clear_skip_worktree_from_present_files() by caching
>  + Update documentation related to sparsity and the skip-worktree bit
>  + repo_read_index: clear SKIP_WORKTREE bit from files present in worktree
>  + unpack-trees: fix accidental loss of user changes
>  + t1011: add testcase demonstrating accidental loss of user modifications
>  + Merge branch 'vd/sparse-clean-etc' into en/present-despite-skipped
>
>  In sparse-checkouts, files mis-marked as missing from the working tree
>  could lead to later problems.  Such files were hard to discover, and
>  harder to correct.  Automatically detecting and correcting the marking
>  of such files has been added to avoid these problems.
>
>  Will merge to 'master'.
>  cf. <20220204081336.3194538-1-newren@gmail.com>
>  source: <pull.1114.v2.git.1642175983.gitgitgadget@gmail.com>

I'd recommend holding off on merging to 'master' for now, until we
figure out what to do about
https://lore.kernel.org/git/YhBCsg2DCEd9FXjE@google.com/. Hopefully that
won't take long.

Thanks,
Jonathan
