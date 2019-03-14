Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4BC2D20248
	for <e@80x24.org>; Thu, 14 Mar 2019 05:05:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbfCNFFK (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Mar 2019 01:05:10 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36194 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726303AbfCNFFJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Mar 2019 01:05:09 -0400
Received: by mail-wm1-f68.google.com with SMTP id e16so1375499wme.1
        for <git@vger.kernel.org>; Wed, 13 Mar 2019 22:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=2JdWncGIw1FSPyhZAiKzW34tiCpqSZQW7pLauUXr1YM=;
        b=i+P3i/7RDgucgYzoL5JMvxy8rAWqbJuPmI8Eybb9eUZ2jGbK7dWqGg4uQMyB7dq4Up
         40T7Y2kC0O3HLKXTG3L0HUH/AI6hnrCEfSlIEbjR4CKYwmdc+zmIdmIbJk7zDkYrw7bd
         8YiS1DefyuT27/2w2ecwyysalOhwxwy0ZDNrNOVT/bepG0TvAIjrJof10iP+7L0ItQog
         x5e95XdDgsNdhsHds2nHiKOUiMqRpCDKLX+11UXfbgokHkdgJVVbMWe2y41gOtFPIgN8
         KtSo+7/5Ct2wVfF5zcDtI/FNAFIQ//PhQlZPmShgtAjBhlvj1D/7I3Ab4B03xygQyWXs
         vp7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=2JdWncGIw1FSPyhZAiKzW34tiCpqSZQW7pLauUXr1YM=;
        b=o432lUm/r8aRuqx2kRir9TG30trm47NvbtbGu+R/rVeeLrm9uv1Ns+oWTQ2HQf3aG9
         0O6s+AWp2+SHRuDFZZU++PkpaDwAeXD2aNqcza61uCoPzyAfWCBET1/8DB98cvLVoMcQ
         KS/TTVsBHp8+azD7sdCLKjchzx4DhMzDSnRzBnD7RKq1bSygTKthHnLo0dDB3HDkq/DW
         fyGBijH0N/357g+HH73Y1v/AxWLkJDeO7PSfh7dYgsXSenYX0DZpomSE5csFudK0uhWl
         +/Atm5h8iY3TBh597jl/DM6cLv27S1MAY0v4OnQk6yVdiqB49i+2ieRu49soEQjvQwMV
         TtwQ==
X-Gm-Message-State: APjAAAUzVqa64BKWQXUVJxA00LsPkyxi1rUw/H7Aypjg1+QZc9bRifC+
        vubp0WKyuf9N/yuKLeXvxIs=
X-Google-Smtp-Source: APXvYqyGShwgqhBdCHSySc0JwUSSIN06MRore4BQ507MnTecImTiW+y8DD7JAGRqHw2oVWtoPHqgOw==
X-Received: by 2002:a1c:f502:: with SMTP id t2mr973148wmh.124.1552539907518;
        Wed, 13 Mar 2019 22:05:07 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id l1sm2681815wrn.65.2019.03.13.22.05.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Mar 2019 22:05:07 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 1/4] rebase: document --rerere-autoupdate
References: <20190313182756.8076-1-phillip.wood123@gmail.com>
Date:   Thu, 14 Mar 2019 14:05:06 +0900
In-Reply-To: <20190313182756.8076-1-phillip.wood123@gmail.com> (Phillip Wood's
        message of "Wed, 13 Mar 2019 18:27:53 +0000")
Message-ID: <xmqqef7a9hbx.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> This option was missing from the man page.
>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---

Looks good, but I do not see what the point is to have 1-3 as three
separate patches.  It does make sense to have 4/4 as a separate
step, though.
