Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 64B421F453
	for <e@80x24.org>; Thu,  1 Nov 2018 01:36:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726134AbeKAKhL (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Nov 2018 06:37:11 -0400
Received: from mail-qt1-f179.google.com ([209.85.160.179]:46070 "EHLO
        mail-qt1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725823AbeKAKhL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Nov 2018 06:37:11 -0400
Received: by mail-qt1-f179.google.com with SMTP id l9-v6so19441247qtj.12
        for <git@vger.kernel.org>; Wed, 31 Oct 2018 18:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=sFwVwAAhMqDjONpwxWKc4ubHwL0xKqqU5tSP/EgGsUU=;
        b=rGZZ1yhZlb2KrcpP79zCptzFPomNUZv50HPoN1c5H4jUsBixqmbitPq2ksh3wCDrPv
         yOmIOC5fhgEZCWJG3Y5dHildQPiUCTX3NBtV1rqzJMNqmMddmZfnp6Z05BIUv8+2tO4M
         C1sPbPkx+ca2veHpA7wwC8qaNVvi79be+5AeFojGUK7rC7zSRD3bjIafabpitjxb3ZSK
         EJT2wyMMj6FVW/w2R43nHPgzzfSRbRtV8nY+SIacXOLEYsmrQXSIL+yFMxnsqtX414uJ
         H+HwuB1xth5Bh3YcsnmRDVWbz/3aW3za1F5VrTdOUXDnwYCSsEE5/09zvu1KHJVyMUga
         xOmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sFwVwAAhMqDjONpwxWKc4ubHwL0xKqqU5tSP/EgGsUU=;
        b=GdA5Fjre43/ZnDTvNzQ2DbT32N0bQtEy69/WL2QCQLuRdFPnCndH329Om5xaFguqGN
         RBpZCF+kCwkgyZ1GMAl7FcC9cC6s3FMXw3CGGkTqJFqff0FZyNOtk4aGrHRAZ0tvMua9
         Wqn/D6QcHPPp+C2AgVV/Pk91e35ngLUxUw2mrTuHLo82rUjbl1gmeBLOFOanM7kBixXI
         tNf7DGNRS4VZIZ1wbEkK4i855hU/twFW4g8WbEiamerpNhhorykVMzOu+cQjPH6PwT39
         wmnh5lTxhpO4iB7m30rrxebuQekquv0aDfrl1w9f2aJ7m0RiRj9Mf8z9jc5VEQSmD2D4
         sqxQ==
X-Gm-Message-State: AGRZ1gJFJg3m1MTmGvfGrhj22yF5yy9ALLmLL+zA82aFSa+odNrxt28n
        +dUefrKxeDAuR/leXzYjjqW+NzrJF8IEz5CG98A=
X-Google-Smtp-Source: AJdET5e0/Fnl4VJbMQ03vVsC7VogEq/b4unukjNpjGCYEF6mcQ5PwkUCpB7/uU+yLOGSdGjIZui04d7n/jq1McrQ4rA=
X-Received: by 2002:aed:20a3:: with SMTP id 32-v6mr5012439qtb.195.1541036184589;
 Wed, 31 Oct 2018 18:36:24 -0700 (PDT)
MIME-Version: 1.0
References: <20181028065157.26727-1-pclouds@gmail.com> <20181028065157.26727-13-pclouds@gmail.com>
 <20181029105304.GP30222@szeder.dev> <xmqqsh0o3kuw.fsf@gitster-ct.c.googlers.com>
 <CACsJy8CE2mi69kXcs2sFYm34txfDb24Qqm4bgv_w3WAcYEEFLg@mail.gmail.com>
 <87ftwolkl4.fsf@evledraar.gmail.com> <87efc8lkcd.fsf@evledraar.gmail.com>
In-Reply-To: <87efc8lkcd.fsf@evledraar.gmail.com>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Thu, 1 Nov 2018 09:36:13 +0800
Message-ID: <CANYiYbGwCwu5FXuir4bE_=eMjRaKtXKxk9h6LO_=xeWiabJuaA@mail.gmail.com>
Subject: Re: [PATCH 12/12] fsck: mark strings for translation
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, szeder.dev@gmail.com,
        Git List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> =E4=BA=8E2018=E5=
=B9=B410=E6=9C=8830=E6=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8A=E5=8D=881:43=E5=86=
=99=E9=81=93=EF=BC=9A
> On Mon, Oct 29 2018, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> Unlike the rest of our stack where we need to support however many years
> old tools we can freely rely on bleeding-edge gettext features, since
> the only person we need to convince to upgrade is Jiang. I.e. he accepts
> the PRs from translators, (presumably) runs msgfmt --check and then
> submits the result to Junio.

I used a shell script to check commits before I send a pull request to Juni=
o.
This script is in the po-helper branch, see:
https://github.com/git-l10n/git-po/tree/po-helper

It can catch unmatched '\n' errors (missing or unnecessary '\n').

    $ git diff
   diff --git a/po/zh_CN.po b/po/zh_CN.po
   index eabd4d1f8e..6b0d9ebc60 100644
   --- a/po/zh_CN.po
   +++ b/po/zh_CN.po
   @@ -5157,7 +5157,7 @@ msgstr  "=E7=95=A5=E8=BF=87=E8=A1=A5=E4=B8=81 '%s'=
=E3=80=82"
    #
    #, perl-format
    msgid   "Skipping %s with backup suffix '%s'.\n"
   -msgstr  "=E7=95=A5=E8=BF=87 %s =E5=90=AB=E5=A4=87=E4=BB=BD=E5=90=8E=E7=
=BC=80 '%s'=E3=80=82\n"
   +msgstr  "=E7=95=A5=E8=BF=87 %s =E5=90=AB=E5=A4=87=E4=BB=BD=E5=90=8E=E7=
=BC=80 '%s'=E3=80=82"
    #
    #, c-format
    msgid   "Skipping repository %s\n"

   $ LC_ALL=3DC po-helper.sh check
   ------------------------------------------------------------
   bg.po     : 3958 translated messages.
   ca.po     : 3328 translated messages, 18 fuzzy translations, 30
untranslated messages.
   de.po     : 3958 translated messages.
   es.po     : 3958 translated messages.
   fr.po     : 3957 translated messages, 1 fuzzy translation.
   is.po     : 14 translated messages.
   it.po     : 716 translated messages, 350 untranslated messages.
   ko.po     : 3608 translated messages.
   pt_PT.po  : 3198 translated messages.
   ru.po     : 3366 translated messages, 594 untranslated messages.
   sv.po     : 3958 translated messages.
   vi.po     : 3958 translated messages.
   zh_CN.po  : po/zh_CN.po:19717: 'msgid' and 'msgstr' entries do not
both end with '\n'
   msgfmt: found 1 fatal error
   3958 translated messages.
   ------------------------------------------------------------
   Show updates of git.pot...

   # Nothing changed. (run 'make pot' first)
   ------------------------------------------------------------
   Check commits...

   0 commits checked complete.
   ------------------------------------------------------------
   Note: If you want to check for upstream l10n update, run:
   Note:
   Note:     po-helper.sh check update <remote>
   ------------------------------------------------------------

So, no warry about it. BTW, I agree with Jonathan.

> Jonathan said:
> IMHO the advantage of leaving the \n out in the message is not so much
> that we don't trust translators but more that where we can make their
> lives easier, we should.

--
Jiang Xin
