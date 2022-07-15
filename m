Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 426A2C433EF
	for <git@archiver.kernel.org>; Fri, 15 Jul 2022 16:54:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234359AbiGOQx7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Jul 2022 12:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234297AbiGOQxx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jul 2022 12:53:53 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D31513E23
        for <git@vger.kernel.org>; Fri, 15 Jul 2022 09:53:52 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id o21so3973645qkm.10
        for <git@vger.kernel.org>; Fri, 15 Jul 2022 09:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=N7xLzy72U5fZqgF2KhPFJwnJbXcrpQjqCey+zADby/s=;
        b=RlE9Hrzwg02OpTZU1ILTN670BIC7q0DR04Z4kX+dDMd8puL/L97gjjpki8n0niTQ/W
         86fDIuY2LmzajbPWlPgjI9bTVPj0GTw9kgY0giZ8+RSfSUTCrd0U0yn7Kc7jp9d/w5Fy
         pe/FbrYCrW+CXBJaX2saGu6bYQsoM3RghmtB9I/tzH3HyXcI3vhJ3qg0LrXu1dYAV5C9
         hMD4clDXH5rZE1pLlVXikS5oMVcGGT2ORHxLM4E/I/9f8P8cRxfaMMsrerPQc/Y2Psz9
         cvsdoUkmqICLFca2thbD2fL/J1535Wyo90yr7+v9j1SYmXTiZIrtNilkF6VuBtBSML7e
         t7NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=N7xLzy72U5fZqgF2KhPFJwnJbXcrpQjqCey+zADby/s=;
        b=AldSX+wBcvyrUFtNoqiViv3WNXTq9MZi1sUcU4uqFkAnizkMBeQH4lH9oCMcxIu+wu
         Tc1l1pB76OkcaoepAGV/PHfV768RX8o4c2wRYICmR7Gd9dgtrbrdzFWn6PYPBbfWs7m9
         16t1FToEz0l3mYN57xG8K95D6nQrDaUZhd7XKAZ7F8u0Pawc8slGLSZ1xp4leXlam7EH
         dR1Y5oRBZp/YkSQbZKE08Xbx1r/75gGLty0PzDSsf8tWOGK+3vCvmCsqaSxnR/c9SHrw
         IuvdMkbYWhPul1t4M7Br37cONCVc1Ac28MJtxenDrCOgtPdi9/mIw1YOV2Z4Ya8QAbrG
         tuIA==
X-Gm-Message-State: AJIora+uINsu8GLPHxvdGO74lovc2IDmj29olNsSAvGv1Z1fUEOoXgvT
        njAO4s3m2NhXw370kWKXcJYJ
X-Google-Smtp-Source: AGRyM1ui4xdXvnJdN0zkA5Pa/BsdRfhrySCf+OoJ/hptJ/mnGsx5HZCRH7wrkDxBY+Pylk4cPsSCQg==
X-Received: by 2002:a37:f90d:0:b0:6a5:b72e:d2c9 with SMTP id l13-20020a37f90d000000b006a5b72ed2c9mr10382529qkj.490.1657904031263;
        Fri, 15 Jul 2022 09:53:51 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:34ca:20bc:bde7:c407? ([2600:1700:e72:80a0:34ca:20bc:bde7:c407])
        by smtp.gmail.com with ESMTPSA id k7-20020a05620a414700b006b5ccec4121sm2995969qko.5.2022.07.15.09.53.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Jul 2022 09:53:51 -0700 (PDT)
Message-ID: <bb415e89-896d-b399-1e96-7ab1642ff3ec@github.com>
Date:   Fri, 15 Jul 2022 12:53:49 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 0/2] scalar: prepare documentation for future work
Content-Language: en-US
To:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, gitster@pobox.com,
        Victoria Dye <vdye@github.com>
References: <pull.1275.git.1656521925.gitgitgadget@gmail.com>
 <pull.1275.v2.git.1657584367.gitgitgadget@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <pull.1275.v2.git.1657584367.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/11/2022 8:06 PM, Victoria Dye via GitGitGadget wrote:
> 
> Changes since V1
> ================
> 
>  * Moved 'contrib/scalar/technical/scalar.txt' to
>    'Documentation/technical/scalar.txt'.
>  * Rephrased/removed references to Scalar being "built-in" to avoid
>    confusion with the 'git ' built-ins.
>  * Fixed line wrapping of bullet points in "Roadmap".
>  * Removed the "[RFC]" tag.

Sorry I'm late to respond. I added a reply to the v1 discussion,
but this v2 looks good to me. I'm looking forward to seeing your
next steps.

Thanks!
-Stolee
