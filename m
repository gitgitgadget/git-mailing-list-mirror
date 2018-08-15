Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 821241F404
	for <e@80x24.org>; Wed, 15 Aug 2018 17:44:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729487AbeHOUhU (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Aug 2018 16:37:20 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:45462 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729363AbeHOUhU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Aug 2018 16:37:20 -0400
Received: by mail-io0-f195.google.com with SMTP id p6-v6so1631317iom.12
        for <git@vger.kernel.org>; Wed, 15 Aug 2018 10:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ShaMEbQqwqDD15v/nYMgusf6JJpZQvfkNi66snE53gM=;
        b=CNN0pLYqyC4YjkyQF4hN4lJb6wT0eIr4sMtA7K48ieKkL/oLydL1Q7FNbvPKEg77M8
         I2qvr1urbQxCtC57aiD1ROssTD8yQRMWSn9F2+y7vuaL9hwFTBCwV5J5Z+4JTQg7LV8+
         Vu59aqrIld5HSbR6sx+T/wm4bDtgAa/v3pE/OEFtzsDKMbXPEl2JHt6B7FaQS3b5qgSH
         nzjgxq/oZXBpfZEUryvOeK7UhCbBlp76C9MfybEpxaDxYRLflWAHwkeQ6yHc8oCWuJMd
         S99VH8b0DXQNwqI7pyaJVLS7iUQwhkA7cmfQGUmNiqNpTK4JsBfjsxGPSAdjOS5erbTN
         vhYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ShaMEbQqwqDD15v/nYMgusf6JJpZQvfkNi66snE53gM=;
        b=MiF5OHyVBO9oqqYwECXCNeN2cejgafkNpnQpb2AqIw3SdJ7i/wuqcG8jpPpyap6Xmn
         AaDx1+f1O/ZjFGvh944YkH1TolS4CkNjgdzvJC4m546w5cEx3YYwMU6x4t12LjmuryoX
         KRmLaLGUWPrwQMRZZU1qY/CO7E4Oe0ALys1ShFYwdEBIygYWJOjgRTnrFPw2GbIsSjQf
         OU5piQ0dGrfAnXV5Z8ad4AMW05X+FJ1PWlBSaICwtmrgwhn46xGAoGAvF6rStZzFYhNe
         HJ0MMxXC704Xs4cWCZZ01p3Tm2xz5/30jnUIMpZjChRJg48YPTpiNKsqRzIPRsQVKSb6
         7UzA==
X-Gm-Message-State: AOUpUlHpF050OKxR5piTY366LZ3ih7h51nTsn1dZ0KtKdnCpbunfEGaT
        yTe239goGk1GXDpUrgoeY9pKJteB4xR6TzdSFfA=
X-Google-Smtp-Source: AA+uWPwAIcqfVIyQI4R37ejAMpk6ccw51RLVbMf9bH+ODowOAXSQBzTWzfeVDQJcfoEore81MVMhzpSO6TNXclXXu78=
X-Received: by 2002:a5e:d803:: with SMTP id l3-v6mr9313606iok.236.1534355053476;
 Wed, 15 Aug 2018 10:44:13 -0700 (PDT)
MIME-Version: 1.0
References: <20180815162308.17747-1-pclouds@gmail.com> <CABPp-BEC45snMzGeCre-dD1rtqGok-RKuLGbMaV=VJhwx1ceew@mail.gmail.com>
 <CACsJy8B3ip+_sDrpvaZ32a35-6hWkY=eE6g4RObWgbHnf6g8uw@mail.gmail.com>
 <CAGZ79kbSa2chcUj_2=v7iE59R6_0m==ecYkB86+-4Fd_Zgd5_g@mail.gmail.com>
 <CACsJy8ASVqV9mmokTMmap9q7o--3nk1rRyFuuYrrNRO9mnrUvQ@mail.gmail.com> <xmqqh8jvil8n.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqh8jvil8n.fsf@gitster-ct.c.googlers.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 15 Aug 2018 19:43:47 +0200
Message-ID: <CACsJy8CE+TsE3kS+VCvxKGg6zHaDttTw+izkgveJ8qW=tSpTWA@mail.gmail.com>
Subject: Re: [PATCH 1/2] branch.c: remove explicit reference to the_repository
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>,
        Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 15, 2018 at 7:38 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Duy Nguyen <pclouds@gmail.com> writes:
>
> >> 4) eventually (in the very long run), we'd change the signature of
> >>   all commands from cmd_foo(int argc, char argv, char *prefix)
> >>   to cmd_foo(int argc, char argv, struct repository *repo)
> >>
> >> you seem to be interested in removing the_repository from branch.c,
> >> but not as much from bultin/ for now, which is roughly step 2 in that plan?
> >
> > Yes. Though I think step 4 is to make setup_git_directory() and
> > enter_repo() return a 'struct repository *'. This means if you have
> > not called either function and not take the repo as an argument, you
> > do not have access to any repository.
>
> That part is understandable if somewhat hand-wavy, but it is not
> clear how you can lose the prefix and still keep things like
> OPT_FILENAME() working correctly.

I haven't worked it all out yet, but I think setup_git_directory()
could still return it either as a separate argument or inside 'struct
repository'. Then parse_options() still takes the prefix like now, or
take the struct repository (the latter may be better because there's
also other option callbacks that need struct repo).
-- 
Duy
