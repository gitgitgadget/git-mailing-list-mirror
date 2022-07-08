Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D261C43334
	for <git@archiver.kernel.org>; Fri,  8 Jul 2022 11:29:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237661AbiGHL3K (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Jul 2022 07:29:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231217AbiGHL3G (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jul 2022 07:29:06 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3551904F6
        for <git@vger.kernel.org>; Fri,  8 Jul 2022 04:29:04 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id z41so26545625ede.1
        for <git@vger.kernel.org>; Fri, 08 Jul 2022 04:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks.biz; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4Lz+eJe1HivvSv0vTrPPHeimcF7+p/3R/te7FeKIW5k=;
        b=OFGwh9EpqsSD/O5XQlEk3t8ZRixlwNy/DTJ7bGTIYOj2kyMDHqbSmRyejfTQSpzrey
         1FysC0VGn3U6gcT9EqNeVvBQmFHEHArhGJrMRLRIlDJBwkDJ/T98/hUKwALn3islqs1U
         XYoJgeIfQJEamtf+ItrXZwlChT6HpF+cC5V4g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4Lz+eJe1HivvSv0vTrPPHeimcF7+p/3R/te7FeKIW5k=;
        b=vuakQdXSMXbn4ZuzxNtM2KF11XHVpt5wWXHVj3Owg00mJuuHC7/QloJBManhUQGg5a
         JzaM2vula+vFpW+/4l8hSmhseOlukazcAz1UZ6KqYzvM/H+RI2PNTKuesFEPkYbsB6VS
         yedrlInn2tOhA34VvUSEvwwAS9dAYGp9ko1NJFChmCB0q17xPCid6JAtylORVtf0b8Op
         ERrfH7UaziOQCDr4I389JNjPwt1FWuDk9s9QCnc2EfjqbKmO+fid4XkX8nKmeXjIQR3v
         4OiaIwNubJQz2lIfy0ipCC333mkR0QLphA0qLMYUOnWZ3GQ1ZLd2a2+OCVWvCOh6k2lA
         EHcg==
X-Gm-Message-State: AJIora8lfhdFHoqj+xP+a6cSV6ztDSVuTUVYfHUa3RAgRj5cuKNXIH6q
        LjPqMgesd/R6DYdsERcEoxQSAouKWISht0GVxjbtyQHS59VY09K0Olc=
X-Google-Smtp-Source: AGRyM1tE97Z9laRQF2BK3MzX7khq/NZluAFdCs3k+hFJ86zNyf4Af4NdR8p6O/h7q6QUGNEwLco2V3ElMhgVl5kUcFY=
X-Received: by 2002:a05:6402:294c:b0:43a:91a9:a691 with SMTP id
 ed12-20020a056402294c00b0043a91a9a691mr4273377edb.182.1657279743157; Fri, 08
 Jul 2022 04:29:03 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1285.git.git.1657267260405.gitgitgadget@gmail.com>
In-Reply-To: <pull.1285.git.git.1657267260405.gitgitgadget@gmail.com>
From:   Tao Klerks <tao@klerks.biz>
Date:   Fri, 8 Jul 2022 13:28:51 +0200
Message-ID: <CAPMMpohwP1U4pr-G=fDDu_AHTY-2mn8hn8zBf-pAsmm=w0mSzw@mail.gmail.com>
Subject: Re: [PATCH] git-p4: fix bug with encoding of p4 client name
To:     Kilian Kilger via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Kilian Kilger <kkilger@gmail.com>,
        Kilian Kilger <kilian.kilger@sap.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This makes sense to me, and I don't see anything wrong with the "form"
(and nor does GitGitGadget).

Not sure whether formal review sign-off is used on this list, I don't
tend to see it, but do I see "Reviewed-by" on patches, so FWIW:

Reviewed-by: Tao Klerks <tao@klerks.biz>


On Fri, Jul 8, 2022 at 10:01 AM Kilian Kilger via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Kilian Kilger <kilian.kilger@sap.com>
>
> The Perforce client name can contain arbitrary characters
> which do not decode to UTF-8. Use the fallback strategy
> implemented in metadata_stream_to_writable_bytes() also
> for the client name.
>
> Signed-off-by: Kilian Kilger <kkilger@gmail.com>
> ---
>     git-p4: Fix bug with encoding of P4 client name
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1285%2Fcohomology%2Fmaint-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1285/cohomology/maint-v1
> Pull-Request: https://github.com/git/git/pull/1285
>
>  git-p4.py | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/git-p4.py b/git-p4.py
> index 8fbf6eb1fe3..e65d6a2b0e1 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -854,12 +854,12 @@ def p4CmdList(cmd, stdin=None, stdin_mode='w+b', cb=None, skip_info=False,
>              if bytes is not str:
>                  # Decode unmarshalled dict to use str keys and values, except for:
>                  #   - `data` which may contain arbitrary binary data
> -                #   - `desc` or `FullName` which may contain non-UTF8 encoded text handled below, eagerly converted to bytes
> +                #   - `desc` or `client` or `FullName` which may contain non-UTF8 encoded text handled below, eagerly converted to bytes
>                  #   - `depotFile[0-9]*`, `path`, or `clientFile` which may contain non-UTF8 encoded text, handled by decode_path()
>                  decoded_entry = {}
>                  for key, value in entry.items():
>                      key = key.decode()
> -                    if isinstance(value, bytes) and not (key in ('data', 'desc', 'FullName', 'path', 'clientFile') or key.startswith('depotFile')):
> +                    if isinstance(value, bytes) and not (key in ('data', 'desc', 'FullName', 'path', 'clientFile', 'client') or key.startswith('depotFile')):
>                          value = value.decode()
>                      decoded_entry[key] = value
>                  # Parse out data if it's an error response
> @@ -871,6 +871,8 @@ def p4CmdList(cmd, stdin=None, stdin_mode='w+b', cb=None, skip_info=False,
>                      continue
>              if 'desc' in entry:
>                  entry['desc'] = metadata_stream_to_writable_bytes(entry['desc'])
> +            if 'client' in entry:
> +                entry['client'] = metadata_stream_to_writable_bytes(entry['client'])
>              if 'FullName' in entry:
>                  entry['FullName'] = metadata_stream_to_writable_bytes(entry['FullName'])
>              if cb is not None:
>
> base-commit: e4a4b31577c7419497ac30cebe30d755b97752c5
> --
> gitgitgadget
