Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8A21CCA47C
	for <git@archiver.kernel.org>; Thu,  2 Jun 2022 14:00:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235684AbiFBOA3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Jun 2022 10:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235649AbiFBOA1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Jun 2022 10:00:27 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD892296300
        for <git@vger.kernel.org>; Thu,  2 Jun 2022 07:00:26 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id 2so4861103iou.5
        for <git@vger.kernel.org>; Thu, 02 Jun 2022 07:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=WicDmpoOsrzukFjkitbC66HoMUYDfsF7MSRgjslMc/Q=;
        b=ccQ0riz9Ov3OLn+FduafAGwhQzz4Q2LaxUwKM/fauY4m0BUowCSt8RvRdRbUi7655a
         vFfwwRBn1FU0WWohsACz02N//jZ/GnvDn68hE0OPAHpaL5coyxAiXkZieRleD4sY/YKH
         y34FpsfoWqkFkBF7C6dijrjwcM4LtNkkiVA47kkPrQ5fG67O0sawA7peXskfITexv6In
         cOBiYHekQt6CQj6T4hieoKJH5BiqF4OWTOWXjfMJXrkYAcprp3OK9VizvDJL7nfkFNAc
         DLKDhCSP0ANWUuNF/7jIcOipacW7JxflOrKVu30fWrNVqA5gLiSV4MptB959s8vjpB0v
         iG5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=WicDmpoOsrzukFjkitbC66HoMUYDfsF7MSRgjslMc/Q=;
        b=mtf6tayqOYw5yf2DmN9g7DwnWwfuITVeX1NTg0LUBv2KB+bFXIro5kOsk52N3kdk/2
         HzY5GBmx1Ok98o5OAEUtUWXtFO1R2uvzeLFu/CQOQNO8ViM6WEVO7n3Rhz7BwcOoFIcj
         mGiAi/TsoPEKZBUHtZ3VjabOpBGuJLp2t9rSwZP8JtbeebILi70pgpTee/kt0wkxQ+ft
         cOPxRJDR1ff+Q4gD2ZRX3hA91WnLbzil9RBGNArp+7hGZgIkNAQtXydsAxlU3x3cSKXC
         1RQjg8msbVrBWU5+ONdbTxI4+KBa47EKZYrSYBXXwqjvr9Q28ZtAGRnp9Vhck+4JiKmx
         IhCA==
X-Gm-Message-State: AOAM532DpmOMQ6A1VFw0pu0obHSi5Cxot/foJjD7E/qnHjYHhl0aJT35
        khD+/6yaGi4ZNLYTS8eXi9LY
X-Google-Smtp-Source: ABdhPJxdLZBkFlIKIMT0zC7oOeSeB53DuwFDIo7hz+q/Iq1Db79yktvg9mtBIB30LpY/HNQAHkkpMg==
X-Received: by 2002:a05:6638:b81:b0:32e:5009:192d with SMTP id b1-20020a0566380b8100b0032e5009192dmr3076525jad.28.1654178426153;
        Thu, 02 Jun 2022 07:00:26 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:9cc9:fda3:3ddf:6700? ([2600:1700:e72:80a0:9cc9:fda3:3ddf:6700])
        by smtp.gmail.com with ESMTPSA id d11-20020a92d78b000000b002d3a77b2b40sm1420095iln.11.2022.06.02.07.00.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jun 2022 07:00:25 -0700 (PDT)
Message-ID: <d0448d28-b33c-3f42-901d-3cd7f4201c78@github.com>
Date:   Thu, 2 Jun 2022 10:00:24 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 0/2] Integrate Scalar into the CI builds
Content-Language: en-US
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.1129.git.1654160735.gitgitgadget@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <pull.1129.git.1654160735.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/2/2022 5:05 AM, Johannes Schindelin via GitGitGadget wrote:
> During the review of the initial Scalar patch series, it was suggested to
> include Scalar in Git's CI builds. Due to some conflicts, this was postponed
> to a later patch series: This patch series.

It's good to start running Scalar builds and tests during CI before
moving from contrib/. We can establish a pattern that the code is
not causing build failures, and demonstrate that the tests succeed
consistently. Better to do that while still in the mode where we can
easily reverse course.
 
> Note that the changes to the GitHub workflow are somewhat transient in
> nature: Based on the feedback I received on the Git mailing list, I see some
> appetite for turning Scalar into a full-fledged top-level command in Git,
> similar to gitk. Therefore my current plan is to do exactly that in the end
> (and I already have patches lined up to that end). This will essentially
> revert the ci/run-build-and-tests.sh change in this patch series.

I expect that this won't be a full remote, since we will still want to
exclude Scalar from the build without INCLUDE_SCALAR enabled.

Thanks,
-Stolee
