Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0926C77B6E
	for <git@archiver.kernel.org>; Fri,  7 Apr 2023 06:08:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233137AbjDGGIF (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Apr 2023 02:08:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231508AbjDGGID (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Apr 2023 02:08:03 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FED086B8
        for <git@vger.kernel.org>; Thu,  6 Apr 2023 23:08:02 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id j11so53332315lfg.13
        for <git@vger.kernel.org>; Thu, 06 Apr 2023 23:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680847680; x=1683439680;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+I3ipYfdveAhZ3Tkv1ry9c0gjBj0dwFueu8wSPUl8gw=;
        b=VE9xzxntUgaDIypbyfEPiAhu+h4paYspl8p9x0gbL91hg/1CD3L5MuAnsgci1xB2fc
         8xXhpjSUQEPamqqjHht4FprfSrMVOxnNeY3zBEXQG5aFCLryyc/OeI3DEr7V1dFWSZgR
         ul6nwGkNX+JQSxsbFBM4+Q+uMIqQzHHS/ZCakLJKg2Fqrs3ttA9gMwL8sKo0B/Eelfrt
         4zjRETsl3S40UnfjWwXJat+sT3hueFXDEvc7/COAUO5m8499nQHgNSZuw1S88CcHZ8kF
         NnTNW/2Cz+qh6QFGw9cC9btgH/0esZ30z2k5rvKiUuruVYLWOPEhDN/yp8layE7Ra+vE
         o/IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680847680; x=1683439680;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+I3ipYfdveAhZ3Tkv1ry9c0gjBj0dwFueu8wSPUl8gw=;
        b=1cOJO47gTlV1RAmsvGvTehx5LYpDcWBjW4xtb8vp/AptI6JCFIKq+UHM2dJ8Hp0c5i
         D8kPIJGy4Wnmc895CjOD0leLaaNsz4XCUG6/OePUEy6HMILtjZJjOd29L+1Pmj+0zcUt
         IfKHaPzxxwWNV3Nu1eF1IQbbjyAHdExs7jZrSSCzmTbHKnp6u+VtGmVls01IzZ12S2Nz
         QyQS/HdEdlRsrYRsk088SP34ATkWTWfEaP9xpCmyaPOuvZXKj5KaUFPJMffRBACikkSf
         XbH/sA526ktCp57q6ngQiQQ/sYhyusKNZzyMU0HswNkAeiu3DXmiQVmDjhtr4UM3Ev75
         0Q0Q==
X-Gm-Message-State: AAQBX9dWZvUIe0ku13DhxEFpK5E0zKZKd5upS0Gs5urJ/konpZPmVul1
        lC2VeWAS96h2cZKhTtKeceiMhvV6B4H3ViLw97k=
X-Google-Smtp-Source: AKy350bGFrO2hssZHIPdZHwf8f18WspfEIN96PPoLkGGnNQVxOhTCPihC+6O66xDwZH+7Gwj/ZSk+2n95y4hN17vrGo=
X-Received: by 2002:ac2:4569:0:b0:4e9:22ff:948d with SMTP id
 k9-20020ac24569000000b004e922ff948dmr390595lfm.7.1680847680409; Thu, 06 Apr
 2023 23:08:00 -0700 (PDT)
MIME-Version: 1.0
References: <47afc6a6c8757032d9d69a2f9aaaeb427c5a003f.1680571352.git.gitgitgadget@gmail.com>
 <20230405172840.730076-1-calvinwan@google.com>
In-Reply-To: <20230405172840.730076-1-calvinwan@google.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 6 Apr 2023 23:07:48 -0700
Message-ID: <CABPp-BEurqhk32hC041kcXiVNpVXx3YzJMyzDh4E=ctBLemz8A@mail.gmail.com>
Subject: Re: [PATCH v2 21/24] strbuf: move forward declarations to beginning
 of file
To:     Calvin Wan <calvinwan@google.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 5, 2023 at 10:28=E2=80=AFAM Calvin Wan <calvinwan@google.com> w=
rote:
>
>  Instead of moving these declarations, can we move
>  strbuf_repo_add_unique_abbrev() and strbuf_add_unique_abbrev() to
>  object-name.[ch]? These functions are related to both strbuf and
>  object-name, but object-name should be a higher level API than strbuf
>  so it seems more natural to belong in there.

I like that suggestion; that would be better overall.  However, should
it be in this (already lengthy) series?  I'm guessing you likely
already have such a change in the series you're including, and if I
were to add it to mine (and risk doing it slightly differently), that
might increase the conflicts you need to deal with.  Would it perhaps
be easier to keep this small change for this series, or even drop this
particular patch, and then let you address this improved direction
with your strbuf work?

> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
> > From: Elijah Newren <newren@gmail.com>
> >
> > Signed-off-by: Elijah Newren <newren@gmail.com>
> > ---
> >  strbuf.h | 9 ++-------
> >  1 file changed, 2 insertions(+), 7 deletions(-)
> >
> > diff --git a/strbuf.h b/strbuf.h
> > index 3dfeadb44c2..547696fb233 100644
> > --- a/strbuf.h
> > +++ b/strbuf.h
> > @@ -1,6 +1,8 @@
> >  #ifndef STRBUF_H
> >  #define STRBUF_H
> >
> > +struct object_id;
> > +struct repository;
> >  struct string_list;
> >
> >  /**
> > @@ -72,12 +74,6 @@ struct strbuf {
> >  extern char strbuf_slopbuf[];
> >  #define STRBUF_INIT  { .buf =3D strbuf_slopbuf }
> >
> > -/*
> > - * Predeclare this here, since cache.h includes this file before it de=
fines the
> > - * struct.
> > - */
> > -struct object_id;
> > -
> >  /**
> >   * Life Cycle Functions
> >   * --------------------
> > @@ -634,7 +630,6 @@ void strbuf_list_free(struct strbuf **list);
> >   * Add the abbreviation, as generated by repo_find_unique_abbrev(), of=
 `sha1` to
> >   * the strbuf `sb`.
> >   */
> > -struct repository;
> >  void strbuf_repo_add_unique_abbrev(struct strbuf *sb, struct repositor=
y *repo,
> >                                  const struct object_id *oid, int abbre=
v_len);
> >  void strbuf_add_unique_abbrev(struct strbuf *sb, const struct object_i=
d *oid,
> > --
> > gitgitgadget
