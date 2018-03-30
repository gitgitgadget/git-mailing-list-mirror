Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D65751F404
	for <e@80x24.org>; Fri, 30 Mar 2018 18:45:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752259AbeC3SpK (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Mar 2018 14:45:10 -0400
Received: from mout.gmx.net ([212.227.17.21]:52097 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752069AbeC3SpK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Mar 2018 14:45:10 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MGip3-1ep6qR33Y1-00DTWz; Fri, 30
 Mar 2018 20:44:50 +0200
Date:   Fri, 30 Mar 2018 20:44:46 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@dscho.gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Jeff King <peff@peff.net>,
        Stefan Beller <sbeller@google.com>, git <git@vger.kernel.org>,
        Thomas Rast <tr@thomasrast.ch>, Phil Haack <haacked@gmail.com>,
        Jason Frey <jfrey@redhat.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: Re: [PATCH 1/9] git_config_set: fix off-by-two
In-Reply-To: <xmqqefk14jlb.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1803302042570.5026@qfpub.tvgsbejvaqbjf.bet>
References: <cover.1522336130.git.johannes.schindelin@gmx.de> <899ea23951627426ccd0aac79f824af386c5590c.1522336130.git.johannes.schindelin@gmx.de> <CAGZ79kapTWGsYznt7rr0QTNX+uH85TPY8AOA1jtDJ6_q8edX1Q@mail.gmail.com> <20180329194159.GB2939@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1803301415240.5026@qfpub.tvgsbejvaqbjf.bet> <87in9dwsxl.fsf@evledraar.gmail.com> <xmqqefk14jlb.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-519448038-1522435490=:5026"
X-Provags-ID: V03:K0:wcqalM3x2lmjqHggmxB0fQIL2HiH3ypieAuTKWchtjwr3lGyi2c
 VXd8+q8OBPBC0PU2Hn8k/xzEyjxTFgsJZn9AsX5OZyUUTA7+fQyaZfSi/2dg8QE/L1jlwvc
 ZySEMv9WpY5+bVXgepAFDayxiVW6cIUJ7v832fFQbueBuoqS/3lt19hJC858ZZd1h2WmaMk
 Z/ftGbM7py3LQRRzm0FHg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:U4iyateD0Zc=:hayIUTtZCLX760aYOdt+e2
 tZgGB0khPKRZc0LNY8RwQ4vYUgA7iulVuea87vmL/xRBnPwidAH+up7NISvl3DcwBnlXnSFYD
 XhW8/BTbWQg43jSAVeOzAGZXjZ+vgIednQmAxWvy8i0hOlmSTNdxSS6M4MZk3D92TSWaWCl4r
 12NzE6FycllI6m6JJj60PZw0kILwkF613+xx2YL7L0x4aDcELaLNnGJjKRww4rMRmSGbswghH
 ug0OHLMOtXoeNNs3Jv6Wf2Blsz781c1iOfIjXmlj9Pkl5rX7VrIKSJjqb67iZvehKZRr8zRI3
 /Fcwf6Y1mKKsWJUofjfl5lduLSck/bKs/YzSrj8rgf34xUT82vd4nnlVMK0mAi1LspTJDXhIk
 j/EafBJc4Ojheq4Z6QZrh/foj7ndaibZkdTlEC1v/54s36zP2CXPMNJHvkZUB+sVdXpEwMfp/
 YU8QUK6Le4ZCC+ukn+bXGPHBeL9XtJ/RNrK+7Eg2n8k4mRs9FptL904b0znWN87iA8nA5DGo8
 ggFWNhfsRuO7SStwWukgk5Hi8n25eWCgxg0yYq1XFIAVjWqUIChhPqlewa7D8xHbukDcBRzgY
 pOSaAYhK/4COiAXcXmul2LoFn/3k/GSN+x89KX0kjPte6Zm6PoEo5x/Sxe2TkuoDjkqlP9DFM
 tQ87Ks2hZxbPansfzumRRq7zLn8PQ6LUk/WPP3lYMPmM9i7fRknAY2vLghJFJrWnvbk8xdb1V
 Ly6ypy/X9KMveaRAQFVlzUApcwds43Xm+jCZ/cvZSI+zYVkBK1+EHTdHGdjfBwU8vm/LsSljR
 NwxoeAvk9NkxqO1xlfWD5pldUrByvLO92BdxBmbBFRLfQeLb1CuymkF8PAzfEmKZaP3WX+q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-519448038-1522435490=:5026
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Junio,

On Fri, 30 Mar 2018, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>=20
> > I think if it's worth fixing it's worth testing for, a future change to
> > the config code could easily introduce a regression for this, and
> > particularly in this type of code obscure edge cases like this can poin=
t
> > to bugs elsewhere.
>=20
> Yup.  "The port to my favourite platform is too slow, and everybody
> should learn to live with thin test coverage" would not be a good
> strategy in the longer run.

What would be a *really* good strategy is: "Oh, there is a problem! Let's
acknowledge it and try to come up with a solution rather than a
work-around".

EXPENSIVE_ON_WINDOWS is a symptom. Not a solution.

And you are actively hurting my ability to contribute, I hope you are
aware of that.

Ciao,
Dscho
--8323328-519448038-1522435490=:5026--
