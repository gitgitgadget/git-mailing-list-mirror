Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A04FDC433EF
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 05:21:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 884EF60F92
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 05:21:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbhIJFWt convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Fri, 10 Sep 2021 01:22:49 -0400
Received: from mail-ed1-f41.google.com ([209.85.208.41]:33297 "EHLO
        mail-ed1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbhIJFWs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Sep 2021 01:22:48 -0400
Received: by mail-ed1-f41.google.com with SMTP id s25so811106edw.0
        for <git@vger.kernel.org>; Thu, 09 Sep 2021 22:21:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9CjACKRx2Y73yIXSmlLUa/QE9/62ZoIjqgKPas4Rkl0=;
        b=nk5kKa/m9TV/27iS8USY/vreQ88SluX+5bZxqj7MEKwb+2B+JoRYjzjBiKJsV2XRX4
         baRlTzat8Q8xk8TcFkt364Bo0D9I5GPgoL3qWcoxROIos+JP0emk6GoR++Y2wRtBsE/Y
         RM8wVQiRwmhpz8pkwJqfY52KgbaSSs+gKUtW98NW4WLKjJjoLVNGdTYURiMqN+5IRY2z
         0d1V9paByJH5TvBjqNPDTY8oNvE3HLLL+arcNH+EpYrkV4DBCUQBgrlVjgsY1C5Kjo/u
         axtvI6MN3VKnL9ykIyVCrV/ecy4oVH2BVlWSLWrWmANt2CkhwaHYApbWeqNHTV0KNjNY
         95/Q==
X-Gm-Message-State: AOAM531sCoQIzMgRn/ZGqfOPGqLe/EifadeLUjNOWTxboWriSLj4BSLH
        VTPPileGxlLrj5xpj4LajXDPAuqzOY0EWubWw+Q=
X-Google-Smtp-Source: ABdhPJx/zoOrjFZBhkThKNhMG+te2Q9MkFvXyQXjKvo7k4dyMhJZdf0AdGJA2n03oOYUQty+qIVw8U7oCx4o8QPWYq0=
X-Received: by 2002:a05:6402:2686:: with SMTP id w6mr7036458edd.231.1631251297412;
 Thu, 09 Sep 2021 22:21:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210830072118.91921-1-sunshine@sunshineco.com>
 <20210830072118.91921-4-sunshine@sunshineco.com> <xmqqwno2505w.fsf@gitster.g>
 <CAPig+cQ6FA0rUnkkTDRUD5vAD3cDXW9vtR1oX0pUJK5eJB9CHg@mail.gmail.com>
 <xmqqeeaa4y0v.fsf@gitster.g> <CAPig+cQdXp0c+JYthvy+bbr6vLR7nq4pQY3w+CADUtzr+Ang4A@mail.gmail.com>
 <CAPig+cTFbnrPPSZbzihJ9gdGV2c4poXWyNjhK3mnr5_uRwpxbg@mail.gmail.com>
In-Reply-To: <CAPig+cTFbnrPPSZbzihJ9gdGV2c4poXWyNjhK3mnr5_uRwpxbg@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 10 Sep 2021 01:21:26 -0400
Message-ID: <CAPig+cR5Gm0Jq24EbsuaU2NV4uaT61CcYzE_yyR81OrOw1h3vQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] notes: don't indent empty lines
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 10, 2021 at 1:18 AM Eric Sunshine <sunshine@sunshineco.com> wrote:
> Have we made a decision about whether this patch series -- which
> avoids indenting blank notes lines -- is desirable? Or are we worried
> about backward-compatibility? If we think there is value in this
> series, then I can re-roll with Ævar suggestions. If not, perhaps I
> can re-submit just patch [1/3] which makes a few tests less brittle.
> Or, since those brittle tests aren't necessarily hurting anything, we
> can just let this series die.

I meant [2/3], not [1/3], as a possibility for a standalone
re-submission. That's the patch in which a few tests in t3303 and
t9301 which care only whether notes are present (or not) are made less
brittle by removing dependence upon the default output format of
git-log.
