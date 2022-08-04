Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A288DC19F2A
	for <git@archiver.kernel.org>; Thu,  4 Aug 2022 13:05:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239644AbiHDNFs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Aug 2022 09:05:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239634AbiHDNFr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Aug 2022 09:05:47 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D948EA1B2
        for <git@vger.kernel.org>; Thu,  4 Aug 2022 06:05:45 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id p82so934048iod.2
        for <git@vger.kernel.org>; Thu, 04 Aug 2022 06:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=fxO0DmQD3hVofYKG0YDeHOH5lFt7n+Te+Bk0OBBmnHw=;
        b=SHC3QR+fyYQBNCviSovawooLk5Zx6Q1Vd9ne5CacxvEQI+/q3yWRX0q/4YvplE/K+q
         y7jo2GSMgnLO4HjE8NYAWbIWeH4dnLohyz/GzJkvwJ7KtNJF41fV9aJREmNDlIAl6xUb
         TfVhJaFMOsLIfYr41sr+bys3fTxvadyfDvnDMtXcw/frPX3DlZvAbKbBClm5PknMPhQj
         CDMyfUY7AnVzAQMQnjHwmwgRtW+HIAutci7+rFDO7dXM0aBY1BFcfhZKvj4UPPlmswE5
         H6FApAfJMWJOc4Rzi09fbQIsCYYZ3lbelLn3gHTG3+hjOdJkc9encCdjaiVh/BiL2Ppz
         IFpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=fxO0DmQD3hVofYKG0YDeHOH5lFt7n+Te+Bk0OBBmnHw=;
        b=4nYDO+ecKXkr3U0AfDltzYRfihm2dtrgXpItiOWQRthezzYKYMUozUQ+pD+pUN+a+s
         0kYfHol98gbL9bgsxm+aFs7y1bIMgUsj2ucFyVBVv/kV+4H1lJ08t47fMJqrWnQU4f5Q
         IJ4wbWfMVu4+Omplm6FiPaD8bZcfx9vaLXwBuL4RhnKJjwqT0PiX82C2QJ6LtngRLSrD
         roxSc2wdoWEe+XXfxu61LsVzwr5HP1cQ5dvVBWWyw7WvdjG4oSUSOyayry5bBl5CyJCr
         DknB4N8ass/21ZpjRQu5li7HqU+zeF2193Nx4aF9g21JCuk/DkLsXnRn0jXnw2OqU7Ek
         z/Pw==
X-Gm-Message-State: ACgBeo1naq7RrX6vNQN7UB1yTotymRHZM9XCBh3fZYxdKJaDqc74sNBW
        /QcvstllCgFdMkp8jMYQq4pz
X-Google-Smtp-Source: AA6agR7oWBQy8+XvoGcWgLx3I8iJRkwUN2jBC9RXkvp3Y4HxC/KDqjaSPFNiQWyW2lsdfvszRWiPiQ==
X-Received: by 2002:a5e:8216:0:b0:681:4dea:6f2a with SMTP id l22-20020a5e8216000000b006814dea6f2amr736651iom.206.1659618345248;
        Thu, 04 Aug 2022 06:05:45 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:8b6:bc6e:e88:13d9? ([2600:1700:e72:80a0:8b6:bc6e:e88:13d9])
        by smtp.gmail.com with ESMTPSA id bg12-20020a0566383c4c00b0033f4b1c2151sm412634jab.154.2022.08.04.06.05.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Aug 2022 06:05:44 -0700 (PDT)
Message-ID: <6803b725-526e-a1c8-f15c-a9ed4a144d4c@github.com>
Date:   Thu, 4 Aug 2022 09:05:43 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 2/2] config: let feature.experimental imply
 gc.cruftPacks=true
Content-Language: en-US
To:     Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org
References: <20220803205721.3686361-1-emilyshaffer@google.com>
 <20220803205721.3686361-3-emilyshaffer@google.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <20220803205721.3686361-3-emilyshaffer@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/3/2022 4:57 PM, Emily Shaffer wrote:

> +	/* feature.experimental implies gc.cruftPacks=true */
> +	git_config_get_bool("feature.experimental", &experimental);
> +	if (experimental)
> +		cruft_packs = 1;
> +

This should be grouped into prepare_repo_settings() in repo-settings.c
so we have a single place to see what is updated by feature.experimental.

Thanks,
-Stolee
