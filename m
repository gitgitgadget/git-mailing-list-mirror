Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D46AC433EF
	for <git@archiver.kernel.org>; Thu,  2 Dec 2021 08:42:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345572AbhLBIqK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Dec 2021 03:46:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbhLBIqJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Dec 2021 03:46:09 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E299EC061574
        for <git@vger.kernel.org>; Thu,  2 Dec 2021 00:42:47 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id m24so19712760pls.10
        for <git@vger.kernel.org>; Thu, 02 Dec 2021 00:42:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=S3xeJxUPcGUAA02ng8cP3MgvOzUoAQpFhaXdtKBYcpc=;
        b=mklCgJt9b976a4ghgXxWa8ojf7dSsRNfs5yjFWr43Q/R20prsRnFt5fJPZelzL6lDv
         Ui5Q1i2LVX/YrQwxAFJME0Ve8VN+XRcZa+LZAc5o7mc2BUfYA5V5mUHN4jyQo4nt1zTB
         auGWa929bjv7b3cmyOAsJlOmum0gNt1igwlmq3RHJ6leQojOQJwnVPfmGLx+hACxNp0j
         CFEmQJAGluHi5geUYVi+sJDVNJVuBs7xn94ualYBCaYMZM/9qPE6gmOjoz+qhH4+FfBf
         Ncm3lCxjIuvQcRxeEi0+avyzwX21mneol/qUzuKhyk7D5IQOEBFLXE57cIEacvBGG7/o
         WcPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=S3xeJxUPcGUAA02ng8cP3MgvOzUoAQpFhaXdtKBYcpc=;
        b=DDDqX85ZypOKqW/TLbp2+QmBLvkWSEtt4dru82KkD/CB2HHozuy8psBSXtowkQMHaK
         cD183iw14d2wYUb8taoh183Fc0RO2tXAO4ltAERPNRGHNV0MbWSZmFAZr/aD8eqlLkGI
         UB78WY1FzJttc9xgrWo51lbWL0v47qOGIxkd9nOfE2wtSR08xA/aB9z/aTMtG3D7fKqe
         EfYK1G7qewxqh3MB991nyvczCB6ATncGocnQAnX1Cxu4vBe1swJJY5dJjOIyZ8NudMIo
         wBv593Q71FdmBDwSt0v6Lz1F2Lnf4sWWa7eie1zBjpF/3yVMM7NKdvZTIDt3nd8K9AhV
         8pMQ==
X-Gm-Message-State: AOAM532JMlDkrQ7df+/Uzvtg3LITAEy8y15wpA3eli4DP8ngxMCRd+RY
        mBDgLIZQiOmifpcAIsyI5mc=
X-Google-Smtp-Source: ABdhPJy9dfnOQOOU3OUsXviqi6JUwH0m1/IVshFXmjdmkuoQdmYY0sI4EdqKNmsVqlzTyoQszfcmCw==
X-Received: by 2002:a17:902:ab0c:b0:142:343d:4548 with SMTP id ik12-20020a170902ab0c00b00142343d4548mr13792278plb.14.1638434567390;
        Thu, 02 Dec 2021 00:42:47 -0800 (PST)
Received: from [192.168.43.80] (subs02-180-214-232-84.three.co.id. [180.214.232.84])
        by smtp.gmail.com with ESMTPSA id ns21sm1830596pjb.37.2021.12.02.00.42.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Dec 2021 00:42:47 -0800 (PST)
Message-ID: <df70e408-9355-aff7-c6fe-540b5c687865@gmail.com>
Date:   Thu, 2 Dec 2021 15:42:42 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v5 2/2] update documentation for new zdiff3 conflictStyle
Content-Language: en-US
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Phillip Wood <phillip.wood123@gmail.com>
References: <pull.1036.v4.git.git.1637028785.gitgitgadget@gmail.com>
 <pull.1036.v5.git.git.1638317108.gitgitgadget@gmail.com>
 <409ae2bbd85c20a88347a4e1b8afdddcb7c82e5d.1638317108.git.gitgitgadget@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <409ae2bbd85c20a88347a4e1b8afdddcb7c82e5d.1638317108.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/12/21 07.05, Elijah Newren via GitGitGadget wrote:
>   	The same as `--merge` option above, but changes the way the
>   	conflicting hunks are presented, overriding the
>   	`merge.conflictStyle` configuration variable.  Possible values are
> -	"merge" (default) and "diff3" (in addition to what is shown by
> -	"merge" style, shows the original contents).
> +	"merge" (default), "diff3", and "zdiff3".
>   

Missing '... (the latter both also shows the original contents)'.

-- 
An old man doll... just what I always wanted! - Clara
