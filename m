Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7848B1F453
	for <e@80x24.org>; Sun,  3 Feb 2019 09:12:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727368AbfBCJMC (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Feb 2019 04:12:02 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:38155 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726812AbfBCJMB (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Feb 2019 04:12:01 -0500
Received: by mail-qt1-f196.google.com with SMTP id p17so12502944qtl.5
        for <git@vger.kernel.org>; Sun, 03 Feb 2019 01:12:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T7fyC2EPKDe+BMQaDL1Npe8DsmkynP2bKG9ePs3sBtw=;
        b=lT/DS2vzc1yxqzi2x9gygIIo1OheIdC+4iAAEwRkyz79UEIroMwk62LogPf/m7q1YZ
         Bi86QCvAT7dA22fK00TCW8nyl4ZaORetXU/7/SrNvBi+oGxhG5OAwLphb0o2B8Jwq0gV
         W/Lg0HYdtctcUxLj6MCEU5OKNoBtN7a2Lc1PdHlPNxrC6K3sJJr6aIZhkKyHs1R46WWd
         1+IOwTS0ltLunbM28vp7Lg6fcJa2y1ajsic4vRUZmocM+/Ig4RCxEaXVDsVPcx2CH9m8
         ElsZkHuxBI9fFNobTgLw++X9xcTSX5Ze6j2Caqb7J+awz1/gAg+brmpSYpCEvwq/ETLL
         p/AA==
X-Gm-Message-State: AJcUuketxjeytDjA1E50k9W/Ri8j3g/mcDj+4k7tH8bGAF62W/o6O9Xw
        KlvYMSN5TnashONhIaLMbb28lyxhrC2w5bX3jXSdMg==
X-Google-Smtp-Source: ALg8bN68lqWyvwxBJUS4dhWE7+J9J6/j8WPu+nwFCowRR0xtqvDDzpcr/04AmB733Mko+h3dIEiiTKzaHEhABpqBazs=
X-Received: by 2002:ac8:90c:: with SMTP id t12mr44862934qth.335.1549185120966;
 Sun, 03 Feb 2019 01:12:00 -0800 (PST)
MIME-Version: 1.0
References: <20190203083545.5877-1-martin.agren@gmail.com> <CAPig+cRN_Jw_vj5=RWZJWp-Wn6-=Vd9oZKQieMWJ02TjAHWwWg@mail.gmail.com>
In-Reply-To: <CAPig+cRN_Jw_vj5=RWZJWp-Wn6-=Vd9oZKQieMWJ02TjAHWwWg@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 3 Feb 2019 04:11:50 -0500
Message-ID: <CAPig+cQYuwMmyw8_p863BeSU5RP-xdB=HFMa7EM4G3YALQj3_g@mail.gmail.com>
Subject: Re: [PATCH] doc-diff: don't `cd_to_toplevel` before calling `usage`
To:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Feb 3, 2019 at 4:08 AM Eric Sunshine <sunshine@sunshineco.com> wrote:
> I wonder if a more fruitful, longer-term fix which would save us from
> having to worry about this in the future, would be to make
> git-sh-setup.sh remember the original $0 before cd_to_toplevel() and
> then employ the original value when usage() re-execs with the -h
> option. That would also avoid the slightly ugly repeated
> cd_to_top_level() and 'tmp' assignment in this patch.

By "original $0", I meant a path which would be suitable for
re-exec'ing (which wouldn't be the literal original $0). Sorry for the
confusion.
