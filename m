Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABCABC433F5
	for <git@archiver.kernel.org>; Thu,  9 Dec 2021 09:28:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236161AbhLIJb6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Dec 2021 04:31:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236158AbhLIJb5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Dec 2021 04:31:57 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98448C061746
        for <git@vger.kernel.org>; Thu,  9 Dec 2021 01:28:24 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id h24so4004688pjq.2
        for <git@vger.kernel.org>; Thu, 09 Dec 2021 01:28:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=20qxQpaayxdoZKCc4hHhPkkHotN/xcjR7rzcsGJG5fg=;
        b=STgBvXan23YX39BQPZJ88glETSSWNBndYQs4tuU2u/bIUKIiafKWeS7O86IDWkpk1R
         MJjLmI2VAkNNHlD1asAd3jHkTVQ01wY2zQdkmJl7a9ZlGS0eKkjh0F7a8VPHh2cGEpRu
         ItTJqzQwnMMXAwEBlza4ZMQ3hbkxj6luLEI/tjaw4MFbDk3B9lGXGDpSNA9pj6vGEKcw
         AAH11aG8P92DAGIjtIubvpaHQHE3S4/qYs1x7MSwt40OmVj1WSOJMG/7S2H7Zk+HpsjU
         CzXzMWZfozmuQoKYL2F4doOg2Z7CW6nK3Nu2dmdmP5lVJ4zPI/Ngf4j4cYptzx1dTue4
         XgNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=20qxQpaayxdoZKCc4hHhPkkHotN/xcjR7rzcsGJG5fg=;
        b=tDO4L3I/nu6RNdUmNFiw78DCzdTce/XbvtK+dMwvFUqmskZN8gFUlSDghnSZNj7QmW
         7OnohtifyP8alEqhxGlD5797g7TtgND0OTvSmBRjMlgNVAIJqa3a4OQi7kky6h9sXX5D
         lJs8d9CpZnJWDyvvT35WAkJblQeWE0HxJImgVRsXSSjhj6ZB/SyenqA/+eF8t1M3CzBo
         d/EY3zZUnXRs7cv1Ml1Qs7vqIenrE08l2MO6+LYHOREff4hPy/93J81vkPrbDXjj0Vai
         XcygHb/OvCaIxdj7bQOGjdeqLm6oGTX1ELCcwbj17uw6hKKtL5fX4FkQhwHzKKVqjAdk
         PmQg==
X-Gm-Message-State: AOAM533ZtCFb3r9osmvHpmkVxH2Db/CHHKV6C5H0p9cEj/JQsik34mUC
        gBaHALj2/l5mI3dt21XO1b8=
X-Google-Smtp-Source: ABdhPJzNw36gYf1DkpKCSlddVB6tB8gGgtUgztyeZhDskjjiUbnzbPsOv/FgMW5QoYJySkcN15I8ZA==
X-Received: by 2002:a17:90a:a786:: with SMTP id f6mr14160919pjq.158.1639042104142;
        Thu, 09 Dec 2021 01:28:24 -0800 (PST)
Received: from [192.168.43.80] ([180.214.232.4])
        by smtp.gmail.com with ESMTPSA id y130sm6021248pfg.202.2021.12.09.01.28.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Dec 2021 01:28:23 -0800 (PST)
Message-ID: <1ad4a3ee-af05-9bb2-67fe-566d5e4c39a8@gmail.com>
Date:   Thu, 9 Dec 2021 16:28:14 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v19 1/3] doc: git-format-patch: describe the option
 --always
Content-Language: en-US
To:     =?UTF-8?B?5b6Q5rKb5paHIChBbGVlbikgdmlhIEdpdEdpdEdhZGdldA==?= 
        <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?B?QWxlZW4g5b6Q5rKb5paH?= <pwxu@coremail.cn>,
        Aleen <aleen42@vip.qq.com>
References: <pull.1076.v18.git.1638939946.gitgitgadget@gmail.com>
 <pull.1076.v19.git.1639034755.gitgitgadget@gmail.com>
 <a524ca6adfa2adc02e517b7be5199b0c071134c4.1639034755.git.gitgitgadget@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <a524ca6adfa2adc02e517b7be5199b0c071134c4.1639034755.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/12/21 14.25, 徐沛文 (Aleen) via GitGitGadget wrote:
> +--always::
> +	Include patches for commits that do not introduce any change,
> +	which are omitted by default.
> +

What about this wording below?

diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index be797d7a28..302659cfd5 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -193,8 +193,8 @@ will want to ensure that threading is disabled for `git send-email`.
  	ignored.
  
  --always::
-	Include patches for commits that do not introduce any change,
-	which are omitted by default.
+	Always generate patches, even if there are empty-change commits.
+	Default is to omit such commits.
  
  --cover-from-description=<mode>::
  	Controls which parts of the cover letter will be automatically


-- 
An old man doll... just what I always wanted! - Clara
