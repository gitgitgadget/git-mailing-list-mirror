Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6A44C433F5
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 10:01:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C2176136A
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 10:01:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349723AbhI3KD1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Sep 2021 06:03:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238316AbhI3KDN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Sep 2021 06:03:13 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65470C06176A
        for <git@vger.kernel.org>; Thu, 30 Sep 2021 03:01:30 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id w29so9071886wra.8
        for <git@vger.kernel.org>; Thu, 30 Sep 2021 03:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=hOExkUyCnmMN9zGuNsWSGWnRwyyRqQ2W4BQosKgUJXo=;
        b=DVfQwxfUk48fSwPix+NjVkh6mookJjPH7TB9BHVvYp/0g/kiC54ScIyjBuDUnL/5+S
         GUlYnCzwKvhCEtDLgK1J3N2PLPlIktN1Rc5ie+71Dc+l+sDMkFmJt0g788u0mEJ+911p
         SECY3HaijTCGUx6Bia4HkS2HimwosSF88iUrrrAWU4T7AtlPhC2zayqEnH2JsyJstme9
         iU/klpl62IJA6Mxh0ZSWp3xstvyod86wmOjEVlecz+L/lHe6FkdwcAlERsLrJF1k4oGf
         vWY+DBfWDNu60n6JPYiN3pbOrcEiZNdeEGyhbUS+ZnBlJWPjFnm77iRRVlwQQh+Xew9r
         KwPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=hOExkUyCnmMN9zGuNsWSGWnRwyyRqQ2W4BQosKgUJXo=;
        b=OUwtdnAUTYHrwsTXQ+4u7mV1t5GEi/J/LacYk20hyt2neNT3sMGwd9ORJ0ttLD03ve
         tUvQFtDhh3Dz39fyOb+EZU0HyG9f0Tz2Zabvu692QxQjpaytj7+Atjwguc4Tby8bs7fY
         7buiXunudXlvtFhHTU6YfjvRL70V2vK5kGolyxS2e7+U9H56D2rM6a1VpBjMCXb7g+gj
         xppKJj6IKZbrCpkmpQ4fhYJ0qipnLtqvXW+B27sUaU0R/oKT5SY5m+jAOhya/TGUPoZv
         C4t4vX9oM55vcnqyVoY3A55a/Pm6jm/i43YOIf9Ar6zknK544vXVovE1rScWtKv5zcyD
         abMQ==
X-Gm-Message-State: AOAM532Zh9NNmTlZ24ZvsYSplZYRV7gl4GLkPiDP1BlVMK/wJjSGRTV1
        GNYc9o78eMvDPLeKms5jQ7MHo840ZZ8=
X-Google-Smtp-Source: ABdhPJz0Drj3npH2L+1Pe2DHnezjw9g9UKBEM6J4MAT/BpJ+rcCoK+eP6ygsc9P6Vh3Bkg9G5j4nlA==
X-Received: by 2002:adf:a499:: with SMTP id g25mr4583307wrb.239.1632996089057;
        Thu, 30 Sep 2021 03:01:29 -0700 (PDT)
Received: from [192.168.1.201] (178.2.7.51.dyn.plus.net. [51.7.2.178])
        by smtp.googlemail.com with ESMTPSA id o1sm2534519wru.91.2021.09.30.03.01.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Sep 2021 03:01:28 -0700 (PDT)
Message-ID: <05770f9c-49e9-2572-d610-dcbd2b97cca3@gmail.com>
Date:   Thu, 30 Sep 2021 11:01:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 5/5] cbtree.h: define cb_init() in terms of CBTREE_INIT
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
References: <cover-0.5-00000000000-20210927T003330Z-avarab@gmail.com>
 <patch-5.5-7e571667674-20210927T003330Z-avarab@gmail.com>
 <ef724a3a-a4b8-65d3-c928-13a7d78f189a@gmail.com>
 <87h7e61duk.fsf@evledraar.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <87h7e61duk.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 27/09/2021 12:00, Ævar Arnfjörð Bjarmason wrote:
> 
> On Mon, Sep 27 2021, Phillip Wood wrote:
> 
>> Hi Ævar
>>
>> On 27/09/2021 01:39, Ævar Arnfjörð Bjarmason wrote:
>>> Use the same pattern for cb_init() as the one established in the
>>> recent refactoring of other such patterns in
>>> 5726a6b4012 (*.c *_init(): define in terms of corresponding *_INIT
>>> macro, 2021-07-01).
>>> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
>>> ---
>>>    cbtree.h | 5 +++--
>>>    1 file changed, 3 insertions(+), 2 deletions(-)
>>> diff --git a/cbtree.h b/cbtree.h
>>> index a04a312c3f5..dedbb8e2a45 100644
>>> --- a/cbtree.h
>>> +++ b/cbtree.h
>>> @@ -37,11 +37,12 @@ enum cb_next {
>>>    	CB_BREAK = 1
>>>    };
>>>    -#define CBTREE_INIT { .root = NULL }
>>> +#define CBTREE_INIT { 0 }
>>>      static inline void cb_init(struct cb_tree *t)
>>>    {
>>> -	t->root = NULL;
>>> +	struct cb_tree blank = CBTREE_INIT;
>>> +	memcpy(t, &blank, sizeof(*t));
>>>    }
>>
>> Slightly off topic but would this be a good site for a compound
>> literal test balloon?
>>
>> 	*t = (struct cb_tree){ 0 };
>>
>> Compound literals are in C99 and seem to have been supported by MSVC
>> since 2013 [1].
> 
> I think that's a good thing to test out, FWIW I've also tested it on the
> IBM xlc, Oracle SunCC and HP/UX's aCC, they all seem to accept it.

Thanks for taking the time to test those other systems, it's good to 
know they support compound literals

> But I'd prefer just doing that in some general follow-up to bd4232fac33
> (Merge branch 'ab/struct-init', 2021-07-16), i.e. let's just use the
> init pattern it established here.

I agree it makes sense to introduce it as a separate series. I'm not 
sure if there is a pressing need for them but it is the sort of thing 
that is occasionally useful.

Best Wishes

Phillip

