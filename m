Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C708202DD
	for <e@80x24.org>; Wed, 25 Oct 2017 13:09:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750974AbdJYNJS (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Oct 2017 09:09:18 -0400
Received: from mail-qk0-f171.google.com ([209.85.220.171]:51481 "EHLO
        mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750788AbdJYNJQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Oct 2017 09:09:16 -0400
Received: by mail-qk0-f171.google.com with SMTP id 17so30326857qkq.8
        for <git@vger.kernel.org>; Wed, 25 Oct 2017 06:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=/9yJT38BAAEwV6m/vJR//Gpo2b/Z44bUA5YoY/Q86SU=;
        b=NlD2BGGM2Egz9f5AOUxm1D2zPq9J+4+m6rHAKv1EN68Qpl117/zpSGyfiq4yzH0rda
         aYxaeBcXZqPYBo9mSf6xnA5InBsvPRfxLoGPKL+RC3IgQ+TCwFUOlko9E5qDAANKb/H0
         3iQS/RNQujBHOjdlBO/4uYnkbgHdFUIY7iDvD9CkfYRTNb8qsdb+M8rcaNMoC8Y9HCyG
         27XmZuIZZ+cSEKG1RtQ9dbSY7hv0r2xRoJPFLHh+7Pc07Sy1jI5TwprdwqQxw6CMV1jW
         MWBbG6rzamWsIrPO5LkVUAC/lJaCW+M+NEOAmUoOuBJKBq4Z75V0iBAs7hYL2X34ctPQ
         7/+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=/9yJT38BAAEwV6m/vJR//Gpo2b/Z44bUA5YoY/Q86SU=;
        b=pVDmcKjjInPjkCp+Msw6eqkrH+v1tgZCPHJ6DiBNkVWotpI3KlxYgEgaXwJsBQo/HW
         emZxaEt1nemCDWoLbWor+6VBA6C371fQAftBQKjD8ddThT/cuULKfJjuKQ0hkL0gKDl5
         Jtfji05ydzdir5tsTme3puu1e794V7qY0hrQTb1sB2feUu9oH2V7AqC4xtG9vEwNG16j
         7vPn6/ROyoVPMuINmB6onFL5H8AkD6d5t5HWkknQ+acKfYUvxytd9NTZxeue4bMt/MBA
         YUwrO14/Lh2bovZZQ4rSOiqbSwKkvrRWmjppwkQDl5ebCUEq/XmYQQSIdkmP/FwHgF3O
         yoVQ==
X-Gm-Message-State: AMCzsaWQwmJBzoI/pi+S3exvB+FiiWMUXHdjk8m9H+xq8tdU6ishOG0f
        b007AF7DDxqk7R7QtTS5V2g=
X-Google-Smtp-Source: ABhQp+SMLFlKJES7rdcf8alyoM+hwza1SfQ8cN4toE88e8d0ahFROfk+8K+AGwVC8V1NuWErv+8VZg==
X-Received: by 10.55.159.88 with SMTP id i85mr2904223qke.350.1508936955863;
        Wed, 25 Oct 2017 06:09:15 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010::7cc])
        by smtp.gmail.com with ESMTPSA id m6sm1779016qkh.90.2017.10.25.06.09.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Oct 2017 06:09:15 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
Subject: Re: [RFC] protocol version 2
To:     Brandon Williams <bmwill@google.com>, git@vger.kernel.org
Cc:     spearce@spearce.org, git@jeffhostetler.com, gitster@pobox.com,
        jonathantanmy@google.com, jrnieder@gmail.com, peff@peff.net,
        sbeller@google.com
References: <20171020171839.4188-1-bmwill@google.com>
Message-ID: <0ba57a04-9321-e765-ed19-3d0e68e1edc0@gmail.com>
Date:   Wed, 25 Oct 2017 09:09:12 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20171020171839.4188-1-bmwill@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/20/2017 1:18 PM, Brandon Williams wrote:
>   Overview
> ==========
>
> This document presents a specification for a version 2 of Git's wire
> protocol.  Protocol v2 will improve upon v1 in the following ways:
>
>    * Instead of multiple service names, multiple commands will be
>      supported by a single service
>    * Easily extendable as capabilities are moved into their own section
>      of the protocol, no longer being hidden behind a NUL byte and
>      limited by the size of a pkt-line (as there will be a single
>      capability per pkt-line).
>    * Separate out other information hidden behind NUL bytes (e.g. agent
>      string as a capability and symrefs can be requested using 'ls-ref')
>    * Ref advertisement will be omitted unless explicitly requested
>    * ls-ref command to explicitly request some refs

Hi Brandon,

