Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9DBBC1F404
	for <e@80x24.org>; Wed, 21 Mar 2018 16:31:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752221AbeCUQbX (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Mar 2018 12:31:23 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:52887 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751630AbeCUQbU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Mar 2018 12:31:20 -0400
Received: by mail-wm0-f67.google.com with SMTP id l9so10900035wmh.2
        for <git@vger.kernel.org>; Wed, 21 Mar 2018 09:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=siIPXVsb9J1kIY7aNg32+1cuTujdcUnkcCpN8ulSz1U=;
        b=avhXdbY54H3XOJDtLd3fJ0Q3z4cOCL+ohNIHuykCuZZUBO406E2pG0hP/LH7u+Yopk
         d5bzqjcocIuoMrkTxsXfgkwwzgcMRxAJxrmcviWcSjJjuqcegSdW1jzrdf7bWc3x49wk
         VWyasoxHn/xOsKs78UXpf1II33f1eeOj4/swiZs/pUmQ4ojuHmOnJjYVXKScflIcQh9G
         sifycKo4YvQdKpQXiMEifB6E4tNhUoKaQF+8VlhKW4EVmlM6pbUUJkr5c97lRgo5LLqX
         uIB3mQ51KZa4Fupp4a3nDSLljmYklR9C0cfqaS6GzM8yo7NmOeNRIRdVamLKT4yt0Z69
         qsRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=siIPXVsb9J1kIY7aNg32+1cuTujdcUnkcCpN8ulSz1U=;
        b=P6Vdb24QYq9Itapo2Cd1BmxYoOKIOEM95lFeQQy5TWSAvPDK39FhZ+yILfNrv3+5hC
         UHpeCGXhTOsS/QsWmDtTAdURooJUPJ/6RrCqap4y6nL8JaNw8RHeLe6plzWM2JCVUDox
         mCnTs4Np/VaS5nxN/756Ei4fNX0ZnByL7w4+68VsqvI6hcOjwzz2X5MUoct6lC3uTnsl
         u+zN4X/IT42fTlX1hjsOQuX781VEDpGGK0gs3jnS7CPN1VOdj78NKbfxU+dMNvGfdBeQ
         AnjKgLb6jmPLhGYuhMKH5MpyZlOA7aW9jll5EP2FjQ1SUpaZJjyPl3Dlt7UHIP0POopV
         J3Yg==
X-Gm-Message-State: AElRT7EAAkFxNJm5PQIOoP5ciTXW1lywbakLExwbrGP8hDHIejlrgqai
        lRqjrbL28rIbTnH3GbRBY1U=
X-Google-Smtp-Source: AG47ELvJ31A/URm9p36NiyiiJqe/vsT3wsN2FD2ZICUtoxU52SFawMjtTvbzvVD+TTl0MdzGGvMh/Q==
X-Received: by 10.80.138.102 with SMTP id i93mr22514902edi.260.1521649879063;
        Wed, 21 Mar 2018 09:31:19 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id x46sm4195051edm.60.2018.03.21.09.31.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Mar 2018 09:31:15 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        e@80x24.org, git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v6 00/11] nd/pack-objects-pack-struct updates
References: <20180317141033.21545-1-pclouds@gmail.com> <20180318142526.9378-1-pclouds@gmail.com> <20180321082441.GB25537@sigill.intra.peff.net>
User-agent: Debian GNU/Linux 9.4 (stretch); Emacs 25.1.1; mu4e 1.1.0
In-reply-to: <20180321082441.GB25537@sigill.intra.peff.net>
Date:   Wed, 21 Mar 2018 17:31:14 +0100
Message-ID: <87tvt9xuel.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Mar 21 2018, Jeff King wrote:

> On Sun, Mar 18, 2018 at 03:25:15PM +0100, Nguyễn Thái Ngọc Duy wrote:
>
>> v6 fixes the one optimization that I just couldn't get right, fixes
>> two off-by-one error messages and a couple commit message update
>> (biggest change is in 11/11 to record some numbers from AEvar)
>
> [...]Yes, having that many packs is insane, but that's going to be
> small consolation to somebody whose automated maintenance program now
> craps out at 16k packs, when it previously would have just worked to
> fix the situation[...]

That's going to be super rare (and probably nonexisting) edge case, but
(untested) I wonder if something like this on top would alleviate your
concerns, i.e. instead of dying we just take the first N packs up to our
limit:

    diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
    index 4406af640f..49d467ab2a 100644
    --- a/builtin/pack-objects.c
    +++ b/builtin/pack-objects.c
    @@ -1065,8 +1065,9 @@ static int want_object_in_pack(const struct object_id *oid,

            want = 1;
     done:
    -       if (want && *found_pack && !(*found_pack)->index)
    -               oe_add_pack(&to_pack, *found_pack);
    +       if (want && *found_pack && !(*found_pack)->index) {
    +               if (oe_add_pack(&to_pack, *found_pack) == -1)
    +                       return 0;

            return want;
     }
    diff --git a/pack-objects.h b/pack-objects.h
    index 9f8e450e19..50ed2028fb 100644
    --- a/pack-objects.h
    +++ b/pack-objects.h
    @@ -171,15 +171,17 @@ static inline void oe_set_in_pack_pos(const struct packing_data *pack,
            pack->in_pack_pos[e - pack->objects] = pos;
     }

    -static inline unsigned int oe_add_pack(struct packing_data *pack,
    +static inline int oe_add_pack(struct packing_data *pack,
                                           struct packed_git *p)
     {
    -       if (pack->in_pack_count >= (1 << OE_IN_PACK_BITS))
    -               die(_("too many packs to handle in one go. "
    -                     "Please add .keep files to exclude\n"
    -                     "some pack files and keep the number "
    -                     "of non-kept files below %d."),
    +       if (pack->in_pack_count >= (1 << OE_IN_PACK_BITS)) {
    +               warning(_("Too many packs to handle in one go. "
    +                         "Ran into the limit of %d.\n"
    +                         "Limping along by pretending packs beyond that"
    +                         "number have *.keep!"),
                        1 << OE_IN_PACK_BITS);
    +               return -1;
    +       }
            if (p) {
                    if (p->index > 0)
                            die("BUG: this packed is already indexed");
