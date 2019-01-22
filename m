Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5FC4C1F453
	for <e@80x24.org>; Tue, 22 Jan 2019 09:50:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727578AbfAVJu6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Jan 2019 04:50:58 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:43774 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727026AbfAVJu5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jan 2019 04:50:57 -0500
Received: by mail-io1-f65.google.com with SMTP id b23so18607277ios.10
        for <git@vger.kernel.org>; Tue, 22 Jan 2019 01:50:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IGYcFDZX2O45s44RG2sJZmqeVlybYurNGHhkRrJ7Kn8=;
        b=u5/0PUPblAZrNGSBkyktRM81AqwQiDq49rCpkzAs+NghWfkI7pC19sPAIcyJJbjmUO
         lW80yLqKYHP+H0jN+MKZVS8pQQcuo6De55Wd7iJsqCyPRpntXLxu5rG+LmkVj0S5DnAZ
         114mYf9rmXHRCH3IR025cNB+v3mk4yj/oKIP2b6Q0VWjCs77rn6WBLlQuA1v/3oK26h6
         etgN5qfbjW2099BKoXZgOYg2XNj/hS+9IqUqCneJADeBhumULHN5GV4ZzZ8JB1OxXkHP
         LyNz+Hsp3xxMviSd+LI+23uzN/XbSISfRn6MGrvdGFyfl1NUtLPc8tYeLN5Z7tqpjUM6
         MrkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IGYcFDZX2O45s44RG2sJZmqeVlybYurNGHhkRrJ7Kn8=;
        b=mN0vDCHFgTdv+DHTu2Sw16XthmG+asA5jyb3xtoGikn1/h6OvwQSW1Nbha82Dyky4A
         zznY+RtbW4cLsp4xJRaSr7nmnwqN3aIktpThUv5wnryHSRRAk3RA0fZQKT0Ize6pU7LK
         CIK4QYVqoNmPCHzbgWEs3sFhP+tLF465FRcvoqLB1aUO7g8O/NzxNd0PqIyQHrGjesan
         CFQsfe63Ulk21rKcqGMM0hYjO82TnDujxbeOztii5zPLfw6byGp8ZfOB5moL7Mt07cb+
         ODgf/EBDU4GNDt663an2XdIaa9Ia3hIGIRpMRzysFDDkBThuOoTNNFob1K4mQ7AD9nOz
         1O6w==
X-Gm-Message-State: AJcUukd5eX34FcfPL1Uueg9GKI2Rdg+CZJpfwyPoURZIelHNhexZ62/I
        9Z9DqNInfRrd1SP+23E5Yy2kjGBkrXvFXR1fJxo=
X-Google-Smtp-Source: ALg8bN7Sa7ZQp1jVSF6110aTc0RkIidSM+n2T+WBOOglrmCPNImPIDLvNrDDCU6ZbfhpwmY0PFSF50aGCIvPPv+ZmK8=
X-Received: by 2002:a5d:9812:: with SMTP id a18mr14220451iol.236.1548150656366;
 Tue, 22 Jan 2019 01:50:56 -0800 (PST)
MIME-Version: 1.0
References: <CAK3b1G+88a=xfO=6wfRi1SMy3xtca2NcFyxuBLKwSifb_L9xwA@mail.gmail.com>
 <20190117160752.GA29375@sigill.intra.peff.net> <CAK3b1GJPZ5X3uEP1a-NF9PZkE0tTKVLda5hM32jExVz_OD2E=g@mail.gmail.com>
 <20190118165800.GA9956@sigill.intra.peff.net> <20190118213458.GB28808@sigill.intra.peff.net>
 <20190118214626.GC28808@sigill.intra.peff.net> <CAGZ79kaPXQUY=FN3qusc2PNs=o1EiNarcBejOQKiozMSPvEOYw@mail.gmail.com>
 <20190122071921.GC28555@sigill.intra.peff.net>
In-Reply-To: <20190122071921.GC28555@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 22 Jan 2019 16:50:30 +0700
Message-ID: <CACsJy8ALL5_gHro9jZcSBnfnV01UEJLReCrqi+w727bkqnjUAA@mail.gmail.com>
Subject: Re: [PATCH] attr: do not mark queried macros as unset
To:     Jeff King <peff@peff.net>
Cc:     Stefan Beller <sbeller@google.com>,
        =?UTF-8?Q?S=C3=A9rgio_Peixoto?= <sergio.peixoto@gmail.com>,
        Brandon Williams <bwilliams.eng@gmail.com>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 22, 2019 at 2:19 PM Jeff King <peff@peff.net> wrote:
> Yes, that's the interesting part. I think I've convinced myself, too,
> that it doesn't do the _wrong_ thing ever. But I think it misses the
> point of the original, which is that you want common ones like "diff"
> not to trigger in_stack if nobody has actually used them.

Yes. I don't think it matters much when you don't have a lot of
attributes, but if you do, the cost of lookup will be proportional to
the stack's depth even whenever you look up some attribute, even
though you don't use it. This makes code that uses attributes just a
tiny bit slower over time because I think we still add more and more
attributes.

> And doing that
> really does mean marking in_stack not just when a macro mentions it
> (because clearly "binary" is going to mention it for every repo), but
> waiting to see if anybody mentions that macro.
>
> Which means we must call determine_macros(), and then propagate the
> macro's in_stack to its expansion (if it's indeed called at all).
>
> I don't think that would be _too_ hard to do. But I also wonder if
> there's much point. We are trying to avoid fill(), but I think that
> determine_macros() is of roughly the same complexity (look at all
> matches of all stacks). I guess it does avoid path_matches(), which is a
> bit more expensive. And in theory it could be cached for a particular
> stack top, so the work is amortized across many path lookups (though I
> think that gets even more tricky).

There is a comment that got eventually removed in bw/attr, especially
the second to last sentence.

-/*
- * NEEDSWORK: maybe-real, maybe-macro are not property of
- * an attribute, as it depends on what .gitattributes are
- * read.  Once we introduce per git_attr_check attr_stack
- * and check_all_attr, the optimization based on them will
- * become unnecessary and can go away.  So is this variable.
- */
-static int cannot_trust_maybe_real;

The promise here is, after we have moved away from global attribute
stack, we can build custom stacks containing only queried attributes.
This makes attribute stacks short (in the best case, empty, which is
what my optimization is for) which means fill time (I think it's
path_matches() would dominate) becomes shorter in the _general_ case,
so this optimization "will become unnecessary". More importantly the
total number of attributes will not matter since we only look at what
we are interested. This makes attribute lookup scale much better in
the long run.

This part, building custom stacks, has not come true yet. But if we
optimize this code again, I think this is the way forward. Perhaps
this could be one of the mini projects for Matthey's students. The
scope is relatively small, and optimization is always fun.
-- 
Duy
