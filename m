Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB582C433EF
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 03:10:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A08B561452
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 03:10:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347711AbhI3DMW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Sep 2021 23:12:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347001AbhI3DMV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Sep 2021 23:12:21 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9DBDC06161C
        for <git@vger.kernel.org>; Wed, 29 Sep 2021 20:10:39 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id n64so5566227oih.2
        for <git@vger.kernel.org>; Wed, 29 Sep 2021 20:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8UbVoCACzz4yoGpFa+zLqhdSnIuiXuESCmnwThF50/A=;
        b=MFLtrTPS6mkeAE/HEWTuov/23K5GYJRMJdQMOymoG9zzEG5ByG91UEx0lkpHlrM/ec
         ozRWE0IOui3IRCWbvv37LJHan4iU1ReDoN2Ya+Xq75RDoZ8d/gz5MDVeThh9kGmqbg5d
         6CPwn/fS4YrhCfkBoRzi5wEe6t1gnSX0Z1cSDSl2KCdQ7JNDJ1v/MN+zzM7HlcIoMjHN
         GFeEwbavM1Da/GJRGEkbBpoiPMgOEsechXT+IBg0fPkpgYRG70+cYd52ZkKS/j8NmT8M
         TYKa3xNRp2fYNakTFoFgLYqXB+uxmBvoLZjGKnFrhrbZP4lVr2Ey9Exqx88uvyDOz14C
         WFVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8UbVoCACzz4yoGpFa+zLqhdSnIuiXuESCmnwThF50/A=;
        b=mhPPggRHZrOIPFgNNyonVMjkn5hkftDLt4giroFIENu6BSX2CJhO9iDYTiMEMcU/e6
         GjzqGJYY0RE1AsS6NQLlpw7mL6EBqvTFxGoVkcVnb1TLG5ws1ZuNsx5jZCRsXE8lEqJK
         ALx/XLXhy+p2U0Ke7UcVAD8DKZnNHxicEGAtdPvsAlQpMP70y0R/hWYGTnfeil81+5tk
         MecwoA/4Hx7k2ZjFwCV90S396ZT4S/GhNqqy/KRt4XGqOTD4ZkR0u5M0OpcwqAhFBQ/D
         zeqztkciQLqRTZcwdcGMiaJECrWHVyNTz7y9q1dMNFfN7JNpSirDEms1C4iqOUMQXglA
         tEow==
X-Gm-Message-State: AOAM533trnUGM/7hov1BwvUC3nWy4XYi670jjHYR1Hs1msUddTaoUt3b
        hPRSFe6jC+pNpErsngx+bzb8xQQN7hM/zbzzG3X8qVuk4AU=
X-Google-Smtp-Source: ABdhPJwrIKZJnSHc5pFHqoxzI0ekHZ6CUbBb8ZLGjpqIo5vWiovdXxai9BzjpUL3WKxbKjqL51xxg4yy1BTQezqX/yA=
X-Received: by 2002:aca:aace:: with SMTP id t197mr255044oie.167.1632971439158;
 Wed, 29 Sep 2021 20:10:39 -0700 (PDT)
MIME-Version: 1.0
References: <87zgs34ccx.fsf@evledraar.gmail.com> <20210924024606.20542-1-tbperrotta@gmail.com>
 <87bl4h3fgv.fsf@evledraar.gmail.com>
In-Reply-To: <87bl4h3fgv.fsf@evledraar.gmail.com>
From:   Thiago Perrotta <tbperrotta@gmail.com>
Date:   Wed, 29 Sep 2021 23:10:23 -0400
Message-ID: <CABOtWuqXS_kJk2md=kgg-ReaWtKermpUW_Dk_bc0pMXQL+xMeA@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] send-email: shell completion improvements
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Carlo Arenas <carenas@gmail.com>, gitster@pobox.com,
        bagasdotme@gmail.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 24 Sept 2021 at 16:07, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar=
ab@gmail.com> wrote:

> I meant something like the below patch, feel free to incorporate it if
> you'd like with my signed-off-by, i.e. there's no reason to parse the
> usage message, or hardcode another set of options, we've got it right
> there as structured program data being fed to the GetOptions() function.
>
> All we need to do is to assign that to a hash, and use it both for
> emitting the help and to call GetOptions().
>
> What I have doesn't *quite* work, i.e. the --git-completion-helper
> expects "--foo=3D" I think for things that are "foo=3Ds" in perl, so the
> regex needs adjusting, but that should be an easy addition on top.

1)
Thanks =C3=86var, I get the gist of it. Your approach revealed a few issues
with the current usage string:

The following options exist in GetOptions but not in the usage string:

--git-completion-helper
--no-signed-off-cc
--sender
--signed-off-cc

Out of these, I'd argue --git-completion-helper is intentionally omitted,
however --sender and --signed-off-cc were overlooked.

2)
Also, your patch misses --dump-aliases and --identity; that's because
they are in other GetOptions functions in the file.

The two obvious possibilities here are either (i) hard-code them directly, =
i.e.:

-my @options =3D sort @gse_options, @fpa_options;
+my @options =3D sort @gse_options, @fpa_options, "--dump-aliases", "--send=
er";

or (ii) refactor the other two GetOptions like you did in your patch,
so that `sub completion_helper` ends up receiving all three hashes
(or maybe a single hash as a result of all three merged).

Any preference between (i) or (ii)? I am leaning towards (i).

3)
Finally, I noticed that "sort @gse_options, @fpa_options" doesn't
really sort fpa_options.

If sorting is really intended, it would be better to modify the source
of format-patch to
emit sorted output.

Otherwise, we may as well leave it untouched. AFAIK from a completion
perspective it
seems that it doesn't matter: both bash and zsh emit `git format-patch
--<TAB>` sorted
today, even though the output of `git format-patch
--git-completion-helper` isn't sorted.
The only benefit of sorting I see would be to deduplicate ('uniq') flags.

Do you agree with this rationale?
Either way, let me know whether or not it's preferable to sort.
I'll probably sort `send-email` options anyway just to deduplicate a
few flags such as --to-cover,
but `format-patch` could remain as is.


I'll wait for replies before sending another patch (on top of your
original one).
