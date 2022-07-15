Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8907BC433EF
	for <git@archiver.kernel.org>; Fri, 15 Jul 2022 03:21:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241309AbiGODU7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jul 2022 23:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241304AbiGODU5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jul 2022 23:20:57 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 846AA76E97
        for <git@vger.kernel.org>; Thu, 14 Jul 2022 20:20:56 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id m20so1954381ili.3
        for <git@vger.kernel.org>; Thu, 14 Jul 2022 20:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=iDcB9jK9bmgj2r/tPZva+Fft6+wKdzPZ7YbaKJ2wL8c=;
        b=Wsn6J83Mk0Uh8Z7L3uieIJfCItH85mYktKtW+mS6lhfmixk8VDXifvaV9iAMZa3aEe
         Cc+IJzTPVC6thsG06KG39s9Y5I4FeP8DCzEkmTqeUCaIRhPCtyLkt7BByesHuxJlsyPE
         PTkgsAm94Dv7mVGgIhmnS5ekxJfeudvyUdiQbKcCKKNaDi2GwiKoE9dPZhhOr6P/O9k+
         lnQZiSN7HgiWkAaFP/kHZ7QwtIVZltGCmVteG1tMo9fyZam/YaqKu6HXYY2APLD1RoEw
         MviF9FA+j4CvEYFGnRoBQt6aQV8FFZ9FL0/AqpWjbHzhj0mlDH8x4q/neGeQiRs0DA1o
         84+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=iDcB9jK9bmgj2r/tPZva+Fft6+wKdzPZ7YbaKJ2wL8c=;
        b=GTE09SdiyCKwTGy+eC9+OyKPFp6GYO3eDhFe92/pZJbmYSKYSHriQ5C+aB52ik2NOH
         I0TOc2vXI9QVtxX/OHT53FhhhHLrMJRdGVBjpWQjJEMpY1b+CSS9roZQrHUNlFYyG6ZH
         ByTOFUBCc+8ttpjcRcHBzw9XQJYGVbKdfKYSete6PRaU90CLXgzPS48Zh48A9HwA0jqk
         PqZ8wjt/8JdQ1TfezU90k4yVhE7wj/H0YzJ3tGkoCVNcySIA/HtFylaIpoG5NYQEZpgR
         +9CvsyU0D0kPMqyBrszyUMduAOWbXGdFzUCu+e329k0CVrvjJJDCL/ikWYgmBA9sFdMx
         +bbQ==
X-Gm-Message-State: AJIora+FYCHXVwnrtlcBzNYXkCnJ/uQVwPQqi2c0HQ1vve+jDoj5GzI2
        lHCtmfKyOfYMiy1Z2E/GLiZG
X-Google-Smtp-Source: AGRyM1u+02r6ScSin+g6slzkNURRIHkEwt9ErA7VIH04cLyNLSG5MW+XtZhV1hVZg0BZ+pxZ2qK1ag==
X-Received: by 2002:a05:6e02:19cc:b0:2db:f05e:676c with SMTP id r12-20020a056e0219cc00b002dbf05e676cmr5783069ill.212.1657855255890;
        Thu, 14 Jul 2022 20:20:55 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:a446:d79d:69be:6b29? ([2600:1700:e72:80a0:a446:d79d:69be:6b29])
        by smtp.gmail.com with ESMTPSA id ay8-20020a5d9d88000000b0067bce43163esm1293031iob.42.2022.07.14.20.20.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jul 2022 20:20:55 -0700 (PDT)
Message-ID: <14325f93-051a-c286-9dc4-1a2762554a27@github.com>
Date:   Thu, 14 Jul 2022 23:20:54 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 0/3] commit-graph: fix corruption during generation v2
 upgrade
Content-Language: en-US
To:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, ps@pks.im, wfc@wfchandler.org
References: <cover.1657667404.git.me@ttaylorr.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <cover.1657667404.git.me@ttaylorr.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/12/2022 7:10 PM, Taylor Blau wrote:
> This brief series resolves a bug where a commit-graph would become
> corrupt when upgrading from generation number v1 to v2, as originally
> reported in [1].
> 
> Some speculation occurred as to what might be causing that bug in the
> thread beginning at [1], until the problem was explained in more detail
> by Will Chandler in [2].
> 
> The crux of the issue, as is described in [2] and [3], is that the
> commit_graph_data slab is reused for read and write operations involving
> the commit-graph, leading to situations where data computed in
> preparation of a write is clobbered by a read of existing data.
> 
> The first patch demonstrates the issue, and the second patch prepares to
> fix it by introducing a helper function. The crux of the issue is
> described and fixed in the third patch.

Thanks, all, for identifying the scenario that causes this breakage.
It was frustrating that we had reports of corruption without knowing
where it was coming from.

This solution looks like the best we can do right now, although it
hints that some refactoring would be good to distinguish between
"commits as read" and "commits to be written" during this upgrade
phase. Something to think about, but not to block this fix.

Thanks,
-Stolee
