Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A36E1F40E
	for <e@80x24.org>; Wed,  3 Aug 2016 20:03:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758104AbcHCUDG (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 16:03:06 -0400
Received: from lang.hm ([66.167.227.134]:52733 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757476AbcHCUDF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2016 16:03:05 -0400
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id u73K3051000773;
	Wed, 3 Aug 2016 13:03:00 -0700
Date:	Wed, 3 Aug 2016 13:03:00 -0700 (PDT)
From:	David Lang <david@lang.hm>
X-X-Sender: dlang@asgard.lang.hm
To:	Santiago Torres <santiago@nyu.edu>
cc:	Jeff King <peff@peff.net>, Git <git@vger.kernel.org>
Subject: Re: [OT] USENIX paper on Git
In-Reply-To: <20160803174459.knlmyx6txmggixzi@LykOS.localdomain>
Message-ID: <alpine.DEB.2.02.1608031259500.16896@nftneq.ynat.uz>
References: <20160801224043.4qmf56pmv27riq4i@LykOS.localdomain> <20160803145830.uwssj4uhqfemhr4o@LykOS.localdomain> <20160803171124.yzm5xs67empuka7o@sigill.intra.peff.net> <20160803174459.knlmyx6txmggixzi@LykOS.localdomain>
User-Agent: Alpine 2.02 (DEB 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, 3 Aug 2016, Santiago Torres wrote:

>> So if you want to treat Git as a cryptographic end-to-end distribution
>> mechanism, then no, it fails horribly at that. But the state of the art
>> in source code distribution, no matter which system you use, is much
>> less advanced than that. People download tarballs, even ones with GPG
>> signatures, all the time without verifying their contents. Most packages
>> distribute a sha1sum or similar (sometimes even gpg-signed), but quite
>> often the source of authority is questionable.
>
> Yes, this happens an awful lot of times. We did some work with python's
> pypi last year, and we found out that less than 1% of people actually
> downloaded the gpg signature for the package they are retrieving[1].
>
>>
>> For example, consider somebody downloading a new package for the first
>> time. They don't know the author in any out-of-band way, so any
>> signatures are likely meaningless. They _might_ be depending on the
>> source domain for some security (and using some hierarchical PKI like
>> TLS+x.509 to be sure they're talking to that domain), but in your threat
>> model, even well-known hosts like FSF could be compromised internally.
>>
>> So yes, I think the current state of affairs (especially open-source) is
>> that people download and run possibly-compromised code all the time. But
>> I'm not sure that lack of tool support is really the limiting factor. Or
>> that it has turned out to be all that big a problem in practice.
>
> I couldn't agree more. I feel that OSS is slowly moving towards a more
> cryptographically robust, trust-based way of doing things, which I find
> pleasing.

It's too easy to look at this from purely a technical, cryptographic point of 
view and miss a very important point.

It may be very easy to see that this was signed by "cool-internet-name" but how 
can I tell if this is really Joe Blow the developer? and if it is, I still have 
no way of knowing if he's working for the NSA or not.

The lack of meaningful termination of the signatures to the real world is why so 
few people bother to check package signatures, etc.

David Lang
