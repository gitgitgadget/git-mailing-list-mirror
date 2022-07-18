Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C33B9C433EF
	for <git@archiver.kernel.org>; Mon, 18 Jul 2022 19:26:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235802AbiGRT0J (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Jul 2022 15:26:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235129AbiGRT0I (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jul 2022 15:26:08 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B94DD2C10B
        for <git@vger.kernel.org>; Mon, 18 Jul 2022 12:26:07 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id mf4so23165419ejc.3
        for <git@vger.kernel.org>; Mon, 18 Jul 2022 12:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2NAo2/LOjW7YC5CLG8s0hhkVZ1Mz+mwrt20sKSwQdgY=;
        b=GDLh0tT7w2trMVTThD1h+MR04y6FoodsvCTWSjdiA+enEQp/IBb9C/KGSXqbGlzych
         pDoAM8+TUYr790Xamnnq3M0mVyI2ALvyw8LDqiA+hkDw3EqtJ5ZF6KKMyIPzoafKIdLG
         oehG9KU+rPmYcAqzvEwsiFsjCstltkTHoyXaIJvykr1RER30mGmwTUWRTrjNyifWF5vR
         zqpSXdCDZigVpBXc0NSfynYviwmaOHG02XxFTvnUXHE4Iky/f12FcDIzD1UPjC/Q47oz
         hlxw2EJ8XMSG1ex4sgMS5ezY86QYGOjm2g2MlDbU/xm2RSGXNfV0u+kH1z7cv1Hj1NAm
         x7pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2NAo2/LOjW7YC5CLG8s0hhkVZ1Mz+mwrt20sKSwQdgY=;
        b=zlYPG7aE/J2nKVCiM+26qwlhFigj+7O/58o1hKD4Zr8cToBYdai8vTm/iN0CWhqVZc
         dIPe8QT+sruDBZeSRbke87lHWA43aOxL+w746sy2vWo39Vs4wi3Xmsw/LNGhWOXlROzG
         FbeU2hZPssQHo9oziWy5S1xandixCZO/2NkWNLstYcwP2DtvSyyWPd3i/puymQdR4kuE
         aGXnxxUJGF84spu0zPy/as69Mhzr2sRQtPQGjUcTg07KVd6UaTEWDRlR7DGi0GoGV+ur
         TDAVs61hi7nuSuqRfaU3UiHftpuQwKMSmjIwT0FFRYL8WCDzg/k9frS/VJjqwY8KhFiP
         f5dA==
X-Gm-Message-State: AJIora/IvnSPhsmhMEXSb7fbWM/NlgGNDnC1uQP0A/x2VRJGHXTnxN3F
        GC9I2n6JU6tzEptXbGguC85MplOQRJgQ93jYR58bC66rBZKKEQ==
X-Google-Smtp-Source: AGRyM1vYzMq1/yrhwY2QjSiXiM46JA557CW563/I/+HZIy8eDco+yLjG2T2dMXl9qo/Ar32xAXtW6F0bXdAyUchzexw=
X-Received: by 2002:a17:907:7fa9:b0:72f:36fd:ef89 with SMTP id
 qk41-20020a1709077fa900b0072f36fdef89mr4945088ejc.433.1658172366098; Mon, 18
 Jul 2022 12:26:06 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1266.v2.git.1656249017.gitgitgadget@gmail.com>
 <pull.1266.v3.git.1656924376.gitgitgadget@gmail.com> <e64362621d235f2c79f52e984de7a2a2794e2842.1656924376.git.gitgitgadget@gmail.com>
 <YtDVDu7VKgAcvRse@nand.local> <CAPOJW5y+ywbiT2XBYYNN+y73+V98Ro33D1bgZQveQLTPfrgE_g@mail.gmail.com>
 <YtHoJ90N6rmDmn6M@nand.local> <CAN0heSoA=wv4syJ3VOe92QPpjPHyqUPJ8+Pv+mbB0-TiiieVmw@mail.gmail.com>
In-Reply-To: <CAN0heSoA=wv4syJ3VOe92QPpjPHyqUPJ8+Pv+mbB0-TiiieVmw@mail.gmail.com>
From:   Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Date:   Tue, 19 Jul 2022 00:55:54 +0530
Message-ID: <CAPOJW5zEJJwx+1_4MrpwPVnpV=i_82obO-uqAcYJGJDS6y=31w@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] pack-bitmap: prepare to read lookup table extension
To:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Abhradeep Chakraborty via GitGitGadget 
        <gitgitgadget@gmail.com>, git <git@vger.kernel.org>,
        Kaartic Sivaram <kaartic.sivaraam@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 18, 2022 at 2:37 PM Martin =C3=85gren <martin.agren@gmail.com> =
wrote:
>
> Hi Abhradeep and Taylor,
>
> I very much enjoy following from a distance Abhradeep's work on this
> series and all the reviewing and mentoring. I don't grasp anywhere near
> all the details, but I've looked into this a bit:

Thanks!

>   "The compar routine is expected to have two arguments which point to
>   the key object and to an array member, in that order, [...]"
>
> I think it would help to make this something like
>
>   static int triplet_cmp(const void *key, const void *array_item)
>
> to really highlight this asymmetric nature of this function, or to make
> clear how the values flow through our call-chain through something like
>
>   static int triplet_cmp(const void *commit_pos, const void *table_entry)

Nice. Will update it.

> Would it make sense to let the `const void *key` directly carry the
> 32-bit value and hope that `sizeof(key) >=3D sizeof(uint32_t)`? That's
> probably too magical, "just" to save on dereferencing.

I do not have any particular opinion here. I will do whatever you think is =
best.

> One thing that could perhaps make things clearer is if
> `bsearch_triplet()` did take the position directly, rather than as a
> pointer:
>
> -static int bsearch_triplet(uint32_t *commit_pos,
> +static int bsearch_triplet(uint32_t commit_pos,
>                            struct bitmap_index *bitmap_git,
>                            struct bitmap_lookup_table_triplet *triplet)
>  {
> -       unsigned char *p =3D bsearch(commit_pos,
> bitmap_git->table_lookup, bitmap_git->entry_count,
> +       unsigned char *p =3D bsearch(&commit_pos,
> bitmap_git->table_lookup, bitmap_git->entry_count,
>                                    BITMAP_LOOKUP_TABLE_TRIPLET_WIDTH,
> triplet_cmp);
>
>
> Also, maybe s/bsearch_triplet/&_by_pos/ could clarify the intent of this
> function?

Ok, sure!

Thanks :)
