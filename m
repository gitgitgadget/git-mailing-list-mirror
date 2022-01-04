Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC79CC433F5
	for <git@archiver.kernel.org>; Tue,  4 Jan 2022 19:38:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbiADTi6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Jan 2022 14:38:58 -0500
Received: from mail-pj1-f48.google.com ([209.85.216.48]:40959 "EHLO
        mail-pj1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbiADTi5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jan 2022 14:38:57 -0500
Received: by mail-pj1-f48.google.com with SMTP id o63-20020a17090a0a4500b001b1c2db8145so621124pjo.5
        for <git@vger.kernel.org>; Tue, 04 Jan 2022 11:38:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=93d+xBV0VjBWUknPx0oYSjgfSUTcmExyEFiqNKMfpxg=;
        b=la+sSvpIX+GJVdjWz+kNXf8pFUTrIam8Q+7iISUCzPKgKHDq2hs1krgnt+WwcjAn+V
         0WVfpcZRlhcJbX2H16LmgiYkC5Rkge6/ebcjnoRqrTvE+dUmuLvQuGTSNkNrnADPbK4I
         6Z2txzr9l7BBZyAsQApWtol6+KumDZHKIq494dzS0UF3ZDtkLrxXBOgFv1GJlmwFWtOR
         RJfww0GbGGgWmwOmjQe8Vlpzl3doVh1jq4ACI/aWoimAfi6KsYiCM239rA9PEIRuIKIh
         MnTaE4dYpZmyNmyDxaQ8fme1A2O2IaOZbm1mhuJQmYhzrUZ0mf2xkA8sWXze5+rYY6Bz
         ZQdQ==
X-Gm-Message-State: AOAM532IRrVmpEU9lrPfElfo+G5/ve2y/K707N5dC9O9OwAPA3dNSpZn
        ogNmpCxpaVZ3EF0jl9G5GGCZime1vAYNuyBXIE6hyoiRV5mtPQ==
X-Google-Smtp-Source: ABdhPJxSIcIU7j6aWzcRauQzhpTeLLCXOCW83nFRn9aTWO8Abr1hPXB6yZgUxvQ+pTieZU8LX/4O5zis88ABnLWgrL0=
X-Received: by 2002:a17:902:b688:b0:149:a1d6:c731 with SMTP id
 c8-20020a170902b68800b00149a1d6c731mr25073005pls.145.1641325137194; Tue, 04
 Jan 2022 11:38:57 -0800 (PST)
MIME-Version: 1.0
References: <pull.1171.v2.git.git.1640759021.gitgitgadget@gmail.com>
 <pull.1171.v3.git.git.1641221261.gitgitgadget@gmail.com> <55ec2a5fa3e748b7e5f9ef871214563ba2b28adf.1641221261.git.gitgitgadget@gmail.com>
 <77e18a78-ddfe-0337-deaf-bb9dfb63a495@iee.email>
In-Reply-To: <77e18a78-ddfe-0337-deaf-bb9dfb63a495@iee.email>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 4 Jan 2022 14:38:46 -0500
Message-ID: <CAPig+cRUQA_G_sLi4Q_F4ZhHkhEFKT-an4LuOpbTJ9bDuZLjog@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] name-rev: deprecate --stdin in favor of --annotate-text
To:     Philip Oakley <philipoakley@iee.email>
Cc:     John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        John Cai <johncai86@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 4, 2022 at 10:32 AM Philip Oakley <philipoakley@iee.email> wrote:
> On 03/01/2022 14:47, John Cai via GitGitGadget wrote:
> > From: John Cai <johncai86@gmail.com>
> >  --stdin::
> > +     This option is deprecated in favor of 'git name-rev --annotate-stdin'.
> > +     They are functionally equivalent.
> > +
> > +--annotate-stdin::
> >       Transform stdin by substituting all the 40-character SHA-1
> >       hexes (say $hex) with "$hex ($rev_name)".  When used with
> >       --name-only, substitute with "$rev_name", omitting $hex
> > -     altogether.  Intended for the scripter's use.
> > +     altogether.
>
> Is there a preferred order for the old/new variant documentation?
>
> It struck me that the docs should offer the new (now 'correct') variant
> first.
>
> I didn't see anything about deprecation in the CodingGuidlines or
> SubmittingPatches (only a quick search though)

In other cases, we've demoted the deprecated option to a tiny blurb at
the end of the description of the option which replaces it so that the
deprecated option is no longer given a place of prominence but can
still be found with a search in case someone runs across it somewhere
and wants to learn about it.

    --annotate-stdin::
        Transform stdin by substituting all the 40-character SHA-1
        hexes (say $hex) with "$hex ($rev_name)".  When used with
        --name-only, substitute with "$rev_name", omitting $hex
        altogether. --stdin is a deprecated synonym.
