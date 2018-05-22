Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D9021F42D
	for <e@80x24.org>; Tue, 22 May 2018 10:55:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751239AbeEVKzS (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 May 2018 06:55:18 -0400
Received: from mail-pl0-f47.google.com ([209.85.160.47]:33096 "EHLO
        mail-pl0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750733AbeEVKzR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 May 2018 06:55:17 -0400
Received: by mail-pl0-f47.google.com with SMTP id n10-v6so10692817plp.0
        for <git@vger.kernel.org>; Tue, 22 May 2018 03:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=IxOhhhnC4+aWZxDxoUDzfC1HFZ/IT53bu5ojpfcIGCE=;
        b=DUgxWrtnr6HA9ozOL1IKU6pl59nplVg/agx8Ssbh1c2v28ddCayHgrXNOg+H9J2ucP
         URgu6pe9nrriaDdvd8O2caz2jAHYChLnbkeR97pRhk05xVggbye9tOCrmvP0gwOut2dG
         YD6MxUAshRogKviVF02DyxDfFLsUfwlgvBbof/wjkwXapV1qAvt7ZxUHTVaGYJpDKSVu
         oMVyeRVVq80eImsB5wA0E830xlH+1lV3aJ8SDgW45MSs9Bq5oECrhli1BXcbF0puqpPf
         KMNKf7ilbmhgVUo6rWuUgPdXb7QLm+F5V0N0DqzjNc1d4fFzMO7+hxlIbosXU0UE6JuZ
         TWFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=IxOhhhnC4+aWZxDxoUDzfC1HFZ/IT53bu5ojpfcIGCE=;
        b=PXrOnsWeb2etGxFt7kxiXONAXQwCxSzYoYFVAYX2axkgTslIztiqAt+myCEV9IFfz6
         QrTvTN9TH6BVryXOtEoEXBuUoM6sBzJJtAtvaMlqS/gw0oOBAWdRZb9CmOaa5So5KHLG
         rwIdjsqp9HdnxgL+G/BQ/odqhAnA01xlVXZ4CiED5Iy82shJgy4M/PaV9/95qWupTvh2
         a51Cpt3/InJrqGYuwRU9hzo0c9ip2oW3dwm96SBfmQLUqA1j2Ozmkg9MU5UvzfwIGs3j
         P4PLFDSNsqPTvA7my6gLCcshNIoYJwKVFls6n5B9uPt1qmRP5KCs8kaclHVHZQv1VptW
         v0fQ==
X-Gm-Message-State: ALKqPwcVMTXBnMoQKWlR0FO2GAkCs/tf2Mts5qk9UE/mW7hC+eUTy4c6
        GTeASSSPY1LKBrOD4teaxAgZFpdBcbO4cD15HG0=
X-Google-Smtp-Source: AB8JxZovf5fg0F/W5Deep2ADDEdhMjSnpFB9jrQeF6EqHTeBdm45BbP4tK4DZoiJWxZ6o9hRCF9pZGWKYdvuQVBPrs4=
X-Received: by 2002:a17:902:74c6:: with SMTP id f6-v6mr24399580plt.7.1526986516989;
 Tue, 22 May 2018 03:55:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:bb8b:0:0:0:0 with HTTP; Tue, 22 May 2018 03:55:16
 -0700 (PDT)
In-Reply-To: <50d629b9-bf89-77af-a1ee-6175745c5e42@ramsayjones.plus.com>
References: <d203f6ef-f684-cf6b-07b0-553b6b79e189@ramsayjones.plus.com>
 <xmqqvabgzhjr.fsf@gitster-ct.c.googlers.com> <50d629b9-bf89-77af-a1ee-6175745c5e42@ramsayjones.plus.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Tue, 22 May 2018 12:55:16 +0200
Message-ID: <CAN0heSrTpWGqCRMfhhyGqCX7TcBUKXbJWJp0yDy0cLQdhhwdHQ@mail.gmail.com>
Subject: Re: symbol string_list_appendf() unused
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ramsay

On 22 May 2018 at 02:08, Ramsay Jones <ramsay@ramsayjones.plus.com> wrote:
> On 22/05/18 00:59, Junio C Hamano wrote:

>> There is a reroll by Martin that ties all the loose ends.
>
> Ah, OK, sorry for the noise.

No worry. Thanks for pointing out the unused function to me. I
appreciate it.

Martin
