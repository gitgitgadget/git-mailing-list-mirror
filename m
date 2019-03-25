Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 904B120248
	for <e@80x24.org>; Mon, 25 Mar 2019 05:10:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbfCYFKW (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Mar 2019 01:10:22 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:35872 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726237AbfCYFKW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Mar 2019 01:10:22 -0400
Received: by mail-lf1-f65.google.com with SMTP id d18so5037448lfn.3
        for <git@vger.kernel.org>; Sun, 24 Mar 2019 22:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vsjXh6KLn/vED52R1OtFcn3dms4+gaGLOZjfkWG5zZY=;
        b=hZaDTnCvTzt9i4JiXNpD8DDfW3n/XnyWhXIwsslEO9894pljEHX2r+VW9x15Zs+wm0
         SQ1Lqc0zm6YpGt306MRLIg57JmR14uDGlV5XkJB58mzB/0Wqb8GoGTLKvwVpjgVf4Bcz
         z3NEqP0YaqZAvzuySYLn3/v34cMjNNbKd5iIDPLwJwgKmpsWNHo0JZ/dxvDz9ogUBT/M
         a8pri+222ygPmNMbnCtGaHP1yeEeJMeYa+PDwlCSRQ0vPmnFU0wfoYzaxyZctKnD5yOp
         5eMMq/lbtTt4VM8KqGrGAgdDKeEeWyLFMgedpA3I8HKHaUxMchz64c4gI9T4iHJ0aoNV
         PVzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vsjXh6KLn/vED52R1OtFcn3dms4+gaGLOZjfkWG5zZY=;
        b=m6w1sFYEsliN6yzW2TV0z+H3DWTAVaERTxnC77+hb0p07MCE4JUpFuNBdUynGmnZke
         kzWho1rhbLlskhvf8mdfIQdVAqh5p03BIH3yu8Im/6kTVyTDYfv0SvZ9MArBrOJYBc0R
         tydKwb3GdP7C4RDyEtULIhTt81chZLQ4+ajUzPyyl57tybRY8YyKrnxp3+iCbIPn/GNU
         D64VvV8L0fsGznSXHv3uKZU5x8dpXP+rooQ9uudB0wC6u1Fn4ZrhajHBEBHOYznpU9jn
         fTetln0rgbXb0QLoYB+CU3f1vsOozKOYjsM6OqXRahz488S44p9fsAlUiP3ZXW1lZPPS
         5Bpw==
X-Gm-Message-State: APjAAAUYCir0TzxbnmlzGPvAYmibwlpxM55qPRdQYqFJWB8Y97R4N3RW
        S3y1SLJRGNa73QDmJQ/HlfcuWVCctlLtIyN//F4=
X-Google-Smtp-Source: APXvYqxRImgZpm+Z+ocXGZMzIZtwvIgBPEN0FDKxkr4U/zi2xOclBhejIT9NJLXDhb/n6hB+ryHcMrWehY/Pm2acTc4=
X-Received: by 2002:ac2:5629:: with SMTP id b9mr10820238lff.100.1553490620273;
 Sun, 24 Mar 2019 22:10:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190323041332.9743-1-alexhenrie24@gmail.com> <xmqq36ncpgpe.fsf@gitster-ct.c.googlers.com>
 <CAMMLpeQbz5qHyK8e4gZ0zKQ5na+zQCd49GZifKZ_iO-gXrs1Gg@mail.gmail.com> <20190325011717.GA5357@rigel>
In-Reply-To: <20190325011717.GA5357@rigel>
From:   Alex Henrie <alexhenrie24@gmail.com>
Date:   Sun, 24 Mar 2019 23:10:08 -0600
Message-ID: <CAMMLpeQGz85ogLgKX6DBMyz0wpRvW9fXCpK87m+JoT9i7hw1Kw@mail.gmail.com>
Subject: Re: [PATCH] In `git log --graph`, default to --pretty=oneline --abbrev-commit
To:     =?UTF-8?Q?Rafael_Ascens=C3=A3o?= <rafa.almas@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 24, 2019 at 7:18 PM Rafael Ascens=C3=A3o <rafa.almas@gmail.com>=
 wrote:
>
> But If we make the default to 'short' (or anything else), what should be
> done if the user has `format.pretty=3D` defined to something? Is `--graph=
`
> special to be allowed to not follow said configuration?
>
> It's inconsistent itself, and introduces inconsistencies on other things
> like the configuration above.
>
> In my opinion, a better alternative could be having a configuration like
> log.graphFormat, similarly how we have log.graphColors for colors, to
> determine which format should be used with --graph.

The way that I wrote the patch, if format.pretty is not defined then
`git log` will default to one format and `git log --graph` will
default to another. I admit that it is a bit of a hack.

On Sun, Mar 24, 2019 at 12:58 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> But maybe a built-in "git-graph" is in order? E.g. one can imagine that
> once we have a dedicated command for that (similar to range-diff) you
> could really focus on the UX of that, e.g. going further than --oneline
> and truncating a N+ divergence as "...and N more.." or something.

I like the idea of a completely separate `git graph` command. This
command would simply be a builtin alias for `git log --abbrev-commit
--pretty=3Doneline`, like how `git reflog` is a builtin alias for `git
log -g --abbrev-commit --pretty=3Doneline`. Junio, would you be on board
with that?

-Alex
