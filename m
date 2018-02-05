Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 92FCC1FAE2
	for <e@80x24.org>; Mon,  5 Feb 2018 21:27:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752156AbeBEV1t (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 16:27:49 -0500
Received: from mail-vk0-f43.google.com ([209.85.213.43]:38141 "EHLO
        mail-vk0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752124AbeBEV1r (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 16:27:47 -0500
Received: by mail-vk0-f43.google.com with SMTP id z9so18588799vkd.5
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 13:27:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=oNT4A2/m3jbIaYO0N8HurbMDlZJCjkOcp+KTZQeREtE=;
        b=Ln/eYgCOHwS44Cn6PAaKXWgJJmcJLY08uRwshhKA8ABF0tLxaBV5st6xx2bc1N7+y2
         wAZJZkWt0g8McHcU8jh/rS7tFRlzdwbHN1Gy7XvtCo0DMCtSQ8B00GMR8S81wAejrLM0
         amTbT2nF8heHY++5uE8n1w1xQ4YJ1aDXPWEFGB4B3HdrPi3SPcsUuIeIMcPG+90vd2EE
         w2mQEqJ7T1VHIWYQe9nL7pkP40iUUU1h15KL+9nq8KEbuf0uLWCdSzs6ZyyM+MuavCIf
         lymdH3JqzMYKbmWxkDljiy1s1UpzAMfra8v/qjlAsg+7DPUuffWgyx7n+OnL0Jo6mTTD
         SWIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=oNT4A2/m3jbIaYO0N8HurbMDlZJCjkOcp+KTZQeREtE=;
        b=LbNhCANPG1jSD8U+n5t5CTs4iGrc6dshJgOf55caeEDlvjoz+oFqrPlpZ64c2Dacsj
         7HIEvFyIDrCdm21sRirZS0x4Ty513UsVW+QVXFA2FkArZ4jS9Wd32XC0Va9v9/VGhhQN
         TrcN9iahdIV/rw4TKLpaPsjKdGunw+yRLmdIilvocvUSF6w6zK2j2ulZnEkeQk5MTa16
         VCTP+YhTBtFIMenoKvwgnPpA7u5LwU8BVwQp2spBVpYgQ3AuZ5Y008b+P3deb8XfN29z
         dPlFvHlFUGoq8UcI/kyp35thCv6XY72aQozf1eL2XvXwhhMvAQo3LApOKzV4/P+BkQ58
         aVKA==
X-Gm-Message-State: APf1xPC3VOjgRq8RCMEZUQ842F/1v6aAnpSEdRFeTiNy0zRdxG+aDi6K
        d+CKN4AoUSVSsBCo7FqL0rEAThhwPnuDMPhmMW8=
X-Google-Smtp-Source: AH8x226gtHx/JLRpk14Lu1hJ0Q/KPPO3M2NLuV6XHjBkoVI/Z/c8FKCntNprcaW/bmklZImH/KNepJox+NrFukEBbkE=
X-Received: by 10.31.96.196 with SMTP id u187mr221508vkb.75.1517866066803;
 Mon, 05 Feb 2018 13:27:46 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.1.33 with HTTP; Mon, 5 Feb 2018 13:27:46 -0800 (PST)
In-Reply-To: <CAGZ79kaFud05Txp6o2Qjz-kyWu9rb3vNzDGXSA5OZSY4MxyE+w@mail.gmail.com>
References: <20180130232533.25846-1-newren@gmail.com> <20180130232533.25846-18-newren@gmail.com>
 <CAGZ79kYcmq9JyD4smH1Vdm5YOFXRXjhYhhHYjNV=Z7mxz2UVGw@mail.gmail.com>
 <CABPp-BGc0F5023yY1wRb3Gy+oXdbHAibkHYr35+zE=OnT2bQmQ@mail.gmail.com> <CAGZ79kaFud05Txp6o2Qjz-kyWu9rb3vNzDGXSA5OZSY4MxyE+w@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 5 Feb 2018 13:27:46 -0800
Message-ID: <CABPp-BGPYNrgxuW7FGa1-vb=SmRBer_hAwb27oZaETJ5HYMCfA@mail.gmail.com>
Subject: Re: [PATCH v7 17/31] merge-recursive: add a new hashmap for storing
 directory renames
To:     Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 5, 2018 at 11:44 AM, Stefan Beller <sbeller@google.com> wrote:
>>> Having a stringlist of potentially new dirs sounds like the algorithm is
>>> at least n^2, but how do I know? I'll read on.
>>
>> Yes, I suppose it's technically n^2, but n is expected to be O(1).
>> While one can trivially construct a case making n arbitrarily large,
>> statistically for real world repositories, I expected the mode of n to
>> be 1 and the mean to be less than 2.  My original idea was to use a
>> hash for possible_new_dirs, but since hashes are so painful in C and n
>> should be very small anyway, I didn't bother.  If anyone can find an
>> example of a real world open source repository (linux, webkit, git,
>> etc.) with a merge where n is greater than about 10, I'll be
>> surprised.
>>
>> Does that address your concern, or does it sound like I'm kicking the
>> can down the road?  If it's the latter, we can switch it out.
>
> I think that is fine for now; the real world usage matters more
> than the big O notation. But maybe you want to hint at the possibility of
> speedup (in the commit message or in code?), once someone produces
> a slow case and digs up the code.

Sounds like a good idea; I'll add a comment about this issue to the
commit message.
