Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5746F208D0
	for <e@80x24.org>; Fri, 18 Aug 2017 18:39:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752231AbdHRSi7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Aug 2017 14:38:59 -0400
Received: from mail-wr0-f182.google.com ([209.85.128.182]:37418 "EHLO
        mail-wr0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752204AbdHRSi5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Aug 2017 14:38:57 -0400
Received: by mail-wr0-f182.google.com with SMTP id z91so65067638wrc.4
        for <git@vger.kernel.org>; Fri, 18 Aug 2017 11:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=zKprYoOlgOmLSxPu6irbYpA88vd/kXBujsTHiuBzPz8=;
        b=O/2h1NDu0gvEXoCJNA49a7Zmty6dld5hE9HcHSW00OJUM7zwO6pF3uWhfSpnaU4hxI
         5zw4heckSUooDRJK9m7iFCZB3zxo4d56Ng0pLa5ARFb4jb0BnNj6BjFGIiyGE38ib7EX
         8lzV3Q/AaLCdZvqYngfEiksb0bE1nv/3I7c4rQicJ37vWXdyxdZjRrHmm7aByNNF5v9q
         J2LQXZF6huQweHj2ALRhEKM2xdyh3GrTInbcpMMkBidtYROKHZCGt3b87jeu+UjPfMbZ
         74S4mylvqrH44Z5f+hpf88+ggarehHHgvhy4IMmFkdCliWZuW/JzDOkrQAUbQQzeQSG6
         6sJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=zKprYoOlgOmLSxPu6irbYpA88vd/kXBujsTHiuBzPz8=;
        b=XH3nPoGH4lXP8MpPw/DnZAjJ1Ni3x7Kraoc01tIQr0bcppJT5UC0YuJes/UqPW9wD+
         Xd/tCHFth2lr4ZN7l4Hf6ObXXARmrPeXNboV/7gOkxAC/w+o3jP0JqXMRBpfd/O0sgi2
         pMGk+rJR9bFHur69Jmw8KqX8VxGMwcte2PvJYBJ2noUHbkhQWQPvx4dt3I4p9JBQxp86
         HVvFxNn4NDWql3aEjxeL7jG+d7sRk5oqRSFRuAB9VHRkGiZyfd8zmdoPxdsGpVMLW1Y3
         HP3frKJrG0URiVQpMkCklqT6NAbPSZ3010GdE43M1nSOxpqqK+pWwVhpMdS5KRYZ1FuJ
         hOrg==
X-Gm-Message-State: AHYfb5havfvczcFukiRy2Zthlp4YNky6bbDKPZmdvbWTibAi4s+g8yBz
        gcQVykY0iz+5fNaDYMD9Jyg+ZHfKANubXpU=
X-Received: by 10.223.155.210 with SMTP id e18mr5762317wrc.55.1503081536430;
 Fri, 18 Aug 2017 11:38:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.28.24.130 with HTTP; Fri, 18 Aug 2017 11:38:25 -0700 (PDT)
In-Reply-To: <9a4548f1d0832d036cad152771339d853b5885f3.1503079879.git.patryk.obara@gmail.com>
References: <cover.1503020338.git.patryk.obara@gmail.com> <cover.1503079879.git.patryk.obara@gmail.com>
 <9a4548f1d0832d036cad152771339d853b5885f3.1503079879.git.patryk.obara@gmail.com>
From:   Patryk Obara <patryk.obara@gmail.com>
Date:   Fri, 18 Aug 2017 20:38:25 +0200
X-Google-Sender-Auth: 53Eu9Qf7fl4_seVnOfMfNYYgK4k
Message-ID: <CAJfL8+T3vqnmFJmx19H-v8yGiY4Se78SM+ax_q07_PF4VHDv3Q@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] commit: rewrite read_graft_line
To:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>
Cc:     "brian m . carlson" <sandals@crustytoothpaste.ath.cx>,
        Stefan Beller <stefanbeller@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Actually, I don't think I needed to remove free(graft) line, but I don't
know if freeing NULL is considered ok in git code. Let me know if I
should bring it back, please.

--=20
| =E2=86=90 Ceci n'est pas une pipe
Patryk Obara
