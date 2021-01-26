Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8C29C433E9
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 22:19:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9904F2067B
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 22:19:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728001AbhAZWDx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Jan 2021 17:03:53 -0500
Received: from mail-ej1-f47.google.com ([209.85.218.47]:33843 "EHLO
        mail-ej1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392128AbhAZUGE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jan 2021 15:06:04 -0500
Received: by mail-ej1-f47.google.com with SMTP id hs11so24835890ejc.1
        for <git@vger.kernel.org>; Tue, 26 Jan 2021 12:05:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RgPrkf52bfI5fMxZ5+NYM3sV16ZNjLMpIPqE7435VLw=;
        b=p3OUl+CIXK700dTnufmtBaHTdegpY41oikkNgo4zP9p1fNziIDrNjoGahjOLIqw/4j
         msB8V+8SsW/VqfbCWjVUqZLBx/+8s/6KKy46DE+vonzbFWf3jtMhvwDQF9eKn0YgCnqo
         ACDnuh222QCvo73lK8M9VzlhyPoDCclZjYAzJqBn2i8P5z8pQPpqLDfw1GVhwslPgqoJ
         VRI3SPd4iXVqbFD7FubGDpO1H68NX9voI4xckcmKyPQ7Q20yMvHJrtsJrPv+OlGdMb/w
         n1HeISGkTstPh/zGIeOhcqXqrpt11kb7MIvUA4NQ2JxSxZGHXqXKQWvqmtqeADjIXhsV
         negw==
X-Gm-Message-State: AOAM532yeQiAOry8NtWQ9nAA+k8gYqzjcxqEPAww0QtcBIRRDpoMDHzM
        +PvDOBPqdDD8kcbbj5SaAQ0UBogLh/w1XfyNx6Y=
X-Google-Smtp-Source: ABdhPJxeFCNFavY3+d2BvOpS4fh2Mc5UT/8XXyTQIkkxM4iRKaHrFioJvQIH+dlwRN3ZWPHPQ7k+Yrv0JTzq6G+iPIM=
X-Received: by 2002:a17:906:c410:: with SMTP id u16mr4349978ejz.159.1611691521653;
 Tue, 26 Jan 2021 12:05:21 -0800 (PST)
MIME-Version: 1.0
References: <20210125191710.45161-1-mirucam@gmail.com> <xmqqh7n337nq.fsf@gitster.c.googlers.com>
 <CAN7CjDDQw-Vr_pV=yM0eRXi02F4LjcMfE-9gs5iLS_MU-JPYKQ@mail.gmail.com>
In-Reply-To: <CAN7CjDDQw-Vr_pV=yM0eRXi02F4LjcMfE-9gs5iLS_MU-JPYKQ@mail.gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
Date:   Tue, 26 Jan 2021 12:05:09 -0800
Message-ID: <CAPc5daWO8JT1p0xhBtNyAjvy1hzjt3s-ho7LCPxEe-E_y8-a-w@mail.gmail.com>
Subject: Re: [PATCH v4 0/7] Finish converting git bisect to C part 3
To:     "Miriam R." <mirucam@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > Did we lose [2/7] somewhere in the mailing list?  I see the same
> > thing as what is shown in
> >
> > https://lore.kernel.org/git/20210125191710.45161-1-mirucam@gmail.com/
> >
> > i.e. a 7-patch series that lack its second part.
>
> I received the [2/7] patch:
>
> -------------------------------------------
> De: Miriam Rubio <mirucam@gmail.com>
> Date: lun, 25 ene 2021 a las 20:17
> Subject: [PATCH v4 2/7] bisect--helper: reimplement `bisect_replay`
> shell function in C
> To: <git@vger.kernel.org>
> Cc: Pranit Bauva <pranit.bauva@gmail.com>, Lars Schneider
> <larsxschneider@gmail.com>, Christian Couder
> <chriscool@tuxfamily.org>, Johannes Schindelin
> <Johannes.Schindelin@gmx.de>, Tanushree Tumane
> <tanushreetumane@gmail.com>, Miriam Rubio <mirucam@gmail.com>

It does not count---you are on the direct path of the message
and are not relying on the list to relay it back to you.

It seems that today's one of those days that the mailing list is
hiccupping. The message I am responding to, which is sent both
to the list and directly to me, hasn't appeared either on the public-inbox
or the lore list archive, either.

Hopefully we'll see all 7 messages eventually ;-).
