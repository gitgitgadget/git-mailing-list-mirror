Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 07E7B1F403
	for <e@80x24.org>; Mon, 18 Jun 2018 19:58:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755396AbeFRT6L (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Jun 2018 15:58:11 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:34242 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754227AbeFRT6K (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jun 2018 15:58:10 -0400
Received: by mail-qk0-f194.google.com with SMTP id q70-v6so10102471qke.1
        for <git@vger.kernel.org>; Mon, 18 Jun 2018 12:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=WmrIrI1el0CpTS3ONMPNI1AE+aqsWfobpUSxdxK/Pr8=;
        b=kDd0W+YZM8Ztdre0atda0hqWhHu6+QN238KgcUlLA2Bor49Nx+cM0bOURCkWra5Tnd
         8BotcHCBTLt1On/90TUpYuy75Dw+BoKZXc8SEHj2y2cya9qGSF3NMTZZYSa2tbEnLD6Y
         zkVQKT55grvULlEIQAYI/pqXXJv5a/Jibm5Vo95YS9KzDEaRTTDny4LnoEfq2vUXcxEr
         kJhvmsMuziYdJwrpoG9buL8XRNFiHRW9gT8M/y4C4SpkpgTYZN8iXqIrrTwgKdr/gsD5
         0kIcYFGIyyhEu0q6CKsDYNwrlInYbpJiMhE1ISVc3SeelxrT1T+6NwNmTL/wzZZMQuPf
         V2Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=WmrIrI1el0CpTS3ONMPNI1AE+aqsWfobpUSxdxK/Pr8=;
        b=obB3PFOvV9HUBCja7vmhb4ABOH9OxzskjPSGx1gNI8OzmMsJK/tCZxY2PpQ+z6eACV
         z2pD6n7IyH1TcUb5cACoFxLsyMzq+iovdAUBU0tYrYcEErhx8y7JQhS7iY2U4atgFL+K
         9AZIJKHsU7kbfuHcZwPHa4ZksRLkDI0RxtgAtI3FNr11z0/5fQxMihfnPNWh46K+N+Qu
         DPLxwTFep9e++4s8YYTVciZf2E5tFH3QO/p+cO37B1V3d7htTI3vlavJ3N0I7D5sjW35
         hPxPSsFC55GZqI++x49ziR9AjpyrdugZn+2JS3v+zxi4bfLAew4022aBB9HZSD4zMBOC
         fCbg==
X-Gm-Message-State: APt69E1yZXZeMicpb+VonYTtDkIsOmQXROG+xSqMrF6LNhYtnSKRJYKb
        vVTYAcoAZoTwam3mRkbUwgyPWOTX
X-Google-Smtp-Source: ADUXVKJkEMtkb2wwIpNHxUOklHBy3swLcfy+K8DvXBgql2ikbQaFQYwaTqJazfQZ++64ensC3vGRlA==
X-Received: by 2002:a37:cbd3:: with SMTP id u80-v6mr11196990qkl.290.1529351889495;
        Mon, 18 Jun 2018 12:58:09 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:d807:51c7:6f48:91e4? ([2001:4898:8010:0:c13d:51c7:6f48:91e4])
        by smtp.gmail.com with ESMTPSA id r25-v6sm12119951qtc.39.2018.06.18.12.58.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jun 2018 12:58:09 -0700 (PDT)
Subject: Re: [PATCH 03/23] midx: add midx builtin
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>, Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Martin Fick <mfick@codeaurora.org>
References: <20180607140338.32440-1-dstolee@microsoft.com>
 <20180607140338.32440-4-dstolee@microsoft.com>
 <CAGZ79kaH7XzbtPZqVwGgP774GJNxF7ZsHqLzWEmb2NLSxG3Njg@mail.gmail.com>
 <160f10c8-3016-8466-22dd-14cbd1a2c2f6@gmail.com>
 <CAGZ79kbb699FHoD1X5gXjtBv0r7zpd5PRuh1R2FQ8ABySV8znQ@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <87d4a3ef-cc42-daef-66cb-46ae0f4d7ffe@gmail.com>
Date:   Mon, 18 Jun 2018 15:58:07 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAGZ79kbb699FHoD1X5gXjtBv0r7zpd5PRuh1R2FQ8ABySV8znQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/18/2018 3:55 PM, Stefan Beller wrote:
>>> But as this is plumbing and users should not need to worry about it
>>> this is optional, I would think.
>> The design document is also in 'Documentation/technical' instead of just
>> 'Documentation/'. Do we have a pattern of linking to the technical
>> documents?
> Apparently we do (and I was not aware of it):
>
>      $ git -C Documentation/ grep link:technical
>      git-credential.txt:23:link:technical/api-credentials.html[the Git
> credential API] for more
>      git.txt:839:link:technical/api-index.html[Git API documentation].
>      gitcredentials.txt:184:link:technical/api-credentials.html[credentials
> API] for details.
>      technical/http-protocol.txt:517:link:technical/pack-protocol.html
>      technical/http-protocol.txt:518:link:technical/protocol-capabilities.html
>      user-manual.txt:3220:found in link:technical/pack-format.html[pack format].

Thanks! I'll add some links.
