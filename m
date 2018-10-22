Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E91E1F453
	for <e@80x24.org>; Mon, 22 Oct 2018 14:34:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728268AbeJVWxc (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Oct 2018 18:53:32 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:35902 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727146AbeJVWxc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Oct 2018 18:53:32 -0400
Received: by mail-it1-f194.google.com with SMTP id c85-v6so12752821itd.1
        for <git@vger.kernel.org>; Mon, 22 Oct 2018 07:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3tVO1gC4X4Eha6H7fZqkSEQvQx/TKl+eV2kzbtabH70=;
        b=WGklUk2ddeUzHslK2RT0uowEOw2uSLWeCmuqMB2h3ABqMIgixs10iL4lff/rbBJ8bL
         tCpLVzUXtTpGeps/ShQpkgQqRSA9Ms7BJr/ZLsgNOeZQJ2vTHFgrt2Do1toEgvoseeT6
         60/K+lFVkvdd9sG8cMq8cmqZot1VHoqbvst1KgKpRnKhciMqcdK4zgUS1aSO8jXDfLCE
         gCYq0e0DS+1CTCriLgpDFJeFMC7N8M9QMOkBoipQKtiy3VWGx6cF57GXkOKm9+5NpuKy
         ALz11/MhfQy3Ge1OdeKdcfuq4eis0lGApgchMf2jgkWcVYmGEAz8u37shQrsR6u+Fr/r
         k5ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3tVO1gC4X4Eha6H7fZqkSEQvQx/TKl+eV2kzbtabH70=;
        b=Z5Rt3Yw5IPld4VbW1uvvN5Z8A1Uwuns+OUf2phYG6g0QCmt0YRV9yTQNxs+KK/HikD
         2IxyzAUWq4S1VpQNZ/uS/vxtZX2b/WTiizIDT5kmygDLhLxKSmULgX5LgBIv780zK5v1
         vbz2e27qslRuGagqnmwhTuplvHPcNRAqRa1CG6/NnAmAS6KHhJi4YVoCyp1OVtqWatDr
         xe4qHqqWRnhiddPXExrYEeTqwB/jowXaQsBjNXvaVRscqji3JLiV1m3KKZzLhRozey96
         xQEbfLeu/6z5reUuc22kP9qKmygPVF4lYJXvtIOk5I0/rVMwt3o1S+MBcVjeuAS20lcK
         nNVg==
X-Gm-Message-State: ABuFfohQ+OUsO5UwcJa5DtkMAlKrJDEpptZujNWDyYm/zCxS7/dtQZ6Y
        6UAnjJXwVW27gWpkPkNfd/GRLjSJl/8V+OHmNr6osA==
X-Google-Smtp-Source: ACcGV636jCJKGiZ433c6n59AReKb0qR5rQ95iraF5mDS4m8ZOntknaUJ1eArg1XTCiKdK2u0MURILievStqUHmrtTR8=
X-Received: by 2002:a24:7804:: with SMTP id p4-v6mr9862604itc.123.1540218883263;
 Mon, 22 Oct 2018 07:34:43 -0700 (PDT)
MIME-Version: 1.0
References: <20181021083731.8009-1-pclouds@gmail.com> <xmqqr2giwsep.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqr2giwsep.fsf@gitster-ct.c.googlers.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 22 Oct 2018 16:34:16 +0200
Message-ID: <CACsJy8B-NtKb1sk_CxwB-bffMsy+nDGL2-MpkScBF5vvGHFBjA@mail.gmail.com>
Subject: Re: [PATCH] completion: fix __gitcomp_builtin no longer consider
 extra options
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 22, 2018 at 5:51 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:
>
> > __gitcomp_builtin() has the main completion list provided by
> >
> >     git xxx --git-completion-helper
> >
> > but the caller can also add extra options that is not provided by
> > --git-completion-helper. The only call site that does this is "git
> > difftool" completion.
> >
> > This support is broken by b221b5ab9b (completion: collapse extra
> > --no-.. options - 2018-06-06), which adds a special value "--" to mark
> > that the rest of the options can be hidden by default. The commit
> > forgets the fact that extra options are appended after
> > "$(git xxx --git-completion-helper)", i.e. after this "--", and will
> > be incorrectly hidden as well.
> >
> > Prepend the extra options before "$(git xxx --git-completion-helper)"
> > to avoid this.
>
> Thanks for a clear analysis.  How did you find it?  Got annoyed that
> completion of difftool got broken, or discovered while trying to
> apply the same trick as difftool completion uses to another one and
> seeing that the technique does not work?

I was fixing format-patch completion and was surprised it did not work
as expected. Never really used difftool myself :P I only found out
about it when I asked myself "why wasn't this breakage found earlier?"
--=20
Duy
