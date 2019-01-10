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
	by dcvr.yhbt.net (Postfix) with ESMTP id AC1311F803
	for <e@80x24.org>; Thu, 10 Jan 2019 03:30:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726938AbfAJD2r (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Jan 2019 22:28:47 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:39134 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726637AbfAJD2r (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Jan 2019 22:28:47 -0500
Received: by mail-qt1-f196.google.com with SMTP id u47so10949804qtj.6
        for <git@vger.kernel.org>; Wed, 09 Jan 2019 19:28:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RXFbv2luD/dxcYoinhHXp+Mv7MZ1vX/eiD26auVue4s=;
        b=PSTyRLilaRuesUvZGmPKy9nn2U1/CPsz3LqdJXipZNhWzTeweoDD2Q+b96L8bV2QWf
         JBentlXFikQNxIdi52Qp5x3WBhWYjJmQ59IV9BvDWe1dD1/AfMkj2eieSQ3pqd9jkU4N
         AyoUgvW4w7ZZIVV81xTWPicP7NeUImMLpMSlZJWP3HEXaECebOjPlKAvNungsV6Vlbcf
         YDQfMYyK08hHbzhuoMis11iihtMp8XfI5JbBxHVUPuyVcaoA3Nany8hG2TP5VzCi8+fR
         V4XPG3BA5l12fQmh7jIUqISjaNa1+Vslj4fPhOY5XzRBcxM/a456UX07SkYh1z2wFVUM
         87gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RXFbv2luD/dxcYoinhHXp+Mv7MZ1vX/eiD26auVue4s=;
        b=mB+59QQCxsQtf0z6J1gBuBolQ3LYJBCDB0b66hrwqPjs7nBpMybcCeNuIMa8cLwTKI
         V4TZ7GzQRcV8fE+wViJ/zkuVPzFMOEpZmWUaNjxQzcl0XElfA/UUEImgv0uUk0KpkCBN
         PcYodqvJ+JWBmjcd2WZ3YmljneP9FuCWZ6R9W1+wS3D5tSaclc7jERGh4JTrb5uc1zdJ
         bZsT4E201DOLrRpvFCd8P769+O3zKqUlFzrW/SS9Nx6Q/d5zQqjkxpqVU5R5AsD2oy0D
         L6cuil80sRn1GPd9Z+l8zyIGgF+7HC1qNW+OiiKFauBW7E0Ghwz+O/rQL3H/1L2WJvpc
         q/Cw==
X-Gm-Message-State: AJcUukfcJwmtZS+eiqRtSpsnISPic5dIM24s/uK84toU9TreLRjzL5/5
        vFuUleUc3KHEE/uvJZRxDrixCqEaLcMhell06nU=
X-Google-Smtp-Source: ALg8bN7vv3dI5Cyx9+VYdRpW94v19wKJA2Ltz8L1xQ3e5FaMPyvqrVD4SIopzT4H9gOX8TE0W0JUFl7pgNPjpT+3ihA=
X-Received: by 2002:aed:3746:: with SMTP id i64mr7944338qtb.307.1547090926353;
 Wed, 09 Jan 2019 19:28:46 -0800 (PST)
MIME-Version: 1.0
References: <20181219121451.21697-1-worldhello.net@gmail.com>
 <20190102043456.15652-2-worldhello.net@gmail.com> <20190109125628.GG4673@szeder.dev>
In-Reply-To: <20190109125628.GG4673@szeder.dev>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Thu, 10 Jan 2019 11:28:34 +0800
Message-ID: <CANYiYbGqLHr-t+f6m6gyY3QiYgxbzbqsmmRw-afKe6NG_mxhPQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] t5323: test cases for git-pack-redundant
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Sun Chao <sunchao9@huawei.com>, Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> =E4=BA=8E2019=E5=B9=B41=E6=9C=889=
=E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=888:56=E5=86=99=E9=81=93=EF=BC=
=9A
>
> On Wed, Jan 02, 2019 at 12:34:54PM +0800, Jiang Xin wrote:
> > From: Jiang Xin <zhiyou.jx@alibaba-inc.com>
> > +test_description=3D'git redundant test'
>
> s/redundant/pack-redundant/ ?

Yes, will correct it.

> > +
> > +. ./test-lib.sh
> > +
> > +create_commits()
> > +{
> > +     set -e
> > +     parent=3D
> > +     for name in A B C D E F G H I J K L M
> > +     do
> > +             test_tick
> > +             T=3D$(git write-tree)
> > +             if test -z "$parent"
> > +             then
> > +                     sha1=3D$(echo $name | git commit-tree $T)
>
> There is a considerable effort going on to switch from SHA-1 to a
> different hash function, so please don't add any new $sha1 variable;
> call it $oid or $commit instead.
>

Will do.

> > +
> > +# Create commits and packs
> > +create_commits
> > +create_redundant_packs
>
> Please perform all setup tasks in a test_expect_success block, so we
> get verbose and trace output about what's going on.

Will do like this:

    test_expect_success 'setup' '
            create_commits  &&
            create_redundant_packs
    '

> Don't use 'set -e', use an &&-chain instead.  To fail the test if a
> command in the for loop were to fail you could do something like this:
>
>   for ....
>   do
>     do-this &&
>     do-that ||
>     return 1
>   done

Will do.

> > +
> > +test_expect_success 'clear loose objects' '
> > +     git prune-packed &&
> > +     test $(find .git/objects -type f | grep -v pack | wc -l) -eq 0
>
> Use something like
>
>   find .git/objects -type f | grep -v pack >out &&
>   test_must_be_empty out
>
> instead, so we get an informative error message on failure.

if `grep -v pack` return empty output, it will return error, so
I will use `sed -e "/objects\/pack\//d" >out` instead.

>
> > +'
> > +
> > +cat >expected <<EOF
> > +P1:$P1
> > +P4:$P4
> > +P5:$P5
> > +P6:$P6
> > +EOF
> > +
> > +test_expect_success 'git pack-redundant --all' '
> > +     git pack-redundant --all | \
>
> Don't run a git command (especially the particular command the test
> script focuses on) upstream of a pipe, because it hides the command's
> exit code.  Use an intermediate file instead.
>
> > +             sed -e "s#^.*/pack-\(.*\)\.\(idx\|pack\)#\1#g" | \
>
> This sed command doesn't seem to work on macOS (on Travis CI), and
> causes the test to fail with:
>

It works if rewrite as follows:

    git pack-redundant --all >out &&
    sed -E -e "s#.*/pack-(.*)\.(idx|pack)#\1#" out | \

Without `-E`, MasOS has to write two seperate sed commands, such as:

    git pack-redundant --all >out &&
    sed -e "s#.*/pack-\(.*\)\.idx#\1#" out | \
    sed -e "s#.*/pack-\(.*\)\.pack#\1#"

Option '-E' is an alias for -r in GNU sed 4.2  (added in 4.2, not documente=
d
unti 4.3), released on May 11 2009.  I prefer the `-E` version.

>
> Minor nit: 'git pack-redundant' prints one filename per line, so the
> 'g' at the end of the 's###g' is not necessary.
>
> > +             sort -u | \
> > +             while read p; do eval echo "\${P$p}"; done | \
> > +             sort > actual && \
>
> Style nit: no space between redirection operator and filename

Will do.
