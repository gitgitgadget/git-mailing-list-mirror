Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B291C433EF
	for <git@archiver.kernel.org>; Mon, 23 May 2022 13:18:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235941AbiEWNSy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 May 2022 09:18:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236066AbiEWNSt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 May 2022 09:18:49 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C8632D1CF
        for <git@vger.kernel.org>; Mon, 23 May 2022 06:18:46 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id d198so10154506iof.12
        for <git@vger.kernel.org>; Mon, 23 May 2022 06:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=iokuru2tqfsGmLmgcU3upQFNKa+Le/yTR49yBuW6DF0=;
        b=IMleOqxy+J50DCOwS1EVxR7MCEhjz1ukYZ9ieIjaylbQHYNaVc9OHqCTUBxQOjwjde
         TqaCRHC6r+fKBKiB/U5o7vsX/FdGrtAE/6SvD1tJtPw7HBpUp93eQixHGHwTpzs3VE7y
         h6+8eDzA5qhxcjX1UuwWck1nEjjJ/TT7cO7Sd873t6+GrQYBLUa+ZFRJqtVRWtjkX2Pd
         bWPwoSeK4QuJtCkEhw67VMhFJc+jxiQDt3+Xn7UY146JM4kYoU7gFqqHQwVY2wI4o63n
         Y79yEtSQua+nRI3ayojalaTdmp+3ppC7kG3L+XrmQsWpl49w6/UWrOqvf5vxNRTkNM5x
         Xc/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=iokuru2tqfsGmLmgcU3upQFNKa+Le/yTR49yBuW6DF0=;
        b=mjQoamvatj7QQYpLTEj/0+ZYhZ9KIvhJlAIVqyL40tkxbnlHyUhZokaewtdbV0YI9d
         fzwtLVIUNQc64US/Lp/TeBr6qOOsYFmF7UlmeoookuzQSuGZpHKWr+M+fvEfBrQmYRH3
         byMtTBtlwesaC7Ym2PzMUSwM2WG4S8JcbO/HIKJCT+DSU5LY1Bg0hfAgdKIpxXsll3gY
         KkFNGthfQ/ZYRcsgCr8NSx+gnqZXqN4ZVgleAp2+oTms25QCuL00YM32bKafPBgR8nvT
         C4jpUDT2cXa5kXJ5iB5tcef0UhOR3Hr1VDRhRwii0SKXWELGSiU6ZQkgf4HAQfUIkJzz
         RzhA==
X-Gm-Message-State: AOAM532qcMGvFha53f04Ctv0zsFOa8i2sldxQNfub/xNuK7o1nb+GoVu
        DPS5H72odb3J9oSJFC+8Hsd9
X-Google-Smtp-Source: ABdhPJykCqOHlCjOnKqzf/3pivZL2e2DnrKyDGSAjsuf6LHkSVa6eK6k+kxXd7DgrBRwBIGq3lnvJA==
X-Received: by 2002:a02:aa04:0:b0:32e:c9f8:87ba with SMTP id r4-20020a02aa04000000b0032ec9f887bamr2433815jam.254.1653311925684;
        Mon, 23 May 2022 06:18:45 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:4800:d130:3923:6cc0? ([2600:1700:e72:80a0:4800:d130:3923:6cc0])
        by smtp.gmail.com with ESMTPSA id p13-20020a6b8d0d000000b0065e4641e78asm3475711iod.31.2022.05.23.06.18.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 May 2022 06:18:45 -0700 (PDT)
Message-ID: <f9abea8d-5386-5275-4de2-27d443945c7a@github.com>
Date:   Mon, 23 May 2022 09:18:43 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v2 08/10] sparse-index: complete partial expansion
Content-Language: en-US
From:   Derrick Stolee <derrickstolee@github.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, vdye@github.com, shaoxuan.yuan02@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.1208.git.1652724693.gitgitgadget@gmail.com>
 <pull.1208.v2.git.1652982758.gitgitgadget@gmail.com>
 <ed640e3645ba4f60f06bd335b9ac7bf350dd81f9.1652982759.git.gitgitgadget@gmail.com>
 <xmqqsfp3coqy.fsf@gitster.g>
 <5909f466-c323-0874-b175-51fe5e93dc12@github.com>
In-Reply-To: <5909f466-c323-0874-b175-51fe5e93dc12@github.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/23/2022 9:13 AM, Derrick Stolee wrote:
> On 5/21/2022 3:45 AM, Junio C Hamano wrote:
>> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

>> By the way, why are we passing the "--missing-ok" option to "git
>> write-tree" here?
>>
>>> +	cache_tree_update(istate, WRITE_TREE_MISSING_OK);
>>
>> The same question here.  We didn't say "missing trees are OK".  What
>> made it OK in this change?
>  
> Both of these additions of WRITE_TREE_MISSING_OK are not needed. I
> think I added them in an earlier version, thinking they were needed
> due to something in the Scalar functional tests. I confirmed just now
> that they are not needed for that. I will remove them.

As I went to remove these from sparse-index.c, I found another that
exists, but for good reason. See 8a96b9d0a (sparse-index: use
WRITE_TREE_MISSING_OK, 2021-09-08), which explains that that instance
needs the flag because it could be used during 'git add'.

It still isn't necessary in the instances being added here, so I will
remove them.

Thanks,
-Stolee
