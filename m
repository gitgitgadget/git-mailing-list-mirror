Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2816B1F453
	for <e@80x24.org>; Tue, 25 Sep 2018 22:20:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725999AbeIZEaU (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Sep 2018 00:30:20 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:46520 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725762AbeIZEaT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Sep 2018 00:30:19 -0400
Received: by mail-ed1-f66.google.com with SMTP id k14-v6so134503edr.13
        for <git@vger.kernel.org>; Tue, 25 Sep 2018 15:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=r4W57qzVHJqCzEsgq0enJu4gx+fy7rsBJ1RXubEyXKY=;
        b=o2D1/gVObzOdjdSmjwA/dPrP5A7ly6PeAto1ZB/sjFUhH4t+i9s6H+v7KiokX1qLje
         LpjUzGBjZrXA9XbG7lj7v6PnrA+2N5cQFscVV4vMHfbX/Oh/jqkQeDiLNa3rJ+uhhqVO
         zQTySP3XMZzPs/AulZvlzQNv/xQs+iTsoJpL+UeKmwNa8qHK1SIuN88s2etwIYaDOuVm
         7Bxuu+qWjICtTqvWC7f9yvglo/H4Cob9fO0UWeXkZIYQjJsdrJnXztI1rZjmYN2UaFhn
         AEIIblk4PFdV/0Wb10dyNt+E4KaErK/X7Y6LMt6q1z2m2EJH6Ib828OxXw+MoFPVIBAp
         mPHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=r4W57qzVHJqCzEsgq0enJu4gx+fy7rsBJ1RXubEyXKY=;
        b=OdFQwQLBBqljRdnGDAVX4YHU7kNWufvx/HwcD/uVYCFRnJU5+uErDww+ni3pVVpgJI
         C1d7L6W07Gi4TE8g+fB+/j2QnZwhYC1XngYURRidcg31C3u6Pss4kJspK/ghlCDXv8CV
         hS6Ho9Bhl7uab65VjvfWoTLc1DqJd/c81bdrKE7LrRQp7I397AzqCvbcLJwagUkxIIV4
         CxWrU87iSJabQpew1mD/4HfbdHBE/pWxR+kOjIAWc9ZiwbfeyRhZUoemxo/YZCbXZWex
         nO48YUgYb7092e1SGHuVRpd7bru+Es5pFlSFpWTzxzieq4ox5IngBmZfgSxVDc4Do+0x
         AUQA==
X-Gm-Message-State: ABuFfoh9UBvVaxknKoGC4Srw/7zHgXcgh7HujGqXiYxbp9rA0W+DBkKZ
        jnMVPNXwyfXAEf8Mg8k3g4uzDQPy
X-Google-Smtp-Source: ACcGV63Z97VLAgLtkg5JGRgJBo0S+yL5sbjyWsZaJ8vGqa1KFv2502NeVF/VNx1iR/yGJ9RtaelCPA==
X-Received: by 2002:a50:8807:: with SMTP id b7-v6mr4868471edb.182.1537914036531;
        Tue, 25 Sep 2018 15:20:36 -0700 (PDT)
Received: from [192.168.0.103] ([92.55.154.13])
        by smtp.gmail.com with ESMTPSA id d23-v6sm6498547eds.47.2018.09.25.15.20.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 15:20:35 -0700 (PDT)
Subject: Re: [GSoC][PATCH v8 14/20] stash: convert create to builtin
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
References: <cover.1535665109.git.ungureanupaulsebastian@gmail.com>
 <a4faed3c8aa5ea8f0d4c578b693f3b5de3e3a709.1535665109.git.ungureanupaulsebastian@gmail.com>
 <nycvar.QRO.7.76.6.1809031718230.71@tvgsbejvaqbjf.bet>
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Message-ID: <5ba50c37-2840-e1f9-4d35-877979018f1c@gmail.com>
Date:   Wed, 26 Sep 2018 01:20:34 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1809031718230.71@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Sorry for the late reply. I had a lot on my plate for the last couple of 
weeks.

>> +
>> +	git_config(git_diff_basic_config, NULL);
> 
> Is this not called in as part of `git_config(git_default_config, NULL);`
> in cmd_stash() already?
> 
> *clicketyclick*
> 
> I guess not. But then, maybe it would make sense to run with
> `git_diff_basic_config` from the get go, to avoid having to run
> `git_config()` twice.

I am not sure I got it right, but if I did:

Running `git_config` with `git_diff_basic_config` from the
beginning wouldn't be pointless when we would use any other
command than `create`, `push` and `save`? Although it might
confuse the reader a little bit, the stash should run without
problems.

Best,
Paul
