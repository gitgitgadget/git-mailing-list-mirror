Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 579C11FF32
	for <e@80x24.org>; Fri, 20 Oct 2017 12:53:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751244AbdJTMxQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Oct 2017 08:53:16 -0400
Received: from mout.gmx.net ([212.227.17.22]:61187 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750954AbdJTMxP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Oct 2017 08:53:15 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MXVr0-1dl40Z1fBm-00WU2J; Fri, 20
 Oct 2017 14:47:57 +0200
Date:   Fri, 20 Oct 2017 14:47:56 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Stefan Beller <sbeller@google.com>
cc:     Ben Peart <peartben@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Ben Peart <benpeart@microsoft.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v1] read_index_from(): Skip verification of the cache
 entry order to speed index loading
In-Reply-To: <CAGZ79kZfw7Cb8Qs4BKuESukBL8rCgmYh0=BcNYm9mXJ1LYCg0g@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1.1710201444590.40514@virtualbox>
References: <20171018142725.10948-1-benpeart@microsoft.com> <xmqq4lqvk8ze.fsf@gitster.mtv.corp.google.com> <db8da340-f8f5-0114-392d-e415b5564993@gmail.com> <CAGZ79kZfw7Cb8Qs4BKuESukBL8rCgmYh0=BcNYm9mXJ1LYCg0g@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:8lJHwr3UeyasDM05fNsyNogQVsxGxqEOb5g2OBLNWtptOYzO8M6
 +JbAZ91uAVUQQnOBRw5/Fz7bm4spcKkGGCclbyV7p7IHM0AOzh7nCg6lirXVVvIsLTK+MAb
 Y4L4Y6QJhess9S/LYwdVNvs5d3q3OOKxeesAEsJuhHuJ7uZGPG7ha68aOj7/DB2eXjjER1s
 YBml79FThFr9F2ZHV6tng==
X-UI-Out-Filterresults: notjunk:1;V01:K0:3+MUyyhkJVE=:l1XdOU9FpS6lnzkmf4Fl+b
 x7NsTPXXY2iY1WFPzlyqOn81fsckZpqmnN6Yfg0L94oPgcof7jPNpwrr48Mxeujex+DvIIwWI
 oqmzRNK7hIdHReBFfMV/7kNvXCN6qd8acEO6pZUnzoWscxY0bPc24vnmnQYqyyeBU0wc44C/X
 Wq2brKMkEiKYJ9zh33zqhzIxcP2YCSYpALcffF9iUAMZQNOIjAVwrPIDpjjMDivrW6rB+8u/k
 cSLJhGp0OS7BqPaZx/2t3fqFUt0pejXIvOXmx2v6zEikDXEq9ROJrYL5/mrvpsSTyP6EbZuKG
 6upDhHWOseApAQ3P+zcZpixigEfyWj8mXIHl2A2UMEQNxrouhvZXnpPRcCgdbA1AgLFJYjk0j
 YLGuyj6RJYoYN+v+XEOEn1ZRjB92lIbMOaROzBD39i0A7TKGi9xw45Xnsc7k2qLCFanvX4Zc+
 uVDCOzI3VRDl6Jvq5JZ7Cw96lhvddNRUEplGfbCQ7DYyQYW/vpx20QFkCiuCVVjtxyeaRmSO/
 a0KJCsLcrGYQvZAYMIotu1tOqT1NxNWmFkez3NYO2TDfPQiF7UdwqBmnXArk7QJG+955HinJd
 E6jme7M2j1E4+bozXP0n4q81USTrQWsgpbNMSoivYNDIHVNWrnSdWtQr9JBVXmk/NkG6osCtE
 PjPT9poMMrPXKs2Vo6QyhYILwvw0AVRVFvGZxGHKvHqBcEuf8z4da4ntcGLMsJlle0kc+Pi3G
 lRLFHhSKpdjmuSEC22OdsIYLGS0m0g0PVJ0QGQ/928vEzHkh5W4er7bNKXlwh9Nyx5UilJpuE
 F1gWsG2algQG6sai6Ttl53M67OyDeUDDFCA0icLxYKusaDHts37tYlmIWL2FC7ejOorcCzd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stefan,

On Thu, 19 Oct 2017, Stefan Beller wrote:

> On Thu, Oct 19, 2017 at 8:12 AM, Ben Peart <peartben@gmail.com> wrote:
> 
> > If we are guarding against "git" writing out an invalid index, we can move
> > this into an assert so that only git developers pay the cost of validating
> > they haven't created a new bug.  I think this is better than just adding a
> > new test case as a new test case would not achieve the same coverage.  This
> > is my preferred solution.
> >
> > If we are guarding against "some other application" writing out an invalid
> > index, then everyone will have to pay the cost as we can't insert the test
> > into "some other applications."  Without user reports of it happening or any
> > telemetry saying it has happened I really have no idea if it every actually
> > happens in the wild anymore and whether the cost on every index load is
> > still justified.
> 
> How well does this play out in the security realm?, c.f.
> https://public-inbox.org/git/20171002234517.GV19555@aiede.mtv.corp.google.com/

That link talks about security implications from administrators accessing
Git repositories with maliciously crafted hooks/pagers.

Ben's original mail talks about integrity checks of the index file, and
how expensive they get when you talk about any decent-sized index (read:
*a lot* larger than Git or even Linux developers will see regularly).

The text you quoted talks about our talking out of our rear ends when we
talk about typical user schenarios because we simply have no telemetry or
otherwise reliable statistics.

Now, I fail to see any relationship between Jonathan's mail and either of
Ben's statements.

Care to enlighten me?

Ciao,
Dscho
