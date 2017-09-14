Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D6F39209B8
	for <e@80x24.org>; Thu, 14 Sep 2017 12:40:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751936AbdINMkO (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Sep 2017 08:40:14 -0400
Received: from mout.gmx.net ([212.227.17.21]:59888 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751618AbdINMkN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Sep 2017 08:40:13 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MIQlv-1dr67E1Nuh-004Ccb; Thu, 14
 Sep 2017 14:39:43 +0200
Date:   Thu, 14 Sep 2017 14:39:39 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Jonathan Nieder <jrnieder@gmail.com>
cc:     Brandon Williams <bmwill@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>, jonathantanmy@google.com,
        Jeff King <peff@peff.net>, David Lang <david@lang.hm>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: RFC v3: Another proposed hash function transition plan
In-Reply-To: <20170913163052.GA27425@aiede.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.21.1.1709141119140.4132@virtualbox>
References: <20170304011251.GA26789@aiede.mtv.corp.google.com> <CA+55aFz+gkAsDZ24zmePQuEs1XPS9BP_s8O7Q4wQ7LV7X5-oDA@mail.gmail.com> <20170307001709.GC26789@aiede.mtv.corp.google.com> <xmqqa828733s.fsf@gitster.mtv.corp.google.com> <xmqq1snh29re.fsf@gitster.mtv.corp.google.com>
 <20170911185913.GA5869@google.com> <alpine.DEB.2.21.1.1709131340030.4132@virtualbox> <20170913163052.GA27425@aiede.mtv.corp.google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:FcUCcpBz7BE77A8sK+HatAN+IwSCUUL4qmAKf6xgNKMsYjMG62L
 z3TEOBGDeMAoxWkTorxjaXpYkiXv/GUxcPBOgR75IVSM7bcsqTKnQNBNBeXmN75V41yHbow
 mUNucG5uPQMa4mjTEE8Ecuy7Tq3gLZtISEy3UfHgetye6DCD3wsKFL7cL4zyspDFPx8PGRE
 LZrzip3qG3uj/ZnHUNEJg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:taO4lN/G3Ao=:F3MnDXsMw5JauI/hpRUxDW
 wdmWsfp+Onh+cEcnQlxDPCfzZuiB/WgOI6a912BaxpTBRgxX+48AFuOoes7zTyKmAZjZzJR0i
 CCwaS8LsEDSRLztiCCSt4Ru1hARyBDTFQA7IThjnJAzSCN/zgcSFz/0lgbatla05W8nfxgvQb
 K+ZG0dPR8hnncEtGEJMoaJjB+Rp8pUJBMnBJ2jX+eMH7QORsQDF089zsH6Vuh228ypB+JPU/3
 4HukrtCfPWBxnUsKJN/E0Mm9mx67HLtYNbcp9vIFK5EjQ1YmvMs/QfpAfVvyZob2wMs80NgHa
 Qbarv2VIoYfbPK8T3vA41sqvbz5+UchvyzMPPMlw0cuQRJV6AsM8iltlmnG2GPIUPAXac927m
 2EECd9WlOX5Lsw/k+ADWrF1agzxI/2SRjv75tscZILat6uPcrhKITiG01JKI+mLk/U0RrHGz7
 Tj5CwE9BXS5H/mK67Uj3zvJlu2r/iQTdy913wVURaqTyHvrluOfo4N6x4PvdkYOuVOZNaaqcu
 z4c/un4BoDgUHQFJkydkearKh521u3ACSd1iiPszb/Pxq4zOsiuOOEXMOxS1vQDc5K5g6zv6U
 kB7kCNnuydYvoOwuv5qldyjtOfXCNVjZ2dc/c5thdqM+KxXxgd1wAtKJQxDkVu4hU05QjTeuD
 EKKa4tGbLkEapVA//cbUTrncQYsjdWy+/6gzqiMTcX4bpVsFEcK5IylkCspMJhDdcK2sO+aiB
 xv9WBB8nQbI/tzNaBr/u4291G+TYlj+J2E/Wj1F9BY0b7PmJX7s9thv18gM1Ldu142AXkeWoO
 7bKkhTM+O2PpgRXxiQ14BtjnGjBeQsJWmSMrWGmyOcBUQoimaI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jonathan,

On Wed, 13 Sep 2017, Jonathan Nieder wrote:

> As a side note, I am probably misreading, but I found this set of
> paragraphs a bit condescending.  It sounds to me like you are saying
> "You are making the wrong choice of hash function and everything else
> you are describing is irrelevant when compared to that monumental
> mistake.  Please stop working on things I don't consider important".
> With that reading it is quite demotivating to read.

I am sorry you read it that way. I did not feel condescending when I wrote
that mail, I felt annoyed by the side track, and anxious. In my mind, the
transition is too important for side tracking, and I worry that we are not
fast enough (imagine what would happen if a better attack was discovered
that is not as easily detected as the one we know about?).

> An alternative reading is that you are saying that the transition plan
> described in this thread is not ironed out.  Can you spell that out
> more?  What particular aspect of the transition plan (which is of
> course orthogonal to the choice of hash function) are you discontent
> with?

My impression from reading Junio's mail was that he does not consider the
transition plan ironed out yet, and that he wants to spend time on
discussing generation numbers right now.

I was in particularly frightened by the suggestion to "reboot" [*1*].
Hopefully I misunderstand and he meant "finishing touches" instead.

As to *my* opinion: after reading https://goo.gl/gh2Mzc (is it really
correct that its last update has been on March 6th?), my only concern is
really that it still talks about SHA3-256 when I think that the
performance benefits of SHA-256 (think: "Git at scale", and also hardware
support) really make the latter a better choice.

In order to be "ironed out", I think we need to talk about the
implementation detail "Translation table". This is important. It needs to
be *fast*.

Speaking of *fast*, I could imagine that it would make sense to store the
SHA-1 objects on disk, still, instead of converting them on the fly. I am
not sure whether this is something we need to define in the document,
though, as it may very well be premature optimization; Maybe mention that
we could do this if necessary?

Apart from that, I would *love* to see this document as The Official Plan
that I can Show To The Manager so that I can ask to Allocate Time.

Ciao,
Dscho

Footnote *1*:
https://public-inbox.org/git/xmqqa828733s.fsf@gitster.mtv.corp.google.com/
