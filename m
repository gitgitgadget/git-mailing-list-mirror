Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 30C661F42D
	for <e@80x24.org>; Sat,  2 Jun 2018 06:07:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750886AbeFBGHM (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Jun 2018 02:07:12 -0400
Received: from mail-ot0-f193.google.com ([74.125.82.193]:38360 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750750AbeFBGHL (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Jun 2018 02:07:11 -0400
Received: by mail-ot0-f193.google.com with SMTP id n3-v6so31749883ota.5
        for <git@vger.kernel.org>; Fri, 01 Jun 2018 23:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hZCkLoZiTLFwr8e+G6rLZmIPRThGGv3nQLyjQE0E40g=;
        b=g5ccYBYK2t7jegqtsyY2Ybw/FcoTcRAhY3318Co7JkaYVxfPU1LaRR7yeskvK8UWHQ
         DiMkFPgFD9eHdXDb/FBOKXL1YGb0peR3IfN+uvNlgwncFcoyPD3Stv8iHpd9ayCRh5v3
         bYckPkqEb1kaxjJaDp1j/xwVH54bnWpDUW09ulHITXAE86KqvBRswEKLY/uy3mF7sHa0
         5gPqfEiQ7xcJN3afaSBtz8WWahLYHKC3r39vTiEeDZSc+QR7XszFIiaElkxgZeXRLmee
         DTVSFxcUNc43lzThVysmlxeAqZW/iXHRMpBPBYC6w+siMJSyM+cH603Wf7q29alW35Bt
         oeBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hZCkLoZiTLFwr8e+G6rLZmIPRThGGv3nQLyjQE0E40g=;
        b=mHBxbkNQk1QYmz8wUyISZA20RKRJJ0AiVf/GpfuMVTGhD8cvzuyF644hL8U1y42Kwe
         K1ysPoOE5EB4fhNHD4sIazaHdIxuLLAw/N2fFtgYwTSW9zNW2qLw0rSmcCiNdvTdvUmy
         e358kCrEwODMPBoPDiuF2pslf9lFswTTngz7R6TFisBHa+i4xnFdf1tJUiajlccRXFoD
         ZX37jmqF9OFfof/Vru+uVue3MnAM5l4BkJmDor68Fj//7+U4M27wsBphV+SqAWykfTj7
         L8eTYdhYZAT9Z6nO/SShh54kQRWIk6sdITzyzQauRdTYZpM8qsbVTzergzRALATnUMg9
         b1Qg==
X-Gm-Message-State: ALKqPwchGZFbBd+loi1dOa+g/jeuub75w71zpu9Dd5JgvxgYwwGnQl4j
        lkLr6WDaiTyRYc1xXm/UvreWCYGullVXKu9KlfA=
X-Google-Smtp-Source: ADUXVKJn7FPlTTX/8/IJb+LdT0u9NhpUWsqlU6cOT3OWfvdjswpOynsX6MpefL3S5/kGV7D38mXBS1O5ROn+uRH4ceU=
X-Received: by 2002:a9d:55a8:: with SMTP id m37-v6mr9713446oth.75.1527919631264;
 Fri, 01 Jun 2018 23:07:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:b285:0:0:0:0:0 with HTTP; Fri, 1 Jun 2018 23:06:40 -0700 (PDT)
In-Reply-To: <CACsJy8B7g-J8XeWYpY9SG1p51-fBLE2-V5872uWbyBXY2aVoEA@mail.gmail.com>
References: <20180522194854.GA29564@inner.h.apk.li> <20180526113518.22403-1-pclouds@gmail.com>
 <xmqqy3g4jpck.fsf@gitster-ct.c.googlers.com> <CACsJy8B7g-J8XeWYpY9SG1p51-fBLE2-V5872uWbyBXY2aVoEA@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 2 Jun 2018 08:06:40 +0200
Message-ID: <CACsJy8D_RDhJTbMp26gN291piDAr5pPp7zcSmY7RHc_o-anB9g@mail.gmail.com>
Subject: Re: [PATCH] upload-pack: reject shallow requests that would return nothing
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Andreas Krey <a.krey@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 28, 2018 at 8:48 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Mon, May 28, 2018 at 7:55 AM, Junio C Hamano <gitster@pobox.com> wrote=
:
>> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:
>>
>>> To avoid this, if rev-list returns nothing, we abort the clone/fetch.
>>> The user could adjust their request (e.g. --shallow-since further back
>>> in the past) and retry.
>>
>> Yeah, that makes sense.
>>
>>> Another possible option for this case is to fall back to a default
>>> depth (like depth 1). But I don't like too much magic that way because
>>> we may return something unexpected to the user.
>>
>> I agree that it would be a horrible fallback.  I actually am
>> wondering if we should just silently return no objects without even
>> telling the user there is something unexpected happening.  After
>> all, the user may well be expecting with --shallow-since that is too
>> recent that the fetch may not result in pulling anything new, and
>> giving a "die" message, which now needs to be distinguished from
>> other forms of die's like network connectivity or auth failures, is
>> not all that helpful.
>
> An empty fetch is probably ok (though I would need to double check if
> anything bad would happen or git-fetch would give some helpful
> suggestion). git-clone on the other hand should actually clean this up
> with a good advice. I'll need to check and come back with v2 later.

It turns out harder than I thought. Cutting history and want/have
negotiation are separate but must be consistent. If during the
negotiation you said "I'm giving you this ref at this SHA-1" then you
send nothing back, the client will complain at connectivity check. It
expects all the objects that lead to said SHA-1.

Part of the problem is we advertise refs very early, before accepting
shallow requests and it's kinda hard to tell the user "ok with this
set of shallow requests, only these refs are actually valid and could
be sent back to you" before the want/have negotiation starts. At the
current state, the only thing we could do is tell the user "nak you
can't have that ref" even if we advertise the ref. This might confuse
clients and does not sound great.

I think for now die() may be a good enough quick fix. I'm not sure if
it's worth messing with the want/have negotiation just to cover this
rare edge case.
--=20
Duy
