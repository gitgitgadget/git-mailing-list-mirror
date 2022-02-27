Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33499C433F5
	for <git@archiver.kernel.org>; Sun, 27 Feb 2022 04:29:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbiB0EaD (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 26 Feb 2022 23:30:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbiB0E3u (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Feb 2022 23:29:50 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AA52C4B
        for <git@vger.kernel.org>; Sat, 26 Feb 2022 20:29:13 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id j10-20020a17090a94ca00b001bc2a9596f6so8420855pjw.5
        for <git@vger.kernel.org>; Sat, 26 Feb 2022 20:29:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=QFRvOGQqAUpb+UUXOPfB7WArnnEr+JVLq4SlCpqDDm8=;
        b=YjGalBjlJKSc3w0LfS3DhHz5hJtGquM4VEXgtoWOE97IsdlNNbEE+hTANu2l9HkSfb
         HGult/bslIK6reTGM4iHbP5hnFp/0x8YYI+PRBHRNTl3STO+wOgV2z8ZV3QWEf2ZCMTv
         ZjmpEavri0ZL2/IL2kEGEbxSXJMVm72vS57QSpgat7MYNAmaS8Td3tPs6S1bGkZygkWz
         OzrgIAUFHX2/xeMQzRAsDq2Taxrt0yQWSuXdtsa4Lf9rF7x/xHaS4NrlLyzzhyS+f6G+
         Z8mzioCN5ijcvmAAf8oV4py+ScmNY+pmbPdM+cPWEUTFcyd9nJGlXp3vuuRI/ypI6kRy
         +tug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=QFRvOGQqAUpb+UUXOPfB7WArnnEr+JVLq4SlCpqDDm8=;
        b=0EWgvIdATxbt8/YXfjm7Un6jqxkYzErXNbynHQZv3HkJ5MlFe4WKf9dHdWvR8Fct0z
         MkLvL9zQDr19Bu/N+fjUOBDG5O4w24ruL17hE9SBwCVt756r+2/KLn1P4KcaEthLBtjs
         pay2XvhT4VRrxLAJBWx378sXV48bXa4dsKTh44HPsdcMfDDOmDK58yTjSnDTkLp7lzcM
         VVlmK/FJMyoSswbP/L+lp1C09neAmfc+v9z+0Lu78kw7oAvPcppPYBHdGMGHvch5KTjl
         LPVUlP4PhLaU7pz+BJx4l96b2U27BbsQNTPgQdrbYEFZ9marzCO216Y85Mo38mg9bK5t
         s1xg==
X-Gm-Message-State: AOAM533lLeMH7EmYjDicFzGoz0NwElU1QuSl7nB/+hZx2yRfXGlfX6+w
        O2fYv8ka1IsSvZAe2Sk/4NI=
X-Google-Smtp-Source: ABdhPJxSJ04w5uPSBe+mpex1wj+zSxnAcPg9rXFOyB/huYmdUKGn/ZncTWh0aB9HlFWCkjU07gGdow==
X-Received: by 2002:a17:902:dacd:b0:150:4f5:1158 with SMTP id q13-20020a170902dacd00b0015004f51158mr14462524plx.67.1645936152520;
        Sat, 26 Feb 2022 20:29:12 -0800 (PST)
Received: from [192.168.43.80] (subs28-116-206-12-41.three.co.id. [116.206.12.41])
        by smtp.gmail.com with ESMTPSA id h17-20020a63df51000000b0036b9776ae5bsm6828889pgj.85.2022.02.26.20.29.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Feb 2022 20:29:11 -0800 (PST)
Message-ID: <f171e157-7dbc-b07e-7164-c62e2427fbe2@gmail.com>
Date:   Sun, 27 Feb 2022 11:29:06 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] fix: include the type flag in the cli docs
Content-Language: en-US
To:     Matheus Felipe via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Matheus Felipe <matheusfelipeog@protonmail.com>
References: <pull.1220.git.git.1645853661519.gitgitgadget@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <pull.1220.git.git.1645853661519.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 26/02/22 12.34, Matheus Felipe via GitGitGadget wrote:
> From: Matheus Felipe <matheusfelipeog@protonmail.com>
> 
> When the `git config --global --help` command is invoked,
> the cli documentation is shown in the terminal with a small
> error in one of the values of the Type group, which is the
> absence of the type flag in the `--type` argument.
> This commit fixes that.
> 

What about the commit message below?

```
The usage help for --type option of `git config` is missing `type`
in the argument placeholder (`<>`). Add it.
```

> -	OPT_CALLBACK('t', "type", &type, "", N_("value is given this type"), option_parse_type),
> +	OPT_CALLBACK('t', "type", &type, N_("type"), N_("value is given this type"), option_parse_type),


The help should be `give the value the specified type`.

-- 
An old man doll... just what I always wanted! - Clara
