Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB8E81F404
	for <e@80x24.org>; Sat, 14 Apr 2018 16:00:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751141AbeDNQAC (ORCPT <rfc822;e@80x24.org>);
        Sat, 14 Apr 2018 12:00:02 -0400
Received: from mail-ot0-f196.google.com ([74.125.82.196]:39880 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750996AbeDNQAB (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Apr 2018 12:00:01 -0400
Received: by mail-ot0-f196.google.com with SMTP id a14-v6so13035810otf.6
        for <git@vger.kernel.org>; Sat, 14 Apr 2018 09:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=j4ORgzimtao+706TTd/4P+f6OXtQWtbCyl2jlIb9OkE=;
        b=HQ1t5FJxLYgnJaTRYYMKHH393KAxVAL99DuFVhf2BXFUHA02f+RrkRDWjasP3uXDrP
         2G85yObEF4aIh7NXVBFqyDzUL58oUYIv6KyXcH2npVXDMgqeUWKcTnnQueqUVjt8q5fz
         SV7i2VnW/r8eViVxg3lbZ+mD9DWWfcZ6s2KxBzuUb24W0SD4qzJyea9wQbTxJu5b3ZaQ
         m6nCbfiA18yyzoR00r8lqyNouG3ec9wZ5Knu1d5zMJLAXNYFcRpQlj9l+j0HXPwVC91a
         eyhHvhuD0bhQ4artxBfQdhsLZpLWSo69EkzN/Fd5BfMMIWxP5Jw9T3LEAjLsU6gTpVc1
         O1xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=j4ORgzimtao+706TTd/4P+f6OXtQWtbCyl2jlIb9OkE=;
        b=XBn4sjKM7sLDmUNKwHdEJDmCN3BWtY/Kcz9ylUm+mqMwGTgXj6Mb/yqcakV6F9mE12
         Fzu8VBsYAfmCcnel2dvFRHpbWYOrFbEDAr11TezPZ3zNYKu7/8Ug0OqxEndL/TlTVodw
         MjqbJpYnki1FR/sC4v+nqnhfg3mXxKf3Caz9ZzL86bZocvJsIDhSVzeaTZutML2BBe8Q
         6p85edli20L4iuwusTGuiZdWWhaLn2cATheZCYHH7/P6yNK/cUYZxgzH/2hIM6cxD5uX
         oiJfWQDCERuABbi/28C0GfPAY0DtSG3+oTt/Ovx1DQB/d0VBxRvS6ihwlgWBQjTNBE9Y
         skeA==
X-Gm-Message-State: ALQs6tAaJF9zFTepLwfTf4PBBsLjSh0GWEnVgR+sbKOZZIyVmIZSyfb6
        QpPRxGO8rurc2B7BD6VqlMTkoLCuxgc/S/05sVo=
X-Google-Smtp-Source: AIpwx48DuZ1ANzAeU5yMtOl/m9rubCg9rtYI4zZORilcYoAFT7qMbQPAox/YZ/X8RkoNrOozvS/aWXHtXVotsVj6t28=
X-Received: by 2002:a9d:24c7:: with SMTP id z65-v6mr6731209ota.152.1523721601033;
 Sat, 14 Apr 2018 09:00:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.198.152 with HTTP; Sat, 14 Apr 2018 08:59:30 -0700 (PDT)
In-Reply-To: <20180410210408.13788-1-benpeart@microsoft.com>
References: <20180410210408.13788-1-benpeart@microsoft.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 14 Apr 2018 17:59:30 +0200
Message-ID: <CACsJy8B+fTfUiGA-cFE5QEipa_4pSfC4_GhUSJvCKL82G21xWw@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] fsexcludes: Add programmatic way to exclude files
To:     Ben Peart <Ben.Peart@microsoft.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "alexmv@dropbox.com" <alexmv@dropbox.com>,
        "blees@dcon.de" <blees@dcon.de>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "bmwill@google.com" <bmwill@google.com>,
        "avarab@gmail.com" <avarab@gmail.com>,
        "johannes.schindelin@gmx.de" <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 10, 2018 at 11:04 PM, Ben Peart <Ben.Peart@microsoft.com> wrote=
:
> In git repos with large working directories an external file system monit=
or
> (like fsmonitor or gvfs) can track what files in the working directory ha=
ve been
> modified.  This information can be used to speed up git operations that s=
cale
> based on the size of the working directory so that they become O(# of mod=
ified
> files) vs O(# of files in the working directory).
>
> The fsmonitor patch series added logic to limit what files git had to sta=
t() to
> the set of modified files provided by the fsmonitor hook proc.  It also u=
sed the
> untracked cache (if enabled) to limit the files/folders git had to scan l=
ooking
> for new/untracked files.  GVFS is another external file system model that=
 also
> speeds up git working directory based operations that has been using a di=
fferent
> mechanism (programmatically generating an excludes file) to enable git to=
 be
> O(# of modified files).
>
> This patch series will introduce a new way to limit git=EF=BF=BDs travers=
al of the
> working directory that does not require the untracked cache (fsmonitor) o=
r using
> the excludes feature (GVFS).  It does this by enhancing the existing excl=
udes
> logic in dir.c to support a new =EF=BF=BDFile System Excludes=EF=BF=BD or=
 fsexcludes API that is
> better tuned to these programmatic applications.

I have not had a chance to really look at the patches yet but I think
these three paragraphs should somehow be included in the commit
description of 1/2 (or spread out between 1/2 and 2/2). 1/2
description for example briefly talks about how to use the new thing,
but not really tell what it's for, why you need to add it.
--=20
Duy
