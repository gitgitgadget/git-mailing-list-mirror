Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 88AA21F597
	for <e@80x24.org>; Mon, 16 Jul 2018 20:21:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728558AbeGPUum (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Jul 2018 16:50:42 -0400
Received: from mail-vk0-f66.google.com ([209.85.213.66]:47015 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728197AbeGPUum (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jul 2018 16:50:42 -0400
Received: by mail-vk0-f66.google.com with SMTP id b14-v6so22358692vke.13
        for <git@vger.kernel.org>; Mon, 16 Jul 2018 13:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=tKotaOyDNr6orPZtbYfpcUcDn9X5SaiFT19xJhCiYrY=;
        b=O4nr4iDR8+sxy5kZBZo7MyHxgTI6DXQpkncF8qAEte9lMX/LhpBVZ7V3XacZ9FweXF
         cg+ZVhePUG21zcvrxBPmpBZcvz7L8G1SCh24ant25HE9VyqbVao4jlZfq6BeHgcm5a84
         VcWZVfuyHWr1OMAvuwjVZP8EQ6GGIIIDirnbLqYW4y+FPV5JL7Kv0KFp/wbCXxEPsb1w
         yb3DpZrGJwxIPFoeqp+yvJpoqlGWjzAscF4PDtQgGrDk5UWCfVbLWZGdmqMq6L3vtoGD
         P4EqpZ4i6OwhrGsrXdlSyq6c2RvfgXJ0nR/3pw9H5OZAv0NoSMuvqzJK3sWDsfLm7Qpm
         JfSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=tKotaOyDNr6orPZtbYfpcUcDn9X5SaiFT19xJhCiYrY=;
        b=baPy0E8fElQkCE5p0lbxIk9TXIVrPbFfniT5pPRLlClfvmcGlyJHXDNFcm9a1BsuHN
         6QXTvkk+QL0o74NGr85yEy8HcFAXmdpbovRFBdEMLpBcQJYiqy5Fk9l3nNgwFvD5xch+
         P0ZztMG3Cos9YhiXYVIxA5MUIZXeCSG0iwwj5c+lTCYRRS4jIGzK3iQ2kdF/RaHyHztk
         BvMZ1lCq6PfxVR8tfR2F/P8VXLq+uKG+/FqptsEWus1sMftQ1IguoCUOTw609tfWwpcC
         AfNAY1TY9lwzRky9XTU4i+YK6u2OUazjlk+6izXry6Wfm2GRJI+GCPpXOxgRB6FYT7V9
         k9Ug==
X-Gm-Message-State: AOUpUlEW4pSlOc54+4zGhZesvOwsg8RKA+vfutMWgXH1Qd2nWqrWKHYg
        9o4o3SPqon/RB1gY+fGvfKjG5s8NTNUyLLxpGf0=
X-Google-Smtp-Source: AAOMgpdoB87/2SraH1o/KCcaEHsLYRa5o1dqx39xzlt53QiaPrGWoXgpwaO08tc++JB0jC3nNVnBXq5lmlPGvWEMNzw=
X-Received: by 2002:a1f:2cce:: with SMTP id s197-v6mr10169909vks.106.1531772500817;
 Mon, 16 Jul 2018 13:21:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:21c7:0:0:0:0:0 with HTTP; Mon, 16 Jul 2018 13:21:40
 -0700 (PDT)
In-Reply-To: <20180716191923.GC11513@aiede.svl.corp.google.com>
References: <20180716172717.237373-1-jonathantanmy@google.com>
 <20180716191505.857-1-newren@gmail.com> <20180716191923.GC11513@aiede.svl.corp.google.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 16 Jul 2018 13:21:40 -0700
Message-ID: <CABPp-BGN4NeH2QAP0WMyuOdr2GYq+hpt9584wdn2jHHinEAgDg@mail.gmail.com>
Subject: Re: [PATCH] gc: do not warn about too many loose objects
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Mon, Jul 16, 2018 at 12:19 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Elijah Newren wrote:
>
>> The basic problem here, at least for us, is that gc has enough
>> information to know it could expunge some objects, but because of how
>> it is structured in terms of several substeps (reflog expiration,
>> repack, prune), the information is lost between the steps and it
>> instead writes them out as unreachable objects.  If we could prune (or
>> avoid exploding) loose objects that are only reachable from reflog
>> entries that we are expiring, then the problem goes away for us.
>
> My understanding is that exploding the objects is intentional behavior,
> to avoid a race where objects are newly referenced while they are being
> pruned.
>
> I am not a fan of that behavior.  It's still racy.  But when we've
> brought it up in the past, the consensus seems to have been that it's
> better than nothing.  Documentation/technical/hash-function-transition.txt
> section "Loose objects and unreachable objects" describes a way to
> eliminate the race.

Ah, that's good to know and at least makes sense.  It seems somewhat
odd, though; loose objects that are two weeks old are just as
susceptible to being referenced anew by new commits, so the default of
running 'git prune --expire=2.weeks.ago' as gc currently does would
also be unsafe, wouldn't it?  Why is that any more or less unsafe than
pruning objects only referenced by reflog entries that are more than
90 days old?

Elijah
