Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DECE21F70F
	for <e@80x24.org>; Fri, 27 Jan 2017 00:35:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752630AbdA0Afe (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Jan 2017 19:35:34 -0500
Received: from mail-pg0-f50.google.com ([74.125.83.50]:34756 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752130AbdA0Afd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jan 2017 19:35:33 -0500
Received: by mail-pg0-f50.google.com with SMTP id 14so76465819pgg.1
        for <git@vger.kernel.org>; Thu, 26 Jan 2017 16:35:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=0I0D4Y+UBW9za/7Nvk/Bc5IILsy03TNZDMDrfJ0HKiM=;
        b=I8zKZLTC4zqc5EOQC6zCzkXnCxnoKZZDgRgODGwaSsO8m2GUt9a1ibbfxfkTRlln9G
         EBbvKYQ8XEESi8X2YjFkro+7IOHGqW7QyWK2bI8SWVa/1svkEHM5pmN0ri6UL3gdbnWz
         JCWDDzBjCJRjxbCzXrrQWHZeFXyZgQEWgKPyROa0kVlUkz4bi5mQXzoJeSUNE8qgvBSj
         cjwx376z4wtFlgRrWNSVQ2p2AHaWTeUZFmuCasXtoQZ0mm4OHUn1HsnMpkFp/xywYYtV
         FT7oHLZb9vhsKsZjAxVdtB8E3hpYW/cmrNtkIgyiZI0RvSjLz/rFyGgaldP9aIp/QKOF
         g5zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=0I0D4Y+UBW9za/7Nvk/Bc5IILsy03TNZDMDrfJ0HKiM=;
        b=UAY4fOPMElhNJPcmMKDRrEXgqBCRtW8KBkysaWQQKSyR3IfH/Msb91aAPMo25BuPq+
         WY54hmMH2Ck8Uzh9J6FvVT/20Ncse5Fa+36InDaTX7bDF04WERCxxOxji6fCKrIDYSvb
         6g4yDQtoC/sXd1nrNuLyJfP5cK8cvE/IX9aQp7rTtKFx1+LHdxDJaRnzXhn/965XKvmQ
         PR9nEqAzhxlnZg2IXg9ZThVHC3Fzc5tBmUxRpRzY7SsPVXwd0qkIS95cN7UUYv7KDEeW
         2fDYAbm6h03Eg7gzSPXS+vCnJO1Pn41iqtgypBpK9jCRgCMfrsGU7KhYJjZPasPMpEbD
         bEOA==
X-Gm-Message-State: AIkVDXKX1gECPWAN0QClbb38AGF2BJzZKAj1Ed2vz2x1XHEQNMDeFWeTFgQa3bSM4uaLFxgY
X-Received: by 10.98.75.16 with SMTP id y16mr6201740pfa.23.1485477332615;
        Thu, 26 Jan 2017 16:35:32 -0800 (PST)
Received: from twelve2.mtv.corp.google.com ([2620:0:1000:5b10:f0de:f19e:2597:5e36])
        by smtp.gmail.com with ESMTPSA id 199sm5996062pfu.91.2017.01.26.16.35.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Jan 2017 16:35:31 -0800 (PST)
Subject: Re: [RFC 02/14] upload-pack: allow ref name and glob requests
To:     Junio C Hamano <gitster@pobox.com>
References: <cover.1485381677.git.jonathantanmy@google.com>
 <cover.1485381677.git.jonathantanmy@google.com>
 <d0d42b3bb4cf755f122591e191354c53848f197d.1485381677.git.jonathantanmy@google.com>
 <xmqqd1f931g7.fsf@gitster.mtv.corp.google.com>
Cc:     git@vger.kernel.org
From:   Jonathan Tan <jonathantanmy@google.com>
Message-ID: <dc09e446-6d29-8b94-f440-6aa094ab9dc9@google.com>
Date:   Thu, 26 Jan 2017 16:35:31 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <xmqqd1f931g7.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 01/26/2017 02:23 PM, Junio C Hamano wrote:
> Jonathan Tan <jonathantanmy@google.com> writes:
>
>> Currently, while performing packfile negotiation [1], upload-pack allows
>> clients to specify their desired objects only as SHA-1s. This causes:
>> (a) vulnerability to failure when an object turns non-existent during
>>     negotiation, which may happen if, for example, upload-pack is
>>     provided by multiple Git servers in a load-balancing arrangement,
>>     and
>> (b) dependence on the server first publishing a list of refs with
>>     associated objects.
>>
>> To eliminate (a) and take a step towards eliminating (b), teach
>> upload-pack to support requests in the form of ref names and globs (in
>> addition to the existing support for SHA-1s) through a new line of the
>> form "want-ref <ref>" where ref is the full name of a ref, a glob
>> pattern, or a SHA-1. At the conclusion of negotiation, the server will
>> write "wanted-ref <SHA-1> <name>" for all requests that have been
>> specified this way.
>
> I am not sure if this "at the conclusion of" is sensible.  It is OK
> to assume that what the client side has is fixed, and it is probably
> OK to desire that what the server side has can change, but at the
> same time, it feels quite fragile to move the goalpost in between.

Do you have any specific concerns as to this fragility? Peff mentioned 
some concerns with the client making some decisions based on the initial 
SHA-1 vs the SHA-1 reported by "wanted-ref", to which I replied [1].

> Stepping back a bit, in an environment that involves multiple server
> instances that have inconsistent set of refs, can the negotiation
> even be sensibly and safely implemented?  The first server the
> client contacts may, in response to a "have", say "I do have that
> commit so you do not have to send its ancestors to me.  We found one
> cut-off point.  Please do explore other lines of histories."  The
> next server that concludes the negotiation exchange may not have
> that commit and will be unable to produce a pack that excludes the
> objects reachable from that commit---wouldn't that become a problem?

It's true that this patch set wouldn't solve this problem. This problem 
only occurs when there is a commit that the client knows but only a few 
of the servers know (maybe because the client just pushed it to one of 
them). If, for example, the client does not know a commit and only a few 
of the servers know it (for example, because another user just pushed 
it), this patch set does help. The latter scenario seems like it would 
occur relatively commonly.

> One way to prevent such a problem from hurting clients may be for
> these multiple server instances to coordinate and make sure they
> have a shared perception of the common history among them.  Some
> pushes may have come to one instance but may not have propagated to
> other instances, and such a commit cannot be accepted as usable
> "have" if the servers anticipate that the final client request would
> go to any of the servers.  Otherwise the multiple server arrangement
> would not work safely, methinks.
>
> And if the servers are ensuring the safety using such a mechanism,
> they can use the same mechanism to restrain "faster" instances from
> sending too fresh state of refs that other instances haven't caught
> up to, which would mean they can present a consistent set of refs to
> the client in the first place, no?
>
> So I am not sure if the mechanism to request history by refname
> instead of the tip commit would help the multi-server environment as
> advertised.  It may help solving other problems, though (e.g. like
> "somebody pushed to update after the initial advertisement was sent
> out" which can happen even in a single server environment).

This patch set would solve the problem you describe (whether in a single 
server environment or the coordination between multiple servers that 
provides "strong consistency"). (Although it may not be an important 
problem to solve, since it is probably OK if the client got a "slow" 
version of the state of the refs.)

>> To be flexible with respect to client needs, the server does not
>> indicate an error if a "want-ref" line corresponds to no refs, but
>> instead relies on the client to ensure that what the user needs has been
>> fetched. For example, a client could reasonably expand an abbreviated
>> name "foo" to "want-ref foo", "want-ref refs/heads/foo", "want-ref
>> refs/tags/foo", among others, and ensure that at least one such ref has
>> been fetched.
>
> Cute.  This may be one way to implement the DWIM thing within the
> constraint of eventually wanting to go to "client speaks first, the
> server does not advertise things the client is not interested in"
> world.
>
> But at the same time it may end up bloating the set of refs the
> client asks instead.  Instead of receiving the advertisement and
> then sending one request after picking the matching one from it,
> the client needs to send "refs/{heads,tags,whatever}/foo".

That is true, although I think that the client will typically send only 
a few ref names (with or without globs), so the request packet is still 
not that large.

[1] <67afbb3b-5d0b-8c0d-3f6e-3f559c68f4bd@google.com>
