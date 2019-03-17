Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2DD5920248
	for <e@80x24.org>; Sun, 17 Mar 2019 12:58:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbfCQM6a (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Mar 2019 08:58:30 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:54037 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726204AbfCQM63 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Mar 2019 08:58:29 -0400
Received: by mail-it1-f195.google.com with SMTP id k74so6324783ita.3
        for <git@vger.kernel.org>; Sun, 17 Mar 2019 05:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WjdKG9hkgGPWiQL7rQp0isar/pLvrkegNrQTD3uByUk=;
        b=ZzeLW4nmbLdH69XgaSMR79KClLCl1AwzMMgY3AfEnIcxctBqDn72tBRvKXSs5kCDus
         TR+aNbQC9FBIq0D0LUPmWSzhvig8kmD9Ru3+cQyJuu9cKrhD92NYN4tuC7pziVcRIHSg
         zIlNCrMHkwYSGqVGTBdDyytCkyQB4cC2WfvlkWPm7Fkm7SI5LEmqAUPK4HIazreBojY3
         YQ3CQ/mSzI4jnW20lUzyZVJZ7HtmujrsbjKBo8J/IJQS/qbYWrEcaDkYf20Bmjtk79D3
         6whLf5TckCEv9NixumNihAAH3XdQs75gEEO1mFwzVutFx5WDAIkEfuN0mL2ueskCrYXQ
         qrhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WjdKG9hkgGPWiQL7rQp0isar/pLvrkegNrQTD3uByUk=;
        b=UdgApgVqN+pNyMYKRnVKamcwfixXv9bq4CqxLy3NsBS+363VZ+77elrzrtvvXVRUql
         2z2N2Yhddc1TDNZHIlVqtVCB3RiFIitldWr95uJEPSwKHodjZ5fge/iHsg8vtjdpWck6
         wtuPcJQ5rMt7k6dbhDw9euA0M26Iztu0jwtCkL9OCpy4wHno9z6z40SzWaja0idgGwOR
         OSu2DmHgRLecor0P3XQIYlJWq6UM4VS5QVyihaWGT0PMH8CA3sjvTyvGivqqpr0QV+YS
         Tu+aX4nUf9bHk7pP/2o52Mmoq9oNOYMlJCFzBF5GjeTgCRfgmIC8pZST0IIwLdbDbxi/
         aPmg==
X-Gm-Message-State: APjAAAVTMWEVDe3PPHNpV8V4ZBORa2zklGiSXrLXDo61WyMS1oAQWqJ7
        J3VDTlSKiBltjNZzcZ44jHkxZD0lZ2cU2gUQVj8=
X-Google-Smtp-Source: APXvYqz8/B5CXfy9VB8tbh9cmj2DkGYe48UY9ecwAMiW3ejf+86ncNz4m38G+GlKMjH2fBnzatUB7+aJ7IENh7bVW+Y=
X-Received: by 2002:a24:ccc5:: with SMTP id x188mr7678729itf.123.1552827508647;
 Sun, 17 Mar 2019 05:58:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190308095752.8574-1-pclouds@gmail.com> <20190317124926.17137-1-pclouds@gmail.com>
In-Reply-To: <20190317124926.17137-1-pclouds@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sun, 17 Mar 2019 19:58:02 +0700
Message-ID: <CACsJy8BevFGXt-RL_1G263ntXYee69N055TY8_GQL1unvJNPnw@mail.gmail.com>
Subject: Re: [PATCH v4 00/26] Add new command 'switch'
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?Q?Eckhard_Maa=C3=9F?= <eckhard.s.maass@googlemail.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Andrei Rybak <rybak.a.v@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 17, 2019 at 7:49 PM Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <=
pclouds@gmail.com> wrote:
>
> Thanks for all the comments from v3 (and before), I didn't expect
> feedback from so many people. v4 fixes most of them, but still leaves
> a couple for v5.
>
> - -C remains because people seem to need it
>
> - --recreate vs --force-create: there was no strong preference for
>   either, so I stick with --force-create
>
> - --guess (dwim mode) is now made default
>
> - --orphan by default switches to an empty tree instead of current HEAD
>   (this is Elijah's alternative approach). This allows you to start
>   fresh, but you can still keep "HEAD" content or even switch to another
>   tree.
>
> - advice.detachedHead text is updated to suggest a way out (currently it
>   only suggests a way forward with 'checkout -b')
>
> - --force has a new alias --discard-changes
>
> - the error message when we expect a branch is improved to help point
>   out why the given argument is not a branch
>
> - more docs update and reorganization, and other silly bugs I made in
>   v3

I did forget one thing:

- 'git switch' refuses to switch in the middle of
rebase/bisect/cherry-pick/... session. Add --ignore-in-progress to
override this

Now that I mention this, --ignore-in-progress should probably be part
of --force too. Hmm...
--=20
Duy
