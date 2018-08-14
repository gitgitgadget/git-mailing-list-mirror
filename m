Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5226D1F404
	for <e@80x24.org>; Tue, 14 Aug 2018 18:44:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727807AbeHNVcv (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Aug 2018 17:32:51 -0400
Received: from mail-yw1-f54.google.com ([209.85.161.54]:35335 "EHLO
        mail-yw1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727755AbeHNVcv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Aug 2018 17:32:51 -0400
Received: by mail-yw1-f54.google.com with SMTP id s68-v6so16977547ywg.2
        for <git@vger.kernel.org>; Tue, 14 Aug 2018 11:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nMkkgh0vUZhQGbLUN7ahTngVDrv1bZU4rETtDU9I6Yg=;
        b=fFoN1xpG3+xwdlt+Nz3ypBCRFf6x3FalJwwdZvLcE8GV6kg148s1q5g8GLTFtaY915
         iGd7a56nWpq469fGsHvoQHZAB0ZyojbfSVB1CPd6O+fku71bEngScIviKcxCaBheIzFm
         nul7gkDKbLYJo49qZECrhYF2gOlk5YGj3rdEUiJdiSouX+MvdqwZukHnfaXg9XE7NVVQ
         E62aIDpDYmIoxk9wzyttm44YcKZ9Fvyn0rTOo21oG/zKMPqynaAf3qpyp06jcGg+NysJ
         hvAXJ+kXJtc+V24VcNhHr4Af8ruAL2Qam2Xe1v5vwhs1lsR3ZHVw9fkJmGUQ7EVd9q22
         H0Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nMkkgh0vUZhQGbLUN7ahTngVDrv1bZU4rETtDU9I6Yg=;
        b=BctlF83zrsVEFIWWBzBApwgLVIcfFSnJCKePP4G5WXIETbJtn2bAhnKkG/Eosbe2Pi
         ZQOP7txmIumRuTf3j7IXSyAatN8Sy8Gj+pBdedZZiYY0yVIX5e+wMk8XYwbZvIg83V19
         4x/zZcGoqBeQL3zlt7IIYWAVPqUh2jEi3Nuj4Z7wIwcSXzKT/g/CG9BNCqPhosRQCt+2
         MOolpNTl9sY0EzLqoZNgRlN13+2KnLKU6OqY2TUxIfGe7RHCrUOu7fvuvBqB3k/MXj8a
         q0u6639dII0i/S/IgirA+IN+EBFQDDoVUHfyvVK/jSVDaTSGOjei2yP4y47q0hMI58mx
         Y+sg==
X-Gm-Message-State: AOUpUlEsTv2SdyUFD4xpu7i49Y/6GGJ15PjCvI5tSePT9S4ZTDRlWbIa
        NRQ0QX+rvg6H3tNYWJ7imrjVPndg83j8vJfUcCNkJw==
X-Google-Smtp-Source: AA+uWPx4LtCNKJmGDAZLs/YOLQr7EakS+HTv9xvW4OV5qeSrOOLtUo9olyTMq3VBZZTnqZNYsAImEmHRS+LprUZNLwo=
X-Received: by 2002:a81:ae41:: with SMTP id g1-v6mr11969945ywk.345.1534272260751;
 Tue, 14 Aug 2018 11:44:20 -0700 (PDT)
MIME-Version: 1.0
References: <20180804053723.4695-1-pclouds@gmail.com> <20180812081551.27927-1-pclouds@gmail.com>
 <20180812081551.27927-3-pclouds@gmail.com> <20180813192526.GC10013@sigill.intra.peff.net>
 <xmqqk1ot3n4h.fsf@gitster-ct.c.googlers.com> <90d1bbf7-91a3-74ac-de65-1eb8405dc1f7@jeffhostetler.com>
 <CACsJy8DQmOCD2a5QFUiyPuoPZLq-QEejLhWACKpsJLvK5ERAMg@mail.gmail.com>
In-Reply-To: <CACsJy8DQmOCD2a5QFUiyPuoPZLq-QEejLhWACKpsJLvK5ERAMg@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 14 Aug 2018 11:44:09 -0700
Message-ID: <CAGZ79kZwVpCBMkBKuYpwZFgAN50wZub_fyzWrAsE=ksuc-aCgQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] unpack-trees: add performance tracing
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Ben Peart <Ben.Peart@microsoft.com>,
        git <git@vger.kernel.org>, Ben Peart <peartben@gmail.com>,
        Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 14, 2018 at 11:32 AM Duy Nguyen <pclouds@gmail.com> wrote:
>
> On Tue, Aug 14, 2018 at 8:19 PM Jeff Hostetler <git@jeffhostetler.com> wrote:
> > I'm looking at adding code to my SLOG (better name suggestions welcome)
> > patch series to eventually replace the existing git_trace facility.
>
> Complement maybe. Replace, please no. I'd rather not stare at json messages.

From the sidelines: We'd only need one logging infrastructure in place, as the
formatting would be done as a later step? For local operations we'd certainly
find better formatting than json, and we figured that we might end up desiring
ProtocolBuffers[1] instead of JSon, so if it would be easy to change
the output of
the structured logging easily that would be great.

But AFAICT these series are all about putting the sampling points into the
code base, so formatting would be orthogonal to it?

Stefan

[1] https://developers.google.com/protocol-buffers/
