Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A3DD020A21
	for <e@80x24.org>; Thu, 14 Sep 2017 22:07:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751833AbdINWHF (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Sep 2017 18:07:05 -0400
Received: from mout.gmx.net ([212.227.15.18]:59819 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751758AbdINWHC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Sep 2017 18:07:02 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LfjlS-1d3H5a2gjy-00pOl0; Fri, 15
 Sep 2017 00:06:36 +0200
Date:   Fri, 15 Sep 2017 00:06:32 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     demerphq <demerphq@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Brandon Williams <bmwill@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff King <peff@peff.net>, David Lang <david@lang.hm>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: RFC v3: Another proposed hash function transition plan
In-Reply-To: <CANgJU+UpMu82a09h644GjqKLsYzHq-t7Tv8x=+ybTYP-QqyPtQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1.1709142357090.219280@virtualbox>
References: <20170304011251.GA26789@aiede.mtv.corp.google.com> <CA+55aFz+gkAsDZ24zmePQuEs1XPS9BP_s8O7Q4wQ7LV7X5-oDA@mail.gmail.com> <20170307001709.GC26789@aiede.mtv.corp.google.com> <xmqqa828733s.fsf@gitster.mtv.corp.google.com> <xmqq1snh29re.fsf@gitster.mtv.corp.google.com>
 <20170911185913.GA5869@google.com> <alpine.DEB.2.21.1.1709131340030.4132@virtualbox> <20170913163052.GA27425@aiede.mtv.corp.google.com> <xmqq7ex21d2v.fsf@gitster.mtv.corp.google.com> <CAGZ79kakGcMJ7HuH+MPsMrvw40uGchr6H-SQw9-p8pgi3Yk_Bw@mail.gmail.com>
 <20170913221854.GP27425@aiede.mtv.corp.google.com> <xmqqpoauyqlp.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.21.1.1709141722500.4132@virtualbox> <CANgJU+UpMu82a09h644GjqKLsYzHq-t7Tv8x=+ybTYP-QqyPtQ@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:XPfcobsLfZt3SIPAjWQx8OTLm3sCGXJRSakr1PdWoKIZJlvf2kx
 WGWBzrnmSWNUBHREgNXMspY5SfTcBSi6cCLKFhmYKaj+k6TIqMrp0VK5Dai/wXS7tkwIIhp
 tjYBlkctg82gcanFnRF9kTs9DkIjui9IcmrtEvubhO3Y/KvzswsrkVjKmj1L0+cPacqx7VT
 h3XN3F3Abj6dhRQKrkW+A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:4u7P7M3/AM0=:StTIpfSfTkgFO0nroRqZlF
 Uoks4Oaigm558Xiq5AKYWzAjzijzKECgzIeR5wsZi/wr1s1S4LWuLpNsmh+SCCmxKWYGe+CH9
 xd6FIs0V1nw/Pp8cG2Q8JmV6UMayzZv7s9Lv/m1r88RAyR/n06n6vc9ArN98iQJLlZwq0yVSV
 b1nAktFhTd7Qj2nxOFwZXse+k6C3yIpSsIEXoR93gPrjyKqqERujVDuwmY795Y3zt9GVgujPR
 kfg3IB5JVMpxDozW2MBhqD5fMTDD3ARLcmGndYB1hrsaCVY160Db+aaGlREq65yve43Elveqi
 AeoUra2X2B2T9VYfJXRkEz/+d/BcehhFVIlTUc3+jjFQcHpL7hqiQAIkDTcH4K+iEpGkwdNNT
 +KxxuHxD4Jw8+R03UzMYgpdXvA+tsoncrcJynN7q4tRNfj2nII8Fs3w56ouXNlEerA3byrW6t
 vpSrA673WEdbXCjjpghNUlFb6bru+E4NIG8dnMq58y8yub6OcjmIJ8aXfbD6izapDBE+xq6Yg
 unZnLNDA9fCf1FUiqB3jd+nMZg53GnGWaRITL6TOljDdkJGyJZyaZFWsVKdGBLprwx1ifV7Ey
 jbPLnh33gmDUgsPZPqCrLbhvNGy67SN+m08hrv3Vog8jTA5KAcqE9cT50HQAuKCOgN3I0X9Ad
 GUSJUsLx4NpLOgJFkc3Uh8TSHWUx6V7kja5ZOidqPtwai3gw9Ho1hvZgdCYL+MgEcapTA5qau
 BUZb+dn2CeKiIqEo8CK4Z5ubUqYjNZWNIGN+9/YXVhBJwCE1fXKqHJUZGqMfOGDiO9jvZ8qRR
 XYQugoI97UYM/zECnbaUgv6eJoS+eTNEhoFh1z4la4YjUeCWeg=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Thu, 14 Sep 2017, demerphq wrote:

> On 14 September 2017 at 17:23, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> > SHA-256 has been hammered on a lot more than SHA3-256.
> 
> Last year that was even more true of SHA1 than it is true of SHA-256
> today.

I hope you are not deliberately trying to annoy me. I say that because you
seemed to be interested enough in cryptography to know that the known
attacks on SHA-256 *today* are unlikely to extend to Git's use case,
whereas the known attacks on SHA-1 *in 2005* were already raising doubts.

So while SHA-1 has been hammered on for longer than SHA-256, the latter
came out a lot less scathed than the former.

Besides, you are totally missing the point here that the choice is *not*
between SHA-1 and SHA-256, but between SHA-256 and SHA3-256.

After all, we would not consider any hash algorithm with known problems
(as far as Git's usage is concerned). The amount of scrutiny with which
the algorithm was investigated would only be a deciding factor among the
remaining choices, yes?

In any case, don't trust me on cryptography (just like I do not trust you
on that matter). Trust the cryptographers. I contacted some of my
colleagues who are responsible for crypto, and the two who seem to
disagree on pretty much everything agreed on this one thing: that SHA-256
would be a good choice for Git (and one of them suggested that it would be
much better than SHA3-256, because SHA-256 saw more cryptanalysis).

Ciao,
Johannes
