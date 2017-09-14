Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6327B20A21
	for <e@80x24.org>; Thu, 14 Sep 2017 18:26:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751568AbdINS0c (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Sep 2017 14:26:32 -0400
Received: from mout.gmx.net ([212.227.17.22]:56517 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751555AbdINS0b (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Sep 2017 14:26:31 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MH5Sw-1deri345Pm-00DrEa; Thu, 14
 Sep 2017 20:26:06 +0200
Date:   Thu, 14 Sep 2017 20:26:01 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Jonathan Nieder <jrnieder@gmail.com>
cc:     demerphq <demerphq@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>, jonathantanmy@google.com,
        Jeff King <peff@peff.net>, David Lang <david@lang.hm>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: RFC v3: Another proposed hash function transition plan
In-Reply-To: <20170913225158.GR27425@aiede.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.21.1.1709141754240.4132@virtualbox>
References: <20170304011251.GA26789@aiede.mtv.corp.google.com> <CA+55aFz+gkAsDZ24zmePQuEs1XPS9BP_s8O7Q4wQ7LV7X5-oDA@mail.gmail.com> <20170307001709.GC26789@aiede.mtv.corp.google.com> <xmqqa828733s.fsf@gitster.mtv.corp.google.com> <xmqq1snh29re.fsf@gitster.mtv.corp.google.com>
 <20170911185913.GA5869@google.com> <alpine.DEB.2.21.1.1709131340030.4132@virtualbox> <CANgJU+Wv1nx79DJTDmYE=O7LUNA3LuRTJhXJn+y0L0C3R+YDEA@mail.gmail.com> <20170913225158.GR27425@aiede.mtv.corp.google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:dM7bFgflcMpMFedmjCRExaOaBUgNQHZJA10NWFC8/dwYa64JVsb
 AunPFzZQo9hwZwpxTCYRZ1I/y1DId0bfyP4jVzSU4Gha0Wmhb9bTp4u99C2VT81OSUkGSfY
 RNexvMDCjNtnEqklVVLyK5HipUOcRCBaWqtY/sKfhhQxbdStLW1kULetdUrkM66oENn77ql
 FTCiP8O26bbnD9ZPbRIaQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:79/WvozA1DQ=:Y1mFr85BbGG3cfHO3JvP2N
 dgAl5AKXUneZTcwtTNas2OqLNj9h8ySqRWjrgmG01d9kguwyTTupcOUI0iAX4GxjJWzY6/8vj
 2baOTqg9Oz3WUf0/fo0dTpzGVT/NU9Xx7KWWAIM6MXFOoxhyukIpS43t47lZ+uiGobEmpO5Vp
 yLUdQTdjA3woD7gSY9WML09n/3P7TXMQe9Sr0KTsQ8D7SxdkivkoTa2bh1XHWzOPgbfw0u0yy
 E9Q7puaT6ZS/M7gXIbC4FtALKufD7fQ/Ja1kMPSQbFPs7uJGjR3+x+ztk13WgKFVwm5wyXjA5
 zuNtAy2pJYcg2zctVtz5hPdtZ1ghIFgP5/gUGk9sBS+LQVU48XjqkmsrUUhi6lRSWyHhB71gO
 J/mFkZHmReKbWJlKIY3wHIdkSBGxVm2mlb901nTH/7lpxzjn8CVglLwA2TMIfvgf0AtJZvbTB
 sFaHY2xBlgzFOVfzgWBDjzT2FLhafd+rDF6uJqVXyn3I7FJWx7M2JLmRKuatZfEB+08HBQMON
 q2fgdCv3DldJ0c0ZNxTUSvLfcPmgYeITlrhD9nhUwlgTj+qtNIzSzLJVKRE/sxChGLN7W+lZV
 V7LwBnSgC4nOZO7Q4RghqfkmMmipHLSrEXdBY+4MFpNIMOtwzLYPM0uHOxhfIQe580uf6kby5
 ibFhLf4cZJpbDlL2z3aFHy7vemLMJ6PSFqIO0XkWGgVXdMdPhYrDmEH7cHTTkB2M3A8lKxczE
 a0ZkkdabAGJVM4eNWEPQJhwu7zBnPgXfac5UAXWHyuWAwcEhBJ8RBqeU1BIBCbG7H61+qKClK
 lpKtCJXKUeFDzZshdbdXjMtM/e1hFg33W5Z8bfS5rjoK5LRLEI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jonathan,

On Wed, 13 Sep 2017, Jonathan Nieder wrote:

> [3] https://www.imperialviolet.org/2017/05/31/skipsha3.html,

I had read this short after it was published, and had missed the updates.
One link in particular caught my eye:

	https://eprint.iacr.org/2012/476

Essentially, the authors demonstrate that using SIMD technology can speed
up computation by factor 2 for longer messages (2kB being considered
"long" already). It is a little bit unclear to me from a cursory look
whether their fast algorithm computes SHA-256, or something similar.

As the author of that paper is also known to have contributed to OpenSSL,
I had a quick look and it would appear that a comment in
crypto/sha/asm/sha256-mb-x86_64.pl speaking about "lanes" suggests that
OpenSSL uses the ideas from the paper, even if b783858654 (x86_64 assembly
pack: add multi-block AES-NI, SHA1 and SHA256., 2013-10-03) does not talk
about the paper specifically.

The numbers shown in
https://github.com/openssl/openssl/blob/master/crypto/sha/asm/keccak1600-x86_64.pl#L28
and in
https://github.com/openssl/openssl/blob/master/crypto/sha/asm/sha256-mb-x86_64.pl#L17
are sufficiently satisfying.

Ciao,
Dscho
