Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D6EBD1F404
	for <e@80x24.org>; Sun, 16 Sep 2018 06:56:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbeIPMR6 (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Sep 2018 08:17:58 -0400
Received: from mail-it0-f47.google.com ([209.85.214.47]:34492 "EHLO
        mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726279AbeIPMR5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Sep 2018 08:17:57 -0400
Received: by mail-it0-f47.google.com with SMTP id x79-v6so8307847ita.1
        for <git@vger.kernel.org>; Sat, 15 Sep 2018 23:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=U9p9vfg5UjVVZ2CkYM+JTyo4CZNQPfn3pRSsPs37K/w=;
        b=Kr7akv+Z6YVwgaCb5k6gB66g110zyUfcympRz6xNk2EAg6XbrO9JjMhXuHsKO61s5X
         dESktxWzXj33j06hxG2BtSpm9AmRRUMcCB2fUjIMnL5tZuG8eqFrPjXqKq92SmaOXToX
         Tn2ksRrFWvFS8ZpOKqiZtIzeKPjoYoUDZhig/xZq8GY9LMdEhKCrSjDplte50kxGR+G1
         tPuvsQn73n6cXSGmm2fmZKQLuB5Q63eFd3k0Kl/yVcJjaDuHasCjYTknrAXyVonBByx0
         nT1vPV7FDOdEUoHoa3x+WMUVDzhZCoAFoiy9DGOPWPsHNTS/4rdCnkTbu0JzQF2Gx3Oc
         7ZxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=U9p9vfg5UjVVZ2CkYM+JTyo4CZNQPfn3pRSsPs37K/w=;
        b=SV5Ce2iyO0HnaYYrq9/sb92jJz4P/fSXsL5Sl9CBbUzB7hA86VzwQjeKC997To3EeD
         48901ugMZj/j/HDmHwE3+zxc/7ik4FGtZZLe2SyKQfiPpKFIGoWgtrHp2mOJB8bT5KlY
         OjbX+K+GQVRDcilhsRqzf+6uqB42N1OA0wp+WuP2zWDy7xsEsn+ivoJRA/XGYvQgH0Lp
         krd4kLHsqXsIuRAwnqMdFrGcxtLR/YtKQfbz03m7mat8uuMhPqN6z5AYL+UZqaplwkuO
         lLjrLS4Ff769qLeF0XqM6PEY4ja+ZDstXvffDRn7uJxLqU/Ymv0g2S/HLz+30YmBlwKX
         571g==
X-Gm-Message-State: APzg51C4YlT6cubcmGmN/hRSFQ1n5JyKTyR1ZKGXcSC3EdkK0jQluS3v
        5RaZ/lRXfTkoSBubh+B5Cya6MxZFWBZ71BPHQdhCZg==
X-Google-Smtp-Source: ANB0VdZ/FYezTfyEo+yzTLqzUAM+aBgkDPOUXuO53Q+wHYsY3+g3WiQZVVUVYTTzg3P0Pw4aeLvh1JCYNNX8unDy5HQ=
X-Received: by 2002:a24:d583:: with SMTP id a125-v6mr8428508itg.91.1537080962504;
 Sat, 15 Sep 2018 23:56:02 -0700 (PDT)
MIME-Version: 1.0
References: <20180904202729.13900-1-avarab@gmail.com> <20180907182954.2413-3-avarab@gmail.com>
In-Reply-To: <20180907182954.2413-3-avarab@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sun, 16 Sep 2018 08:55:36 +0200
Message-ID: <CACsJy8A5tFxAaD-OqNNvMmX+KnbmW=O7JCCBbY-5dZa8Ta7QYg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] commit-graph verify: add progress output
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 7, 2018 at 8:30 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar=
ab@gmail.com> wrote:
> @@ -989,11 +990,14 @@ int verify_commit_graph(struct repository *r, struc=
t commit_graph *g)
>         if (verify_commit_graph_error & ~VERIFY_COMMIT_GRAPH_ERROR_HASH)
>                 return verify_commit_graph_error;
>
> +       progress =3D start_progress("Verifying commits in commit graph",

_()

> +                                 g->num_commits);
--=20
Duy
