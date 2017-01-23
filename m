Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A35EF20A17
	for <e@80x24.org>; Mon, 23 Jan 2017 20:03:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751183AbdAWUD4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jan 2017 15:03:56 -0500
Received: from mail-wm0-f42.google.com ([74.125.82.42]:37964 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750948AbdAWUDz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jan 2017 15:03:55 -0500
Received: by mail-wm0-f42.google.com with SMTP id r144so174037875wme.1
        for <git@vger.kernel.org>; Mon, 23 Jan 2017 12:03:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=2ei1Ay9ktvHu4anJW/60pHLJWpAB8gNITjvg318ahR0=;
        b=oAS9XOjJtltfQRr7TxRM69ZNjh80I9piZB+H8t5o0LHQPWen3We8d1dAQXATQbTMb1
         1l6uZsBVTfDLRMLstnOGoOH+Hpi6PeqGAsoKJ+2gz1dZm4g2X9mAPinrW9G57ITqfCYO
         5s8GjMJ3wMLVXdQiyNOzekGrJeM8MNMfQzk75ZlnGlwYsiCPWyLFxjVlw1uJrjY6fYrw
         L7yIo9IsoZ8vMWCXEipHFRMfOtruqIjz+5cSYFHoGcEnODotvYfLe+wdctaCtGBKOF53
         npiyp/J5n5mNbD9OaHKzaTsdLTy9VNxvvrpWta/LWq0gS/EhlyUZ9ekfDcwS4Vjijdj0
         Xsvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=2ei1Ay9ktvHu4anJW/60pHLJWpAB8gNITjvg318ahR0=;
        b=hUCwFXHA6QP+I5SJzec03xY6OUcyv0psB6dtTSqOWyAMoGVPYWrGpH0DQYRFdFkNIg
         80dlz66QD3nrp+m+1tIW5z2PQ0An2AINpSb6p3pz7MAUde1mIqwmcLCP8hq4HJICGkoD
         7i0mk7WBMBYv0clVX1RnFObwr89ctpIW/kQwEkSOyuxt0u6TSKSC98R6XI1Wvhd0lUHI
         unre1rXl1N68Wr+cPmHgGGkj6A+nwXg+GLB/kCzQIe+S58Y5xdh4kfRCgEa6silQ3ZvY
         vBkPxUb9fWqouB7tt8KsuAnnDDwr18jlJkIyWbEODECQp0JD+sQoXUvzrqw5doGE7oXJ
         JU1g==
X-Gm-Message-State: AIkVDXLYwRURd2nOq1Izi6WRtzMEGNU8++orDQQN9z1Q3EraE5uKUTKbkHuS7IszapUhNwgMZCESeXjqM3JoNg==
X-Received: by 10.28.143.204 with SMTP id r195mr14675655wmd.32.1485201834310;
 Mon, 23 Jan 2017 12:03:54 -0800 (PST)
MIME-Version: 1.0
Received: by 10.28.145.193 with HTTP; Mon, 23 Jan 2017 12:03:33 -0800 (PST)
In-Reply-To: <xmqqh94ptzke.fsf@gitster.mtv.corp.google.com>
References: <20170121104904.15132-1-giuseppe.bilotta@gmail.com> <xmqqh94ptzke.fsf@gitster.mtv.corp.google.com>
From:   Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Date:   Mon, 23 Jan 2017 21:03:33 +0100
Message-ID: <CAOxFTcyuLkvgPOxQuzaDUVuDRu_KJg=JrYtU84pQyjLstChbLg@mail.gmail.com>
Subject: Re: [PATCH] rebase: pass --signoff option to git am
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 23, 2017 at 7:13 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> Should we plan to extend this to the interactive backend that is
> shared between rebase -i and rebase -m, too?  Or is this patch
> already sufficient to cover them?

AFAIK this is sufficient for both, in the sense that I've used it with
git rebase -i and it works.
