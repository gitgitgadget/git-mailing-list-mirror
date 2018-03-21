Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EFB201F42D
	for <e@80x24.org>; Wed, 21 Mar 2018 07:36:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751731AbeCUHgL (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Mar 2018 03:36:11 -0400
Received: from mail-ot0-f178.google.com ([74.125.82.178]:36041 "EHLO
        mail-ot0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751455AbeCUHgK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Mar 2018 03:36:10 -0400
Received: by mail-ot0-f178.google.com with SMTP id 108-v6so4623877otv.3
        for <git@vger.kernel.org>; Wed, 21 Mar 2018 00:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dakotahawkins.com; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=N7UPeD48LzVzHldKl/6+fC2Ws5+/3XAUtABIueQHyTs=;
        b=Fjw3dkPCXhWl17bCCydmW0THVWEaPkdcjglNzntfgGt868s947mL9RS7c2QPK0ckhL
         S+ttDJ/RZNQrqNBf7pPqeBORxZDvJJ4R5SEcct9LO0H8D+loqwLiE3v2Px4JtMa5tnPR
         sh0QvBYPsCeOXHjL2aBFwnTrmFiiHYRA2+Rtk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=N7UPeD48LzVzHldKl/6+fC2Ws5+/3XAUtABIueQHyTs=;
        b=YuE5byv3wGQy2IGsrQs29OM1CFoqh8q/ig0p0Vii9vTG9381MrL2bkxMqgUaFhfg2w
         1IQboA/uCsaimfFxbBBRtUfMd4JEXEACOME4JvX4UnnUfI2+7upTEQUHTDQR87JU6ksM
         sqkHg/mBM5aWRyLGZoKF0MR0s5T83qByu9KajqkcPfLAeUzjWemNjemOR5gmCeln+JL7
         g8j6BpM9lzy1OFMHbuQ3lntINXzvRa0M3mlgj02iE3Dmzepwm/sVsrejmvfWNex6/vcv
         /UTJtd+69l4RzLzh2HXFSKwsLYwjVKA3jBXQ4ghq5F1saFcX7Gytms/ApvkqdtrIUqsl
         S2iA==
X-Gm-Message-State: AElRT7FUy69Pp20ybfCdUcEdWBnhaSyljjVODSt+3f5m9J81oT8nIsgW
        ZwF7+pd7BAwkZ3Zc8B5ttnEX3YnDTVm9JTXJmoi9okXopws=
X-Google-Smtp-Source: AG47ELv5Fa02B/VlnUIWht+NsjEav/0/9gpmvkQpfKB3xZzttUnvzkokAxlnBcxAo+spGXZzRxdVQNl41ATm7q3DXW0=
X-Received: by 2002:a9d:4992:: with SMTP id g18-v6mr11968124otf.238.1521617770054;
 Wed, 21 Mar 2018 00:36:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:4a69:0:0:0:0:0 with HTTP; Wed, 21 Mar 2018 00:36:09
 -0700 (PDT)
In-Reply-To: <20180321065212.GC16784@sigill.intra.peff.net>
References: <CAHnyXxRX4+sMJCNG6f9xtsDO6bdqRS-U6TAYO47OKQjH8bGzbg@mail.gmail.com>
 <20180320023423.GA10143@sigill.intra.peff.net> <CAHnyXxRcwq40W4tKm=Kscrsnb77yh7=eGDE=r5AZq073MPX9AQ@mail.gmail.com>
 <20180320040411.GB12938@sigill.intra.peff.net> <CAHnyXxQMbnNam=oB_B57xDZBaMPRn_8hfKtostHPV6nBHbTBog@mail.gmail.com>
 <20180320044036.GD13302@sigill.intra.peff.net> <CACsJy8BP+ov0jeHp6QZoi=etPDQX5qEFqEfktyA-U-ffUE92vA@mail.gmail.com>
 <CAHnyXxRsqR3A0FpHJwnfOWo29WNx05qWSXfxvmwPv1TUdqm0aQ@mail.gmail.com> <20180321065212.GC16784@sigill.intra.peff.net>
From:   Dakota Hawkins <dakota@dakotahawkins.com>
Date:   Wed, 21 Mar 2018 03:36:09 -0400
Message-ID: <CAHnyXxTf16ukf8CFSfzjQjTEjf5yJXFqK5TnS9KiXZEeAD7dgg@mail.gmail.com>
Subject: Re: .gitattributes override behavior (possible bug, or documentation bug)
To:     Jeff King <peff@peff.net>
Cc:     Duy Nguyen <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> I think that ignoring all of /ignore-most/ is much more efficient, since
> we don't have to enumerate the paths inside it at all (which is why the
> current behavior works as it does).

That's definitely true, but I wonder what the impact would be for most
cases (even for most cases with large repos and larges sets of ignore
files).

Most of my .gitignore patterns weren't hand-written
(https://www.gitignore.io/ is pretty neat), but there are a ton of
patterns like `dir/`...

I think if I were designing it from scratch and knew what I know now
I'd probably argue that behavior should be declarative (`dir/*
recurse=false` or something), but we can't really get there from here.

At any rate, would it at least be a good idea to make the "trailing
slash halts recursion, won't consider nested .gitignore files"
explicit in the `.gitignore` doc? Unless I'm missing it, I don't think
that behavior is called out (or at least not called out concisely/in
one place). It looks like this is all there is:

    "If the pattern ends with a slash, it is removed for the purpose
of the following description, but it would only find a match with a
directory. In other words, foo/ will match a directory foo and paths
underneath it, but will not match a regular file or a symbolic link
foo (this is consistent with the way how pathspec works in general in
Git)."

Also, I'm not sure what the "following description" is in "it is
removed for the purpose of the following description". Is that trying
to imply "excluded from the rest of the doc"?

- Dakota
