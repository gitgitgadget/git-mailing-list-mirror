Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 87D781F5FB
	for <e@80x24.org>; Mon, 27 Feb 2017 21:21:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751672AbdB0VVb (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Feb 2017 16:21:31 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:35636 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751665AbdB0VVQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Feb 2017 16:21:16 -0500
Received: by mail-pg0-f68.google.com with SMTP id 1so2155340pgz.2
        for <git@vger.kernel.org>; Mon, 27 Feb 2017 13:19:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Wef5ZBOIUkOu+CJrpzbRhj1uJ9pa5UHkserv8smgS+4=;
        b=E3XcqZQwGKPOWXjVUaUsAfRVKBVO8/DhldGezLvZcb4r3a8nSk1Gy6Au6ZnC/9mOYv
         WXE4TvhlMgH5n7KqZy5NrDjDf3bmKI1y7FuQF2oWH6AeMVYHTfjErNdgksF5G1aRQqJg
         Y90qEUc8syhb1EMJ75zjJtU8MenxVBPwo3nNmZ3NwROa5CgVR6H2637YbFO8zCUpDcKO
         Y/vngcQwqlIJSpnr07dzdqGrd5ujs3N69DW5+UQGTI2fcZqy5QJW+pb9iiu8bxRz3cz1
         QOYXTbT97Aj79mM9y+LaaGY5o9n7f15LcOJXq3/drE/s+ztI0h3zUaLZA+9xFlUUGPyn
         fnMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Wef5ZBOIUkOu+CJrpzbRhj1uJ9pa5UHkserv8smgS+4=;
        b=nveQ6/yVQ29mYPXuci/TaiDUPNNNgGUlfFygZWCuoLy5xiUnZmuS3jx9EnLClY17lq
         LjPtptFtdQ9KO2CRJHkdnLsZaccr1Fr44kNuuHXWw+lYUX/q2kfekuwogJqE0Fgsp96R
         rO+kvDN6Vdt/ThvFQhuawlSsFLuBn/xWzHBJ0EDX6acnydOooI8wgSEipPBDwN1ChapJ
         OOSJPUrCglcIfP9dJj/yDHRD863V42IzlVzPReG7D3a6MwYiW1cF/okibAvgSvT7monU
         z7nJBdIj6YdOmIqwld7piDqEu2e4IDKMAqhVPyY97aMNENnNTSVaQXb52PdMEksdN4EE
         W9tw==
X-Gm-Message-State: AMke39kpPDkpwvacTfAzzZtWzo8Uv2ip2+QTeDOta/XSWQJA+dYKdVdymuFzMtDYx5nEqw==
X-Received: by 10.99.53.204 with SMTP id c195mr23107079pga.205.1488230370651;
        Mon, 27 Feb 2017 13:19:30 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:c953:ec42:862e:1e81])
        by smtp.gmail.com with ESMTPSA id x2sm32304606pfa.71.2017.02.27.13.19.29
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 27 Feb 2017 13:19:29 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] t6300: avoid creating refs/heads/HEAD
References: <20170227092931.7iquwaxomeuuusi2@sigill.intra.peff.net>
        <xmqqzih7whrw.fsf@gitster.mtv.corp.google.com>
        <20170227205151.rjhod347ddhmdmxp@sigill.intra.peff.net>
Date:   Mon, 27 Feb 2017 13:19:29 -0800
In-Reply-To: <20170227205151.rjhod347ddhmdmxp@sigill.intra.peff.net> (Jeff
        King's message of "Mon, 27 Feb 2017 15:51:51 -0500")
Message-ID: <xmqqshmzuyam.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I suspect there are a lot of other places that are less clear cut. E.g.,
> I think just:
>
>   git branch foo bar
>
> will put "foo" through the same interpretation. So you could do:
>
>   git branch -f @{-1} bar
>
> Is that insane? Maybe. But it does work now.

No, it _is_ very sensible, so is "git checkout -B @{-1} <someplace>"

Perhaps interpret-branch-name that does not error out when given "@"
is what is broken?  I suspect that calling interpret_empty_at() from
that function is fundamentally flawed.  The "@" end user types never
means refs/heads/HEAD, and HEAD@{either reflog or -1} would not mean
anything that should be taken as a branch_name, either.  

So perhaps what interpret_empty_at() does is necessary for the "four
capital letters is too many to type, so just type one key while
holding a shift", but it should be called from somewhere else, and
not from interpret_branch_name()?





