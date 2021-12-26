Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9FC4C433F5
	for <git@archiver.kernel.org>; Sun, 26 Dec 2021 09:58:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbhLZJ6a (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Dec 2021 04:58:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbhLZJ6a (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Dec 2021 04:58:30 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDF45C06173E
        for <git@vger.kernel.org>; Sun, 26 Dec 2021 01:58:29 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id r5so11137751pgi.6
        for <git@vger.kernel.org>; Sun, 26 Dec 2021 01:58:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=q4yWWxVfgibcsIHAixKNTIK3PGPSaFh8ajoXTmAI9fQ=;
        b=mmk/o+Lf9Jl5wiTxqRqFHYvApSoF3UDLtjShIt5NAuYK3ZizOIhnMbY42bWymJOVn8
         hzly9I3pocP0RMYQE+GxXKWH4P+bCn+1Mb3tEwH6RmLaBVWV7mjpvliR6FhozMpRvK+a
         YmbDlQPNhGIk+VOoldWJJyyxzcbK2PwgEs3Xj+mVU3sIyJ0Xd9wCKlv1jSwDSG240DEc
         Xm9AINz6QBvm4Q//BNEyH+BLvwMTXNkRvI7SWcf2NwxAl9g2cuSpgN/J+hywNJUMr/Rm
         450Qen9ChyZuMrlUwVwUED0cXYMWNgN8EyHQmrurVXRvtx6hRP1VTirel6CRmkjf6cRz
         QBTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=q4yWWxVfgibcsIHAixKNTIK3PGPSaFh8ajoXTmAI9fQ=;
        b=evZNV8VddrEUmS8kLQ5u9ZAn7vJ6hognA1JpFHc8cSKzYAj5mDL8KKPAteOaDbYKvM
         hMjEYPV6Gd8lQ0Erv6E7taGSOYpZmQoMJe06cRveQdtMdoIVvBJPyYVnDj05C2POqui9
         BOc4HSZAFRiXpLdz1uYi5lG8o3dZnqdzoGREhjLCHeRqT57ogJzJWjlwHRWJEy1U2yEm
         de665tpGviRvTkAjeAZsuGeBJMAoQYPSWoMkT3Y14w9fQNup4bU7Ev0tMvGMA+142KUJ
         OakbD6axniF08jEYuwZSpJi1R2c4SL7NJu23GuOvJ8MQOhg2omKoK1IiD1js1lsSHAob
         A6jA==
X-Gm-Message-State: AOAM530Andor60UVmFS7DCM7EuKSYkMdoD9ltwQEvs5AxXIO1ZkEbzpC
        lf7YE8UL+Mmpu7/ogajA2Wu8uu1anEpxbSgz
X-Google-Smtp-Source: ABdhPJy+B4MeyRJdyVYAzBZK0oTQJ81kTZECgCYZ0AFV2tM4Nq1wcmPMgC0b3urQ1C1tfSw/jknLWw==
X-Received: by 2002:a05:6a00:234e:b0:4ae:2e0d:cc68 with SMTP id j14-20020a056a00234e00b004ae2e0dcc68mr13358829pfj.60.1640512709210;
        Sun, 26 Dec 2021 01:58:29 -0800 (PST)
Received: from [192.168.18.18] ([103.252.33.202])
        by smtp.gmail.com with ESMTPSA id y128sm14450283pfb.24.2021.12.26.01.58.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Dec 2021 01:58:28 -0800 (PST)
Subject: Re: Rebasing commits that have been pushed to remote
To:     Erik Cervin Edin <erik@cervined.in>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <71b51bc8-172f-48de-7c3f-cf55dc45b39a@gmail.com>
 <xmqqlf0cjuwx.fsf@gitster.g> <d51b7981-5034-b34c-42d6-ad8b80a378c1@gmail.com>
 <CA+JQ7M_GhE=vcpoCSPEnSPoLA1xZM3uVMuGw4goPe4AmQip2hg@mail.gmail.com>
From:   Lemuria <nekadek457@gmail.com>
Message-ID: <f282b2eb-efd2-e194-d326-fe4daa07b598@gmail.com>
Date:   Sun, 26 Dec 2021 17:58:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CA+JQ7M_GhE=vcpoCSPEnSPoLA1xZM3uVMuGw4goPe4AmQip2hg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 26/12/2021 4:44 pm, Erik Cervin Edin wrote:
>> Alright. I'll take this into account. Unfortunately, before you got to
>> me, I reworded the commits on my local and pushed them to the remote,
>> which resulted in a messy history with duplicate comments.
> 
> This easily happens
> Usually when you merge old history back onto rewritten history
> It's easy to confuse what is what when rewriting history
> 
> If you find yourself rewriting and force pushing a lot
> you might find the following script helpful
> https://gist.github.com/CervEdin/2e72388c3f7d9b30d961ec3b64d08761
> It shows:
> - The graphs of differences between local and upstream of a branch
> - The difference between local and upstream
> - Prompts to force push with lease

I don't force push a lot, but regardless I'll make a note of
that.

> 
>> But at least my GitHub page has more green on it!
> 
> If you want green you can fork
> https://github.com/cervEdin/vanity
> 

I'm surprised how GitHub hasn't taken that down yet. Well,
spamming commits means more green and isn't that good for
the environment, right?
