Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 455B320A2C
	for <e@80x24.org>; Sat, 30 Sep 2017 22:02:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751243AbdI3WCN (ORCPT <rfc822;e@80x24.org>);
        Sat, 30 Sep 2017 18:02:13 -0400
Received: from ober.noekeon.org ([91.134.133.203]:53023 "EHLO ober.noekeon.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751178AbdI3WCL (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Sep 2017 18:02:11 -0400
Received: by ober.noekeon.org (Postfix, from userid 33)
        id 9B96A2241D; Sun,  1 Oct 2017 00:02:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=noekeon.org; s=mail;
        t=1506808928; bh=vBcu1Mw3J5MHcyZDeqoxflwIfsNBrIV9vAt6X5mOVrM=;
        h=To:Subject:Date:From:Cc:Reply-To:In-Reply-To:References:From;
        b=HYW8WvG8fcV8Y65Wm4ssrDwlE7fyyJzhZ4hXDfTeCDzhcIQ1ERuLUiq3L4wpcGbxB
         oOIA4vkjRsSGQ61HjD3uaBudSXpvF8rpLqRTl9dTcQX4ddKZc2LWsSK03oK7xOewb3
         SI6NWqBHVfI2JaSI8iP/Dan4scBsUnwzEXtwimoA=
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: RFC v3: Another proposed hash function transition plan
X-PHP-Originating-Script: 0:rcube.php
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Sun, 01 Oct 2017 00:02:08 +0200
From:   Joan Daemen <jda@noekeon.org>
Cc:     Gilles Van Assche <gilles.vanassche@st.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        demerphq <demerphq@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff King <peff@peff.net>, David Lang <david@lang.hm>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Keccak Team <keccak@noekeon.org>
Reply-To: jda@noekeon.org
Mail-Reply-To: jda@noekeon.org
In-Reply-To: <alpine.DEB.2.21.1.1709292355060.40514@virtualbox>
References: <20170304011251.GA26789@aiede.mtv.corp.google.com>
 <CA+55aFz+gkAsDZ24zmePQuEs1XPS9BP_s8O7Q4wQ7LV7X5-oDA@mail.gmail.com>
 <20170307001709.GC26789@aiede.mtv.corp.google.com>
 <xmqqa828733s.fsf@gitster.mtv.corp.google.com>
 <xmqq1snh29re.fsf@gitster.mtv.corp.google.com>
 <20170911185913.GA5869@google.com>
 <alpine.DEB.2.21.1.1709131340030.4132@virtualbox>
 <CANgJU+Wv1nx79DJTDmYE=O7LUNA3LuRTJhXJn+y0L0C3R+YDEA@mail.gmail.com>
 <CA+55aFwUn0KibpDQK2ZrxzXKOk8-aAub2nJZQqKCpq1ddhDcMQ@mail.gmail.com>
 <alpine.DEB.2.21.1.1709142037490.4132@virtualbox> <59BFB95D.1030903@st.com>
 <alpine.DEB.2.21.1.1709182340350.219280@virtualbox>
 <59C149A3.6080506@st.com> <alpine.DEB.2.21.1.1709291416290.40514@virtualbox>
 <acd96750-c165-650c-c67f-44465f2075f2@noekeon.org>
 <alpine.DEB.2.21.1.1709292355060.40514@virtualbox>
Message-ID: <6d96ec902dc1d500ba3fcb11d31b2015@mail.noekeon.org>
X-Sender: jda@noekeon.org
User-Agent: Roundcube Webmail/1.1.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Johannes,

thanks for your response and taking the effort to express your concerns. 
Please see below for some feedback.

On 30/09/17 00:33, Johannes Schindelin wrote:
> Hi Joan,
> 
> On Fri, 29 Sep 2017, Joan Daemen wrote:
> 
>> if ever there was a SHA-2 competition, it must have been held inside 
>> NSA:-)
> Oops. My bad, I indeed got confused about that, as you suggest below (I
> actually thought of the AES competition, but that was obviously not 
> about
> SHA-2). Sorry.
> 
>> But maybe you are confusing with the SHA-3 competition. In any case,
>> when considering SHA-2 vs SHA-3 for usage in git, you may have a look 
>> at
>> arguments we give in the following blogpost:
>> 
>> https://keccak.team/2017/open_source_crypto.html
> Thanks for the pointer!
> 
> Small nit: the post uses "its" in place of "it's", twice.

