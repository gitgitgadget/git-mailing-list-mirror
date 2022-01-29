Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35A21C433F5
	for <git@archiver.kernel.org>; Sat, 29 Jan 2022 18:37:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353008AbiA2ShE (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 29 Jan 2022 13:37:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352959AbiA2ShD (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Jan 2022 13:37:03 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B20C0C061714
        for <git@vger.kernel.org>; Sat, 29 Jan 2022 10:37:03 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id q63so9654142pja.1
        for <git@vger.kernel.org>; Sat, 29 Jan 2022 10:37:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+l+VNSb0P3eMo9jC3jCfSvjyBIOg+hMtUaHWsfnkqMU=;
        b=apqcdNP8dEN8n3d3bIg2lISyPkFivDVjOe4dfK9C9eseFEwrkVVK/Lxu1GZmQaUiHZ
         hC9RvRVriLi57DCgrwRKbRWc1KzMlFm5z8XpkTEUX0zEzD8y4BrtHBPAKmG2WqbR7lPb
         DMCEefzuZd0aDCc1+97fMMjUUvBgNDdV57lHZU5nLFa8oMy4VjxxU22bdNUBMzT7+9xg
         LLQa1MXtshj33gd0daZX5jeODUsF2I0BPpACqTPMbaRwZM/8zpz/Cbqcua2gSLGSnGOM
         aVKlxB4bYJY0555xV1+NPCMrtYxwhjkUQ+T/8Qmnw08D1KAsdLgj/ON6G81WOyAF8AGE
         vdEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+l+VNSb0P3eMo9jC3jCfSvjyBIOg+hMtUaHWsfnkqMU=;
        b=HhH+ZFSre6NyuhvU6Esqv24ekNJPyYQlwZLn6qJb9aIyfVkkE+RRSWEhZMyTnuP+t8
         2U8+l5ta4enk1XOs7JWRCv9O1PeyYwh7O5xTCP2LhNm2SWtmSbvWmUSvxm4PKG7XZZdq
         iOr0GFuncV1+hA+FKuLIfsEMfd6tLWm/kwy351I+PzxTOSXTok5FbyRluq/kD6Zxheas
         iccuwRRtcRqapPn6oe96Qh4aV3yI9EWk2ZUeg6GG9SgL2sPDmUOX4QInboKsP9eptfYZ
         M8CEoOWQLByuNiA4DshRIEe8MsZCxP1QlcblSFuwoqEf/M1pKnz/Cb9RNPHkVefvb/Q7
         DTqw==
X-Gm-Message-State: AOAM533kJ8+uD65Y8qpbd2+9jesNdi6iu6FR/A59SKZ4hEDyHWUJKn7s
        vQ8bGcyEKhuwgCLL08pMlQc=
X-Google-Smtp-Source: ABdhPJxlRM7gQxkm00HT+6nIDkxNY0SV7bJPds3fDGcLRLXpmMd6Vt83fVgKDmrcKo9v04D6KYIoog==
X-Received: by 2002:a17:902:da92:: with SMTP id j18mr14204389plx.127.1643481423066;
        Sat, 29 Jan 2022 10:37:03 -0800 (PST)
Received: from [192.168.208.38] ([49.204.143.33])
        by smtp.gmail.com with ESMTPSA id f8sm10956137pfv.24.2022.01.29.10.37.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Jan 2022 10:37:02 -0800 (PST)
Subject: Re: Git in GSoC 2022?
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Git Community <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
References: <439ebfba-d493-2cff-434a-b1073e755688@gmail.com>
 <9d2e58ab-2d8f-0797-84ed-0c1e8941edaa@gmail.com>
 <CAP8UFD38WDwMKf3tMKGt6hMxmsuZk2JkDRJaOZsXFqHvbVLRLQ@mail.gmail.com>
 <nycvar.QRO.7.76.6.2201281114440.347@tvgsbejvaqbjf.bet>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Message-ID: <22e484c3-f313-5335-5f34-5df019b7ee98@gmail.com>
Date:   Sun, 30 Jan 2022 00:06:59 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.2201281114440.347@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho,

On 28/01/22 4:15 pm, Johannes Schindelin wrote:
> 
> A project that I would personally find a lot of fun, with a great impact,
> and never really talked about on this list, would be to offer a good
> replacement for the `git daemon`: its purpose is to make it easy to stand
> up an ad-hoc server, to allow developers to clone/fetch (and even push, if
> that is enabled) via the network, unauthenticated. Now, the git://
> protocol has served us well in the beginning, but it is increasingly
> obvious that we should use https:// wherever possible. Wouldn't it be fun
> to have a `git daemon` that talks https:// by default, maybe even
> optionally offering a real web UI via gitweb? This is not as huge of a
> project as it sounds, Jeff Hostetler already did a ton of work to that end
> over in the Microsoft fork of Git: the `test-gvfs-protocol` helper is used
> in the regression tests to offer Git repositories via http:// and the
> biggest task to convert this to an HTTP-speaking `git daemon` would be to
> rip out the GVFS parts. After that, HTTPS support could be added.
> 

Sounds interesting. Would you mind drafting this into a project proposal
for GSoC. Then we could add it to the list of ideas document [1].

Also, would you be willing to mentor a student in case they pick this
project? Or would you rather leave it to others?

[1]: https://github.com/git/git.github.io/pull/540

-- 
Sivaraam
