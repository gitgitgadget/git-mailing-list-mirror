Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 922CFC04A68
	for <git@archiver.kernel.org>; Sat, 30 Jul 2022 13:46:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232428AbiG3NqQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Jul 2022 09:46:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231561AbiG3NqP (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Jul 2022 09:46:15 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 857AA11448
        for <git@vger.kernel.org>; Sat, 30 Jul 2022 06:46:11 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id x39so1383148lfu.7
        for <git@vger.kernel.org>; Sat, 30 Jul 2022 06:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=9qVHUZTZNQBKg32B1nUcVx8odBuq6/JO0Ct87FMkIJ8=;
        b=K9MmMDnCFZOxhqA/ftoz2DPZweG5tj38h5iAEIx0YdR3UfPl/kHaoKBIHKd7Rbaw9X
         uVVkRGChR3DxNFzt7QwqoOQNMb2nWeYVr1b/UIcGA7Zy949rWOzoFohz/fF3hI49ADl5
         k2bQ3RtGJoxVMyNj0HcylWSlYUsYN+51fEND7CMcSb0nOmAyZmL8THvjgFB2ixQTcrEw
         POnTixqTVtYf43MFtH9Sk9+f+T+L7W5E+Hem926mar0VEJCpY+pgT0Ra/RsGCYxky4XJ
         jcGiQjDj8Jslp2orrmebX9ocNmA4EavROIL9RB5QmU24oFqGqDkTC12603GHAgGTiNtX
         DmLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=9qVHUZTZNQBKg32B1nUcVx8odBuq6/JO0Ct87FMkIJ8=;
        b=qTIhvURI+3/IC4HylXDXulGLeBIm+0fzJLWUkaJcy+6iApDDbrWBJv7uMk4gyJnP6s
         s95Vl/IUWxodq0Fmo3RamcC5+R/rdlu0p/QAfop7szpVdlFtY6h9MYABFARAlKpBr/DX
         pCfZo9tmGMsTiY9qssm4fEoQmiMztMGMotTrOhesHH/YqTfOdIJREEEuAuf1jS851K9x
         ytPD9Uw2NnlvuHKi7y1RuuhFBTHNgAYr0O15peX9Ve8wo2A1D07x5aNLMl0zZYzLiFh5
         TKkrT5R0LTQsGTs1e4YUIcjukpuNaOky3+kGKaqxdxc84aGanhm049yugwRQuDx4oi6e
         17jg==
X-Gm-Message-State: AJIora/0ML33dHGICKOYS6GnPGg41WPdosOw+d6xGt99LmJwM5U+hjwb
        BxrWLglIuPpMhtxesFb4J4UIbc+HeaIuRKVfak4BOg==
X-Google-Smtp-Source: AGRyM1vFA6sxa4zDMquxZPUlAhoN8Q+ueqe2BxNtTdFyTO2/wA90J6Gcc8W+yZT1v2B7JgA9T7qwYYQsb9L2PY2lXys=
X-Received: by 2002:a05:6512:3f13:b0:48a:a89e:3ccb with SMTP id
 y19-20020a0565123f1300b0048aa89e3ccbmr2611342lfa.245.1659188769751; Sat, 30
 Jul 2022 06:46:09 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1657819649.git.matheus.bernardino@usp.br>
 <cover-v2-0.9-00000000000-20220729T081959Z-avarab@gmail.com> <patch-v2-3.9-8138dc54e3e-20220729T081959Z-avarab@gmail.com>
In-Reply-To: <patch-v2-3.9-8138dc54e3e-20220729T081959Z-avarab@gmail.com>
From:   Matheus Tavares <matheus.bernardino@usp.br>
Date:   Sat, 30 Jul 2022 10:45:58 -0300
Message-ID: <CAHd-oW4ZdGxOE4djUwDvt1zVZ2A-FC39FLi=k_7pREAN8AbyYQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/9] send-email docs: de-duplicate configuration sections
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
> De-duplicate the discussion of "send-email" configuration, such that
> the "git-config(1)" manual page becomes the source of truth, and
> "git-send-email(1)" includes the relevant part.
>
> Most commands that suffered from such duplication had diverging text
> discussing the same variables, but in this case some config was also
> only discussed in one or the other.
>
> This is mostly a move-only change, the exception is a minor rewording
> of changing wording like "see above" to "see linkgit:git-config[1]",
> as well as a clarification about the big section of command-line
> option tweaking config being discussed in git-send-email(1)'s main
> docs.

Makes sense. And this is easy to review with --color-moved.

> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  Documentation/config/sendemail.txt | 40 +++++++++++++++++++++++++++---
>  Documentation/git-send-email.txt   | 36 ++-------------------------
>  2 files changed, 39 insertions(+), 37 deletions(-)
>
> diff --git a/Documentation/config/sendemail.txt b/Documentation/config/se=
ndemail.txt
> index 50baa5d6bfb..51da7088a84 100644
> --- a/Documentation/config/sendemail.txt
> +++ b/Documentation/config/sendemail.txt
> [...]
>  sendemail.annotate::
>  sendemail.bcc::
>  sendemail.cc::
>  sendemail.ccCmd::
>  sendemail.chainReplyTo::
> -sendemail.confirm::
>  sendemail.envelopeSender::
>  sendemail.from::
> -sendemail.multiEdit::
>  sendemail.signedoffbycc::
>  sendemail.smtpPass::
>  sendemail.suppresscc::
> @@ -44,7 +76,9 @@ sendemail.thread::
>  sendemail.transferEncoding::
>  sendemail.validate::
>  sendemail.xmailer::
> -       See linkgit:git-send-email[1] for description.
> +       These configuration variables all provide a default for
> +       linkgit:git-send-email[1] command-line options. See its
> +       documentation for details.

Ok, I looked one by one and these are all indeed mentioned in the
git-send-email(1) cli option documentation.

The rest looks good too.
