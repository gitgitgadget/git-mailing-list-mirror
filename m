Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C9CF1F597
	for <e@80x24.org>; Tue, 17 Jul 2018 08:15:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729614AbeGQIrC (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jul 2018 04:47:02 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:34644 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbeGQIrB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jul 2018 04:47:01 -0400
Received: by mail-lf0-f65.google.com with SMTP id n96-v6so196043lfi.1
        for <git@vger.kernel.org>; Tue, 17 Jul 2018 01:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HjarW2lmb80TsRuqaZwSo+5NIkyidCg3S09bQUs0iro=;
        b=bkZWk4n/DNXsO1Pb7rhyJfzwXKc/joS9lfd4nMZofvrcoiLNz1fKQx9DlT1tG6kxpG
         pIH+pNedrVzHcOVReF2iL/rbbFNK0dvjC4WJtf2UntjqrrbYlKncXDnpSI30iQvlEVrn
         6VcQbXHYFsRbyGVR5YY/gXpMIP+CjiYTiq/lI62Vb0zS7Ah09QFqgUPoArFySeNz1Pho
         AJnWe/GqpI93lgYcbwVUinPqunxQSvSC1HQYx4PqzESYa7P16ewIN0S+6XhuLjjs9Y1o
         0yIf6/XKXv/FkzTUxEBMANrqxuDhdANXIDPICS4+M66H0QVThZEZpnjlnn74Eg9FCChR
         XqDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HjarW2lmb80TsRuqaZwSo+5NIkyidCg3S09bQUs0iro=;
        b=Meq5YSr4uRnngD5Xb4n3m7R+YLau/Ko08eIxtP4LZWMC70N3ivPpL88f3zc0N4MQq0
         k7PCQel+jIymOHWPVWX2gZrTJn+V5OPlOQuQyPU7E//Vnr3iZcPrqbAAdAyVtjfrU5NT
         TD6/SaroHL6N6DjjzSwuDpm+lHap/p6UlArzleEKWEwGdg8/wpweqcuZNLRUWUdSHo0V
         0H9wQx11GMd25134qJ0ZgXB30GoDPMTHUoZv/Dy/Q/+SORcYIZahACXrKgpu6vNPKL10
         vM/Fgoz7iVsdcQZQAAnQFR0LaxVHrxO8Q+gbTfnbURI7fT74YIF2JaQF+Am6VDal8JcX
         6UsA==
X-Gm-Message-State: AOUpUlFliYtbp9gVcu5ZH3Tx5vBEcI0SYHK5Lsarlg5SzKUobYtJ3TxT
        n0N3IV2eEm1NkL93WU7A9b3nQD4XFPi0+f4glA0=
X-Google-Smtp-Source: AAOMgpfekVLGK+e2tEe3n2IqmLt3yEPrMxZur11PW2xEXZNmF6Ah25XCZU/0lJ59zOab4+FCR9LkAVZCQpqPTROySHQ=
X-Received: by 2002:a19:a04c:: with SMTP id j73-v6mr556146lfe.123.1531815336563;
 Tue, 17 Jul 2018 01:15:36 -0700 (PDT)
MIME-Version: 1.0
References: <20180702002405.3042-1-sunshine@sunshineco.com>
 <20180702002405.3042-22-sunshine@sunshineco.com> <20180712123729.17861-1-szeder.dev@gmail.com>
 <CAPig+cRYNo_KL02LN1LOa79Zm2oYZqbnBHJ=KDA3oaF4pVfjcA@mail.gmail.com>
 <xmqqd0vsxq47.fsf@gitster-ct.c.googlers.com> <xmqq8t6gxpxb.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq8t6gxpxb.fsf@gitster-ct.c.googlers.com>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Tue, 17 Jul 2018 10:15:25 +0200
Message-ID: <CAM0VKj=_5s40Z=8gRuRt__s74uSGa5wxy_+hDdAZhu8cRCC_Ew@mail.gmail.com>
Subject: Re: [PATCH 21/25] t5000-t5999: fix broken &&-chains
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git mailing list <git@vger.kernel.org>,
        Elijah Newren <newren@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Stefan Beller <sbeller@google.com>,
        Luke Diamand <luke@diamand.org>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 12, 2018 at 8:35 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Junio C Hamano <gitster@pobox.com> writes:
>
> > Eric Sunshine <sunshine@sunshineco.com> writes:
> >
> >> On Thu, Jul 12, 2018 at 8:37 AM SZEDER G=C3=A1bor <szeder.dev@gmail.co=
m> wrote:
> >>> The change below should be squashed into this patch to fix a
> >>> previously unnoticed broken &&-chain.  I think you missed it, because
> >>> this test script is rather expensive and you didn't run it with
> >>> GIT_TEST_CLONE_2GB=3DYesPlease.
> >>>
> >>> diff --git a/t/t5608-clone-2gb.sh b/t/t5608-clone-2gb.sh
> >>> @@ -23,7 +23,7 @@ test_expect_success CLONE_2GB 'setup' '
> >>> -               echo "M 100644 :$i $i" >> commit
> >>> +               echo "M 100644 :$i $i" >> commit &&
> >>
> >> Thanks for finding this. I tried to get as much coverage as possible
> >> by installing packages I don't normally have installed (Apache, cvs,
> >> cvsps, Subversion, Perforce, etc.) and even temporarily modified a
> >> script or two to force it run ...
> >
> > Thanks, both.  I think the &&-chain fix series is already large and
> > also otherwise seem to be pretty solid, so let's not reroll but
> > queue this addition on top.
>
> Oops, sent before completing the message.
>
>         For that to happen, we need a sign-off ;-)
>
> I guess this one would have been caught with the "sed script on
> subshell" linter that does not execute?

It was in fact caught by Eric's linter (Travis CI runs these expensive
tests, too), so I think it would be more appropriate to give him the
credit.

Signed-off-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>


> -- >8 --
> Subject: t5608: fix broken &&-chain
>
> This is inside a loop that is run inside a subshell, in a test that
> is protected with CLONE_2GB prerequisite, one or more which is quite
> likely reason why it wasn't caught durin the previous clean-up.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  t/t5608-clone-2gb.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/t5608-clone-2gb.sh b/t/t5608-clone-2gb.sh
> index df822d9a3e..2c6bc07344 100755
> --- a/t/t5608-clone-2gb.sh
> +++ b/t/t5608-clone-2gb.sh
> @@ -23,7 +23,7 @@ test_expect_success CLONE_2GB 'setup' '
>                 printf "blob\nmark :$i\ndata $blobsize\n" &&
>                 #test-tool genrandom $i $blobsize &&
>                 printf "%-${blobsize}s" $i &&
> -               echo "M 100644 :$i $i" >> commit
> +               echo "M 100644 :$i $i" >> commit &&
>                 i=3D$(($i+1)) ||
>                 echo $? > exit-status
>          done &&
