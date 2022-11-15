Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 341AFC433FE
	for <git@archiver.kernel.org>; Tue, 15 Nov 2022 18:47:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbiKOSrM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Nov 2022 13:47:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbiKOSrJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Nov 2022 13:47:09 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB6E7A462
        for <git@vger.kernel.org>; Tue, 15 Nov 2022 10:47:07 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id 186-20020a6300c3000000b004702c90a4bdso7842233pga.9
        for <git@vger.kernel.org>; Tue, 15 Nov 2022 10:47:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XLovrrrdOikA2KC82BSn2bv6GY9twDJGmryvJ911+zg=;
        b=IKIH7pV4Jny77gXzOldI7dfd1zAXwIMFZVAtNoa7/vtVlXLrHbuxgoScQiji3szl66
         Jb6ZDTPCjNbdtoyq0GcSV5lEJe8aY752Z2BHjHHDFj2zORg7VWFmSmjTJjvHcLNCjJOd
         tjN9pdUPDrM13Na/dRI5lyorc/8t4jwh4fvMpSkKe0EUbG4D5Fxmidq09wHrLerkYM2k
         Ms78qq1gob6QMTx5xVok0PijigN3CSc4fULe51Avgv2A0M643cZz/i4wfPHVxAez5rJo
         V0jEhMMm/7Wtyr00PjT/MV5K/uzLVrQjtuL6nHJ4S5Sr4f73ytmRB83eisxb2So2/Niz
         8uEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XLovrrrdOikA2KC82BSn2bv6GY9twDJGmryvJ911+zg=;
        b=lgX6l7T/vOqysWouLma/6VccLM/+abLkmJ76Ws6Wc3JHzmPOMfB25WJNaNfDyGvXp7
         XS9kfc7ohiNAxAw/lv/jHwmJMoKnG7QsdTwACYk51WvAobHL705x71vGipuRveZOUGDb
         0nplFV9oAv6oTF6A4vYgmsNFqU0cX+HRX/wR8ZWAPQ0/xHkxAjUkPOh/ZHUE+KcfAQOw
         D7figc6l+P757kpXIN4pydPFFOJR54MADqmZlQguqZ3+/M1WCOvyoAamGlL4CivtZwwJ
         Qe0GZ6ez+3C7DA7iDvNcMo4xeC0sNPOob2pxz4JIpWfS5nKUfLnO/7BnOzwF9vUagavw
         36zA==
X-Gm-Message-State: ANoB5pmrDgLnjGvUQR+BsKnvm1HbAHsWuJo3SJXJuuf9/l/skwzD/hcD
        5y7uGoRo/0IyUVKO5JmqqB8sDTZIelfS9308RCAE
X-Google-Smtp-Source: AA0mqf4K+QGTm+C2ZZ6UMorjB31Fd8XEhNMQ+mgmKhkk7qIM901Va+EhJfroTluvMoBL3vi9fXT94kz+VlZrQvmK3Njg
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:90a:eacd:b0:213:2708:8dc3 with
 SMTP id ev13-20020a17090aeacd00b0021327088dc3mr440036pjb.2.1668538026888;
 Tue, 15 Nov 2022 10:47:06 -0800 (PST)
Date:   Tue, 15 Nov 2022 10:47:02 -0800
In-Reply-To: <kl6lcz9pnic2.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.1.493.g58b659f92b-goog
Message-ID: <20221115184702.169258-1-jonathantanmy@google.com>
Subject: Re: [PATCH v2] Doc: document push.recurseSubmodules=only
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Glen Choo <chooglen@google.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        me@ttaylorr.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

First of all, thanks for taking a look at this.

Glen Choo <chooglen@google.com> writes:
> That said.. I find the status quo very surprising and unergonomic. As
> demonstrated in a test below, if a submodule has push.recurseSubmodules
> unset, recursion doesn't occur. At the very least, I would have expected
> the submodule to respect the superproject's config since that's still a
> statement of intent.
> 
> I expect that we will have to change this behavior at some point, and
> hopefully my "ideal" behavior makes sense to users.

Well, your "ideal" behavior makes sense to me :-)

> When we pass this magic, undocumented value, "git push" will warn about
> about "only" and override it with "on-demand". We always pass it when we
> recurse into submodules, and we assume that no user will pass it, thus
> we get the warning iff we are recursing into submodules.
> 
> In that case, it sounds like "--recurse-submodules=only-is-on-demand" is
> a synonym for "this is a submodule that is being recursed into". In that
> case, wouldn't it be more self-documenting to have a hidden CLI flag
> that expresses exactly that ? e.g. we could add a PARSE_OPT_HIDDEN flag
> called "--is-recursing" and check that boolean value. This seems clearer
> to me at least.

Hmm...--recurse-submodules=only-is-on-demand is hidden too, right? One
advantage of doing this instead of a separate arg is that neither the
caller nor "git push" needs to think about what happens if both --recurse-
submodules=something and --is-recursing are both specified.
