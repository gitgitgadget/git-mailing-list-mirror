Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F1621F454
	for <e@80x24.org>; Sun,  4 Nov 2018 06:29:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728817AbeKDPne (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Nov 2018 10:43:34 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:51141 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728781AbeKDPne (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Nov 2018 10:43:34 -0500
Received: by mail-it1-f195.google.com with SMTP id k206-v6so8550704ite.0
        for <git@vger.kernel.org>; Sat, 03 Nov 2018 23:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VYlBXKGzKnvPkcAH3Ezv5ZCUyoaLGj4r/Al+QpFGzys=;
        b=o/fJyHa5aBocU4Kzy0z2Gubgb8RO4gx6tLOJaMylo7cZyUfqq2832PNr4BZ/eJqNQQ
         z/dcxbwn9++ihldglV34WWW+AVVhxhFFPaNDiCqaBRNt59QRbrAAVHqx77oo7EzMPqjc
         eK4QJkaa113Aj28mKCZleEyaCQU0kRBRLmzGzQmSWLTpymPO/3qd6oXQi0kq+9YD6j3I
         O1qHnQUHpGdswvPh5SdLpAAPXJwiURTGYGacgawdxU1DlGoVjVo8lIcJdwabSiSfGkgR
         M3HBC03VPYjy5Z48NgQW50mtw2KyWlG/KcL+Aks000lyxHW/hlQP6LL5ugG5OoVbKyxs
         +0ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VYlBXKGzKnvPkcAH3Ezv5ZCUyoaLGj4r/Al+QpFGzys=;
        b=SAZdMf4Qywuy6ZAYK5JGYlCvhzEWIZN8mSQBOfJ+NTQKq9PH1uGeEfRqaaD16x4MZG
         ncomT/LGp4AhVKJQ6dTGqSC3FiYi3iqMrbYu5XvdFYRkkSS/6nKFYvMigEAAYWhFocIw
         49xl2npC6/2LYdfakSzcSqGT4oYo9nGjidJ2ta7PCV53NeUlJXIvOvFoNXbmuxCiuMII
         jaaBlX17ww4wzPBUC3V7Vam711H3jePQAWlsoDf1jaFad2m7jPxjcIi79Te4K5yCqWtb
         el1kWGaYRy5xGPeSluvEluO3SrWBOO0KhR/5Ad1fk/91NTlEMBdjl667GRaNp7YbzU1K
         /nWg==
X-Gm-Message-State: AGRZ1gITofKlWeBEbkO2TrRcCSDTAOzXZWx5nM6PoBUEax2xchOvAd2x
        u0255Z1WdxOTkCLFSlGl5+wou4oqtoM/BqSQcTQ=
X-Google-Smtp-Source: AJdET5cPLLmyBdGz2SCu1RKr0XH9Je2+yKgANM2uuJYQNs/PLaUn4lv+J9o6UF7rxx0v+mFk/5swxIsomIFRomQhQVM=
X-Received: by 2002:a24:7804:: with SMTP id p4-v6mr2838662itc.123.1541312982577;
 Sat, 03 Nov 2018 23:29:42 -0700 (PDT)
MIME-Version: 1.0
References: <CAGOLd-5Gbt6fQTvm+7018uX+8WF7NUWpa1sFWAg3-5bxtmOt-Q@mail.gmail.com>
 <20181103153049.22850-1-pclouds@gmail.com> <CAPig+cS7b0nenb0+0jyXE=-bDkhapmYE8Yr6VfyAWRq3ydjPOg@mail.gmail.com>
 <CAPig+cQTaG=pTQ_fQp8gv-4+bzJrSGCy8zK_iDeJsFNeX+4Cpg@mail.gmail.com>
In-Reply-To: <CAPig+cQTaG=pTQ_fQp8gv-4+bzJrSGCy8zK_iDeJsFNeX+4Cpg@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sun, 4 Nov 2018 07:29:16 +0100
Message-ID: <CACsJy8DPF8XFCkppnh6iyY3noQG-OMbqq3+LNm1iaotCSr-znw@mail.gmail.com>
Subject: Re: [PATCH] tree-walk.c: fix overoptimistic inclusion in :(exclude) matching
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Christophe Bliard <christophe.bliard@trux.info>,
        Git Mailing List <git@vger.kernel.org>,
        Rafael Ascensao <rafa.almas@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 4, 2018 at 7:27 AM Eric Sunshine <sunshine@sunshineco.com> wrot=
e:
>
> On Sat, Nov 3, 2018 at 8:25 PM Eric Sunshine <sunshine@sunshineco.com> wr=
ote:
> > On Sat, Nov 3, 2018 at 11:31 AM Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc D=
uy <pclouds@gmail.com> wrote:
> > > +test_expect_success 't_e_i() exclude case #8' '
> > > +       git init case8 &&
> > > +       (
> > > +               cd case8 &&
> > > +               echo file >file1 &&
> > > +               echo file >file2 &&
> > > +               git add . &&
> >
> > Won't this loose git-add invocation end up adding all the junk files
> > from earlier tests? One might have expected to see the more restricted
> > invocation:
> >     git add file1 file2 &&
> > to make it easier to reason about the test and not worry about someone
> > later inserting tests above this one which might interfere with it.
>
> Upon reflection, there shouldn't be any junk files since this test is
> creating a new repository and "file1" and "file2" are the only files
> present. Apparently, I wasn't paying close enough attention when I
> made the earlier observation.

Yup.

> Anyhow, the more restricted git-add invocation you used in the re-roll
> is still preferable since it makes the intention obvious. Thanks.

Which is why I did it anyway :)
--=20
Duy
