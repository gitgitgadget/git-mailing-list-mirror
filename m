Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1130520133
	for <e@80x24.org>; Mon,  6 Mar 2017 18:49:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754155AbdCFStv (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Mar 2017 13:49:51 -0500
Received: from mail-pg0-f52.google.com ([74.125.83.52]:33093 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753436AbdCFStt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Mar 2017 13:49:49 -0500
Received: by mail-pg0-f52.google.com with SMTP id 25so69311428pgy.0
        for <git@vger.kernel.org>; Mon, 06 Mar 2017 10:49:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=8jv9OXbPkR07N5syWly9FXcZcVGQFenLA/DiLGWn4PM=;
        b=fkmtct9pDg0XbTweuAHr58A8cq696q6K9YvLTm13WIjOYbhYRNDzrHiC0ezZUztAK0
         tVJeieoAtiIktsRyiiTy2+Jbbtu+1DJXU7S2qzu9K1+Bjmk0BrbZcixV2NEAJVF+agzQ
         SvrH2qAQKy8HRbpbm8/sRXyFmsHa0vOldfIZBNNVdXH0HrOl2r4wuK45pjCrwJAkcXTj
         MajCUwj4mwIJzwLGnx1sYkprjRmuyPSU86wHC8Xri95OWlmxkVbJITIjMjo5Z++0/vW/
         AI2gCibeK2MkHFfSxJE3t/f9MxtHQeCSjTj828TfOUoyow/y6gqs2LPK72hM0I7v4KDY
         KCbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=8jv9OXbPkR07N5syWly9FXcZcVGQFenLA/DiLGWn4PM=;
        b=LcHcLCfL7B0Rukaw3YfuuRBkL5BT+zzT+wxP9tRLO2NkXjZCg2qvi0emL8PjrpTGK1
         Jit6UxogjpV/PSVOCvynvqvmE9pdJznPiLpfguP27y5iTlgM0e6OHy4pRxGNMLpFWjpO
         bdh1WNHf0zwPFwmTy1FPTscgl51QEHgUEmDLqMdNccwBV9wP4ZKiv24cwYirg+qFhtco
         qk6QfIeHb8u5+FYLh/XMVfP4ggl60Dwq6cFcKil98FIxtikLXxnQDJlib4//vM74aiRw
         pmSdp6bq4nDNcoV2999AgrgPfOOIIiGpjuLokpq0n7Na+z4h35TVwB+q8tDSKEbYj0KQ
         Ng9g==
X-Gm-Message-State: AMke39mkpZC4IPtZ6YS6MBl4xjwflu/WTyTKOn4jsBsB3mVinKfUyp3i4HVoclL3ZfNfdAkg
X-Received: by 10.84.198.164 with SMTP id p33mr29005395pld.127.1488825591230;
        Mon, 06 Mar 2017 10:39:51 -0800 (PST)
Received: from twelve2.mtv.corp.google.com ([2620:0:1000:5b10:1458:35b5:154a:3344])
        by smtp.gmail.com with ESMTPSA id x15sm21736659pgc.16.2017.03.06.10.39.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Mar 2017 10:39:50 -0800 (PST)
Subject: Re: RFC: Another proposed hash function transition plan
To:     Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>
References: <20170304011251.GA26789@aiede.mtv.corp.google.com>
 <20170306084353.nrns455dvkdsfgo5@sigill.intra.peff.net>
Cc:     git@vger.kernel.org, sbeller@google.com, bmwill@google.com,
        Linus Torvalds <torvalds@linux-foundation.org>
From:   Jonathan Tan <jonathantanmy@google.com>
Message-ID: <cdd7779a-acdb-99fd-a685-89b36df65393@google.com>
Date:   Mon, 6 Mar 2017 10:39:49 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <20170306084353.nrns455dvkdsfgo5@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/06/2017 12:43 AM, Jeff King wrote:
> Overall the basics of the conversion seem sound to me. The "nohash"
> things seems more complicated than I think it ought to be, which
> probably just means I'm missing something.  I left a few related
> comments on the google doc, so I won't repeat them here.

I think "nohash" can be explained in 2 points:
  1. When creating signed objects, "nohash" is almost never written. Just
     create the object as usual and add "hash" lines for every other hash
     function that you want the signature to cover.
  2. When converting from function A to function B, add "nohash B" if
     there were no "hash B" lines in the original object.

The "nohash" thing was in the hope of requiring only one signature to 
sign all the hashes (in all the functions) that the user wants, while 
preserving round-tripping ability.

Maybe some examples would help to address the apparent complexity. These 
examples are the same as those in the document. I'll also show future 
compatibility with a hypothetical NEW hash function, and extend the rule 
about signing/verification to 'sign in the earliest supported hash 
function in ({object's hash function} + {functions in "hash" lines} - 
{function in "nohash" line})'.

Example 1 (existing signed commit)
<sha-1 object stuff>  <sha256 object stuff>  <NEW object stuff>
                       nohash sha256          nohash new
                       hash sha1 ...          hash sha1 ...

This object was probably created in a SHA-1 repository with no knowledge 
that we were going to transition to SHA256 (but there is nothing 
preventing us from creating the middle or right object and then 
translating it to the other functions).

Example 2 (recommended way to sign a commit in a SHA256 repo)
<sha-1 object stuff>  <sha256 object stuff>  <NEW object stuff>
hash sha256 ...       hash sha1 ...          nohash new
                                              hash sha1 ...
                                              hash sha256 ...

This is the recommended way to create a SHA256 object in a SHA256 repo. 
The rule about signing/verification (as stated above) is to sign in 
SHA-1, so when signing or verifying, we convert the object to SHA-1 and 
use that as the payload. Note that the signature covers both the SHA-1 
and SHA256 hashes, and that existing Git implementations can verify the 
signature.

Example 3 (a signer that does not care about SHA-1 anymore)
<sha-1 object stuff>  <sha256 object stuff>  <NEW object stuff>
nohash sha1                                  nohash new
hash sha256 ...                              hash sha256 ...

If we were to create a SHA256 object without any mentions of SHA-1, the 
rule about signing/verification (as stated above) states that the 
signature payload is the SHA256 object. This means that existing Git 
implementations cannot verify the signature, but we can still round-trip 
to SHA-1 and back without losing any information (as far as I can tell).
