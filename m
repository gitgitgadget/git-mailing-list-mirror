Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B3B21F597
	for <e@80x24.org>; Fri, 27 Jul 2018 16:08:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388739AbeG0Rau (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Jul 2018 13:30:50 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:55856 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388568AbeG0Rau (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jul 2018 13:30:50 -0400
Received: by mail-it0-f68.google.com with SMTP id 16-v6so8231466itl.5
        for <git@vger.kernel.org>; Fri, 27 Jul 2018 09:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7bi4qlEi4C6lbFqAKk71u2Dpld/aoPo9GHkopgQASng=;
        b=h5adQT52ztRKyfZNeknMVMVxGNoOtmUCoMXL8up9f/UZ+WQ52vUqDD3v71SgxPIwAl
         2rbbSjUpkDqNXIYmaHazrnQy+QGvn9jKNhMTIKiMYGh6XSD1RqBbdjuL1Q+FXsA581j+
         TDnz+yBmVUz6fCiL9h72YPL/WoHCb8mk1ZeD7HLRMJDKx5JCBjJ6SA/LX18Ux+0tCao9
         lcTjTnnprYv9zV4Pk7Y/fVCbNPEreFpQPrqUCDfqM/8PDfojwzhFtpEL6UQCAUnSlRxW
         wN6cFBbeA1WFwZrQXbgokDzkZcDqDJs/AB9F1GqvqDbVmoZmbQ7T4gsnpYkiGCc4ra4m
         nuJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7bi4qlEi4C6lbFqAKk71u2Dpld/aoPo9GHkopgQASng=;
        b=Z3Gs77Zvt3ftOiV2DdHQJISKGdpfeo1xirx3C1cRnawcKg+pEK1RRpkrBsdIGb836k
         tE60OckZ0umbPa2sPPmP9ciV20BWxLLB81evq+q+NodEx8Fv/EdevfEo1T8M1Unwx2dS
         SB965KapIG1QqMGCQ+6+Sq5q2XHy7nrbl20zNUeHUwkmIRtO8CxcZyX/jjAR89AP+IMy
         YCX4stzEnLBOMjIVVEjd4Gz7z6Lpjccc/FehqhKV3yKR4Uwni/AqYuCV8DUm0ZDpnGUB
         58DIWvTC3hfeq+MXUJYY6lfRS73G1kbtHacAerUsTMQ/YiDSvWBd9pheQMxcSipz112W
         +ASA==
X-Gm-Message-State: AOUpUlHPHeEkKnk9bZUXP+/aLBIyGxGUwp+QI13fYjjxWiKpnDuyGKfK
        71WQCWJRCgfUd0f3+BNAjJew8iT9w9XEL3h7A5o=
X-Google-Smtp-Source: AAOMgpdjjWi8sIkBe3AuQgP7SuUMPuDxUyO+p7xms0Wyl4zMmxHvZasj7jbA8CQnD9pxZoqzgjN/xHT55llxtquCpq8=
X-Received: by 2002:a24:b101:: with SMTP id o1-v6mr5844443itf.121.1532707696757;
 Fri, 27 Jul 2018 09:08:16 -0700 (PDT)
MIME-Version: 1.0
References: <20180727003640.16659-1-sbeller@google.com> <20180727003640.16659-3-sbeller@google.com>
In-Reply-To: <20180727003640.16659-3-sbeller@google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 27 Jul 2018 18:07:50 +0200
Message-ID: <CACsJy8Ae3sZvOQ3irQM+hv0fCRchGi8995kvLZBadbaphRo-3A@mail.gmail.com>
Subject: Re: [PATCH 2/3] refs: introduce new API, wrap old API shallowly
 around new API
To:     Stefan Beller <sbeller@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Michael Haggerty <mhagger@alum.mit.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 27, 2018 at 2:40 AM Stefan Beller <sbeller@google.com> wrote:
>
> Currently the refs API takes a 'ref_store' as an argument to specify
> which ref store to iterate over; however it is more useful to specify
> the repository instead (or later a specific worktree of a repository).

There is no 'later'. worktrees.c already passes a worktree specific
ref store. If you make this move you have to also design a way to give
a specific ref store now.

Frankly I still dislike the decision to pass repo everywhere,
especially when refs code already has a nice ref-store abstraction.
Some people frown upon back pointers. But I think adding a back
pointer in ref-store, pointing back to the repository is the right
move.
-- 
Duy
