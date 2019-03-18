Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 31BBB20248
	for <e@80x24.org>; Mon, 18 Mar 2019 08:07:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbfCRIHJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Mar 2019 04:07:09 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37763 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726454AbfCRIHI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Mar 2019 04:07:08 -0400
Received: by mail-wm1-f67.google.com with SMTP id v14so3130212wmf.2
        for <git@vger.kernel.org>; Mon, 18 Mar 2019 01:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=cJlG3cM3w5bw/8TDQlNm69v0E8PelMSsQtudbq08VgI=;
        b=ZWCmHX9Bu0gzVjFy6f7z0M9XzR/T5x7/z7Zg/xFrBoaA7iusycIXR+dsW9/zL3UXVn
         zYFFuONFGQUMmWH6V6ogEzjRDwuz94TuUJcuxDosCHTDo3d/kSEjXjLOsMMQRgOxLXps
         M9zqGCjAYE75dtJE4XMjJaUOZNnIXxshfAdHsytV3OyrN/aHty7GBuy33gskhv1Uctav
         Syy2+N/kMFWKwW215Xs3b0skHOVCkjgwuk6qJGt+5b8ifMgT1kZhwBWQqylzMHPScmPd
         b1tFQDYGoa+psyFtpD2KZCjjSRS+4OaLLO1qSMPwPLM/IcvMc+t8Ty4CTzNRxy9Lb/EA
         I5zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=cJlG3cM3w5bw/8TDQlNm69v0E8PelMSsQtudbq08VgI=;
        b=Rj8bvS+fgi1kaJ+SAFUWkW/renWe4SNIUUjA7L1e1JV8Ber0mT6Oxg2baRJZT90h0W
         GM6zRN0qPlcDyi3yTGrlbPv/252WJJUskbzeaXTgFJVXcu2uJUc8dj1JE1R3iJFG+XYg
         9LEgeiuxRFfeYn8sKSyfgjr+bE39w+3VDVTS+AHtCtkzrnpYk9IsBKT/Ekq4uNCf7LZQ
         BQ08u5P9ycuOXUbjva4H3Gxxn/aQ6yS1n16DjzQO4RqhCe99+9gfg+TMF39SOr9+n04/
         9Pe0hdC11+D3OSQ67ng4d31Ce9+bmSoW9bdxg2p6IlRRySkcAPdxAbaCl2eGdKjLv3Pv
         II8w==
X-Gm-Message-State: APjAAAVW6sNf6R2MieZA2u4TiF7kWfAGlRpIdv1dD+jy2jrqhttLmvsL
        Ak3GDYmtAVbA+AKWMVP4JHs=
X-Google-Smtp-Source: APXvYqw1tUvuHO91TbPxbyz42ZN6JccmfHZvIJHCH2wjTcW7uwFBOMTqw3W2qcO0LJKZOFTzu4w5Lg==
X-Received: by 2002:a1c:64c1:: with SMTP id y184mr10117175wmb.0.1552896426714;
        Mon, 18 Mar 2019 01:07:06 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id v12sm6536326wml.29.2019.03.18.01.07.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Mar 2019 01:07:05 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: separating regression test patches from fixes, was Re: [PATCH 3/3] cherry-pick --continue: remember options
References: <20190313182615.7351-1-phillip.wood123@gmail.com>
        <20190313182615.7351-3-phillip.wood123@gmail.com>
        <nycvar.QRO.7.76.6.1903132344350.41@tvgsbejvaqbjf.bet>
        <xmqqimwm9hh5.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1903141432000.41@tvgsbejvaqbjf.bet>
        <CACsJy8DCZLNNa9zFj04kPx=f1S_5VJqqP_qTK6QYJ0fFmusymg@mail.gmail.com>
Date:   Mon, 18 Mar 2019 17:07:05 +0900
In-Reply-To: <CACsJy8DCZLNNa9zFj04kPx=f1S_5VJqqP_qTK6QYJ0fFmusymg@mail.gmail.com>
        (Duy Nguyen's message of "Thu, 14 Mar 2019 21:30:53 +0700")
Message-ID: <xmqqtvg0zjva.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> .... One of the problems I
> have with separating tests from the actual code change is the
> description of the problem often stays on the test commit, which I
> can't see in git-log if I'm searching for the code change.

In the message you are reponding to, Dscho made it sound as if I am
reviewing only from my MUA, but most of my reviews are done after
the patches are tentatively applied (it is a separate issue if the
result is found worth keeping and merged to 'pu'), so our workflows
are not so different.  It is not like "must have them separate" is
the need shared among those who prefer to review in-tree.  I do not
want a logically single patch split into two.

And I find your "find the other half" of a pair of patch that is
artificially split into two a real problem for me, too.  If you
split a single patch into two, depending on which half you find
first, finding the other half is either trivial (as you can just
follow the parent pointer to $THAT_THING^) or hard (you'd need to
have something that binds everything together, like 'pu', and grep
for "git log ..pu" trying to find what its most relevant child is).
