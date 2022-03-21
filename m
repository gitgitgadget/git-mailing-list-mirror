Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE7ABC433F5
	for <git@archiver.kernel.org>; Mon, 21 Mar 2022 15:26:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234507AbiCUP1s (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Mar 2022 11:27:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348839AbiCUP1o (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Mar 2022 11:27:44 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DC7FC3375
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 08:26:19 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id j83so16567749oih.6
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 08:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=C9LUQQ/ZvFAUW99p7yGBVAHwiPxmFMXtzBbk6KY272s=;
        b=V8+RyK6oTK4Epq2UrauukbPRDO5emQh/SRf1U+owwbEXKIawl3mopBK67rtOZE0J6R
         pwkfPvRpjubYkPBKlrR/H1NnYZXMX3lsWRa3HJaWFPIIwuTqWZ5Xhd8qUnQdfhKSaPYF
         FQ+s03nznmeCimgszN6UZg8h7JfqeRJCE3mHS7FaxjVU6513pzhiajekv/6hlznyWUVl
         A0K+bUksq8x+4eLJB9GYG1ydRXzKMiFp+N2BX2R+Uawigw9LvLQmxeZsZYjNXsstYMNm
         ty/00UKDP+dmx92u/Dh94FX3GPm9GPUmsgnluAJ6GjfemMcLEesYn9qRxo66HBcsAsVR
         9ByQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=C9LUQQ/ZvFAUW99p7yGBVAHwiPxmFMXtzBbk6KY272s=;
        b=hESpKMFDW7bCis3ygEPzvTbmSVgOs4uW4AgUpkpX1NoEKRoXif35OmiSdqZP+7i1Eb
         cq8uV301Jp0rAwWKyWViqWutt9E/B+BCwHwnzfJ5g1Ar5mXJg1FRkzcMCJjNIskwNtZP
         CY3f09b4Wt5coHl4iJFQPrL0tFlam0avspEuRTI0LC7DBIyYAGJ1wQ7VjVgSrlIIulKZ
         +PR+Fv5Fa2ZDeJ1BFb842lJcvq9q/mcHad9RIlDfjPeU1lTEw5SSIuAFRHrclFX4A1TW
         bmg8kr6ddM4B0KzYqngJxpdY4YmWvmlU932cL2klbZwsNPXMZ9DbdcoZoTyY7aQdapm8
         5jPw==
X-Gm-Message-State: AOAM533i2UVcS+X1npnDrgr9IY6wZAl+HhBWq6p6zwACTnZUvdVmiuSd
        CbSH4q7dECRCpeG+duNLhKvC
X-Google-Smtp-Source: ABdhPJwC569IVmYzBeFbLUboh9kzC8FuOMFnQpyPDSiSpLpDE/JfRykJo3shRs96iltdpkcVfd3Wrw==
X-Received: by 2002:a05:6808:1c3:b0:2ec:c493:cabe with SMTP id x3-20020a05680801c300b002ecc493cabemr13894733oic.190.1647876378572;
        Mon, 21 Mar 2022 08:26:18 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id 4-20020a4ae1a4000000b003215cb3d53dsm6723936ooy.4.2022.03.21.08.26.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Mar 2022 08:26:18 -0700 (PDT)
Message-ID: <8b6b7c0f-0c49-5348-8b46-41f0dba334eb@github.com>
Date:   Mon, 21 Mar 2022 11:26:14 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2] partial-clone: add a partial-clone test case
Content-Language: en-US
To:     Abhradeep Chakraborty via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
References: <pull.1175.git.1647193162570.gitgitgadget@gmail.com>
 <pull.1175.v2.git.1647423969576.gitgitgadget@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <pull.1175.v2.git.1647423969576.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/16/2022 5:46 AM, Abhradeep Chakraborty via GitGitGadget wrote:
> From: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
> 
> In a blobless-cloned repo, `git log --follow -- <path>` (`<path>` have
> an exact OID rename) shouldn't download blob of the file from where the
> new file is renamed.
> 
> Add a test case to verify it.
> 
> Signed-off-by: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
> ---
>     partial-clone: add a partial-clone test case
>     
>     changes since v1:
>     
>      1. remove the event track method to detect the downloading as it is not
>         future proof ( and buggy).
>      2. Instead see if the file is missing initially and after running the
>         git log --follow ... command.

> +test_expect_success 'exact rename does not need to fetch the blob lazily' '
> +	rm -rf repo partial.git &&
> +	test_create_repo repo &&
> +	content="some dummy content" &&
> +	test_commit -C repo create-a-file file.txt "$content" &&
> +	git -C repo mv file.txt new-file.txt &&
> +	git -C repo commit -m rename-the-file &&
> +	FILE_HASH=$(git -C repo rev-parse HEAD:new-file.txt) &&
> +	test_config -C repo uploadpack.allowfilter 1 &&
> +	test_config -C repo uploadpack.allowanysha1inwant 1 &&
> +
> +	git clone --filter=blob:none --bare "file://$(pwd)/repo" partial.git &&
> +	git -C partial.git rev-list --objects --missing=print HEAD >out &&
> +	grep "[?]$FILE_HASH" out &&
> +	git -C partial.git log --follow -- new-file.txt &&
> +	git -C partial.git rev-list --objects --missing=print HEAD >out &&
> +	grep "[?]$FILE_HASH" out
> +'
> +

Thanks for taking the feedback and turning it into a good test!

I'm adding it as a TODO to go fix the buggy helper as discussed.

Thanks,
-Stolee
