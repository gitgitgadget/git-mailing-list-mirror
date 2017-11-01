Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B52F202A0
	for <e@80x24.org>; Wed,  1 Nov 2017 17:59:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754712AbdKAR7K (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Nov 2017 13:59:10 -0400
Received: from mail-qk0-f178.google.com ([209.85.220.178]:55496 "EHLO
        mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754643AbdKAR7J (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Nov 2017 13:59:09 -0400
Received: by mail-qk0-f178.google.com with SMTP id x82so3687866qkb.12
        for <git@vger.kernel.org>; Wed, 01 Nov 2017 10:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=RUJIu4z9mZ7inPhJk8G0w9eKnKT3uS19CNJSjyMB2Us=;
        b=NV4OgrexTOojb/oDDFYppjueTXaMzlPJeGBB7xa0xrItxv7435+KlP6yET7r9rvgj/
         PCh2Tmi8nnLECwoK30gusjt9tj4VwjOAVjn+nGQJd3uMB96TrQC4c5BiW/gF76qcY7Sd
         7+9pEFi+OlZ9a2z0ZDXy7Qn9+Yo0Gi8EPW/C1sBSG//ftgGdIB6hmikRgJg6sehqakLI
         LxsSSpew+yu191uqAA9zGlLjbo0/nKbix71V7IHhQiDPeeiVNkiezDbaIT7O0/7fckhH
         0R8j0yVWeH+6yzbdOI6sZOFduNy8IflgkiUU4uc9Obu7sKfhToI+OdbpspcJAyL7cIqV
         STsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=RUJIu4z9mZ7inPhJk8G0w9eKnKT3uS19CNJSjyMB2Us=;
        b=rH0fqGBj39/DNQojvDrTnHRDdV8BXwXK1CDiQrmrKNS4vduuiKX+C1I4nx78A5MTzY
         zexPnZWczpcmuliYuGCbY7YcmEW7i40TW2xpJE8E0HJyxwFRGBlgm18ezBzSs5qLR1eA
         SNLgfaaw4cqGifmWoIAZYDA5Fa/VrJS8/h+us0bXEWKd1q2L/v1oGO+FmctAkNJfnsnN
         qxeir0nG5Xy6LLmoos9gjp9TrFrS5JwSyCTgSagBT7VAYVPDLSFZ1CGjpDqe0qxLeZJF
         B2ykpVYjyw9mSXcgG1vSjVeekv33XRdOYA10kV1JooZd185rpqoVVCvLgrGtuKF0hDJU
         JYkA==
X-Gm-Message-State: AJaThX4ZIt5JtcEB4+mbVrOO5NFfx1ZnSGOog6NgWz5amLiPx+JjgERf
        b3ksoPL46O+Y1qMENTjScygD4YsblZSwf9Xxbxasgw==
X-Google-Smtp-Source: ABhQp+Q+DtFgN/y5aKnlLNLbLoXcec1yC/cq/HcEwCojnaCxwrGO0bDLXra0Bcj3PSYlGkkpLWNtc/wJxC/cQ2H1Q/c=
X-Received: by 10.233.239.140 with SMTP id d134mr1055558qkg.308.1509559148514;
 Wed, 01 Nov 2017 10:59:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.70 with HTTP; Wed, 1 Nov 2017 10:59:08 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.21.1.1711011329300.6482@virtualbox>
References: <20171031003351.22341-1-sbeller@google.com> <20171031211852.13001-1-sbeller@google.com>
 <20171031211852.13001-7-sbeller@google.com> <xmqqbmkmvdrq.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.21.1.1711011329300.6482@virtualbox>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 1 Nov 2017 10:59:08 -0700
Message-ID: <CAGZ79kZPNiNnSJd6CNYb7XkTVsT2ONLQLhwAQxt6_SPFTSwMcw@mail.gmail.com>
Subject: Re: [PATCHv2 6/7] builtin/describe.c: describe a blob
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
        Jacob Keller <jacob.keller@gmail.com>,
        Kevin Daudt <me@ikke.info>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>> Does the code describe a9dbc3f12c as v2.15.0:GIT-VERSION-GEN, or
>> would it always be <commit>:<path>?
>
> As the blob is described using this function:
>
> static void process_object(struct object *obj, const char *path, void *data)
> {
>        struct process_commit_data *pcd = data;
>
>        if (!oidcmp(&pcd->looking_for, &obj->oid) && !pcd->dst->len) {
>                reset_revision_walk();
>                describe_commit(&pcd->current_commit, pcd->dst);
>                strbuf_addf(pcd->dst, ":%s", path);
>        }
> }
>
> i.e. as `describe_commit()` is used on the commit part, the answer to your
> question is: the former. I guess that is why Stefan wrote `commit-ish`
> instead of `commit` ;-)

$ ./git describe a9dbc3f12c
warning: reflog of 'HEAD' references pruned commits
v2.15.0-7-g980e40477f:GIT-VERSION-GEN

So as noted below, this output is less than ideal, but technically correct as
v2.15.0-7-g980e40477f contains that blob as well (you don't have these;
it is this very series consisting of 7 patches on top of 2.15, none of them
touching GIT-VERSION-GEN, hence that blob stays intact.)

The way Junio asked, we actually may prefer the commit-ish to give
that commit that introduced the blob for the first time, i.e. add the
--reverse to the graph walking.
