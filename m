Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 722D9C433EF
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 22:47:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54B1B60EE5
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 22:47:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231921AbhJUWtp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Oct 2021 18:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231629AbhJUWtp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Oct 2021 18:49:45 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C452AC061764
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 15:47:28 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id bp7so2851755qkb.12
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 15:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=W63np7YtNtNBddmwdqCi47s43vpjQZrOFi7gAbzkEzw=;
        b=J7vbCWtHlvQIpJTwpB1bJX0JlnYIJQR/3d1bQgncaWiF5Y25YId3GH3MTp2b5zDYsM
         2FhXXTNZXLj9gb5KRL3/jsEzceeitcx5eEyeO8E1eyI6FsU08FHlI+fBpBb/h3H7OMCN
         O+FySDi7L6AbmVHsi8uf2+grqJ2X34XUZQuyyBAhDCkjdWQRViUXGxTCAMhY+XY1TWPr
         9SxKgBHqiBRsnylWlsLM8ArBMvfEdgBI+kSm9cAaTSk86t5FdJCcbYI5dR5AybUBfDnm
         dMU39Tl1Ho1aC2Muo/BbBs3f947SmbysUvfdCQyKwyNkuzWMuSgBwAm7jpHIkNDZtgvo
         hTrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=W63np7YtNtNBddmwdqCi47s43vpjQZrOFi7gAbzkEzw=;
        b=kg29ObwfO5yEh4IUFJ0N5ldKv10ZIbN5FXUsa8Pd7iBzFXMJPw+05FSIPoyVSKfWc+
         AP6qaWhDbZhonUAPQ1SjSXyL+7EnnpNg2BvaCKmPA3ErT2YX9Ge1wX6I8iLeRekT69OB
         S52DKchCOJ1KitgP13rfrrZxwdyGjABX8ywk6LR5e/mIHBIM6+mCxlgQ/LqaZhmPeL+c
         HzCa4T8xpOskSMagEdINzPd6OF3bvpP3Y2S0qHNEKmcxTDxakSEwhhQeU0R2LttxRyGx
         sFPnrMA463v1Z16oFkg99m8knVPGDxJ/0iHx0bYxc7CzADv5O6XNLNEv0GyiCSo2+MIa
         LBsw==
X-Gm-Message-State: AOAM533gAO9d6YFTHuac2Jx1CqurOnBKaS+pm2ckQP0ucyK/j+Jwibg/
        8Zj280GhI9fwVYQifcL8Zi65UQwzvob1khEbOtM=
X-Google-Smtp-Source: ABdhPJxuN/JbWLf49Y+yhBPlYy1TQuYxHlMndjamv8bDgnoMd+/9uD9GFOLvCVePYbhDtcbKZUkdnb7eDyXEW6Pz2pE=
X-Received: by 2002:a05:620a:4414:: with SMTP id v20mr5069462qkp.302.1634856447930;
 Thu, 21 Oct 2021 15:47:27 -0700 (PDT)
MIME-Version: 1.0
References: <YNqBtrXzUlJiuc7y@coredump.intra.peff.net> <cover-0.8-00000000000-20211020T183533Z-avarab@gmail.com>
 <patch-7.8-0c6f9b80d3b-20211020T183533Z-avarab@gmail.com>
In-Reply-To: <patch-7.8-0c6f9b80d3b-20211020T183533Z-avarab@gmail.com>
From:   =?UTF-8?Q?=C3=98ystein_Walle?= <oystwa@gmail.com>
Date:   Fri, 22 Oct 2021 00:46:52 +0200
Message-ID: <CAFaJEqtHdg7htFLyztVpJsWViC7rxRxknWpPHHcK_v8PoPxOig@mail.gmail.com>
Subject: Re: [PATCH 7/8] Makefile: stop having command-list.h depend on a wildcard
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 20 Oct 2021 at 20:40, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avara=
b@gmail.com> wrote:

> Unfortunately we can't drop the old code completely due to the CMake
> integration, see 061c2240b1b (Introduce CMake support for configuring
> Git, 2020-06-12). It will keep using the older and slower script.

I took a quick stab at this earlier today and it's not too difficult to
implement. I can take a deeper dive over the weekend if this patch
series gets traction.

> +header_only=3D
> +case $1 in
> +--entry-only)
> +       shift
> +       print_command_list $1 <"$1"
> +       exit 0
> +       ;;

Why is "$1" given twice here? As far as I can tell print_command_list
doesn't reference its arguments anymore.

> +# The old compatibility mode for CMmake. See 061c2240b1b (Introduce
> +# CMake support for configuring Git, 2020-06-12)

s/CMmake/CMake/

> +echo "static struct cmdname_help command_list[] =3D {"
> +grep -v \
> +       -e '^#' \
> +       -e '^git-fsck-objects ' \
> +       "$1" |
>  print_command_list "$1"
> +echo "};"

I suppose it stems from this unchanged line. That can be changed to just
`print_command_list`.

=C3=98sse
