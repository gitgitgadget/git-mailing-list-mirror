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
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C9A41F403
	for <e@80x24.org>; Mon, 11 Jun 2018 21:19:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753380AbeFKVTP (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Jun 2018 17:19:15 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:53450 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751712AbeFKVTO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jun 2018 17:19:14 -0400
Received: by mail-wm0-f66.google.com with SMTP id x6-v6so16985389wmc.3
        for <git@vger.kernel.org>; Mon, 11 Jun 2018 14:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=tebjhrdJWV77LY3eOz9UrSD/uFG9JDKsNw7Nb4kCBzw=;
        b=BMGTp8keJ3AXP3ld0CxWDS/agiLHOTKoDktZliRLNXOwMTMr4jMszNfZWPXIClG8ps
         L/Qr91mFYiwGQEDbF5iF6NhaT8jL1FDfDb8Ye8raNIKNN/C/TzJIs2rNBdCmzxlTYcUZ
         8cJ9qvPreH4RbxeojAXFt6AEQHAzblYTgHT+zJ0QV9AhO5e52AlEIcvhuXerpwEpGnz5
         ObA23XhQ4KNQL9eoY4omgEr0ZqcuDl/89fjU202iS3u+648NlNjsMu34ZSkQqCYwMShE
         kKgTyBIg4ar1JX2BBb32dKoMX1aKy8lPCNJ5XDvuEoJ41hNEIJcIcgn/RFhT7olWhktY
         Z4Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=tebjhrdJWV77LY3eOz9UrSD/uFG9JDKsNw7Nb4kCBzw=;
        b=Me53vWuePeZoXqaLeqHgM4re0NaXMvqb04YOys5riiyv30SS64svYJYHBud/mvYB4q
         dZtdAYK2bWUshRrK1Hli//AxVdMQL3bvpWJGfEe+HIb2ED9n8sernCM8UV3wqWcSOZdY
         aJxMAPIP33XDXvenwrYjJe0QdLkCvf5lcNtU7S+mV6OQxtb3Q0iVrltaRB8DI25+e+GE
         U8SaBgTHDPk4bPEUhgemxRFQhLuJ4azvMf2+gL9IFL0rT8OxEDRgy+VB45F4RedYZdz3
         kdYoZWX4+7QODwVVpX+lHDJ6DJLPGgzAyEB2dOu7qUrhc2OTYXZOizyTbBm33cyDwdTK
         850A==
X-Gm-Message-State: APt69E3Do3iHTd2yIyOqcpdstFMVQwrH1Wae8LlyXJBpPSbcaHSUf526
        i46T/kauSX9OWh/4GKNhXuY=
X-Google-Smtp-Source: ADUXVKJrwI3E51wtGo938i/YIk5YRqM2wUv84Hn5PShCBGrloieCe9iXNhAJWx0jAOykWG3ep4HlDw==
X-Received: by 2002:aa7:d0d2:: with SMTP id u18-v6mr674574edo.205.1528751952710;
        Mon, 11 Jun 2018 14:19:12 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id m10-v6sm12671900edp.57.2018.06.11.14.19.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Jun 2018 14:19:11 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Adam Langley <agl@google.com>,
        Jeff King <peff@peff.net>, Mike Hommey <mh@glandium.org>,
        Brandon Williams <bmwill@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Hash algorithm analysis
References: <20180609205628.GB38834@genre.crustytoothpaste.net> <20180609224913.GC38834@genre.crustytoothpaste.net>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20180609224913.GC38834@genre.crustytoothpaste.net>
Date:   Mon, 11 Jun 2018 23:19:10 +0200
Message-ID: <87bmchvx69.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Jun 09 2018, brian m. carlson wrote:

[Expanding the CC list to what we had in the last "what hash" thread[1]
last year].

> == Discussion of Candidates
>
> I've implemented and tested the following algorithms, all of which are
> 256-bit (in alphabetical order):
>
> * BLAKE2b (libb2)
> * BLAKE2bp (libb2)
> * KangarooTwelve (imported from the Keccak Code Package)
> * SHA-256 (OpenSSL)
> * SHA-512/256 (OpenSSL)
> * SHA3-256 (OpenSSL)
> * SHAKE128 (OpenSSL)
>
> I also rejected some other candidates.  I couldn't find any reference or
> implementation of SHA256×16, so I didn't implement it.  I didn't
> consider SHAKE256 because it is nearly identical to SHA3-256 in almost
> all characteristics (including performance).
>
> I imported the optimized 64-bit implementation of KangarooTwelve.  The
> AVX2 implementation was not considered for licensing reasons (it's
> partially generated from external code, which falls foul of the GPL's
> "preferred form for modifications" rule).
>
> === BLAKE2b and BLAKE2bp
>
> These are the non-parallelized and parallelized 64-bit variants of
> BLAKE2.
>
> Benefits:
> * Both algorithms provide 256-bit preimage resistance.
>
> Downsides:
> * Some people are uncomfortable that the security margin has been
>   decreased from the original SHA-3 submission, although it is still
>   considered secure.
> * BLAKE2bp, as implemented in libb2, uses OpenMP (and therefore
>   multithreading) by default.  It was no longer possible to run the
>   testsuite with -j3 on my laptop in this configuration.
>
> === Keccak-based Algorithms
>
> SHA3-256 is the 256-bit Keccak algorithm with 24 rounds, processing 136
> bytes at a time.  SHAKE128 is an extendable output function with 24
> rounds, processing 168 bytes at a time.  KangarooTwelve is an extendable
> output function with 12 rounds, processing 136 bytes at a time.
>
> Benefits:
> * SHA3-256 provides 256-bit preimage resistance.
> * SHA3-256 has been heavily studied and is believed to have a large
>   security margin.
>
> I noted the following downsides:
> * There's a lack of a availability of KangarooTwelve in other
>   implementations.  It may be the least available option in terms of
>   implementations.
> * Some people are uncomfortable that the security margin of
>   KangarooTwelve has been decreased, although it is still considered
>   secure.
> * SHAKE128 and KangarooTwelve provide only 128-bit preimage resistance.
>
> === SHA-256 and SHA-512/256
>
> These are the 32-bit and 64-bit SHA-2 algorithms that are 256 bits in
> size.
>
> I noted the following benefits:
> * Both algorithms are well known and heavily analyzed.
> * Both algorithms provide 256-bit preimage resistance.
>
> == Implementation Support
>
> |===
> | Implementation | OpenSSL | libb2 | NSS | ACC | gcrypt | Nettle| CL  |
> | SHA-1          | 🗸       |       | 🗸   | 🗸   | 🗸      | 🗸     | {1} |
> | BLAKE2b        | f       | 🗸     |     |     | 🗸      |       | {2} |
> | BLAKE2bp       |         | 🗸     |     |     |        |       |     |
> | KangarooTwelve |         |       |     |     |        |       |     |
> | SHA-256        | 🗸       |       | 🗸   |  🗸  | 🗸      | 🗸     | {1} |
> | SHA-512/256    | 🗸       |       |     |     |        | 🗸     | {3} |
> | SHA3-256       | 🗸       |       |     |     | 🗸      | 🗸     | {4} |
> | SHAKE128       | 🗸       |       |     |     | 🗸      |       | {5} |
> |===
>
> f: future version (expected 1.2.0)
> ACC: Apple Common Crypto
> CL: Command-line
>
> :1: OpenSSL, coreutils, Perl Digest::SHA.
> :2: OpenSSL, coreutils.
> :3: OpenSSL
> :4: OpenSSL, Perl Digest::SHA3.
> :5: Perl Digest::SHA3.
>
> === Performance Analysis
>
> The test system used below is my personal laptop, a 2016 Lenovo ThinkPad
> X1 Carbon with an Intel i7-6600U CPU (2.60 GHz) running Debian unstable.
>
> I implemented a test tool helper to compute speed much like OpenSSL
> does.  Below is a comparison of speeds.  The columns indicate the speed
> in KiB/s for chunks of the given size.  The runs are representative of
> multiple similar runs.
>
> 256 and 1024 bytes were chosen to represent common tree and commit
> object sizes and the 8 KiB is an approximate average blob size.
>
> Algorithms are sorted by performance on the 1 KiB column.
>
> |===
> | Implementation             | 256 B  | 1 KiB  | 8 KiB  | 16 KiB |
> | SHA-1 (OpenSSL)            | 513963 | 685966 | 748993 | 754270 |
> | BLAKE2b (libb2)            | 488123 | 552839 | 576246 | 579292 |
> | SHA-512/256 (OpenSSL)      | 181177 | 349002 | 499113 | 495169 |
> | BLAKE2bp (libb2)           | 139891 | 344786 | 488390 | 522575 |
> | SHA-256 (OpenSSL)          | 264276 | 333560 | 357830 | 355761 |
> | KangarooTwelve             | 239305 | 307300 | 355257 | 364261 |
> | SHAKE128 (OpenSSL)         | 154775 | 253344 | 337811 | 346732 |
> | SHA3-256 (OpenSSL)         | 128597 | 185381 | 198931 | 207365 |
> | BLAKE2bp (libb2; threaded) |  12223 |  49306 | 132833 | 179616 |
> |===
>
> SUPERCOP (a crypto benchmarking tool;
> https://bench.cr.yp.to/results-hash.html) has also benchmarked these
> algorithms.  Note that BLAKE2bp is not listed, KangarooTwelve is k12,
> SHA-512/256 is equivalent to sha512, SHA3-256 is keccakc512, and SHAKE128 is
> keccakc256.
>
> Information is for kizomba, a Kaby Lake system.  Counts are in cycles
> per byte (smaller is better; sorted by 1536 B column):
>
> |===
> | Algorithm      | 576 B | 1536 B | 4096 B | long |
> | BLAKE2b        |  3.51 |   3.10 |   3.08 | 3.07 |
> | SHA-1          |  4.36 |   3.81 |   3.59 | 3.49 |
> | KangarooTwelve |  4.99 |   4.57 |   4.13 | 3.86 |
> | SHA-512/256    |  6.39 |   5.76 |   5.31 | 5.05 |
> | SHAKE128       |  8.23 |   7.67 |   7.17 | 6.97 |
> | SHA-256        |  8.90 |   8.08 |   7.77 | 7.59 |
> | SHA3-256       | 10.26 |   9.15 |   8.84 | 8.57 |
> |===
>
> Numbers for genji262, an AMD Ryzen System, which has SHA acceleration:
>
> |===
> | Algorithm      | 576 B | 1536 B | 4096 B | long |
> | SHA-1          |  1.87 |   1.69 |   1.60 | 1.54 |
> | SHA-256        |  1.95 |   1.72 |   1.68 | 1.64 |
> | BLAKE2b        |  2.94 |   2.59 |   2.59 | 2.59 |
> | KangarooTwelve |  4.09 |   3.65 |   3.35 | 3.17 |
> | SHA-512/256    |  5.54 |   5.08 |   4.71 | 4.48 |
> | SHAKE128       |  6.95 |   6.23 |   5.71 | 5.49 |
> | SHA3-256       |  8.29 |   7.35 |   7.04 | 6.81 |
> |===
>
> Note that no mid- to high-end Intel processors provide acceleration.
> AMD Ryzen and some ARM64 processors do.
>
> == Summary
>
> The algorithms with the greatest implementation availability are
> SHA-256, SHA3-256, BLAKE2b, and SHAKE128.
>
> In terms of command-line availability, BLAKE2b, SHA-256, SHA-512/256,
> and SHA3-256 should be available in the near future on a reasonably
> small Debian, Ubuntu, or Fedora install.
>
> As far as security, the most conservative choices appear to be SHA-256,
> SHA-512/256, and SHA3-256.
>
> The performance winners are BLAKE2b unaccelerated and SHA-256 accelerated.

This is a great summary. Thanks.

In case it's not apparent from what follows, I have a bias towards
SHA-256. Reasons for that, to summarize some of the discussion the last
time around[1], and to add more details:

== Popularity

Other things being equal we should be biased towards whatever's in the
widest use & recommended fon new projects.

I fear that if e.g. git had used whatever at time was to SHA-1 as
BLAKE2b is to SHA-256 now, we might not even know that it's broken (or
had the sha1collisiondetection work to fall back on), since researchers
are less likely to look at algorithms that aren't in wide use.

SHA-256 et al were published in 2001 and has ~20k results on Google
Scholar, compared to ~150 for BLAKE2b[4], published in 2008 (but ~1.2K
for "BLAKE2").

Between the websites of Intel, AMD & ARM there are thousands of results
for SHA-256 (and existing in-silicon acceleration). There's exactly one
result on all three for BLAKE2b (on amd.com, in the context of a laundry
list of hash algorithms in some presentation.

Since BLAKE2b lost the SHA-3 competition to Keccak it seems impossible
that it'll get ever get anywhere close to the same scrutiny or support
in silicon as one of the SHA families.

Which brings me to the next section...

== Hardware acceleration

The only widely deployed HW acceleration is for the SHA-1 and SHA-256
from the SHA-2 family[5], but notably nothing from the newer SHA-3
family (released in 2015).

It seems implausible that anything except SHA-3 will get future HW
acceleration given the narrow scope of current HW acceleration
v.s. existing hash algorithms.

As noted in the thread from last year[1] most git users won't even
notice if the hashing is faster, but it does matter for some big users
(big monorepos), so having the out of purchasing hardware to make things
faster today is great, and given how these new instruction set
extensions get rolled out it seems inevitable that this'll be available
in all consumer CPUs within 5-10 years.

== Age

Similar to "popularity" it seems better to bias things towards a hash
that's been out there for a while, i.e. it would be too early to pick
SHA-3.

The hash transitioning plan, once implemented, also makes it easier to
switch to something else in the future, so we shouldn't be in a rush to
pick some newer hash because we'll need to keep it forever, we can
always do another transition in another 10-15 years.

== Conclusion

For all the above reasons I think we should pick SHA-256.

1. https://public-inbox.org/git/87y3ss8n4h.fsf@gmail.com/#t
2. https://github.com/cr-marcstevens/sha1collisiondetection
3. https://scholar.google.nl/scholar?hl=en&as_sdt=0%2C5&q=SHA-256&btnG=
4. https://scholar.google.nl/scholar?hl=en&as_sdt=0%2C5&q=BLAKE2b&btnG=
5. https://en.wikipedia.org/wiki/Intel_SHA_extensions
