Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9B0CC433FE
	for <git@archiver.kernel.org>; Mon,  7 Nov 2022 19:25:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232401AbiKGTZO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Nov 2022 14:25:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232220AbiKGTZN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2022 14:25:13 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4386D286CC
        for <git@vger.kernel.org>; Mon,  7 Nov 2022 11:25:11 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id l2so7455022qtq.11
        for <git@vger.kernel.org>; Mon, 07 Nov 2022 11:25:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mhQzw5osKQnLAmI6JrhfUzaVRlBccZ8aEPO0meryuUM=;
        b=IoT7uWoWAQUHPIyCv81AIT/O2b8D3Xe7n54EmjQnpaDd5v87kPW4/I16W9h5yIssMo
         AxAPA2JMfNHalu+84+O4A/XmAtt7yx3hEiZ7tkC/vNk3tN8KPiVxIweZXZ125PIj7qt8
         XfnDiYjLnVLehxv0BES+ovE2BZoAp/iu4832V0P71gnh6ZD0P8ahiacb+5rW8Hmog9CD
         2D9INhDaPUofrdwEdW3A1EHKt7xoXvQqN2uaJZ92vRzNncuKDGvej3+9ZLo5CH69OErA
         9aDfd1/xwXPv4pbKnyQFTsUaWbtgCWXGXHg43TsT7rJxKcvxcfQ84h0olb6lFFB8i2z2
         W51A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mhQzw5osKQnLAmI6JrhfUzaVRlBccZ8aEPO0meryuUM=;
        b=diuhySL7cgjlQok3uRlkysTo3IvLzVTHtknNxqTDKAdVVPPqjYELvhAXp/EcDrYPsO
         WoRyaNOtUgfOetL9H9t5TlddpPJNGDL3clSGLm7bHCTLgAZ4oRhpd+z6Hl+Mm0iPgdDC
         3yiaiv3q70tR8EuaHXjBaA84XqhqudWE0xw4CnHtfqSbsUhwPBZ7Y8l40KaeM1ACFl06
         65UnNwNeD5XPlwfGIdf+t3u/0BmBYKR1o93LZwq3xC8wB4bNObW2+5jxyjWntzXOChZQ
         k4d7jJi/+JsuLm3s+bQwtyo6xPIjjlafKYpsPHxaFZH66Iq7gp4K63l66zBI0vPUTakv
         5DDQ==
X-Gm-Message-State: ANoB5pmvlwFqTR/9xmi8qC12anpxgnipAXv0qZ6JiQAUnoJU/oxNnOce
        IxNYwi8Msrxb+Yn0nhjgbLu7
X-Google-Smtp-Source: AA0mqf5uGbqWCttD4YlMeosTpL4VcHTUe4iRb3BrS1hACN2KYrsAVwYDEbQOyCGUG7PAKobj57ZStg==
X-Received: by 2002:a05:622a:1746:b0:3a5:84a2:ade2 with SMTP id l6-20020a05622a174600b003a584a2ade2mr6120065qtk.600.1667849110368;
        Mon, 07 Nov 2022 11:25:10 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:d948:f30c:63de:b667? ([2600:1700:e72:80a0:d948:f30c:63de:b667])
        by smtp.gmail.com with ESMTPSA id j11-20020a05620a410b00b006ce40fbb8f6sm7590299qko.21.2022.11.07.11.25.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Nov 2022 11:25:09 -0800 (PST)
Message-ID: <6c19845a-b7e5-da85-34d5-0461960668bc@github.com>
Date:   Mon, 7 Nov 2022 14:25:09 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: Re: [PATCH v2] rebase --update-refs: avoid unintended ref deletion
Content-Language: en-US
To:     Victoria Dye <vdye@github.com>, git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        "herr.kaste" <herr.kaste@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <20221104165735.68899-1-vdye@github.com>
 <20221107174752.91186-1-vdye@github.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <20221107174752.91186-1-vdye@github.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/7/22 12:47 PM, Victoria Dye wrote:
> In b3b1a21d1a5 (sequencer: rewrite update-refs as user edits todo list,
> 2022-07-19), the 'todo_list_filter_update_refs()' step was added to handle
> the removal of 'update-ref' lines from a 'rebase-todo'. Specifically, it
> removes potential ref updates from the "update refs state" if a ref does not
> have a corresponding 'update-ref' line.
> 
> However, because 'write_update_refs_state()' will not update the state if
> the 'refs_to_oids' list was empty, removing *all* 'update-ref' lines will
> result in the state remaining unchanged from how it was initialized (with
> all refs' "after" OID being null). Then, when the ref update is applied, all
> refs will be updated to null and consequently deleted.
> 
> To fix this, delete the 'update-refs' state file when 'refs_to_oids' is
> empty. Additionally, add a tests covering "all update-ref lines removed"
> cases.
> 
> Reported-by: herr.kaste <herr.kaste@gmail.com>
> Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> Helped-by: Derrick Stolee <derrickstolee@github.com>
> Signed-off-by: Victoria Dye <vdye@github.com>
> ---
> Changes since v1:
> - Modified approach to handling empty 'refs_to_oids' from "optional force write
>   empty file" to "always unlink"
> - Added/updated tests

This "always unlink" version is much cleaner. Thanks!

The new tests look great and I'm confident that they
are exercising the unlink() followed by a retry of
parsing the update-refs steps.

This version LGTM.

Thanks,
-Stolee
