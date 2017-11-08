Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DBC371F442
	for <e@80x24.org>; Wed,  8 Nov 2017 09:33:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751104AbdKHJd5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Nov 2017 04:33:57 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:60574 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750817AbdKHJdz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Nov 2017 04:33:55 -0500
Received: from [130.75.46.4] ([130.75.46.4]) by mrelayeu.kundenserver.de
 (mreue103 [212.227.15.183]) with ESMTPSA (Nemesis) id
 0McyCA-1eTLMK1ku2-00IH8r; Wed, 08 Nov 2017 10:33:42 +0100
Subject: Re: [PATCH 2/3] merge-base: return fork-point outside reflog
To:     Ekelhart Jakob <jakob.ekelhart@fsw.at>,
        Junio C Hamano *EXTERN* <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Matthias Lischka <matthias.lischka@fsw.at>
References: <68633b20-9e2b-ae23-2ede-8728283250f0@grubix.eu>
 <cover.1505394278.git.git@grubix.eu>
 <5513a1415d11517c28158d9b4212d383a233182f.1505394278.git.git@grubix.eu>
 <xmqq60ckzng7.fsf@gitster.mtv.corp.google.com>
 <cd97bb1b-13f3-0856-a250-8f4921b9f6d8@grubix.eu>
 <xmqqshfnx1kl.fsf@gitster.mtv.corp.google.com>
 <xmqqshfgk1mr.fsf@gitster.mtv.corp.google.com>
 <5a2fca1d-4edf-965f-4840-58c924c91051@grubix.eu>
 <xmqqzi9nlcyw.fsf@gitster.mtv.corp.google.com>
 <4a14c35c-88b0-7bc3-0a6e-c69ed9ec7ee7@grubix.eu>
 <xmqqa81njds0.fsf@gitster.mtv.corp.google.com>
 <xmqq7ewckbpk.fsf@gitster.mtv.corp.google.com>
 <b9c2c978a6d3407c8c26509fc82b3920@SFSWW2K12EX02.intern.fsw.at>
From:   Michael J Gruber <git@grubix.eu>
Message-ID: <1a375938-a3dc-d670-dd41-de524ac0f93d@grubix.eu>
Date:   Wed, 8 Nov 2017 10:33:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <b9c2c978a6d3407c8c26509fc82b3920@SFSWW2K12EX02.intern.fsw.at>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:2/McskV4d2JgeHleybTHO0tq3cIQlZ4K2t5uIw7k0YN4Du+9Jys
 OXyXow3U9uDesT7aB+2+RTAYmyMulrkOyJgKwsffnuAKioquTBp2ZLKmt9ElPDfN1BLoj6N
 CdrneJZjdkwCmHU1V1ynHKzfvh7CdbDVN6cw6mxrIFNvWqGNW5LD8Q/dZ+o1gNsC9K9XX/v
 Q366fL1jYGLbNpenVwyGw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:dzQOn0RZzNE=:IFkNLbsqtLTekO24WLVAAZ
 cEzkr5pgn6j6M03+ysOqemYS6RR6LbHuxWqwtZmtoY3hYzpYqKdZC5eVd6OggbhiVo64F+pE2
 B7ndNals1f4XS1Pa1fd5OPrFGe+tcE9PzDiT1OMToYCJzsDGkH3CM3wDE7b7fEaxAmMM60Gm+
 kCt3gmYQnVYxOIvmr8qsGjQoe4Uc2sHxmoK2+1p2tP5TBjSRnpltD/pqfJMSmc+U0PF9V9eD6
 hB0UDhaSyvn5aRj6QpDUwPYn8hUMTtfi+VddFOYz1ISOPKpEDKZQkqoDs295BAqz7HK2x8Sza
 jnhzaQBRZ8mV0A6um0gzm9fhH2RubzPPBQacVILppzMYaj75t/QLJ+BwW/DCgRf4Z2tIQ0QaX
 LaKHMh5SgNP2uH+WmIV7oHPRkDsy9bKnaKJ/XyL1U5J0k+njRxqd8zfQKqxnBsJwkaBd8mHzA
 BGREBYXPWNRtj0aDdAGzdMBfrqEuSmMa3X0RFxJmztmFXxoNXjlyhHg3VoF7TEFm1BGNr4YlG
 AoDKIVeCaVbjuYfCsHdJETC0LKMJq9VVPUCJJqukVGaiYHhabgNaqgT67BhZzeiAq46agFvDq
 UwA/DmeF3EbcvG7o/6FHXTX06Zr7UvqeVgwMSuDj0IcDRY23fYx2qJ1xPEmmyL00rjEXzFG5u
 BDNf12FM08Xyg54u60RYP6UEmnTa20fEUS9ov/2RbHLHekmq6L7cCJyOEAqXEaoYNhBAN7X6A
 h1xUFBmC8iICw/nvxCSq5IpAD6Q51XvDAkj7KiNv7tfFc5vTn4l2cZKEye4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ekelhart Jakob venit, vidit, dixit 08.11.2017 09:52:
> Thank you for all the effort to fix this issue. Unfortunately, we are still suffering from this and our workaround just stopped being sufficient.
> 
> We were wondering if there is any way to tell when this fix will be released?
> 
> BR Jakob

Soon (TM) :)

Term start kept me busy, but I'll try and resume dangling topics this
week or next.

It seems the consensus was that current functionality is as designed but
not necessarily as expected, and another mode "--fork-base" (that does
what I suggested as "fix") would meet these expectations. I would reuse
the documentation of the current mode as a description of the new mode
and add documentation for the existing mode ;)

Michael
