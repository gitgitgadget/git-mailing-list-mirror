Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 68C3620899
	for <e@80x24.org>; Wed, 23 Aug 2017 17:43:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932361AbdHWRnD (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Aug 2017 13:43:03 -0400
Received: from mail-pf0-f182.google.com ([209.85.192.182]:33132 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932111AbdHWRnC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Aug 2017 13:43:02 -0400
Received: by mail-pf0-f182.google.com with SMTP id k3so2628403pfc.0
        for <git@vger.kernel.org>; Wed, 23 Aug 2017 10:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1amUtIk1I5jDcgNusHZoHbvCreerYZtcd6EWkMBOYw8=;
        b=b5wbeNcSkLfIbPohTRDlseVHq91QEXXTPWqWgpfJtgExafbQ/6KV4BHrObkXotyrCP
         /1rxFxC8LPrwVTJeomqvekqs/OfS80zPiSh9qiATlXfLlgXVG8V05NFu5N3hEkpfmvFm
         rUott5KriVGnhA8C1cOlSsikbbXJylLBGl5vRH9p1bhipV2NlQeD+PoE+9Mj1PM4n+U4
         HwArXzAHw6Tskvi/B9zNKNdi+Q3RcEtIUVpkNZzdyEMyQQjDrL1F7XpcN7jRrHUKReLI
         NZw8QJjU6ACwTVZBjRE+bhJgZCB+bYyNQTCptU8zXm+w7EMqlGEpP1QhZFR7R8V24T5h
         kGvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1amUtIk1I5jDcgNusHZoHbvCreerYZtcd6EWkMBOYw8=;
        b=tsGs33hkpb26a6UUXZgG+Gi/Ix06T+NZ8XU/7EzH6dEbg4RUQbDA8RKe1Oxy/nKvj7
         VFQzo2g41xA5b4CFh4uDnEYEQbS52eMZ4QhU6wRrkWyiBsBFf5mgEuXihQqr7q8bSShB
         dSxOoEBPcFspXDZ6RJk75QkLTedicVijtlzUdwY1fKe90FYYON0fFMYNAVXeiF0qVWlA
         BcH+UBw08301ShO8GltuVQRhEqlYb1amjwRnvNfWUjIVmbMPDsBIF2E5OS8A8YdaGGR6
         SfpgTo79CjEwBrSede3WzwxPle432zdPPrn5LJDlXdZHUrP1qPG6XqTWRIVPvzvXPY4x
         DMfg==
X-Gm-Message-State: AHYfb5go5HQl4KjCsGdta6PDQHi4KTr1ucij75RL88v87JbKIEZkDPTv
        ofA0F7HOuktj3WWIOxGcBdqbPArIeg==
X-Received: by 10.99.97.2 with SMTP id v2mr2132317pgb.165.1503510182051; Wed,
 23 Aug 2017 10:43:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.162.37 with HTTP; Wed, 23 Aug 2017 10:43:01 -0700 (PDT)
In-Reply-To: <xmqq378i19ku.fsf@gitster.mtv.corp.google.com>
References: <cover.1502780343.git.martin.agren@gmail.com> <cover.1503323390.git.martin.agren@gmail.com>
 <dccd3e75fcd1b2de93263e8373a3b4cd5da0dd32.1503323391.git.martin.agren@gmail.com>
 <xmqq378i19ku.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Wed, 23 Aug 2017 19:43:01 +0200
Message-ID: <CAN0heSoqnEx=vPVZ5-OfqMkzL_JKKoa+iyP=G5h-cnqOwjPPYg@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] strbuf_setlen: don't write to strbuf_slopbuf
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 23 August 2017 at 19:24, Junio C Hamano <gitster@pobox.com> wrote:
> Martin =C3=85gren <martin.agren@gmail.com> writes:
>
>> strbuf_setlen(., 0) writes '\0' to sb.buf[0], where buf is either
>> allocated and unique to sb, or the global slopbuf. The slopbuf is meant
>> to provide a guarantee that buf is not NULL and that a freshly
>> initialized buffer contains the empty string, but it is not supposed to
>> be written to. That strbuf_setlen writes to slopbuf has at least two
>> implications:
>>
>> First, it's wrong in principle. Second, it might be hiding misuses which
>> are just waiting to wreak havoc. Third, ThreadSanitizer detects a race
>> when multiple threads write to slopbuf at roughly the same time, thus
>> potentially making any more critical races harder to spot.
>
> There are two hard things in computer science ;-).

Indeed. :-)

>> Suggested-by: Junio C Hamano <gitster@pobox.com>
>> Signed-off-by: Martin =C3=85gren <martin.agren@gmail.com>
>> ---
>> v2: no "ifdef TSAN"; moved check from strbuf_reset into strbuf_setlen
>
> Looks much better.  I have a mild objection to "suggested-by",
> though.  It makes it sound as if this were my itch, but it is not.
>
> All the credit for being motivate to fix the issue should go to you.
> For what I did during the review of the previous one to lead to this
> simpler version, if you want to document it, "helped-by" would be
> more appropriate.

Ok, so that's two things to tweak in the commit message. I'll hold off
on v3 in case I get some more feedback the coming days. Thanks.

Martin
