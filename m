Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.9 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EDA681F453
	for <e@80x24.org>; Tue, 29 Jan 2019 12:01:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730646AbfA2MBt (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Jan 2019 07:01:49 -0500
Received: from mail-yb1-f171.google.com ([209.85.219.171]:34074 "EHLO
        mail-yb1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731093AbfA2MBr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jan 2019 07:01:47 -0500
Received: by mail-yb1-f171.google.com with SMTP id k9so7543304ybg.1
        for <git@vger.kernel.org>; Tue, 29 Jan 2019 04:01:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fMTwI6dry0E7p4Z8lPonxpl2cwMSfBDdxsC7pBtAiEo=;
        b=WqOEIeZTlkIfVkVQOf2qlBGu5AHVxYM+/vLHeaI6506jUj74bj7VNG4XE/+/Kdt6Nn
         SaWNFh/FpVGLroWW+7D10wAUlqwWx7+qSgkHdnZoS6rp5qXOwfs1OCNxWsFoIcD2JzQj
         IgWKHc43ovH5ppcb0blNp9mhc1IFiCPxVPq/revjW6insyKogfN1JetJtv2qidOey5mB
         Vk/hQ0X81sP5pyc9Jy3V0+tG/61ZnZfY9sCWaPGzURbQeimulY4XvLOM4Ndwc6AsQJuS
         JjegHBnVXiYoPiDgCy7ZpytWrG+r+BKGPs4Dhm2Gc1Fm6fdVLOsOKgF9NRjck8ACkS34
         ZCPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fMTwI6dry0E7p4Z8lPonxpl2cwMSfBDdxsC7pBtAiEo=;
        b=qS588XVrpWK9msY4KCUM5/fZorFFFQGBehJPB5EjWnxscB4UfJj0rzwZR/8ynNkxtL
         sEuMLEn5aEIAHBL4g7azwv02p5ZdTLlrvZlSY2jlp81T3t+kG1FJHldAy10ePm3AxmGS
         Y/sBhll0A5rvuquX1XQeRm9MbdbAPVfJeSi/g7cV/mDbdUhqhPreY9eoNBltkVuUQ9s2
         dvpc4k1EbJ2CXRi38tcBcNIvtoymAubWN1oILrWefG2/zNXhx1oi2cSKSEEz5+og7nBQ
         pCGvPD8Qf19Lh42CzvYoDISHzjdCVfL1vSjN2DIDTBLDj6IaVZLQ2C3+gdB+WMbuea6B
         S8dQ==
X-Gm-Message-State: AJcUukc91HpHDctRyXIuiP0tGFJGrLAI2BaXrvdY2rU78yl5S5f6e5kh
        rPBQuq04qYaBd1flmIKVNhleWv3k/SWSCDZEiZ4=
X-Google-Smtp-Source: ALg8bN5fbYhqrkpBbQd0lhKf54JIEOLnR3APkDakZWYcNL/qeheln7UYjlqtrxqWqRmryWCirR54FEz9awe6N3RvfdA=
X-Received: by 2002:a25:6a44:: with SMTP id f65mr24029217ybc.25.1548763305734;
 Tue, 29 Jan 2019 04:01:45 -0800 (PST)
MIME-Version: 1.0
References: <CAHMHMxWpqTDyCQPXPY6WPeMBHFzYGE=Z0Q8pSL=9TecwuP9fwg@mail.gmail.com>
 <CAP8UFD0eQ0hPkd-wsNR8e0hQSJC+dUQatvV1xgdJOUxtXYqC_g@mail.gmail.com>
In-Reply-To: <CAP8UFD0eQ0hPkd-wsNR8e0hQSJC+dUQatvV1xgdJOUxtXYqC_g@mail.gmail.com>
From:   =?UTF-8?B?zp3PhM6tzr3PhM6/z4IgzqPPhM6xz43Pgc6/z4I=?= 
        <stdedos@gmail.com>
Date:   Tue, 29 Jan 2019 14:01:09 +0200
Message-ID: <CAHMHMxU7fzHDqWnqx=d016FFPTpyR_Q9f8=oDt+BPBT2WS5bcA@mail.gmail.com>
Subject: Re: No clear API/Error message to validate a "revision object" using
 git rev-parse
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 29, 2019 at 12:51 PM Christian Couder
<christian.couder@gmail.com> wrote:
> > `--verify`s error message is even more cryptic:
> > $ git rev-parse --verify version.3
> > fatal: Needed a single revision
>
> Yeah, but it works.
>
> The error message could perhaps be improved. On the other hand it has
> been the same for a very very long time and very few people complained
> about it.
>
> [...]
>
> In fact as `git rev-parse` is a "plumbing command" it's supposed to be
> used mostly by scripts and power user who can easily deal with such an
> error message, which explains why there has not been much incentive to
> change this error message.

I understand the points here, and I understand how minor this "issue"
is in a sense.
Maintainers / fixer can decide on it, but I thought I should bring it
to lists' attention.

> As you are writing a script, you can at least easily redirect it to
> /dev/null and output something else.

I like the "expected" output in that way, since:
```
'version.0-false' is not matching. I am asking git ...
80d790c17c9a3f10c156561efc323ac5d4684b16
'version.0' is not matching. I am asking git ... fatal: bad revision 'versi=
on.0'
```
it "complements" the previous output, and sounds "fluent enough".
And also that I don't have to patchwork it (I can, obviously).

The reason I mentioned:

> $ git rev-parse --verify version.3
> fatal: Needed a single revision

is that the message sounds counter-intuitive. I already gave (what I
thought was) a revision, and it is "already" one.
I "could" claim that `git rev-parse` is reading 2 arguments
(`--verify` and `version.3`),
and somehow `git rev-parse --verify` checks that `argc =3D=3D 1`, and
failing due to a bug in the code.

I would understand that message in this context:
> $ git rev-parse --verify version.3 version.4
> fatal: Needed a single revision
since I gave 2 arguments instead of 1.

With regards,
=CE=9D=CF=84=CE=AD=CE=BD=CF=84=CE=BF=CF=82 =CE=A3=CF=84=CE=B1=CF=8D=CF=81=
=CE=BF=CF=82
