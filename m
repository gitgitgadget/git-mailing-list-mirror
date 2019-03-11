Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 208DC20248
	for <e@80x24.org>; Mon, 11 Mar 2019 15:40:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727471AbfCKPkZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Mar 2019 11:40:25 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:50553 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727050AbfCKPkY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Mar 2019 11:40:24 -0400
Received: by mail-it1-f195.google.com with SMTP id m137so7980833ita.0
        for <git@vger.kernel.org>; Mon, 11 Mar 2019 08:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Ve2hgFIzQFR985OGH4OTNlwevFSK/opSh8+oq71P8Cw=;
        b=HBa9VebJbebmsoKL6CP7VhjIm6Pjvy3ZKOIz3rUzpy6Bg2PHlZKHrOvTUrHt7KGVFZ
         vgbeDm69q6gsDNEbF7EWiyyBPHw3RbbLyXo7TDGGxPp9ua3jwoEJlyfH1yVPZ992nl9e
         iwL+Kkb9tyEI4B4kwVFeLyNAdssybMA6P4R24pH+tjDbry0NLNDNTB2Q++9mw7hy1jfW
         N4aagAm7OG6He4gqhUrqudadg+9pq91Xm3g0bRgh6TzuzoejKdCreiMI7WJzal9m9Gg2
         ABO56WrvlkV93KcQqHemehnSI0566eKyhjU6dN4qTLicFDGZatPkMNLZ0+EiGxBVkmIj
         vong==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Ve2hgFIzQFR985OGH4OTNlwevFSK/opSh8+oq71P8Cw=;
        b=ZaLUGdPSMZp+clcr74X1UPf78Mg4Mn+hb5pT7hC0UYHyuD8Eb8b6veBrjKiT4+zTXD
         aTJldjVTrunuFAfoJO2E3MatZZHOvr78cG5Iph3eGnBpnV5F1iHPFpkFkJPzVgJpyO3K
         itDD2NgvKjdHX7IeEE832f58VLlLZyIPFPODV7HjUOrJKxW7m5C7KHQ/xr5Fx9m8A143
         4v7qiQQY7iW6WQMP8ASAcLGHfvSNNnmuTpQbrDpfqP3ktBAc5//jVsWsmWIafjsPfgF6
         nT/PWmOFQf3vTBW7jEZjrmdrMAc30rIwZW+mz1n15pyps6heln+ZRK+V+KVvKbbkePyS
         HqcQ==
X-Gm-Message-State: APjAAAUao2AVpAjXJZ+mgiWIdIwBTmUQtPYwvi3vJ7EkeJzu0oxl/8ad
        lMbSUslZ4upIeoL5S2ctpapK25kg71LATvs+L8E=
X-Google-Smtp-Source: APXvYqxKRRPufcwyPlaPBwGYOwZmZq8/3cs+yS8aPm1zHxbubw/FLsCbVXC8eqLTvQcf39OpWQjCgDFF8MudolL48Ng=
X-Received: by 2002:a24:ccc5:: with SMTP id x188mr180754itf.123.1552318823861;
 Mon, 11 Mar 2019 08:40:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190308101655.9767-1-pclouds@gmail.com> <20190308101655.9767-11-pclouds@gmail.com>
 <CABPp-BGbqYUMEK0V_m0i7dpFb38Mm3sS-h0Ut-GSdvsKEZzRQg@mail.gmail.com> <CACsJy8DeGQ=GRnRByNQ18Npe5JEcRXBf2oK3Xg6uv44OCg_EBA@mail.gmail.com>
In-Reply-To: <CACsJy8DeGQ=GRnRByNQ18Npe5JEcRXBf2oK3Xg6uv44OCg_EBA@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 11 Mar 2019 22:39:57 +0700
Message-ID: <CACsJy8ASZ2jcrk7jf+5p0yCk9bLy-8SJmQyEjG9TSULhd+GhaQ@mail.gmail.com>
Subject: Re: [PATCH v1 10/11] completion: support restore
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 11, 2019 at 10:22 PM Duy Nguyen <pclouds@gmail.com> wrote:
>
> On Sun, Mar 10, 2019 at 2:17 AM Elijah Newren <newren@gmail.com> wrote:
> >
> > On Fri, Mar 8, 2019 at 2:17 AM Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Du=
y <pclouds@gmail.com> wrote:
> > >
> > > Completion for restore is straightforward. We could still do better
> > > though by give the list of just tracked files instead of all present
> > > ones. But let's leave it for later.
> >
> > s/give/giving/
> >
> > I'm slightly worried that due to using --no-overlay mode by default in
> > restore, having tab-completion include untracked files increases the
> > risk of accidentally nuking the wrong file.  restore is a destructive
> > command anyway and should thus be used with care, so perhaps this
> > isn't a big deal, but I thought I'd mention it.
>
> This makes me think about my "git restore :/" example, which does not
> remove untracked files because its source is the index. But isn't it
> inconsistent that we only remove untracked files with --source and
> keep them without? Will that just confuse people more? Or did I just
> forget to implement no-overlay mode for the index too?

Nope you confused me. non-overlay mode never touches untracked files
and so neither does git-restore.

It does make the description of git-restore about "remove if paths do
not exist" incorrect. But frankly I find it hard to explain
non-overlay mode with the index being the remove filter. In
git-checkout, where we update both index and worktree, this may make
sense to use the index as the remove filter. But worktree works on the
worktree only by default. I'll need to sleep on this.
--=20
Duy
