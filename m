Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 40FCC208CD
	for <e@80x24.org>; Mon, 21 Aug 2017 16:55:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753899AbdHUQzQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Aug 2017 12:55:16 -0400
Received: from mail-yw0-f178.google.com ([209.85.161.178]:33588 "EHLO
        mail-yw0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753546AbdHUQzQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Aug 2017 12:55:16 -0400
Received: by mail-yw0-f178.google.com with SMTP id h127so26265921ywf.0
        for <git@vger.kernel.org>; Mon, 21 Aug 2017 09:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=AdM56RJhGxfKVToe7+BQS8EQC7JU/jBaXSIErvrX/98=;
        b=rye8UdepV60nyLLoUmLp5rzI7rFYeLy6SOVZy7DV9Fue440IzPoy9lJKG2M2SycA8e
         LyVo94zRXjfw1dBV0pFJlqX5/6w6anJ8Nm99TjYjyCpZ1YOQdQRoSNZ+dZVaW+PLqOJX
         a0QWfTDUP8B42653eYTE/+f+Uqqkrsy6YFQEHqtvAPl2K/yIkOfVuZKbt1H/oRJkdbWp
         JTiENepwOgm/JqX+/inECI6RQ0tMVb+8O8/uUreLsFHPZK6x4ZOcimoa0WBJGYQPuqo0
         B42wI6P4/of5tUrXWx8mISdxBfFgm6Fz/ayRUJKtK7nItfLCnZJXF2+4SQHsPb64Czsa
         qbcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=AdM56RJhGxfKVToe7+BQS8EQC7JU/jBaXSIErvrX/98=;
        b=nL0uxSUfTprHfrbxfn96ukQFqJR0ShWY4RPI0kzQFzUswxITsCoNubaIiW1OMQS7RG
         3o27MlcbbZ7YITfsxq2DWG3daWIcD+2f82Sqzpwvvuhzeb/ZQVZvdyM62TCX/4ybbH/K
         kKVOo1zrmMjoewIz9O8W/hlcwOlXI15U5K1L5T61ffwNDHfGI9TWFhdS21UhN/G4UQ3J
         HF9h2+n5GjdWpbajzk6yyaHEkOcz9GpMTOge2WtnjDu5JarO6P2KLhb1JyxDV0P8bcYp
         sXcNrBXJtPf/0xxfjYumvjIbn1K7mecpxTaJmhfANSd9LR+Jukj7iMoKa+f38A8dTUlw
         5Y5w==
X-Gm-Message-State: AHYfb5gLXyAsoSemddt/mqe3uoQ8bu/Qix/Zr+lZ7quePHEDdAEXT3lY
        DJpbxr81l4V80b7XjZrgqdFBszycO/xS
X-Received: by 10.37.43.193 with SMTP id r184mr9263813ybr.14.1503334515318;
 Mon, 21 Aug 2017 09:55:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.56.142 with HTTP; Mon, 21 Aug 2017 09:55:14 -0700 (PDT)
In-Reply-To: <20170821162056.GB1618@book.hvoigt.net>
References: <xmqqpobsbsk1.fsf@gitster.mtv.corp.google.com> <20170818220431.22157-1-sbeller@google.com>
 <xmqqvalk9is0.fsf@gitster.mtv.corp.google.com> <20170821162056.GB1618@book.hvoigt.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 21 Aug 2017 09:55:14 -0700
Message-ID: <CAGZ79ka1jyxmATQbrjPHAv3227UJNcN0nw9AY-RZXnNahepoGQ@mail.gmail.com>
Subject: Re: [PATCH] pull: respect submodule update configuration
To:     Heiko Voigt <hvoigt@hvoigt.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bmwill@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Lars Schneider <larsxschneider@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 21, 2017 at 9:20 AM, Heiko Voigt <hvoigt@hvoigt.net> wrote:

>> So I am a bit curious to learn which part of this change you dislike
>> and why.
>
> I am also curious. Isn't this the same strategy we are using in other
> places?
>

I dislike it because the UX feels crude.  When reading the documentation,
it seems to me as if submodule.<name> can be one of the following

    (none, checkout, rebase, merge, !<custom-command>)

This is perfect for "submodule-update", whose primary goal is
to update submodules *somehow*. However other commands

    git rebase --recurse
    git merge --recurse
    git checkout --recurse

have a different primary mode of operation (note how their name
is one of the modes from the set above), so it may get confusing
for a user.

'none'  and '!<custom-command>' seem like they would be okay
for any of the commands above but then:

    git config submodule.<name>.update "!..."
    git reset --hard --recurse
    git status
    # submodule is reported, because "!..." did not 'reset'.

Anyway. That dislike is just a minor gut feeling about the UX/UI
being horrible. I wrote the patch to keep the conversation going,
and if it fixes Lars problem, let's take it for now.

Thanks,
Stefan
