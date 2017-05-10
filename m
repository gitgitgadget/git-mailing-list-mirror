Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A12DB1FF34
	for <e@80x24.org>; Wed, 10 May 2017 10:55:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752113AbdEJKzj (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 May 2017 06:55:39 -0400
Received: from mout.gmx.net ([212.227.15.15]:59440 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751593AbdEJKzi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 May 2017 06:55:38 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M1msU-1e0eou44mw-00tnKf; Wed, 10
 May 2017 12:55:27 +0200
Date:   Wed, 10 May 2017 12:55:25 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jeff King <peff@peff.net>,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH v2] archive-tar: fix a sparse 'constant too large'
 warning
In-Reply-To: <xmqqr2zxzjf9.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.21.1.1705101254440.146734@virtualbox>
References: <4bf9be3c-5d19-09e3-b8b3-dd58e00e623d@ramsayjones.plus.com> <alpine.DEB.2.21.1.1705091223190.146734@virtualbox> <5068a9b6-c77a-737d-9d80-40108c5f22c3@ramsayjones.plus.com> <xmqqr2zxzjf9.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:XWNyb4tdU05qizQvOOn+AUb5f/2odQBGxd4nk7b9fiPN1tHeSS6
 DGmeNfavVDoukoIiBC2qX9m+Q85QsykADdQe0f6oCeAYKlLTYtX/TqLq2v8Ai2nMsKUIbYR
 hv84Pe6vIdH33rzjQQmHH/DHTJ9atfQPvFvrzKnkF8for4qBeCpl0rk2a2jPvmlRj2p0oDk
 +2J0GIqZKzag01EI5RrjQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:BZHDlTfZyRM=:oW1VoLIbNS4VwtEQpIT82Z
 KpM++W7IB2HmZ3RIyF14Y8TWoIr64K2VlngP99dlyHAZ47oOOrhzFnm8IkyfnNYS693kXAx3W
 EnvOEJpAMFv4n0yYOIHNOVjU2a6DpnjRirMx1HcROu+gAtYSXdUcOp29uMElYIUMbK04nxkHi
 7RAJvUYsbv3NmyLKbxo15rqh6bVCvefT7LEn3Zj7Z5T2dJEYqL7WM9c10Rv4nshih5b57i/bt
 ObK1tz4zuEjvFLa5dvisdJg2CATG+Ja0RLG42jX4EI3Qc1b5MV9hqYQHEBM5j6wNuJMfRbsyx
 vjdInaL/LU5xFSfxeM2Rrf5gZsh3RH9lcKVnqlr4pVr6Xj6HNf4DcJaFO+rmoq7HKAY9oF0z2
 6WHG+d/6Tug56qRm88i8ZNTGnC7dwswa7u8jBxYIqDLCeX88KiOMFJ3jsovZSk3B7xDelo2fP
 oIpSs/LCNTe9joDUqwHczoO8FtamSM01YAvHKtPSWscjxV/0PbHZG5ngY4nd6joUxa6MoLDio
 c0cFz7fbs83szEdDPxEdRJxGuYBDRllTv2gWcv2iVFtzsQwT+LmzpHfd6P83X0mjVGZa1A9qc
 ab3opA1A2wdcoU2lhBGUd95lx9FiZABsgwhTK/vkZsnNbUKIJQuz8TzyRzRVuKBO94JX/PxbJ
 HgfBI7WW9yx2Gb/HadoTvNGnoBb8SSueIRF577tl4leALTjZ8HPWHu7V/Nx3ovxz/NTZrVAp4
 /MjCZbYZjvOYVU02ZCEBoKuaPI+WYkv4mmQiAEXkzkppohaSatqNNifpPmsWKfeG3oPmJYjOF
 59w7cXh
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 10 May 2017, Junio C Hamano wrote:

> Ramsay Jones <ramsay@ramsayjones.plus.com> writes:
> 
> > Yeah, I had a similar comment in the commit message (but much more
> > verbose than your concise addition above), but I edited it several
> > times, without finding a wording that I liked. I eventually removed
> > it, because it didn't really add any value. :(
> 
> I tend to agree that the proposed additional comment does not add much
> value.  It assures the readers that we (at the time of applying this
> patch) know that the earlier use of ULL was not done with a good reason
> but was merely an accident, and strengthens the claim that this is a
> good change, but the correctness of the change is already obvious, and
> the readers would understand without being explained where the
> incorrectness we have to fix with this patch came from, I would think.

Future me would find that comment in the commit message very clarifying,
though: why was that code there? Ah, that's why.

Now I have to dig through the mailing list to find out.

Ciao,
Dscho
