Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D003C433EF
	for <git@archiver.kernel.org>; Mon, 11 Jul 2022 03:51:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbiGKDvh (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 Jul 2022 23:51:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiGKDvg (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Jul 2022 23:51:36 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05F0116583
        for <git@vger.kernel.org>; Sun, 10 Jul 2022 20:51:36 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 73so3680453pgb.10
        for <git@vger.kernel.org>; Sun, 10 Jul 2022 20:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=CtAsLOJWenVVgopdtkQkLhhzJeMg2kcy+nVniRLyqf8=;
        b=e7am3bnSoMZEuG3jaVl5bCkC8GHzzscJMmM2I5ibp8LePB/qSU0UjsVEDSb/UJEDWm
         58/YxeOZTYlz3clysiJdqVOKkUpXAHaIOeck459c/ZN20I8OBrkDPdw8i9AEScvsAgmf
         GNQkAuvtjylep0UESlSlnKmxqbmDRpAT44nGcNryqftOVxsJCImuvwf2FHw3L0iXcQ28
         HCUQePkf99IcIUAMbEFulxRgTo8nNMjjNbEBQKedo3dptcxGh7IAhHXkidzeecQKmBcz
         Tjxn+gp3JLGx4f79fkTq9oZz+Wd8n0W6FpaS6fVwLafrWAXBJGTWhfesm0xqHF5ftPKM
         KFow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=CtAsLOJWenVVgopdtkQkLhhzJeMg2kcy+nVniRLyqf8=;
        b=DgjZmzSMRbbg/4DrZi3KQ3rOXSJkIijjCXe71c0gAzd1ILGXaZLLO261AlE79m9Lyt
         VXA8HMIccW1RUR0oVXIasET5BMsO6V0aGBiy/M4AdA7m1G9bl/msa3UnGd8sPOu1XBy+
         mcCWCBlELtSIq1nX64LsjIEDzNJfGcMec7WkCy9wBQNlr8ifktigpPIWI7zdm/LaKmDS
         aolRGHLBzaBtbV6yZmyfMIuSDD+rLhMoLLR6oIRqOpjFtj050RUgCb2AK6ciea44Dicp
         gNDl9oanCCiwKRU8feU7bBH8VGy/33SL8Zd/Zq3UMjzb3CCErN24FoKLYTKxhQQYYdGh
         ekrA==
X-Gm-Message-State: AJIora/u/z7pdkPZY8xUdKZo2LRHxkCGjJ8qhw3H6tjUEPuoKBmPGCMv
        9f1dUonXkmBUT9Kk3E6k3Ow=
X-Google-Smtp-Source: AGRyM1utanfjRYGJHGtDwJ1X3VHh8lbsLdQ1YGfAiMUIz8U7kXYPX1/p4unlJHJYLXrVBzdYlZIfSg==
X-Received: by 2002:a63:ea55:0:b0:412:290c:9694 with SMTP id l21-20020a63ea55000000b00412290c9694mr14420031pgk.39.1657511495502;
        Sun, 10 Jul 2022 20:51:35 -0700 (PDT)
Received: from ?IPV6:2409:4065:e85:380b:f208:953e:c36:cf3f? ([2409:4065:e85:380b:f208:953e:c36:cf3f])
        by smtp.gmail.com with ESMTPSA id c14-20020a170902d48e00b0016befc83c6bsm3487102plg.165.2022.07.10.20.51.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Jul 2022 20:51:34 -0700 (PDT)
Message-ID: <ac3f12de-a421-dfec-dd2c-e1aae2393515@gmail.com>
Date:   Mon, 11 Jul 2022 09:21:28 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2] gpg-interface: add function for converting trust level
 to string
Content-Language: en-US
To:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Jaydeep Das via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>
References: <pull.1281.git.1657202265048.gitgitgadget@gmail.com>
 <pull.1281.v2.git.1657279447515.gitgitgadget@gmail.com>
 <CAPig+cTX76ZMG_S-qOX_JDxYVWXRvtP2Ref4k8uM1KJaDwX9=w@mail.gmail.com>
 <xmqqwncmt3el.fsf@gitster.g>
 <CAPig+cScKabgrh80e5rqWX8cnNEgvxP9JyVJCu+afBOJk_yopg@mail.gmail.com>
From:   Jaydeep Das <jaydeepjd.8914@gmail.com>
In-Reply-To: <CAPig+cScKabgrh80e5rqWX8cnNEgvxP9JyVJCu+afBOJk_yopg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 7/10/22 11:14, Eric Sunshine wrote:
  
> I also am not a fan of making the caller free the result, and thought
> of mentioning it but didn't know if the approach implemented by this
> patch was suggested by an earlier reviewer.
> 
> 
> Given the small, fixed number of trust levels, and if the list is
> unlikely to change much in the future, I might suggest simply
> initializing the fields at compile-time rather than on-demand at
> run-time:
> 
>      static struct {
>          const char *key;
>          const char *display_key;
>          enum signature_trust_level value;
>      } sigcheck_gpg_trust_level[] = {
>          { "UNDEFINED", "undefined", TRUST_UNDEFINED },
>          { "NEVER", "never", TRUST_NEVER },
>          { "MARGINAL", "marginal", TRUST_MARGINAL },
>          { "FULLY", "fully", TRUST_FULLY },
>          { "ULTIMATE", "ultimate", TRUST_ULTIMATE },
>      };

Will do in next patch.

Thanks,
Jaydeep
