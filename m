Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 25B261F70F
	for <e@80x24.org>; Fri, 27 Jan 2017 00:27:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753333AbdA0A1X (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Jan 2017 19:27:23 -0500
Received: from mail-pf0-f181.google.com ([209.85.192.181]:35779 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753210AbdA0A1W (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jan 2017 19:27:22 -0500
Received: by mail-pf0-f181.google.com with SMTP id f144so68912225pfa.2
        for <git@vger.kernel.org>; Thu, 26 Jan 2017 16:26:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=/FHBvtmiJApexgpVnfJ7X8e4FPKB8xgiwBUmdQYEX3Y=;
        b=TnVbI5H2VJns9biOihHzE0M06fveLYH6AZpX20xYY16mqUgCpwuXB6ixVvFacwFq/v
         h9fyKvKs8D4Y6vK7RWFx/m2MWQKsYQpz/iNtKNkWNQx0k2lSKFllbOJWYW9eNh3aZmeK
         lWMpRvAl044A4n4FkaPkkfKt7xDtn2JF5umlrX6oOCvXHKqapIV9gO0rhqKmljSbFzGe
         iAj07IksY9jtNY56dup0mV6auQKhMIN6a8bobKqwVlmW8bcs6Kfj+OiaBPTmXvI7ZzjK
         BYwPQhPLR34MPwtv0QNUvc8wPViyTNl8f0ln4d/TO0LqcvCdflXWXtxS299mzTnPmP6w
         Ofpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=/FHBvtmiJApexgpVnfJ7X8e4FPKB8xgiwBUmdQYEX3Y=;
        b=LISRxMppHEtx7FIcmHAm3kIh0iM7TEFSPvGmd986gVr/wphTYU4fWfmHgHb3Du79ER
         EsElqxeKqkI/YXSr7s5sBzIkfGeSS/T0IppP+bSFJjddV4/eFXAU09j/8gG1obMQGhls
         s4nxm+BKIAHOJ1r6j0UvyeWYToHPOaoRDlqUP5rat5YvHaLoBU9g1bot0BTW6L/3Y+sa
         E/pb0yCWiZ5rQ1IpzfeKB6LwAijbC1gLhbp3EaFV3So3fjkRpXWrxT9apyI+x0QgOPqS
         0I+tNajqXhubqHvca668U68mrixglFoinJH9R+CoFaNM052mAWIpI0K6y8u0jcL5Saqr
         YX9w==
X-Gm-Message-State: AIkVDXKUCsxu69uvYpC8A9NjA1R2ia/QCnutpUj2JWdkccizS3RY+OA2bULWR3rYEF0vi+iH
X-Received: by 10.98.215.70 with SMTP id v6mr6091642pfl.141.1485476808682;
        Thu, 26 Jan 2017 16:26:48 -0800 (PST)
Received: from twelve2.mtv.corp.google.com ([2620:0:1000:5b10:f0de:f19e:2597:5e36])
        by smtp.gmail.com with ESMTPSA id w76sm5984071pfd.74.2017.01.26.16.26.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Jan 2017 16:26:47 -0800 (PST)
Subject: Re: [RFC 00/14] Allow fetch-pack to send ref names (globs allowed)
To:     Jeff King <peff@peff.net>
References: <cover.1485381677.git.jonathantanmy@google.com>
 <20170126230046.aknesybfyzxhx3ia@sigill.intra.peff.net>
Cc:     git@vger.kernel.org
From:   Jonathan Tan <jonathantanmy@google.com>
Message-ID: <67afbb3b-5d0b-8c0d-3f6e-3f559c68f4bd@google.com>
Date:   Thu, 26 Jan 2017 16:26:47 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <20170126230046.aknesybfyzxhx3ia@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for your comments.

On 01/26/2017 03:00 PM, Jeff King wrote:
> On Wed, Jan 25, 2017 at 02:02:53PM -0800, Jonathan Tan wrote:
>
>> Negotiation currently happens by upload-pack initially sending a list of
>> refs with names and SHA-1 hashes, and then several request/response
>> pairs in which the request from fetch-pack consists of SHA-1 hashes
>> (selected from the initial list). Allowing the request to consist of
>> names instead of SHA-1 hashes increases tolerance to refs changing
>> (due to time, and due to having load-balanced servers without strong
>> consistency),
>
> Interesting. My big question is: what happens when a ref _does_ change?
> How does the client handle this?
>
> The existing uploadpack.allowReachableSHA1InWant is there to work around
> the problem that an http client may get a ref advertisement in one step,
> and then come back later to do the want/have negotiation, at which point
> the server has moved on (or maybe it's even a different server). There
> the client says "I want sha1 X", and the server needs to say "well, X
> isn't my tip now, but it's still acceptable for you to fetch".
>
> But this seems to go in the opposite direction. After the advertisement,
> the client decides "OK, I want to fetch refs/heads/master which is at
> SHA1 X". It connects to the server and says "I want refs/heads/master".
> Let's say the server has moved its version of the ref to SHA1 Y.
>
> What happens? I think the server will say "wanted-ref master Y". Does
> the client just decide to use "Y" then?  How does that interact with any
> decisions the client might have made about X? I guess things like
> fast-forwards have to be decided after we fetch the objects anyway
> (since we cannot compute them until we get the pack), so maybe there
> aren't any such decisions. I haven't checked.

Yes, the server will say "wanted-ref master Y". The relevant code 
regarding the decisions the client makes regarding X or Y is in do_fetch 
in builtin/fetch.c.

There, I can see these decisions done using X:
  - check_not_current_branch (forbidding fetching that modifies the
    current branch) (I just noticed that this has to be done for Y too,
    and will do so)
  - prune refs [*]
  - automatic tag following [*]

[*] X and Y may differ in that one relevant ref appears in one set but 
not in the other (because a ref was added or removed in the meantime), 
causing a different result if these decisions were to be done using Y, 
but I think that it is OK either way.

Fetch optimizations (for example, everything_local in fetch-pack.c) that 
check if the client really needs to fetch are also done using X, of 
course (and if the optimization succeeds, there is no Y).

Fast-forwards (and everything else in store_updated_refs) are decided 
using Y.

>> and is a step towards eliminating the need for the server
>> to send the list of refs first (possibly improving performance).
>
> I'm not sure it is all that useful towards that end. You still have to
> break compatibility so that the client tells the server to suppress the
> ref advertisement. After that, it is just a question of asking for the
> refs. And you have two options:
>
>   1. Ask the server to tell you the values of some subset of the refs,
>      pick what you want, and then do the want/have as normal.
>
>   2. Go straight to the want/have, but tell the server the refs you want
>      instead of their sha1s.
>
> I think your approach here would lead to (2).
>
> But (1), besides being closer to how the protocol works now, seems like
> it's more flexible. I can ask about the ref state without necessarily
> having to retrieve the objects. How would you write git-ls-remote with
> such a system?

Assuming a new protocol with the appropriate backwards compatibility 
(which would have to be done for both options), (2) does save a 
request/response pair (because we can send the ref names directly as 
"want-ref" in the initial request instead of sending ref names in the 
initial request and then confirming them using "want <SHA-1>" in the 
subsequent request). Also, (2) is more tolerant towards refs changing 
over time. (1) might be closer to the current protocol, but I think that 
the difference is not so significant (only in "want-ref" vs "want" 
request and the "wanted-ref" response).

As for git-ls-remote, I currently think that it would have to use the 
existing protocol.

>> [1] There has been some discussion about whether the server should
>> accept partial ref names, e.g. [2]. In this patch set, I have made the
>> server only accept full names, and it is the responsibility of the
>> client to send the multiple patterns which it wants to match. Quoting
>> from the commit message of the second patch:
>>
>>   For example, a client could reasonably expand an abbreviated
>>   name "foo" to "want-ref foo", "want-ref refs/heads/foo", "want-ref
>>   refs/tags/foo", among others, and ensure that at least one such ref has
>>   been fetched.
>
> That has a cost that scales linearly with the number of refs, because
> you have to ask for each name 6 times.  After the discussion you linked,
> I think my preference is more like:
>
>   1. Teach servers to accept a list of patterns from the client
>      which will be resolved in order. Unlike your system, the client
>      only needs to specify the list once per session, rather than once
>      per ref.
>
>   2. (Optional) Give a shorthand for the stock patterns that git has had
>      in place for years. That saves some bytes over specifying the
>      patterns completely (though it's really not _that_ many bytes, so
>      perhaps the complication isn't a big deal).

I envision that most fetches would be done on a single name (with or 
without globs), that expands to 5 (so it is not so crucial to factor out 
the list of patterns). Having said that, I am open to changing this.
