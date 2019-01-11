Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2459E1F803
	for <e@80x24.org>; Fri, 11 Jan 2019 01:59:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729391AbfAKB7f (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Jan 2019 20:59:35 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:35495 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728703AbfAKB7e (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jan 2019 20:59:34 -0500
Received: by mail-qt1-f194.google.com with SMTP id v11so16558951qtc.2
        for <git@vger.kernel.org>; Thu, 10 Jan 2019 17:59:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=IMLKPmnIcl4rHst8B4skCpxKm+rm2I7Dh9iRZdhbzF8=;
        b=CruOJOFQlhQIUUyBhMlIxlq4YWnMydxDh9LSveTgbivKadykv3jZYgNKU8F3PZcovj
         XfxbEGMAj8CHfLUOuXro5+fQ/cg6O5BFy1txrGfoYIpAODmdPSXroR3TIbv08cmXZBXQ
         p/E3auWU4tH4ZdZOz4Y96VuJ3S+RTPDIEb7VAfltoBztYfXHNcwRpEXeJQkPhR5q1fa5
         iSd2GEyyB1gwvP2KzqJRgAvm8zQZ6upX27qGbhPwqFvei8f7vXHXKgMlQ2FgNHn3F9uy
         KQ8jhOqm2pEzMBEC7qcB5QVGnz+QDoxqJ320qPTeJ9t3DCEOzz6YGSO/i+bMzFQ+jZOM
         5bxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IMLKPmnIcl4rHst8B4skCpxKm+rm2I7Dh9iRZdhbzF8=;
        b=EXXfEYBWzlM0RoQ/0QBUGXXU2uGurWrpJq7gqquoD9fhzQDXAD5poB8VPJ6VIEDs+d
         uTu3l0SsfoMMJ+jJDXgPgUfInOGckAJD5y9L+ZeOEk+aNoMp+3jqHw56evpJ9ptFTBmt
         sFCUYSG2Z37fZwzsgPVLSF7Prgaw9aqF2eIXZnS9GbahvbTeVJcVUaDtl94IjhGYXuUF
         HhXqdkxNcCQI+hSyZpWPARjy084oPcvy/SDF8ehfSLZAQLZw/1eqNMelYIDJnb9vNyzW
         eWk/3UeSXnpTVEYhMNsJ93JKbDfTXAnsMg+uBEsPlOeVmfMibYgZ3zsWd7ZOVJqxqPmP
         SW0g==
X-Gm-Message-State: AJcUukf/6k7NOmo0Ov6glHAsTEIJ7/23vyrKtnQD06iiUYailB/Qkh5N
        fhoXcjbtGvX1r1L/yJjMcC40EuADqJ2JflS6sj+doWUaubYrFw==
X-Google-Smtp-Source: ALg8bN6zF7Kuxflhn6oPeHNhRELNjh26/7BtNuJpsvblefzOpWe5PmgAt40Vow1r+03cbMoorE9Ewgk5xcBoJA5CUQU=
X-Received: by 2002:a0c:f212:: with SMTP id h18mr12367214qvk.106.1547171973675;
 Thu, 10 Jan 2019 17:59:33 -0800 (PST)
MIME-Version: 1.0
References: <20190109164731.GJ4673@szeder.dev> <20190110120142.22271-2-worldhello.net@gmail.com>
 <xmqqimyw1am8.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqimyw1am8.fsf@gitster-ct.c.googlers.com>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Fri, 11 Jan 2019 09:59:22 +0800
Message-ID: <CANYiYbFxCYSt0yQtt5xsFSshVCDuVU58hWBA6AF2e+QzmdUViQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/5] t5323: test cases for git-pack-redundant
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Sun Chao <sunchao9@huawei.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Johannes Sixt <j6t@kdbg.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2019=E5=B9=B41=E6=9C=8811=E6=97=
=A5=E5=91=A8=E4=BA=94 =E4=B8=8A=E5=8D=885:11=E5=86=99=E9=81=93=EF=BC=9A
>
> Jiang Xin <worldhello.net@gmail.com> writes:
>
> > From: Jiang Xin <zhiyou.jx@alibaba-inc.com>
> > +create_commits()
> > +{
>
> Style (see Documentation/CodingGuidelines).

OK, parenthese after function name.
>
> > +create_pack_1()
> > +{
> > +     P1=3D$(cd .git/objects/pack; printf "$T\n$A\n$B\n$C\n$D\n$E\n$F\n=
$R\n" | git pack-objects pack 2>/dev/null) &&
>
> Yikes.  Can't "git pack-objects" get the input directly without
> overlong printf, something along the lines of...
>
>         P1=3D$(git -C .git/objects/pack pack-objects pack <<-EOF
>                 $A
>                 $B
>                 $C
>                 ...
>                 $R
>                 EOF
>         )

Find that no space before <OID>,  because git-pack-objects not allow that,
and mached parentheses should in the same line.
So Will write like this:

    create_pack_1() {
            P1=3D$(git -C .git/objects/pack pack-objects pack <<-EOF) &&
    $T
    $A
    $B
    $R
    EOF
            eval P$P1=3DP1:$P1
    }

> > +test_expect_success 'no redundant packs' '
> > +     create_pack_1 && create_pack_2 && create_pack_3 &&
> > +     git pack-redundant --all >out &&
> > +     test_must_be_empty out
> > +'
> > +
> > +test_expect_success 'create pack 4, 5' '
> > +     create_pack_4 && create_pack_5
> > +'
> > +
> > +cat >expected <<EOF
> > +P2:$P2
> > +EOF
>
> Move this to the next "expect success" block?

$P4 and $P5 are defined after calling `create_pack_4` and `create_pack_5`,
so create pack functions should be called before write `expected` file,
if puts $P4 and/or $P5 in the expected file.

For this case, $P4 and $P5 not in expected file, we can move
create_pack_4 and 5 to the following test_expect_success block,
but the new algorithm may change the expected file.
>
> > +test_expect_success 'one of pack-2/pack-3 is redundant' '
> > +     git pack-redundant --all >out &&
> > +     sed -E -e "s#.*/pack-(.*)\.(idx|pack)#\1#" out | \
>
> How portable is "sed -E" (it is not even in POSIX.1)?  Wouldn't it
> be easier to work with to have two "-e" fed to a single sed
> invocation instead?

will fix using two '-e' commands.
