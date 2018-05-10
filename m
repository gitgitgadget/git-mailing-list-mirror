Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 579CE1F406
	for <e@80x24.org>; Thu, 10 May 2018 19:22:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750855AbeEJTWO (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 May 2018 15:22:14 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:37466 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750747AbeEJTWN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 May 2018 15:22:13 -0400
Received: by mail-yw0-f193.google.com with SMTP id u83-v6so879327ywc.4
        for <git@vger.kernel.org>; Thu, 10 May 2018 12:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=rgaDkTHw0I5LZPxrHWYqPCcL9j6C8K86tafqqO9AsFc=;
        b=vact3G9NFGinjLRHdxCO3CsXfhegKjFV/b4YgISOcdgoyv2ICgzIYpFLP6+WQGz6xb
         WToYOI/J7XbVh/I99/fV/ZyCwHQDYd0BYcUYvaIUqcvxgN1FjXkXTD1HRk/aaQRjAlPs
         uPjLNACXoWgiw9tn4BuOmy5urLGJ3fu6s1f1LzNcV5K8b0Utjteu7dC3k0mBQXl8HOWX
         3ETnkxCIQTM+PEr3IoAS/Ov2wi73/dkQ82n+PUcltYhtCFr3Rld08YAMWf6Rm3R5coFq
         hBKRy3uA/NeNQcc4Bpn0OEyJxIt+8LEkMCjc0ZZ2QV7PoZVpaW75lBjuonoNvE5Ovw9f
         YEcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rgaDkTHw0I5LZPxrHWYqPCcL9j6C8K86tafqqO9AsFc=;
        b=O0zbG66MQ67mSd+yfbKpWLSR+qmSzNBbBbtcF6xMp2dpd3s8g+DXQzqdd/Vcp2o20s
         K79PkYSqKIc4W4RklBgOq8U9Bc/vBgqRCguo45svnGYwQNtU4Po8iKjnoinDMVlh2y4/
         dX/ZtoUGK2OSsMrqwBf89kfhBFGO7U8IYtWnmO8m0Asij10jiD4sHUiSwj301999jvI9
         2VORMY6qKw1nvzZMkb24/QYpslg+U/U0jLfSISDvuMcjUPfwbS1Q7g7rDu31Hgh8ZTaA
         SjbeQInLv+b2C+iP13DHRTeN1z4OutkvkogfAkP04EuVnPjcWF1MdNe+EMpuvl/6oDU4
         en5w==
X-Gm-Message-State: ALKqPwd7fg2U4z6pdC15dWj8Wijy0xIfVEfo5EE31GlZXsioFT6jwfVe
        ibaIu49NtcxrjyYBXzIx1C4wyM/nhENfBWA2ynvunZ0f
X-Google-Smtp-Source: AB8JxZrDYG7xinshdyoi64v5SYijGLTFky3yBjT69vaJsp1lqL9fSXncIclRdhqASN3shmVoqLRpxecqPtlhAQAqR1s=
X-Received: by 2002:a81:9447:: with SMTP id l68-v6mr1283242ywg.345.1525980132629;
 Thu, 10 May 2018 12:22:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cfd8:0:0:0:0:0 with HTTP; Thu, 10 May 2018 12:22:12
 -0700 (PDT)
In-Reply-To: <CAN0heSo-1+BvE0SiZMKT1zHZ4o+-mK0W9S+xxDA4Pyw3iTvpDQ@mail.gmail.com>
References: <20180417181028.198397-1-dstolee@microsoft.com>
 <20180510173345.40577-1-dstolee@microsoft.com> <CAN0heSo-1+BvE0SiZMKT1zHZ4o+-mK0W9S+xxDA4Pyw3iTvpDQ@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 10 May 2018 12:22:12 -0700
Message-ID: <CAGZ79kY1m_6AdUoRx1L2=HzX7hG_uUUcYnLsb=VNdxPcvnpOEg@mail.gmail.com>
Subject: Re: [PATCH 00/12] Integrate commit-graph into fsck, gc, and fetch
To:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "peff@peff.net" <peff@peff.net>,
        "jnareb@gmail.com" <jnareb@gmail.com>,
        "stolee@gmail.com" <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 10, 2018 at 12:05 PM, Martin =C3=85gren <martin.agren@gmail.com=
> wrote:
> On 10 May 2018 at 19:34, Derrick Stolee <dstolee@microsoft.com> wrote:
>
>> Commits 01-07 focus on the 'git commit-graph verify' subcommand. These
>> are ready for full, rigorous review.
>
> I don't know about "full" and "rigorous", but I tried to offer my thought=
s.
>
> A lingering feeling I have is that users could possibly benefit from
> seeing "the commit-graph has a bad foo" a bit more than just "the
> commit-graph is bad". But adding "the bar is baz, should have been
> frotz" might not bring that much. Maybe you could keep the translatable
> string somewhat simple, then, if the more technical data could be useful
> to Git developers, dump it in a non-translated format. (I guess it could
> be hidden behind a debug switch, but let's take one step at a time..)
> This is nothing I feel strongly about.
>
>>  t/t5318-commit-graph.sh                  |  25 +++++
>
> I wonder about tests. Some tests seem to use `dd` to corrupt files and
> check that it gets caught. Doing this in a a hash-agnostic way could be
> tricky, but maybe not impossible. I guess we could do something
> probabilistic, like "set the first two bytes of the very last OID to
> zero -- surely all OIDs can't start with 16 zero bits". Hmm, that might
> still require knowing the size of the OIDs...
>
> I hope to find time to do some more hands-on testing of this to see that
> errors actually do get caught.

Given that the commit graph is secondary data, the users work around
to quickly get back to a well working repository is most likely to remove
the file and regenerate it.
As a developer who wants to fix the bug, a stacktrace/datadump and the
history of git commands might be most valuable, but I agree we should
hide that behind a debug flag.

Packfiles and loose objects are primary data, which means that those
need a more advanced way to diagnose and repair them, so I would imagine
the commit graph fsck is closer to bitmaps fsck, which I would have suspect=
ed
to be found in t5310, but a quick read doesn't reveal many tests that are
checking for integrity. So I guess the test coverage here is ok, (although =
we
should always ask for more)

Thanks,
Stefan
