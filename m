Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B96D5C433EF
	for <git@archiver.kernel.org>; Wed,  9 Mar 2022 15:23:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233829AbiCIPYJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Mar 2022 10:24:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233819AbiCIPYF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Mar 2022 10:24:05 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA07E286FE
        for <git@vger.kernel.org>; Wed,  9 Mar 2022 07:23:05 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id k9-20020a056830242900b005ad25f8ebfdso1964384ots.7
        for <git@vger.kernel.org>; Wed, 09 Mar 2022 07:23:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=bDBfxTc6EPlssgxswJsYLJ4A5+9ME5j86lVVzDo5CMQ=;
        b=PvnsuW2omHnY3hMA9TzKzVS9Q3PdMMJHxvuP4a0NoV92kHnTBm9H55K8RT2c5pP6iU
         iVH2KKkANyelILfAykqmpCe4scuBqEwGklSsSoOU2EDkEya5bgxhE9wUV68mxgXfQU2D
         xXdazd7W07Gc7emJszQ9So+j61Bhsg7SfgNBjEccbxnFZXjoSkm0mGPmHTR8dV5xH4ow
         KsPPJ1s9qM3MLVlYezNmWd0RSzSumSNszDj6P7IAZc6qG83qlipypxf/o6WmDwL51EGZ
         fcWp7DKHLf4lqPAYufhbbQeJn/sSwL4H6uDi8nNlqN3iNlO3MJ81Q49fUj4i/fY9pfUq
         1/Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=bDBfxTc6EPlssgxswJsYLJ4A5+9ME5j86lVVzDo5CMQ=;
        b=Jx4j6PVhB7cOZWMqMOol+6AF89gnFX5rw9Mm//b0+7tafQSPZrCMqIRKcrLEV5NP5k
         1gwBNmH5nOkuxlFPnqJ6012s+85p8pM1f/uCTzsJku2niaxJzK/u/rS+mbTaFdO0zyVh
         8v40+wz8uh/gTze+xSSmozxHparQty78PmTZUY72/yJ8MHPfMd+O+BtAvZV5XySIIwoU
         8jogI7ujEnjErG65MjoMFkGnUmTyoLV4/Z8J+C+NFbVkxvOeUJ8Xctyd61+iSLadUo7m
         KxM/wVQXhHKygMd8YCSVC90eQfB1JZ+NqT2gVXZ+ewh3T1+YH7IoS+UwJaCS0snaTyVj
         oEjQ==
X-Gm-Message-State: AOAM531SB61uPjyw8ZgDh9vhSQfMi7bx0j1oAMxrmsk8iCiPzlQ+ZN6/
        EJISq9jG1kppSXwqVxlcKrp/
X-Google-Smtp-Source: ABdhPJxAXKR8KoTU+3tdolC/rwmcgUUX5tqgm10eymR/U9CZxLDoYD9wMX9tN9XY20hNupKVapuhcg==
X-Received: by 2002:a05:6830:2256:b0:5b2:46c6:1780 with SMTP id t22-20020a056830225600b005b246c61780mr106322otd.263.1646839385044;
        Wed, 09 Mar 2022 07:23:05 -0800 (PST)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id bc24-20020a056808171800b002d722aead50sm1005119oib.27.2022.03.09.07.23.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Mar 2022 07:23:04 -0800 (PST)
Message-ID: <b5afa73a-d563-eb89-2557-5dcc02df2541@github.com>
Date:   Wed, 9 Mar 2022 10:23:02 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: Add an OPTIONS chunk to Documentation/git-sparse-checkout.txt
Content-Language: en-US
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>,
        Derrick Stolee <stolee@gmail.com>, vdye@github.com
Cc:     Git List <git@vger.kernel.org>
References: <CAJyCBOTKq3t=QtynBMrHvP5__FfNpoeUJ7t8xMv-3zTbv4yU7Q@mail.gmail.com>
 <a0bb08ba-ef7a-53ec-a3c1-9238f9eb90ce@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <a0bb08ba-ef7a-53ec-a3c1-9238f9eb90ce@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/9/2022 7:42 AM, Bagas Sanjaya wrote:
> On 09/03/22 14.55, Shaoxuan Yuan wrote:
>> Hi all,
>>
>> I'm wondering if we could add an OPTIONS chunk to
>> Documentation/git-sparse-checkout.txt?
>>
>> Cause when I was skimming through the SYNOPSIS
>> and it says "git sparse-checkout <subcommand> [<options>]"
>> but I didn't quite see the options until I read into the COMMANDS.
>>
>> Perhaps something like this:
>>
>> OPTIONS
>>
>>      --[no-]cone
>>
>>      --[no-]sparse-index
>>
>>      --stdin
>>
>> If this is okay to do then I will try to submit a patch later :)
> 
> OK, but we need to list out subcommands and options in the SYNOPSIS,
> much like in git-worktree(1) and git-submodule(1).

Thank you for showing an interest in improving our docs! Be sure
to start from Elijah's recent series [1] that overhauls the docs in
a few different ways, just to avoid conflicts.

[1] https://lore.kernel.org/git/pull.1148.git.1646725188.gitgitgadget@gmail.com/

Thanks,
-Stolee
