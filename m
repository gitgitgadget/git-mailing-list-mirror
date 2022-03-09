Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 439CAC433EF
	for <git@archiver.kernel.org>; Wed,  9 Mar 2022 12:42:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231420AbiCIMnU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Mar 2022 07:43:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231723AbiCIMnT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Mar 2022 07:43:19 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 192D9177742
        for <git@vger.kernel.org>; Wed,  9 Mar 2022 04:42:21 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id z3so1823718plg.8
        for <git@vger.kernel.org>; Wed, 09 Mar 2022 04:42:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=hrJzXsbVrIsJH4vocTWXPi4pwIjVlT/ByzKlyaJhb5Y=;
        b=nBjdTmsjCULEe8FOFMe5nnNL5n6e34Nsr3S9i++vcOgO5w1VyjYHHqi3DhCiE9XZ+1
         YESUG9qidjz1O8qpjL+qZKjmkgHBhVjrc1QemDkpTliHs3JOUG/JtxjfDCqvAxsrFkkd
         naOYxImJMHzNfNMxJD2mNg5aRC6Aj14pvg4bBAzi4FqnVAC2OAC+eJQnkchZExMPTIg7
         HgaoIKqZnukMsIM2g9PVaKE19bfAjXr2+RdI6/OSiyP5LExHvE2tjHYsOwqo3b4c3kSu
         pm9s6djehUpHcISA5VBPd86O79yk2N62uFKistBjAq6hidNPpCZyoLcc1MwuOo37EuCA
         QZWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=hrJzXsbVrIsJH4vocTWXPi4pwIjVlT/ByzKlyaJhb5Y=;
        b=yYVYfcASu9qr5sYDiO8286c9Dzz5AVf+zlTnfALZ8Uz1MUGerm4PIBMo4dcpxkSRuq
         AjR/f7NDpvoYK9oKeXFXq/SFpH3oOxylOuBU7msDli2JP80JNmAl5AAEJTpeyrrcHmqj
         93kGPaJukQDycz//LS99gZ8wTzaU8fqHzCBWqUE8LaqRPKg2XRS7Of7kJNwiCC2nBIYH
         xSC/0aqefK44ZzI7QrKnurLuXC8cc60zdTaODPLEEyX6XNch14XudfHMajpPSDkmQDhE
         a6o7rVGwRcNBFDYDuBd/VAmdiQOwBj9gChgU/NSENBJLrE5qEItityXEMJBCd23oDS69
         UhPw==
X-Gm-Message-State: AOAM533n+hinsDqvAgjnWk+7w5YDzgrD1weF432Tjtg1pn+Jkc4myobb
        XiQE1ZA45JjiP1+cDQTCc3i9enssAa4=
X-Google-Smtp-Source: ABdhPJwo9BeekmOXu8AXYA/5V/YaTmhDiy3h1RFLN4IThuQQ+UA3PLI30eDpReZEX/AlcPulRf0XaQ==
X-Received: by 2002:a17:90a:af88:b0:1bd:6b5d:4251 with SMTP id w8-20020a17090aaf8800b001bd6b5d4251mr9946609pjq.134.1646829740546;
        Wed, 09 Mar 2022 04:42:20 -0800 (PST)
Received: from [192.168.43.80] (subs02-180-214-232-94.three.co.id. [180.214.232.94])
        by smtp.gmail.com with ESMTPSA id s6-20020a056a0008c600b004f667b8a6b6sm2815721pfu.193.2022.03.09.04.42.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Mar 2022 04:42:20 -0800 (PST)
Message-ID: <a0bb08ba-ef7a-53ec-a3c1-9238f9eb90ce@gmail.com>
Date:   Wed, 9 Mar 2022 19:42:16 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: Add an OPTIONS chunk to Documentation/git-sparse-checkout.txt
Content-Language: en-US
To:     Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>,
        Derrick Stolee <stolee@gmail.com>, vdye@github.com
Cc:     Git List <git@vger.kernel.org>
References: <CAJyCBOTKq3t=QtynBMrHvP5__FfNpoeUJ7t8xMv-3zTbv4yU7Q@mail.gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <CAJyCBOTKq3t=QtynBMrHvP5__FfNpoeUJ7t8xMv-3zTbv4yU7Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/03/22 14.55, Shaoxuan Yuan wrote:
> Hi all,
> 
> I'm wondering if we could add an OPTIONS chunk to
> Documentation/git-sparse-checkout.txt?
> 
> Cause when I was skimming through the SYNOPSIS
> and it says "git sparse-checkout <subcommand> [<options>]"
> but I didn't quite see the options until I read into the COMMANDS.
> 
> Perhaps something like this:
> 
> OPTIONS
> 
>      --[no-]cone
> 
>      --[no-]sparse-index
> 
>      --stdin
> 
> If this is okay to do then I will try to submit a patch later :)

OK, but we need to list out subcommands and options in the SYNOPSIS,
much like in git-worktree(1) and git-submodule(1).

-- 
An old man doll... just what I always wanted! - Clara
