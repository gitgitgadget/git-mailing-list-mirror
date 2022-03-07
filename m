Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36CF6C433FE
	for <git@archiver.kernel.org>; Mon,  7 Mar 2022 18:32:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240306AbiCGSdT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 13:33:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240208AbiCGSdS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 13:33:18 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7612265801
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 10:32:23 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id w127so5772011oig.10
        for <git@vger.kernel.org>; Mon, 07 Mar 2022 10:32:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Afxph1CaiJQuRJTd+V/XysAfJghksEd5SGOgTWZ5ewo=;
        b=crH//rgfC9vY+aF2pH8wNCZftzsdD/GyPS5nNYJkMKieho0sqo/0gJ4iTtCKfEW+KP
         HpIH+5cHdMpoARAjdZ/SITorKDbIBrVeQpWMQy0Z3eju6w6b+IvWNnTul/mtY+w+GWis
         j7r+CewhUd1MdUWhON15YmoCMJANAU05t0PBIeD2eMgJntv4oekrmDHvm5ZtFjwmI0p+
         8GkYrG9VSRAz+dk31Y3TpZAp1dTbP8wm3Kz7NWDL7SCNPdnOAK02/RBFP2VVq5Q/ZUXX
         r3i4q8P7iyPvgp1dd3vnKyFLkWXp4iVlGIhHbdRCcLPcCnry9SR4PN8YWeijVgeRa+hq
         1KZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Afxph1CaiJQuRJTd+V/XysAfJghksEd5SGOgTWZ5ewo=;
        b=fQOfQwc+tQvpre5LzZqwVtUR8SCV/qPB4vxoX2hIr/UbgQ6tAA54NiFxJ2+4kDoAOj
         K6nx1B1qGmJo1paRaQHrKBL9iPAb5TAxjPCWrkfb/xWGWLRl0WUvz/qEqUb9gYA0tbz8
         5bZ6GiU4StH1x81K38EZlR3+1+6LnpCkJaF0sE4QTF47loevIHHtkV4H8SU/pdIvpV1w
         Xk/pknahGQG+bEKkbzVRNRCgSV0/G5ABXjlzynIVNTlvh2O5c6UbsAu0DXCGZ2X7FP4c
         inR7WlB7TozoWPW7nTY4lCDjGSiWtDl5bFO6K2qUmw/WsqO5B8rxvsYZT1M2DR7cX7AD
         cSEQ==
X-Gm-Message-State: AOAM532dW9iPbs27a4e/kZf4dOLZarNUtH94S1tOHCMhdcOH+Y3OnODo
        DQbQq3DfOisPDR6jp/kZmjE7
X-Google-Smtp-Source: ABdhPJxxK7+NP7lznOnB4w7O+wTsHCvjajFR+KumS9cd43gjEHSLAzOqjP14CljVhCKUOfgGePepvw==
X-Received: by 2002:a05:6808:1914:b0:2d9:a01a:48bb with SMTP id bf20-20020a056808191400b002d9a01a48bbmr178569oib.262.1646677942813;
        Mon, 07 Mar 2022 10:32:22 -0800 (PST)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id bp8-20020a056808238800b002c6b56d99bcsm7058922oib.13.2022.03.07.10.32.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Mar 2022 10:32:22 -0800 (PST)
Message-ID: <ebfac323-7567-6327-f5e6-0fd9e0356550@github.com>
Date:   Mon, 7 Mar 2022 13:32:19 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: tb/cruft-packs (was Re: What's cooking in git.git (Mar 2022, #01;
 Thu, 3))
Content-Language: en-US
To:     Taylor Blau <me@ttaylorr.com>, Jonathan Nieder <jrnieder@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <xmqqv8wu2vag.fsf@gitster.g>
 <0870b8f0-976a-cf2f-f34f-7e966b9c426f@github.com>
 <YiZJiPVMZwPXbfrK@google.com> <YiZMhuI/DdpvQ/ED@nand.local>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <YiZMhuI/DdpvQ/ED@nand.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/7/2022 1:18 PM, Taylor Blau wrote:
> On Mon, Mar 07, 2022 at 10:06:00AM -0800, Jonathan Nieder wrote:
>> I'm excited about this work!  I just sent a quick review to the
>> design doc.
> 
> Thanks! I haven't had a chance to look at the design doc, but let me
> respond quickly to this message:
> 
>> Before merging to 'next', I'd be interested in two things:
>>
>>  1. Marking the feature as experimental so we can learn from experience.
>>     Clarifying what aspects we consider to be stable / set in stone and
>>     what are subject to modification.
> 
> I'm not sure there is much practical benefit to marking this feature as
> experimental. The only new file format here is the .mtimes one, which
> should make it easy for us to modify the format in a
> backwards-compatible way.
> 
> If there are other benefits you had in mind, I'm curious to hear them.
> But I think we should be fine to "lock in" the first version of the
> .mtimes format since we have an easy-ish mechanism to change it in the
> future.

I feel similarly to Taylor here.

>>  2. Marking this as a repository format extension so it doesn't interact
>>     poorly with Git implementations (including older versions of Git
>>     itself) that are not aware of the new feature
> 
> The design of cruft packs was done intentionally to avoid needing a
> format extension. The cruft pack is "just a pack" to any older version
> of Git. The only thing an older version of Git wouldn't understand is
> how to interpret the .mtimes file. But that's no different than the
> current behavior without cruft packs, where any unreachable object
> inherits the mtime of its containing pack.
> 
> So an older version of Git might prune a different set of objects than a
> version that understands cruft packs depending on the contents of the
> .mtimes file, the mtime of the cruft pack, and the width of the grace
> period. But I think by downgrading you are more or less buying into the
> existing behavior. So I don't think there is a compelling reason to
> introduce a format extension here.

In particular, older versions would first explode unreachable objects
out of the cruft pack and into loose objects before expiring any of
them based on the loose object mtime. There is no risk here of causing
problems with older versions of Git and does not need an extension.

Thanks,
-Stolee
