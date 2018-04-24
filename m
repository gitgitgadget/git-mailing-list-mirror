Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 75FE91F424
	for <e@80x24.org>; Tue, 24 Apr 2018 16:13:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752262AbeDXQNP (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Apr 2018 12:13:15 -0400
Received: from mail-ot0-f174.google.com ([74.125.82.174]:37129 "EHLO
        mail-ot0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751236AbeDXQNM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Apr 2018 12:13:12 -0400
Received: by mail-ot0-f174.google.com with SMTP id 77-v6so15802929otd.4
        for <git@vger.kernel.org>; Tue, 24 Apr 2018 09:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tG7ZaFixyFh2d6Ag6Jx3bjTOqhVJ+1HO/hkPBl9Rr+I=;
        b=hnWdA6a+gxPsKIYjtIlKKj7sYuG3/7xn4DSCYcJoMNFY+iz6e00j97qQffKPG/SO0r
         GO5lHE42W1WZWmY8bpWwNScr5icDV9g2Ayz1NGGoZ0oawpBMaD0v6dOIvsrFwSU3gZ1N
         hDBoRtHzJbUAycF9KgQTyYtyK//EWltFEGudYKCP53GCOyqzq6Kcikpn4Q9Qfq2rD94h
         vINIHpgz6GR5I8PiYcpGWa87FowpsMrPx8J3xIvI/rLErLrsNfPNukqszIuIIbJ2Le+N
         ZS+oV9YCMu6c5wQ/gyyL1SJJUBbmA1l24ifqT90L1ZVUv3X7+VQK2zJi4Wa/CzGbQDLj
         QLrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tG7ZaFixyFh2d6Ag6Jx3bjTOqhVJ+1HO/hkPBl9Rr+I=;
        b=A6mCz9tVqnMSRxFCVO1SFUE7HDBIvKNuq9UrHQ6akOMFWiqKwz1wesrGwg26nfSfRh
         EwO4b5E0R9QcoTnwKxOyF3rwU73n0pxDDESh0YnGxGG1vhPE0H/owsE948tk67BlrbSI
         OZGc6hXrtooeUJ/mRFtNzuZ9CPbZif4eqmzZaBt3vPb99xbf/XVlxff2TV+xfZcO9TjC
         rxjTSH1tI2I7ZoQhUqp2978IkvJ29cnWVEtm4wE6hq0D+4hMhiHVbNNPSsDJAIiqIe7E
         h6nE7omWqxpW9xEEec0iwWR2bmaXRBEk0piqywMSOmuA4J8OkR2IqdZrzo8zfmtyL2pB
         lFRw==
X-Gm-Message-State: ALQs6tAd3PHj1xn3HOHHkGH4rD6Smim2RMVDftn2Z1nM22rEo22Msp1F
        rAuWFpMtRajsZNfd/mP/3hOm294vaNxyyLc04SQ=
X-Google-Smtp-Source: AIpwx4/f2FhJRdpcp19ycSiaXljuoJd8X2rWhidx+ktU8m3G5OTJBQldSMlMb6vs6AcITppafZg8xZ6CTQA71UpDRJw=
X-Received: by 2002:a9d:4197:: with SMTP id p23-v6mr12721638ote.75.1524586392235;
 Tue, 24 Apr 2018 09:13:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.198.152 with HTTP; Tue, 24 Apr 2018 09:12:41 -0700 (PDT)
In-Reply-To: <CAM0VKjkd7OZspeTPumi4NVOM=7yXEq=nSjCNntkJ9d-8mPfR2w@mail.gmail.com>
References: <20180415164238.9107-1-pclouds@gmail.com> <20180421165414.30051-1-pclouds@gmail.com>
 <20180421165414.30051-5-pclouds@gmail.com> <CAM0VKjkd7OZspeTPumi4NVOM=7yXEq=nSjCNntkJ9d-8mPfR2w@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 24 Apr 2018 18:12:41 +0200
Message-ID: <CACsJy8B0bFzh5h+QE+NMgCHfoShfu8MvCzmxPPCVi-g_Ud3sUw@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] git.c: implement --list-cmds=porcelain
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 23, 2018 at 3:32 PM, SZEDER G=C3=A1bor <szeder.dev@gmail.com> w=
rote:
> But then I noticed that it's not an accurate description of the
> current situation, because there is a wide grey area between
> porcelains and plumbing, and the completion script doesn't "filter out
> plumbing commands", but rather filters out commands that can be
> considered too low-level to be useful for "general" usage.
> Consequently, after 'git <TAB>' we also list:
>
>   - some 'ancillaryinterrogators': blame, annotate, difftool, fsck,
>     help
>   - some 'ancillarymanipulators': config, mergetool, remote
>   - some 'foreignscminterface': p4, request-pull, svn, send-email
>   - even some plumbing: apply, name-rev (though 'name-rev' could be
>     omitted; we have 'git describe')
>   - and also all "unknown" 'git-foo' commands that can be found in
>     $PATH, which can be the user's own git scripts or other
>     git-related tools ('git-annex', Git LFS, etc.).
>
> With this change we wouldn't list any of the above commands, but only
> those that are explicitly categorized as 'mainporcelain'.  I'd much
> prefer the current behaviour.

Yeah I noticed this (kinda) with filter-branch but I did not look
further to see all this. It's good that you review this series then :)

For the first group (known commands), how about we add a new category
"completion" in command-list.txt? Each command may belong to multiple
categories (and my updated script has to deal with that [1]). For the
second group, we could also have a special "external" category that is
produced at run time, not specified in command-list.txt. --list-cmds
option either has to accept multiple values, or we accept multiple
--list-cmds=3D<category> options.

git-completion.bash will be updated to ask git "give me the commands
in the mainporcelain, completable or external category". This also
addresses another thing that bugs me: I wanted an option to let me
complete all commands instead of just porcelain. This approach kinda
generalizes that and it would be easy to let the user choose what
category they want to complete.

[1] which also means I could bring "deprecated" category back.
--=20
Duy
