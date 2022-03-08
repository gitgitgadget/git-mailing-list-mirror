Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A646C433F5
	for <git@archiver.kernel.org>; Tue,  8 Mar 2022 14:30:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347479AbiCHObi (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Mar 2022 09:31:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347473AbiCHObi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Mar 2022 09:31:38 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 072394BFE9
        for <git@vger.kernel.org>; Tue,  8 Mar 2022 06:30:42 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id x193so19034972oix.0
        for <git@vger.kernel.org>; Tue, 08 Mar 2022 06:30:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=rZq4iZPYPZOFk3xL4eKngUsxXmEJIOMF5KEG2vYCCJk=;
        b=Meg4OehfT/VNMmshNEGRT6FRLEeJ5m3GafvHPyykK4c8nt2P379AC1oofNdDynrHJL
         SJy3jFcqiREpc06pGNRYnfwq34WD6zi+hMzKzg6Bk2MBanUtMaRCDY8aBfSaC3jHUQQp
         FLIFu6brCoij8tS/Ue8CxI1xTcKEhMkB+jBH/VsBfebIXzjnt4YCIPvdki+u2GnXKwDA
         IfQUccCvLKDysDlFsmpIFnGL73hqroIE3mWWTsc//rkoA0OmoWxmEMdeB70s7/ivJFJ7
         qQmyIPy6hPiA/I7lGBKOqVh+exS+OKTSlRNquViSlk86uStsnrYd9XYoIoAgXSc47i1g
         pdug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=rZq4iZPYPZOFk3xL4eKngUsxXmEJIOMF5KEG2vYCCJk=;
        b=Z2Qu4DXsZlgkoxmiQWKSuXIctPngpYHIWPG+i4ZQI7/BVzWL5qsucwgtFqU3WsGMXB
         v8nKRQteDWuS15ND7hu9QQ0SbH5lNEA8A44I0a1rBcUj/KKXytaWgQ63tbzvYgtLfgqc
         LQLeKNdh/cqw4sVY5qv04vhEooP4KODYw1e1cnSjH/XcEh75lwS0QyOP+EwGn67TvtIE
         1OdMfCgYkePhrkWnEVxFylrb25LpTpdkoLwTs4tOSvkuNgb9O3pEkFewGLOdDpWsk+4c
         IT36c8HnInxGj3BLHWSevqdaRAgmA8sgJPH65a40NdiEMGZbvDSBhCPO8muqQw06Q4AF
         UG2A==
X-Gm-Message-State: AOAM530bsyp+BdOZc0slxeUduwGvqxtmktZ1i+wvZKCpiPkNwj1KcuGQ
        FNmzWJTp1H3Xfiuy55ywAKQP
X-Google-Smtp-Source: ABdhPJycjUG8HitqAwS/hb7eFzN48x0tjOSnBq8dONrRJgXzWdUwPpETawRhY2Du7461V80AdBANkw==
X-Received: by 2002:a05:6808:152c:b0:2d7:58b0:15b9 with SMTP id u44-20020a056808152c00b002d758b015b9mr2628016oiw.81.1646749841342;
        Tue, 08 Mar 2022 06:30:41 -0800 (PST)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id ec47-20020a0568708c2f00b000d9ca2e1904sm5914630oab.45.2022.03.08.06.30.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Mar 2022 06:30:40 -0800 (PST)
Message-ID: <5c59964a-a3ce-3723-8044-16727d9d3170@github.com>
Date:   Tue, 8 Mar 2022 09:30:39 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH 6/9] git-sparse-checkout.txt: add a new EXAMPLES section
Content-Language: en-US
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Victoria Dye <vdye@github.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Elijah Newren <newren@gmail.com>
References: <pull.1148.git.1646725188.gitgitgadget@gmail.com>
 <3265f41bcab7202991da5a7a160a85820fbff0c4.1646725188.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <3265f41bcab7202991da5a7a160a85820fbff0c4.1646725188.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/8/2022 2:39 AM, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
> 
> Since many users like to learn from examples, provide a section in the
> manual with example commands that would be used and a brief explanation
> of what each does.

Examples are great!
 
> +`git sparse-checkout reapply`::
> +
> +	It is possible for commands to update the working tree in a way
> +	that does not respect the selected sparsity directories, either
> +	because of special cases (such as hitting conflicts when
> +	merging/rebasing), or because some commands didn't fully support
> +	sparse checkouts (e.g. the old `recursive` merge backend had
> +	only limited support).  This command reapplies the existing
> +	sparse directory specifications to make the working directory
> +	match.

This focuses on how a Git command might cause extra data, but it
doesn't mention how other tools might create ignored files outside
of the sparse-checkout and this will clean them up. Do you want to
add that, or do you prefer focusing on just Git reasons?

Thanks,
-Stolee
