Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E7471F85D
	for <e@80x24.org>; Wed, 11 Jul 2018 20:54:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733168AbeGKVAS (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Jul 2018 17:00:18 -0400
Received: from mail-wr1-f49.google.com ([209.85.221.49]:37871 "EHLO
        mail-wr1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726611AbeGKVAR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jul 2018 17:00:17 -0400
Received: by mail-wr1-f49.google.com with SMTP id q10-v6so19485343wrd.4
        for <git@vger.kernel.org>; Wed, 11 Jul 2018 13:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=ZGQ8QE2uezMGDeeMpyimnTn8xaoD1biu+09c1VgQm2I=;
        b=nWbXU5Jd8Ikb4AmIFliKdwtg2DmuuK51PQBt+arBUGh6zoNiUsLe8+1XVr4kimjSs3
         0JYANmQbHXLxgkQ3d+QTJbUytws+9SyZo+gXEDajZCKv+BH0pQp0rbIk8burJ5j/BBv5
         neyt5ByZMqGT5y2vdtimtLKfaNZAj075IBeR4Nc0NgP//o9HtUhVr3HDRiPg3Cj1o2Cq
         AbQvBxurRhMi4lG6nCDe/t9ziztInbNqm082HF9NXQrnfyIRROj+cBqqBs4TsaJNSWMi
         vEiVWemCncwMwuu5R33hc79gj67lOdNRZQewPVTrHmj71RP0Wnta808l31iDwSKRMYyU
         uyEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=ZGQ8QE2uezMGDeeMpyimnTn8xaoD1biu+09c1VgQm2I=;
        b=sYe09iwNDzRTiHpP2aLADcpzD9+MSE3YQeILLmjtJe+ltHdGT6FXkfHqmMpFDnj8/D
         3gb5W8QxIx96yauhftGPpvXwp4PiUMXwC2Ck3ZrOs8benLbgUiTWuj3adLnGHnqTd/Yh
         mRiSXhL/6Ljks+VVQgjprRIFsGP+viJocwTd5akAV8zRyqvKxbHeT75K1KFyPSCJ9f1c
         uAC4Jq/41arqO8QmrvBWQgsGPpvSbZCcIFyE/TU5ShOHk1U8FRoyGBChpY7t5dbGehuo
         JvYOVtyl9kclrzd01FF0XgFCvgu5nJ+IQ5DN5veobVc9HFpBmGapEOZkL/MeLodczO3S
         YFbw==
X-Gm-Message-State: AOUpUlGVb6rVDTftgPbFi3Ct4fI8gSuQ6V7sA2HR/nwlnMiI0h0IpMrW
        Ev2SK4ccNnQlfxocTRyE7yg=
X-Google-Smtp-Source: AAOMgpfIQhzMot8sXGApBOW8AAY1qanAso2mG23AAI2YTEUDyUSthVx4WfFGXWXNk5yRzNLtQg7XKQ==
X-Received: by 2002:adf:f90d:: with SMTP id b13-v6mr138942wrr.38.1531342448082;
        Wed, 11 Jul 2018 13:54:08 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id g75-v6sm4024165wmd.38.2018.07.11.13.54.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Jul 2018 13:54:07 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Andrei Rybak <rybak.a.v@gmail.com>
Cc:     torvalds@linux-foundation.org, git@vger.kernel.org
Subject: Re: [RFC PATCH v2] Add 'human' date format
References: <alpine.LFD.2.21.999.1807071238410.18818@i7.lan>
        <alpine.LFD.2.21.999.1807071502260.18818@i7.lan>
        <CACayv=ifE5BQVtxXCVEhS3uO7iz1z+ZPrF3J_n=e-uoYOpwNtA@mail.gmail.com>
        <CACayv=jM0Q4x=U+4=_YqJHto_ZdZAz8r89xALOcW5a+n9w=LeA@mail.gmail.com>
Date:   Wed, 11 Jul 2018 13:54:07 -0700
In-Reply-To: <CACayv=jM0Q4x=U+4=_YqJHto_ZdZAz8r89xALOcW5a+n9w=LeA@mail.gmail.com>
        (Andrei Rybak's message of "Wed, 11 Jul 2018 22:38:23 +0200")
Message-ID: <xmqqtvp51ok0.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Andrei Rybak <rybak.a.v@gmail.com> writes:

> On Wed, 11 Jul 2018 at 22:34, Andrei Rybak <rybak.a.v@gmail.com> wrote:
>>
>> Is -1 an OK initial value for timezone if local_time_tzoffset returns
>> negative values as well? It looks like it doesn't matter for from functional
>>
>
> meant to say: "It looks like it doesn't matter from the functional
> point of view".

As long as we do not show data in a timezone that is exactly one
minute ahead (or is it behind???) of UTC, it does not cause an issue
in practice.
