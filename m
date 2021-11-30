Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 760EAC433F5
	for <git@archiver.kernel.org>; Tue, 30 Nov 2021 08:24:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239578AbhK3I1q (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Nov 2021 03:27:46 -0500
Received: from mail-ua1-f51.google.com ([209.85.222.51]:44576 "EHLO
        mail-ua1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234234AbhK3I1p (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Nov 2021 03:27:45 -0500
Received: by mail-ua1-f51.google.com with SMTP id p2so39634611uad.11;
        Tue, 30 Nov 2021 00:24:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J5WX3b9eBzW68ooaz80a8Xaxaty63apmS35CTcN24SU=;
        b=xlK/ACjGX5AiqAU3DwKahbIusndCQFhWcJHCcBL2TKZPdaejlY0hLafthfssSlVnGk
         nIj871rQtvnf0toPniChR0Bwk2FFWvO345x+uOYP88sBVS5n6ktWEFJrPtEICMUeI7UP
         DxsLe/wEDaRzft1hHQ/V80IzlD6SOJejOdrFT9nLMOChAbhXnme2WUdbl8UFkRADgsHU
         +wcOjjZ9NBlPhbzZ8H9CkMhWrFf0HXMuGcV2RrhyzGj6gnZQB7DtLnW1CQeNgd29GDKG
         cWkVKiNkBD2wkIKVMgQfPBFP4DYBi6ZdNONjFtWR9z7T/vekXqsUDfm8v8Xr1HlM5/T2
         k/Rw==
X-Gm-Message-State: AOAM533cHU25fUUVHOUI5tSCFjRnMDmM8Dag1RVDUD04JrkMtmlLn+LM
        zqHFwEOXQ+WOih7egtn3AYgvjhDZfTL95w==
X-Google-Smtp-Source: ABdhPJwbYSZXeqV6CQT8qfwl7U40MCKLzJCLs/63sT459r1IAOh1qs1JYvC1rv80SfP3/3tseS3NXQ==
X-Received: by 2002:ab0:70cd:: with SMTP id r13mr54397416ual.99.1638260666183;
        Tue, 30 Nov 2021 00:24:26 -0800 (PST)
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com. [209.85.221.177])
        by smtp.gmail.com with ESMTPSA id q26sm10341433vsp.23.2021.11.30.00.24.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Nov 2021 00:24:25 -0800 (PST)
Received: by mail-vk1-f177.google.com with SMTP id u68so12998207vke.11;
        Tue, 30 Nov 2021 00:24:25 -0800 (PST)
X-Received: by 2002:a05:6122:2193:: with SMTP id j19mr43169775vkd.7.1638260665465;
 Tue, 30 Nov 2021 00:24:25 -0800 (PST)
MIME-Version: 1.0
References: <cover.1637566224.git.linux@leemhuis.info> <6b760115ecdd3687d4b82680b284f55a04f3ad90.1637566224.git.linux@leemhuis.info>
 <20211123185237.M476855@dcvr> <12cefa81-495b-3083-5f19-b319c704ebf7@leemhuis.info>
 <20211126171141.GA21826@dcvr> <42ff6b8d-0b7c-12e0-4648-a9232b0f577c@leemhuis.info>
 <20211127195231.GA4636@dcvr> <xmqqtufx5p19.fsf@gitster.g> <87mtlnjhj6.fsf@intel.com>
 <20211129172618.GA26651@dcvr>
In-Reply-To: <20211129172618.GA26651@dcvr>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 30 Nov 2021 09:24:14 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWygx9kTemsrZdru-ieYyJXm=8276Q_ZSxZGkqsu5OWVg@mail.gmail.com>
Message-ID: <CAMuHMdWygx9kTemsrZdru-ieYyJXm=8276Q_ZSxZGkqsu5OWVg@mail.gmail.com>
Subject: Re: [RFC PATCH v1 1/1] docs: add the new commit-msg tags 'Reported:'
 and 'Reviewed:'
To:     Eric Wong <e@80x24.org>
Cc:     Jani Nikula <jani.nikula@intel.com>,
        Junio C Hamano <gitster@pobox.com>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        workflows@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Git Mailing List <git@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

On Mon, Nov 29, 2021 at 11:29 PM Eric Wong <e@80x24.org> wrote:
> It's a bit much for common cases with git-send-email and
> reasonable MUAs, I think.  I don't know if formail is commonly
> installed, nowadays...

Of course ;-) You need it to run checkpatch on patch series obtained
through "b4 am", before you apply them to your tree:

$ cat *mbx | formail -s scripts/checkpatch.pl

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
