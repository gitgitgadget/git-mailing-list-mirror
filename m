Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 89A431F403
	for <e@80x24.org>; Tue, 12 Jun 2018 04:34:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753202AbeFLEeF (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Jun 2018 00:34:05 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:35094 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752816AbeFLEeE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jun 2018 00:34:04 -0400
Received: by mail-yw0-f194.google.com with SMTP id v131-v6so7081064ywg.2
        for <git@vger.kernel.org>; Mon, 11 Jun 2018 21:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=FJR3OSPYu1UrfSP7S0Ce+/jSvWmnJ7Ko6HSbTtb5fis=;
        b=izKXzUJ0Dsm3a82uEauSL1pA+MtvU5N/mDxWtyk3oFmb9MRcOmhickiQ6OiToGsyLa
         JhzgdmiZZsBrcxOu1a1w4dRCoBZpXCsjaKNGNLtqMQ3dJLpFjF1W8E3HWt5Js5hiGZHz
         xV1f0IbCxv4DyUkq6XsUiSiDLb0A7HoRjy3Xrl31w+We4opS4QIL5wCGAoeFU7e2zTmq
         91WfZ8o+1yCRDfv+ebKKeLszjtR2b03YUmEeXZk0zNFylBCeNdWAuvIGBjnQia4CgBqy
         cfavLUMt3tFVRWMJqQ6oeT4BTx0NX+cNrDbYGV+HOuFD8XDbYkuQLFXiS2gyNXC2GQxS
         GwvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=FJR3OSPYu1UrfSP7S0Ce+/jSvWmnJ7Ko6HSbTtb5fis=;
        b=GZT0ilmGl47N5wdJSaRa821q80hDQFEqor8NH/Abc8R41j48VN6nvF3UFkjz4omU/C
         zciqH/gmxxt5/mXpBEli8WuBipZ/8Q2NzO0G1JZSxNemJv2P2ANcbHG2jTyQFYStn7Of
         CF3eEVU7blrJE7FCtdeKZpM1KdUKud4V9zNOfNW8VIhyUx7e1lhrswQpcjUQCxSCfsA/
         mDHX5K+xVHr7Te660kB+D9ILjviLb90mvTDTEcOHFFj9qBb+/eCnjyuU1M5JOv0QCkaZ
         74yh/GadPaJjhrdscJjW8gKpKpJX7eiFm+oXGo3G9YtPulOBM7aJfSphS6mJfdtgcmQo
         Nyow==
X-Gm-Message-State: APt69E1FIRMmNdxA5mnLm7imjAji9NYDtxbWMD1W4YtGxllypflbMBWf
        QIqOGgNXIBIHDbwGKkD6tlhVTBDJxm7Rb+txgFo=
X-Google-Smtp-Source: ADUXVKJRUCOy8E4rhb3/wPbtbM/fFG/kV5S+8VNfY5Fs0+c4IPpP243UTlUjv0XFokKdnNGx/OvmAsVebDOCRZVQDuw=
X-Received: by 2002:a81:6088:: with SMTP id u130-v6mr816208ywb.418.1528778043970;
 Mon, 11 Jun 2018 21:34:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:3dc7:0:0:0:0:0 with HTTP; Mon, 11 Jun 2018 21:34:03
 -0700 (PDT)
In-Reply-To: <CA+dzEBk8H_=a9k1DaFUK=JJBhd17bhS3+ngSUBcBV+7hD-RFMw@mail.gmail.com>
References: <20180604201742.18992-1-asottile@umich.edu> <CAPig+cSzJ=2Zz7jRNB7sK7FyZ+YwdAFseCTSDbM_m4E8K9WxHA@mail.gmail.com>
 <CAPig+cRyv=JuGo+OfULuvbLrqRxoYZyBZDrSJrt5F8YRwzNn6w@mail.gmail.com>
 <CA+dzEB=7tGeXduxdKrJpDpXrmNbb_ZnYg=CmByJ7J-w-iiyxsQ@mail.gmail.com>
 <CAPig+cSm7My9r8KN1vNyssendf_v_nMARDAq6ALA=X7nZ+spkA@mail.gmail.com> <CA+dzEBk8H_=a9k1DaFUK=JJBhd17bhS3+ngSUBcBV+7hD-RFMw@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 12 Jun 2018 00:34:03 -0400
X-Google-Sender-Auth: xfFm6Wvh07ZN5W6AZ6rrnA-tumE
Message-ID: <CAPig+cTgJbwatnZ+9eAvjQ1Mn7dszWr9Tgh5GTJNAH-jNjV=Cg@mail.gmail.com>
Subject: Re: [PATCH] config.c: fix regression for core.safecrlf false
To:     Anthony Sottile <asottile@umich.edu>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[cc:+torsten]

On Mon, Jun 11, 2018 at 9:46 PM, Anthony Sottile <asottile@umich.edu> wrote:
> On Wed, Jun 6, 2018 at 10:22 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> Thanks for pointing that out. In that case, it's following existing
>> practice, thus certainly not worth a re-roll.
>
> Anything else for me to do here? (sorry! not super familiar with the process)

I don't think so. Nothing in the review warranted a re-roll, and
(importantly) Torsten gave his Acked-by:, so the next step is to wait
for Junio to pick up the patch. He's been offline for a bit, so it
might take a some time for him to catch up since the list has been
plenty busy in his absence.

It's a good idea to check the "What's Cooking" summaries Junio sends
to the mailing list once in a while to check the progress of your
patch. If you don't see it show up in the summary within a couple
weeks or so, it wouldn't hurt to ping again (as you did here).
