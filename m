Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 347DFC433EF
	for <git@archiver.kernel.org>; Wed, 15 Jun 2022 12:41:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232224AbiFOMln (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jun 2022 08:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231861AbiFOMlm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jun 2022 08:41:42 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE9043F308
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 05:41:40 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id f13so8033237qtb.5
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 05:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=AgyMkeqPoOPVhjZokcXD7f8p4k4pjAM0Y1WoHRx0LMk=;
        b=CEy9GN1f2KCbevYCmXo4/HHarnyJm1ge7GMdpUyAmeeg0jIxgSRFvTxZkHN4lHEi1E
         2fJGlLXA1D/WAAPeJqfpxbHv2O1ZQt1Ptf3FK3EafHX8P1RybySM6K8N7FOdsOse2kK2
         6RerzI6VF5fCQuA3XSgKJiXJ91m1iy2j891pO6uhvBhmucfRjpMGMk9tdl3W6V1eurdx
         ER99dTWUzwVmTnOch6u3SzAsR3fkEMAHVwKvcIhCHG/A6LIgB0ALqo93fG3rKL8/26ej
         uxr0UfTF9VzfR6BLCx4WLF4ddPHFLMJ7FhJ8LPdPLvtIQHadwtAqPo5VBXDqXWvAvi09
         Kwjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=AgyMkeqPoOPVhjZokcXD7f8p4k4pjAM0Y1WoHRx0LMk=;
        b=t3Bl5p7UJhJXuFWAS5zgVn/xWtf3nrxuwZXqym87fzO3zGL5C3fGUs2ILsrGQy1t24
         cYRY8+OnbH2jDEROkr2a7GZGIB8p5Dzovl6fyg0KlLWko+ViurYgTFbpTHlutdMHeZEM
         Jx59O+01M4StwOEUwdP+Vi9arAaW0RSliWddBlK8a4EwsAmRY1+kkFTgqlhaO4NHXIY9
         vIpglaWSVV4u0tb/vJB9fytYCWNYTazvhIt/cM+B1JiqUZqfbDzLq/iBe/MnyiKhMk65
         vD+WpNS+IQxUE6jUMZC0QQqqH7sHZehO2vAt/sfYwV0ssEyR49PjAJLN2a8OLQ1Ztt56
         xDHg==
X-Gm-Message-State: AOAM53365yqLynq0ZqbsF8iaSgzhWaWOMkHtctEXcEl1AR4Z6Havd+Qo
        i2p/cIZGdG3I36OSBHKLRW3EWc4tRoRe
X-Google-Smtp-Source: ABdhPJx9kaUXGMDYaWzWS/wIJLl5F58hwbJ3llOX/LzDCcTLwq4BjGunfqmMqz79UKrIpVCYRwW1tg==
X-Received: by 2002:a05:622a:1b91:b0:304:ff21:288e with SMTP id bp17-20020a05622a1b9100b00304ff21288emr8566643qtb.397.1655296899924;
        Wed, 15 Jun 2022 05:41:39 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:900f:fa9e:132:1bde? ([2600:1700:e72:80a0:900f:fa9e:132:1bde])
        by smtp.gmail.com with ESMTPSA id o22-20020ac85556000000b002f93c5444e3sm9339436qtr.52.2022.06.15.05.41.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jun 2022 05:41:39 -0700 (PDT)
Message-ID: <cbba9f52-8ebe-40f2-739e-0796cf60b05c@github.com>
Date:   Wed, 15 Jun 2022 08:41:38 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.1
Subject: Re: [RFC PATCH 3/5] CI: add a linux-BUILD-vars job
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
References: <RFC-cover-0.5-00000000000-20220615T104503Z-avarab@gmail.com>
 <RFC-patch-3.5-d69368c5b39-20220615T104503Z-avarab@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <RFC-patch-3.5-d69368c5b39-20220615T104503Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/15/22 6:53 AM, Ævar Arnfjörð Bjarmason wrote:
> Add a linux-BUILD-vars job, in a preceding commit we fixed a bug that
> would have been spotted by testing under NO_CURL=Y.

You'll want to double-check patch order before sending a full version
for review.

Also, why capitalize "BUILD"? I suppose the variables are all-caps,
but our job names are all lower case to this point, right?

> This CI job attempts to unset various settings in config.mak.uname and
> the Makefile, so that we'll stress our fallbacks and conditionally
> compiled code as much as possible.

I think it is a good idea to include a job that tries these "as
minimal as possible" builds.

> If there is a missing setting here that we can enable under
> "ubuntu-latest" the omission isn't intentional, this list came from a
> quick skimming of the relevant parts of the Makefile and
> config.mak.uname.

We can extend this in the future if we discover something new to add.
The important thing is that this moves us in the right direction.

Thanks,
-Stolee
