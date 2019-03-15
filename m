Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EFAA620248
	for <e@80x24.org>; Fri, 15 Mar 2019 09:51:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728720AbfCOJvd (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Mar 2019 05:51:33 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:44678 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728657AbfCOJvc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Mar 2019 05:51:32 -0400
Received: by mail-io1-f65.google.com with SMTP id u12so7669141iop.11
        for <git@vger.kernel.org>; Fri, 15 Mar 2019 02:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=yO/+BIOwOT+zCrvJ2/zrLOLRJd/XYKG6tN1CMp3Fqc4=;
        b=IC8h863MmPbIru9pyohToYQNA54qzkDQRihwxA9Ctcr01zJIvUobALwOrs0fo+U8eQ
         Z2YGEUfD9L/66uCsV/ChWb0R6cqbjZMZTCJGDflXpDhCpCnBcC3VvTNXXdYpQpX7WWw+
         2NIKs2tT5BWwm448ydK4qAHXSnODRYNYkC5gii9yjdiUs2N1ko7XkVH6XtP/vNdjbFgr
         MxNKQKErbY80LO4CSGURsq4IQoU/hBpsBxFVv1LGRBWXYHBRw1By2dqyJV+9BKP1Bqw/
         G8yOyoQgav5MQa6Um/HKTEb67RCar0lgfe0fbkr2OM37nXNIF11gK3523GEMA/gMmsQm
         KsLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yO/+BIOwOT+zCrvJ2/zrLOLRJd/XYKG6tN1CMp3Fqc4=;
        b=JAjcJtysS8ZU9pqhypGAU38+u9fC+fM22pIhCQ5tAQh7aEo8i64x+a2SbXJj9R0CHr
         uO/710dHY9/0w9tw9ZCGFSnIfFx09cJtCO1XF1H/NLnP9I1E6PczJOXMTJREXCL/m/0P
         9GERyVLY1y+X5zD5SGzsUSygOYmrLb08nuZDMgNnVPuZjTd08D4D0kz8s/YMEqkMT9QK
         kKV4bhnbqZ9o3LbWcVQAVdcWIvEEV4+6d9/8wK2J9KGkxAuRxslokkst3iho7z9/Ufou
         V4s/j6SWwNUnKDcaKZQJNTWSyPO57M1QTffjBfMdkID/oczQAUChSp365vazpOZZyk0/
         FwNA==
X-Gm-Message-State: APjAAAXvBLv3p4J+YmxbjPYgeG/7SW/zilu+lPVSpoM7i+dTaM6X7MEH
        oQOwcby+mR+BBjviDBrqVlGkjGN6s7gjd3gf5Mo=
X-Google-Smtp-Source: APXvYqyocTgLvKHSd/JctcHlYcDc00EobNNiw+XTXImbhESNvySc3hEyWfwC0G+vMMlMtHHlMEngNIxE5OMOSQasCt8=
X-Received: by 2002:a5d:9446:: with SMTP id x6mr1349532ior.236.1552643491930;
 Fri, 15 Mar 2019 02:51:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190313235439.30439-1-avarab@gmail.com> <20190314123439.4347-3-avarab@gmail.com>
In-Reply-To: <20190314123439.4347-3-avarab@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 15 Mar 2019 16:51:06 +0700
Message-ID: <CACsJy8CikZt_WF79V6y2JRtR0jAosTPPmDBXN8uMRTjm4FAV-A@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] gc: convert to using the_hash_algo
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 14, 2019 at 7:34 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> There's been a lot of changing of the hardcoded "40" values to
> the_hash_algo->hexsz, but we've so far missed this one where we
> hardcoded 38 for the loose object file length.

Wow. Good catch.

> diff --git a/builtin/gc.c b/builtin/gc.c
> index 8c2312681c..733bd7bdf4 100644
> --- a/builtin/gc.c
> +++ b/builtin/gc.c
> @@ -156,6 +156,7 @@ static int too_many_loose_objects(void)
>         int auto_threshold;
>         int num_loose =3D 0;
>         int needed =3D 0;
> +       const unsigned hexsz_loose =3D the_hash_algo->hexsz - 2;

Since you're removing hard coded numbers. Another option is a
combination of strlen(basename()) and
loose_object_path(the_repository, , null_oid). They should also give
the same 38. Then if loose object format is updated to use 3+ chars
for the directory part, this code will not need update anymore.

The downside of course is a lot more code. Or you can just introduce a
new function to return this "hexsz - 2", keep that function close to
fill_loose_path() with a comment there that the two functions should
be aligned.

>
>         dir =3D opendir(git_path("objects/17"));
>         if (!dir)
--=20
Duy
