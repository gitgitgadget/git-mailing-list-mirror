Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 72FD121841
	for <e@80x24.org>; Tue,  1 May 2018 11:16:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754246AbeEALQR (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 07:16:17 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:33740 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753072AbeEALQQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 May 2018 07:16:16 -0400
Received: by mail-qt0-f195.google.com with SMTP id e8-v6so9327642qth.0
        for <git@vger.kernel.org>; Tue, 01 May 2018 04:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=QrbWb3GGntyP2qMhKcnAXwC+S1cdUQ48DyFfhDA07Yk=;
        b=klka4VPRAdg8eKei9Qg81JXju9wREBC99Wo+MoU+2bbzPRc9n++8nrZfgyMtw8kN5U
         uvzOGzGjPio6U/aMQZuUvASOP4SfoMBbEM1McgRn9nYP6TgqiyvBaUpGB15nTjL2+ACB
         Cm/8QVHFvPuT8nnjsmLW5GqaxBfG/ZEsXpKZiSBPoQZB91MvQIsi0vHOd8FbHGZe3UG5
         Z7M+rmPBHoOLCvoGqFLp6BqsF5NZavbQvbu7MrTHrHbHJiCDWGoiS/1aGWNuTKZ1Mse4
         2pwmEjxYxkx+3x8HafiRR8M8TgHYKcTq/ScC3MPg4/8ugC8WVokRQ1DSJS5KDmnBPm2u
         EPug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=QrbWb3GGntyP2qMhKcnAXwC+S1cdUQ48DyFfhDA07Yk=;
        b=OSTPElOUIHXfJihfqSAIQEU52Is6Q4jBoF+WPjttATk0f8qc92GC0g+ozI6h4fq8Vs
         vpjjt5pzoqD0S7SiP9Ti0NomsL54hhaKodZQxTUlKcr9kv4U6G+tRQ7ZIUfaKNz6cy3w
         pV+QB0uVTRNsSbFs3IcgL3AzY6E10kBWtsjb8ZoMqlPMqgnzYzSy4ZFY7URKIdyPiCmf
         iU8hPr9p7PWNN70GW+9B4uue1i+K8flTOFiIK6dY+4oJwd1pF6jCr3kFB0DJPiprXrym
         d1OZsnBBqWuiLtaGtJqvavCpkn7Q4nlVV73tkYDN694gUFOTUPps3d7iu5WW5dlcWCIn
         BIbw==
X-Gm-Message-State: ALQs6tCHvYRquwk9NVXhd3r9qa6/TcVQVv/qIBP8T4JyMZXmbZlMOdHF
        4u99SqjYuQwTCsbAWh1dWLk=
X-Google-Smtp-Source: AB8JxZrw5VhaHlgFePuuu8zhZJbMYwKWcM+WPyJU1P1ImWxStZyOuJ+Es0i0gbl63ZrQgIDMEh5MDg==
X-Received: by 2002:ac8:2c49:: with SMTP id e9-v6mr5472733qta.24.1525173375424;
        Tue, 01 May 2018 04:16:15 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010:0:ae1c:7a22:56f1:df04])
        by smtp.gmail.com with ESMTPSA id v57-v6sm8254476qtj.47.2018.05.01.04.16.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 May 2018 04:16:14 -0700 (PDT)
Subject: Re: [PATCH 0/9] get_short_oid UI improvements
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
References: <20180430220734.30133-1-avarab@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <49980177-b389-1ef2-e579-cd7f2f4b91f0@gmail.com>
Date:   Tue, 1 May 2018 07:16:13 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180430220734.30133-1-avarab@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/30/2018 6:07 PM, Ævar Arnfjörð Bjarmason wrote:
> I started out just wanting to do 04/09 so I'd get prettier output, but
> then noticed that ^{tag}, ^{commit}< ^{blob} and ^{tree} didn't behave
> as expected with the disambiguation output, and that core.disambiguate
> had never been documented.
>
> Ævar Arnfjörð Bjarmason (9):
>    sha1-name.c: remove stray newline
>    sha1-array.h: align function arguments
>    sha1-name.c: move around the collect_ambiguous() function
>    get_short_oid: sort ambiguous objects by type, then SHA-1
>    get_short_oid: learn to disambiguate by ^{tag}
>    get_short_oid: learn to disambiguate by ^{blob}
>    get_short_oid / peel_onion: ^{tree} should mean tree, not treeish
>    get_short_oid / peel_onion: ^{tree} should mean commit, not commitish
>    config doc: document core.disambiguate
>
>   Documentation/config.txt            | 14 ++++++
>   cache.h                             |  5 ++-
>   sha1-array.c                        | 15 +++++++
>   sha1-array.h                        |  7 ++-
>   sha1-name.c                         | 69 ++++++++++++++++++++++++-----
>   t/t1512-rev-parse-disambiguation.sh | 32 ++++++++++---
>   6 files changed, 120 insertions(+), 22 deletions(-)
>

This is a good series. Please take a look at my suggestion in Patch 4/9, 
but feel free to keep this series as written.

Reviewed-by: Derrick Stolee <dstolee@microsoft.com>
