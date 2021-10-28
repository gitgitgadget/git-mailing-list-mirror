Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ABCDC433F5
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 18:46:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 362E460C40
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 18:46:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230444AbhJ1Ss0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Oct 2021 14:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbhJ1Ss0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Oct 2021 14:48:26 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9200C061570
        for <git@vger.kernel.org>; Thu, 28 Oct 2021 11:45:58 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id 127so6860306pfu.1
        for <git@vger.kernel.org>; Thu, 28 Oct 2021 11:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JNllZTXOxMvBIfu+ba8GN2Goo3S98WvlXgmlrQqGL6A=;
        b=icap3sgZjoELE8XBCmw8blcmYgCIvXWVP+IPM1i1BynvRZ3vGr4fPBiYE2PZQmXJK8
         vo0FVk9JhjBVNxyfu8wHuAiX4vEs3HuCn90Fl8EM8qKS6O1AmIVQEgVff3eq9yY4gzz4
         p8PlL+NVGtyF1dJVyYYB8IN+GrmRgd3OCQiP6YgfpPy2aeRBtSePc41E+iIfFmypa0KB
         G96GYOC2sc0ADDAUuU9QSd71F6B01wJWSiWtdEOGpQLLxhOwLVyVNDhhsyO2XxGqZgLh
         gRsEQCt5JKLZfCZDEdLZhrVE+aMKmy+Ff9+IgSTQOSqEM287503B0xfxU2ZE2WRy4tbw
         WQxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JNllZTXOxMvBIfu+ba8GN2Goo3S98WvlXgmlrQqGL6A=;
        b=HUen5gk989XEzdDVnn1gV1IgiH8aTLi66UbkkY0gueCY3IvoCxjvex7GR/jrB1MB8t
         vn4YT35gl7RFy6cWmjVPNrzZK84GWVeln+OjmnALgabrSDGbYSbcICkkDKrOQJaBh4HP
         e4O4RVQzE0SS76NYsJP/y69gCKsNEbvnsFW7j8hpeiHrjEGhc8xoelQQel5JDxJE1ux3
         8t6DpJRSXxjsyaS1/dasitrGSF6x9Jt3xMXAcbxLz02oVZsVtHhrOBqe/Rt55GKkhPb3
         z3lHmp+4fhNt9131+e45k8pcDuE3Fb9mQ9gBH0lBQJKW6Thx08hgO4zs+mFXo9yG8OGG
         5jBA==
X-Gm-Message-State: AOAM530EGcSibYWhUcOrtJ0Ki6z1KiT/Rd5c8PyhdKwkgOjsk/10BJMo
        LP3voDYN4dsKR5MK6qsImUIJWNB+fn2OeIMlMYY=
X-Google-Smtp-Source: ABdhPJy4sO1omURs/FDFEIsoFvY73Xnz3ttepKnRFuP2jGLr3Df2pZJ7OD/RvgThY/LB6P/V0BWoKtkyrZXxdc4mn/Y=
X-Received: by 2002:a05:6a00:13a3:b0:47c:126:3596 with SMTP id
 t35-20020a056a0013a300b0047c01263596mr5984245pfg.5.1635446758395; Thu, 28 Oct
 2021 11:45:58 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1066.git.1635261072531.gitgitgadget@gmail.com>
 <pull.1066.v2.git.1635438124.gitgitgadget@gmail.com> <0045fe6faeaa2beb63a1e63b3b7573ae06cfba38.1635438124.git.gitgitgadget@gmail.com>
In-Reply-To: <0045fe6faeaa2beb63a1e63b3b7573ae06cfba38.1635438124.git.gitgitgadget@gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Thu, 28 Oct 2021 20:45:46 +0200
Message-ID: <CAN0heSqFNULMRGCHGAWfSj6cQ_N2-OoGm3KTc3Kzy=MwzJQWxw@mail.gmail.com>
Subject: Re: [PATCH v2 2/9] doc: split placeholders as individual tokens
To:     =?UTF-8?Q?Jean=2DNo=C3=ABl_Avila_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 28 Oct 2021 at 18:22, Jean-No=C3=ABl Avila via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>  archives that it imports, it is also possible to specify Git branch name=
s
> -manually.  To do so, write a Git branch name after each <archive/branch>
> +manually.  To do so, write a Git branch name after each <archive>/<branc=
h>
>  parameter, separated by a colon.  This way, you can shorten the Arch

> -<archive/branch>::
> -       Archive/branch identifier in a format that `tla log` understands.
> +<archive>/<branch>::
> +       <archive>/<branch> identifier in a format that `tla log` understa=
nds.

This patch looks good to me. Maybe these "<archive>/<branch>" should go
in SQs, but that should be outside the scope of this patch (and this
series is big enough anyway). This last instance here adds a new
instance of this pattern, but it's an existing pattern and you're
following the local convention.


Martin
