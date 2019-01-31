Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C5101F453
	for <e@80x24.org>; Thu, 31 Jan 2019 11:04:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbfAaLEv (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 Jan 2019 06:04:51 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:35427 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726500AbfAaLEu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Jan 2019 06:04:50 -0500
Received: by mail-io1-f66.google.com with SMTP id f4so2311654ion.2
        for <git@vger.kernel.org>; Thu, 31 Jan 2019 03:04:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Dn+ZscKrr7dxwxnkV7rr9UeTSN0IZRj08l9waNkuyNQ=;
        b=sITRHRZy+kRDFi97VFPChfdZel6qGdEW+Gl+skDbewuZdseSlrqsAEgOESA2ZW7EpR
         EP61XthVAQFznpr6e8Iux5Prc9/tzyJ4Wlq6CB18v02WFNsosiSnY0MoIJhcZ83T9RTz
         pvfMiavRmmiIjIuDqM5wrY7c5P4k2XUYyZoC1vnYQ/yNsJsuiu9cNQRaaXyopHRNiy4i
         JhUmPC9ckB/6TxpVz/Z8QU3Y4qvcFfS9boZ4n9SD4Kt4Y9EdFELLfeHXgPq3zr+PwDzU
         t6fyF1pTP5PJXKkDTh8I2f/HSMUJvdJL9/pVkNMPlLnw6FfE6wyrxyeNP+nBAXu4PW0w
         gL5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Dn+ZscKrr7dxwxnkV7rr9UeTSN0IZRj08l9waNkuyNQ=;
        b=VUrBxX+OpdHF0Yydavi+L9G/YSIW/1mhnc2wIWPGu7uv/OFn6oE3ZjIx7BQQzcNRga
         KvuMhFvnVsAxAnNAnFHIeYcAwMyHFX9rH97mBWpt5vxkqyIM2hGNvFsulPGKaB2+Yo6O
         h00eAuZX4okjFD/ORc7Fg3Ztj8szqCRqNGhiV2ESG/40SkUcbE+V7c1KiCzIM6O0P6is
         DOeuck8xD0SwJV5A47qF/xXIGAO67BT/BmYxmb6qUF/GE0T+ewAVt0TmEyBJEgl6v3HG
         ubcvPX6wjVY1ijI/se06fbN6EF1Zzq8IjQl6KHFE/curK3bFinUUuf02vrHGb25zdmYq
         7CNw==
X-Gm-Message-State: AHQUAuaj8hGXi8AGCR7aE0o39a3IwM5HkoikhbPpjDKPNX3oHrO2kQ9z
        WDmNvHf6HMO0EZH8H/qOwyPkg+VYRCtWf5H2hhY6dg==
X-Google-Smtp-Source: AHgI3IZJJxWmMNHVJVxcvtfkDBC421p3GbUhWPJYv72rAMYrfUrWljkLHIrLHthNJJ+AVBGCDX1zdCvbIzH8vCMjkBE=
X-Received: by 2002:a5d:9812:: with SMTP id a18mr16453250iol.236.1548932689747;
 Thu, 31 Jan 2019 03:04:49 -0800 (PST)
MIME-Version: 1.0
References: <CACsJy8C2fx-+NxS+ahmmHDgLrwtyiCV6WEEfpmYwfcPM3kYVvA@mail.gmail.com>
 <20190131092112.6197-1-pclouds@gmail.com> <CAPig+cSzDSeJ7HypXTjMpn26LYygH_UFYwcPzthGLoEQYDNLcQ@mail.gmail.com>
In-Reply-To: <CAPig+cSzDSeJ7HypXTjMpn26LYygH_UFYwcPzthGLoEQYDNLcQ@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 31 Jan 2019 18:04:23 +0700
Message-ID: <CACsJy8D_3-SrxEAjrndieXhxu=mt6VUpDGTfVu2nrDW6USsgPw@mail.gmail.com>
Subject: Re: [PATCH] git-commit.txt: better description what it does
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 31, 2019 at 5:49 PM Eric Sunshine <sunshine@sunshineco.com> wro=
te:
>
> On Thu, Jan 31, 2019 at 4:21 AM Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy=
 <pclouds@gmail.com> wrote:
> > The description of git-commit jumps right into the commit content, whic=
h
> > is important, but it fails to mention how the commit is "added" to the
> > repository. Update the first paragraph saying a bit more about branch
> > update to fill this gap.
> >
> > While at there, add a couple linkgit references when the command is
> > first mentioned.
> >
> > Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
.com>
> > ---
> > diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.tx=
t
> > @@ -17,16 +17,19 @@ SYNOPSIS
> >  DESCRIPTION
> >  -----------
> > +Creates a new commit containing the current contents of the index with
> > +a log message from the user describing the changes. The commit is the
> > +direct child of the tip of the current branch. The branch is updated
> > +to point to the new commit (unless no branch is associated with the
> > +working tree, see "NOTES" section).
>
> Okay. The information about the branch being updated makes sense.
>
> > +NOTES
> > +-----
> > +If a branch is associated with the working tree, 'HEAD' points to this
> > +branch. When a new commit is created, the branch is updated to point
> > +to the new commit. As a result, resolving 'HEAD' still gives the new
> > +commit.
>
> I'm not sure I understand the purpose of the final sentence about HEAD
> "still resolving" when you were, just before that, talking about the
> branch.
>
> > +If no branch is associated with the working tree (i.e. "detached HEAD"
> > +as described in linkgit:git-checkout[1]), 'HEAD' records the object
> > +name of the previous commit directly. When a new commit is created, it
> > +will be updated to point to the new commit.
>
> I'm having a hard time figuring out what these two paragraphs together
> want to say. I _think_ they want to say that HEAD is updated
> automatically to point at the latest commit, and that if a branch
> points at HEAD, then the branch is is updated along with HEAD,
> otherwise if no branch, then it's a "detached HEAD".

I felt some more explanation was needed when I mentioned about
updating current branch in the description, but then what happens when
there's no branch (aka detached HEAD)? There is still some updates. If
you consider HEAD a branch, then it's ok, but otherwise something is
missing. But perhaps this is the kind of details that could be left
out?
--=20
Duy
