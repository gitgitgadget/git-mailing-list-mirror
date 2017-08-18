Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E5821F667
	for <e@80x24.org>; Fri, 18 Aug 2017 10:13:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750953AbdHRKNK (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Aug 2017 06:13:10 -0400
Received: from mail-wr0-f172.google.com ([209.85.128.172]:36905 "EHLO
        mail-wr0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750877AbdHRKNJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Aug 2017 06:13:09 -0400
Received: by mail-wr0-f172.google.com with SMTP id z91so57899606wrc.4
        for <git@vger.kernel.org>; Fri, 18 Aug 2017 03:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=7ubh/7duDzNKZ3PwK3DbcUGTNiJgbeZhfkliZY7QP/g=;
        b=V40zAnKJWb/jAcT5YguX5zKhe5eJK9VBRaCFqvs0CCJ1N3bfKNRyQ7ODNqJr6rW0sl
         hokktXrlSjGl6hQvazVMDvA9gE6WpQOpeAqkttiLYNlsj5N3inazx9NyCoJEtGU0LOql
         kNSiumx0Z2t8ttIXSNvTQtpYbGQ87Z1nsSyTx43UuBfiCWelm2GdMScyhO+gCNcOu0ND
         1hE3tGeGBu4Wg79bcwTSYyUkHWW4GIhHKDLE6Wk21wlTvoKezPiy1cP+gtdHhTaYiZ57
         EVVIHa/BGMleq8h93JUE2uGaC1HbquWCLFAYbZIA7EEuanE0OqYBp0kWTaii7tVdgFih
         yzlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=7ubh/7duDzNKZ3PwK3DbcUGTNiJgbeZhfkliZY7QP/g=;
        b=o4QWD7zoqBFcRsVn7/HcZ1iLpT0kTWulFdT2zNaupkZ42L4XSxUw5tVWNH/vn74kPI
         OWFfYsaiE3KHKKEn4XL3gGU7QClLzWvNojBZ48XBXZ1N4mlJpAwSqNakxuy9W3uVpszV
         kblSlIl9rMWvSxcC80V/F5J2xN5blAu4lryhfwAloY9aNWs80q3B+EpfA2PSaY07Q/Ql
         /yPeDG2C9nIcHABPo+9rTq5wHlfm86BAuCg9ZG9548m7IMmmNFLqdVKVAGiR8S30dHqM
         cSg1iZ8sWY/KIwQy8lhrOGPFJXcN1W6Yy10kO40BGWhTUKw3R07Tot7fE17iT6t0MT74
         515g==
X-Gm-Message-State: AHYfb5gwVF+NZH01ka39kTv9edW2s1zYE4KGiw9nca0906GvgG4L5cis
        ETZEnoedTDS0OuP6z+3zYdqFHsc3RQ==
X-Received: by 10.28.46.197 with SMTP id u188mr1082752wmu.26.1503051188007;
 Fri, 18 Aug 2017 03:13:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.28.24.130 with HTTP; Fri, 18 Aug 2017 03:12:37 -0700 (PDT)
In-Reply-To: <20170818062929.f4zitbtaeii4xiko@sigill.intra.peff.net>
References: <cover.1503020338.git.patryk.obara@gmail.com> <65f84c5eb94e8b6f5cbce31f56810fdb71a58bf9.1503020338.git.patryk.obara@gmail.com>
 <20170818062929.f4zitbtaeii4xiko@sigill.intra.peff.net>
From:   Patryk Obara <patryk.obara@gmail.com>
Date:   Fri, 18 Aug 2017 12:12:37 +0200
X-Google-Sender-Auth: 3hcVWD1rwx8_V69Xs6-fzzEeUdU
Message-ID: <CAJfL8+TRZQrfF9Y9PdBZTptEf_O9u9irVRzb0bBVAnTRga2xmw@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] commit: replace the raw buffer with strbuf in read_graft_line
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> wrote:

> AFAICT this is only here to avoid having to s/buf/line->buf/ in the rest
> of the function. But I think we should just make that change (you
> already did in some of the spots). And IMHO we should do the same for
> line->len. When there are two names for the same value, it increases the
> chances of a bug where the two end up diverging.

My motivation was rather to keep patch(es) as small as possible because eve=
ry
line using buf will be replaced in a later patch in series. But it will mak=
e
commit better (it will stand on its own), so why not to do it? :)

> (=E2=80=A6) I think short-circuiting like:
>
>   if (!line->len || line->buf[0] =3D=3D '#')
>
> is better (I also think "!" instead of "=3D=3D 0" is our usual style, but
> that's much less important).

Ah, I only replaced comparison to NULL terminator with length check because
I thought it better shows intention of the code and I didn't notice, that
reversing order will result in better code overall.

I will include both changes in v4.

--=20
| =E2=86=90 Ceci n'est pas une pipe
Patryk Obara
