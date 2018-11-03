Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD2B41F453
	for <e@80x24.org>; Sat,  3 Nov 2018 08:30:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbeKCRkc (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Nov 2018 13:40:32 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:34850 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbeKCRkb (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Nov 2018 13:40:31 -0400
Received: by mail-it1-f196.google.com with SMTP id v11so111155itj.0
        for <git@vger.kernel.org>; Sat, 03 Nov 2018 01:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WD+YClfqOD1rLqiz0F+loNAbfu4hnWritD1U1Ht8khA=;
        b=O8E1PDv3/r/rFYFAGEhb7BeQ39hQjxuv5pLkDMrNI4DlKZcetSEfy8BoHO69x0Mz/n
         zWAkW4I5Kex4YaGhkzfekzptfnXJZ4DI/JE7TR03s7R0u5SVjB1kL31+g3KlNUVakAs8
         DSj061SMjtFo0fABQ/VWheOMQh4KmJO1y+2WU8ZBn3ir5vg6bvQuklrBUeOVx7NpZxG8
         kcNjWkL9AHixBOk5i8EavUKueqbhGUO/BJeT9QKTc0NJYsn+oUEImgQB7Flrspu7hyUK
         2ikotsUYFW+HutErNJNQvzUeuI0a9x2R3bTar9Y4Vcc21z/zMH/j4+Wb4OwACJhoh9I7
         BU6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WD+YClfqOD1rLqiz0F+loNAbfu4hnWritD1U1Ht8khA=;
        b=d7uA7cz2J+it0HQ8YGfl3xRX4cSm1MIsw+SjfOMlTS/sI5pDGE+YWbvFz4AKX8QoDF
         L1irRYMeK7csj/s3ujX07RZoXrLF0GNQpT/wQ2slqdVP2NGXOfOdrrTuZUxIMqcGfwPw
         2a84PLCnSGOm5IzlmZBl9WKEazePyp43C+mHiktTQSiuOmsIIuQ9sXK+SxysyGLaQI+m
         orbhejMbLgR790MS0gC6j/hAABIckdyZWSlnRBM9UqSUBjTs+yg9Xfy4/2F3fIETU9UQ
         +basSyFzawJBKS9Vh9rcyLmaUnvGcJi33QaepeS4XSTmzXz/yjjxN+rCidfuMcrmdv9X
         ZPsw==
X-Gm-Message-State: AGRZ1gKUYAJMhKwqWBQE+0+1SQUgqmHg64OVQg0EyslBHfyZDEIV8jIG
        lf5rKi6PRHQcyUdV62Z6fMae4v4cg1CdzcozHKk=
X-Google-Smtp-Source: AJdET5cBtJqRcgMWn3qKBS82IVuv2mU/mUWwBjXq4rhpItKD/RMnIqm639RRjvJd4ft29d9dKKbTt1bDOB400lbap+Y=
X-Received: by 2002:a24:b64b:: with SMTP id d11-v6mr223569itj.10.1541233798364;
 Sat, 03 Nov 2018 01:29:58 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqbm7c2n0i.fsf@gitster-ct.c.googlers.com> <72331ce9275ce995009fe8dd3d586bb9d71f2cbf.1540881141.git.liu.denton@gmail.com>
 <CACsJy8Ajc0qWw3RLak1PRPXvQzMHjaFuWJ6BPkhiVg=7fQvCnA@mail.gmail.com>
 <xmqqk1lxvaj6.fsf@gitster-ct.c.googlers.com> <CACsJy8AowaAW91wGMYbC8aTOB1NoqQN-5NGx=qUCHp0i6zQRDA@mail.gmail.com>
 <xmqqzhuss6dd.fsf@gitster-ct.c.googlers.com> <20181103060317.GA5432@duynguyen.home>
 <20181103075918.GA905@archbookpro.localdomain>
In-Reply-To: <20181103075918.GA905@archbookpro.localdomain>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 3 Nov 2018 09:29:31 +0100
Message-ID: <CACsJy8B4vrtsBu79J2kYNmcNQfRkgetdbi8XOPjm7j1kNDJ6Yg@mail.gmail.com>
Subject: Re: [PATCH v2] completion: use builtin completion for format-patch
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Anmol Mago <anmolmago@gmail.com>, briankyho@gmail.com,
        david.lu97@outlook.com, shirui.wang@hotmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 3, 2018 at 8:59 AM Denton Liu <liu.denton@gmail.com> wrote:
> > @@ -2081,7 +2077,7 @@ _git_send_email ()
> >               return
> >               ;;
> >       --*)
> > -             __gitcomp "--annotate --bcc --cc --cc-cmd --chain-reply-to
> > +             __gitcomp_builtin send-email "--annotate --bcc --cc --cc-cmd --chain-reply-to
> >                       --compose --confirm= --dry-run --envelope-sender
> >                       --from --identity
> >                       --in-reply-to --no-chain-reply-to --no-signed-off-by-cc
>
> Would it make sense to make send-email's completion helper print these
> out directly? That way, if someone were to modify send-email in the
> future, they'd only have to look through one file instead of both
> send-email and the completions script.

I did think about that and decided not to do it (in fact the first
revision of this patch did exactly that).

If we have to maintain this list manually, we might as well leave to
the place that matters: the completion script. I don't think the
person who updates send-email.perl would be always interested in
completion support. And the one that is interested usually only looks
at the completion script. Putting this list in send-email.perl just
makes it harder to find.
-- 
Duy
