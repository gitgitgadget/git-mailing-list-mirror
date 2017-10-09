Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F8151FA21
	for <e@80x24.org>; Mon,  9 Oct 2017 04:14:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753893AbdJIEOO (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Oct 2017 00:14:14 -0400
Received: from mail-pf0-f173.google.com ([209.85.192.173]:45694 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753711AbdJIEON (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Oct 2017 00:14:13 -0400
Received: by mail-pf0-f173.google.com with SMTP id z84so12552763pfi.2
        for <git@vger.kernel.org>; Sun, 08 Oct 2017 21:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5jCkR4kLoDGsFXReXNaK6h0MEkX+75B9wcjezjBpRHs=;
        b=D/PYG82L1m2LuBZUd8kBL7gsnJElvrHZGlthqh6FYpz+eMtWy1Gq9f+uaWOYrO7O4j
         FcPs6GP4wodox7M7qfvM9w1Wc/iN9ECTbZsK/LUExOUjjn5VvbuVi2y6oaMrvQpvU1TW
         WlM9vklAsmO91OBBW1BfImVdZm/ONgVQxjL5O4SyoL38cZeJarNjHVDODxu4X4MehM5q
         caMJC6pJFPlXGl89Bd7L2Wt36zTp9L0i+jOqDnLw9I9LBKPbmGnH8SJJX+oh31bMzn8K
         gjZ8LFHaQ7JVk2uZuMGLhrRU+qUczITy+Byj4KmAZ9wkQ1HXBoCBUwczvcp6SkdzuQtH
         /bMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5jCkR4kLoDGsFXReXNaK6h0MEkX+75B9wcjezjBpRHs=;
        b=FUUajht43kMV0037yNV/NVoGXS3812iHilw7AIyIdygPPgE9GupB5hq/FgnXBMPaTE
         owPfEkURU2N35BObil42DQ5wXcS+p1Hd7rGmyESk4PMdhffaL+uftMPCjzwoGNT6XKTg
         IWb+6f6seHiqpFMPJjSfjALwuhsI0Aq3D+wyS6zLUDoZoDUxnuItwpDeK7fOgFuTmKT6
         FC2GEkeJuZ51chMsrcbVF+ZjsvIF+9L8qIhbj4RpZOc5YpP/tziell0L1qn+mlRMC1OF
         rnCd06HcB/S9upwQd9woXSkaFZ2L3muT4zPsOiTc0bZ1D2cadaDp6e062OmXcc0X+56F
         X/fQ==
X-Gm-Message-State: AMCzsaXejgRCFp470KaAA052RYTRhzbsF2Q5bZFHGNWJP/D2PbOG47U4
        5BAGKC3DGoVWxumWXAgbfX5veVUo76j0pJ2N3HU=
X-Google-Smtp-Source: AOwi7QCl2p6FCAK1l8Ut9RY9tqgbLotuap/06TspSKBNVi8AH5UzyXSHZsr5gpgUgaJQAZ8NHJNg8N+O5ZTJhFg/20A=
X-Received: by 10.84.185.106 with SMTP id e39mr7931470plg.333.1507522453099;
 Sun, 08 Oct 2017 21:14:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.156.137 with HTTP; Sun, 8 Oct 2017 21:14:12 -0700 (PDT)
In-Reply-To: <CAPc5daVk+sPLmw4G_AghOVFeO5myKTADQjKr823U3xaQZK+43g@mail.gmail.com>
References: <CANYiYbGHBDGMEjbrvX_ayXkXkciT3GgL4seM_X1NmWtud2upcg@mail.gmail.com>
 <20171008084824.5331-1-martin.agren@gmail.com> <8686C1FA80EF45099730B50235CAFF6F@PhilipOakley>
 <20171009005137.4qwvkpedjslvbkca@genre.crustytoothpaste.net> <CAPc5daVk+sPLmw4G_AghOVFeO5myKTADQjKr823U3xaQZK+43g@mail.gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Mon, 9 Oct 2017 06:14:12 +0200
Message-ID: <CAN0heSqFSiev8BeZVu3KBA5vswsbQrrOH=tYYOSs_h_eq=8-3Q@mail.gmail.com>
Subject: Re: [PATCH] submodule: avoid sentence-lego in translated string
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Philip Oakley <philipoakley@iee.org>,
        Git Mailing List <git@vger.kernel.org>,
        Jiang Xin <worldhello.net@gmail.com>,
        Alexander Shopov <ash@kambanaria.org>,
        Jordi Mas <jmas@softcatala.org>,
        Ralf Thielow <ralf.thielow@gmail.com>,
        =?UTF-8?Q?Christopher_D=C3=ADaz?= <christopher.diaz.riv@gmail.com>,
        =?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>,
        Marco Paolone <marcopaolone@gmail.com>,
        Changwoo Ryu <cwryu@debian.org>,
        Vasco Almeida <vascomalmeida@sapo.pt>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Peter Krefting <peter@softwolves.pp.se>,
        =?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
        Jacques Viviers <jacques.viviers@gmail.com>,
        m4sk1n <m4sk1n@o2.pl>, Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9 October 2017 at 03:30, Junio C Hamano <gitster@pobox.com> wrote:
> On Mon, Oct 9, 2017 at 9:51 AM, brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
>> On Sun, Oct 08, 2017 at 10:32:35AM +0100, Philip Oakley wrote:
>>> From: "Martin =C3=85gren" <martin.agren@gmail.com>
>>> > - die(_("submodule entry '%s' (%s) is a %s, not a commit"),
>>> > -     cb->path, oid_to_hex(oid), typename(type));
>>> > + die(_("submodule entry '%s' (%s) is not a commit"),
>>> > +     cb->path, oid_to_hex(oid));
>>> Bikeshed,
>>> maybe:
>>> "submodule entry '%s' (%s) is not a commit. It is a %s"
>>> This puts the two parts in separate sentences?
>>
>> Languages with multiple grammatical genders are going to have problems
>> with this.  In French, "a tree" is "un arbre" (masculine), but "a tag"
>> is "une =C3=A9tiquette" (feminine).  We don't currently have a Spanish
>> translation, but this would break there as well.
>>
>> Splitting the article out with the type name is still problematic for
>> languages where articles vary by case, like German, since the
>> translation might be reused in another place requiring a different case.
>
> While all of the above is correct, would we really need to subject typena=
me()
> to translation? IOW, can't we just treat 'blob', 'tree', 'commit' and
> 'tag' as-is,
> as terms of art (i.e. with a specific or precise meaning within a
> given discipline
> or field and might have a different meaning in common usage)?

In another subthread, I sort of suggested "... is of type '%s', not 'commit=
'".
So "commit" and "%s" would appear as the file-format-level terms that they =
are.
I think it looks odd but I guess it might work in Swedish, FWIW.

In this particular case, we could have three specific messages plus one def=
ault
message (which at the time shouldn't ever occur). Or we have one specific
message for the "tag"-case, which seems to have been Stefan's original
motivation, and a generic message for the other cases.
