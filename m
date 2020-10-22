Return-Path: <SRS0=9JxE=D5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13D26C388F2
	for <git@archiver.kernel.org>; Thu, 22 Oct 2020 05:54:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0E0421775
	for <git@archiver.kernel.org>; Thu, 22 Oct 2020 05:54:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503013AbgJVFyR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Oct 2020 01:54:17 -0400
Received: from mail-ej1-f68.google.com ([209.85.218.68]:34965 "EHLO
        mail-ej1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2409013AbgJVFyR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Oct 2020 01:54:17 -0400
Received: by mail-ej1-f68.google.com with SMTP id p5so502166ejj.2
        for <git@vger.kernel.org>; Wed, 21 Oct 2020 22:54:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Cp5esgrV3GiBHn4pxkyVB5CG1nvn79mi1rzCDtLr8GY=;
        b=JCx83dytHm3goTkNgfLO4QnzmzgcxppogTnPQOf94YufzxpOnwZHUNUAFvztpbBpAI
         9/S5fkQb130fxzAE3L6JcarhxTUBSIRQDOWjzjOntKjwN1nYUp9d0cvPxCQyR4UliCyN
         VrFfoLO+UJk5W5LSgEsntqR9KKE3wxjXVJ2bomzZmpQ75T5UvGdOyyrA+/xC/5g3PHHz
         /rwbCj0bdODprbvWblSp3ISqdX1LmBd5HlN9IAgnkIh4cfoVrPxvdu4jSBnlffor5f54
         N/38hCApj3bhmLNYD/6KO84qYY1TavwbLnCsO8uUrrdaA30F4FquKgs9l6LrfxXGy3wH
         Sanw==
X-Gm-Message-State: AOAM531EK3Nj77TKqejdI8DI0D6TijgC38FrC+c4jcx+IGA8SNjd3al1
        jKGXwQC2cLP4Uzud5/ttidU1P2ssVGr6TQn03gA=
X-Google-Smtp-Source: ABdhPJwSY+ygTv47bUy/B6MZCeBy2pgRZxXi8NevV00pJD/sBbxapR3eWMQtG50ao3nqUSa0OqxBBbLqJp3G492rO/c=
X-Received: by 2002:a17:906:f24b:: with SMTP id gy11mr779127ejb.371.1603346054244;
 Wed, 21 Oct 2020 22:54:14 -0700 (PDT)
MIME-Version: 1.0
References: <20201020121152.21645-1-charvi077@gmail.com> <20201021124823.2217-1-charvi077@gmail.com>
 <20201021124823.2217-4-charvi077@gmail.com> <CAPig+cRzLpY4Pe11SQ0uux-_+x_CSVYM1FvRvDebH3TNi-bVow@mail.gmail.com>
 <xmqq36264xx5.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqq36264xx5.fsf@gitster.c.googlers.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 22 Oct 2020 01:53:31 -0400
Message-ID: <CAPig+cSXgrLOfMgN2L6BnTnaCBd-h5DJaKsdOV8JePXmzeE_dQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/5][Outreachy] t7102,t7201: remove whitespace after
 redirect operator
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Charvi Mendiratta <charvi077@gmail.com>,
        Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 22, 2020 at 1:44 AM Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> > There's still a space after the '<<' operator which should be removed:
> >
> >     cat >expect <<EOF
>
> Also, this is outside any test_expect_*, which is unusual in
> modernized test scripts.  There are many other instances of
> preparing expected output outside test_expect_* in this file,
> so we may need another patch to clean them up.

I noticed that, as well, but wasn't sure if mentioning it was
worthwhile considering that this is a microproject and we're already
at v5. It can certainly be addressed by someone as a follow-on patch
if desired.

> For now, within the context of this patch, let's just fix the space
> after the << here-doc redirection operator, as you spotted.  The
> attached I'll squash into this patch.
>
> -cat >expect << EOF
> +cat >expect <<EOF

Looks fine.
