Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA2FDC433EF
	for <git@archiver.kernel.org>; Mon, 14 Mar 2022 15:25:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241242AbiCNP0h (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Mar 2022 11:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238922AbiCNP0g (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Mar 2022 11:26:36 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 864AA193CE
        for <git@vger.kernel.org>; Mon, 14 Mar 2022 08:25:25 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id g6-20020a9d6486000000b005acf9a0b644so11990464otl.12
        for <git@vger.kernel.org>; Mon, 14 Mar 2022 08:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=NXKxptpe6BJMQRP9TxG3R5+s3ieD2dgQq6T8WnDg3Jc=;
        b=C7ZWzy4sBOc5QpDGnWhlHRhSLOE3Coo16fY2PpplhgUrv1/PS+rAopraxIMexuRhul
         zeJ3u0m/6C8SryDvYa84jKwb1l+MKJ6Oz5b//AWPPyJNf7uzURk35MYn/yRnevGF7VFt
         /3TVZFrrVm3yJTXFVd0nAWqIRSxr6ByA+xIKtGbpBPEB7bR00D+Hp6XemTdS0WWMrJ89
         vZa/m2KXHq4Xp9zHdQOJesDYmtxXaYDi+/zkzhb2daeyBh6IThpm8rThPVufZ7N5+X6Q
         pKXk/DJNZ68LLOvCver20giE0W6PcGjEECrhItF8H1fs3VU2MxdjkKk1qU41aI8Dejaw
         vy0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=NXKxptpe6BJMQRP9TxG3R5+s3ieD2dgQq6T8WnDg3Jc=;
        b=PSiNwnvSdhqVwLtjAL3sXtSQ4TwFJSrK3NXfeEcpSQZChX86nK9OC1NfahrGyOyH65
         PyQ8ePeAC0xjJO5dq+VBZ/9AuodQRBYg6i0KGN4azfIGV3VWRRRt7Y5ZMEIg/tVmzj6S
         CThvDhqx7l6ei6CiFqs5VbYlUFm8TYttdQKI1jJhzBe2i0W8yaom5pcsiNc78OdaAasQ
         ajyhRP8guwuwZC65l0A3fhbFOQf4jTBuj4+rUZbxY/A6Y83ZKUXfzbQpK9igtnD6Ees8
         Ov3FHE/V5/DMa05mpPFm+UKTbSwlHAf3uE3MmJ2qVsb94XvhudgYe+vuzBwi99/L0eIx
         JNew==
X-Gm-Message-State: AOAM533NQ532dOpSEV2Zq6XdxpxGYNQjlnRtcP2ZXU/WEE514eTcDOhY
        laKO14p1DAkRKcygkELk+ecM
X-Google-Smtp-Source: ABdhPJwO+1pNkGavlQE8beqAz/B/mX79GpfRE/L1GPj9BNcbBuLRWkHh2DRJ0oVSwMrRZGt1SQBF+w==
X-Received: by 2002:a9d:2a89:0:b0:5b2:5f48:f1f5 with SMTP id e9-20020a9d2a89000000b005b25f48f1f5mr11225478otb.125.1647271524685;
        Mon, 14 Mar 2022 08:25:24 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id f7-20020a056830264700b005b2503422d4sm7953476otu.81.2022.03.14.08.25.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Mar 2022 08:25:24 -0700 (PDT)
Message-ID: <af00cce6-262b-aebc-422d-4924df26f85a@github.com>
Date:   Mon, 14 Mar 2022 11:25:23 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 0/9] sparse-checkout: make cone mode the default
Content-Language: en-US
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Victoria Dye <vdye@github.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Elijah Newren <newren@gmail.com>
References: <pull.1148.git.1646725188.gitgitgadget@gmail.com>
 <pull.1148.v2.git.1647054681.gitgitgadget@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <pull.1148.v2.git.1647054681.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/11/2022 10:11 PM, Elijah Newren via GitGitGadget wrote:
> == Updates Log ==
> 
> Changes since v1:
> 
>  * rebased on master, to remove dependence on en/present-despite-skipped
>    (which has since merged to master). Earlier version of series wasn't
>    picked up anyway, so rebasing should be safe.
>  * Wording and code style tweaks suggested by Stolee in his review

Thanks for these updates. This version looks good to me.

Thanks,
-Stolee
