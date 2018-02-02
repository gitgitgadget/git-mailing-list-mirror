Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BBCD61F576
	for <e@80x24.org>; Fri,  2 Feb 2018 09:46:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751812AbeBBJqb (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Feb 2018 04:46:31 -0500
Received: from mail-qt0-f176.google.com ([209.85.216.176]:38635 "EHLO
        mail-qt0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750795AbeBBJq2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Feb 2018 04:46:28 -0500
Received: by mail-qt0-f176.google.com with SMTP id z10so30146923qti.5
        for <git@vger.kernel.org>; Fri, 02 Feb 2018 01:46:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=hU7ZkMsYcVbo538ZbE60Kq9oIB8hTU5bR1T21ZxcMAI=;
        b=uwbeYMShXOS94E+uRQ+IKVc+/bHnZaPuxcbxl6ghf67+gH+tLg5Jo5UkDqsTRkbklI
         KuxwUiVR3z9SE/NkO23nMNcyWy3+1sFxC2pOu5swpa6d6HZbXo/IFhX6LmVV49J5KmiZ
         c08QaukhkNgALMnzqA3P8tEiqNv7IFIJHUkGAsyKDpsqaNdQxA11kZ14YUGWiMW1TBfx
         DCqxd3I4HB2nF7+B97k7cjkfhIAfDv5mXSOeYDEbksQVvwJQVl5szbitNyus/E32t98R
         4EfCRA0Lpo1j4D5r2Xk2iUQ6PXc3q/05RY0a2Tif+rYpD289wa8kPPe+ldmXZEw/aaiQ
         6N2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=hU7ZkMsYcVbo538ZbE60Kq9oIB8hTU5bR1T21ZxcMAI=;
        b=C4KyugSEzGogbDzni/9ZuVph2r4XmtupkkybV4nAgSx8ZsJisJfdJg73VBQQVZOFqm
         pcs/OnQusvlPp8O//RNOQ2dQCIE0UKAq15itEc3lVfG5pgDWQvG9zX/Imh58zeBH/t6w
         OxqSHCnUILC+nb9/WNqIRICoo3O/92p6JfGznDL7GR5gURT4fpCgJELHJaQSNdHVs1Fz
         NC20swBqGLNqAnOHz/HXqfG7F3/Vn9xm8lO0y4oFOvOiiJcP/07mkCB+MCo/pyg+5sEX
         U2eajQ/MnT0PmTNGjpJoIZqhCmC8w1XG5OU48yuERSDrCbDcaMHEqygsAHlh6AEwQ591
         CD7Q==
X-Gm-Message-State: AKwxytf4hzWweVL9lEyEn/7Lv/FYRDm5F3Y8RNbnfy928MgU2PQvRvHs
        AK5DlXILyGUy14Rdma/JjwJtckaE7VU86dJbKL0=
X-Google-Smtp-Source: AH8x225d1zJi4NqlA/DcFl2jSDDen7rBepotoCyayxMWG1IgffV3HcoiOnsSVhqGf+Lc9CehBju8RLFuSv4FphhKq8k=
X-Received: by 10.200.45.109 with SMTP id o42mr3047559qta.277.1517564787979;
 Fri, 02 Feb 2018 01:46:27 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.175.239 with HTTP; Fri, 2 Feb 2018 01:46:27 -0800 (PST)
In-Reply-To: <20180202092511.GA28946@ash>
References: <20180126095520.919-1-pclouds@gmail.com> <20180131093051.15525-1-pclouds@gmail.com>
 <20180131093051.15525-2-pclouds@gmail.com> <CAPig+cR24=0_NPekYaF+oG9OovDkv1Et-RpNvAHqE7Qd7g7QQA@mail.gmail.com>
 <xmqqpo5pr5wr.fsf@gitster-ct.c.googlers.com> <20180202092511.GA28946@ash>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 2 Feb 2018 04:46:27 -0500
X-Google-Sender-Auth: 5eAsF41zemU7gV-X-He_fMCHiq4
Message-ID: <CAPig+cQKMxwadf9aGyC5ESa-vxDy9PzrYo+m+JaVQ3S=12PyQQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] am: add --show-current-patch
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tim Landscheidt <tim@tim-landscheidt.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 2, 2018 at 4:25 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Wed, Jan 31, 2018 at 02:59:32PM -0800, Junio C Hamano wrote:
>> Eric Sunshine <sunshine@sunshineco.com> writes:
>> > On Wed, Jan 31, 2018 at 4:30 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc=
 Duy <pclouds@gmail.com> wrote:
>> >> +       len =3D strbuf_read_file(&sb, am_path(state, msgnum(state)), =
0);
>> >> +       if (len < 0)
>> >> +               die_errno(_("failed to read '%s'"),
>> >> +                         am_path(state, msgnum(state)));
>> >
>> > Isn't this am_path() invocation inside die_errno() likely to clobber
>> > the 'errno' from strbuf_read_file() which you want to be reporting?
>> True.
>
> Thanks both. Good catch. Of course I will fix this in the re-roll, but
> should we also do something for the current code base with the
> following patch?
>
> -       die_errno(_("could not read '%s'"), am_path(state, file));
> +       saved_errno =3D errno;
> +       path =3D am_path(state, file);
> +       errno =3D saved_errno;
> +       die_errno(_("could not read '%s'"), path);

Rather than worrying about catching these at review time, I had been
thinking about a solution which automates it using variadic macros.
Something like:

    #define die_errno(...) do { \
        int saved_errno_ =3D errno; \
        die_errno_(saved_errno_, __VA_ARGS__); \
        } while (0);