Thanks, we'll correct that.

> It does have a good point, of course: the scientific exchange (which 
> you
> call "open-source" in spirit) makes tons of sense.
> 
> As far as Git is concerned, we not only care about the source code of 
> the
> hash algorithm we use, we need to care even more about what you call
> "executable": ready-to-use, high quality, well-tested implementations.
> 
> We carry source code for SHA-1 as part of Git's source code, which was
> hand-tuned to be as fast as Linus could get it, which was tricky given
> that the tuning should be general enough to apply to all common intel
> CPUs.
> 
> This hand-crafted code was blown out of the water by OpenSSL's SHA-1 in
> our tests here at Microsoft, thanks to the fact that OpenSSL does
> vectorized SHA-1 computation now.
> 
> To me, this illustrates why it is not good enough to have only a 
> reference
> implementation available at our finger tips. Of course, above-mentioned
> OpenSSL supports SHA-256 and SHA3-256, too, and at least recent 
> versions
> vectorize those, too.

There is a lot of high-quality optimized code for all SHA-3 functions 
and many CPUs in the Keccak code package 
https://github.com/gvanas/KeccakCodePackage but also OpenSSL contains 
some good SHA-3 code and then there are all those related to Ethereum.

By the way, you speak about SHA3-256, but the right choice would be to 
use SHAKE128. Well, what is exactly the right choice depends on what you 
want. If you want to have a function in the SHA3 standard (FIPS 202), it 
is SHAKE128. You can boost performance on high-end CPUs by adopting 
Parallelhash from NIST SP 800-185, still a NIST standard. You can 
multiply that performance again by a factor of 2 by adopting 
KangarooTwelve. This is our (Keccak team) proposal for a parallelizable 
Keccak-based hash function that has a safety margin comparable to that 
of the SHA-2 functions. See https://keccak.team/kangarootwelve.html
May I also suggest you read https://keccak.team/2017/is_sha3_slow.html