I'm very interested in your protocol as a former server-side dev for the 
VSTS Git server, and understand some of these headaches. We built 
limited refs specifically to target the problem you are solving with 
ls-ref, but it requires knowledge about the authenticated user in order 
to work. I believe your suggestion is a better solution for the Git 
protocol.

The "easily extendable" part has specifically caught my interest, as we 
(Microsoft) would like to move most of the GVFS protocol into core Git, 
and this is a great way to do it. Even if not all features are accepted 
by upstream, we could use our GVFS-specific fork of Git to communicate 
to our servers without breaking normal users' interactions.

Please CC me in future versions of this proposal. Let me know if you 
want to chat directly about the "TODO" items below.

Speaking of TODOs, how much of this concept do you have working in a 
prototype? Do you have code that performs this version 2 handshake and 
communicates the ls-refs result?

>   Ls-refs
> ---------
>
> Ls-refs can be looked at as the equivalent of the current ls-remote as
> it is a way to query a remote for the references that it has.  Unlike
> the current ls-remote, the filtering of the output is done on the server
> side by passing a number of parameters to the server-side command
> instead of the filtering occurring on the client.
>
> Ls-ref takes in the following parameters:
>
>    --head, --tags: Limit to only refs/heads or refs/tags

Nit: It would be better to use "--heads" to match refs/heads and your 
use of "--tags" for refs/tags.

>    --refs: Do not show peeled tags or pseudorefs like HEAD

Assuming we are in the case where the server has a HEAD ref, why would 
that ever be advertised? Also, does this imply that without the --refs 
option we would peel annotated tags until we find non-tag OIDs? Neither 
of these functions seem useful as default behavior.

>    --symref: In addition to the object pointed by it, show the underlying
>              ref pointed by it when showing a symbolic ref
>    <refspec>: When specified, only references matching the given patterns
>               are displayed.

Can you be specific about the patterns? For instance, it is not a good 
idea to allow the client to submit a regex for the server to compute. 
Instead, can we limit this pattern-matching to a prefix-set, such as the 
following list of prefixes:

     refs/heads/master
     refs/releases/*
     refs/heads/user/me/*
>   Fetch
> -------
>
> Fetch will need to be a modified version of the v1 fetch protocol.  Some
> potential areas for improvement are: Ref-in-want, CDN offloading,
> Fetch-options.
>
> Since we'll have an 'ls-ref' service we can eliminate the need of fetch
> to perform a ref-advertisement, instead a client can run the 'ls-refs'
> service first, in order to find out what refs the server has, and then
> request those refs directly using the fetch service.
>
> //TODO Flush out the design
>
>   Fetch-object
> --------------
>
> This service could be used by partial clones in order to request missing
> objects.
>
> //TODO Flush out the design

As you flesh our these "fetch" and "fetch-object" commands, keep in mind 
that partial clones could mean any of the following:

  * fetch all reachable objects except for blobs.

  * fetch all reachable objects except for blobs above a
    certain size.

  * fetch all commits, trees, (and blobs?) within a certain
    "cone" of the file system.

>   Push
> ------
>
> Push will need to be a modified version of the v1 push protocol.  Some
> potential areas for improvement are: Fix push-options, Negotiation for
> force push.

Negotiation is something to keep in mind for all pushes, especially in 
an ecosystem full of fork-based workflows. If you are working across 
forks and someone else syncs data between your remotes, you may re-push 
a large chunk of objects that are already present in a fork. Adding an 
ls-refs step before push would be a step in the right direction.
>   Other Considerations
> ======================
>
>    * Move away from pkt-line framing?
>    * Have responses structured in well known formats (e.g. JSON)
>    * Eliminate initial round-trip using 'GIT_PROTOCOL' side-channel
>    * Additional commands in a partial clone world (e.g. log, grep)

[Tangent]

I too have thought about making calls like "log" and "blame" available 
for calling remotes. One reason GVFS sends a "prefetch pack" of _all_ 
commits and trees is because one "git log -- path/to/file" command would 
start downloading thousands of objects one at a time as the walk moves 
through the history. If the remote can compute the commands that require 
historical data, then our partial clones can be more "pure" (i.e. only 
contain objects required for the user's changes).

One major caveat: if someone runs "log" from HEAD, then they may be 
working over data that is not on the remote, which means they would need 
to start the history walk until reaching commits that are known to be on 
the remote. If there are merges in the local history, then this could 
include multiple independent commits.

Further complicating this area, the server may not want to allow certain 
types of commands (i.e. regexes, expensive history options like 
"--simplify-merges").

In conclusion, I think it is a great idea to have the protocol allow 
these extensions, especially in a way that is easy to extend without 
breaking client/server compat scenarios (after both have v2 enabled).

[End Tangent]

Thanks,
-Stolee

