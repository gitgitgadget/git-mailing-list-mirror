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
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A86F1F403
	for <e@80x24.org>; Wed,  6 Jun 2018 22:42:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752937AbeFFWml (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Jun 2018 18:42:41 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:52243 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752141AbeFFWmk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jun 2018 18:42:40 -0400
Received: by mail-wm0-f66.google.com with SMTP id p126-v6so14380059wmb.2
        for <git@vger.kernel.org>; Wed, 06 Jun 2018 15:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=U0J0ose9DdkdYttJM0UqWGejknZ0n7y3dDhLve/j0Ks=;
        b=hqXYVxQc/IEBnuXKb2qfMQ7Bgjlm933Pz/tipH8hBCb8VI+SMnjRnuhSmFlRb+e/vs
         Er6eTmEp4o48LMSOiLEaRYQJf+eibeK/1yAPgLq2dhVF8X652BTRd2A/Fi+vpHKragEJ
         i9iCWKmuBRD6XueAj7s6OcGKluuGZyc2EJWSpAjaaNEQP9boW8teo90akUV07epZ757D
         LUcZqjAvrEc8HMlHRUvqKNrLrzthD98VxvyRf2kt5xREPDELw8yDuI50T74JTCu3mlOY
         /J7u20uAZrZydhWjpJWbCEG7fY8uegLrHieOmCb9Wo9+K6jb/w2KRLYmm5ptVMEINCqD
         8gpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=U0J0ose9DdkdYttJM0UqWGejknZ0n7y3dDhLve/j0Ks=;
        b=j6N27ebLly1fS2Rms+40AyLrr6jQsk/03PtnB8z7W+RRJQgbpwSFNU6MY1oIe6doeO
         klVbaOdq97XukGplknFV7ArjiHmMR6ucbbEQvVBZJWnl7zgwnDpAyWbKXbX5xr8AbE3w
         drDtq15n57Dz37KnuU6sMkhiNB9GD3MON7o+vxs3PU68MZ/Jt6TVwkZphdJavLW1jlUH
         ImW4RuLRmmcihimdTjJ6boTcepf6v7MFCIW9Jlre0P315Nl3P6IUUJnbfWHsdTE7Q39k
         MEItjr0pLtoNRmqCjUgSw9L2MyQsGoU38EGERCcXk8aCD1Z6sAONk5G5e5OT0fEQ6gxX
         BwOQ==
X-Gm-Message-State: APt69E3UJz7WpZqwNFq57V83C+KIWbxB0JeEC6L5zl/u6XqpBWGIDBcI
        Mx/5tRmRJ0Qw4s/I5CN6r72bX97Q
X-Google-Smtp-Source: ADUXVKIAehitlJFxFDuR/Z6RHwMTtY7Ho+42lNiOT0qatSnjFCp5PApV1t0Bn/AYm2QawmxTDLL5+Q==
X-Received: by 2002:a50:a2c7:: with SMTP id 65-v6mr5655867edm.136.1528324958882;
        Wed, 06 Jun 2018 15:42:38 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id d4-v6sm27505983edp.11.2018.06.06.15.42.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Jun 2018 15:42:36 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/8] upload-pack: implement ref-in-want
References: <20180605175144.4225-1-bmwill@google.com> <20180605175144.4225-3-bmwill@google.com> <87po15ynx1.fsf@evledraar.gmail.com> <20180606213213.GA154134@google.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20180606213213.GA154134@google.com>
Date:   Thu, 07 Jun 2018 00:42:36 +0200
Message-ID: <87d0x3zgdf.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jun 06 2018, Brandon Williams wrote:

