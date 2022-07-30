Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE3A6C3F6B0
	for <git@archiver.kernel.org>; Sat, 30 Jul 2022 13:32:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233419AbiG3N32 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Jul 2022 09:29:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231386AbiG3N31 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Jul 2022 09:29:27 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E21DE140FC
        for <git@vger.kernel.org>; Sat, 30 Jul 2022 06:29:22 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id r14so7842068ljp.2
        for <git@vger.kernel.org>; Sat, 30 Jul 2022 06:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=AiAHPVCrueuC1Jx5lSQQNIsWAZp+8QiZxAIwp9Gb4mM=;
        b=iIZFCn5R1RvYt20hcNAY7zhCAq3oFv08YX2q5lQwW1zW/S3TD2wERLSie8sSe9Y66M
         9NCX3+aCajM52Ts6IvRYRQTv2hsj8c81k3mX7jYVKbb3QqxO07BiGceDKnxpToYdyhMS
         B5KWYuoLQAKtxet4N3Bz5VSBN3mWcEDAlYjJaR5/utCmkzrX4ZJFFfusIwqfEVoqnge2
         ZPZHDiwWYFuwc53a+b0MSyipqiNQhQaFypkScx1mWYgsM53tBMjEJWvsuGGhwB4PVido
         8Eu1QRL7a/XzIr4vrvrXgTc5H456tGwkQX/LL5WCYbwFiJhfUIeDfyy0OLWVQ7+m7hy6
         Evhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=AiAHPVCrueuC1Jx5lSQQNIsWAZp+8QiZxAIwp9Gb4mM=;
        b=2TqnH8dzOLVpUWUJ+DH8W2Wuyw4Ihauv9lykalnFsbU8sC9VZ1X8dL6HA/VslQbMuQ
         LKnufIlWSIs2CldLXmdxVYtujtnieKLBmRgPHTjcGUXoGCSd+9fckptrU6Z/+A+TdG+Z
         6hHkK2Kbs1wLi6eP3o5xyHq5JR27sSuJOEM/jxcrNOlsFk4Wjf/vGXP5JPQb39ARN1oQ
         EtiMxx6qnNRr5cW4/snwH8WignJqPli9Cvv6mrQK1KK6+WhDVOl9wY1rZHB2LYlSrz9W
         1tMwD/XU9b23ucUIP8mkEltAxlN7L0/GuBuUhqvLflxxxScPWI0BDGk/27rtHeZDwrZU
         Z/8w==
X-Gm-Message-State: AJIora+5lef5qd2dFkbrHHAAIVzG5rouYAphs4idKTKnt1EM/mbm9vKq
        UAAZBW0H6GiAzfxDXxeqlDTZRbJfsABmKesmPpT2xg==
X-Google-Smtp-Source: AGRyM1uO6PZRf+aSHsy24x/iFIO4xcCf6ZZAK5fSt32jMRxPDmVdOoVThjx5aUc+gtGCF1n1kGK5vB4K1YlxyKhdH20=
X-Received: by 2002:a05:651c:23aa:b0:25e:2c1b:fb57 with SMTP id
 bk42-20020a05651c23aa00b0025e2c1bfb57mr2405820ljb.424.1659187761092; Sat, 30
 Jul 2022 06:29:21 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1657819649.git.matheus.bernardino@usp.br>
 <cover-v2-0.9-00000000000-20220729T081959Z-avarab@gmail.com> <patch-v2-1.9-ef6fa5450e7-20220729T081959Z-avarab@gmail.com>
In-Reply-To: <patch-v2-1.9-ef6fa5450e7-20220729T081959Z-avarab@gmail.com>
From:   Matheus Tavares <matheus.bernardino@usp.br>
Date:   Sat, 30 Jul 2022 10:29:10 -0300
Message-ID: <CAHd-oW5mD-H1kvuF9VEVb8KjaSkUSUpBH-WAkpCn6_Ci8o888w@mail.gmail.com>
Subject: Re: [PATCH v2 1/9] docs: add and use include template for config/* includes
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 29, 2022 at 5:25 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
> index 3125473cc1d..6e5db8ef4c5 100644
> --- a/Documentation/git-merge.txt
> +++ b/Documentation/git-merge.txt
> @@ -386,13 +386,16 @@ include::merge-strategies.txt[]
>
>  CONFIGURATION
>  -------------
> -include::config/merge.txt[]
>
>  branch.<name>.mergeOptions::
>         Sets default options for merging into branch <name>. The syntax a=
nd
>         supported options are the same as those of 'git merge', but optio=
n
>         values containing whitespace characters are currently not support=
ed.
>
> +include::includes/cmd-config-section-rest.txt[]

This will say that "everything above this line is unique to this
documentation", but `branch.<name>.mergeOptions` is in git-config(1)
with the same wording that it appears here (coming from
config/branch.txt).

Nevertheless, I'm not sure if it is worth moving this definition to a
separate file, to be included by both git-merge(1) and
git-config(1)...

> +
> +include::config/merge.txt[]
> +
>  SEE ALSO
>  --------
>  linkgit:git-fmt-merge-msg[1], linkgit:git-pull[1],
