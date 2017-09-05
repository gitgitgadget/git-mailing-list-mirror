Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 80928208E3
	for <e@80x24.org>; Tue,  5 Sep 2017 15:09:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751829AbdIEPJn (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Sep 2017 11:09:43 -0400
Received: from mail-qt0-f172.google.com ([209.85.216.172]:36197 "EHLO
        mail-qt0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751386AbdIEPJm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Sep 2017 11:09:42 -0400
Received: by mail-qt0-f172.google.com with SMTP id b52so8186429qtb.3
        for <git@vger.kernel.org>; Tue, 05 Sep 2017 08:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=aerotech.com; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=vz+qbnUdQ90SJa4zFu9G93rE4dMdDFVaG2hquVMbmp0=;
        b=Q4viBghP3KuHLr52x+/Hxf3zvbIygFgSmzgaFq5zxmUvBUI1x/FjW7/jW96Z9fqrZS
         mmwbxDvh3EMXvro6vJt7cfgrZdnTX1NtXhWV4sijPpVGtIVzEYED4ZqON9q2sJyPM9f1
         rAj1deW9HGpLO2JsxoOgR0dMACe3xaI6LQV5c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=vz+qbnUdQ90SJa4zFu9G93rE4dMdDFVaG2hquVMbmp0=;
        b=Y3P1J4lnhET8vicoEB2zuYsWcL9SF5tIFTtyi+VwfuyQv1SEpFrioGZuG2hpVgaQ21
         /ymvNBJlStarFbsM5RwF1Ha8vm3v2OzgxCD53nOpmEcBvfYyJmBrJKWWUVKGBCYZ9yiU
         /aoSG1qnLgrj0nGkzY5QzYuTSSkzgsxA3VTMtS1u09pFBEfkn34sLgf5YCTXxkRyyTI0
         VQyhrV99EpkcdTf4gn4uZGlOp/Ex6US/5uIwVpo2UK/JmYwWot6A7G5ARtZQiDbJngRJ
         1HwhSX7upDkvjKqzkWsr4UUlTrFHd+5pUZXXjNe8/dLLtwjP7LuvtJYNai6Kz1eBBgKi
         kYNA==
X-Gm-Message-State: AHPjjUizYfduZGnUHg+gkjqmdV01Hbf+L/ChzIAakHGjMLNKRhdrxKPU
        Ve1f7QIfOfnQfb3nHVEz9YvUBLnTGfxV
X-Google-Smtp-Source: ADKCNb5l4AQIRML8Kj3/hzwscmJ0rldpC/hJlXxm96JYGEayqv0yfK3pbljlApdQ63XmBfTWxOe7uq0zk1AtAqfUfCM=
X-Received: by 10.200.38.59 with SMTP id u56mr5586443qtu.14.1504624181611;
 Tue, 05 Sep 2017 08:09:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.130.35 with HTTP; Tue, 5 Sep 2017 08:09:01 -0700 (PDT)
In-Reply-To: <20170902083319.lcugfpkkk5lahieb@sigill.intra.peff.net>
References: <CAEVs+za9do_wXC12SSRznF9v9oGw3_Grq2EFDVf8nH1CRgM-Qw@mail.gmail.com>
 <20170902083319.lcugfpkkk5lahieb@sigill.intra.peff.net>
From:   Ross Kabus <rkabus@aerotech.com>
Date:   Tue, 5 Sep 2017 11:09:01 -0400
Message-ID: <CAEVs+zbbWQuM-=5d04bkpTu38Mr4PyczskNhni5K1u_nzh-2Qw@mail.gmail.com>
Subject: Re: [Bug] commit-tree shouldn't append an extra newline to commit messages
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 2, 2017 at 4:33 AM, Jeff King <peff@peff.net> wrote:

> But I am confused by your "inconsistent with git commit porcelain"
> comment. The porcelain git-commit definitely _does_ add a newline if one
> isn't present (and in fact runs the whole thing through git-stripspace
> to clean up whitespace oddities).

Ok I figured out my confusion. The repository I am working with did
commits with "git commit --cleanup=verbatim" thus do not have a newline.
This is why I thought there was an inconsistency.

> So I don't think "inconsistent with git-commit" is a compelling
> argument, unless I'm missing something.

Agreed, but now I guess I would argue that it is inconsistent because
it lacks a "verbatim" option like git-commit has. I would like to see
an argument like this for commit-tree but a clean way to add this option
didn't immediately jump out at me.

> And definitely it does not when taking the message in via stdin.

I'm not seeing this, I see commit-tree as adding a new line even via
stdin (and the code seems to corroborate this), unless I missed something.

~Ross
