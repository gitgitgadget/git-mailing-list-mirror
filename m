Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E07B1FAE2
	for <e@80x24.org>; Sun, 18 Mar 2018 08:49:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753370AbeCRIty (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Mar 2018 04:49:54 -0400
Received: from mail-oi0-f54.google.com ([209.85.218.54]:36123 "EHLO
        mail-oi0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751003AbeCRItx (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Mar 2018 04:49:53 -0400
Received: by mail-oi0-f54.google.com with SMTP id u73so11979263oie.3
        for <git@vger.kernel.org>; Sun, 18 Mar 2018 01:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=aUU2G7j/GkzaFnlVPQj2AkKPfghU/HgX5yewtZ705pY=;
        b=AdMytF+QvO/EJLLN7CVUT/oydo9BaGE+slIAklB2VVf4G8lhB47/SA/uAxv6hv0WBU
         Af3OG63crQfs7wCurpBo+NAjM96pAkNGYtEt85fqQVUgwVNSS8RIIBF5RBrgfxTx0tWI
         ttBX3TA2jthFcaZwZqCnik655ijkgus0psMTHNudicPuIdEq08+tikIuohFDVo7fDLog
         5e88fdcN2XjDdNSUZvsxHYCHx0sbjPYS41naBWx1GUz++GSvk/4FBMIbWQMJ87GYe4A7
         FdpiobHW1kTQuhUt9hiOPuylu3kYW2O0OK0l71DL1pXCrmMprVm00MgxzMmREvD7REkJ
         CWFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=aUU2G7j/GkzaFnlVPQj2AkKPfghU/HgX5yewtZ705pY=;
        b=DilJgLdyVqXReBDQN4FMIu+JpmGj7qatWsf5lty+5s+GCwXTdzgVnGNqiQTNhEtIUi
         6lnnPkiUVzcYvWkCXO5r4lqxT7CaOnz5LjBXdQYfNNxDhMuZ0oIykqPWkDzjdJea0n48
         bGqDBKDaH08+mU1huzYIBAr3KlBGiFRGc/M6y2x3fLKd8LtkE53yQvFscoGw0SdHlUs8
         KV+lx/tcnKeWxggmr7Eligo0QuF28ER3MQ5fVZNaarxKwpB9TLKUtnBcAXVP4lhB6DAH
         GTHvoZLR3u0BF4qaxTy1BbEAWep5UmUczMMroOTr1cw4cboYyCVEIhXSizD7Gtpyre1k
         FTyQ==
X-Gm-Message-State: AElRT7HsEG3r6Fp29dK1LWW0xgIHBXO3bgCwLPE97f+Tbe0bu6MMUOYC
        1pKmHGEj5Za3NJSQHomiy92Am6uGhWYnAwDhgCg=
X-Google-Smtp-Source: AG47ELsdw0ZrQk48IBBnu+xProVyYHcbXbpPX4t6QJjjDVOtAe09ncX/54V0QjkkN3SVNo1d0ualK3d/PZhBmhyBOBw=
X-Received: by 10.202.64.85 with SMTP id n82mr4886740oia.30.1521362992985;
 Sun, 18 Mar 2018 01:49:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.154.146 with HTTP; Sun, 18 Mar 2018 01:49:22 -0700 (PDT)
In-Reply-To: <87muz6cwcu.fsf@evledraar.gmail.com>
References: <20180316183200.31014-1-pclouds@gmail.com> <20180317141033.21545-1-pclouds@gmail.com>
 <20180317141033.21545-12-pclouds@gmail.com> <87muz6cwcu.fsf@evledraar.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sun, 18 Mar 2018 09:49:22 +0100
Message-ID: <CACsJy8D8ZrzyNE=JAGEnENhtGnhHvB4vL2B-tex=Z2=D2Mx4ZQ@mail.gmail.com>
Subject: Re: [PATCH v5 11/11] pack-objects.h: reorder members to shrink struct object_entry
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Eric Wong <e@80x24.org>, Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 17, 2018 at 8:53 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> On Sat, Mar 17 2018, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy jotted:
>
>> Previous patches leave lots of holes and padding in this struct. This
>> patch reorders the members and shrinks the struct down to 80 bytes
>> (from 136 bytes, before any field shrinking is done) with 16 bits to
>> spare (and a couple more in in_pack_header_size when we really run out
>> of bits).
>
> Given what I mentioned in 87po42cwql.fsf@evledraar.gmail.com just now I
> think we should add this to the commit message.
>
>     This is the last in a series of memory reduction patches (see
>     "pack-objects: a bit of document about struct object_entry" for the
>     first one).
>
>     Overall they've reduced repack memory size on linux.git from 3.747G
>     to 3.424G, or by around 320M, a decrease of 8.5%. The runtime of
>     repack has stayed the same throughout this series. =C3=86var's testin=
g on
>     a big monorepo he has access to (bigger than linux.git) has shown a
>     7.9% reduction, so the overall expected improvement should be
>     somewhere around 8%.
>
>     See 87po42cwql.fsf@evledraar.gmail.com on-list
>     (https://public-inbox.org/git/87po42cwql.fsf@evledraar.gmail.com/)
>     for more detailed numbers and a test script used to produce the
>     numbers cited above.

Yeah.

I probably should add something that was on my mind but never written
out. These shrinking and packing definitely slow down access to these
struct members (more instructions to read or write). However, since
pack-objects is mostly IO-bound, and when it's CPU-bound, I think the
hot path is either inflating objects or generating deltas, these
slowdowns do not matter (and smaller cache footprint helps too)
--=20
Duy
