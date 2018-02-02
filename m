Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 817891F404
	for <e@80x24.org>; Fri,  2 Feb 2018 12:59:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751815AbeBBM7c (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Feb 2018 07:59:32 -0500
Received: from mail-qk0-f196.google.com ([209.85.220.196]:33982 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751812AbeBBM7b (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Feb 2018 07:59:31 -0500
Received: by mail-qk0-f196.google.com with SMTP id b76so23735023qkc.1
        for <git@vger.kernel.org>; Fri, 02 Feb 2018 04:59:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=YPv8zsylyAaDDngFL9n30rNng4M7XvMol5rAMfA7qb8=;
        b=lzAfp8aMe5HloD/fj/Yy9HXvp3yA4SGqJaUPibWNvJ1BHs5XvQr5d3u0tskR1Ejaq6
         lo+cN6WJguuc6NLD17XOEkyydT7wOEvtsFkPUPF0vVGNVGS1u8v5Brp1h8Utac0XZRD1
         v30xZoLfvsGjk4fpPkoJhTfORI8B2338Xfwz3xcRsHKKz7EwomWyuLJgJy6WTGLGfrMZ
         b/k0xcAYlBZWH/gFndB+UCbJkNV0esPUHq8TcF8qGTdwCYgk5jIAWrWggTDeEd6KOOVt
         dsqfxu2K5YXJgAvisVv6xopLthRDCzlnjeIEWJm0ljXGDxy/55LLI6IXn5bqWNfYgnkX
         m5AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=YPv8zsylyAaDDngFL9n30rNng4M7XvMol5rAMfA7qb8=;
        b=GKDedfXafnfvWf4xhuvEkf+asQjbmAdHHJ+lFzmuRa3+wsOJuF2rJRTr1vOEd/zD8B
         SM/+eJh4zgykkTgXI3n1fdjiwgix5tJPu4F0uX2w9ttVTRrVLKfrVc5MdelYXBPPjy+6
         RDPqpN/AefFGY8YuhTbIp2YGQgRvmb5YvB+3aj9/6QiZQO/ZFh/uGmc0+8QAyJLS3Cjm
         9IPbv9D6U5pvjcbIL0cJOOgTuvXOhNCtZ8Wn38jKBHIa262maJ2WCcf+kZx3LItbNep3
         vdBTNG5lw2C/ipmHmAwtg6cuxF0kq8Ym/JbbYpgE/Bc9inJLC1KwS/KC/8i320a8eNca
         3fjw==
X-Gm-Message-State: APf1xPDBLMNqDACDt14n6nOfG3Z/tLQ5J16MGrZ+s32AVZ7KfU2uSt8Q
        Tf6w5PBnyd8odnnx0KNtcOU17nYT1GNOfAu+gBw=
X-Google-Smtp-Source: AH8x224YHPpbPXAoF6WAYSmUmrTG5IqWI/udyaZ96NGYpR/xbrXniIm5gLLzhW2gsEMXnMSsPRIv8ZyeCT1hT+M4ezs=
X-Received: by 10.55.27.77 with SMTP id b74mr9055731qkb.212.1517576370536;
 Fri, 02 Feb 2018 04:59:30 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.175.239 with HTTP; Fri, 2 Feb 2018 04:59:29 -0800 (PST)
In-Reply-To: <20180124095357.19645-8-pclouds@gmail.com>
References: <20180124095357.19645-1-pclouds@gmail.com> <20180124095357.19645-8-pclouds@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 2 Feb 2018 07:59:29 -0500
X-Google-Sender-Auth: 1AiV0uEfp5tj0SGXsRzDSPlHW1s
Message-ID: <CAPig+cR=kPhRuY=2NPFsPcVOby90bf+zS_hJ_60H+2QTQgjfcQ@mail.gmail.com>
Subject: Re: [PATCH 7/7] worktree remove: allow it when $GIT_WORK_TREE is
 already gone
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 24, 2018 at 4:53 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =
<pclouds@gmail.com> wrote:
> [...]
> - $GIT_WORK_TREE _can_ be missing if the worktree is locked. In that
>   case we must not delete $GIT_DIR because the real $GIT_WORK_TREE may
>   be in a usb stick somewhere. This is already handled because we
>   check for lock first.
> [...]
>
> Noticed-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.c=
om>
> ---
> diff --git a/t/t2028-worktree-move.sh b/t/t2028-worktree-move.sh
> @@ -116,4 +116,12 @@ test_expect_success 'force remove worktree with untr=
acked file' '
> +test_expect_success 'remove missing worktree' '
> +       git worktree add to-be-gone &&
> +       test -d .git/worktrees/to-be-gone &&
> +       mv to-be-gone gone &&
> +       git worktree remove to-be-gone &&
> +       test_path_is_missing .git/worktrees/to-be-gone
> +'

Perhaps there could also be a test to verify that a missing but locked
worktree is _not_ removed?
