Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 913DE1F406
	for <e@80x24.org>; Sun, 13 May 2018 06:04:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750910AbeEMGD4 (ORCPT <rfc822;e@80x24.org>);
        Sun, 13 May 2018 02:03:56 -0400
Received: from mail-ot0-f170.google.com ([74.125.82.170]:46551 "EHLO
        mail-ot0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750850AbeEMGDz (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 May 2018 02:03:55 -0400
Received: by mail-ot0-f170.google.com with SMTP id t1-v6so10814922ott.13
        for <git@vger.kernel.org>; Sat, 12 May 2018 23:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=hZNrsloilvsqbz6iDMFV0RTRyEKgMMu3a/KS/B0EYS4=;
        b=rZZ9XFOg/9cBaqlseQ8cL8BmcAHW/7bkFyIjR+LTCuRb78M5jjIoJ4SDKaTQ9qxeIS
         qjNLhteS+SaiuQGNELHj8WYfhg21bPJcTilphK5XvOYyoJWuAns+y2SnQ2Mhu4xVG9MF
         eFAgB2v+0WaS23stbwxfkNYXYNuBVsE+EJBArrZar8MK9K+574ZAwSb/Hk4IxSGvrTU+
         fEuDw4j/et2iyMF1Ocm1FnAK/1lLuSYeFGQNJkyxorNux2YYe5QaSxCQyfCt00hwLtKT
         eaYvwD4KhhvVw90nSAdsnil7Kp73mrFiGF/WalN28uo0RbhhfVEbbDxlHmuD+1SR5+TR
         /xtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=hZNrsloilvsqbz6iDMFV0RTRyEKgMMu3a/KS/B0EYS4=;
        b=UHxGRq+7/WqkNUoxDmNQY1UYOUCenIIj4Lom/+pwM3O9vR0C+FzcPUO6WxNO35FKvb
         FKpt1ef9JSsXUS5liTcAuFjPKGP+1afNCn51QKwSdC1SDTf8xgu/VX+dopFSDxrmoFFc
         VjwOtCzv1cex5oWa/mo5jbqTH6eqx/OMzy1fPRsXhsNmzohWgo0ps4ryHJ9EzbjJlqxx
         HANMY2gTwhuGaWaBYrQZ1rv1ilkNszkhDxAbs/1fJvAKsHcXfc2hxIZBHtCNxKcNzUlQ
         t200w9IDhMQLbmTkTyHkkAEn6j1+u1cfmnwMoUVlRmhK9bN2WEcsj7bNkFGtSZQAp2/i
         HdAg==
X-Gm-Message-State: ALKqPwdXDRTqVxpP7irzgGZZUyNfMdqjGLVH5msZF6aL9MmrH0mQ4LOY
        RT80nS0IX1GHMknWPB5mIFGFtoZO30CEhWKLabo=
X-Google-Smtp-Source: AB8JxZpqzvafIjTlouIURpeRFz/tBGeXKQ8RG2DzdTY300ICQQB2ZXfG0YSTW+WW8KQddhLcGzdf/vYvg4aSNfbuTuo=
X-Received: by 2002:a9d:1d92:: with SMTP id y18-v6mr3704659otd.304.1526191435059;
 Sat, 12 May 2018 23:03:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.178.133 with HTTP; Sat, 12 May 2018 23:03:24 -0700 (PDT)
In-Reply-To: <1526178214-30956-1-git-send-email-danniercl@gmail.com>
References: <1526178214-30956-1-git-send-email-danniercl@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sun, 13 May 2018 08:03:24 +0200
Message-ID: <CACsJy8DZ1QvjO+JdbB76TOLtB2wp4Ya+CgsTyD1oz2Y+ZdKdYQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] checkout.c: add strict usage of -- before file_path
To:     Dannier Castro L <danniercl@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Matthieu Moy <Matthieu.Moy@imag.fr>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, May 13, 2018 at 4:23 AM, Dannier Castro L <danniercl@gmail.com> wrote:
> Currently, <checkout> is a complex command able to handle both
> branches and files without any distintion other than their names,
> taking into account that depending on the type (branch or file),
> the functionality is completely different, the easier example:
>
> $ git checkout <branch>  # Switch from current branch to <branch>.
> $ git checkout <file>    # Restore <file> from HEAD, discarding
>                          # changes if it's necessary.
> $ git checkout -- <file> # The same as the last one, only with an
>                          # useless '--'.
>
> For GIT new users, this complicated versatility of <checkout> could
> be very confused, also considering that actually the flag '--' is
> completely useless (added or not, there is not any difference for
> this command), when the same program messages promote the use of
> this flag.

I would like an option to revert back to current behavior. I'm not a
new user. I know what I'm doing. Please don't make me type more.

And '--" is not completely useless. If you have <file> and <branch>
with the same name, you have to give "--" to to tell git what the
first argument means.

> Regarding the <checkout>'s power to overwrite any file, discarding
> changes if they exist without some way of recovering them, the
> solution propuses that the usage of '--' is strict before to
> specify the file(s) path(s) for any <checkout> command (including
> all types of flags), as a "defense barrier" to make sure about
> user's knowledge and intension running <checkout>.
>
> The solution consists in detect '--' into command args, allowing
> the discard of changes and considering the following names as
> file paths, otherwise, they are branch names.
-- 
Duy
