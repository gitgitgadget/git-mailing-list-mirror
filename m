Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3601C433EF
	for <git@archiver.kernel.org>; Thu, 14 Jul 2022 19:47:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240711AbiGNTri (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jul 2022 15:47:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232415AbiGNTrh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jul 2022 15:47:37 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B5046BC3F
        for <git@vger.kernel.org>; Thu, 14 Jul 2022 12:47:36 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id o31-20020a17090a0a2200b001ef7bd037bbso4143055pjo.0
        for <git@vger.kernel.org>; Thu, 14 Jul 2022 12:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=UgblyLX+F6G6AH2EfiydlBVrFvVtThY5FJGaTV7+tj8=;
        b=GCA6gTFAk93DhsMKgbtTn0KdaYPElST1mNJrMVg1674LNJe7n4FMGGrciki/7A1HVU
         njVJPs7X48w7EcMhcZJ+N25qHaQhzKwEze1L6vE9CqX4wHC8tdZ5kb7zJaBTmBtD+8ae
         z+W77ENR78kp46Or3Er1kZAK9+dY8b7aL44DAe39kU17IDewXAcm9osio3BRDUVnDiV6
         YGiz//j1jLK+tjddIAUlvA4RQz/tWG3DDK8azaFstPpLBpZV7fTNfePP+hnlh+UOS97y
         07XEOc/8fnCgqtsRf1CY1cdnY1XFc6Jn8tCVWxYq113x0af3QivJF3o47AtrPqsKtXMg
         +xeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=UgblyLX+F6G6AH2EfiydlBVrFvVtThY5FJGaTV7+tj8=;
        b=K3TIfNlzFCT7liBtqy8Yn00AOKnsR1jX7Qc9dTcdhrKATuhVT9V7500QDnQcLa3I69
         9hAzr6lDpDOWETN04dt9iqmCGiUr57kI1XBLGvpnII5o/O61GGmUh1eWO1fl0Ir07qA6
         bsC9I13+bz6uObDwFXG9P6sIZrB6gY+w1E+OtXK/OJsjKTnLzWEeLWUJSn8efCKpgBGg
         ktIAh3zoDD5b0y9syHOav8PnqxZ81gX1WQXnQRMLJu7FovErhh0p40Q3RYpds6LfipSo
         aDB8V/SewV/d04de6Z/TQwXov9SfL6e0fSmbnF6qC/7YQRdXDBv3/tdmLdTNoWOXYGnv
         nvuw==
X-Gm-Message-State: AJIora8cjk5oVvICOgxBsgQ1Pj0WrkB9HWB8sgMXa0MUK/5aRdWCFxAW
        oxPAcAtXINoTryww4i0ov5IT
X-Google-Smtp-Source: AGRyM1sf9HH13kKbFTpQr4TwSBt6IEonjf8VLnxNUXirk8BOn3tQp6+OzoPq4uzpxFnZrmuKf5U0XQ==
X-Received: by 2002:a17:90a:7c05:b0:1ee:e40c:589b with SMTP id v5-20020a17090a7c0500b001eee40c589bmr11525454pjf.78.1657828056076;
        Thu, 14 Jul 2022 12:47:36 -0700 (PDT)
Received: from [192.168.0.104] (cpe-172-249-73-112.socal.res.rr.com. [172.249.73.112])
        by smtp.gmail.com with ESMTPSA id i6-20020a62c106000000b0052594a3ba89sm2100431pfg.65.2022.07.14.12.47.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jul 2022 12:47:35 -0700 (PDT)
Message-ID: <a1580785-e35c-9a2d-7fa1-c3d7fc62883b@github.com>
Date:   Thu, 14 Jul 2022 12:47:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: "reject arguments in cone-mode that look like patterns" doesn't
 work in macos-12
Content-Language: en-US
To:     fawaz ahmed0 <fawazahmed0@hotmail.com>,
        Git Mailing List <git@vger.kernel.org>
References: <BL0PR13MB42750BC5C4837B7B0BD1885EF1889@BL0PR13MB4275.namprd13.prod.outlook.com>
 <BL0PR13MB427533B25CCFE6A37F7619E8F1889@BL0PR13MB4275.namprd13.prod.outlook.com>
 <4f4d5d03-2a0d-19c1-fd2e-80ab86aa1145@github.com>
 <BL0PR13MB427538CEAD5481CCBF6D195DF1889@BL0PR13MB4275.namprd13.prod.outlook.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <BL0PR13MB427538CEAD5481CCBF6D195DF1889@BL0PR13MB4275.namprd13.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

fawaz ahmed0 wrote:

Hi Fawaz,

Please make sure you "Reply-all" to include the mailing list in the
discussion, and make sure to inline or bottom-post your replies.

> I assume it's v2.37, you can reproduce it on github actions macos 12.

Per the virtual environment specification [1] linked in the runner execution
[2], the Git version used on these agents is 2.36.1. 

[1] https://github.com/actions/virtual-environments/blob/macOS-12/20220627.3/images/macos/macos-12-Readme.md
[2] https://github.com/fawazahmed0/currency-api/runs/7312663698?check_suite_focus=true#step:1:11

> 
> My github actions workflow didn't fail, even when I was setting pattern in cone mode.
> 
> please see: https://github.com/fawazahmed0/currency-api/actions/runs/2660320076/workflow#L31

Based on the commands you linked, combined with the fact that cone mode was
not made the default until v2.37, you're setting a wildcard pattern in *non*
cone mode. If you want to use cone mode in version v2.36, try running 'git
sparse-checkout reapply --cone' after your clone to set the appropriate
config.

> 
> 
> 
> 
> From: Victoria Dye <vdye@github.com>
> Sent: Friday, July 15, 2022 12:48 AM
> To: fawaz ahmed0 <fawazahmed0@hotmail.com>; git@vger.kernel.org <git@vger.kernel.org>
> Subject: Re: "reject arguments in cone-mode that look like patterns" doesn't work in macos-12 
>  
> fawaz ahmed0 wrote:
>> Please refer: https://github.com/git/git/commit/8dd7c4739bded62175bea1f7518d993b39b51f90#commitcomment-78433458
>>
>>
>> Using patterns in cone mode should fail, but it doesn't seem to fail on macOS-12(github actions)
> 
> Can you confirm which version is being used on that MacOS agent? For
> example, you could add a call to 'git version' in the workflow and see what
> it prints out. I suspect that the agent may be using an older version of
> Git, which would mean that the sparse-checkout is initialized in *non* cone
> mode.
> 
> For what it's worth, my local development machine is also MacOS 12 (running
> Git v2.37), and I'm correctly seeing the error in a cone mode
> sparse-checkout.
> 
>>
>> Step to reproduce(try in macOS-12):
>>
>> git clone --filter=blob:none --no-checkout --depth 1 --sparse https://github.com/fawazahmed0/currency-api.git . 
>> git sparse-checkout add 'latest/*'
>>
>> Thanks
>> Fawaz Ahmed

