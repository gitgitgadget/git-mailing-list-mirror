Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 84F3E20248
	for <e@80x24.org>; Mon, 18 Mar 2019 11:05:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbfCRLFg (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Mar 2019 07:05:36 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:43031 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbfCRLFg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Mar 2019 07:05:36 -0400
Received: by mail-ed1-f68.google.com with SMTP id m35so13105707ede.10
        for <git@vger.kernel.org>; Mon, 18 Mar 2019 04:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=rvPWZmjnvdlrRLwqJyNDasw+Z8XS1vV8BPgcr4FVRnQ=;
        b=kmRF5B55Q9d972Lw5mj6gX0gstoyw2JWLw4U/JBTictIWqmOyu3AOEi1ptmAe8a3j4
         txlX0+jvYkj6EleK1VcAlurJp1C0tLonRoslq1TaKQk6EXTKkz1jcKe+oEMmnvGlIKpm
         7vS+8j7QiZun8YAY9GxVtO82hCGAfLlBU5TotIwXiAuViHPM+nCEger1X+0/g8SZMvMx
         pw0Nu1yhACmd9wvRw8Yij1ZdVrYUdIAoGnG5yrOtqUy5gsx5w22DZkGCTDp7/wXUkMv4
         tdTBYF2QE57jempwmV7Ix1o3rFjfoVE64Tmys0ujFsDv8Ppdd3Ll26vg7bpErkjvHPQB
         xxSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=rvPWZmjnvdlrRLwqJyNDasw+Z8XS1vV8BPgcr4FVRnQ=;
        b=b+HUdvuM9c+a/IAJenGCnwFbdtw8444HwLy3HYJ4FkQlBwDGHDiShtefa8snZcxlLp
         lsdimVQC0MtmqVgcRkX/Nzrd6Zlds10FDJvyKTkqYrFs27pmKRbLzeHWIjhTKQBYLMuO
         ekYAv4irEycJudsQC5utyw6x5r9anD3/PJXgn5AEt5nc3gWtaZ060YSRZ/k3UaHYBN//
         vdpE0XjGOtE373RXxAPRtX+6hUNbBNZjheB5q12HPOXQvBPo2HTSinrWyzPZXNwedqy4
         8DIFkj09k7cfehREjPnRLnLUMq7KaPT5sGa1V3zXmBORQrKCzhYD7J58cvAc18IYzDez
         4dXA==
X-Gm-Message-State: APjAAAWXudL6zKKaq+6cDS0u3QQh81WOSBwt9zsERImkGqtLY1jBdEeT
        aq8os6OXcHHvKbVm25D01yn/QxVrkg8=
X-Google-Smtp-Source: APXvYqwKbs1xWQhdns7x7qfxiizD1isiEHOrj7NoyCze/u/PIl/k0G6wvp1e7ySrz8x/RHE/ldp1iA==
X-Received: by 2002:a50:e8cc:: with SMTP id l12mr12119102edn.125.1552907134434;
        Mon, 18 Mar 2019 04:05:34 -0700 (PDT)
Received: from evledraar ([5.57.21.49])
        by smtp.gmail.com with ESMTPSA id e4sm1836494edm.86.2019.03.18.04.05.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Mar 2019 04:05:33 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Ben Peart <benpeart@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] Fix fsmonitor after discard_index()
References: <pull.165.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <pull.165.git.gitgitgadget@gmail.com>
Date:   Mon, 18 Mar 2019 12:05:32 +0100
Message-ID: <87ef74a1dv.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Mar 16 2019, Johannes Schindelin via GitGitGadget wrote:

> It was reported by =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> [https://public-inbox.org/git/nycvar.QRO.7.76.6.1903142058130.41@tvgsbejv=
aqbjf.bet/T/#mb8718fe52e4721dacd3b143a09187ff9090ef4e3]
> that there were problems with the fsmonitor feature in conjunction with t=
he
> newly built-in git stash/git rebase.
>
> The culprit really is that the fsmonitor flag that says whether it was
> queried already was not re-set after discard_index() was called by mistak=
e.
>
> This fixes that, and apparently also other long-standing fsmonitor issues.

I've added this to my internal build & now the test suite passes in the
fsmonitor mode without any test skipping.

> (Note that there is still a flakiness around t7519
> [https://github.com/git-for-windows/git/pull/2127#pullrequestreview-21501=
0574]
> where it tries to make sure that the fsmonitor hook can prevent unnecessa=
ry
> lstat() calls, but that seems to be unrelated to this here bug.)

FWIW Since February 1st, 2018 I've run my builds on CentOS [67] through
an GIT_FSMONITOR_TEST=3D$PWD/t7519/fsmonitor-all test and have never
encountered this flakyness, and I built pretty much on every "next"
push-out.

The fix sounds good, just one data point on the rarity of the race in
practice. I hadn't noticed this being flaky.
