Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3621120281
	for <e@80x24.org>; Mon,  2 Oct 2017 14:27:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751515AbdJBO1b (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Oct 2017 10:27:31 -0400
Received: from mout.gmx.net ([212.227.15.15]:52750 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751067AbdJBO12 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Oct 2017 10:27:28 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MgLMU-1ddWYc3xxu-00NeUQ; Mon, 02
 Oct 2017 16:26:53 +0200
Date:   Mon, 2 Oct 2017 16:26:49 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Joan Daemen <jda@noekeon.org>
cc:     Gilles Van Assche <gilles.vanassche@st.com>,
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
Subject: Re: RFC v3: Another proposed hash function transition plan
In-Reply-To: <6d96ec902dc1d500ba3fcb11d31b2015@mail.noekeon.org>
Message-ID: <alpine.DEB.2.21.1.1710021601380.40514@virtualbox>
References: <20170304011251.GA26789@aiede.mtv.corp.google.com> <CA+55aFz+gkAsDZ24zmePQuEs1XPS9BP_s8O7Q4wQ7LV7X5-oDA@mail.gmail.com> <20170307001709.GC26789@aiede.mtv.corp.google.com> <xmqqa828733s.fsf@gitster.mtv.corp.google.com> <xmqq1snh29re.fsf@gitster.mtv.corp.google.com>
 <20170911185913.GA5869@google.com> <alpine.DEB.2.21.1.1709131340030.4132@virtualbox> <CANgJU+Wv1nx79DJTDmYE=O7LUNA3LuRTJhXJn+y0L0C3R+YDEA@mail.gmail.com> <CA+55aFwUn0KibpDQK2ZrxzXKOk8-aAub2nJZQqKCpq1ddhDcMQ@mail.gmail.com> <alpine.DEB.2.21.1.1709142037490.4132@virtualbox>
 <59BFB95D.1030903@st.com> <alpine.DEB.2.21.1.1709182340350.219280@virtualbox> <59C149A3.6080506@st.com> <alpine.DEB.2.21.1.1709291416290.40514@virtualbox> <acd96750-c165-650c-c67f-44465f2075f2@noekeon.org> <alpine.DEB.2.21.1.1709292355060.40514@virtualbox>
 <6d96ec902dc1d500ba3fcb11d31b2015@mail.noekeon.org>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:DZSogI+M3swYzbnGdgiTJ4CFA5BmvSkBx0mjJnu7Aah7JcKew73
 1ZGjBKD61YFg4HKUbe6JxZT7lPlTqlbf3I67FpyZnAxmym+wwM9XF3EUg9DBrLf48PYyVIU
 7RXthHqbcuJD+SSK2HJNXE/cNjqmpirXrZPmyZymgriFRFlp+9YGVI514wBdxmW01KP4Io0
 d69wnJKDwjITRdiHt+fVw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:JijcYchL9YI=:zi/HXB/7pmCIXhiM5jH9Wz
 SBa32BXLXtCNoTzHdQQNDwPZ/a+uiH+XF4M2kTfZ2qhi7cXY+txLefyY9l5P5kMp2pQhYQnSw
 +Fmv+MbgbsDdLdSpi3uKajW3xzG5O+XlGcjcdIKwMNIuLe7UFjMmym57dad1GRQ+bUMcfKOS9
 vdg+vU+AMcstluSJW70KC/NJwIzzqyT2ftU2fOh6QEdJjF9zvbBeZ6/xWLbUF0cMiWa2yjIWs
 pzEMA/K91QiQdV/raU4TrvjNTY/I3fz3JiaqZQWAjsjWkWYXTRghJVY7m3Anj/jZcjesRKxbW
 TV1wCQV6PH7o/z6qJBn72NRW+ckdsK0Syia/w6b0yfILgq4qOiZvOtIk8dK/hk/HLLA/a2ai6
 AcxadVM526qCGlDoyBDTe0XIgeGQIm6t6iK95jAePCdhtS7Up74Oi+6uYhgXzwx7+Uey5qbnh
 8NRslAbg4vwrhsZIykzPBHeOHQqbt8BaDTLWCoMlfzeZRU23TSMAklhcO+YW+yE7XX1suzv+Z
 WD2tt2ZXHTyyzs7k7siGSWeCMwq1oCw9YBtLwYB6b7kYdvlvNfYiRxKJoBlhGDL/+Kk/iYfij
 pVX85lGGMGZanHDlLoclKyQ+IT/dIjcO/8rIGe1unY/7b/YzeL1B/dslZ19anRbMt/hDMM7xX
 u/IcbB8B9F0GtdrRgyPoeG80GPQsNRP/LGkv8gUsd3ECrKCHZCnkxCSin/yBpKHdAj8jTq/Mr
 9resu1Yr4DODHMyUUeOyFAnPVZzFIaKNKI5M36J4X2iIhF+nD33CItnplt2P5XfOrrViUYo37
 OpKZ29JxYA9D1fZu2ZjkbEizWey+SmD+l0isQlJ15c2LrS5qQU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Joan,

On Sun, 1 Oct 2017, Joan Daemen wrote:

> On 30/09/17 00:33, Johannes Schindelin wrote:
> 
> > As far as Git is concerned, we not only care about the source code of
> > the hash algorithm we use, we need to care even more about what you
> > call "executable": ready-to-use, high quality, well-tested
> > implementations.
> > 
> > We carry source code for SHA-1 as part of Git's source code, which was
> > hand-tuned to be as fast as Linus could get it, which was tricky given
> > that the tuning should be general enough to apply to all common intel
> > CPUs.
> > 
> > This hand-crafted code was blown out of the water by OpenSSL's SHA-1
> > in our tests here at Microsoft, thanks to the fact that OpenSSL does
> > vectorized SHA-1 computation now.
> > 
> > To me, this illustrates why it is not good enough to have only a
> > reference implementation available at our finger tips. Of course,
> > above-mentioned OpenSSL supports SHA-256 and SHA3-256, too, and at
> > least recent versions vectorize those, too.
> 
> There is a lot of high-quality optimized code for all SHA-3 functions
> and many CPUs in the Keccak code package
> https://github.com/gvanas/KeccakCodePackage but also OpenSSL contains
> some good SHA-3 code and then there are all those related to Ethereum.
> 
> By the way, you speak about SHA3-256, but the right choice would be to
> use SHAKE128. Well, what is exactly the right choice depends on what you
> want. If you want to have a function in the SHA3 standard (FIPS 202), it
> is SHAKE128.  You can boost performance on high-end CPUs by adopting
> Parallelhash from NIST SP 800-185, still a NIST standard. You can
> multiply that performance again by a factor of 2 by adopting
> KangarooTwelve. This is our (Keccak team) proposal for a parallelizable
> Keccak-based hash function that has a safety margin comparable to that
> of the SHA-2 functions. See https://keccak.team/kangarootwelve.html May
> I also suggest you read https://keccak.team/2017/is_sha3_slow.html

Thanks.

I have to admit that all those names that do not start with SHA and do not
end in 256 make me a bit dizzy.

> > Back to Intel processors: I read some vague hints about extensions
> > accelerating SHA-256 computation on future Intel processors, but not
> > SHA3-256.
> > 
> > It would make sense, of course, that more crypto libraries and more
> > hardware support would be available for SHA-256 than for SHA3-256
> > given the time since publication: 16 vs 5 years (I am playing it loose
> > here, taking just the year into account, not the exact date, so please
> > treat that merely as a ballpark figure).
> > 
> > So from a practical point of view, I wonder what your take is on, say,
> > hardware support for SHA3-256. Do you think this will become a focus
> > soon?
> 
> I think this is a chicken-and-egg problem. In any case, hardware support
> for one SHA3-256 will also work for the other SHA3 and SHAKE functions
> as they all use the same underlying primitive: the Keccak-f permutation.
> This is not the case for SHA2 because SHA224 and SHA256 use a different
> compression function than SHA384, SHA512, SHA512/224 and SHA512/256.

Okay.

So given that Git does not exactly have a big sway on hardware vendors, we
would have to hope that some other chicken lays that egg.

> > Also, what is your take on the question whether SHA-256 is good
> > enough?  SHA-1 was broken theoretically already 10 years after it was
> > published (which unfortunately did not prevent us from baking it into
> > Git), after all, while SHA-256 is 16 years old and the only known
> > weakness does not apply to Git's usage?
> 
> SHA-256 is more conservative than SHA-1 and I don't expect it to be
> broken in the coming decades (unless NSA inserted a backdoor but I don't
> think that is likely). But looking at the existing cryptanalysis, I
> think it is even less likely that I SHAKE128, ParallelHash or
> KangarooTwelve will be broken anytime.

That's reassuring! ;-)

> > Also, while I have the attention of somebody who knows a heck more
> > about cryptography than Git's top 10 committers combined: how soon do
> > you expect practical SHA-1 attacks that are much worse than what we
> > already have seen? I am concerned that if we do not move fast enough
> > to a new hash algorithm, and somebody finds a way in the meantime to
> > craft arbitrary messages given a prefix and an SHA-1, then we have a
> > huge problem on our hands.
> 
> This is hard to say. To be honest, when witnessing the first MD5
> collisions I did not expect them to lead to some real world attacks and
> just a few years later we saw real-world forged certificates based on
> MD5 collisions. And SHA-1 has a lot in common with MD5...

Oh, okay. I did not realize that MD5 and SHA-1 are so similar in design,
thank you for educating me!

> But let me end with a philosophical note. Independent of all the
> arguments for and against, I think this is ultimately about doing the
> right thing. The choice is here between SHA1/SHA2 on the one hand and
> SHA3/Keccak on the other.  The former standards are imposed on us by NSA
> and the latter are the best that came out of an open competition
> involving all experts in the field worldwide.  What would be closest to
> the philosophy of Git (and by extension Linux or open-source in
> general)?

Heh. Do you realize that you are talking to a Microsoftie, i.e. one of the
"evil company"? ;-)

So philosophically, I am much more pragmatic. Or maybe I am not, after
all, I joined a company at a time when it is arguably going through one of
the most dramatic cultural changes any company has seen lately (a year
ago, we became #1 contributor on GitHub according to Business Insider, and
as far as I can tell, we're not willing to pass that belt to anyone else).

But when it comes to the philosophy of Git, I fear I have to disappoint
you: Git's fundamental concepts were not developed in an open process. Git
even so much as rejected professional advice *not* to bake SHA-1 into
everything.

Of course, we are undoing this damage right now, and your input helps
greatly, I would think.

While I feel reassured by your response that SHA-256 would be "good
enough" and would have some real-life benefits of announced hardware
support, I would now also feel comfortable if my preference was overruled
in the end, in favor of a hash from the Keccak family. I would understand,
for example, if the parallel option turned out to be enticing enough for
other core Git contributors to aim for, say, K12).

Again, thank you very much for chiming in,
Johannes
