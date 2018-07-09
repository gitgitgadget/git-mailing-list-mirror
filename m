Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D62631F6AC
	for <e@80x24.org>; Mon,  9 Jul 2018 17:10:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933712AbeGIRKM (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jul 2018 13:10:12 -0400
Received: from mail-qt0-f202.google.com ([209.85.216.202]:44970 "EHLO
        mail-qt0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933364AbeGIRKL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jul 2018 13:10:11 -0400
Received: by mail-qt0-f202.google.com with SMTP id o18-v6so8789958qtm.11
        for <git@vger.kernel.org>; Mon, 09 Jul 2018 10:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=JkDPWviJssOrzxIaSAm4n1DHvHUcY07xnHeAbAEd+9E=;
        b=mDqni7o7FCNAGvZPyGuYEv2zUHw8otP1vD6ItgMgwTEvGFMc8lix5UH7gf4i/nJCH0
         qFx5kKqecFvWzwJ4R0tgccFsvg1t/Xrp7oXtS2GA7JAGpBjqXbcxy4CWgCxdfiCYBC+b
         F0lIAQIELT9/fRfqGFks2KNMGII7Ig2SrZP6HKK0LXWT8hGCuTQo9FNKWxHmTlEeCJrI
         x2f3+C9XPMVlHz048gKOq9+/IrlkNS8Cjejto+azb7uv2vrYyeVHBH7yStLUkNymsgEj
         TRwFxDrpCpSQ1QYwHyONWhuFax8QR5ecjamodwCY7+J7rXmgXCn/cgeXa0/VSkH6coWT
         88/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=JkDPWviJssOrzxIaSAm4n1DHvHUcY07xnHeAbAEd+9E=;
        b=r2Djr2BDEMrEndeYPhGFoT3fBo/mfsr3XcPEw5yAKOmtuRDsteBJyEMUPhxjfqAnPr
         u+ZEfHjzMTbgVzWAkxYkTa8X7gmZp2rCh5h/pGOYJWNybltOfK2MhN7eeEMZJlltspcN
         Rmc30MdREbh3l0ve92xG0jPnr+0GOp9efYsLSHqLv1lus4Asr1X3F6rktWAfs7XpHTcz
         rlICEQTCFEX/tadMWktUgFzYt1qI1cu5NfpkdEenPE6hOqT+J7q9LRo2xFXCu7XgDMN1
         1iPD0R2Yf69DRjDhLxx1BSFu6WakGmsq8Q6Ican2E9+Mq62oCvN33W/HbUiAEszpRAou
         Bx4w==
X-Gm-Message-State: APt69E2ZhURaGlqQZHhlTeVmk4JLm7lT2eZUv0wy+hoOA9YKjlAQU1y2
        UzEBaUJtTYL8m3I0MaU81gSH7u0ti32fKd/qB6eE
X-Google-Smtp-Source: AAOMgpfKfzKvtcsehTl8lh9/7wrjstgtAm8NC3vr6LkSuX9sVBzwI9T5x4kFHslzJ+UhUiDlXZg26fCKLIbPnNC993eE
MIME-Version: 1.0
X-Received: by 2002:a0c:acdc:: with SMTP id n28-v6mr12037862qvc.26.1531156210655;
 Mon, 09 Jul 2018 10:10:10 -0700 (PDT)
Date:   Mon,  9 Jul 2018 10:10:07 -0700
In-Reply-To: <xmqqpnzwfl4a.fsf@gitster-ct.c.googlers.com>
Message-Id: <20180709171007.53406-1-jonathantanmy@google.com>
References: <xmqqpnzwfl4a.fsf@gitster-ct.c.googlers.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
Subject: Re: [PATCH 0/2] Avoiding errors when partial cloning a tagged blob
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitster@pobox.com
Cc:     jrnieder@gmail.com, jonathantanmy@google.com, git@vger.kernel.org,
        git@jeffhostetler.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> I think that refs in files-backend is a bit hard to update to
> annotate with extra information like "is this merely promising or a
> tip of the connectivity graph?" and agree that we should not make
> refs promisors.

OK, we agree on this :-)

> Such an otherwise unreferenced blob could be made into a promised
> object by the promisor repository, though, I think.  It can include
> a synthetic tree that points at such a blob in the pack stream data
> if it knows that the resulting pack will be marked with the
> .promisor bit, and by doing so, there is no need to update the
> client side, no?

Yes, that is possible, but I think the client side still needs to be
updated, for the same reason as in my implementation (the client should
check that the server sent all necessary objects - the blob itself in my
case, and the synthetic tree in yours).

I think that if we were planning to introduce a synthetic tree, though,
it would be better just to include the object itself (as in my
implementation). In both solutions, both the protocol and the server
need to be updated, but existing clients will still work (minus the
checking that would still be desirable with both solutions).
