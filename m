Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 107EEC38A2D
	for <git@archiver.kernel.org>; Thu, 27 Oct 2022 03:35:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233987AbiJ0DfV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Oct 2022 23:35:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233810AbiJ0DfS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Oct 2022 23:35:18 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E331BF3
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 20:35:14 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id o13so260697ilc.7
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 20:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jgDMOHkKHCjp7FVgJ3HNQXItIpZnVlrilSOS/Jkta7w=;
        b=HCyLizas9V2668qfWRG9SlChlujZdO9tfpVQD7qubw5ONgDYmfGUSVmaeuLezWUM7j
         blX5E6Ud/CWA7qsqtW5kpkAg0KgvYBgNiBgJxSQCrvzDsew5FjyVa59Bu82tbGDGnanm
         RO/EpdIGTvj1hKUGmB3hz6KZqvfWp77+4WF4WABc6NsSRQkQAMaoOm3GqunnQJi0mEnK
         cR2JcCo5g6mSKaFTEP1rgfCLn9V1k9Daw7mArSVYNsJHQFVPEgTBHVdMOmbJO7zeFYi5
         ifx8kmSampCZHtETCqmCsMHAN0L4bErYLEMIKVUBd9kqWW41hb3sVb05+7zkqhbxxSza
         V1CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jgDMOHkKHCjp7FVgJ3HNQXItIpZnVlrilSOS/Jkta7w=;
        b=p/nGJu8nqzMaCODJ01CNqgsKgIKjK9ocqaLrUmR9WBo0tMom4D6Q375tnyVQLW1M0K
         wF81aWUZWP7faHV66bRmlLRC21Mq3OeYRJr8JDIClZHj18PLWsljA5rEu9xLa3egtqi6
         aVily95qXvX9xIQKC69XYs8uA7s+BQo1l9anMNK9vZYx3Df/Wr4ZgJT2rWG5/NdkdLq1
         dAGugDykaNkcNqnsigBv74HmN0Uw1bGXchUtXhUa4kRMoQzZlYK2g44tp7G84iSE8nAf
         WiNYCogAZVc59fiPMSgCup706QVKhDBP5eEiduSkpupoVrF6a9/iYXWqg8TShtWI50ce
         86Xw==
X-Gm-Message-State: ACrzQf2gcaIaUZwxdx+tIqTtEsgZaof83cwwsm0Iwy5c2RCJ6oY9Os5I
        r7ZRzwWPMkOOeCMNF42hyzsYk6dPWIy0UcnPesuMftYZ
X-Google-Smtp-Source: AMsMyM5GWWOFPTmWfwbMemnQ33jZgKRrMchs5sv0eNk9amyMWR5h4TiE01w/Ab9W6S0Oyp+ZY+IP9N3pQciFZ9PO1h0=
X-Received: by 2002:a05:6e02:1905:b0:2ff:a163:8497 with SMTP id
 w5-20020a056e02190500b002ffa1638497mr15933980ilu.147.1666841714286; Wed, 26
 Oct 2022 20:35:14 -0700 (PDT)
MIME-Version: 1.0
References: <cover-0.9-00000000000-20221021T091013Z-avarab@gmail.com>
 <cover-v2-00.11-00000000000-20221027T032622Z-avarab@gmail.com> <patch-v2-02.11-9e2470dcb95-20221027T032622Z-avarab@gmail.com>
In-Reply-To: <patch-v2-02.11-9e2470dcb95-20221027T032622Z-avarab@gmail.com>
From:   Eric Sunshine <ericsunshine@gmail.com>
Date:   Wed, 26 Oct 2022 23:35:03 -0400
Message-ID: <CAPig+cShURmL4JD4M1Pb5PdGXt6aHxKJKsRa6bS-tAQdZ-LhhA@mail.gmail.com>
Subject: Re: [PATCH v2 02/11] cmake: update instructions for portable CMakeLists.txt
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Victoria Dye <vdye@github.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 26, 2022 at 11:27 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> The instructions for running CMake went back & forth between *nix,
> Windows and Visual Studio instructions Let's create headings and split
> the existing instructions up into those new sections.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
> diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/C=
MakeLists.txt
> @@ -4,7 +4,48 @@
> +=3D=3D Building =3D=3D
> +
> +One the recipe is created a build recipe will be created.

First sentence seems to be gobbledygook. I _think_ you wanted to say
"Once the recipe is created, something, something, something", though
I don't know what "something" was supposed to be.

> +[...] For Windows
> +Open contrib/buildsystems/git.sln on Windows and build Git. Or use the

Too many "Windows".

> +"msbuild" command-line tool (see our own ".github/workflows/main.yml"
> +for a real example):
> +
> +       msbuild git.sln
> +
> +On all other platforms running "cmake" will generate a Makefile, to
> +build with it run:

s/,/;/

> +       make -C contrib/buildsystems/out
