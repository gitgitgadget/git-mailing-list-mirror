Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A0F2D1F404
	for <e@80x24.org>; Mon, 10 Sep 2018 18:37:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbeIJXdM (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Sep 2018 19:33:12 -0400
Received: from mail-wm0-f52.google.com ([74.125.82.52]:53677 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726657AbeIJXdM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Sep 2018 19:33:12 -0400
Received: by mail-wm0-f52.google.com with SMTP id b19-v6so22600998wme.3
        for <git@vger.kernel.org>; Mon, 10 Sep 2018 11:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=tBVegnVuIv/mcLCRHq1Yfs8hktbGRU84//Y+USEsPiA=;
        b=l35OmQ+jsYgP3Vs3Q/EkJYsRU4JJB3Bv8b6sKG8THVomT4kfWJZHRG/kfZLRUdT3NE
         DlqOEDiX90LHEFYQDzxFltHTeAFWpz4ydnZmND+PSSM+xhF6Q98BV9nZEFKkKTTrU3+d
         MOZeQy61Lb6AhHSAiXzjObpj3FAUNqHxln052gLK65uFJl59yNe2a5/PygNGd75myB2i
         Xviz0BuTCTJXIJHACNzlLa2LnVV6sZSw1U+1OgodGSpdfOPVIBK66ssdgtxamOfrhu3W
         pYo34jyG9Lq2YnICyRvfSD97AOpIke6O5B/jDMRGHwzJma6CJGiFTMpp63bAaSWFhPEq
         LV5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=tBVegnVuIv/mcLCRHq1Yfs8hktbGRU84//Y+USEsPiA=;
        b=OwrlbpfeXY6QSqIENS+oVe82xcd/RUV8cYaFf5rngrURvcrheRGyyg5POCqtjIa1kK
         JuQo1oGDl+fSCrdmpTdWTshPC0a2lR1NM4ISJ9VyEU7bY5pimEDID2z/Szf9s0Uzcuqx
         Scki7drWz23IOMkOAxT04ZTI8B6o9oR6313wjACx2otj3XV2ncrT2KhR5Sapa2BUVPpp
         h/L1okq/Ir2HluJkHOVPPdxFBrGSq0aZG61tHa8N3McHzz+l2/EV7ZXpidphkLHsOQ1/
         YkRnau0uaM4LxyUboxgkd6/mWK0kgsMcZjxj4F/1VQ7zlypn51uhi7HrTeMAafLHQW5O
         LlTQ==
X-Gm-Message-State: APzg51Bqs9/nx8u6Vjqb0GMmdUP1g161Xf5CTZFYJXVQUBxQK2pvuyWe
        OSPg9RjeN8k4rFGsiCX6reU=
X-Google-Smtp-Source: ANB0VdZtsIJB/GkTOuuoY2Bs/PMMIEJEFDrbKly80hXilku3JWzamCm3/koSQ4tr7KkcbZPtlkk+LQ==
X-Received: by 2002:a1c:b441:: with SMTP id d62-v6mr1661461wmf.17.1536604666220;
        Mon, 10 Sep 2018 11:37:46 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id z69-v6sm16843034wmz.18.2018.09.10.11.37.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Sep 2018 11:37:45 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Eckhard_Maa=C3=9F?= <eckhard.s.maass@googlemail.com>
Cc:     Jeff King <peff@peff.net>, Bryan Turner <bturner@atlassian.com>,
        dylanyoungmeijer@gmail.com, Git Users <git@vger.kernel.org>
Subject: Re: [Possible GIT Bug]
References: <CAPGJNu5RPXjeib-vayVzmFkU9cZ=h5o5VDoM1vQqv2+HgtNXLw@mail.gmail.com>
        <CAPGJNu5=GkiALR1=RYgHLv3NDrycqv13jpU5_=SOW-yWtRXduw@mail.gmail.com>
        <CAGyf7-EFiZ7ouUPDMtv3eb57QEiM2pkavyKQe7iNO7+eBeuZ9w@mail.gmail.com>
        <20180910132452.GB5233@sigill.intra.peff.net>
        <xmqqin3duypt.fsf@gitster-ct.c.googlers.com>
        <20180910173512.GA22152@esm>
Date:   Mon, 10 Sep 2018 11:37:45 -0700
In-Reply-To: <20180910173512.GA22152@esm> ("Eckhard =?utf-8?Q?Maa=C3=9F=22?=
 =?utf-8?Q?'s?= message of "Mon,
        10 Sep 2018 19:35:12 +0200")
Message-ID: <xmqq5zzdtczq.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Eckhard Maaß" <eckhard.s.maass@googlemail.com> writes:

> On Mon, Sep 10, 2018 at 09:03:10AM -0700, Junio C Hamano wrote:
>> It is neither but if I have to pick one between the two, it is much
>> closer to the former than the latter.  The primary source of this is
>> that we have only *one* pathspec given to the diff machinery, but in
>> order to implement your ideal "find harder", you'd need *two*.  That
>> is, one set of paths for which you are interested in their origin,
>> and the other set that you allow the machinery to consider as possible
>> origins.  Since we can only give one pathspec machinery, that one
>> pathspec is used to specify both of these sets.
>
> How does tihs compare to `--follow`? With that knob active the machinery
> indeed uses the whole repository for finding renames and/or copies. Is
> this the only exception then?

'--follow' is a checkbox hack that is not even properly integrated
with the diff machinery (it only exists on the "log" side of the
tool), so I do not think it is productive to find a comparison.
