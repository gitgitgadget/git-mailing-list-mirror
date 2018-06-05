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
	by dcvr.yhbt.net (Postfix) with ESMTP id AD8191F403
	for <e@80x24.org>; Tue,  5 Jun 2018 20:32:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751988AbeFEUcq (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Jun 2018 16:32:46 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36903 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751911AbeFEUcp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jun 2018 16:32:45 -0400
Received: by mail-wm0-f66.google.com with SMTP id r125-v6so7490766wmg.2
        for <git@vger.kernel.org>; Tue, 05 Jun 2018 13:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=pGx8y9rr58DLd2y8bHcaDwFoMriQTdhcwmfyHOSEBL4=;
        b=QUaSTqT17fZVRFmoURNh94vMwv7IQ4/Lm1aiBjRGBBUqMUwcFnyTBecoxJPxV0N5hq
         jmiiYIcN1OYxzzZH05/OCAF9UTNhhzNA7VkT+nB64wmvNMZpiJK9mi1t+HCWN3CWkpx4
         4AW7njwh8RgAxFUhPJyhFWMbis9JfwXcZGhVWIyDqxj78jWOYbDl9Rh3lV/Nw2/ssnpm
         /Z1dclgdwAdyXUHleBEmGuucp9OLceX6TtmD0cks+yXnAZRniSc++bCc6URgKHdGDh/l
         kiYpL0Sf9EBrkAcVx9pPFEYMrks1xe026CW91TX4f+6R/ia0Aojyt/yiTkGZd4DlIp+K
         +hgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=pGx8y9rr58DLd2y8bHcaDwFoMriQTdhcwmfyHOSEBL4=;
        b=fy9rIw8/OlkFXNOfe9bS0wZG+xvBfK+StCJ5P5JdTZjOoGqrWcQ+nbyF3QOhhYGZ6R
         zLWLPHfC9Epq5tUiJFAlwAQ3QY5C4cvsAdGkAPpg7zeTtaF414fyy47ErXMFYizxBa09
         2Ou9+S1KZW/yJ+jEK+2136eePKRlVpRhr8Wc7+QokjacmM5XwXVGell4RvjNEYKmWUTN
         IfRz8sJ4sbE1xM1U3b2JI8xdQ2xd+R8f3+jW3xRqkhBXQYyn/erv11gjSDjT9f8hrp6k
         bvbdZ6TmCOKOzVeeUKRJPtuH8JNryx5ZVBmOYneZvjJbDvr5p9eqZ+7OyRFtLJTq2E7V
         BT+g==
X-Gm-Message-State: APt69E1eAu/dUD2UxKlb/AHOG+BuOsXJ+sUSkR4P3DN5bJ9GN2WgkNrG
        ip5w7XHlYnYVAKBqW48mVRg12b/y
X-Google-Smtp-Source: ADUXVKJ7Bs5c7C+9qAY9C5l/oDew95Epx5hvuJH25fOcZtxEh4CUMXk0lwK24/CFyKdDmUbf5vKLkg==
X-Received: by 2002:a50:8743:: with SMTP id 3-v6mr610725edv.218.1528230764423;
        Tue, 05 Jun 2018 13:32:44 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id c20-v6sm4823572ede.3.2018.06.05.13.32.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Jun 2018 13:32:43 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/8] upload-pack: implement ref-in-want
References: <20180605175144.4225-1-bmwill@google.com> <20180605175144.4225-3-bmwill@google.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20180605175144.4225-3-bmwill@google.com>
Date:   Tue, 05 Jun 2018 22:32:42 +0200
Message-ID: <87po15ynx1.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jun 05 2018, Brandon Williams wrote:

> +uploadpack.allowRefInWant::
> +	If this option is set, `upload-pack` will support the `ref-in-want`
> +	feature of the protocol version 2 `fetch` command.
> +

I think it makes sense to elaborate a bit on what this is for. Having
read this series through, and to make sure I understood this, maybe
something like this:

   This feature is intended for the benefit of load-balanced servers
   which may not have the same view of what SHA-1s their refs point to,
   but are guaranteed to never advertise a reference that another server
   serving the request doesn't know about.

I.e. from what I can tell this gives no benefits for someone using a
monolithic git server, except insofar as there would be a slight
decrease in network traffic if the average length of refs is less than
the length of a SHA-1.

That's fair enough, just something we should prominently say.

It does have the "disadvantage", if you can call it that, that it's
introducing a race condition between when we read the ref advertisement
and are promised XYZ refs, but may actually get ABC, but I can't think
of a reason anyone would care about this in practice.

The reason I'm saying "another server [...] doesn't know about" above is
that 2/8 has this:

	if (read_ref(arg, &oid))
		die("unknown ref %s", arg);

Doesn't that mean that if server A in your pool advertises master, next
& pu, and you then go and fetch from server B advertising master & next,
but not "pu" that the clone will die?

Presumably at Google you either have something to ensure a consistent
view, e.g. only advertise refs by name older than N seconds, or globally
update ref name but not their contents, and don't allow deleting refs
(or give them the same treatment).

But that, and again, I may have misunderstood this whole thing,
significantly reduces the utility of this feature for anyone "in the
wild" since nothing shipped with "git" gives you that feature.

The naïve way to do slave mirroring with stock git is to have a
post-receive hook that pushes to your mirrors in a for-loop, or has them
fetch from the master in a loop, and then round-robin LB those
servers. Due to the "die on nonexisting" semantics in this extension
that'll result in failed clones.

So I think we should either be really vocal about that caveat, or
perhaps think of how we could make that configurable, e.g. what happens
if the server says "sorry, don't know about that one", and carries on
with the rest it does know about?

Is there a way for client & server to gracefully recover from that?
E.g. send "master" & "next" now, and when I pull again in a few seconds
I get the new "pu"?

Also, as a digression isn't that a problem shared with protocol v2 in
general? I.e. without this extension isn't it going to make another
connection to the naïve LB'd mirroring setup described above and find
that SHA-1s as well as refs don't match?

BREAK.

Also is if this E-Mail wasn't long enough, on a completely different
topic, in an earlier discussion in
https://public-inbox.org/git/87inaje1uv.fsf@evledraar.gmail.com/ I noted
that it would be neat-o to have optional wildmatch/pcre etc. matching
for the use case you're not caring about here (and I don't expect you
to, you're solving a different problem).

But let's say I want to add that after this, and being unfamiliar with
the protocol v2 conventions. Would that be a whole new
ref-in-want-wildmatch-prefix capability with a new
want-ref-wildmatch-prefix verb, or is there some less verbose way we can
anticipate that use-case and internally version / advertise
sub-capabilities?

I don't know if that makes any sense, and would be fine with just a
ref-in-want-wildmatch-prefix if that's the way to do it. I just think
it's inevitable that we'll have such a thing eventually, so it's worth
thinking about how such a future extension fits in.
