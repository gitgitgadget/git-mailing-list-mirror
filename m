Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C696F1F424
	for <e@80x24.org>; Wed, 25 Apr 2018 14:45:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754600AbeDYOpO (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Apr 2018 10:45:14 -0400
Received: from mail-oi0-f50.google.com ([209.85.218.50]:34697 "EHLO
        mail-oi0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754585AbeDYOpN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Apr 2018 10:45:13 -0400
Received: by mail-oi0-f50.google.com with SMTP id e23-v6so21092412oiy.1
        for <git@vger.kernel.org>; Wed, 25 Apr 2018 07:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pTCkPMv5EeVC1at3nNUnSx3nxCWyiDjLF7sAE6odoZ4=;
        b=rVBRa3bnuLW/prLZIdEuNZ80FmRjTeWNQkarcfr4HoyYVjQ4ApkPZEbY2PKPdHpcq3
         HWhcTvWJAto95vIZPGIf7VKfyOQPrilLER74w8DJuKeiLqG7+cb5Rb3emEDlqt76DWeM
         tageMG7anT72qaoXwO4RVMGNgl+asRehld2HyifWpP/qiSWmY3xFORGqLH+8d+TpysLM
         rMS0SLxSoOLJn07vYEZUt/zZstxu++Q8LsP3g/hXa0PKX7s6BHElcWGgiO3Exa6/8ew0
         jpYtNS+f3E0KQNGS+/nsXxXvmt3tVDp37pN6EFRmXjM1Lkfj1IrIkzwSuAbiZKRkI2+S
         e2jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pTCkPMv5EeVC1at3nNUnSx3nxCWyiDjLF7sAE6odoZ4=;
        b=Jlw1Vn1JiHydz8F7WuKV658OQtCVOuERgkCcUlSCmezoxu0VGrEdNwq8VHf5aqnl90
         xU/wlPaS71QXtWNDTN1CzmwR3EmBjgEdr5jfVFmqZMoGj3/HbZKjKgX9gnz6LjyPERdk
         ovzXj9xRjkhVM1ySDAsUn75lYC4uKW2q5FylIKVe+6KueTS7pYIAOiFvrifxh5lKP3Xv
         VDuwvgmSW4KGRZseVyLyPVhubZWOk6dUm/tApEAtncMRclcGGf01JdIS9h9pb9iHzn7F
         MqkToO+DL7OL4NeAxp8/DaOhY0FWU8Zs0miDU0DNcS8/uXLy37u+ZHsjCyWsaDHwZfGU
         lQhw==
X-Gm-Message-State: ALQs6tDdYnSmNbDEQpgzvPMzvMzLM3E7Yq5lyviqTCfl5TJ5gQ7hs4lO
        5zHzDz/3kfZjcqqvDr3y5RwW9Zt+NhlGYSWhoRo=
X-Google-Smtp-Source: AIpwx49QmBCCYS3TshTej/1z8lNuAMT96phvqAFc0gvrTFf1xEkI+0gde42KzXBb5qGrU+08XKUA4uTKwUvheK2pz8E=
X-Received: by 2002:aca:aad3:: with SMTP id t202-v6mr18340818oie.30.1524667512750;
 Wed, 25 Apr 2018 07:45:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.198.152 with HTTP; Wed, 25 Apr 2018 07:44:42 -0700 (PDT)
In-Reply-To: <CAM0VKjnD4ZnZjwO6M=P1NcJCfJCfJb=tR5CKwSOeCBvUbjcB=Q@mail.gmail.com>
References: <20180415164238.9107-1-pclouds@gmail.com> <20180421165414.30051-1-pclouds@gmail.com>
 <20180421165414.30051-5-pclouds@gmail.com> <CAM0VKjkd7OZspeTPumi4NVOM=7yXEq=nSjCNntkJ9d-8mPfR2w@mail.gmail.com>
 <CACsJy8B0bFzh5h+QE+NMgCHfoShfu8MvCzmxPPCVi-g_Ud3sUw@mail.gmail.com>
 <CACsJy8DWcofCqg=QKo2pLcLQ91GKohnS71Wns8siVZ_sufjgUA@mail.gmail.com> <CAM0VKjnD4ZnZjwO6M=P1NcJCfJCfJb=tR5CKwSOeCBvUbjcB=Q@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 25 Apr 2018 16:44:42 +0200
Message-ID: <CACsJy8Bw0+Zdq6yhw4J0W=HccB57_ssFHaHgShuM5bWiDyhtMg@mail.gmail.com>
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

On Wed, Apr 25, 2018 at 3:46 PM, SZEDER G=C3=A1bor <szeder.dev@gmail.com> w=
rote:
> On Tue, Apr 24, 2018 at 6:17 PM, Duy Nguyen <pclouds@gmail.com> wrote:
>> On Tue, Apr 24, 2018 at 6:12 PM, Duy Nguyen <pclouds@gmail.com> wrote:
>>> git-completion.bash will be updated to ask git "give me the commands
>>> in the mainporcelain, completable or external category". This also
>>> addresses another thing that bugs me: I wanted an option to let me
>>> complete all commands instead of just porcelain. This approach kinda
>>> generalizes that and it would be easy to let the user choose what
>>> category they want to complete.
>>
>> To complete this: there could also be yet another special category
>> "custom", where --list-cmds=3Dcustom simply returns a list of commands
>> specified in config file. With this the user can pick the "custom"
>> category to have total control of what command shows up at "git <tab>"
>> if they are not satisfied with the predefined categories.
>
> Note that config settings can be repository-specific, which might
> cause surprises if the user sets a custom command list in one
> repository's config file, but not (or a different one!) in others.
> Then the list of completed commands will depend on where the user
> happened to be when first hitting 'git <TAB>'.

I think that is expected when the word "config file" is mentioned.
It's no different than aliases, which could also be repo specific and
affects completion.

> Unless you forgo
> caching the list of commands and run 'git --list-cmds=3D...' every time
> the user hits 'git <TAB>', but that will add the overhead of fork()ing
> a subshell and a git command.

This is a good point. I'd rather forgo caching iff the "custom"
strategy is used (technically we could still cache if we know the
source if $HOME/.gitconfig or higher but it's not worth the effort).
Just make it clear to the user that if they go with "custom" strategy
then they may hit some performance hit.

> Once upon a time I toyed with the idea of introducing environment
> variables like $GIT_COMPLETION_EXCLUDE_COMMANDS and
> $GIT_COMPLETION_INCLUDE_COMMANDS, to exclude and include commands from
> 'git <TAB>'.  I wanted to exclude 'git cherry', because I have never
> ever used it but it's always in the way when I want to cherry-pick.
> And I wanted to include 'git for-each-ref' back when I was running it
> frequently while working on speeding up refs completion, but it
> wouldn't have brought that much benefits, because I have a 'git
> for-each-commit' script, too.
> Never really pursued it, though, just patched the long list in
> __git_list_porcelain_commands() in my git clone :)

I'm tempted to support "delta custom list" (e.g. "+cherry-pick" in the
config variable means "add that command on the existing list", or
"-blame" means exclude it) but that's probably too much work.
--=20
Duy
