Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 16E6A20248
	for <e@80x24.org>; Sat,  9 Mar 2019 18:52:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbfCISwO (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Mar 2019 13:52:14 -0500
Received: from mail-vk1-f193.google.com ([209.85.221.193]:34644 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726351AbfCISwO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Mar 2019 13:52:14 -0500
Received: by mail-vk1-f193.google.com with SMTP id k64so184701vke.1
        for <git@vger.kernel.org>; Sat, 09 Mar 2019 10:52:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/ie3xIMC2VepAJr1RCtozyiO78ktqbIu599V/8lU32A=;
        b=FhiWy95ZDwHW8IjLC6hHGBdEmg6kFfGeHTaD62d4+nNw9cQ+wE6/RvLMjauVVY8VB/
         g7EgbGXbQ30fqPpSws02e63jezbNsoflEfWA7ANXMi4HSoW10yCw5r/0YBngGqwoUlWt
         mM+5EWoMfNcdjNIbegnMQKgMpNtpCeXKnuAuce44c2yOOUrtbN0z1yfm341eMGCS3l7s
         ZS3/DtfsapmGAo0IF7Xacjb67huBTPowtwSQEPEV6pYHvBUiB7rhejG1GBy/kZl5EocI
         78KO1EtJc3Q+mutSPhRcF3kNHp2eBwZnrqHtAsqY+QMcx7msvb+Br0Yr5hzDGnB5BWi1
         Q6fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/ie3xIMC2VepAJr1RCtozyiO78ktqbIu599V/8lU32A=;
        b=LarFsoCT6x1sx3l+mGE48C1OyGpwT6OY2lJtoZiKnu2KeiDiloxCyo3ej9qd3HPYJk
         Y/2C6qr17/oEmkh3LqKWkPfSYOYpQB8JJHG3iwRwi845QUNkDGRbNrFB5oRe60dPPCzO
         yp0QSvTEwl8loO4gfxBQL0pxc+ufYn/ssKJfAy23jXYm1ai9qAOcsoduZcyTTLCNFGS9
         BoTBaEw2kVjL/bX9P7UGk6oF5TG1wBVpCxhiP+5UdFyOxOuFpDCdwpFTJX/ABiJcHEq3
         oNAj+sOUWBs6I+8aaCNI/QPP6L7CYQfqoxyWhzUR9J5bSe0R6eJHSwDGzilrdcSqwDrQ
         CA1w==
X-Gm-Message-State: APjAAAVEnor4165HY5DAMnV0rjOOtK1eL5f2FHg3SFRX1zmK8zKuBIed
        0sYVMOoPSceJ2mdytfaYzGR5cYHgQtUc5TNKQ6Y=
X-Google-Smtp-Source: APXvYqzYd99JOPaLBl+a6ZWhaZWtQqtb43rvfrBExxbO+PnZZASxAi1CiycDyBvNvZk+gRylE3vjGo9Kd31Du1CtKBE=
X-Received: by 2002:a1f:a14f:: with SMTP id k76mr12393814vke.15.1552157533247;
 Sat, 09 Mar 2019 10:52:13 -0800 (PST)
MIME-Version: 1.0
References: <20190308101655.9767-1-pclouds@gmail.com> <20190308101655.9767-7-pclouds@gmail.com>
In-Reply-To: <20190308101655.9767-7-pclouds@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 9 Mar 2019 10:52:02 -0800
Message-ID: <CABPp-BFv-a3Uw1g+ebLqTHRbCedsv1akZxxJ7QfeyXtXBdQuOw@mail.gmail.com>
Subject: Re: [PATCH v1 06/11] restore: add --worktree and --index
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 8, 2019 at 2:17 AM Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <p=
clouds@gmail.com> wrote:
>
> 'git checkout <tree-ish> <pathspec>' updates both index and
> worktree. But updating the index when you want to restore worktree
> files is non-intuitive. The index contains the data ready for the next
> commit, and there's no indication that the user will want to commit
> the restored versions.
>
> 'git restore' therefore by default only touches worktree. The user has
> the option to update either the index with
>
>     git restore --source=3D<tree> --index <path>  (1)
>
> or update both with
>
>     git restore --source=3D<tree> --index --worktree <path> (2)
>
> PS. Orignally I wanted to make worktree update default and form (1)
> would add index update while also updating the worktree, and the user
> would need to do "--index --no-worktree" to update index only. But it
> looks really confusing that "--index" option alone updates both. So
> now form (2) is used for both, which reads much more obvious.
>
> PPS. Yes form (1) overlaps with "git reset <rev> <path>". I don't know
> if we can ever turn "git reset" back to "_always_ reset HEAD and
> optionally do something else".

I'm really happy with how this series is going generally.  :-)

> +       if (!opts->checkout_worktree && !opts->checkout_index)
> +               die(_("neither '%s' or '%s' is specified"),
> +                   "--index", "--worktree");

Is this die() or BUG()?  I thought --worktree was the default.

> +               else
> +                       die(_("'%s' with only '%s' is not currently suppo=
rted"),
> +                           "--patch", "--worktree");

:-(

> +               /*
> +                * NEEDSWORK: if --worktree is not specified, we
> +                * should save stat info of checked out files in the
> +                * index to avoid the next (potentially costly)
> +                * refresh. But it's a bit tricker to do...
> +                */
> +               rollback_lock_file(&lock_file);

A total tangent: I see both FIXME and NEEDSWORK in the codebase.  Are
there other 'keywords' of this type that we use?  Is there a
preference for how they are used?
