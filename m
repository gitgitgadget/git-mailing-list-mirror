Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1EE0C433EF
	for <git@archiver.kernel.org>; Mon,  7 Mar 2022 20:51:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245295AbiCGUwl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 15:52:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245299AbiCGUwk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 15:52:40 -0500
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6B6F2A73E
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 12:51:45 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id eq14so7105355qvb.3
        for <git@vger.kernel.org>; Mon, 07 Mar 2022 12:51:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=IBKUq4PPn81mmi2V69Cm6l8GjBVV/l7hxVVPz21T5Ys=;
        b=HrUNEkad8zn8ogZ7+G+FkjOe/z0PTtm+F9/8zCju0qLaMrvuZE57Ebx3OUs2bDaebF
         Qzp8/0gTnNlFzpjnpbaEzHSHop6Vz3BFpT0Yy+C6yINrX+jf0HOPCZTTcE8Ph48dO5xM
         NerqkSltXXjCjsOxQNgqCHi6ZwjWO4CKzfdi3zBWQ4kxqNqx5D1hbbTcuKf2KG3jcBFz
         Ve+xUEbPXqy4K67HLSZX6uVkTDXMDCLSO2J72bxyWdaUSiziFYSi8s2FCxgRdYp+Hu7j
         JKd1f6LsVHRTq148GbovJVT7N1QLaMhAAYdy8QbVNxJyY3XeZR8FORxySMpt3iGt6gg/
         /aVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=IBKUq4PPn81mmi2V69Cm6l8GjBVV/l7hxVVPz21T5Ys=;
        b=nEGi9PnoVnaKjxNhQ3noLcII9AyMDhse7DduJmWse1nraiwyaF9U3uAef+Ww/TUSi5
         aAFUNT5pnR6A5LJxZaXTP+a8k4ZdGd7vZYya9ZfH/TKBgxCAt7LBu0N4F2j4bG6qXZAg
         oK1kkGde2THEEG3GqvfEkFCjAqujbvkwCcYIoE8ZefZMgufl4Xy+fKeD4fCeV7iq6jrX
         kgBJd7duPkL+WuH22bJQo4ERTQvdRXUlRbC4+wIiwaosNfEBESEAA+bmcUl1QTOxvHOP
         rDekQz+20iAPtPzdQrPNiyVfSYhVD3sLs9aCT6eif5FwlXQOCQLQKAq4PB0KLkU09HRP
         e6lg==
X-Gm-Message-State: AOAM530XKasWD7DOBZOnWxDA1l2tKGXTjVBJWtc9Ic2Gu3H1T1yKOdZE
        L9xq/MD+s/c9ib9XI9I1eviVhKlOWOqy
X-Google-Smtp-Source: ABdhPJwlPThi4TejP+mHDSePU9hAvREoE3LjhhCpWss7cewyoAGfpRmQMYSYiDPOj5G3/dkg+geeXw==
X-Received: by 2002:ad4:5dc5:0:b0:435:aaec:5407 with SMTP id m5-20020ad45dc5000000b00435aaec5407mr318408qvh.89.1646686304673;
        Mon, 07 Mar 2022 12:51:44 -0800 (PST)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id y17-20020a05622a121100b002e0702457b2sm19198qtx.20.2022.03.07.12.51.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Mar 2022 12:51:42 -0800 (PST)
Message-ID: <332f9b54-edfb-50e7-46a7-2e46d3b574e4@github.com>
Date:   Mon, 7 Mar 2022 15:51:40 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: tb/cruft-packs (was Re: What's cooking in git.git (Mar 2022, #01;
 Thu, 3))
Content-Language: en-US
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
        git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <xmqqv8wu2vag.fsf@gitster.g>
 <0870b8f0-976a-cf2f-f34f-7e966b9c426f@github.com>
 <YiZJiPVMZwPXbfrK@google.com> <YiZMhuI/DdpvQ/ED@nand.local>
 <ebfac323-7567-6327-f5e6-0fd9e0356550@github.com>
 <YiZoojeTodMr+Ypw@google.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <YiZoojeTodMr+Ypw@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/7/2022 3:18 PM, Jonathan Nieder wrote:
> Derrick Stolee wrote:
>> On 3/7/2022 1:18 PM, Taylor Blau wrote:
>>> On Mon, Mar 07, 2022 at 10:06:00AM -0800, Jonathan Nieder wrote:
> 
>>>>  2. Marking this as a repository format extension so it doesn't interact
>>>>     poorly with Git implementations (including older versions of Git
>>>>     itself) that are not aware of the new feature
>>>
>>> The design of cruft packs was done intentionally to avoid needing a
>>> format extension. The cruft pack is "just a pack" to any older version
>>> of Git. The only thing an older version of Git wouldn't understand is
>>> how to interpret the .mtimes file. But that's no different than the
>>> current behavior without cruft packs, where any unreachable object
>>> inherits the mtime of its containing pack.
>>>
>>> So an older version of Git might prune a different set of objects than a
>>> version that understands cruft packs depending on the contents of the
>>> .mtimes file, the mtime of the cruft pack, and the width of the grace
>>> period. But I think by downgrading you are more or less buying into the
>>> existing behavior. So I don't think there is a compelling reason to
>>> introduce a format extension here.
>>
>> In particular, older versions would first explode unreachable objects
>> out of the cruft pack and into loose objects before expiring any of
>> them based on the loose object mtime. There is no risk here of causing
>> problems with older versions of Git and does not need an extension.
> 
> Surely when older and versions are acting on the same repository, they
> would fight by exploding out unreachable objects, packing them back
> into a cruft pack, etc, no?

You are referring to a situation where there are multiple possible
versions responsible for maintaining a repository. Git does not
support parallel writers doing significant updates like full
repacks and GCs and instead relies on the user to control the
concurrency there. The standard we keep to is that parallel readers
can still access the repo during this time.

If someone was running a case where they had these parallel
maintenance processes, then they would already be risking failure
with existing features (though actually in the case of the old
versions breaking the new ones): what if the new/old versions
differ in their understanding of the commit-graph? The old one
could remove commits but not update the commit-graph, leaving
extra commits in that file that the new one would fail to verify.
How about the multi-pack-index? The new version would try loading
objects from missing pack-files since the old version deleted
those packs without updating the multi-pack-index.

At least in the cruft packs the worst case is that no objects are
ever expired because they are toggling between loose objects and
cruft packs.

Thanks,
-Stolee
