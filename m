Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF1601F87F
	for <e@80x24.org>; Mon, 12 Nov 2018 09:13:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728120AbeKLTFU (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Nov 2018 14:05:20 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:35140 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727036AbeKLTFU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Nov 2018 14:05:20 -0500
Received: by mail-qk1-f196.google.com with SMTP id w204so12041857qka.2
        for <git@vger.kernel.org>; Mon, 12 Nov 2018 01:13:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SRYIC/6f1d/tnxxwIXDzqK9deo9nkLtO5tOAjaheqkg=;
        b=Ztud/1ROWVK3gq9e2x7ohn/8isUvuYqp3zi9DNXOb+uQE5B1/boWLP7X54/PMgl22b
         MOnyHk9mxtzwfHfECNUFcpjz0wcSncazeMM2iL9NfA24NYscemYC4Aw9mO85XlkIIGn9
         ahY90M4Q6ZK41OyUfbjyV5QfhbBwb4ml9QnVYcL+VGsL1yw7xpr483WVx0jCGdXBcoyC
         G1cHSCYpNO8Z7Gv+/sFrH+4ums7HDoCIUzzZj+S0mo7CniO6/nLCa0qJsRG6l0wui193
         DCPkqatdVF/5xI8DqXZcaZsavgC7opq4wwB5PnfYxnKTf+ovktvvwngEHhbd2zrSkRUP
         2fhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SRYIC/6f1d/tnxxwIXDzqK9deo9nkLtO5tOAjaheqkg=;
        b=T48TO31tE8nNrbCLmRgpcs64SBF9U2PVKHqv8tXLKT7ungMhJrztFVhHxEigUaZpX0
         /7Hhh7gJfOOKNvrOGSJpUj9Nd+lARs/X/Ukc6CeLJ7nrTUHRt/GDcc/MURsHp2kfSgdo
         k2Vv6qdKcjxWIb8oxVnO01AzgD/xZFfQczI3CoQ/cEz28KR92JcxXXsHGfrcxP4EdsUO
         mmi74PHyYAXLGBVMiNp1YZHrA2qsBUfnHwpGnvfLa8dxd4S0V/IE+epKlB0tY6P6SBGN
         xq9sixoeHuPwRLXlWXi1YDV6B3jUxj711oAtnhSdiPo+yjxlMZ1Jl305t12NQOVwW+WJ
         j6og==
X-Gm-Message-State: AGRZ1gLn9WJ90C4mZYrH0R8VXnqcF/IzLEHGh34km+XkKX0DGMo2haZ6
        HN53fgTreWmSzjqO0JKfwJVmQmUUU1TiCo2StSc=
X-Google-Smtp-Source: AJdET5eR9+QClL3UJ51RLAvJ8za91zjDIu27uLDzAj9JjnHug+Ghuu1ZJqtGnUWhFpCMHYZrrfGsW0YTDzADHrp1L48=
X-Received: by 2002:ac8:5344:: with SMTP id d4mr120021qto.372.1542013982007;
 Mon, 12 Nov 2018 01:13:02 -0800 (PST)
MIME-Version: 1.0
References: <CABPp-BEefqYADr8SVvh6uFWkp96PDv7qfKK1c9O1WUnPy3wqrw@mail.gmail.com>
 <20181111062312.16342-1-newren@gmail.com> <20181111062312.16342-4-newren@gmail.com>
 <20181111063636.GC30850@sigill.intra.peff.net> <87va532x5i.fsf@evledraar.gmail.com>
In-Reply-To: <87va532x5i.fsf@evledraar.gmail.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Mon, 12 Nov 2018 10:12:50 +0100
Message-ID: <CACBZZX6Ck-M7UPK85UW4ZOYWeodSJo0gp7Kgs__on5SfZDmojA@mail.gmail.com>
Subject: Re: [PATCH 03/10] fast-export: use value from correct enum
To:     Jeff King <peff@peff.net>
Cc:     Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Taylor Blau <me@ttaylorr.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 11, 2018 at 9:10 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
>
> On Sun, Nov 11 2018, Jeff King wrote:
>
> > On Sat, Nov 10, 2018 at 10:23:05PM -0800, Elijah Newren wrote:
> >
> >> ABORT and ERROR happen to have the same value, but come from differnt
> >> enums.  Use the one from the correct enum.
> >
> > Yikes. :)
> >
> > This is a good argument for naming these SIGNED_TAG_ABORT, etc. But thi=
s
> > is obviously an improvement in the meantime.
>
> In C enum values aren't the types of the enum, but I'd thought someone
> would have added a warning for this:
>
>     #include <stdio.h>
>
>     enum { A, B } foo =3D A;
>     enum { C, D } bar =3D C;
>
>     int main(void)
>     {
>         switch (foo) {
>           case C:
>             puts("A");
>             break;
>           case B:
>             puts("B");
>             break;
>         }
>     }
>
> But none of the 4 C compilers (gcc, clang, suncc & xlc) I have warn
> about it. Good to know.

Asked GCC to implement it: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D8=
7983
