Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83916C433EF
	for <git@archiver.kernel.org>; Thu,  3 Mar 2022 11:41:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232851AbiCCLmc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Mar 2022 06:42:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbiCCLm2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Mar 2022 06:42:28 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 486A6E33B5
        for <git@vger.kernel.org>; Thu,  3 Mar 2022 03:41:43 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id q11so4273323pln.11
        for <git@vger.kernel.org>; Thu, 03 Mar 2022 03:41:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=t5SkdTbBDE+KxsCABjVC7R59Jeob8zmyWwH/MqE3fqc=;
        b=QUVnVMDQPemr65P+PjTjKzQHtLxhbNHPpYvW/nDL+nJMYSoPOmEejKpk0lKXucvl+b
         j/j4zMgFpKJtwfk95CXuWYvt1LXnQYSdx6j8HNBqy4OGKeCRHucNXC2SRDiXGMUAlV4C
         RgrEzCf/L8Rg0IZXoGjKtnF6EOMi7zWmscgLmZ213RC17L1pR8+39E7ZtnNyRsH/DL+Y
         2rI9h3CM8mpIyDc85nLXO79ztC9NNOvo5uT8yX2ezPkkOJ1sDTpeV2jj0hA5re2tvvMa
         hjvp8ZR+43JUQz7BcnGz5gVO7URMJPsOxBMR1yUnAvqCI+4PN0aM831sfj/vgi2JrFkZ
         vYwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=t5SkdTbBDE+KxsCABjVC7R59Jeob8zmyWwH/MqE3fqc=;
        b=N0DKZRzLQdem0Y4Cwq27nl2ERmDzpcRH3xthhfJTzvlRLTel/9dMA57qAj5llYxLoV
         9wUW1UIS4J4RBCHp0HuQolzpOpx1DGRaRIL7/scFElR80zjXMFoX5kFKLD/3Cv8t3rOZ
         OslKOhXrw820yQPt5K2SEeiBQD8b/C5sbAyctbztdO5SmiDZuDaEySyeUfUD/4JBGLSP
         tnrMgzjfc2+5ts4bI+OcswVNb3UTEMsWShfi5Mu9j9AIssOcieU67ybv8dAcNEYQNvC/
         KREfxVeS65L7DLCE1f5HGijmh24EmPJPO6h/BHsIrRrFqu+rT/6OrFmM8zWaks5C6Bu8
         +nOA==
X-Gm-Message-State: AOAM532FkotYJDjqn2dg8JgcgFCtUD7GyUrklxZMM0MI2W51Vj71qrMb
        JhRs/6bUHAue2F1fwvhzTWf1uOsEg0SJjA==
X-Google-Smtp-Source: ABdhPJwaMqBhYqNeccckAslkGD0zTf0rLoc5TIArEvBLrQgMiLh3HIfiAcN710+7r2W3uVaoUqwu4Q==
X-Received: by 2002:a17:902:a50c:b0:14d:4e8b:d6f with SMTP id s12-20020a170902a50c00b0014d4e8b0d6fmr35367797plq.42.1646307702682;
        Thu, 03 Mar 2022 03:41:42 -0800 (PST)
Received: from ?IPV6:2405:201:a800:4df9:5194:c9b1:2d1f:598e? ([2405:201:a800:4df9:5194:c9b1:2d1f:598e])
        by smtp.gmail.com with ESMTPSA id b3-20020a056a00114300b004cc39630bfcsm2317347pfm.207.2022.03.03.03.41.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Mar 2022 03:41:42 -0800 (PST)
Message-ID: <76d46b15-f6c0-b8da-87e8-a992047b9a6a@gmail.com>
Date:   Thu, 3 Mar 2022 17:11:37 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] userdiff: add builtin driver for kotlin language
Content-Language: en-US
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     git@vger.kernel.org
References: <20220301070226.2477769-1-jaydeepjd.8914@gmail.com>
 <20220302142608.2754709-1-jaydeepjd.8914@gmail.com>
 <20220302142608.2754709-2-jaydeepjd.8914@gmail.com>
 <fe93dfb2-7c0d-11cb-09a0-9ccc7fcc2507@kdbg.org>
From:   Jaydeep Das <jaydeepjd.8914@gmail.com>
In-Reply-To: <fe93dfb2-7c0d-11cb-09a0-9ccc7fcc2507@kdbg.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

How about modifying the number match regex to:

`[0-9._]+([Ee][-+]?[0-9]+)?[fFlLuU]*[^a-zA-Z]` ?

The `[^a-zA-Z]` in the end would make sure to not match
the `.F` in `X.Find`.

Additionally, we can add another regex for matching just
the method calls:

`[.][a-zA-Z()0-9]+`

Both of these changes would make word_regex match 2 tokens in
X.Find() : X and .Find() (Here X can be any valid identifier name)


> How many tokens will the word-regex find in the expression X.e+200UL?
> .e+200UL is a single token. > It's most easily fixed by requiring a digit before the fullstop. But if
> floatingpoint numbers can begin with a fullstop, then we need a second
> expression that requires a digit after a leading fullstop.

But that syntax would be wrong. I tried making a condition like you said,
but it always ended up breaking something else(like breaking 2.e+200UL into 2, .e, + and 200UL)

Also, I realized I did a bit of mistake in the identifier regex.
Both _abc and __abc are valid identifiers. _3432, __3232 are valid identifiers too.(not numbers)

The previous regex matched only one `_`, so in the next patch,
I plan to implement the following regex:

Identifier: `([_]*[a-zA-Z]|[_]+[0-9]+)[a-zA-Z0-9_]*`

Numbers: `[0-9_.]+([Ee][-+]?[0-9]+)?[fFlLuU]*[^a-zA-Z]`
(It makes sure that in X.Find, .F is not matched )

Additionally, An extra regex for method calls:

`[.][a-zA-Z()0-9]+`

What do you think?


Thanks,
Jaydeep.

