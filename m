Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E63A81F424
	for <e@80x24.org>; Wed, 25 Apr 2018 13:46:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753571AbeDYNq2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Apr 2018 09:46:28 -0400
Received: from mail-ua0-f171.google.com ([209.85.217.171]:37561 "EHLO
        mail-ua0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752949AbeDYNq1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Apr 2018 09:46:27 -0400
Received: by mail-ua0-f171.google.com with SMTP id i3so3650536uad.4
        for <git@vger.kernel.org>; Wed, 25 Apr 2018 06:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=FQp3+naEAXCJWdKwigZt9ECJHCD1nyeMAGOCz8dTwEQ=;
        b=n0gHawBQheVtZQ4LAJjiiiHOFXUWjl8LhDWXDHELfP0D6qcD1fxbtHr1aSnGZGlkfP
         pR51nX0axWux3dfmRp0F8WRrnYPgHFU2yj74s1fFZdU7FOclbhqiuh9XnVIj6Rl/LRRB
         +MwrSClbHub5kQgQ+uj0cgDK3zkSOMhZdJ1Q1FcO4bCE+uvnFBI5I6S/COtDohfP/yt2
         Ku34uTERA5cFJ6XHtkMtpeVTQdI+kRbK0p8PjfaE62UD6cYC0YMtzHb+5TU3SwZVLuJI
         H7KVv/OuHYs0NZTA4tVEukiHk89BYzxtnmdHLLcy+fbHzl6LjZpdwC5y3NToi25ZBxum
         MkfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=FQp3+naEAXCJWdKwigZt9ECJHCD1nyeMAGOCz8dTwEQ=;
        b=bHj/60Qo/qXw+zhg66MCSaqFr9KqEGmoHY4kyTNLjUSb6WDpfqrPB26M0MOkLAiX8a
         7xeYE+qzp4ASa7jTBl+TRIw7zrZLYKvNRWDwWPcZYf5TyY4MLHdEfXYHd4HJ+5r7dtH/
         xWLpinAyq/PpfWYVuXEwj2hgbyc7ktGf/BZR6rqSAxQRUvDAES9pqHkZfajsbdZ4g/MJ
         XYvuCVKEN2GFsjF/31pZeYR3O+FcxbRSJdlbLh7kMJSEFJSXGWy7glcbqSDKhMBtqQEB
         YWo5gnu8sxADS7zVM57f8wzRnjFSKxNMAz5H1khWEJD0OzidKAZGtuYSLXmC3970lffe
         fUYg==
X-Gm-Message-State: ALQs6tAQ2N4Fs3EiFRMivAvir3rRyFXenkUkL+HjIprHBSwcX8E+JvWP
        ZltgWl+j7cD8gN0UhTJYS69U49z6mzjfNo9oFAw=
X-Google-Smtp-Source: AB8JxZrAnmEjxzmtGwkx7wDULfCQVDCosmNN+6u1dnTKa7ZXlawYJv+SkH2vNj6TGB6jGtsRrzlQHaUnff3XE+q0LRI=
X-Received: by 10.176.91.146 with SMTP id y18mr468337uae.48.1524663986697;
 Wed, 25 Apr 2018 06:46:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.159.34.195 with HTTP; Wed, 25 Apr 2018 06:46:26 -0700 (PDT)
In-Reply-To: <CACsJy8DWcofCqg=QKo2pLcLQ91GKohnS71Wns8siVZ_sufjgUA@mail.gmail.com>
References: <20180415164238.9107-1-pclouds@gmail.com> <20180421165414.30051-1-pclouds@gmail.com>
 <20180421165414.30051-5-pclouds@gmail.com> <CAM0VKjkd7OZspeTPumi4NVOM=7yXEq=nSjCNntkJ9d-8mPfR2w@mail.gmail.com>
 <CACsJy8B0bFzh5h+QE+NMgCHfoShfu8MvCzmxPPCVi-g_Ud3sUw@mail.gmail.com> <CACsJy8DWcofCqg=QKo2pLcLQ91GKohnS71Wns8siVZ_sufjgUA@mail.gmail.com>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Wed, 25 Apr 2018 15:46:26 +0200
Message-ID: <CAM0VKjnD4ZnZjwO6M=P1NcJCfJCfJb=tR5CKwSOeCBvUbjcB=Q@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] git.c: implement --list-cmds=porcelain
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 24, 2018 at 6:17 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Tue, Apr 24, 2018 at 6:12 PM, Duy Nguyen <pclouds@gmail.com> wrote:
>> git-completion.bash will be updated to ask git "give me the commands
>> in the mainporcelain, completable or external category". This also
>> addresses another thing that bugs me: I wanted an option to let me
>> complete all commands instead of just porcelain. This approach kinda
>> generalizes that and it would be easy to let the user choose what
>> category they want to complete.
>
> To complete this: there could also be yet another special category
> "custom", where --list-cmds=custom simply returns a list of commands
> specified in config file. With this the user can pick the "custom"
> category to have total control of what command shows up at "git <tab>"
> if they are not satisfied with the predefined categories.

Note that config settings can be repository-specific, which might
cause surprises if the user sets a custom command list in one
repository's config file, but not (or a different one!) in others.
Then the list of completed commands will depend on where the user
happened to be when first hitting 'git <TAB>'.  Unless you forgo
caching the list of commands and run 'git --list-cmds=...' every time
the user hits 'git <TAB>', but that will add the overhead of fork()ing
a subshell and a git command.

Once upon a time I toyed with the idea of introducing environment
variables like $GIT_COMPLETION_EXCLUDE_COMMANDS and
$GIT_COMPLETION_INCLUDE_COMMANDS, to exclude and include commands from
'git <TAB>'.  I wanted to exclude 'git cherry', because I have never
ever used it but it's always in the way when I want to cherry-pick.
And I wanted to include 'git for-each-ref' back when I was running it
frequently while working on speeding up refs completion, but it
wouldn't have brought that much benefits, because I have a 'git
for-each-commit' script, too.
Never really pursued it, though, just patched the long list in
__git_list_porcelain_commands() in my git clone :)
