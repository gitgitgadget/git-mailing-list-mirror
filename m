Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B1B6C433EF
	for <git@archiver.kernel.org>; Wed,  2 Feb 2022 17:44:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346309AbiBBRoZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Feb 2022 12:44:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231499AbiBBRoY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Feb 2022 12:44:24 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66316C061714
        for <git@vger.kernel.org>; Wed,  2 Feb 2022 09:44:24 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id j2so1113080ybu.0
        for <git@vger.kernel.org>; Wed, 02 Feb 2022 09:44:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aRKjpro7RURNDsam0Tomwv1khzbiw81RshhoKWBCPuw=;
        b=gf8JzUXOo90bojLmwziaERwcJSPgZXItuSibf+8D2/L4W8Rm0kb+oRPoaPv/cC5gYs
         a6XM7jbVORWIwuB0NF5z/uOYubljeHkEoy4bjZRv/56Oo0IZAnJk+2ZOmVL1OBVaOtkz
         IOl+Bob4IG2Ht3CwpmH3Tv3+rLZbd/BFI0MMI3Gnpdq4dhuqX+hdVwnxeRoJSzFsRb4N
         pQ2Joiot4GJiEDA4t4Sw6GFEdYqoHFeMSEGmCxUCiUzHgdowjRTfiC4zJvMfdB8lTORI
         zw4hGK8NHHyXqkffxGSvfag/rNj2bt+DwNZTroi9G8VC6ErOetx144r+6RHUFUT+j7ED
         8N+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aRKjpro7RURNDsam0Tomwv1khzbiw81RshhoKWBCPuw=;
        b=3FazXQ5mgGVCEnA1YyeMBA5zGXiscTmYBOt2DggwPs+0wb/cwAjeYPDFAqf0qGFH/R
         j1WcLzEs9Dp1xASf9GuOpXkg38bdUwNibqiPhW4i3NfTjN+oUGA2QK/3LqVretjwBa/X
         qVUAvypLHgtnd+za0tmsIyF1XxRxYacBK9gTzypP00Q9vzmH+B29YoUlAXnxFzkw1bdO
         rl5ee3tI5rx0UaTYpSatOky20t2OjcOa0mUVPiUhT39okfHPQD3QAETkRiAg89jSzt4v
         PzCt5kSWvWekTrLeAYI0snBrQ7hXh7jM509DjPInszALp4CxeXOjNy3jFMVpJdvm8v28
         KPhg==
X-Gm-Message-State: AOAM531hotoSSoJETW560VCS5xgnnnDPSw97jVbALq0qpqQI7XV+H/MU
        /kx6PfehWkiCe1im1s61ATYeOXr6+YgjHinAURyL099t
X-Google-Smtp-Source: ABdhPJzcJQ3Q/CYZbesWQunCv8G3/gt7ROWYPmCzpcbMxr75ey01FWNr7J2GsBEXac0PAXQGiDFmSWhAXuZ8w3q3+JE=
X-Received: by 2002:a25:c009:: with SMTP id c9mr41300448ybf.631.1643823863623;
 Wed, 02 Feb 2022 09:44:23 -0800 (PST)
MIME-Version: 1.0
References: <20220202072844.35545-1-shaoxuan.yuan02@gmail.com>
In-Reply-To: <20220202072844.35545-1-shaoxuan.yuan02@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 2 Feb 2022 18:44:12 +0100
Message-ID: <CAP8UFD21Cv50JaqnktywcTQ2XBx7-SqeXnBqQOZT=o_mDHLgmw@mail.gmail.com>
Subject: Re: [PATCH] builtin/diff.c: fix "git-diff" usage string typo
To:     Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        ZheNing Hu <adlternative@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 2, 2022 at 8:29 AM Shaoxuan Yuan <shaoxuan.yuan02@gmail.com> wrote:
>
> Remove mistaken right square brackets from "git-diff"
> usage string. Make the usage string conform to "git-diff"
> documentation (Documentation/git-diff.txt).
>
> Signed-off-by: Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>

This looks good to me!

Thanks,
Christian.
