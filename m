Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E50E202A0
	for <e@80x24.org>; Wed,  1 Nov 2017 22:00:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755449AbdKAWAO (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Nov 2017 18:00:14 -0400
Received: from mout.web.de ([212.227.17.11]:52793 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755289AbdKAWAM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Nov 2017 18:00:12 -0400
Received: from [192.168.178.36] ([91.20.50.251]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LZeZU-1dR6SU0Dtc-00lYyG; Wed, 01
 Nov 2017 22:59:54 +0100
Subject: Re: [PATCH 2/3] http-push: use hex_to_bytes()
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Thomas Gummerer <t.gummerer@gmail.com>
References: <508b1b3f-6b55-eee8-110a-c17d572ec27a@web.de>
 <31ce5c1c-cab3-80aa-623b-43f91ddd2162@web.de>
 <20171101195530.odscytks7jvgukbs@sigill.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <0e7f821a-94ae-3946-fb99-c508a06a6847@web.de>
Date:   Wed, 1 Nov 2017 22:59:49 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20171101195530.odscytks7jvgukbs@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:jddOvcc8Nz461rqiYLj3/GSEnJgn+vSVHdlQ27qC0htYA0GqnTp
 vJYcuWBScOZ98Q0jELOXBkZwWiA4tfIs+E6a5Ra7eB0yHh6KMY0bgtH4zYglsbWqvso4p3j
 bgXZS02CFb14Im0QcyWBUhmJv93JLnV+gYSfzr6CpySKYBB3YX9tkU0pLcZ81yZp9nk7VSm
 A1VwNmug9Lts1xe1MuIVA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:bBoj9YKhdU4=:S4crrqM2a2DRCCdxv6Qwsc
 bVIB6TKlRmcSDSlC5Cpz7eQgvBohQ5eTTKcH/N/vbSbqz6dt6+WSIP9q+CkwfN6FQij/gWwAO
 oLSXgeqLWYhmtm4Go3eSJ8/VSsDhYpKzWp46S4JIG/BoFt48aoAVVQvGP0xNYgJH1bKvNvHsC
 u2AHWN/AV84nbLF331z8O70XLbyQieLfQMPEnR74cz7Tvfg1HQym4Osy1ce8K/YTkwdhw1+rM
 2+R6anQvsdOtyWVtkuj0g57MKH2avvGTNRdrjsqmjd6Y6svqau7jzd9i9h1ZirpJPj7bgkTum
 gonfRFtAwyAPsrraVvEW+SJx4uFXHqLBBOQF71v0ehAPmd2pSC50QzpJJWvVmVwDguhOq9w5x
 BFwDzst8TTimrNT+GaMJwewa88plDx/ijAGeoSIg8yz6BpOuz3prfYMuHIcV8t1O+et9gmrpV
 fRnj3E4WKtE2mYpHzEqIeWLKvkBXDQD0ekptGuzGk8XD8VH4Xvtn/qjrbN+Na/fWjuj7muqRS
 znUBUak2EcUSaXygtJjJUdJ3t/DyRSRpSkZFsJk+mqd0SweQpGtlieFk5Ey8ywkJ4x0qjgi1C
 eWLC63nEMUHcXSrWxCC4tOnRrK6X/OL3rzBHHcgRz/k/w7wuvii8L1KiztU/UjJIxzYeD54vj
 cErJ4MGzp3xQNRrdO6+gd+nWz3YzRPdr9A0TKqaSsaNnoo5NVZculSIFJab9f/msDy5YdqwSO
 tl90NrUMTvOcshCj3rE/tp5Z386WODaqCNRkatAWKw7ge5wJYdyK5RpHCO6695lmDdABQ0gfn
 db1SNaFrLW/Wn0T06LAKYuuf5S3DOCNX5bWk0cJFnLFmdgnjf0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 01.11.2017 um 20:55 schrieb Jeff King:
> On Tue, Oct 31, 2017 at 02:49:56PM +0100, René Scharfe wrote:
> 
>> The path of a loose object contains its hash value encoded into two
>> substrings of hexadecimal digits, separated by a slash.  The current
>> code copies the pieces into a temporary buffer to get rid of the slash
>> and then uses get_oid_hex() to decode the hash value.
>>
>> Avoid the copy by using hex_to_bytes() directly on the substrings.
>> That's shorter and easier.
>>
>> While at it correct the length of the second substring in a comment.
> 
> I think the patch is correct, but I wonder if this approach will bite us
> later on when we start dealing with multiple lengths of hashes.
> 
> The hex_to_bytes() function requires that the caller make sure they have
> the right number of bytes. But for many callers, I think they'd want to
> say "parse this oid, which might be truncated; I can't tell what the
> length is supposed to be".

I'm confused by the word "many".  After this series there are three
callers of hex_to_bytes() and I don't expect that number to grow.

Would loose objects be stored at paths containing only a subset of their
new hash value?  If they won't then there will be two acceptable lengths
instead of the one we have today, which should be easy to handle.

> I.e., I wonder if the right primitive is really something like
> parse_oid_hex(), but with a flag to say "skip over interior slashes".

Hmm, ignoring any slashes is an interesting idea.  Is that too loose, I
wonder?  And I don't think it makes for a good primitive, as slashes
only need to be ignored in a single place so far (here in http-push.c).
Collecting special cases in a central place, guarded by flags, doesn't
reduce the overall complexity.

> We don't need to deal with that eventuality yet, but I'm on the fence on
> whether this patch is making that harder down the road or not. The
> current strategy of "stuff it into a buffer without slashes" would be
> easier to convert, I think.

How so?  If you have a buffer then you need to know the size of the
data to copy into it as well, or you'll learn it in the process.

The call sites of hex_to_bytes() have to be modified along with the
functions in hex.c to support longer hashes, with or without this
series.

René
