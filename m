Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60178C433F5
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 20:06:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C74361213
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 20:06:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231858AbhKJUJH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Nov 2021 15:09:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231160AbhKJUJG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Nov 2021 15:09:06 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9A81C061764
        for <git@vger.kernel.org>; Wed, 10 Nov 2021 12:06:18 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id z21so15118751edb.5
        for <git@vger.kernel.org>; Wed, 10 Nov 2021 12:06:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=eWt4ZEeqeCuUjUvt0oRU+nv6y2X9ES53xPkp3tuEVKU=;
        b=on+kk6q5KYi0sO6/oQ6Tz2hnRt8gXnK8HaEC+nlEGNT4qdiQeJitIWTkef43wWIrkL
         agd/W02i/dW2QsIKZH33atxPPGPhv64xGZ83bxohxfyx8U7xbDxbzHHWQ11RQXxfrFMW
         KNCdLGKVoAHXMHhl41IlNleXMtba3orGXEfs6XKqnZvHJAWsz1gzmGwEKwqwTD8cVIcg
         S4WUutdVz97L2awXU/xeFf/fjeNHO0wOJ5FIl5R8P3CMND7poyzUoW0rdF33cF9f60dh
         QFD17COR7Lg+gfzbfeJ/nA1BDNCu/P3MNWHma+cl8bC/NjJU7jjBmWm2BO5sWbdaZisJ
         yplw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=eWt4ZEeqeCuUjUvt0oRU+nv6y2X9ES53xPkp3tuEVKU=;
        b=DjURTBfg5s81ZPgS7wunEZtIXhafVNrZG0S3QL8TFk700AktVfTodKxoAUY9J+38CG
         6tIdBnM9eOkQebA/fD1AZbJwN5TECzfjer6z+Ds7cVrGtLP1dWlZbmn4Oq22A92i4xa4
         wkHiN+ToZyUsne6N4pBAazoglw5SVkNjHNXaf1AIHs+VUnRJ9LWWkC/nerS9Xiz3L7jH
         PyYdFk6Pw7Ls/OFNoLSw8FFdwOxjQcwYeCBKcgKVsmDvrMhRA6UTEz11aY+Foukn6WFz
         yX6OWKJUTuxWKxh9e8UL5l8H5gotilFEgN5p6i48YJnePlJPdAFCfSZ/abiaDiniQer0
         UXSA==
X-Gm-Message-State: AOAM533jyVzgAXHfossYonJfcSVXBv9rh70dHejxQq12wsuE2ZJeoqaw
        WAz7tfAMtaAG6CVz9Zd4YG8zl3+JWXMsz+ym/NsQ0Z9m
X-Google-Smtp-Source: ABdhPJzz8KDDYlBuW+ecTyBnLTakTz22JHIqRQL/vwTEvT+DZuKuRjo4SuRoMlbM4tm10FHIbEG0Hr/58oVoMyq8CE8=
X-Received: by 2002:a17:906:2f10:: with SMTP id v16mr2269624eji.434.1636574776761;
 Wed, 10 Nov 2021 12:06:16 -0800 (PST)
MIME-Version: 1.0
References: <pull.929.v2.git.git.1607677728.gitgitgadget@gmail.com>
 <pull.929.v3.git.git.1609272328.gitgitgadget@gmail.com> <7214fa73fdd13418744903f6c769fdb77c9512ce.1609272328.git.gitgitgadget@gmail.com>
 <CAPNYHkm5Qp8HQGU5_6DXc7xpCrdGgEin0WYAxbRNOkKW0j2ERQ@mail.gmail.com>
In-Reply-To: <CAPNYHkm5Qp8HQGU5_6DXc7xpCrdGgEin0WYAxbRNOkKW0j2ERQ@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 10 Nov 2021 12:06:05 -0800
Message-ID: <CABPp-BFqZj4qYXbPGLyX=4RM4OdLNL=VbYyhbLakU-RrvU+wfw@mail.gmail.com>
Subject: Re: [PATCH v3 3/9] diffcore-rename: simplify limit check
To:     =?UTF-8?B?QmHFn2FyIFXEn3Vy?= <basarugur@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Taylor Blau <me@ttaylorr.com>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 9, 2021 at 1:15 PM Ba=C5=9Far U=C4=9Fur <basarugur@gmail.com> w=
rote:
>
> Hi all,
>
> First post on Git mailing list, to provide a comment on a patch. Hope
> this works.
>
> In cases where the `rename_limit` is already greater than 65535, the
> `st_mult(rename_limit, rename_limit)` multiplication overflows and
> process halts.

Out of curiosity, what system are you on?  And how many renames do you
actually have?

We used to clamp to 32767, but one specific repository needed values
larger than that, in the range of ~50000.  However, due to a number of
rename detection related optimizations added since then, the git of
today can handle that same particular repository and support full
rename detection with a rename limit under 1000 for merge/cherry-pick
(sorry, forgot the exact numbers), and probably less than 10000 for
diff (just guestimating; I don't want to go and check).

Anyway, all that aside, I don't see any such overflow for rename_limit
being 2**16; we can push it much farther:

    size_t a =3D 4294967295;   /*  2**32 -1  */
    size_t b =3D a;
    size_t c =3D st_mult(a, b);
    printf("%"PRIuMAX" =3D %"PRIuMAX" * %"PRIuMAX"\n", c, a, b);

Output:

    18446744065119617025 =3D 4294967295 * 4294967295

Adding one to the value of a results in:

    fatal: size_t overflow: 4294967296 * 4294967296

> But I don't think an 'overflow error' is very helpful
> for the users in understanding what is wrong with their configuration;
> i.e. `diff.renameLimit` documentation says nothing about a 'maximum
> allowed value'. I would either clamp it to a reasonable range, or
> inform the users about the limits, or maybe both.

That sounds reasonable, but I'm not sure it's worth the effort in
practice.  2**32 - 1 is so impractically large for a rename_limit that
I don't see why anyone would need a value even remotely close to that
level (and I wouldn't at all be surprised if other things in git
scaling broke before we even got to that point).

Perhaps you're dealing with a 32-bit system?  Even then, the
repository that hit this was about 6.5GB packed .git history; and you
might need to be a lot larger than that given the optimization since
then in order to hit this.  Can 32-bit systems even handle that size
of repository without dying in several other ways?
