Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4817C433EF
	for <git@archiver.kernel.org>; Mon, 25 Jul 2022 16:08:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235509AbiGYQIW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Jul 2022 12:08:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234778AbiGYQIV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jul 2022 12:08:21 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D744213DC4
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 09:08:18 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id e69so9159103iof.5
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 09:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=FDrFDmuopX3WyDcp+rycrdr3k/eZzfH16UIGY9jGoWM=;
        b=jlGOQkSDAuO6ViWwtNYmPZgkktx9RAsJjUuzZ8eKidFhBWbHN7OU+o36YZpgJEXaZr
         9juSpouRX7lXMfOh32zBDysLWbX8S5zWO5kjZ7VrnRi6kHTZUI8DMsragkzitW24PSpH
         vb0/2xGsiKC2mvgwc/e79JmK8Kn7AG1oVEesKnscM04TZFIiABQKPYID9hz8d/toeLk8
         VlbHZ+hp62weJUc7rHs0JRqjyJmzf/YKyrjtUYqG0ue/wbv8fKIfEgArHclzQZj2fFrL
         vpOMuYlD/PXz6MQdFh0/njHKJvjeDJxRUR2LUBc+GetYcaQOM+PxeA8u0DwIYJw807Kf
         GNMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=FDrFDmuopX3WyDcp+rycrdr3k/eZzfH16UIGY9jGoWM=;
        b=U/4BhOMa/RnUnwEVYfvF20iN8WJLIvg4zhyLEg/4y1UrvBcWJaVt+YgARmSm1FnE87
         4+jKICWbozJmse492HRoAHutJuDvDVNuuIUECMm6jNwwnYmIMCEdTolHsXvP+Yuac1so
         J5uPXYa3f/+1krxqIIR2PTUFJLDpUryMcs7HErkSargJ6x8Ryhp4u07WJeuF0nuaMjmg
         07o+LBjMU0oAf+GU2nVJzxNaj16c7wJ+0Qa05y+MavT9JWQKCyjQrwQLuFcUluHHZOR7
         5n5D85OEV3GNTGC70wrKrA35Uucz/flh5oO5UK8GIyOEijyRE54k0QP9uEHaJI7YSzAm
         I84g==
X-Gm-Message-State: AJIora8mI3la2IRrOlTa7BEjQ6kZDmVKFDdjqEP+zDLQrM/ERZx0uFW2
        sPUDO5Uph1U0AqarnuyP0XvzxHj3riRb
X-Google-Smtp-Source: AGRyM1u5QQofXxQ6HDtQU2rQFa7WLr+o1kn4L3kWeS7oNMZWjS7mqwW1eQqsk7L0I+ElpmdoruIkOA==
X-Received: by 2002:a02:606f:0:b0:335:ae88:68c6 with SMTP id d47-20020a02606f000000b00335ae8868c6mr5029510jaf.320.1658765298242;
        Mon, 25 Jul 2022 09:08:18 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:f959:7f34:301e:c14? ([2600:1700:e72:80a0:f959:7f34:301e:c14])
        by smtp.gmail.com with ESMTPSA id 17-20020a056e020cb100b002dc789a3dddsm4924300ilg.5.2022.07.25.09.08.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Jul 2022 09:08:17 -0700 (PDT)
Message-ID: <4e28ea5a-03d3-990c-34ad-5d5a91d7b888@github.com>
Date:   Mon, 25 Jul 2022 12:08:16 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 00/20] parse-options: handle subcommands
Content-Language: en-US
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <20220725123857.2773963-1-szeder.dev@gmail.com>
 <16acb1ce-92eb-d7ec-d5a2-3ef08cda9b69@github.com>
 <20220725160040.GA2543@szeder.dev>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <20220725160040.GA2543@szeder.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/25/2022 12:00 PM, SZEDER Gábor wrote:
> On Mon, Jul 25, 2022 at 09:15:45AM -0400, Derrick Stolee wrote:
>> I focused on reading the changes to the builtins I have experience with
>> (commit-graph, maintenance, multi-pack-index, sparse-checkout, worktree)
>> and found the adaptation to the new model very clean.
>>
>> The one common thing I saw was that you are updating a function pointer
>> that you name "fn" but it could be more informative on first reading if
>> it was named something like "subcommand_fn".
> 
> I felt that redundant, because most lines mentioning that 'fn'
> have something clearly subcommand-specific next to it, i.e. the type
> 'parse_opt_subcommand_fn' at its declaration, or the OPT_SUBCOMMAND
> macro.
 
I guess I was just reading the final "return fn(...);" at the end
and thought it looked a bit generic. It's probably not worth
changing.

Thanks,
-Stolee
