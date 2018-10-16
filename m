Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C82D1F454
	for <e@80x24.org>; Tue, 16 Oct 2018 22:22:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbeJQGPR (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Oct 2018 02:15:17 -0400
Received: from mail-ot1-f73.google.com ([209.85.210.73]:43933 "EHLO
        mail-ot1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726048AbeJQGPR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Oct 2018 02:15:17 -0400
Received: by mail-ot1-f73.google.com with SMTP id d34so17843594otb.10
        for <git@vger.kernel.org>; Tue, 16 Oct 2018 15:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=7KdaMJDDy01UOk03DidlkGouFIuGmTYcyCI/SNGDyRw=;
        b=NmXwAP4b1Xw04pHhDAoRIK6AGgia9bhJStXbCHIx+gEuwzA4qOShhCjWrDEcX6tG6W
         NaMu2iqa7ZsRHKQqB67YnH5iJA2MtDmiNPJCD9d0/ZP0DRnuWLUlUxxUmn6dAUNfELhT
         vorvyCSVq09zECcsaRvTfu+mHVdShIjkXHrlMEOhEx8t01GJ1mhwA1gh94iFsRGqaz4X
         XJMI4fQOBQ86AAGW0czRPA9DzCKLhDBo4cbfclna08+qQpDP53zrUY1dSNtDqpQE+ncu
         kINFq1jtO4Uw0F77W7qOWpeZzn9N/W2i2V2tLM1+vV+rAqGocjAL2rJtvgCbtQCOgQdH
         7HYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=7KdaMJDDy01UOk03DidlkGouFIuGmTYcyCI/SNGDyRw=;
        b=AY9I4CHbyWp6oair08AhhOidRyuL27yppUYMf92zBj0tIRJEDI1/EWMB15zMdfZ524
         i560KvYUysvqx+SoTU1AFY7Zp4Ks9CNJLNfBqp4Rg92oYIy8MOUOf49ZgOZtpYOrXHz9
         kozoIpgJ98ZyJnzTU7GJiyLyppKKeAdw6YAyj8sQjZJlNC/uVPAl7V+IB/ig3Vdx4gBp
         eVGmK63Rb0JkNrwycI+R2F53sVFb9ip9s/YlacvjUR6jnAX6T0Ty76YFS9N/4yE6eZwr
         iU8DG02wBKNF0ztG/EnPrk9If+y1dV21JtW8NleZ83xvj8yIYcj3pdKyiPoYnsL2IGk5
         Agcw==
X-Gm-Message-State: ABuFfoij/JcSyKLITURS23HeMRYADEQ9JqTW5W/XbSNLv3gEa/Nq20Ao
        f8LAOxlH2tsZ8ev6gYRfJ+zYc1lnbcI96oUUy/Hm
X-Google-Smtp-Source: ACcGV61I7zDOxF66CcElvY2UVe0lPalHXm+4eO1gDDIBS5AyYKuqQl7Shfq0v07EMm5LSuF+p2wdaDHDnFP5uobBSAqJ
X-Received: by 2002:a9d:2572:: with SMTP id j47mr19917024otd.24.1539728567517;
 Tue, 16 Oct 2018 15:22:47 -0700 (PDT)
Date:   Tue, 16 Oct 2018 15:22:43 -0700
In-Reply-To: <20181016174304.GA221682@aiede.svl.corp.google.com>
Message-Id: <20181016222243.58620-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20181016174304.GA221682@aiede.svl.corp.google.com>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: Re: [PATCH v4 9/9] Documentation/config: add odb.<name>.promisorRemote
From:   Jonathan Tan <jonathantanmy@google.com>
To:     jrnieder@gmail.com
Cc:     christian.couder@gmail.com, sbeller@google.com,
        git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        Ben.Peart@microsoft.com, jonathantanmy@google.com,
        pclouds@gmail.com, mh@glandium.org, larsxschneider@gmail.com,
        e@80x24.org, chriscool@tuxfamily.org, jeffhost@microsoft.com,
        sunshine@sunshineco.com, dev+git@drbeat.li
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>  1. Teaching partial clone to attempt to fetch missing objects from
>     multiple remotes instead of only one.  This is useful because you
>     can have a server that is nearby and cheaper to serve from (some
>     kind of local cache server) that you make requests to first before
>     falling back to the canonical source of objects.

Quoting the above definition of (1) for reference. I think Jonathan
Nieder has covered the relevant points well - I'll just expand on (1).

> So much for the current setup.  For (1), I believe you are proposing to
> still have only one effective <promisor-id>, so it doesn't necessarily
> require modifying the extensions.* configuration.  Instead, the idea is
> that when trying to access an object, we would follow one of a list of
> steps:
> 
>  1. First, check the local object store. If it's there, we're done.
>  2. Second, try alternates --- maybe the object is in one of those!
>  3. Now, try promisor remotes, one at a time, in user-configured order.
> 
> In other words, I think that for (1) all we would need is a new
> configuration
> 
> 	[object]
> 		missingObjectRemote = local-cache-remote
> 		missingObjectRemote = origin
> 
> The semantics would be that when trying to access a promised object,
> we attempt to fetch from these remotes one at a time, in the order
> specified.  We could require that the remote named in
> extensions.partialClone be one of the listed remotes, without having
> to care where it shows up in the list.

Or allow extensions.partialClone=<R> wherein <R> is not in the
missingObjectRemote, in which case <R> is tried first, so that we don't
have to reject some configurations.

> That way, we get the benefit (1) without having to change the
> semantics of extensions.partialClone and without having to care about
> the order of sections in the config.  What do you think?

Let's define the promisor remotes of a repository as those in
missingObjectRemote or extensions.partialClone (currently, we talk about
"the promisor remote" (singular), defined in extensions.partialClone).

Overall, this seems like a reasonable idea to me, if we keep the
restriction that we can only fetch with filter from a promisor remote.
This allows us to extend the definition of a promisor object in a
manner consistent to the current definition - to say "a promisor object
is one promised by at least one promisor remote" (currently, "a promisor
object is promised by the promisor remote").

In the presence of missingObjectRemote, old versions of Git, when lazily
fetching, would only know to try the extensions.partialClone remote. But
this is safe because existing data wouldn't be clobbered (since we're
not using ideas like adding meaning to the contents of the .promisor
file). Also, other things like fsck and gc still work.