> Also, ARM processors have become a lot more popular, so we'll want to 
> have
> high-quality implementations of the hash algorithm also for those
> processors.
> 
> Likewise, in contrast to 2005, nowadays implementations of Git in
> languages as obscure as Javascript are not only theoretical but do 
> exist
> in practice (https://github.com/creationix/js-git). I had a *very* 
> quick
> look for libraries providing crypto in Javascript and immediately found
> the Standford Javascript Crypto library
> (https://github.com/bitwiseshiftleft/sjcl/) which seems to offer 
> SHA-256
> but not SHA3-256 computation.
> 
> Back to Intel processors: I read some vague hints about extensions
> accelerating SHA-256 computation on future Intel processors, but not
> SHA3-256.
> 
> It would make sense, of course, that more crypto libraries and more
> hardware support would be available for SHA-256 than for SHA3-256 given
> the time since publication: 16 vs 5 years (I am playing it loose here,
> taking just the year into account, not the exact date, so please treat
> that merely as a ballpark figure).
> 
> So from a practical point of view, I wonder what your take is on, say,
> hardware support for SHA3-256. Do you think this will become a focus 
> soon?

I think this is a chicken-and-egg problem. In any case, hardware support 
for one SHA3-256 will also work for the other SHA3 and SHAKE functions 
as they all use the same underlying primitive: the Keccak-f permutation. 
This is not the case for SHA2 because SHA224 and SHA256 use a different 
compression function than SHA384, SHA512, SHA512/224 and SHA512/256.

> Also, what is your take on the question whether SHA-256 is good enough?
> SHA-1 was broken theoretically already 10 years after it was published
> (which unfortunately did not prevent us from baking it into Git), after
> all, while SHA-256 is 16 years old and the only known weakness does not
> apply to Git's usage?

SHA-256 is more conservative than SHA-1 and I don't expect it to be 
broken in the coming decades (unless NSA inserted a backdoor but I don't 
think that is likely). But looking at the existing cryptanalysis, I 
think it is even less likely that I SHAKE128, ParallelHash or 
KangarooTwelve will be broken anytime.

> Also, while I have the attention of somebody who knows a heck more 
> about
> cryptography than Git's top 10 committers combined: how soon do you 
> expect
> practical SHA-1 attacks that are much worse than what we already have
> seen? I am concerned that if we do not move fast enough to a new hash
> algorithm, and somebody finds a way in the meantime to craft arbitrary
> messages given a prefix and an SHA-1, then we have a huge problem on
> our hands.

This is hard to say. To be honest, when witnessing the first MD5 
collisions I did not expect them to lead to some real world attacks and 
just a few years later we saw real-world forged certificates based on 
MD5 collisions. And SHA-1 has a lot in common with MD5...

But let me end with a philosophical note. Independent of all the 
arguments for and against, I think this is ultimately about doing the 
right thing. The choice is here between SHA1/SHA2 on the one hand and 
SHA3/Keccak on the other. The former standards are imposed on us by NSA 
and the latter are the best that came out of an open competition 
involving all experts in the field worldwide. What would be closest to 
the philosophy of Git (and by extension Linux or open-source in 
general)?

Kind regards,

Joan


On 30/09/17 00:33, Johannes Schindelin wrote:
> Hi Joan,
> 
> On Fri, 29 Sep 2017, Joan Daemen wrote:
> 
>> if ever there was a SHA-2 competition, it must have been held inside 
>> NSA:-)
> Oops. My bad, I indeed got confused about that, as you suggest below (I
> actually thought of the AES competition, but that was obviously not 
> about
> SHA-2). Sorry.
> 
>> But maybe you are confusing with the SHA-3 competition. In any case,
>> when considering SHA-2 vs SHA-3 for usage in git, you may have a look 
>> at
>> arguments we give in the following blogpost:
>> 
>> https://keccak.team/2017/open_source_crypto.html
> Thanks for the pointer!
> 
> Small nit: the post uses "its" in place of "it's", twice.
> 
> It does have a good point, of course: the scientific exchange (which 
> you
> call "open-source" in spirit) makes tons of sense.
> 
> As far as Git is concerned, we not only care about the source code of 
> the
> hash algorithm we use, we need to care even more about what you call
> "executable": ready-to-use, high quality, well-tested implementations.
> 
> We carry source code for SHA-1 as part of Git's source code, which was
> hand-tuned to be as fast as Linus could get it, which was tricky given
> that the tuning should be general enough to apply to all common intel
> CPUs.
> 
> This hand-crafted code was blown out of the water by OpenSSL's SHA-1 in
> our tests here at Microsoft, thanks to the fact that OpenSSL does
> vectorized SHA-1 computation now.
> 
> To me, this illustrates why it is not good enough to have only a 
> reference
> implementation available at our finger tips. Of course, above-mentioned
> OpenSSL supports SHA-256 and SHA3-256, too, and at least recent 
> versions
> vectorize those, too.
> 
> Also, ARM processors have become a lot more popular, so we'll want to 
> have
> high-quality implementations of the hash algorithm also for those
> processors.
> 
> Likewise, in contrast to 2005, nowadays implementations of Git in
> languages as obscure as Javascript are not only theoretical but do 
> exist
> in practice (https://github.com/creationix/js-git). I had a *very* 
> quick
> look for libraries providing crypto in Javascript and immediately found
> the Standford Javascript Crypto library
> (https://github.com/bitwiseshiftleft/sjcl/) which seems to offer 
> SHA-256
> but not SHA3-256 computation.
> 
> Back to Intel processors: I read some vague hints about extensions
> accelerating SHA-256 computation on future Intel processors, but not
> SHA3-256.
> 
> It would make sense, of course, that more crypto libraries and more
> hardware support would be available for SHA-256 than for SHA3-256 given
> the time since publication: 16 vs 5 years (I am playing it loose here,
> taking just the year into account, not the exact date, so please treat
> that merely as a ballpark figure).
> 
> So from a practical point of view, I wonder what your take is on, say,
> hardware support for SHA3-256. Do you think this will become a focus 
> soon?
> 
> Also, what is your take on the question whether SHA-256 is good enough?
> SHA-1 was broken theoretically already 10 years after it was published
> (which unfortunately did not prevent us from baking it into Git), after
> all, while SHA-256 is 16 years old and the only known weakness does not
> apply to Git's usage?
> 
> Also, while I have the attention of somebody who knows a heck more 
> about
> cryptography than Git's top 10 committers combined: how soon do you 
> expect
> practical SHA-1 attacks that are much worse than what we already have
> seen? I am concerned that if we do not move fast enough to a new hash
> algorithm, and somebody finds a way in the meantime to craft arbitrary
> messages given a prefix and an SHA-1, then we have a huge problem on
> our hands.
> 
> Ciao,
> Johannes



Begin forwarded message:

 From: Gilles Van Assche <gilles.van.assche@noekeon.org>
Subject: Re: RFC v3: Another proposed hash function transition plan
Date: 30 Sep 2017 22:20:42 CEST
To: Joan Daemen <joan@cs.ru.nl>, keccak@noekeon.org

Dag Joan,

About the implementations, there are many high-quality implementations 
of Keccak besides the KCP that you could also mention. E.g., those in 
OpenSSL are very good. And there are all those related to Ethereum.

I tend to agree with Guido regarding SHA-1, even if you are right, there 
is no need to reduce/excuse too much the impact of collisions, there 
could be unexpected use cases. And it's not clean. (And don't 
underestimate the probability to be quoted on this.)

Finally, just to say that I like your last paragraph.

Kind regards,
Gilles




Joan Daemen <joan@cs.ru.nl> wrote:
what about replying with something like this (please have a critical 
look). I sent this from my Radboud account as I have problems with my 
Thunderbird settings. When trying to send a mail, it sometimes works and 
sometimes it says “An error occurred while sending mail: Outgoing server 
(SMTP) error. The server responded:  4.7.1 <joans-mbp.home>: Helo 
command rejected: Host not found."
Dear Johannes,
thanks for your response and taking the effort to express your concerns. 
Please see below for some feedback.
On 30/09/17 00:33, Johannes Schindelin wrote:
Hi Joan,

On Fri, 29 Sep 2017, Joan Daemen wrote:

if ever there was a SHA-2 competition, it must have been held inside 
NSA:-)
Oops. My bad, I indeed got confused about that, as you suggest below (I
actually thought of the AES competition, but that was obviously not 
about
SHA-2). Sorry.

But maybe you are confusing with the SHA-3 competition. In any case,
when considering SHA-2 vs SHA-3 for usage in git, you may have a look at
arguments we give in the following blogpost:

https://keccak.team/2017/open_source_crypto.html
Thanks for the pointer!

Small nit: the post uses "its" in place of "it's", twice.
Thanks, we'll correct that.

It does have a good point, of course: the scientific exchange (which you
call "open-source" in spirit) makes tons of sense.

As far as Git is concerned, we not only care about the source code of 
the
hash algorithm we use, we need to care even more about what you call
"executable": ready-to-use, high quality, well-tested implementations.

We carry source code for SHA-1 as part of Git's source code, which was
hand-tuned to be as fast as Linus could get it, which was tricky given
that the tuning should be general enough to apply to all common intel
CPUs.

This hand-crafted code was blown out of the water by OpenSSL's SHA-1 in
our tests here at Microsoft, thanks to the fact that OpenSSL does
vectorized SHA-1 computation now.

To me, this illustrates why it is not good enough to have only a 
reference
implementation available at our finger tips. Of course, above-mentioned
OpenSSL supports SHA-256 and SHA3-256, too, and at least recent versions
vectorize those, too.
There is a lot of high-quality optimized code for all SHA-3 functions 
and many CPUs in the Keccak code package 
https://github.com/gvanas/KeccakCodePackage

By the way, you speak about SHA3-256, but the right choice would be to 
use SHAKE128. Well, what is exactly the right choice depends on what you 
want. If you want to have a function in the SHA3 standard (FIPS 202), it 
is SHAKE128. You can boost performance on high-end CPUs by adopting 
Parallelhash from NIST SP 800-185, still a NIST standard. You can 
multiply that performance again by a factor of 2 by adopting 
KangarooTwelve. This is our (Keccak team) proposal for a parallelizable 
Keccak-based hash function that has a safety margin comparable to that 
of the SHA-2 functions. See https://keccak.team/kangarootwelve.html
May I also suggest you to read 
https://keccak.team/2017/is_sha3_slow.html

Also, ARM processors have become a lot more popular, so we'll want to 
have
high-quality implementations of the hash algorithm also for those
processors.

Likewise, in contrast to 2005, nowadays implementations of Git in
languages as obscure as Javascript are not only theoretical but do exist
in practice (https://github.com/creationix/js-git). I had a *very* quick
look for libraries providing crypto in Javascript and immediately found
the Standford Javascript Crypto library
(https://github.com/bitwiseshiftleft/sjcl/) which seems to offer SHA-256
but not SHA3-256 computation.

Back to Intel processors: I read some vague hints about extensions
accelerating SHA-256 computation on future Intel processors, but not
SHA3-256.

It would make sense, of course, that more crypto libraries and more
hardware support would be available for SHA-256 than for SHA3-256 given
the time since publication: 16 vs 5 years (I am playing it loose here,
taking just the year into account, not the exact date, so please treat
that merely as a ballpark figure).

So from a practical point of view, I wonder what your take is on, say,
hardware support for SHA3-256. Do you think this will become a focus 
soon?
I think this is a chicken-and-egg problem. In any case, hardware support 
for one SHA3-256 will also work for the other SHA3 and SHAKE functions 
as they all use the same underlying primitive: the Keccak-f permutation. 
This is not the case for SHA2 because SHA224 and SHA256 use a different 
compression function than SHA384, SHA512, SHA512/224 and SHA512/256.

Also, what is your take on the question whether SHA-256 is good enough?
SHA-1 was broken theoretically already 10 years after it was published
(which unfortunately did not prevent us from baking it into Git), after
all, while SHA-256 is 16 years old and the only known weakness does not
apply to Git's usage?
I think even the weakness of SHA-1 will be hard to exploit to do 
something bad in Git. SHA-256 is more conservative than SHA-1 and I 
don't expect it to be broken (unless NSA inserted a backdoor but I don't 
think that is likely). But I also don't expect SHAKE128, ParallelHash or 
KangarooTwelve to be broken, looking at the existing cryptanalysis.
Also, while I have the attention of somebody who knows a heck more about
cryptography than Git's top 10 committers combined: how soon do you 
expect
practical SHA-1 attacks that are much worse than what we already have
seen? I am concerned that if we do not move fast enough to a new hash
algorithm, and somebody finds a way in the meantime to craft arbitrary
messages given a prefix and an SHA-1, then we have a huge problem on
our hands.
As said, I don't expect practical SHA-1 attacks soon. But let me end 
with a philosophical note. Independent of all the arguments for and 
against, I think this is about doing the right thing. The choice is here 
between SHA1/SHA2 on the one hand and SHA3/Keccak on the other. The 
former standards are imposed on us by NSA and the latter are the best 
that came out of an open competition involving all experts worldwide. 
What would be closest to the philosophy of Git (and by extension Linux 
or open-source in general)?

Kind regards,

Joan


