Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1CCCC433EF
	for <git@archiver.kernel.org>; Mon, 23 May 2022 08:26:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231787AbiEWI0l (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 May 2022 04:26:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232049AbiEWI02 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 May 2022 04:26:28 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 798BA11A10
        for <git@vger.kernel.org>; Mon, 23 May 2022 01:26:25 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id c9so10942642qvx.8
        for <git@vger.kernel.org>; Mon, 23 May 2022 01:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=s1rnR68ghxWYGiMp+9j9QcoxSjb9ILyJ0AJaQTxysXA=;
        b=SkVz5BcrxWcNDqnL2xx8Z97E/0lhrTRt9FKT/jHWJ0BIdDgHalANLZdS4+zQvWM4xu
         muC7/wPvDLdEemb0YSaAZb1mKhCCwsw2p19YxC90FUCAg20AJcdwRcRasX61kh/V+TX6
         RvHIDQ19s9lBaz+gef9DZcmu+J9ScuTc0ThpKCL5Xmd9Ni+wV75MQ1dWqoyT+L55P2Zq
         syB7GgffO+oWlbVnDchHPlV24qwmHrQlsVAeB7y99D7doUh70urufXdoZzixoqlON12S
         ZzudYXKvNzCYSKWG/NKs/oboYvmrVcXBcKb/pBbtX2VMaraauuHQBxCblwihDbNffgGZ
         YvbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=s1rnR68ghxWYGiMp+9j9QcoxSjb9ILyJ0AJaQTxysXA=;
        b=KkbbucmcYXWRtE9qX7/MEQ8MReDKSHOdqZgJqWQYT9lWjsh9eQkk0X7dWL2LaZ67C1
         3Qr3BWLTpi8DLXu5ZdeQmuGIZN7erIHiCMKKqTVWEZZnNAscG3PXG5vcVP8VHjrt6zuc
         YkALWTj7ulDgqSG6EuD/yuf0LTeU8rd7I2TqRe+v2MMgcv/Za73veQbA3lhWsbYZiLXc
         16bTLmtghoqqbKlgh6mBbvj/RzXQvLsa1EOrQyoJ3fUtEN2TMVF/uehbWfWrLB5knFjs
         XVx7Vp/B+wp4laI0bnqngMAR2SpgXdxCSETJnVqgZAOsw9PjmYSp9JlaVwJMtKTQFU6b
         zjsg==
X-Gm-Message-State: AOAM531iXfiBzyoMubz4c4xvw5TUZMfYS5JD7ZK70iifLAfB7EPj5KUj
        ZXlenK01zjYbhS98OEGop4ccldq1XtvSbkYAHMY=
X-Google-Smtp-Source: ABdhPJy+BvYkhlBtrPi2FbEYiYBaSEKtBmkDUAZPgCqWKxprNrn2J2QuWPyXnEVYs25AqZs9C/CLh7sWrWxSz1rro4c=
X-Received: by 2002:ad4:5965:0:b0:45b:a80f:c7e3 with SMTP id
 eq5-20020ad45965000000b0045ba80fc7e3mr16181905qvb.11.1653294384787; Mon, 23
 May 2022 01:26:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220519081548.3380-1-worldhello.net@gmail.com>
 <20220523012531.4505-1-worldhello.net@gmail.com> <220523.86v8twzp6a.gmgdl@evledraar.gmail.com>
In-Reply-To: <220523.86v8twzp6a.gmgdl@evledraar.gmail.com>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Mon, 23 May 2022 16:26:13 +0800
Message-ID: <CANYiYbGWrMuqzApDOyJyohmZkfdKf7+oP5gJQZmBS-+wqU08CQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/9] Incremental po/git.pot update and new l10n workflow
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Alexander Shopov <ash@kambanaria.org>,
        Jordi Mas <jmas@softcatala.org>,
        =?UTF-8?Q?Matthias_R=C3=BCster?= <matthias.ruester@gmail.com>,
        Jimmy Angelakos <vyruss@hellug.gr>,
        =?UTF-8?Q?Christopher_D=C3=ADaz?= <christopher.diaz.riv@gmail.com>,
        =?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Alessandro Menti <alessandro.menti@alessandromenti.it>,
        Gwan-gyeong Mun <elongbug@gmail.com>, Arusekk <arek_koz@o2.pl>,
        Daniel Santos <dacs.git@brilhante.top>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Peter Krefting <peter@softwolves.pp.se>,
        Emir SARI <bitigchi@me.com>,
        =?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
        Fangyi Zhou <me@fangyi.io>, Yi-Jyun Pan <pan93412@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 23, 2022 at 3:25 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
