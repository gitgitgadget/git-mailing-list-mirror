Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D65941F403
	for <e@80x24.org>; Wed, 13 Jun 2018 18:00:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935006AbeFMSAX (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Jun 2018 14:00:23 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:40226 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934964AbeFMSAW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jun 2018 14:00:22 -0400
Received: by mail-wr0-f193.google.com with SMTP id l41-v6so3672574wre.7
        for <git@vger.kernel.org>; Wed, 13 Jun 2018 11:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=DLkTKljrWwXs1CAYKX0+7VeaXxL1P+cDtEnA7KizT/Q=;
        b=QxO/W6JutWwh+Kgu70Q9zghXAeITotW3Uj5LpbRUit5i5Cakb+QnyWXC4vrz5uc0tW
         K/9tM2qTulqdMuQwvBegFi1+7R6/EDTDhGGMYBjBsBmeF6wSJrmOSXF4uwI1G3zX5l+n
         HIqTTrhBvBvBZ7H2JE6Y4VRudQRP3lHBV08OFL4v2h5y9UBtePIty6c2mc6qZMCtWNlA
         sMROE8ofc3xQOXGNubhQyK7v7juw4Yy8mbfHqEaB7BCbha7TYKSU0fyAKSVSy20zFRDT
         smKS/Y3M0bgpSzFKJZbv17O0QaqOncNm5cbEkVZ62lLM9cx4ofpgiTbS7HtNcB121hkL
         FlkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=DLkTKljrWwXs1CAYKX0+7VeaXxL1P+cDtEnA7KizT/Q=;
        b=V9C+JarpHimuvfoYXyP+UbCbwy2DC9lb+jm4ccbf6dWieRCtufN5ThaUSJaAtTRNbC
         DkzCSRSesRx1bcgApYpBIi59lI/TZCAsgfZ7pLzqyBNdNZoM4UnAuOldHKuvdFGWBef2
         vGvekCdwBbZZ1033iJkVLiHDgY1r/UpiBwRt8bV0kGBre3DXnSjHUIs96G1EAK+SQtuy
         Uvaaisz6dx4si0ACm2VL33T/c5iwJiS8+4r4FEI3K1eVTHxPqoQzoNQofFYQ77c4NB26
         SvzLF0DeIpr2xZMH02Y9+nkpmoa3lwCNU2cS4RhDku/s2v7hZuWsxO5mEl3Z4RNqwRmU
         +HkA==
X-Gm-Message-State: APt69E3zzhZGzV/Ecx+65YFbqKkTdH9PFZnR+/Tp6rGJvhBH5ND0gV91
        PF9M4NsFPtnXvzmrjUJM4Bo=
X-Google-Smtp-Source: ADUXVKK0eWXslicLYSb8RFzoIpIR/UREEDj9uPH54s182WVDWqxaD2MFarN/0xLxcXWh/6VsBtO95g==
X-Received: by 2002:adf:dfc2:: with SMTP id q2-v6mr4869201wrn.113.1528912820830;
        Wed, 13 Jun 2018 11:00:20 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id q17-v6sm3786185wrs.5.2018.06.13.11.00.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Jun 2018 11:00:20 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH 0/3] submodules with no working tree shall unset core.worktree
References: <20180612235825.12271-1-sbeller@google.com>
Date:   Wed, 13 Jun 2018 11:00:19 -0700
In-Reply-To: <20180612235825.12271-1-sbeller@google.com> (Stefan Beller's
        message of "Tue, 12 Jun 2018 16:58:22 -0700")
Message-ID: <xmqq7en27ej0.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> The first patch teaches checkout/reset (with --recurse-submodules) to unset
> the core.worktree config when the new state of the superprojects working tree
> doesn't contain the submodules working tree.

Are there two cases of "doesn't contain working tree of a submodule"?

The superproject's commit may not have a gitlink to a specific
submodule in its tree (i.e. there is no way to even "submodule init"
with such a commit in the superproject's history).  Or there may be
a gitlink but the user chose not to check it out in the working
tree.

Do they need to be treated differently, or can they be treated the
same way?

Also, is the "submodule" feature supposed to play well with multiple
worktree feature?  Let's imagine that you have two worktrees for a
single superproject, and the branches of the superproject these two
worktrees check out are different ones (which is the more sensible
set-up than checking out the same branch twice).  Further imagine
that the superproject started using a single submodule sometime in
the past and keeps using it throughout its life since then.

 1. if both of these two branches have the submodule, and two
    worktrees both are interested in having the submodule checked
    out via "submodule init/update", where does core.worktree point
    at?  Do we have two copies of the variable?

 2. what if one branch predates the use of the submodule in the
    superproject while the other branch is newer and uses the
    submodule?  Where does core.worktree point at?

Thanks.

> The last patch is teaching "git submodule deinit" to unset the core.worktree
> setting as well. It turned out this one is tricky, as for that we also
> have to set it in the counter part, such as "submodule update".
>
> Thanks,
> Stefan
>
> Stefan Beller (3):
>   submodule: unset core.worktree if no working tree is present
>   submodule: ensure core.worktree is set after update
>   submodule deinit: unset core.worktree
>
>  builtin/submodule--helper.c | 26 ++++++++++++++++++++++++++
>  git-submodule.sh            |  5 +++++
>  submodule.c                 | 14 ++++++++++++++
>  submodule.h                 |  2 ++
>  t/lib-submodule-update.sh   |  5 +++--
>  t/t7400-submodule-basic.sh  |  5 +++++
>  6 files changed, 55 insertions(+), 2 deletions(-)