> On 06/05, Ævar Arnfjörð Bjarmason wrote:
>>
>> On Tue, Jun 05 2018, Brandon Williams wrote:
>>
>> > +uploadpack.allowRefInWant::
>> > +	If this option is set, `upload-pack` will support the `ref-in-want`
>> > +	feature of the protocol version 2 `fetch` command.
>> > +
>>
>> I think it makes sense to elaborate a bit on what this is for. Having
>> read this series through, and to make sure I understood this, maybe
>> something like this:
>>
>>    This feature is intended for the benefit of load-balanced servers
>>    which may not have the same view of what SHA-1s their refs point to,
>>    but are guaranteed to never advertise a reference that another server
>>    serving the request doesn't know about.
>>
>> I.e. from what I can tell this gives no benefits for someone using a
>> monolithic git server, except insofar as there would be a slight
>> decrease in network traffic if the average length of refs is less than
>> the length of a SHA-1.
>
> Yeah I agree that the motivation should probably be spelled out more,
> thanks for the suggestion.
>
>>
>> That's fair enough, just something we should prominently say.
>>
>> It does have the "disadvantage", if you can call it that, that it's
>> introducing a race condition between when we read the ref advertisement
>> and are promised XYZ refs, but may actually get ABC, but I can't think
>> of a reason anyone would care about this in practice.
>>
>> The reason I'm saying "another server [...] doesn't know about" above is
>> that 2/8 has this:
>>
>> 	if (read_ref(arg, &oid))
>> 		die("unknown ref %s", arg);
>>
>> Doesn't that mean that if server A in your pool advertises master, next
>> & pu, and you then go and fetch from server B advertising master & next,
>> but not "pu" that the clone will die?
>>
>> Presumably at Google you either have something to ensure a consistent
>> view, e.g. only advertise refs by name older than N seconds, or globally
>> update ref name but not their contents, and don't allow deleting refs
>> (or give them the same treatment).
>>
>> But that, and again, I may have misunderstood this whole thing,
>> significantly reduces the utility of this feature for anyone "in the
>> wild" since nothing shipped with "git" gives you that feature.
>>
>> The naïve way to do slave mirroring with stock git is to have a
>> post-receive hook that pushes to your mirrors in a for-loop, or has them
>> fetch from the master in a loop, and then round-robin LB those
>> servers. Due to the "die on nonexisting" semantics in this extension
>> that'll result in failed clones.
>>
>> So I think we should either be really vocal about that caveat, or
>> perhaps think of how we could make that configurable, e.g. what happens
>> if the server says "sorry, don't know about that one", and carries on
>> with the rest it does know about?
>
> Jonathan actually pointed this out to me earlier and I think the best
> way to deal with this is to just ignore the refs that the server doesn't
> know about instead of dying here. I mean its no worse than what we
> already have and we shouldn't hit this case too often.  And that way the
> fetch can still proceed.
>
>>
>> Is there a way for client & server to gracefully recover from that?
>> E.g. send "master" & "next" now, and when I pull again in a few seconds
>> I get the new "pu"?
>
> I think in this case the client would just need to wait for some amount
> of replication delay and attempt fetching at a later point.
>
>>
>> Also, as a digression isn't that a problem shared with protocol v2 in
>> general? I.e. without this extension isn't it going to make another
>> connection to the naïve LB'd mirroring setup described above and find
>> that SHA-1s as well as refs don't match?
>
> This is actually an issue with fetch using either v2 or v0.  Unless I'm
> misunderstanding what you're asking here.

Isn't the whole dialog in v1 guaranteed to be with one server from
intial ref advertisement to the client saying have/want, or is that just
with ssh?

In any case the reason the above is an issue here is because you're
getting the advertisement from a different server than you're
negotiating the pack with, right?

>>
>> BREAK.
>>
>> Also is if this E-Mail wasn't long enough, on a completely different
>> topic, in an earlier discussion in
>> https://public-inbox.org/git/87inaje1uv.fsf@evledraar.gmail.com/ I noted
>> that it would be neat-o to have optional wildmatch/pcre etc. matching
>> for the use case you're not caring about here (and I don't expect you
>> to, you're solving a different problem).
>>
>> But let's say I want to add that after this, and being unfamiliar with
>> the protocol v2 conventions. Would that be a whole new
>> ref-in-want-wildmatch-prefix capability with a new
>> want-ref-wildmatch-prefix verb, or is there some less verbose way we can
>> anticipate that use-case and internally version / advertise
>> sub-capabilities?
>>
>> I don't know if that makes any sense, and would be fine with just a
>> ref-in-want-wildmatch-prefix if that's the way to do it. I just think
>> it's inevitable that we'll have such a thing eventually, so it's worth
>> thinking about how such a future extension fits in.
>
> Yes back when introducing the server-side ref filtering in ls-refs we
> originally talked about included wildmatch or other forms of pattern
> matching.  We opted to not over complicate things and favored prefix
> matching because it didn't bake in some subset of globbing or regex and
> it was easier to compute on the server side.
>
> Anyway back to your question.  Yes if at some point in the future we
> wanted to add in wildmatch/pcre to the protocol for ls-refs or for
> ref-in-want then it could be added as a feature or capability.  I don't
> think it would require adding a whole new verb (it probably would for
> the ls-refs case since the verb used there is "ref-prefix") but the
> capability could mean that the "want-ref" verb now understands wildmatch
> patterns in addition to fully qualified refs.

Probably still makes sense to have it be a different verb since some
things in wildmatch / regex are metachars but may be valid in ref names.

Thanks!
