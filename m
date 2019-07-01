Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DDD611F461
	for <e@80x24.org>; Mon,  1 Jul 2019 00:31:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbfGAAbI (ORCPT <rfc822;e@80x24.org>);
        Sun, 30 Jun 2019 20:31:08 -0400
Received: from mail-io1-f47.google.com ([209.85.166.47]:34875 "EHLO
        mail-io1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726086AbfGAAbI (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Jun 2019 20:31:08 -0400
Received: by mail-io1-f47.google.com with SMTP id m24so24826753ioo.2
        for <git@vger.kernel.org>; Sun, 30 Jun 2019 17:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ACFHeK5LTsJF5TqcH6+HxzHNAod41+VgQhi13LU/wxU=;
        b=SmKxRhmE+1q819tvEQKNgt4Sgb/rhjm7OfqB7FvQzWtqipdmMZii8G+dCCOpLo1v4m
         HZuwRvGSWx5DbFQRzgfDIxwI2GVRq9wRXZlOw8segttgSaSaKNfJljDa8cBJYQD6wT3a
         UPEFCXbIP8w9OcUQxeI/d4QEej0e5EzMIVAjPAA+Ok7lUeWQ67wGUl23OsANBX9ue+zQ
         g6XBD/ZbZeBFGnSd6PkUtbcPxXhETJpI8EYKhDQh9b3/zFfxx1P696+YZ1tI3RJ/Zdzf
         3DGUdvCmXyrFrYQH2cA6HWGuwhLZOHFhDZAAbYqRGjMTdyFa561AKp2uLF0gag23Aetw
         kogg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ACFHeK5LTsJF5TqcH6+HxzHNAod41+VgQhi13LU/wxU=;
        b=Os1tvg5wLX/ZaqeyIGqn1ZHKIKZaM0rOrE+B2l9xtu0bCikr/x62dkHcSSg80D6d08
         y39sVFbl48vi7GGAKvG7pZvQQ/FiZHqynR+QHfLPfdqLZrIGkYFfTevmSCCTkAnpSGSW
         XFNNDrkHBZIQ82XU0bKeaxlozma8YjiB0pvXz6OsZz8NDDdOG1vJV1PK54E+tkQMYx7s
         boZjOU67HQrNRFr8Fs6Jerl0Ru7Pyf+TokK1on45osJYYiUlXSaVy3nCEIyDMNs14jxD
         6xMvWQd2YTFReUffjVfl7H70dSOOvWl5/wzMKubtvAeJwE920JHpKlNGtnbS+fzgQCCu
         UvEA==
X-Gm-Message-State: APjAAAXXjTwbHQ2guqFePt5LuXQGWMQVU79o0RcVN3uUzVX2xqhyFn6q
        ea20uTXJlMsq63HlhVVnnZWEof0vqsR3BpNkOo8=
X-Google-Smtp-Source: APXvYqzR0t1aDxqB2K2tj9780iDlUkgPEZDi0ScRZEPNGQYC4Er4muTKwDsa+TAw7fkraXt3QdgXlTDLYne+9vUY948=
X-Received: by 2002:a5d:8890:: with SMTP id d16mr6454577ioo.274.1561941067098;
 Sun, 30 Jun 2019 17:31:07 -0700 (PDT)
MIME-Version: 1.0
References: <8C0042D8869AEA4AA334B49AFBBCEF820243C01B6A@TUT-EX01-PV.KSTG.corp>
 <20190626084139.30246-1-pclouds@gmail.com> <86a7dz4e06.fsf@gmail.com>
In-Reply-To: <86a7dz4e06.fsf@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 1 Jul 2019 07:30:40 +0700
Message-ID: <CACsJy8AQ=kiG4jH5WSujefoCQ2yCG4=dV7UUdVh-Gextoa_T7A@mail.gmail.com>
Subject: Re: [PATCH/RFC] get_oid: new extended SHA-1 syntax to control
 resolution process
To:     Jakub Narebski <jnareb@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Kyle Meyer <kyle@kyleam.com>,
        "Boettger, Heiko" <Heiko.Boettger@karlstorz.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jun 30, 2019 at 4:30 PM Jakub Narebski <jnareb@gmail.com> wrote:
>
> Bikeshed painting ahead.
>
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:
> [...]
> > The problem is we try every possible way to resolve a rev. Let's have
> > some annotation to express that we only want to resolve a rev in a
> > certain way:
> >
> > - <hash>@{hash} only accepts a full hash or a short hash. If it's a
> >   short hash, it cannot be ambiguous.
> >
> > - <ref>@{literal} only accepts full ref. No turning "master" into
> >   "refs/heads/master".
> >
> > - <output>@{describe} interprets <output> as git-describe output
> >   only, not an object name or a reference.
> >
> > This gives scripts much better control over get_oid(), which
> > translates to rev-parse and a bunch other commands.
> >
> > PS. The new syntax can stack with existing ones. E.g. you could write
> > refs/heads/master@{literal}@{yesterday} or <hash>@{hash}^{tree}.
> > Perhaps I should allow these tags at the end too, so you can enforce a
> > variable like "$REV"@{literal} where $REV could be even HEAD~123
>
> I think it would be better to use <hash>^{hash} instead of
> <hash>@{hash}.
>
> The <ref-ish>@{<something>} is used currently for information that is
> outside the DAG, like @{<date>}, @{<n>}, @{-<n>} uses information from
> reflog, and @{upstream} and @{push} uses information from the config.
>
> On the other hand ^{<type>}, ^{/<search text>}, and the future
> ^{<hashalgo>} all use DAG-only information.

I wasn't aware of ^{<hashalgo>}. hash-function-transition.txt is a bit
light on the exact behavior, but maybe we can just define it like
<hash>@{hash} in this thread (then we don't even need to introduce
@{hash})?

That is, if <hash>^{<hashalgo>} fails to find a matching object, the
get_oid() result is "not found", there will be no further attempt to
interpret the given revision in a different way (e.g. try to see if
the same ref exists...). It also means <hash>^{<hashalgo>} will remain
supported even after the sha-512 transition period.

@{describe} might go  the same way as @{hash} (that is, becoming
^{describe}). I think it's just a slightly different way to write
hashes.

> Though one could argue that refs information _is_ outside the DAG...

Refs info is outside DAG. But that's mostly for <ref>@{literal} and it
allows something like <ref>@{literal}@{upstream}. But hash (or object
name) is already used inside DAG (to link between commits, trees and
blobs). Though one might still argue that's only true for full hash,
not short ones.
--=20
Duy
