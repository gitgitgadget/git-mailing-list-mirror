Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3CA7C20248
	for <e@80x24.org>; Fri,  1 Mar 2019 06:17:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727019AbfCAGR6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Mar 2019 01:17:58 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45561 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbfCAGR5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Mar 2019 01:17:57 -0500
Received: by mail-wr1-f65.google.com with SMTP id w17so24499589wrn.12
        for <git@vger.kernel.org>; Thu, 28 Feb 2019 22:17:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9KZuH30f7Vu6dT9Hxr1lNIQesp9yL1VqtCalA6ly1nM=;
        b=PzS2MFSRmkP+x1w5PZZE08d+1Uyr/duu1kNX7BjOx/glTBkx8uW9jQeePkt51+pxo/
         QSeWhCfc3J8uS6Cr2pnBqOXYAohW3DtHnZj1yezUl1hStnad2cSghncjQkIGCJfxmrcq
         jGHkRELYj03QXSd1yWv2/1KWa0F+nc2tTPO2xg/ZW7yaLH4IUw9iVIWENC4sdDOz9Y1L
         M1R07aXVwFwl/quxOcswwvT2SApGjy75iyxUwSnrlBOjJ3oPrf560rFW1V5aRe4XsI4u
         MAnzr6sGHbNxHOgcJ5N4hQsSf6QxS4oiINlAW65nzDRrlQew3tcnlfKk+iwUyBDzFL3d
         z7aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9KZuH30f7Vu6dT9Hxr1lNIQesp9yL1VqtCalA6ly1nM=;
        b=jFT1hFfeaz5K8pXJwgwZPIqJNl6hvx4b6HPR7zUhCswjsb8LGiL/tCm3yj0DtAJ4CY
         V5GhWFlHtQQqHz0YxHPq1f4mFCEZ8K3AU6OBHDQmEbJFNe9Yw9Zknnd2M23zuQ4pN72k
         sDMVHAnWLG2l6toj2cU79u8vW33X8hxzUxZJ00liWdltTUmUR5XYhaGTlAZx+2oXQDCs
         YzQdC3E2QmBTBE84ETOVSCvxkswltvg4UUMEwc08mdBR9j3mVRgIsuj7rlpclps83J9u
         +xkntle5poHdGlTSmLXcTUsVoAXQ97uy9/kKo2aSnGaCHfsgotA3eNVJFJPzUWP9E7Bs
         0R1A==
X-Gm-Message-State: APjAAAVBxXbrInvOkQ8PRkY7uxvDOUZInWrp4N9/vqvHh8SNzY/Jwiqe
        v4DnCrnRHBpZhxzYNc1cfsp6aEUtsKiUGl4XrxdVjw==
X-Google-Smtp-Source: APXvYqyDelegMcHJ+DqMOjVysS9L1ucjdqpYj/Kwa/sMUktm+csjpb04DarU6kel8hX01H/tsB0b5Ms7mqQP0tGHTMk=
X-Received: by 2002:adf:cd02:: with SMTP id w2mr2054278wrm.30.1551421076093;
 Thu, 28 Feb 2019 22:17:56 -0800 (PST)
MIME-Version: 1.0
References: <CAL21BmnVkKtYWa1cRL1EJAwtchGcVUzhu0136AuV8uXAi5Kuew@mail.gmail.com>
 <20190228214314.GL12723@sigill.intra.peff.net>
In-Reply-To: <20190228214314.GL12723@sigill.intra.peff.net>
From:   Olga Telezhnaya <olyatelezhnaya@gmail.com>
Date:   Fri, 1 Mar 2019 09:17:45 +0300
Message-ID: <CAL21Bm=_Ybj+HPU7dq7vpQkev31krapXe=HVN3zXKtY_gU2yJA@mail.gmail.com>
Subject: Re: [PATCH RFC 0/20] cat-file: start using formatting logic from ref-filter
To:     Jeff King <peff@peff.net>
Cc:     git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=D0=BF=D1=82, 1 =D0=BC=D0=B0=D1=80. 2019 =D0=B3. =D0=B2 00:43, Jeff King <p=
eff@peff.net>:
>
> On Fri, Feb 22, 2019 at 06:50:06PM +0300, Olga Telezhnaya wrote:
>
> > In my opinion, it still has some issues. I mentioned all of them in
> > TODOs in comments. All of them considered to be separate tasks for
> > other patches. Some of them sound easy and could be great tasks for
> > newbies.
>
> One other thing I forgot to mention: your patches ended up on the list
> in jumbled order. How do you send them? Usually `send-email` would add 1
> second to the timestamp of each, so that threading mail readers sort
> them as you'd expect (even if they arrive out of order due to the
> vagaries of SMTP servers).

Oh, that's one more bug in submitgit, I guess. I will not use it
anymore, OK, it's time to change the habits.

>
> -Peff
