Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB179ECAAD8
	for <git@archiver.kernel.org>; Fri, 16 Sep 2022 13:46:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231719AbiIPNqP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Sep 2022 09:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231154AbiIPNqN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Sep 2022 09:46:13 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA2AF97ED9
        for <git@vger.kernel.org>; Fri, 16 Sep 2022 06:46:09 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id z25so35712678lfr.2
        for <git@vger.kernel.org>; Fri, 16 Sep 2022 06:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date;
        bh=TWt4t6NPIW5XU0/SATH+cYlpS1/3VVx4IgHvE4ubOvI=;
        b=XZHyq0ZbLqijmRJo5ZbDWZH+fZ8STXsi5fx6H5VNAPmixz4+bwqJshwdhj4ofcxWtl
         L5VMeZDbSgSV4mjRUYavc0vNniaf6kE58R09TTkJ640rRwbpm92+q4s1uqRGxmuwgeSR
         U8qckm21qy/oxOY7w4bTvLye/00z4r83V/CyWd3YXnitUBRhjbzrkTRTNoCMybPI7xzd
         iLUPhUT20s+kjSUt/lw16B82l0Ok6UhJuj0zMiP3g2skxRjcqqhOkP65h4urNwC8tmes
         iOQ6vT1IV7GvvNQSlQ1/IIG1qx0+wiQ1v1OwtMe17LzSA+RLqwLpEeNH3KTcyJwWF7rP
         czlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=TWt4t6NPIW5XU0/SATH+cYlpS1/3VVx4IgHvE4ubOvI=;
        b=m7BVx6Jq4WKj0DAKY4i1i9FM6v+v0Uq6r5om3mngtYPXlm3X3o2hxySBqXdF6T03h+
         nixYQJCXD/bITW+/14c+6DMAfkFfOeVzGLZ87n/CBwtlRZ9QvfVkTeOSl7YRuDZE2GJw
         ga8VfODPoKMd0r38zFlgdmAeonsIFjA3Q1RhLlbwxPtsSDdvL292eSGsMs31Cm0TQDuh
         SgvBf+iWV3P5jwB15rhMkmhZQTV9eDqCxpgHEMo9QvaiQQ+onhRjZDeKhnVmZwWlvToy
         Uje6ymABcwqF9aMhL6ooogj1SXdnDKZ6mchnXoungJpaGAfJJbpQ7MOfRJwOtSIoxr29
         eO1A==
X-Gm-Message-State: ACrzQf2PLgCThLCsyNAIp0FlH2qAstPqU+4Usea1KPaEVhbwOAO6Gb+C
        tyP2aPi9HPX/g9RLYeGj3YnyL3HEldQ=
X-Google-Smtp-Source: AMsMyM6kR04aP32spjfBMm/H3b4GyIPHjeoCcL4O19+c6V4ATLxaJvNK8ij5bu52e5pqcpU+ErlJGA==
X-Received: by 2002:a05:6512:3f05:b0:497:9e06:255b with SMTP id y5-20020a0565123f0500b004979e06255bmr1616211lfa.175.1663335967682;
        Fri, 16 Sep 2022 06:46:07 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id f24-20020ac25cd8000000b0049468f9e697sm3481742lfq.236.2022.09.16.06.46.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 06:46:07 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/3] diff-merges: clarify log.diffMerges documentation
References: <20220914193102.5275-1-sorganov@gmail.com>
        <20220914193102.5275-4-sorganov@gmail.com>
        <xmqqr10cmqbk.fsf@gitster.g>
Date:   Fri, 16 Sep 2022 16:46:06 +0300
In-Reply-To: <xmqqr10cmqbk.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
        15 Sep 2022 11:43:11 -0700")
Message-ID: <87leqjjuu9.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Sergey Organov <sorganov@gmail.com> writes:
>
>> Signed-off-by: Sergey Organov <sorganov@gmail.com>
>> ---
>>  Documentation/config/log.txt | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/config/log.txt b/Documentation/config/log.txt
>> index 5250ba45fb4e..cbe34d759221 100644
>> --- a/Documentation/config/log.txt
>> +++ b/Documentation/config/log.txt
>> @@ -30,9 +30,9 @@ log.excludeDecoration::
>>  	option.
>>  
>>  log.diffMerges::
>> -	Set default diff format to be used for merge commits. See
>> -	`--diff-merges` in linkgit:git-log[1] for details.
>> -	Defaults to `separate`.
>> +	Set diff format to be used when `--diff-merges=on` is
>> +	specified, see `--diff-merges` in linkgit:git-log[1] for
>> +	details. Defaults to `separate`.
>>  
>>  log.follow::
>>  	If `true`, `git log` will act as if the `--follow` option was used when
>
> Is the reason why the patch drops "default" because the value given
> is used only when --diff-merges=on is given, and does not kick in
> when "--diff-merges=<format>" is explicitly given?

Yes, exactly. It's the --diff-merges=on that uses the default diff
format. Well, in fact "-m" uses it as well, being a synonym for
--diff-merges=on, so we might consider to mention "-m" here as well, but
I thought it's not needed as we provide a link to corresponding piece of
documentation already.

I wanted to explicitly describe what log.diffMerges affects, instead of
vague "default diff format" term causing a need to figure what in fact
it means.

Thanks,
-- Sergey Organov
