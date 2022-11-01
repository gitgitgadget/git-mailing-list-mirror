Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81513C4332F
	for <git@archiver.kernel.org>; Tue,  1 Nov 2022 22:59:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbiKAW7J (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Nov 2022 18:59:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbiKAW6u (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Nov 2022 18:58:50 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53A4325F4
        for <git@vger.kernel.org>; Tue,  1 Nov 2022 15:58:49 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id s9so8634594ilu.1
        for <git@vger.kernel.org>; Tue, 01 Nov 2022 15:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=98QskwswgU0rWyM3+WGbJuc3hkMb7cut85RFqFj2xik=;
        b=OEHpv0UXBt9jMEQMKmp4kXSF9oS69icF+DD/UHLUgVgem2GqD1otBeAZvuUGX45wkP
         onyITVbdjm0mUBJFIcf2AlZwLvODU5Bcgo0s24+PNMGwllugkHDtZT+ZzI4NdSpEqCc1
         YG4hLKBMe9p1+M0xBWVOAQRKvu5B9fxTjmRhKw2cpOvfTghA72mg2OsMr5zBivOl/iWK
         6l1P0ymZVd13d/foOiRIHuIeNmJwyMbex4YiyozdYplE0k1XRAILeEW618zy6GI8rYyp
         ty6UcIiCKOc6pC6hSKL9vmBPIuBUCxsEQoCyOvDK+UTPaTUbiFSGSvaAuW/7h7KM0XlT
         P/kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=98QskwswgU0rWyM3+WGbJuc3hkMb7cut85RFqFj2xik=;
        b=c5i3kQQZiQwxw5Ur/rbIt0OlNaxferc8ETTladE5/Oe0mfkYK8R4gMWNME+iNYonci
         70huReEa9fzA7q0X3e8+2CcNKdcypWS59T/kP+U/DGOcoB6ypE2SBIp9HVFHDQ7CucYA
         w45EyPF7DVzMjlje3wLiAwYphdzcrKR3UFq5S6BajttdLw3i87Go7C+KmWkeF4KOwm90
         VEia7u8Rcje0jbPNxvWe5eLLq9xy34ZkE1Wh4PpxYjub3AJnxjihqLSLQkHkfQv1J++b
         GY9jXp7No1iRquzyzsJ8TsyL6PqVi445u0hmzqP06p8+q8JODvs83EtC0HJbK2PhkrBN
         k36Q==
X-Gm-Message-State: ACrzQf3eIiwLgiyhbSzLLzCRcMJRHaicmuvFVWthjuEEGKt7QkBuu2hv
        fvQxyy8whBkubTWVL3HqQOFva9HE/SVKqi4msQY=
X-Google-Smtp-Source: AMsMyM6FCTntnCzzg9Kg6zCkCnfgmiraJhOTxeCKEuTzTLR3uKdHZ6r1SWddrUDNqiwqXuN9dixrnQJzP96DwAPFfDM=
X-Received: by 2002:a05:6e02:13e5:b0:300:929:9782 with SMTP id
 w5-20020a056e0213e500b0030009299782mr12594770ilj.48.1667343528657; Tue, 01
 Nov 2022 15:58:48 -0700 (PDT)
MIME-Version: 1.0
References: <cover-v2-00.11-00000000000-20221027T032622Z-avarab@gmail.com>
 <cover-v3-00.12-00000000000-20221101T225022Z-avarab@gmail.com> <patch-v3-02.12-7a21f4aa24c-20221101T225022Z-avarab@gmail.com>
In-Reply-To: <patch-v3-02.12-7a21f4aa24c-20221101T225022Z-avarab@gmail.com>
From:   Eric Sunshine <ericsunshine@gmail.com>
Date:   Tue, 1 Nov 2022 18:58:37 -0400
Message-ID: <CAPig+cRA5-TS_FVpw=oRN3Ws0BBRDcTkXWsVuMnk4Z4d1uLF2g@mail.gmail.com>
Subject: Re: [PATCH v3 02/12] cmake: update instructions for portable CMakeLists.txt
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

On Tue, Nov 1, 2022 at 6:51 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar=
ab@gmail.com> wrote:
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
> +The "cmake" command creates a build file from this recipe. For Windows
> +Open contrib/buildsystems/git.sln and build Git. Or use the

I suspect you wanted: s/Windows Open contrib/Windows, open contrib/

> +"msbuild" command-line tool (see our own ".github/workflows/main.yml"
> +for a real example):
