Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B487C433EF
	for <git@archiver.kernel.org>; Fri, 17 Jun 2022 20:03:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233759AbiFQUDG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Jun 2022 16:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234750AbiFQUDF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Jun 2022 16:03:05 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A6815B3F6
        for <git@vger.kernel.org>; Fri, 17 Jun 2022 13:03:04 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id bk18-20020a17090b081200b001ec747bb1f7so1689250pjb.7
        for <git@vger.kernel.org>; Fri, 17 Jun 2022 13:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:subject:from:to:cc;
        bh=DKjI41sM8C1pAsT7iics365QZ+cwfifvepRqNLAw4qs=;
        b=VqqvIV/aap2Z9L49kiSdjGvaEzzMb4iTcfjgHo01PvGJvF818tpRfRM3JBb1SMjHRy
         8zbI1x3rlrL8ilrsfGTL6bhRfV2eJIVq44TkbdwG00CQBmIqFlmAMq0JpNzNAEkCSnS8
         z8bcpYpWRB21JDetz3pMqmThEtThHvQbBOzH3Y7vnvs1KpyIms3yVJByVFRVBPcM8uaM
         fb+Y2IEp9u7BfhC1odVyNXLwEqBFwBTk4dGXcwEj89JPWMnMlxIZPI+Z95t11O/IDYJv
         Z3J+k2MoD5Ch/D3YyMsd0R5wwYYnI6H2WJx1sXSDbdcAl9uulquAIT1Bvi8aUJippoQ8
         gsnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version:subject
         :from:to:cc;
        bh=DKjI41sM8C1pAsT7iics365QZ+cwfifvepRqNLAw4qs=;
        b=FC4K0mg+lgKbfAcHSVW6/cUJDJV+xCQIHPkPDHasm3IJysOHyQFnYQ8oIfHJgZQUfl
         OIvIiGLYr6yX17qfHjzXBo0FRbf+TekeDJgpzIeNUluy/CxQkZi9BT8pPbUoZKQAuD9Q
         3R3tzrCvwTYqlsGz0b4Dkg+U/EcJjux60pi5+cNtLWaxeP2+dy9lnKjSSIF+D/EkF0UC
         mE2vNIy868KA8HUL9RsM06fxNcilvGvOOMW2PUSd2MOe4TBIN/hcwvG8rSGb3EguRIOI
         TKCpu2BWD+hmF4D+m3oDz6pZ9h590Ofvit0/b/zgBUP5l1CYkKiwuAttfl6uZfDPrFy3
         b8pw==
X-Gm-Message-State: AJIora9vw/pDBe8oQk5FW3TAlKOg9352IketkxokbAfuSCe/vX1pmcKG
        eKMSbz/hwmATyhFp8KFFN1Lth+8eCbahRKa/18w7
X-Google-Smtp-Source: AGRyM1sZuO/KUKtq438V06aTUn9zPjW0pfAOeja/zlLfl9SoxR9QuvSsU8E4/8/nOfrbufdLguGY4+2zAv+HyXoTy/fW
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:902:da91:b0:168:f947:4fd1 with
 SMTP id j17-20020a170902da9100b00168f9474fd1mr11036679plx.150.1655496183924;
 Fri, 17 Jun 2022 13:03:03 -0700 (PDT)
Date:   Fri, 17 Jun 2022 13:03:01 -0700
In-Reply-To: <xmqqr13wclll.fsf@gitster.g>
Message-Id: <20220617200301.2700839-1-jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
Subject: Re: [PATCH v2] fetch,fetch-pack: clarify connectivity check error
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        avarab@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:
> While that is all true, I do not think the posted patch as-is is a
> good idea.  After all, object missing on our side locally before you
> start "git fetch" is a local repository corruption, which ought to
> be a much rarer event than a still in development and in flux server
> end sending nonsense packfiles, no?
> 
> At least, "they didn't do X" would give the user somewhere to start
> investigation (e.g. complain to the server folks about the error,
> stating where they started from and what they tried to fetch).  The
> new message may be playing it "safe" by not saying anything you are
> not absolutely sure about, but that is much less useful to the users
> who got the message.

Hmm...that's true. Let me try to understand the revision walking code a
bit more, and if by then I still don't end up changing the revision walk
to avoid prematurely parsing a parent, I'll make a patch with your
suggestion.
