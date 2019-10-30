Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 657311F4C0
	for <e@80x24.org>; Wed, 30 Oct 2019 20:45:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbfJ3UpV (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Oct 2019 16:45:21 -0400
Received: from mail-vk1-f202.google.com ([209.85.221.202]:51376 "EHLO
        mail-vk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726983AbfJ3UpV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Oct 2019 16:45:21 -0400
Received: by mail-vk1-f202.google.com with SMTP id u64so1426615vke.18
        for <git@vger.kernel.org>; Wed, 30 Oct 2019 13:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=kEKjmSmV4v0hALx42MP77UOkM65kF+5rESD/xfn06AU=;
        b=IN76mGwwR8V8vjTrleNO8yu0b4DxnLnpzYu93erTl+YuKRgjUkg9wAmNV9MUxHyMg+
         NDOu3imXM5nGJ8AOTYUTNDY2lwYCxXCVW1lP5dhLAGzHHAmQqsjk8W3QgpBK3aKzVzYd
         qDX2mW15s8bK8uNNdwRa8YifI5anqqPDbthqbwX6MRHXGGDShHRC7QdV1/Ee+/mn0rQ/
         Q3gWgrSuf6dEVgsEzsEjJc1vMZSVfvGTB1HK09/p0LwqQgmRQgsLQHHUtgg8gsyp1afZ
         2wSVa/UDcqnYAeI6dlsoGjBewkOqsa5uzY9PmwAqYjM7S2SZRByc6AoItZiqBu9LirI0
         NQkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=kEKjmSmV4v0hALx42MP77UOkM65kF+5rESD/xfn06AU=;
        b=PgFA63tLfFI0c6KkUDQcI/h8uJtpIJCRIfUvhNp8zUzmwa2rs3XKXZO6tAYpUMrFp2
         uCFrgIIJq9yXyiOMRHCI65nsbTYbZN7q6EffxpEuk4yYbFMzhnvj4e8upyFF8rmBETNr
         VdBhXeVg9bCc0r1pQtXCLzS2FOudBAt8kIQof7sP6TN/KpXjJqxZpkGx1H5ek5NaJsKS
         Z85MzJI1I2SKGQTlD4KCmiznTCotfx+x6Y6pQz9khjksxUAypnIBKy0Wn0KFAj0BQAcY
         MWPurZc83NnklEb9nkBhBqtemRuCDCKrmtDcBa+ECWM4E8smABUlAfttkLukzRMMtt4Q
         QjxA==
X-Gm-Message-State: APjAAAWFZAZ2lZH3M+8kI8zysS+SR1WGQxDLieGytmSNGfuHljj8/Hmt
        FBGfOGhsO1F5zzOJKDrD2s+DjM5vznEWq2BgHMeo
X-Google-Smtp-Source: APXvYqx65rB4hMP12SP9g/x8B/m+eWaTtwkSREnG5hbpv1e7nH94dZu4t9513/cf1mwucSi87+qnF8r+gTBQndpfaFNL
X-Received: by 2002:a1f:e243:: with SMTP id z64mr743362vkg.56.1572468320214;
 Wed, 30 Oct 2019 13:45:20 -0700 (PDT)
Date:   Wed, 30 Oct 2019 13:45:16 -0700
In-Reply-To: <20191030203714.GC29013@sigill.intra.peff.net>
Message-Id: <20191030204516.53832-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20191030203714.GC29013@sigill.intra.peff.net>
X-Mailer: git-send-email 2.24.0.rc0.303.g954a862665-goog
Subject: Re: Partial Clone garbage collection?
From:   Jonathan Tan <jonathantanmy@google.com>
To:     peff@peff.net
Cc:     simon.holmberg@avalanchestudios.se, git@vger.kernel.org,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> I don't recall seeing anybody actively working on this, but I think it
> would be a good idea.

I agree with this.

> You could naively just drop everything that matches the filter, and then
> re-fetch it as needed.

We should also retain the promisor objects that are not referenced by
any other promisor object, regardless of whether it matches the filter.
(If not, the resulting repository will not pass fsck.)

The place to make this change is most likely in
repack_promisor_objects() in builtin/repack.c. Currently, it just
repacks all known promisor objects into one - modifying it to only
repack the ones we want (and adding a CLI option etc.) should be
sufficient.
