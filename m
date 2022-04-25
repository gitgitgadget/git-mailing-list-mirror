Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76155C433EF
	for <git@archiver.kernel.org>; Mon, 25 Apr 2022 14:38:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231355AbiDYOl5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Apr 2022 10:41:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiDYOl4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Apr 2022 10:41:56 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22C991E8
        for <git@vger.kernel.org>; Mon, 25 Apr 2022 07:38:49 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id n134so16025977iod.5
        for <git@vger.kernel.org>; Mon, 25 Apr 2022 07:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=z9kCl3sv6xWLWEZg0lAkWU+t2iO8eG7VA27caOvMCRM=;
        b=ML2I82XRWPetu9BsRDeRoCzZGtZL+WeNwL0zALYHshjhU3njGUV0VLsT628ij0xeEN
         +Y+L/JaJrAEkrTmjo02FRXegknDbN1k3HUjNIPPOvxqAoMgzOVMZEUPi5BpdhlxZUT6B
         UG/QqQt1KVAMErcdPWOqT1m4HF08iHWvW8IrKiUmZAlxqOFzzBkPr/lt0Asd45pgIua+
         d6FuaG2S2hkv7wcLX14uxy2ySb5Dkt4CJDDXYAeauTopLHCw7oZ/1PfQo9mkzQeXeBg7
         BIz00GoAKjIAfJ4lViQ4Q/uH4ENWlyErVi14wMZshwPPJDXnIxgUwsUnJlmXuyUQ8/eC
         6Jvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=z9kCl3sv6xWLWEZg0lAkWU+t2iO8eG7VA27caOvMCRM=;
        b=K4Pdn+/UsguqBsexvnQx+CE25hhqLvAvrpqSbDuHMbtqSMUklsdrb82CiFd4QFjoZU
         +bawUsQ2pd3VhCDwbEbvME1ZeBom3jsKbnz8Fp96wU04equj3JsIvdHLNf1pcLFjdWWQ
         isptS3e1y4WrNW8cG+tX51+K3Vn9YrOTJqXovh3oonCK+c7ZIRbd95XCdFy4vhiIW+ho
         PhRdj6IVflA2gmGTScc8vNTo79imr/haogzbBy6IyN3r23pXojoK3EIn7T3j9RZ1f9uK
         +pnDw31EJDGnyCCv1i16AcGufc3RP+FQAsP+aKMZtKO4+RDpiKYscKKKQSmYYCdo/NxC
         +QCw==
X-Gm-Message-State: AOAM531smSIko3UI+FWbjameJ+c2kVb4YPlygmpbXqdpANdwT1cYP6hG
        dWwPFFdqAksu/mOFYdZldxgV
X-Google-Smtp-Source: ABdhPJwO39kJIyAykG0kYHEFZfSBe+oaPXkh/DvqH7aXj2P+uzdTjGvX0OuxN6a6pf675z4R55ln8g==
X-Received: by 2002:a05:6602:2c0d:b0:60f:6ac8:ad05 with SMTP id w13-20020a0566022c0d00b0060f6ac8ad05mr6890118iov.175.1650897528594;
        Mon, 25 Apr 2022 07:38:48 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:4871:ef58:9390:6a00? ([2600:1700:e72:80a0:4871:ef58:9390:6a00])
        by smtp.gmail.com with ESMTPSA id g5-20020a5d8c85000000b0065726e18c0csm7625960ion.22.2022.04.25.07.38.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Apr 2022 07:38:48 -0700 (PDT)
Message-ID: <c64eb904-1524-c44d-4d1c-6289becebf63@github.com>
Date:   Mon, 25 Apr 2022 10:38:45 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v3 0/9] sparse-checkout: make cone mode the default
Content-Language: en-US
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Victoria Dye <vdye@github.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Elijah Newren <newren@gmail.com>
References: <pull.1148.v2.git.1647054681.gitgitgadget@gmail.com>
 <pull.1148.v3.git.1650594746.gitgitgadget@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <pull.1148.v3.git.1650594746.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/21/2022 10:32 PM, Elijah Newren via GitGitGadget wrote:
> Sorry for the long delay since v1. On the plus side, perhaps there will be a
> longer feedback period for this series since it's now really early in the
> 2.37 series?

Yes, a merge early in the cycle would be good for feedback, if any.

> == Updates Log ==
> 
> Changes since v2:
> 
>  * Code style tweak suggested by Junio in one area, reverting back to v1.
>  * Several documentation updates to address Junio's review. Patches 6 & 7
>    had significant changes and would most benefit from a further review.

I took a quick scan of the range-diff, and read patches 6 and 7
on their own. This version looks good to me.

Thanks,
-Stolee
