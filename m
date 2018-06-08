Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A60851F403
	for <e@80x24.org>; Fri,  8 Jun 2018 15:06:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751186AbeFHPGa (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Jun 2018 11:06:30 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:41800 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751140AbeFHPGa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jun 2018 11:06:30 -0400
Received: by mail-lf0-f65.google.com with SMTP id d24-v6so20545517lfa.8
        for <git@vger.kernel.org>; Fri, 08 Jun 2018 08:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5eglXWnyA71F4N8upMfl+87HhmxPu7nbBc+yUssHxQY=;
        b=VWEyZ4LKcVfgBw2o9yqxXw0fjDZ7lwqGA9N+J8V+8GODi3lGdcrc+CUOorOYLReGBT
         N1bTse3hiotkp2op7ThEVrg96byxlhrFl392pd/5mKVCkKVe6Sxa+74GVUrq0knum3Ro
         +mTh4nr/6X3eHkVYNG0zLWEAYAeCU31PFlE2W5Me3WJyIa0PArrOaEhOKmIfCYk+Eg5w
         C5WNN4BKlsmd7wwqOQIOe3u36Jud1B65N6voIxce9R3UhLg2AfGlJK/5+smvLiinuDcq
         Hm1dhp8Y9oT0TqZYhVAo+WxjbQ9UrMohO8qi8mD9PzvC/05ImRZPDUmZHBj0P3JRGkNH
         CxKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5eglXWnyA71F4N8upMfl+87HhmxPu7nbBc+yUssHxQY=;
        b=s0I9C3ukM2S09b/zE1vm2pMuW0fzjAOv0Egq43HUJmJhicIfegdDFA1eP6MrExIh9V
         iq6HEb947TA1Qh+mFJYca2CVzgnf0Pr83UTFzALk98ukYKLV56cqDRTHm/IZ38yFppJR
         /HBQiKu8+so0QEq918Tj9iGMG46z32li9mZp5AL+sQoT3tADsfAuy9m2WDNlARKyOj/Y
         kJ73ifnZ0XZh7nEqF3e3x1RnB5pQDuOdxXFb/L0d659DGZATr46+P8BcJ/vdHGa5X9/X
         /T9QcAr6daOU/JH/ZqpoSF+p7P3TRnGThkMvmdMGnG8cqG5tk15pGzY6P0bkbIoJQRNA
         2Qvg==
X-Gm-Message-State: APt69E37izUEKRV0gs+vvXHvbWPGDLeYvSthXcphlim0bZ9U48iIBZKO
        UvbRLTbvkqwW2n2HwUb+LSoph9JljzNB4HfFeb8=
X-Google-Smtp-Source: ADUXVKK17oqXyId6HbRghb5ocs3ULlAvXDvmBk7K9Xpvt38e8S4srh7wrZtyzn1y82RnYgQlTH+b2/hOEjspYgC74PM=
X-Received: by 2002:a2e:3613:: with SMTP id d19-v6mr1333906lja.31.1528470388714;
 Fri, 08 Jun 2018 08:06:28 -0700 (PDT)
MIME-Version: 1.0
References: <20180606113611.87822-1-dstolee@microsoft.com> <20180608135548.216405-1-dstolee@microsoft.com>
In-Reply-To: <20180608135548.216405-1-dstolee@microsoft.com>
From:   =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Date:   Fri, 8 Jun 2018 17:05:50 +0200
Message-ID: <CANQwDwdRUFnqYva+mvPh8fijcYNGNDRac857aHMhzHUOLeASpw@mail.gmail.com>
Subject: Re: [PATCH v6 00/21] Integrate commit-graph into 'fsck' and 'gc'
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     git <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <marten.agren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 8 Jun 2018 at 15:56, Derrick Stolee <dstolee@microsoft.com> wrote:

> [..], the following
> diff occurs from the previous patch:
[...]
> diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
> index b24e8b6689..9a0661983c 100755
> --- a/t/t5318-commit-graph.sh
> +++ b/t/t5318-commit-graph.sh
> @@ -33,8 +33,8 @@ test_expect_success 'create commits and repack' '
>  '
>
>  graph_git_two_modes() {
> -       git -c core.commitGraph=3Dtrue $1 >output
> -       git -c core.commitGraph=3Dfalse $1 >expect
> +       git -c core.graph=3Dtrue $1 >output
> +       git -c core.graph=3Dfalse $1 >expect
>         test_cmp output expect
>  }

It seems that you have accidentally removed the fix from previous version.
It needs to be core.commitGraph, not core.graph.

Best,
--=20
Jakub Nar=C4=99bski
