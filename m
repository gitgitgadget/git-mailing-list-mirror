Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A04E8C433F5
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 05:42:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BB8761BFD
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 05:42:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbhKOFo6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Nov 2021 00:44:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbhKOFo4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Nov 2021 00:44:56 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A155DC061746
        for <git@vger.kernel.org>; Sun, 14 Nov 2021 21:42:01 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id z6so14061731pfe.7
        for <git@vger.kernel.org>; Sun, 14 Nov 2021 21:42:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=jgVaMpDP1tsBmWPcKhYfroXouETWScAyfjulTDjH5Ok=;
        b=ohGIIViQdQURl6XxcB33WFUnNMGaweKDhLb8o3osKQaEyFL9sK9xIfz6hPI7LpWWTN
         Aw6GV9CtH1sJf5zjQUh9wFRpAoCwudncSh8zmEwd43VteQwTptWsh96Ao3Yyx49PMa02
         JaFDuoJpPznbaF5EL5+nsYsAEdzq+aFKGJRbyaKNWUpwki2YQn5XYw/cAlmz3jsFXLOF
         7eqh6AEAaphViJfkL8dc0xpGgLVP0T/nqVz1m7BfAzvtmEtrqOsKP0tUOqfASir2JZfM
         6VyWc8CoSY123oMwVAcHrzWwwI9ZQzGBJ9zMC7tF6DBoTqHtHUPBd967rQqxOtMsPbYk
         H/gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=jgVaMpDP1tsBmWPcKhYfroXouETWScAyfjulTDjH5Ok=;
        b=f7U8Wp/D/R1he9s8gYtl4EMbeUR0lu3zgi2M9WTPD2oDiPYJ9UflnGRplopgCPmY2V
         MhwASfcHEHEMajQz9lqeWDzkv5GIxbRInoke+yEFYqaprq2MHt53qpPtLtQFhxjsO6Ob
         kbyPf7vo+ux5ZUaDqA5xmF5pbn+AdAwx8LbDAJSndrp9YSgCTh1OpQBrk4ud6wsVSKWS
         LWrbnxHnLLIzxzGREBrxqSpwrdlwbCtppHoa3DgTCWbgTcdneDoHBY/cS+RIeCDoJezC
         4NbqnAOS4udDV4H+vX7C7jcg6GOaItNOAuFs5C9n8m/PnLSzW0dnr+4Vp87tV7/61/TJ
         UXsw==
X-Gm-Message-State: AOAM5332BC/UYMjou9+1Mn3fRqaB+kMY9uP9ClNP0odfNGdTScIQboqy
        3hNm8A9AbfJM9/bdBsBMYMA=
X-Google-Smtp-Source: ABdhPJxA//DzC6M/mVQk0bhym5JnkaxzeFoOcvtOil0l/ZtTQHyis3CftAXJdGXxV2Fh8KYanZU0Dg==
X-Received: by 2002:a63:5664:: with SMTP id g36mr22801760pgm.243.1636954921087;
        Sun, 14 Nov 2021 21:42:01 -0800 (PST)
Received: from [192.168.43.80] (subs02-180-214-232-80.three.co.id. [180.214.232.80])
        by smtp.gmail.com with ESMTPSA id md6sm11227012pjb.22.2021.11.14.21.41.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Nov 2021 21:42:00 -0800 (PST)
Message-ID: <2a4428a5-91d9-a0a5-39cd-eefa1c92024e@gmail.com>
Date:   Mon, 15 Nov 2021 12:41:57 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] fetch-pack: add TRANSLATORS notice for packfile ready
 messages
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        Christopher Diaz Riveros <christopher.diaz.riv@gmail.com>,
        =?UTF-8?Q?Jean-No=c3=abl_Avila?= <jn.avila@free.fr>,
        Daniel Santos <hello@brighterdan.com>
References: <20211114073143.84004-1-bagasdotme@gmail.com>
 <211114.86czn3t676.gmgdl@evledraar.gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <211114.86czn3t676.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 14/11/21 16.50, Ævar Arnfjörð Bjarmason wrote:
> If something isn't meant to be translated do this instead:
> 
>      die(_("expected no other sections to be sent after no '%s"), "ready");
> 
> I.e. pass it as a parameter.
> 
> There can then be a "TRANSLATORS" comment that explains that it's the
> string "ready", in reference to that protocol keyword. We do it that way
> in various other places, and it completely avoids the potential problem
> of a should not be translated string being translated.
> 

Something like:
/* TRANSLATORS: The 'ready' string is the protocol keyword. Leave it
    as is. */ ?

But I have admitted that I lean to your suggestion.

-- 
An old man doll... just what I always wanted! - Clara
