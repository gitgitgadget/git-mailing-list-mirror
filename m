Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 66A311F406
	for <e@80x24.org>; Tue,  2 Jan 2018 10:39:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752247AbeABKjP (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Jan 2018 05:39:15 -0500
Received: from mail-vk0-f54.google.com ([209.85.213.54]:34283 "EHLO
        mail-vk0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752189AbeABKjO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jan 2018 05:39:14 -0500
Received: by mail-vk0-f54.google.com with SMTP id j192so29977945vkc.1
        for <git@vger.kernel.org>; Tue, 02 Jan 2018 02:39:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zQ/8ENZ4JA7KE7ZuWjq4+XloT6MaEsUXitSbNUSj5xg=;
        b=PqDqn5tFKESRugK6xi0CoX7AG9dzAUnfAejR1N6LpI1RC46iE5YScu5O4M8yg1f8uO
         y+73pOcW+Yz0BDP5RMoianKPno4jIg2u4VJPHzcA9X2oDv3LkiHQoroMOMG0WSndUBdb
         6+J+Kb1Em3py/Orq3+XCk7fgY6YwLfMzPGaj5OKv8QjKMDpcZAerznvmpNsSnRu5+G/1
         79c6uqOgHTQvHLAojC66AfJOmxi7SUU9jKjinOclZwjbcpseZ5tLws2/1I8883Og4wDy
         p908hpvuhvaa3Cdt998cYbtK8gzKWqVvN47tTLzGUMzqK5PzTlYf9CoaL5vsdob4WC+R
         +hXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zQ/8ENZ4JA7KE7ZuWjq4+XloT6MaEsUXitSbNUSj5xg=;
        b=Q5tngtTzTV7rpKIomRUWScZyRLnUHnOkfwJ3Cb4kia+TSVuzB7RI72gMegumLf5xmm
         9kJAOexYNmzOv0ENet2dgVHIWY5DY36dYXaTbbfuBg1LnnzAe82hSI86rwMyp6Q0J58J
         8WA5D7PDG0kCsyBj3fAhuyvcmXEpM8zlIKpDJD6aCEMQOToDDZ0Cluh+hsDeAl+4PnLU
         rUDl9J9hWBzYaBWliTc8kvxSGTF9x3OJRIAgNFPrgMYh/rfclX3MoAoL17RWvnvGU/vH
         Kg/27KIiVBv7PlA87Qtj9b/PC+MYymRAAuhP2KFJ3TMt0YVz/HxcyEUwSN9zEfj1PyC3
         uncA==
X-Gm-Message-State: AKGB3mIpjCW4DMpSf54brnKRWnNckT5+XIPjpDe/eITeneLs+Zpo83rO
        bC5lSu4wg8GQwGaNA/r0NjHOcTT8dGui1gGKUZePkQ==
X-Google-Smtp-Source: ACJfBouyATGMpgNzMXrluYlpIRMCyrkBNyZZnCZ9WAMVAE27gpy3tY78lw/93vN6by/hIRhINriP0qLUT2kO54ny4Yk=
X-Received: by 10.31.124.205 with SMTP id x196mr27456044vkc.119.1514889553358;
 Tue, 02 Jan 2018 02:39:13 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.83.15 with HTTP; Tue, 2 Jan 2018 02:39:13 -0800 (PST)
In-Reply-To: <CAPig+cQ=Fj-sWrxDH1RV=PnYT01LGapzJjrRT5QdqUTkyc0rfg@mail.gmail.com>
References: <20180101225448.2561-1-szeder.dev@gmail.com> <20180101225448.2561-5-szeder.dev@gmail.com>
 <CAPig+cQ=Fj-sWrxDH1RV=PnYT01LGapzJjrRT5QdqUTkyc0rfg@mail.gmail.com>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Tue, 2 Jan 2018 11:39:13 +0100
Message-ID: <CAM0VKjm0WMDm_AETogX7ygMgeqY28YQLJLoM+dxtkfQfnT3aww@mail.gmail.com>
Subject: Re: [PATCH 4/4] branch: add '--show-description' option
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 2, 2018 at 6:17 AM, Eric Sunshine <sunshine@sunshineco.com> wro=
te:
> On Mon, Jan 1, 2018 at 5:54 PM, SZEDER G=C3=A1bor <szeder.dev@gmail.com> =
wrote:

> s/exit/exist/

Thanks.

>>     query does).
>>
>> Signed-off-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
>> ---
>> diff --git a/builtin/branch.c b/builtin/branch.c
>> @@ -737,6 +741,35 @@ int cmd_branch(int argc, const char **argv, const c=
har *prefix)
>> +       } else if (show_description) {
>> +               [...]
>> +               if (!argc) {
>> +                       if (filter.detached)
>> +                               die(_("cannot show description on detach=
ed HEAD"));
>> +                       branch_name =3D head;
>> +               } else if (argc =3D=3D 1)
>> +                       branch_name =3D argv[0];
>> +               else
>> +                       die(_("cannot show description of more than one =
branch"));
>
> Aside from paralleling the single branch accepted by
> --edit-description, why this limitation? (Just curious; I don't feel
> strongly one way or the other.)

It's not just '--edit-description', most other options won't accept
multiple branches either.  As far as I can tell only deleting branches
can deal with multiple branches in one go.

Furthermore, branch descriptions are likely more lines long, so we
can't just dump them one after the other, but we we would have to
separate the descriptions of different branches in the output.
Considering that 'git branch' mostly works only with a single branch at
a time, I didn't feel the need to do so.

G=C3=A1bor
