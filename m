Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 05C731F453
	for <e@80x24.org>; Fri,  5 Oct 2018 14:04:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728670AbeJEVDK (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Oct 2018 17:03:10 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41154 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727968AbeJEVDK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Oct 2018 17:03:10 -0400
Received: by mail-wr1-f65.google.com with SMTP id x12-v6so13682660wru.8
        for <git@vger.kernel.org>; Fri, 05 Oct 2018 07:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=l/UrWyLdKTmuDGw5+RZoV6cXZJfakYPyJOIsBNzRPzw=;
        b=YG95qnjRI1PBFxxfBqwiLSDW6ILDXlaInfmKIHVoGM2HGRr0CTS9RXG1v5yJDjaUA5
         5pdLjzpyGqIJGV1BQqEt1Z7TfJsmm2A7+etoTUmdXnlwMfmviHx9KyiPX4blAK6pCzXq
         NZ7byagEGzfmjIDGh4hYquuZRy8kOYFgo33x6E4NNNUEmYULe9xqBoPgJyJTGo0uVrsq
         fL1rcQwPKG9GT7jTBFplHBQgfEkTm8Cji+2cg9vC4Z7rmoLhMyvAKwKlEEkoHOthCt+F
         i3ujiAzwrrUkwYIdpsx/QJ0bevF7k03oT6yDTyfBYIZDMgOo9lmWtxK0iExkPWlTNig3
         01Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=l/UrWyLdKTmuDGw5+RZoV6cXZJfakYPyJOIsBNzRPzw=;
        b=NN4Ek4klaeFrrKavNwcebNXwMxK8CY6xO+UhH4rb9on95+bxvcX/IpyIPSl1UYA1M2
         pqEBTB904iBgQ9AhnLLMIEp/YTsUl59svl4hfXF9KabYpDjCI3FQjes06/F5D6XFovwn
         wUl9K0EsYV8SgMF7baLHvo2Pj+9JdkXeLZCqQx5T2H704pLlKj9QXBPmIJ7u5pVoFh2p
         us5eyKZNsR4/vXD06ov10rmo7zsb/16KU67q539zkqtvOsynpd3KmNXHdCMYWIPbwdSC
         k7IK4d94pTDgZN722iqj+lMazVMcY3F9WKjhZfQECHImL50Ayd/hYZu7Y8zf+DLxS0bK
         OWPg==
X-Gm-Message-State: ABuFfogKo/1n1S28msoTPJ9Uzxv7XWLkMoELX27uH3l0om61gsAd58qs
        JTZHeCRslWZyM1VgMOnAuQ77wHJ/
X-Google-Smtp-Source: ACcGV62bjmjt6dPko7ahw72J6Fh5qcL6wRrqC+omXXnWGOVsS5whuzAArfrZjytDF5ovGI9oISQgCw==
X-Received: by 2002:adf:be07:: with SMTP id n7-v6mr7919024wrh.267.1538748255426;
        Fri, 05 Oct 2018 07:04:15 -0700 (PDT)
Received: from evledraar (proxy-gw-a.booking.com. [5.57.21.8])
        by smtp.gmail.com with ESMTPSA id g76-v6sm2480527wmd.25.2018.10.05.07.04.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Oct 2018 07:04:14 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>
Subject: Re: [RFC PATCH] We should add a "git gc --auto" after "git clone" due to commit graph
References: <87tvm3go42.fsf@evledraar.gmail.com> <87in2hgzin.fsf@evledraar.gmail.com> <dcb8f115-ce3c-64fa-50cc-dd03569c0164@gmail.com> <87ftxkh7bf.fsf@evledraar.gmail.com> <05fefab0-4012-4ef0-5df1-2430eea2bf4d@gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <05fefab0-4012-4ef0-5df1-2430eea2bf4d@gmail.com>
Date:   Fri, 05 Oct 2018 16:04:13 +0200
Message-ID: <87efd4h4ma.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Oct 05 2018, Derrick Stolee wrote:

> On 10/5/2018 9:05 AM, Ævar Arnfjörð Bjarmason wrote:
>> On Fri, Oct 05 2018, Derrick Stolee wrote:
>>
>>> On 10/4/2018 5:42 PM, Ævar Arnfjörð Bjarmason wrote:
>>>> I don't have time to polish this up for submission now, but here's a WIP
>>>> patch that implements this, highlights:
>>>>
>>>>    * There's a gc.clone.autoDetach=false default setting which overrides
>>>>      gc.autoDetach if 'git gc --auto' is run via git-clone (we just pass a
>>>>      --cloning option to indicate this).
>>> I'll repeat that it could make sense to do the same thing on clone
>>> _and_ fetch. Perhaps a "--post-fetch" flag would be good here to
>>> communicate that we just downloaded a pack from a remote.
>> I don't think that makes sense, but let's talk about why, because maybe
>> I've missed something, you're certainly more familiar with the
>> commit-graph than I am.
>>
>> The reason to do it on clone as a special-case or when the file is
>> missing, is because we know the file is desired (via the GC config), and
>> presumably is expected to help performance, and we have 0% of it. So by
>> going from 0% to 100% on clone we'll get fast --contains and other
>> goodies the graph helps with.
>>
>> But when we're doing a fetch, or really anything else that runs "git gc
>> --auto" we can safely assume that we have a recent enough graph, because
>> it will have been run whenever auto-gc kicked in.
>>
>> I.e.:
>>
>>      # Slow, if we assume background forked commit-graph generation
>>      # (which I'm avoiding)
>>      git clone x && cd x && git tag --contains
>>      # Fast enough, since we have an existing commit-graph
>>      cd x && git fetch && git tag --contains
>>
>> I *do* think it might make sense to in general split off parts of "gc
>> --auto" that we'd like to be more aggressive about, simply because the
>> ratio of how long it takes to do, and how much it helps with performance
>> makes more sense than a full repack, which is what the current heuristic
>> is based on.
>>
>> And maybe when we run in that mode we should run in the foreground, but
>> I don't see why git-fetch should be a special case there, and in this
>> regard, the gc.clone.autoDetach=false setting I've made doesn't make
>> much sence. I.e. maybe we should also skip forking to the background in
>> such a mode when we trigger such a "mini gc" via git-commit or whatever.
>
> My misunderstanding was that your proposed change to gc computes the
> commit-graph in either of these two cases:
>
> (1) The auto-GC threshold is met.
>
> (2) There is no commit-graph file.
>
> And what I hope to have instead of (2) is (3):
>
> (3) The commit-graph file is "sufficiently behind" the tip refs.
>
> This condition is intentionally vague at the moment. It could be that
> we hint that (3) holds by saying "--post-fetch" (i.e. "We just
> downloaded a pack, and it probably contains a lot of new commits") or
> we could create some more complicated condition based on counting
> reachable commits with infinite generation number (the number of
> commits not in the commit-graph file).
>
> I like that you are moving forward to make the commit-graph be written
> more frequently, but I'm trying to push us in a direction of writing
> it even more often than your proposed strategy. We should avoid
> creating too many orthogonal conditions that trigger the commit-graph
> write, which is why I'm pushing on your design here.
>
> Anyone else have thoughts on this direction?

Ah. I see. I think #3 makes perfect sense, but probably makes sense to
do as a follow-up, or maybe you'd like to stick a patch on top of the
series I have when I send it. I don't know how to write the "I'm not
quite happy about the commit graph" code :)

What I will do is refactor gc.c a bit and leave it in a state where it's
going to be really easy to change the existing "we have no commit graph,
and thus should do the optimization step" to have some more complex
condition instead of "we have no commit graph", i.e. your "we just
grabbed a lot of data".

Also, I'll drop the gc.clone.autoDetach=false setting and name it
something more general. maybe gc.AutoDetachOnBigOptimization=false?
Anyway something more generic so that "clone" will always pass in some
option saying "expect a large % commit graph update" (100% in its case),
and then in "fetch" we could have some detection of how big what we just
got from the server is, and do the same.

This seems to be to be the most general thing that would make sense, and
could also be extended e.g. to "git commit" and other users of gc
--auto. If I started with a README file in an empty repo, and then made
a commit where I added 1 million files all in one commit, in which case
we'd (depending on that setting) also block in the foreground and
generate the commit-graph.
