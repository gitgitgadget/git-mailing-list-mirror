Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 102951F597
	for <e@80x24.org>; Wed, 18 Jul 2018 12:29:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730220AbeGRNHA (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jul 2018 09:07:00 -0400
Received: from mout.gmx.net ([212.227.15.15]:50577 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726909AbeGRNHA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jul 2018 09:07:00 -0400
Received: from [192.168.0.129] ([37.201.195.94]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LiDrv-1gRQGs40mp-00nOZC; Wed, 18
 Jul 2018 14:29:10 +0200
Date:   Wed, 18 Jul 2018 14:28:52 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Derrick Stolee <stolee@gmail.com>
cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Stefan Beller <sbeller@google.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        gitgitgadget@gmail.com, Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/16] Consolidate reachability logic
In-Reply-To: <65d51c26-e248-f16d-bac2-e6ba0a3be8e5@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1807181427120.71@tvgsbejvaqbjf.bet>
References: <pull.10.git.gitgitgadget@gmail.com> <6b7a50dc-6b71-0e31-030a-42dd1b26bde4@ramsayjones.plus.com> <CAGZ79kYem+uMrhv+CUSDNXtE3C8Pv1cx=aZOyBLG=uo-aQWXeA@mail.gmail.com> <CAPig+cQj5_bEiLyAAS4xnsUQEPzqT_2yerdAQxd8FidVpJ5CxA@mail.gmail.com>
 <65d51c26-e248-f16d-bac2-e6ba0a3be8e5@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:p+HrYvxTYecR3Um7ahRryqQw7I25WUVk5OZB0u1P7VEOP8ZJK54
 EpvZvQx+gfvLk3Di+7QtJzX1N47CNZxdIBL91alh1ML8iD7fXA1kPglD/jrneNrkTXfDd/K
 oPpqputyFIwwV47wHLXm+gyOAcJmhcres+EGA2gtwDAG76p6fLLhqIQB46lvI90J01sVsmZ
 2oIJYwkaXg4Hd+XpDwliw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:N871tVUyheE=:7PfM7pwBijFeJcElfltG8g
 H432UCZyz46CXsZz59ferBOEH32SNnDzzxoTorTcAXfLeoH5MGkBKf7XatvHhdUQPvhIigXeT
 CjGFWrThs5GY7P+hN7YBBL9sx0g6lRSv/mHUAF811jfzcGBT+j2bOkNLktstoQaPEcZFfTtJ3
 A5S3NmE6uZ96BFQ5JpnDu+NUqzYKiB1wp0uQSJ02EoHZn8TpdFhfhBXmpyWQdGansDeu+w61i
 HOIqNJ2q0tBpXm6ysPqPjbzknlyrbWFXu6v6DxA/h7Pm3fm3O9gJDBfJO+I1d86ANRA8KvZYZ
 OopimH76VNICF+mUPbchWUvhZGivUvpFiiGYF8iyx/Idj/asdCR8p45ROgUD2h2v3EOBGb0l5
 oAlqwUOHDM9qiAzLA34ErLGm7COf4O6RYkKXsAxmBTF8CzBKsiCPa+/e2ZGNJRtlq8zi3y0yH
 0nOW3nsiPE1Zhx3gbfY499UlZV+ehBFvEvN79hHfqoEVRbhXY2zizFIOki291zeNvwSYSuS5F
 C5Kzh/MBxSrYND/KjOVs4bPLI/I6oSconpvOwwlPpIx81m7liKuuQCQQs+yWs57AMMR7LPHu4
 iWSQyh/sfLjQJ70dzCDKaBCJp1vJi/RlAwe3tTCu3WzocRtgMTLpKMJncpVCfYefZ0HXAHpQJ
 zvCRn6EtGuP3sIvx7mXXZ3qJ53DxqVgT+15PJ0iB2nuJ/OT5gJgO2Ins7MhbE1zG6odTt+ExL
 QnDvx6qDR9d8J2HpPMBJt+m6Z6Rm0x4ufq7uH4kYsFJVOv8GFy+O2Ik9C5PXBLHpAsEPC3SgX
 L9M55Pf
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Mon, 16 Jul 2018, Derrick Stolee wrote:

> On 7/16/2018 2:44 PM, Eric Sunshine wrote:
> > On Mon, Jul 16, 2018 at 1:27 PM Stefan Beller <sbeller@google.com> wrote:
> > > Another pain point of the Gadget is that CC's in the cover letter
> > > do not work as I would imagine. The line
> > >
> > > CC: sbeller@google.com
> > >
> > > did not put that email into the cc field.
> > gitgitgadget recognizes case-sensitive "Cc:" only[1].
> >
> > [1]:
> > https://github.com/gitgitgadget/gitgitgadget/blob/c4805370f59532aa438283431b8ea7d4484c530f/lib/patch-series.ts#L188
> 
> Thanks for everyone's patience while we improve gitgitgadget (and - in this
> case - I learn how to use it).

And let's please stop pretending that this GitGitGadget project is
somebody else's problem.

It is our best shot at addressing the *constant* pain point that is the code
contribution process of Git.

In other words: if you see something that you don't like about
GitGitGadget, get your butts off the ground and contribute a fix. The code
contribution process of GitGitGadget is very easy: open a PR at
https://github.com/gitgitgadget/gitgitgadget

Ciao,
Johannes
