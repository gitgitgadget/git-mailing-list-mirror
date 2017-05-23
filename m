Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 90BFA20281
	for <e@80x24.org>; Tue, 23 May 2017 12:06:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1763801AbdEWMGN (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 May 2017 08:06:13 -0400
Received: from mail-vk0-f53.google.com ([209.85.213.53]:35546 "EHLO
        mail-vk0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1763754AbdEWMGL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 May 2017 08:06:11 -0400
Received: by mail-vk0-f53.google.com with SMTP id h16so56463861vkd.2
        for <git@vger.kernel.org>; Tue, 23 May 2017 05:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=EsBVJ1LwZdViTLYyBh37xeZ9Dgcxjrs+Y305ZvmlApU=;
        b=CX+VXVOFxZzNebnn9xMRmlFO133tpko8Ykc38U/rB9f+mzX/7XMt/FN7Ki06HTzGFL
         VwYyIK7itFV3pD6m4f02o2yQNIf6LVB9YrYP1RcbYYULr3H4L2fIY814gpyTiUodwsMd
         uXZYgjkmBxfd/FIILvDzGGm0AnD04Qs/z7dY7w+vOzJScURLJBg7Xfj4kBSiIP34VrZS
         y++aAPEy+QeakcmUC2XpjMjd9GCkBz5WfcEujYDNu8dHK0uSJrQW2s4IUV2/aoROXnaD
         hykf2QesF2TTG5GLdVWkMB6RF3QuA0AvIngoa0wvkcYkbX9fY3iuBkXTvoMZR4/VGjYp
         eNDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=EsBVJ1LwZdViTLYyBh37xeZ9Dgcxjrs+Y305ZvmlApU=;
        b=rKt4wRAmLPG0oUDokyLBf+c4O2YWiyLAt6bkXEcr/C89NoGybCLhoUu1xPDuHgpWqy
         ixIpi81czCwqsqNXsWiWlVH+MkW2i9CXWgghPYJ9pyA1olPa98cvVn/ByQyMePDloF6H
         twbuPd9mS7uKCnnv6rJQkpIII59Nn0M7wDfxneaAtzZIapXYMQZ6zVX23gbILAbX+WiY
         jmymUgeEpIvEqOOCZHIaIpu5Oxa0dkOQrktKEvRcsldT3QWl2cZJhenBf5XzagnEsAUH
         5b08j5TPFoDDOm9eyJQNA+YqwceeJ/uOqU6GCB5vp0UnSTSvq9mXHwzZfb1kndINdyHa
         V74A==
X-Gm-Message-State: AODbwcCsHycPvfeHrmwivyQD7jkdPO6dQYtvejk/Gr4EyBwu2Tuwu5u/
        bsai5g7VdyVRSZo9JQOCdntRynKFGw==
X-Received: by 10.31.63.202 with SMTP id m193mr11181501vka.103.1495541170287;
 Tue, 23 May 2017 05:06:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.82.57 with HTTP; Tue, 23 May 2017 05:06:09 -0700 (PDT)
In-Reply-To: <xmqqa864kops.fsf@gitster.mtv.corp.google.com>
References: <20170515110557.11913-1-szeder.dev@gmail.com> <20170515110557.11913-5-szeder.dev@gmail.com>
 <CAM0VKjkr+EBEErQZxW-prrcdAyF4D-icU_ao9vvO3yJ1HWhmhw@mail.gmail.com> <xmqqa864kops.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Tue, 23 May 2017 14:06:09 +0200
Message-ID: <CAM0VKjm5m9sTJtyAq_4O6RWJQ71v1c-sD+ARei=57rWwijMHpw@mail.gmail.com>
Subject: Re: [PATCHv3 4/4] clone: use free_refspec() to free refspec list
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 23, 2017 at 9:38 AM, Junio C Hamano <gitster@pobox.com> wrote:

> I was sifting entries in the draft "What's cooking" report to find
> topics to merge to 'next'.  I read the series over and as Peff said
> in his <20170515224615.f6hnnfngwpierqk4@sigill.intra.peff.net>, I
> think the series overall is good.
>
> Do you want to update the proposed log message for this one before
> the entire thing is merged to 'next'?

I followed Peff's advice on adding the default fetch refspec to this
temporary configuration environment (what's the proper term for
that?), which resulted in the simplest and cleanest code yet, and, as
a by product made this last patch moot, so I will drop it in the next
version.  The code is ready, but the change requires updates to the
first patch's commit message, maybe I can get around to it in the
evening.
