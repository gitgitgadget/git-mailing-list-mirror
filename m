Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C8081F404
	for <e@80x24.org>; Mon, 16 Apr 2018 15:43:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751150AbeDPPn4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Apr 2018 11:43:56 -0400
Received: from mail-ot0-f180.google.com ([74.125.82.180]:35328 "EHLO
        mail-ot0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750732AbeDPPnz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Apr 2018 11:43:55 -0400
Received: by mail-ot0-f180.google.com with SMTP id f47-v6so17893398oth.2
        for <git@vger.kernel.org>; Mon, 16 Apr 2018 08:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3aITjx/stIh8O39wUTeuXlSHBTVOf0UHbH7d383DxVE=;
        b=mKgvbnwzqw7lpNqQR4WGQWr/AchiW8rw4ZMtUKthEh+iUvVOCAl240xwnX7o40SbQc
         KQJkzkAR2jLcnDF8Zt4mFdD8G1ve3DQcXCUPF6qsnIjZBtQb8VO1SJyPiXPpgvWkPx9p
         4AQgWE4LUNV0RMEaOcJGWbkODdRici5FRXEX7YSSJSncd05gV4z7jKuadY732OQ61UG9
         685z8KjdmgH8gMtegR0DJn6U9JMFvMCr6fC584/sMbBNz1nq5Nf/aVYEjkbgHGP2xRs1
         nQmp77dxNDpniafRnMlj79BSWlDGqiL+brfgQ0KxflPcSgTKjFCgjySLJwhWbuyFsWyq
         /skw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3aITjx/stIh8O39wUTeuXlSHBTVOf0UHbH7d383DxVE=;
        b=tS6uHMfmj97x3bigjmWNGl/5wrRvT0KviYTjv4C43dy2xLyFWwldvHlvOuO3eNiQip
         Z4dOobtWljwmLuQxPP4zWW9pSclggmtKOtjIHFHqSOeOlajd6tHZ3SfIZlSIrhd0mPpm
         K5Ffor7gqZ8BRJ+mpb2XtOmDETytdoO6OBFvQJjb9ZEqlucpauZE5UFE7QCyj/piWxoJ
         J/zwinriBSQF1oNpkbaMd+Ce0IUH1SgtMjC9nLrkoBLMGjdwqLmlT4ldvSDXRfHCgeNN
         1gqNl9yoam2D5guHfdV/FR4xrCaQFD3OWwFmWm7hkueCQ4jnDNxqTJNHWXNY1BPISHY5
         knvQ==
X-Gm-Message-State: ALQs6tDdVWmHu4uehgEnXEFfcf8/pyQ/zcio55sWad78oAHAZiKtca2c
        Mu9DLalOxgjYujC8qTw6j/EzCKTV6L1ZAUDG4qI=
X-Google-Smtp-Source: AIpwx49fGah2f0vsyrswT81M5Afea9Yj7+ceODSM3DB3toWwtUeI3VLjQTwTemTHhfv/xlL+zCUv7xySHBOUk3p38aQ=
X-Received: by 2002:a9d:16f3:: with SMTP id s48-v6mr11310156ots.304.1523893434722;
 Mon, 16 Apr 2018 08:43:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.198.152 with HTTP; Mon, 16 Apr 2018 08:43:24 -0700 (PDT)
In-Reply-To: <xmqq36zvy8a5.fsf@gitster-ct.c.googlers.com>
References: <20180326165520.802-1-pclouds@gmail.com> <20180415164238.9107-1-pclouds@gmail.com>
 <20180415164238.9107-4-pclouds@gmail.com> <xmqq36zvy8a5.fsf@gitster-ct.c.googlers.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 16 Apr 2018 17:43:24 +0200
Message-ID: <CACsJy8DHRjtWOC+Mt=gW95-UuyswHmGMM=eM0rFguQXeAsoZyA@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] generate-cmdlist.sh: keep all information in common-cmds.h
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Philip Oakley <philipoakley@iee.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 16, 2018 at 8:28 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:
>
>> @@ -23,28 +36,44 @@ sed -n '
>>       ' "$1"
>>  printf '};\n\n'
>>
>> +echo "#define GROUP_NONE 0xff /* no common group */"
>
> Some later code forgets about this value, and causes "git<ENTER>" to
> segfault at the end of this entire series.
>
> Namely, here:
>
>> -     for (i =3D 0; i < ARRAY_SIZE(common_cmds); i++) {
>> +     for (i =3D 0; i < nr; i++) {
>>               if (common_cmds[i].group !=3D current_grp) {
>>                       printf("\n%s\n", _(common_cmd_groups[common_cmds[i=
].group]));
>>                       current_grp =3D common_cmds[i].group;
>
> where common_cmd_groups[] gets overrun.

Argh!! I thought I tested everything. Sorry for the sloppy quality.

>
> Here is a squash I'll queue on top to keep the tip of 'pu' at least
> buildable.

Thanks. It's actually interesting that we have main porcelain commands
that belong to no group. I'll try to classify them so that they show
up as well.


--=20
Duy
