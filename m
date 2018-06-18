Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0350C1F403
	for <e@80x24.org>; Mon, 18 Jun 2018 14:59:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935251AbeFRO73 (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Jun 2018 10:59:29 -0400
Received: from mail-ot0-f170.google.com ([74.125.82.170]:34337 "EHLO
        mail-ot0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934998AbeFRO73 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jun 2018 10:59:29 -0400
Received: by mail-ot0-f170.google.com with SMTP id r18-v6so18838371otk.1
        for <git@vger.kernel.org>; Mon, 18 Jun 2018 07:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m/HUIx5qxCu2DxjICh4MT0OCHOhxp5IHzjQ8qfPpp50=;
        b=fKa7/KFeYcrBIhyt0MTy8zQKP6y+0++BKmiYTruvzZdibAP2s8W/uXM5vdxBdQ+5+8
         mFP2Hc33ARcr6rIX7RPlpazhjQpEW6sNYK2+TTd/HaTatjKeOOrrYfP2EjMFLXXHNZPD
         GlOJ1/upv5FRs73qm4n7/S83a+9Pc+JE2pbC+1TcLxw17OXyOS2bm5VmNadVO0j1EA60
         DPY9JYvbP59i9ZLXaKdNWShLwOdgLNCSPBPxn4kJAAD3ZMeJ2yHZDKqrUXDzEL8NYoi0
         QJ4EijhLXYq2OquESWO4JxdeHn6G1bZyg6hanJ1Q3S/MDgmpbUJCtFVEaA3yOgZJmFym
         ym9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m/HUIx5qxCu2DxjICh4MT0OCHOhxp5IHzjQ8qfPpp50=;
        b=G+52Ou+DpNsXJfKRuIIxaa/yzwimixsHPuRL9fVOLz3aTXPkQCcImsdhqnDK6UhQx2
         l8532r5SY+CxhEE18/xAr5waBQgr1p6WxkCF/9xEf4rYujwj1hdg5uEewIE2yxyXUmGQ
         aL/tEvdW+TL65/4NcHOiaWNa9KCET6csPAQ/Nb0hhUeWIuc35P/CegHgoGh16fu1xCzm
         jmK67XwhFogZ794T4KnyTrdG9ekNH9yxQzViunFqOs9bg2iREIGRRoGquhFaOd/NB6n4
         NJxmsTcTgxxA0f72PXofDA9e7/s5rq522y9NbYmtTz1vnICxiwRRO/+zL8BEvAwacfrP
         ShNw==
X-Gm-Message-State: APt69E1E4wiMY4TqcN0IYiIMno4dyes4ivgAcYzCZF4pON3n7pLqi0XP
        HTw/gTF4LbJgWSmAhZjsfBw+7Tyxxz2FfN7tNWo=
X-Google-Smtp-Source: ADUXVKLMkR/F3ww0Tcp9Stikb9xlaz2aPq5a85hq3Uj/f5GpanVN0R2JiNgkM0hdKj+iFxEvrH8QlnNgL8OV4cXhPIA=
X-Received: by 2002:a9d:2c94:: with SMTP id p20-v6mr8604668otb.14.1529333968610;
 Mon, 18 Jun 2018 07:59:28 -0700 (PDT)
MIME-Version: 1.0
References: <DFDB0568-9543-4135-A56D-821D4244DC8A@gmail.com>
In-Reply-To: <DFDB0568-9543-4135-A56D-821D4244DC8A@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 18 Jun 2018 16:59:01 +0200
Message-ID: <CACsJy8Cgm6gryO=X2GmztynbkkEEV=nz_J+QZG-93fS7D4eDRQ@mail.gmail.com>
Subject: Re: Git diff --no-index --no-prefix output loses leading slash in paths
To:     george.w.king@gmail.com
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 18, 2018 at 4:36 PM George King <george.w.king@gmail.com> wrote:
>
> As of 2.17.1, `git diff --no-index --no-prefix relative/path /absolute/path` produces the following:

I checked as far back as v1.4.0 and git behaved the same way too. What
version did it work for you? Or is this not a regression, rather a
feature request?

> diff --git relative/path absolute/path
> index XXXXXXX..YYYYYYY ZZZZZZ
> --- relative/path
> +++ absolute/path
>
> The leading slash on `absolute/path` is lost. This is unfortunate; my use case is a diff highlighter that parses and reformats paths so that code editors can autodetect them and link to the files.
>
> Would the maintainers please consider fixing the output to preserve absolute paths?
>
> Thank you,
> George King
>
-- 
Duy
