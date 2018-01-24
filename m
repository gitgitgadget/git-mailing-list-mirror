Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5DED51F404
	for <e@80x24.org>; Wed, 24 Jan 2018 21:20:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932487AbeAXVUA (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jan 2018 16:20:00 -0500
Received: from mail-wm0-f48.google.com ([74.125.82.48]:44019 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932238AbeAXVT7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jan 2018 16:19:59 -0500
Received: by mail-wm0-f48.google.com with SMTP id g1so10961888wmg.2
        for <git@vger.kernel.org>; Wed, 24 Jan 2018 13:19:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=LHAkvhZqe/3awgVZRk0lMVM8H5FCIpamXvrrP8vBXeg=;
        b=KIZiyjSkytzWOfSHi1P/mIESiFIjyEufookQ+pFzRfogMOkYMhna2ENhZF5WNJG58J
         /n2/g+3KEk/XX6KAeMi56jqDc/Xp6Y/GhNjwiH3OsnVVlWeqUA0qh/g8GQhmYNen4Eu5
         0lG2BTlWMux50hNZ/WZ+k+sSR8MrAXXlPppwcsyaYlApnqOdzm7HNX/sNP3tk39/tS8y
         hvOcTcn7hIWTjjbvwOwExdu+/81J8yORtrjw1mJpRAIxKvs0b2/yMF6oL/qiVwTNqYQW
         QKGfdfZh+qAPcpjCKSuEDMY5MrZstSETzBbdAZBFA3zY375X4QO8V8Ko4U39pnJkAYke
         J2Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=LHAkvhZqe/3awgVZRk0lMVM8H5FCIpamXvrrP8vBXeg=;
        b=Ruhgj3oh6oetJqsSe5ct9LDC/L/e+oaRUulFfPVMhseG5QiheOHn6sjVoqgJSzRynp
         MMxMxN0rW2tz59xxtY4o3fSsDYzCygr+NtuOwBOk8nayTpQHwoMrg3/JEHj1QtANwvAf
         qbXUy1p32rNubC9vG8BN0R0EgJSnTtiZmfY8fMpWLCyRjlW12gEe1PGNTKz6Ay3iIiXB
         FqRmrnCrcTBAFAa6RET5ykXK9VXt7mbKMscW1eNgDgamEs1jw1RB7oTgL/dfvuS8e+Ts
         6qxa8HkX5j9qzifdLtY2hY+emdVO9a+Y+hkCh9ASeq0LTMYWKicymJdAHyq7aVrKOUvJ
         2+ag==
X-Gm-Message-State: AKwxyte4b6C8g+L/AWrWu5WgPuirhwjB628M55X+oQqNcLPx7C1EHBdf
        Kc9tHwZD2cZmVaDup1k2pm9ggiB5+cwwrzd1Ido=
X-Google-Smtp-Source: AH8x227c42sZ91zKY2JUSsyrXQ9tiwXfVBqEx52WgNptmE8i56vzjchzdaDQfsHD3519uixfuIKhFYYAc+CokLv0zsA=
X-Received: by 10.28.208.142 with SMTP id h136mr6319362wmg.133.1516828798403;
 Wed, 24 Jan 2018 13:19:58 -0800 (PST)
MIME-Version: 1.0
Received: by 10.223.166.115 with HTTP; Wed, 24 Jan 2018 13:19:57 -0800 (PST)
In-Reply-To: <c5d21b22-e4cd-e338-c953-90a81981e23c@gmx.net>
References: <20180123001648.24260-1-isaachier@gmail.com> <CAG6xkCZn6m2n0rDvpN6MmZcOr2hJBRCfhrppC37f-DUj3_JZsw@mail.gmail.com>
 <c5d21b22-e4cd-e338-c953-90a81981e23c@gmx.net>
From:   Isaac Hier <isaachier@gmail.com>
Date:   Wed, 24 Jan 2018 16:19:57 -0500
Message-ID: <CAG6xkCbtVYa_eqZj4m74jXo7yC8kS8kjWm-fALePmHaH5yY0qg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/1] Implement CMake build
To:     Stephan Beyer <s-beyer@gmx.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for your interest! This patch is based on the cmake-build
branch of https://github.com/isaachier/git, but the full history is on
the cmake branch (squashed it for easier readability). Hope that
helps.

On Wed, Jan 24, 2018 at 4:15 PM, Stephan Beyer <s-beyer@gmx.net> wrote:
> Hi Isaac,
>
> On 01/24/2018 02:45 PM, Isaac Hier wrote:
>> I realize this is a huge patch, but does anyone have feedback for the
>> general idea?
>
> Thank you very much. I am *personally* interested in this due to several
> reasons (which are mostly that I am used to CMake and when I do
> something on the Git codebase, I always end up that its build system
> recompiles everything ...which drives me crazy as hell. Using CMake, I
> could simply use out-of-source builds and be happy).
>
> I am not sure if it should go into the main Git repo. I'd already be
> happy if I could pull it from somewhere (github for example) and rebase
> it to use for my local branches.
>
> ~Stephan
