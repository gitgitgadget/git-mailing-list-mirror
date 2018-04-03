Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 26B2A1F424
	for <e@80x24.org>; Tue,  3 Apr 2018 08:47:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755253AbeDCIrX (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Apr 2018 04:47:23 -0400
Received: from mail-qk0-f176.google.com ([209.85.220.176]:42108 "EHLO
        mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755247AbeDCIrV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Apr 2018 04:47:21 -0400
Received: by mail-qk0-f176.google.com with SMTP id b198so17751097qkg.9
        for <git@vger.kernel.org>; Tue, 03 Apr 2018 01:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=BkEGd6IbyRtoIghUoe3aTxzmLPhxAlzk+XJqYgfHBVw=;
        b=J44YxJcpZMpbEaPpvE6R4la6iojQ97HEDQUdPv5BkDXSkpbx4mveAmfR4ZkL/rAV3Y
         Z3N2GHZQoHnY+s4bsfq9vglaPCtXAFfoUenIHp8iF6PO+xl6ZVt+126Bq9wEBGHP93Rj
         +/PTPxbFejNDU178/5SPaodL3QiomFFhEpZlUy9dgS90Z3SI0SeKFSZVnYfKEbjZzIwE
         Ofadz+eevEf5eTtd5i7QfiK1YQ7yUdDgQtMB6ktGHAWUwDHCR3BBX/wYYVRH7keo4W/M
         gAhFfXrreO+Te4sKCv9ssV3nEVoEtrWalxA4kZOZMyGVJTn2L3Qj2LAZzHY2cvJO8tEs
         4O+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=BkEGd6IbyRtoIghUoe3aTxzmLPhxAlzk+XJqYgfHBVw=;
        b=XSbtNke7tEm1eyuR5dDmArBljZe7/EH8/5GiMQNr2am1HItY8oJmGxkdoSizwbVnIi
         J9PF5M5iyqVhfRMRC01fu2FYt+0j2L7MOgCmrOazd/g82S0SLqEQqYCr0y+9oTHPufJY
         5GYUMH+LCVFKDXqh0yViV/3vTfqQVq1rpEpIUkvA0YfGoZCh01gzkmn3tJUp3vdm37pL
         7c+NCcz1WE59xAkHdU4uvzanfzhNpATv+SKonzz6jF4j1+qHg5NWRsPZ8fkDNmy741/d
         xDhzhOpEVieB7SZT4f56oswbOd7oXlEQ4sgnNTeXlVvC4A5RWBzgaMEtSC7F8IqyYBxg
         BnBg==
X-Gm-Message-State: ALQs6tAd87JD1Ps2R7tTFd4BV5nuk7DvmaIPqqE9MjumncVcxOIG+y1X
        EHTPJUg7bmwCcLFMe6treOTtUH9AKkX+k8il4xQ9nQ==
X-Google-Smtp-Source: AIpwx48AEnZo9ctVktvSZeyvisY47JAIrErZr/Xdh/s2SP13yfefOtdMu2Mwd0Q4V5+wg9TiySqEvtJ151062xjf9jA=
X-Received: by 10.55.159.140 with SMTP id i134mr17087203qke.220.1522745240758;
 Tue, 03 Apr 2018 01:47:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.174.202 with HTTP; Tue, 3 Apr 2018 01:47:20 -0700 (PDT)
In-Reply-To: <6d28dbb1-0c4c-6fca-555c-afb6c1c9e781@frm2.tum.de>
References: <dfb01281-2ffb-a0ac-a44d-74ccd304a7ea@frm2.tum.de>
 <CAPig+cRTf+WHaSJsLhbPuG0fwd6zkTP_zhwLhB14GdC81xiHRQ@mail.gmail.com>
 <cdec466c-ecc9-b1d7-c637-04e63552c759@frm2.tum.de> <CAPig+cSsTPKoLfcxrgD4+NhXa5AeWynxumo8Zed_PH-q3U163w@mail.gmail.com>
 <6d28dbb1-0c4c-6fca-555c-afb6c1c9e781@frm2.tum.de>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 3 Apr 2018 04:47:20 -0400
X-Google-Sender-Auth: TQn595X9hEzLMfs__yebXbK1NYM
Message-ID: <CAPig+cQ8BsaxaWzSHvytx3aHbFbWjs1V=35PKtQCpwKOWBsstg@mail.gmail.com>
Subject: Re: Test t2028 failes
To:     =?UTF-8?B?SmVucyBLcsO8Z2Vy?= <Jens.Krueger@frm2.tum.de>
Cc:     Eric Sunshine <sunshine@sunshineco.us>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 3, 2018 at 4:42 AM, Jens Kr=C3=BCger <Jens.Krueger@frm2.tum.de>=
 wrote:
> Maybe, the attached patch may help. On my machine(s) it helped.
>   git worktree list --porcelain >out &&
>   grep "^worktree.*/destination" out &&
> - ! grep "^worktree.*/source" out &&
> + ! grep "^worktree.*/source$" out &&

Our emails crossed. I suggested the same in my response (although I'd
add the '$' anchor to both grep's, not just the one).
