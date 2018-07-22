Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EDBFD1F597
	for <e@80x24.org>; Sun, 22 Jul 2018 06:49:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728034AbeGVHpT (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Jul 2018 03:45:19 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:36360 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728002AbeGVHpT (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Jul 2018 03:45:19 -0400
Received: by mail-it0-f66.google.com with SMTP id j185-v6so19685589ite.1
        for <git@vger.kernel.org>; Sat, 21 Jul 2018 23:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RG8mPHpztbSrcxvvpYuMHLXUZIlvdwplOhGpiNBCg/Q=;
        b=S1LUBCMqDSqe/mzGYeJOrFGMdK0wJl+6Tc5vGcCtOl+rJ5GQB/+2BehzTAAnK1l/8c
         lJR+Vq8o+1jxyhmyWXoqt7FoyIHRL5r++KCwwKd1xXJzyfzCkVdkcttSZ6QuPwkbSKGo
         adijGXp5s97cnTj5fBMKrdVjqqv0b9PQRWzJ+O9HrfoqxrPZ5wYPDddFnsQuc3W5f9w0
         ZCEJ23b01qiOT07SG0UdGXOo+d2LnheitZBDgYIjql/5pG4UelHho6x4kgsHsJi1Qpl6
         YTOjyirhigaIjO1oA38XIMKdovBA/5qAFYW7J14XkI57peNTs0qrRlTIl4UGlI8+nyN5
         EtFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RG8mPHpztbSrcxvvpYuMHLXUZIlvdwplOhGpiNBCg/Q=;
        b=gk9bUhEpEKQWxrPpCaH/9RE7IP/J0OG8rq1pW8KMpH6RLd5TpwIN3nBlXMBAVKGVYx
         4zXbXDG5v6xfIpcRPr7+/CKSNtV9/xmCGfdEI/4V7Gyo9J51eq4DEhGyLVeNsnCRUat/
         fwFwCEO8JJYcDGUOcOaE3Wx3XEIm7oQ4niSBpQ70Wf+Uji222iZCHKGiCNDb6SdFOwQB
         VPuCZ+pfVWubXUiIg+TcDHuIGW/+EJ/r6J7+yh8ioXDaIM+4tQaB5N/RVPYypOCMiMja
         bSy52LqmCxeodGV8NuODZt/rMKcx40VD6BOhFLgDgYrMlAdKllm4/Mrzy6L6O2oZCG1P
         kGLg==
X-Gm-Message-State: AOUpUlFzpAcoQVyvQMARmIhfkeNCenoaIG79ls8nvKCfQRzkykw9Zn74
        e6IMXSbtYcZEzIrKeDtmU1yTaIapdH9JFsLMuAY=
X-Google-Smtp-Source: AAOMgpfTJX7YXiZa0ffXopUHoKnxWX1a8dvzC77hhcH2A/eix9GPAmJjEmPfVP5QYLXzj/qEYa7qI3u9XbU0B0NxqZ8=
X-Received: by 2002:a24:c888:: with SMTP id w130-v6mr7201256itf.78.1532242181316;
 Sat, 21 Jul 2018 23:49:41 -0700 (PDT)
MIME-Version: 1.0
References: <20180718225110.17639-1-newren@gmail.com> <20180720153943.575-1-pclouds@gmail.com>
 <CABPp-BGJAWXOCPsej=fWWDJkh-7BAV9m8yEDiy2NVkGTRCmk4A@mail.gmail.com>
 <20180721044711.GA31376@duynguyen.home> <CABPp-BHecS-TewK=tCxEZkCiM_QF=Pj3LkDWOT6+2F1VCu-KcQ@mail.gmail.com>
In-Reply-To: <CABPp-BHecS-TewK=tCxEZkCiM_QF=Pj3LkDWOT6+2F1VCu-KcQ@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sun, 22 Jul 2018 08:49:14 +0200
Message-ID: <CACsJy8AdyhdSu1LaER4J+wg03nT_i_pfc29Jxp8acTOS+7EXWw@mail.gmail.com>
Subject: Re: [PATCH] pack-objects: fix performance issues on packing large deltas
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jul 22, 2018 at 8:22 AM Elijah Newren <newren@gmail.com> wrote:
>
> On Fri, Jul 20, 2018 at 9:47 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> > On Fri, Jul 20, 2018 at 10:43:25AM -0700, Elijah Newren wrote:
> >> Out of curiosity, would it be possible to use the delta_size_ field
> >> for deltas that are small enough, and only use an external data
> >> structure (perhaps a hash rather than an array) for the few deltas
> >> that are large?
> >
> > We could. And because repack time is still a bit higher in your
> > linux.git case. Let's try this. No locking in common case and very
> > small locked region when we hit large deltas
>
> This one looks like a winner.  Labelling this as fix-v7, this rounds
> out the table to:
>
> Version  Time (s)
> -------  --------
>  2.17.0   621.36
>  2.18.0   621.80
>  fix-v5   836.29
>  fix-v6   831.73
>  fix-v2   619.96
>  fix-v7   622.88
>
> So the runtime is basically within the noise of different runs of the
> timing for 2.17.0 or 2.18.0 or -v2, and is much faster than -v5 or
> -v6.

Thanks. I'm looking forward to asking you to test lock-related changes
on this 40-core monster in the future :D

Unrelated point of improvement for the future. I notice that at least
on my machine, i have 100% cpu on one core during writing phase,
likely because deltas are being recomputed to be written down and we
don't produce deltas fast enough. We should be able to take advantage
of multiple cores to recompute deltas in advance at this stage and
shorten pack-objects time some more.
-- 
Duy
