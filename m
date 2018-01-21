Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A28FB1F424
	for <e@80x24.org>; Sun, 21 Jan 2018 01:19:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756759AbeAUBTk (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 Jan 2018 20:19:40 -0500
Received: from mail-qt0-f194.google.com ([209.85.216.194]:39708 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756745AbeAUBTi (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Jan 2018 20:19:38 -0500
Received: by mail-qt0-f194.google.com with SMTP id f4so12825190qtj.6
        for <git@vger.kernel.org>; Sat, 20 Jan 2018 17:19:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=Cr2umZo1mXSfGCrcr3qfKj34WcH+PuEv3zWGYTIBT2w=;
        b=OaS4wL8LhxAQqS9gaUyBFNvdHG4vZhQg5WfKmIkJOuaN71h9X/01aaylFx4tjT5ctA
         BVH44IyAL6SEl7O4dPn2O4pQwWcPIikpD/oo7As83Mki9XX3UaizERtoHOWkAkI/ywXN
         u40cxX4eIOQ+51IGo575GmbwbR2AvxIHwxMxStEbNBuKjLMwpduk3tVcqhYmPUvKCl1Q
         H04ifLo8BId3mx5co9UwxyvprW6YstNMPKO6TX/cc6H3jRH87IEpcLPeMncTs33elyif
         cNXLWOEfrJONpy7aTwPMTcoiEw7xx43JSwczYp0sPOZYOS5QsfqDfHDvxGR50vW+i91e
         9tzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=Cr2umZo1mXSfGCrcr3qfKj34WcH+PuEv3zWGYTIBT2w=;
        b=hv5MPpXAn42l+vFylq9s75EOkiugP4eoIrC6BBAF4u8pTWdi+l3+6Ddfcw3gjh15+o
         iv97rSPGgKW2kqLwNREJrvSqB0LkS7HpQAids9v9VT+xHdj4r9D242wMhzmH9mNidaU0
         J6/MF3peppGYHdTCkVT9kDjTN5qnO14ZMn7Bj49evMEaxEIDpuA69vKjvgrWltTkZjMU
         Xdn25EoZQO6ZHFmN8ysUDgwHgv60mkSl4fE2jFKP2T06Apghu8tTG9XfVSYSPaFwkuAN
         mlt0B8Fokl5IqCGVdcO3S7m3htK/+7D5d/A1n1yQEzZN6r0UBb7FDMS382HMtams/iZE
         tcZQ==
X-Gm-Message-State: AKwxytcX0+ctn0gg3L0ti1Uh9A2DVCl7FlZouSb7CaB36sqcdp6XwRDf
        U0sLzYymcy8yx1J2JNxrZiScAom8hzb8reogN3M=
X-Google-Smtp-Source: AH8x224flSgu4NbRZ9aspXaEs6Qn75bB5RvIFBcVDjjnUe13NWWGXr5NGyvVA6fe1foUURH0I7JvPAKiLxVGT4tTvjY=
X-Received: by 10.200.27.91 with SMTP id p27mr4577631qtk.254.1516497577980;
 Sat, 20 Jan 2018 17:19:37 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.175.239 with HTTP; Sat, 20 Jan 2018 17:19:37 -0800 (PST)
In-Reply-To: <20180120203324.112522-1-sandals@crustytoothpaste.net>
References: <20180119041825.727904-1-sandals@crustytoothpaste.net> <20180120203324.112522-1-sandals@crustytoothpaste.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 20 Jan 2018 20:19:37 -0500
X-Google-Sender-Auth: LSXs5q6W7oqP8eIjs4jV-Msq63Y
Message-ID: <CAPig+cQWRRO+gh8oep+zJQdvc-L+sX8QaanCoYuNXvxdiK=QcA@mail.gmail.com>
Subject: Re: [PATCH] t: add clone test for files differing only in case
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        =?UTF-8?B?0JDQu9C10LrRgdCw0L3QtNGAINCR0YPQu9Cw0LXQsg==?= 
        <aleks.bulaev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 20, 2018 at 3:33 PM, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> We recently introduced a regression in cloning repositories onto
> case-insensitive file systems where the repository contains multiple
> files differing only in case.  In such a case, we would segfault.  This
> segfault has already been fixed (repository: pre-initialize hash algo
> pointer), but it's not the first time similar problems have arisen.
> Introduce a test to catch this case and ensure the behavior does not
> regress.

I guess you'd probably want a "From: Eric Sunshine <sunshine@sunshineco.com>"
header before this paragraph.

The patch itself looks correct... ;-)

> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
> diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
> index 0f895478f0..53b2dda9d2 100755
> --- a/t/t5601-clone.sh
> +++ b/t/t5601-clone.sh
> @@ -611,4 +611,17 @@ test_expect_success 'GIT_TRACE_PACKFILE produces a usable pack' '
>         git -C replay.git index-pack -v --stdin <tmp.pack
>  '
>
> +hex2oct() {
> +       perl -ne 'printf "\\%03o", hex for /../g'
> +}
> +
> +test_expect_success 'clone on case-insensitive fs' '
> +       o=$(git hash-object -w --stdin </dev/null | hex2oct) &&
> +       t=$(printf "100644 X\0${o}100644 x\0${o}" |
> +               git hash-object -w -t tree --stdin) &&
> +       c=$(git commit-tree -m bogus $t) &&
> +       git update-ref refs/heads/bogus $c &&
> +       git clone -b bogus . bogus
> +'
> +
>  test_done
