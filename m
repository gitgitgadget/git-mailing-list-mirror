Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEB73C04A68
	for <git@archiver.kernel.org>; Sat, 30 Jul 2022 14:09:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234285AbiG3OJk (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Jul 2022 10:09:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233955AbiG3OJi (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Jul 2022 10:09:38 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02F8217E02
        for <git@vger.kernel.org>; Sat, 30 Jul 2022 07:09:36 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id b21so7883170ljk.8
        for <git@vger.kernel.org>; Sat, 30 Jul 2022 07:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=9WsqwrYuf79k4FycGCndUI27BPpS3d3A+jyfEUd8c3I=;
        b=BZwNsw99D5tCxDnGC0wg0gJQqknKok5jNPHoYML75cS3Mwotj66ikOqAa3I4EeSooP
         exo6xbl5JcQp7Il1Pbj7Wl8StYUfqYsFnMONYyN9hsT8EoJykoMTkrDKItyIkPHA92MC
         O6RahklzYkWyQfMVto2aKsmVutNorSMcGfrxF20r6vpPMmHkG07V/VKXRbeWCm6Qg/bf
         CMxd1zqH11D6TyLwdENstrKm+7+5RSksRfQbEp/Tlviyrj0v8QmWiR35HoO02DkKs0X9
         DrJMlLflLccB3HRS7Fp2AE1ZEJMJmjjNlsks3rqHqBkShgNoe7dlyaopmHRITJIQ6uPm
         JQBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=9WsqwrYuf79k4FycGCndUI27BPpS3d3A+jyfEUd8c3I=;
        b=d7H7sY7cQSjn3M3inv3E8wJgE5DQM/q+wSh2WoHhYeCEIXv7W3mVSTtLTR5WlSQ0nR
         5Mo9x+rWMqUR8ghkGktCCkEiFjbxbWgw1C26sLZcbyr2SvLx1FFq9MAJQxAdXjuFbd1/
         gaZks24vdI/gz3ebt14mOYu4SV5+ER6XsZfqSsMFBSuS7vPpbOIy9mHyj010vt1JZ4ZR
         KOJTxPyjTNUHXL5iyK71IVKYaWuQ01zfejDjF0tU068LoFTtaepqsssSy30KpWYInUDj
         ZJ78ZBWrtSEv/FzhUk6/4SrEMjTKT5kGRF/1x2pqc3RytYr+zuuVQMAVbd6IO4k0CTyv
         I5KQ==
X-Gm-Message-State: AJIora+rNwCUAK7Pmmi/ntsm+yNnUiiUG1nHiTt81w3Y8N5ZtUk1WwEl
        fSFEgRTivveonQ3GUmVroOUHkMIO6poiNXJHBAl7bW4WHLLB6Q==
X-Google-Smtp-Source: AGRyM1sSuFKgZTMUDcTNThJntVLFaGGNAU+q+EEnU1IN6CUA3hPNhsARE0sFrLrpaL68WTruCxNA5wggqg+hghUW94g=
X-Received: by 2002:a2e:9595:0:b0:25e:110e:947a with SMTP id
 w21-20020a2e9595000000b0025e110e947amr2425680ljh.334.1659190173809; Sat, 30
 Jul 2022 07:09:33 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1657819649.git.matheus.bernardino@usp.br>
 <cover-v2-0.9-00000000000-20220729T081959Z-avarab@gmail.com> <patch-v2-6.9-b3a5ea46bb5-20220729T081959Z-avarab@gmail.com>
In-Reply-To: <patch-v2-6.9-b3a5ea46bb5-20220729T081959Z-avarab@gmail.com>
From:   Matheus Tavares <matheus.bernardino@usp.br>
Date:   Sat, 30 Jul 2022 11:09:22 -0300
Message-ID: <CAHd-oW7FHny98ZV5KOk2kHbN7TTGR_d1mm6F8g8S1wQjviKb2g@mail.gmail.com>
Subject: Re: [PATCH v2 6/9] difftool docs: de-duplicate configuration sections
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 29, 2022 at 5:26 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> diff --git a/Documentation/config/difftool.txt b/Documentation/config/dif=
ftool.txt
> index 67625944804..a3f82112102 100644
> --- a/Documentation/config/difftool.txt
> +++ b/Documentation/config/difftool.txt
> @@ -1,6 +1,17 @@
> -difftool.<tool>.path::
> -       Override the path for the given tool.  This is useful in case
> -       your tool is not in the PATH.
> +diff.tool::
> +       Controls which diff tool is used by linkgit:git-difftool[1].
> +       This variable overrides the value configured in `merge.tool`.
> +       The list below shows the valid built-in values.
> +       Any other value is treated as a custom diff tool and requires
> +       that a corresponding difftool.<tool>.cmd variable is defined.
> +
> +diff.guitool::
> +       Controls which diff tool is used by linkgit:git-difftool[1] when
> +       the -g/--gui flag is specified. This variable overrides the value
> +       configured in `merge.guitool`. The list below shows the valid
> +       built-in values. Any other value is treated as a custom diff tool
> +       and requires that a corresponding difftool.<guitool>.cmd variable
> +       is defined.

At first glance I thought it was a bit weird to have this diff.*
definitions moved to difftool, but it makes sense since these are
indeed related to difftool.

>  difftool.<tool>.cmd::
>         Specify the command to invoke the specified diff tool.
> @@ -9,6 +20,17 @@ difftool.<tool>.cmd::
>         file containing the contents of the diff pre-image and 'REMOTE'
>         is set to the name of the temporary file containing the contents
>         of the diff post-image.
> ++
> +See the `--tool=3D<tool>` option in linkgit:git-difftool[1] for more det=
ails.
> +

OK, this comes from the removed part of Documentation/git-difftool.txt.

> +difftool.<tool>.path::
> +       Override the path for the given tool.  This is useful in case
> +       your tool is not in the PATH.
> +
> +difftool.trustExitCode::
> +       Exit difftool if the invoked diff tool returns a non-zero exit st=
atus.
> ++
> +See the `--trust-exit-code` option in linkgit:git-difftool[1] for more d=
etails.

And so does this.
