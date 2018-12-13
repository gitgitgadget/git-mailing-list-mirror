Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D5A520A1E
	for <e@80x24.org>; Thu, 13 Dec 2018 19:53:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728390AbeLMTxL (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Dec 2018 14:53:11 -0500
Received: from mail-it1-f201.google.com ([209.85.166.201]:37102 "EHLO
        mail-it1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727707AbeLMTxL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Dec 2018 14:53:11 -0500
Received: by mail-it1-f201.google.com with SMTP id y86so3576096ita.2
        for <git@vger.kernel.org>; Thu, 13 Dec 2018 11:53:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=GsFhnXk2WFx/uBvE1FD4P7uYnd4GQF9dOXkXLv8C7no=;
        b=ptUUAnypBa1YWsvikTxaCalGAOPkBLJEDcLk8zkjyQJxeMTfL3G5zQEjXd8CZXziku
         BLu0u/j4OSJsg9WT3KOm+fEWZY4Y4kOZi30pGU35zFlnNJyKS8fR+QD8zQLbEaduOkvB
         n6iicbvwSleBDigWOoYLXDK9E7HfeX9WEJ/FZPcQ1r869bSnHBtovG2C+TExnjAVzK5R
         gzm5UOhPDlDoRj2uJPWyLvl9ryKKhThJBi4SbyS0zjnDWdXnJ5CsMSiUACuWidIF4l25
         07SR2VDQ0OOkv84Cz+f4t4hgB2aGuF6mS5ZXXmKrTuqNvU6f9iYgrickPDK+5jxaVUoy
         w6Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=GsFhnXk2WFx/uBvE1FD4P7uYnd4GQF9dOXkXLv8C7no=;
        b=hooAJh1douglGBe5fN6VFOzFbcXuVdduoGaa+VmE9wb25Mx0rJfytOfSUyvJQkx+CZ
         7LT8fxtzy2k5uJk40sUFMXJAbNoV8L+qU0Aibh0zY6rdkmAutvQ00irVzQfY+vzdIlj7
         s1PC+BxpRY9h4koGtHbbq9xh8JSzrJhAbmnROVlp9uECvO380JxmCjzu6WqGCs101ICW
         FeJIQRkZeY6lxPHGboK/49cmVtGxc/mfrtNawgBQ8evU2MSX0CyVeB34vZGQ/0p/Z9PO
         qZMDWfsBdoS/g4ao2QtrEZDG0MVZzd5mGIWTJJfJeSykBc+b2EWMKpSGwlJgGtL+gHF2
         pXDQ==
X-Gm-Message-State: AA+aEWbYxLdJ3SlAbWK9ufV53LYqSuXmD7B0bgSlMcSSyXbmw2XBRLSW
        ZpBaHs14PAQL5QlcHtMQ80J14n14O5eqsIUopMU7
X-Google-Smtp-Source: AFSGD/XHi1MqSAFqJaNflZXNwmJxyZNpvQhLoBlIOfFcXdyBxzig2qccysbnL7KdT1zb/Q6PoBTg1KmCftg+9XtYT91E
X-Received: by 2002:a24:5dd4:: with SMTP id w203mr563516ita.8.1544730789914;
 Thu, 13 Dec 2018 11:53:09 -0800 (PST)
Date:   Thu, 13 Dec 2018 11:53:05 -0800
In-Reply-To: <20181211104236.GA6899@sigill.intra.peff.net>
Message-Id: <20181213195305.249059-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20181211104236.GA6899@sigill.intra.peff.net>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: Re: [PATCH 0/3] protocol v2 and hidden refs
From:   Jonathan Tan <jonathantanmy@google.com>
To:     peff@peff.net
Cc:     git@vger.kernel.org, bwilliamseng@gmail.com,
        jonathantanmy@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Just realized that I haven't replied to this yet...

>   - I'm a little worried this may happen again with future features. The
>     root cause is that "ls-refs" follows a different code path than the
>     ref advertisement for "upload-pack". So if we add any new config,
>     it needs to go both places (non ref-advertisement config is OK, as
>     the v2 "fetch" command is a lot closer to a v0 upload-pack).
> 
>     I think this is just an issue for any future features. I looked for
>     other existing features which might be missing in v2, but couldn't
>     find any.
> 
>     I don't know if there's a good solution. I tried running the whole
>     test suite with v2 as the default. It does find this bug, but it has
>     a bunch of other problems (notably fetch-pack won't run as v2, but
>     some other tests I think also depend on v0's reachability rules,
>     which v2 is documented not to enforce).

I think Aevar's patches (sent after you wrote this) is a good start, and
I have started looking at it too.

>   - The "serve" command is funky, because it has no concept of whether
>     the "ls-refs" is for fetching or pushing. Is git-serve even a thing
>     that we want to support going forward?  I know part of the original
>     v2 conception was that one would be able to just connect to
>     "git-serve" and do a number of operations. But in practice the v2
>     probing requires saying "I'd like to git-upload-pack, and v2 if you
>     please". So no client ever calls git-serve.
> 
>     Is this something we plan to eventually move to? Or can it be
>     considered a funny vestige of the development? In the latter case, I
>     think we should consider removing it.

Personally, I lean towards removing it, but there are arguments on both
sides. In particular, removing "serve" means that both developers and
users of Git need not be concerned with a 3rd endpoint, but preserving
"serve" (and planning to migrate away from "upload-pack" and
"receive-pack") means that we will only have one endpoint, eliminating
confusion about which endpoint to use when making certain requests (when
we add requests other than "fetch" and "push").