>
> On Mon, May 23 2022, Jiang Xin wrote:
>
> > From: Jiang Xin <zhiyou.jx@alibaba-inc.com>
> >
> > A workflow change for translators are being proposed.
> >
> > Changes since v2:
> >
> >  1. Patch 1/9: reword.
> >  2. Patch 2/9: reword.
> >  3. Patch 3/9: reword, and add "FORCE" to prerequisites of "po/git.pot"=
.
> >  4. Patch 6/9: remove "FORCE" from prerequisites of "po/git.pot".
> >  5. Patch 8/9: reword, and reuse "$(gen_pot_header)" to prepare pot
> >                header for "po/git-core.pot".
> >  6. Patch 9/9: various updates on po/README.md.
>
> From skimming this the *.c.po v.s. *.c extension is still left in
> comments. I'm not saying you need to go for my suggestions, but it would
> be very useful in CL's to note things that were suggested but not
> changed, such as that.

I've tried to improve some commit logs to make my point that we should
name the po files in ".build/po/" with ".po" extension instead of ".c"
extension. We can choose plan A, move forward with this patch series,
and start using the new workflow in 2.37. If you want, we can try Plan
B during next release cycle.

> Right now I haven't paged that v2 discussion into my brain again, so I
> don't know if that was the only thing, it's the only thing I remember
> right now...
>
> But let's read on:
>
> > Range-diff vs v2:
> >
> >  1:  c45f34f233 !  1:  362cd0cbe1 Makefile: sort "po/git.pot" by file l=
ocation
> >     @@ Metadata
> >       ## Commit message ##
> >          Makefile: sort "po/git.pot" by file location
> >
> >     -    Before feeding xgettext with more C souce files which may be i=
gnored
> >     -    by various compiler conditions, add new option "--sort-by-file=
" to
> >     -    xgettext program to create stable message template file "po/gi=
t.pot".
> >     +    We will feed xgettext with more C souce files and in different=
 order in
> >     +    subsequent commit. To generate a stable "po/git.pot" regardles=
s of the
> >     +    number and order of input source files, we add a new option
> >     +    "--sort-by-file" to xgettext program.
> >
> >          With this update, the newly generated "po/git.pot" will has th=
e same
> >     -    entries while in a different order. We won't checkin the newly=
 generated
> >     -    "po/git.pot", because we will remove it from tree in a later c=
ommit.
> >     +    entries while in a different order.
> >     +
> >     +    With the help of a custom diff driver as shown below,
> >     +
> >     +        git config --global diff.gettext-fmt.textconv \
> >     +            "msgcat --no-location --sort-by-file"
> >     +
> >     +    and appending a new entry "*.po diff=3Dgettext-fmt" to git att=
ributes,
> >     +    we can see that there are no substantial changes in "po/git.po=
t".
> >     +
> >     +    We won't checkin the newly generated "po/git.pot", because we =
will
> >     +    remove it from tree in a later commit.
>
>
> Does this actually work? This seems to suggest adding a driver for *.po,
> but using it against the *.pot file. Isn't that a typo (I haven't tested
> it)>

Thanks, it's really a typo. s/*.po/*.pot/

>
> >          But it is much simpler to use variables "$(FOUND_C_SOURCES)" a=
nd
> >     -    "$(FOUND_C_SOURCES)" to form a stable "LOCALIZED_C".
> >     +    "$(FOUND_C_SOURCES)" to form a stable "LOCALIZED_C". We also a=
dd
> >     +    "$(SCALAR_SOURCES)" files, which are part of C_OBJ but not inc=
luded in
> >     +    "$(FOUND_C_SOURCES)" because they are in the "contrib/" direct=
ory.
>
> Thanks, good to note that.
>
> [snipped the rest, will re-read individual commits]
