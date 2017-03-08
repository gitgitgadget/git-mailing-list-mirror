Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E86520135
	for <e@80x24.org>; Wed,  8 Mar 2017 22:45:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752324AbdCHWpY (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Mar 2017 17:45:24 -0500
Received: from mail-pf0-f178.google.com ([209.85.192.178]:33446 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751657AbdCHWpW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2017 17:45:22 -0500
Received: by mail-pf0-f178.google.com with SMTP id w189so20314114pfb.0
        for <git@vger.kernel.org>; Wed, 08 Mar 2017 14:43:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=XyTNvszvcEgAsyYej8qZ6ayQb1O5HaPTZSymmqR0wXs=;
        b=ifXQ0qvvham32T+cMUYr8oQn/p8uM5iEGzWVSzvokA6LVFQiJhByi9lGSn0gdosPiU
         T8TLegob2KB0/6Ye+Yl5GmEhO73thluA8AGnGBWN5/W8lUzubXDwYrJXBCp1pS03zHRB
         LCqt2CSS+AcO0nENB+VoqRhJi1EwD2rn9jfzHnYpY8iGYmgziQKmXEVLe1yw2lO4arh/
         AfPPWapk3W2GeLG4QumAKsImmSawKodc6Ts0zyvvndeiiWUwx0dAnLVYFZn/SrsIvZZh
         3H8zGnR865Xp8YE4zc8Z3H96U2U2HFVntM/tHdOcAI2sxZV4FYBOiUfPIXs5RIswcHL2
         A97A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=XyTNvszvcEgAsyYej8qZ6ayQb1O5HaPTZSymmqR0wXs=;
        b=o0lVJ6Su8QcQRQTQKfyz9u9ZALi8Xy2wnFrbRlP1ecz9dC4MJDrqXAhFpeF7190WCt
         UWmKNZGkQTOQTtXq/a7WGSn6+kcxiNhDJ91H4PIRve9nOhtO+ZegTiqXg6VHes6Ri1ys
         RfOsMowAI22rsCPD4doAQrfdKH3RXxLjYoVinsdGpByqHC/B7ssOjb17kOvIPR+CXN2K
         SK56Pej66EkePEc4VkOYqRbjZ/s9J1M0KnYcuEspB2W0GJfe5zaQrZ/nwFIyG2/JvP9C
         zjwLvXExtxvTFo9hYpGVbM8mgmrx9Mrqv/qTsbIEoS0v5+sk2uymtf3Vo4Lp3V6yi2C6
         dEBQ==
X-Gm-Message-State: AMke39mcNNtL+/M0amgbiJSFW8f3yQ/zTepd9lHulS8Y8mLZyBraRog7rCgtbIc7u+43bQCWpuY5yhwW3wYd8SM/
X-Received: by 10.99.140.77 with SMTP id q13mr9622708pgn.179.1489011066058;
 Wed, 08 Mar 2017 14:11:06 -0800 (PST)
MIME-Version: 1.0
Received: by 10.100.187.5 with HTTP; Wed, 8 Mar 2017 14:11:05 -0800 (PST)
In-Reply-To: <xmqq8tof32x9.fsf@gitster.mtv.corp.google.com>
References: <5e5b1b92-f7c6-2987-356e-1aab2bff557e@gmail.com>
 <20170308133348.2ovfsi44vq2rpgom@sigill.intra.peff.net> <CAHGBnuM3iM-kHdxdox_1i56uLbv7gQ5ZUY9Xqf4BG7G_kTf+jQ@mail.gmail.com>
 <20170308140110.wgdedquqwm75zws2@sigill.intra.peff.net> <CAHGBnuPGPcWwbrZX_92XDJu47bpH=kj2PZ7yWHK=MRfZ_RHXrQ@mail.gmail.com>
 <CAGZ79kbwMhL-ZnL-iYwPH=tWa8cNQbEGOYYQBw6OzFCMhOWE-w@mail.gmail.com> <xmqq8tof32x9.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 8 Mar 2017 14:11:05 -0800
Message-ID: <CAGZ79kZFGP0zMP5CtOH3poU9vx8FoT25UVr8ridQo0_VdH2cmA@mail.gmail.com>
Subject: Re: diff.ignoreSubmoudles config setting broken?
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Sebastian Schuberth <sschuberth@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Jeff King <peff@peff.net>,
        Git Mailing List <git@vger.kernel.org>,
        Jens Lehmann <Jens.Lehmann@web.de>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 8, 2017 at 12:54 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> On Wed, Mar 8, 2017 at 7:07 AM, Sebastian Schuberth
>> <sschuberth@gmail.com> wrote:
>>>
>>> + Jens
>>>
>>
>> + Jacob Keller, who touched submodule diff display code last.
>> (I am thinking of fd47ae6a, diff: teach diff to display submodule
>> difference with an inline diff, 2016-08-31), which is first release as
>> part of v2.11.0 (that would fit your observance)
>
> Between these two:
>
>         git -c diff.ignoresubmodules=all diff
>         git diff --ignore-submodules=all
>
> one difference is that the latter disables reading extra config from
> .gitmodules (!) while the former makes the command honor it.
>

Yeah the .gitmodules file is a good hint.

Here is my understanding of the precedence:

  command line options > .git/config (in various forms) > .gitmodules

where in the .git config we have precedence levels for different files

  .git/config > ~/.gitconfig

as well as different settings:

  submodule.<name>.ignore > diff.ignoreSubmodules

It is not clear to me how a specific setting in .gitmodules
would interact with a submodule-global setting in the config,
e.g.

  git config -f .gitmodules submodule. \
      "$(git submodule--helper name scanners/scancode-toolkit)". \
      ignore none
  git config diff.ignoreSubmodules all
  git diff  scanners/scancode-toolkit

From reading the code, I assume "diff.ignoreSubmodules all"
takes precedence here nevertheless because the diff.ignoreSubmodules
setting is treated on a higher level than the submodule specific setting,
despite the submodule specific setting being more specific.

This is a bad example, because it may be intuitive that the
value in the .git/config file takes precedence over .gitmodules,
but we cannot set diff.ignoreSubmodules in .gitmodules.

Stefan
