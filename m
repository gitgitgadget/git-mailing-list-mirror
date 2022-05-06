Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA5D5C433F5
	for <git@archiver.kernel.org>; Fri,  6 May 2022 07:46:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389675AbiEFHuB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 May 2022 03:50:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236048AbiEFHuA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 May 2022 03:50:00 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DF2766C91
        for <git@vger.kernel.org>; Fri,  6 May 2022 00:46:18 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-e5e433d66dso6464698fac.5
        for <git@vger.kernel.org>; Fri, 06 May 2022 00:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=u95JvDhporw8WV6DXreInGdmcuHJ6ChgfLWaGYZlE7E=;
        b=JfZDpohUHwN+KKz4YjIllO0NyR/Px1Z/aBWuJSpnYoSx5uwPK5ncd3VpwkN3+7+5D8
         BwgitSgmp47tpXKlOW5czUO+kwXQiOvkPkcklbmRtpUIlTp45ZL2Ftc4lvgY/1HDtJBC
         hoJgpW/Q6euTD0BUaqckNEh3lGaYLfFBMdSR6a2diGtW5n56NA2Olvnb1lt1d0Xla5e3
         zBe090WyWjGsBzdI3mq+g1YqpJyBje+tw5dae06vS93uecf97nq0UxI01wRzEXIfjge3
         zEBxn6rhfJruPE0ux75ZfIYB4I2yvvfBEcuzEoulGA8M9t2ClELb+3xdKPnxSct19IB7
         sq3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=u95JvDhporw8WV6DXreInGdmcuHJ6ChgfLWaGYZlE7E=;
        b=mopSGobm9v6bx0RiQaWn9sLbqagvxbOyTLPdomEx4jiT2rGEdLV5Ks+N/DyjChkbHT
         jLNq+u9+9oisvrkwzjT4iF7jYxT/jDnViDTRV6therdRkOkrrHlPqdA5ErQf/rgx9DZm
         E+yxLmLvefcJ6rLWqq1K2OJ4uz1EaSX2ESM599WzT/+/kVy0DKCR6kHunQy9koyYS6dl
         GBqCJ5BH+cE6P3Gic9HuTSN96TmyeuGcbfqquuaufaBjEcrNJz8jQN9uJlcgAijo7wyL
         dvYOYkqjyX+ecA1A3i1XRi2iGAhW5tLurwocYOQaXbdmeIB0squ6aHCiUvzF0j5/qu2B
         f9JA==
X-Gm-Message-State: AOAM532i5cxdnCo266Up+dwipO8Jrbd8S+QGanhUHZMdFdKveFSbywIo
        0ipAcWNSGB9FAexp4trD5LvAXyd34jjicZsBn+4R4QW3
X-Google-Smtp-Source: ABdhPJwEAPleu7cTW7uegch+8FnSHcly0jfjmnYnhjH4/Nuh4Lvj+ZGgBuKHTTdP7YKut3Zxz+MZD3L3e73n4nkxpso=
X-Received: by 2002:a05:6870:7093:b0:e6:210a:d98d with SMTP id
 v19-20020a056870709300b000e6210ad98dmr820098oae.68.1651823177436; Fri, 06 May
 2022 00:46:17 -0700 (PDT)
MIME-Version: 1.0
References: <CAP94bnOyrx6hCmWSjmejVfopUydk10ga42wJzm1M4nk_OXn9Mg@mail.gmail.com>
In-Reply-To: <CAP94bnOyrx6hCmWSjmejVfopUydk10ga42wJzm1M4nk_OXn9Mg@mail.gmail.com>
From:   =?UTF-8?Q?Christian_Gr=C3=BCn?= <christian.gruen@gmail.com>
Date:   Fri, 6 May 2022 09:46:03 +0200
Message-ID: <CAP94bnNbXaZA9pdDspb2ajWk==rSAP0xEAQ4LNfwkzsN7B7Exg@mail.gmail.com>
Subject: Re: Resizing panels in the gitk window
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Maybe there=E2=80=99s a better place to address gitk? Anyone?
Thanks  in advance, Christian



On Thu, May 5, 2022 at 9:01 AM Christian Gr=C3=BCn <christian.gruen@gmail.c=
om> wrote:
>
> Resizing panels in the gitk window leads to a error message that=E2=80=99=
s presented multiple times in a dialog:
>
> expected integer but got ""
> expected integer but got ""
>     while executing
> "$win sash place 0 $sash0 [lindex $s0 1]"
>     (procedure "resizeclistpanes" line 38)
>     invoked from within
> "resizeclistpanes .tf.histframe.pwclist 1834"
>     (command bound to event)
>
> Is this a known bug?
>
> I=E2=80=99ll be happy to give more details.
> Best, Christian
>
