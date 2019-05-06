Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A05C1F45F
	for <e@80x24.org>; Mon,  6 May 2019 22:47:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726181AbfEFWrS (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 May 2019 18:47:18 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:40044 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbfEFWrS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 May 2019 18:47:18 -0400
Received: by mail-it1-f195.google.com with SMTP id g71so7589175ita.5
        for <git@vger.kernel.org>; Mon, 06 May 2019 15:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3m0JdV5OrWJVakEYTpQZRGJfDI22RS/87UI6AKck3sc=;
        b=tHjKhui6kQf2MTwS0TqJlYHdsVB9jVjzdpz515kOpZrvmyr8oDEOx+9rqSLhJTg/Ef
         KYdJd/jg9YcSev/fWy77ZJW6pLeC/uysOIMnRVnAVss9GYFxkfUTe8imC1oPRIhPS7pj
         G2rGy7YzmxRbcduD2w8/uhmJyu/JlVYlE5auJ8ikHKZyrzyQArLwy7705jfeDGrFezkf
         TRLh0j2jInqq1+V0+6TrSTXf7O69aEh1vnetGqiWEhs+rTtYEEjEWHZeLI53vUkrvpOb
         aSvO4cyLl1pOz2F7fr6vQgi4YpuWh2Qp3l3AYaUcVFr8MBGAj5aNfCi/ceymZcyA1+PL
         oLtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3m0JdV5OrWJVakEYTpQZRGJfDI22RS/87UI6AKck3sc=;
        b=VMATQBDxLZPqFFfZlM4fZS1WEkpLhQrAo+MnmWT0fyXrWJGCkQyLuHv02cE01LvaW8
         Kc16Hqjke+g4XusrwdGN7XF1llCBwshaKaojugE3u8Xc76Ue9yHvd5CK0FQzTDpV8+r0
         Mt5g7MF3uiEgCjxZAU1ZDI2rv6BYMCmj8UbHWUKapC77BJaq5J6JcXL2otdlQxoqZyag
         sLehN6VULJmHZvoALnEWrON+/sWeyowDJ0wcjLL567Iwee6W3yto3nWKs6NfypJUZsqq
         4JZvqx3Pj9ZzEt/r9OBrNORcQ/PLtyrRIxbCo2hYYpsmg7bd7mo7ARknqqnTP8hxhdx2
         5H2A==
X-Gm-Message-State: APjAAAVJ7hclJ7VZTfS6ALV2+MvpDg2Wcm6Npbl3MmrsZLmFepol39y7
        iSy15a6kXgidPtZoRlZl25fu8WhgYB0BfPUZs2wy
X-Google-Smtp-Source: APXvYqzP7QDZgKqk0+5J5/NG2Lapw4pAxvvY9c4ejtQfQNzlWWRA3LzClOsOJpSN7LhV2dIx+Ww8DV9CBRgKbFgynes=
X-Received: by 2002:a02:b0c5:: with SMTP id w5mr20765004jah.95.1557182837099;
 Mon, 06 May 2019 15:47:17 -0700 (PDT)
MIME-Version: 1.0
References: <CAMfpvhKYRVwTVNLfRJYcjhHtg=FNLNPbnw8xtY93nJu228v6=g@mail.gmail.com>
 <20190506192800.213716-1-jonathantanmy@google.com>
In-Reply-To: <20190506192800.213716-1-jonathantanmy@google.com>
From:   Matthew DeVore <matvore@google.com>
Date:   Mon, 6 May 2019 15:47:05 -0700
Message-ID: <CAMfpvh+jbPcU2waU5n6nToxGEsC29WGOFPLR+ibXbhXL6WBb6w@mail.gmail.com>
Subject: Re: Proposal: object negotiation for partial clones
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, Jonathan Nieder <jrn@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 6, 2019 at 12:28 PM Jonathan Tan <jonathantanmy@google.com> wrote:
>
> > I'm considering implementing a feature in the Git protocol which would
> > enable efficient and accurate object negotiation when the client is a
> > partial clone. I'd like to refine and get some validation of my
> > approach before I start to write any code, so I've written a proposal
> > for anyone interested to review. Your comments would be appreciated.
>
> Thanks. Let me try to summarize: The issue is that, during a fetch,
> normally the client can say "have" to inform the server that it has a
> commit and all its referenced objects (barring shallow lines), but we
> can't do the same if the client is a partial clone (because having a
> commit doesn't necessarily mean that we have all referenced objects).
> And not doing this means that the server sends a lot of unnecessary
> objects in the sent packfile. The solution is to do the fetch in 2
> parts: one to get the list of objects that would be sent, and after the
> client filters that, one to get the objects themselves.
>
> It was unclear to me whether this is meant for (1) fetches directly
> initiated by the user that fetch commits (e.g. "git fetch origin",
> reusing the configured "core.partialclonefilter") and/or for (2) lazy
> fetching of missing objects. My assumption is that this is only for (2).
Yes, that was my intention. The client doesn't really know anything
about the hashes reported, so it can't really make an informed
selection from the candidate list given by the server after the first
request. I guess if we wanted to just reject *all* objects on the
initial clone, this feature would make that possible. But that can
also be achieved more embracively with a better filter system.

>
> My main question is: we can get the same list of objects (in the form of
> tree objects) if we fetch with "blob:none" filter. Admittedly, we will
> get extra data (file names, etc.) - if the extra bandwidth saving is
> necessary, this should be called out. (And some of the savings will be
> offset by the fact that we will actually need some of those tree
> objects.)
That's a very good point. The data the first request gives us is
basically the tree objects minus file names and modes. So I think a
better feature to implement would be combining of multiple filters.
That way, the client can combine "tree:<some small number>" and
"blob:none" and basically get an "enumeration" of available objects.

>
> Assuming that we do need that bandwidth saving, here's my review of that
> document.
>
> The document describes the 1st request exactly as I envision - a
> specific parameter sent by the client, and the server responds with a
> list of object names.
>
> For the 2nd request, the document describes it as repeating the original
> query of the 1st request while also giving the full list of objects
> wanted as "choose-refs". I'm still not convinced that repeating the
> original query is necessary - I would just give the list of objects as
> wants. The rationale given for repeating the original query is:
>
> > The original query is helpful because it means the server only needs
> > to do a single reachability check, rather than many separate ones.
>
> But this omits the fact that, if doing it the document's way, the server
> needs to perform an object walk in addition to the "single reachability
> check", and it is not true that if doing it my way, "many separate ones"
> need to be done because the server can check reachability of all objects
> at once.
After considering more carefully how reachability works (and getting
your explanation of it out-of-band), I would assume that my approach
is no better than marginally faster, and possibly worse, than just
doing a plain reachability check of multiple objects using the current
implementation. My current priorities preclude this kind of
benchmarking+micro-optimization. So I believe what is more important
to me is to simply enable combining multiple filters.

>
> Also, my way means that supporting the 2nd request does not require any
> code or protocol change - it already works today. Assuming we follow my
> approach, the discussion thus lies in supporting the 1st request.
>
> Some more thoughts:
>
> - Changes in server and client scalability: Currently, the server checks
>   reachability of all wants, then enumerates, then sends all objects.
>   With this change, the server checks reachability of all wants, then
>   enumerates, then sends an object list, then checks reachability of all
>   objects in the filtered list, then sends some objects. There is
>   additional overhead in the extra reachability check and lists of
>   objects being sent twice (once by server and once by client), but
>   sending fewer objects means that I/O (server, network, client) and
>   disk space usage (client) is reduced.
Agreed, and this is still true in the new approach we've agreed on.

>
> - Usefulness outside partial clone: If the user ever wants a list of
>   objects referenced by an object but without their file names, the user
>   could use this, but I can't think of such a scenario.
Neither can I.
