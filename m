Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14B6BC433F5
	for <git@archiver.kernel.org>; Thu, 24 Mar 2022 12:05:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349893AbiCXMGu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Mar 2022 08:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240561AbiCXMGt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Mar 2022 08:06:49 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51EC19F386
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 05:05:17 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id t14so3653460pgr.3
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 05:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=v/0pEL6REV8i/DSmBAlGG7mf4hayHNIHAyzhEcc1idk=;
        b=WcBOt2J4wfHUVwP0DQ52He/s6Fyh/BIgbirwAxwhhis5yARm8Ae3dkQYwsfAMGkFAh
         Et/hIxd6AmtqloarFXxD86nU3eoTpUK3e+lfVnHdHTXVfmuZFaHccuo8UzJYzcQxqRIb
         7x3s9eBDCes8nYxGrbsgXSPrSNIeUi0p5aEepDc7SUs8jo7yBsJLQWiace0gvVva9ztT
         PH5KPJlurrpCSCfhiPCunU2qGEg+AZX1UzS0yoT6ZzAUV1xHn7KIby9tpBH7LrvaNamw
         bHRumhKd8tgxF4lAJ/47+UWu/GjHDMCNOVD3J9UoSBlxCwb15kuX9GOgAkL58d33iUte
         f4uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=v/0pEL6REV8i/DSmBAlGG7mf4hayHNIHAyzhEcc1idk=;
        b=0RXQ85H7gfLadRjuQ8XoBjUxg1IHDUPKVyb7vOGCc9qW5Gzq2TFJvJZM1TZFhmMQoE
         U5rMHVQAlVMSOxXlDb1o2FpyQcEPCfa+iulCecuG4icx+vkke/gQCIFJ8FFJYRonDXHx
         jWGH/ieMQsoy7kIjkuTFQ9KIbo6j5nH+mxpQ21x4nsXiwdGo9sHmhlt9moh5mI5KgMoV
         OHqNGM9PHYUr223SU4tzgx7kIBcCrWD5utHd/5shZacCC+ZYDElFxOruVWreoOhhYg5f
         5IxgNZuEn3FSQtOm/nvD6g2t32JQMuksPgkYbeUANCzQyAwFFzwv3OIrJZuNj043rjL3
         AKuA==
X-Gm-Message-State: AOAM533MljDULDd5mj3Vm9uyYUqCqShm4oOktkwO4kwpcYfoaTo95NLG
        md6b0sTK9O4i5LQdy/Mbiig=
X-Google-Smtp-Source: ABdhPJydGUWkedLihVZP+PsEi9UD+F23e69YHwGEweGe/Bq5QE/9S9/3MF/58kwgO5owgm3SPNOkyQ==
X-Received: by 2002:a63:475b:0:b0:382:821b:c17d with SMTP id w27-20020a63475b000000b00382821bc17dmr3885968pgk.250.1648123516640;
        Thu, 24 Mar 2022 05:05:16 -0700 (PDT)
Received: from [192.168.43.80] (subs32-116-206-28-24.three.co.id. [116.206.28.24])
        by smtp.gmail.com with ESMTPSA id e10-20020a17090a630a00b001c685cfd9d1sm2829628pjj.20.2022.03.24.05.05.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Mar 2022 05:05:15 -0700 (PDT)
Message-ID: <8f7ed9c5-9be6-55b4-f95c-40bf11d9e9ed@gmail.com>
Date:   Thu, 24 Mar 2022 19:05:11 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] commit-reach: do not parse and iterate minima
Content-Language: en-US
To:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Cc:     stolee@gmail.com
References: <20220323210803.1130790-1-jonathantanmy@google.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20220323210803.1130790-1-jonathantanmy@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 24/03/22 04.08, Jonathan Tan wrote:
> However, this is not the case when fetching with --update-shallow. In
> post_assign_shallow() in shallow.c, a revision walk is done that also
> parses commits at the shallow boundary before updating the shallow
> information (and hence, the graft information). (This revision walk
> needs to be done before the update because the nature of the update
> depends on the outcome of the revision walk.) If we were to
> revision-walk such a commit (at the shallow boundary), we would end up
> trying and failing to parse its parents because its list of parents is
> not empty (since it was parsed before there was any graft information
> telling us to conceal its parents). This revision walk will happen if
> the client has submodules, as it will revision-walk the fetched commits
> to check for new submodules, triggering this bug.
> 

What about fetching with --deepen?

Will "unintended" unshallowing with --update-shallow possibly happen
if --update-shallow is used, as opposed to --depth/--deepen?

-- 
An old man doll... just what I always wanted! - Clara
