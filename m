Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF4FAC25B08
	for <git@archiver.kernel.org>; Wed, 17 Aug 2022 17:45:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240941AbiHQRpO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Aug 2022 13:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241017AbiHQRpK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Aug 2022 13:45:10 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FBB25A2CA
        for <git@vger.kernel.org>; Wed, 17 Aug 2022 10:45:09 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id mn10so5845815qvb.10
        for <git@vger.kernel.org>; Wed, 17 Aug 2022 10:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=6kJFkI4ww/tO6QXP071+qqZx/hiCdGMRIKY+cnRtiTA=;
        b=SN8nWiKnYAPFAdqsVqsb2uVmpYyPIsUYHUL9P3XPf5Th1msLG2e71n/TAKhjI+jB8e
         2AXDilJaso08pGFm6C8P1+TpNYX4+OnKRVO2j/Cm5umnD2iuFkkriqhBfwiBcVEccu2Z
         1NHeHSMbQmvjNhXCAnJWsi+l1lCTpQxGqDCChSb86awNM2Fml+aBdGVpagy0oCQyqxRx
         Uu058A7EFcO5lTuaZpT1ZpUDhdcXhcI0IDCO7W7rChgStATQtaF3AdWCKIdu7OQM4fNh
         7oze1Qdh1wWyWXurigWjv28dsDl04Rw9ZrUg5ayHR6nYsq13ZMq6qECyH6FrIE1IyVhh
         n4IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=6kJFkI4ww/tO6QXP071+qqZx/hiCdGMRIKY+cnRtiTA=;
        b=s9O+TJA0GVYM4zc4MuEpPd3XZ1Mm3T0ecIpAYJv9up39QEl5BsFM731TUGp8dtJn9W
         XIloG1d21DkeWcyW9WJN2PoO7WdqswA/2cmlJ+CDQRf7p7An8iClMATbDEG4ExCZy07g
         /+gMkMMmW6+DBGC1b2+fp6524v44BGxc7Av5g/EU6uvtwF3NYI7trL6b77VVF/FfyUI0
         68+FbRB7CHaxeFprioxJ7QQWfz59m6jbfcGOpx24S4FIXGlvsj5Oy2qql1CG2LHXism2
         /MKcFmtp0upyU5qBYc9m0o+RNzrnHWk6vNiyRsaOLFv8vHcrsE9NUhK2jFAPCr2B/w5D
         ZQWw==
X-Gm-Message-State: ACgBeo1gYZKC5FKluQgm7RQwBafUdYCjmcUEqLrVZCqSmjFTmkNk3wtC
        +hQbp0K0jlL7avQOeKaPyIfU
X-Google-Smtp-Source: AA6agR4sy9ZclZLN6m3dSBRDrK+uAxQPfetJmWHRgjr6/qdpIkCIEJJEjyjDbtS7oStZtpZQbC7Q1w==
X-Received: by 2002:a05:6214:e81:b0:476:8403:d044 with SMTP id hf1-20020a0562140e8100b004768403d044mr22241133qvb.18.1660758308265;
        Wed, 17 Aug 2022 10:45:08 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:f8cc:7049:fd75:5ebd? ([2600:1700:e72:80a0:f8cc:7049:fd75:5ebd])
        by smtp.gmail.com with ESMTPSA id w17-20020a05620a0e9100b006bb568016easm5421016qkm.116.2022.08.17.10.45.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Aug 2022 10:45:07 -0700 (PDT)
Message-ID: <9012f1f6-eab6-115a-ab23-d51e5dedb358@github.com>
Date:   Wed, 17 Aug 2022 13:45:05 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2 4/5] scalar unregister: stop FSMonitor daemon
Content-Language: en-US
To:     Victoria Dye <vdye@github.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     johannes.schindelin@gmx.de, mjcheetham@outlook.com,
        gitster@pobox.com
References: <pull.1324.git.1660673269.gitgitgadget@gmail.com>
 <pull.1324.v2.git.1660694290.gitgitgadget@gmail.com>
 <fc4aa1fde31fa0726cde2c1d4e41f3f140fff6f6.1660694290.git.gitgitgadget@gmail.com>
 <2cbbd732-b9e7-fe8b-9c77-f86a856d06c7@github.com>
 <6c39fc96-2e88-297e-38df-4bcb88447972@github.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <6c39fc96-2e88-297e-38df-4bcb88447972@github.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/17/2022 1:36 PM, Victoria Dye wrote:

> So I think you're right that it should only be associated with enlistment
> deletion (although I think 'delete_enlistment()' is the place for that -
> right before 'remove_dir_recursively()' - rather than 'cmd_delete()').

Ah. You're absolutely right about that.

Thanks,
-Stolee

