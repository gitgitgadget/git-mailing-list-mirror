Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 03B6A20248
	for <e@80x24.org>; Wed, 17 Apr 2019 12:26:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732063AbfDQM01 (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Apr 2019 08:26:27 -0400
Received: from mout.gmx.net ([212.227.15.18]:56451 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729522AbfDQM00 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Apr 2019 08:26:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1555503977;
        bh=NmUyt9+Qa7tOXCGh/alSPmGQMlBfGREzRhrMgwwLs1A=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=FeCsIjfB5/CKca94/639/+iSzI/3UxDNqN6uqNwgt6NnzUxHoW35dCyWlWKNBU1Cd
         215SkXmiYMdoiVAsej51PYu4qA5ZUQ3SpoeKEHPrEwUNH6+1XoJ1afGQXUN+/jJjFL
         8tu6SgsCDSUKtmDyPf+nhbcFszS0YruV/wKoJYM4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.14]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MKbkM-1hZUwf2RKO-00KxrY; Wed, 17
 Apr 2019 14:26:17 +0200
Date:   Wed, 17 Apr 2019 14:26:22 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Elijah Newren <newren@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2 1/2] commit/reset: try to clean up sequencer state
In-Reply-To: <xmqqr2a1jenm.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1904171423370.46@tvgsbejvaqbjf.bet>
References: <20190329163009.493-1-phillip.wood123@gmail.com> <20190416101842.16556-1-phillip.wood123@gmail.com> <20190416101842.16556-2-phillip.wood123@gmail.com> <xmqqr2a1jenm.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:L+JetqRPlf8vkg4+XGW1M258oLptWRaL5k0LQ7qLIgWJ1d/7DP9
 Y/is4sLV+nxGyuFcVqZ0nopos8geDGaNMj6xH5FZxWfaz9dHHW0R0E2GjXH/+sfxQtqAy0d
 csYn//4visA4awWHVkjsqXEyDOasCd7vu+uvMIC3jbrCzImTQhvMvn1VOUNdmtWlLnNdB5F
 6fsOcssQykG7RlzpNuITA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Hsv7NGrLiQQ=:/sOKuuph2PCca+FyqtVVV7
 6ufU5rj5y2czID56p1iPxCi32nRXEfW0BGdiMCg7VlOQDfOizs5p3+QA1U/OG3XnOQR+sXwon
 FEnoTXc/0wx8l1omv3fGjvHwNdpaCyDLU4r++Z7eQqJtZtIAq5/ZGaMtiNxu2Q+4TCBkEWHBS
 9bzPF0obCILJCLBF7B1F9Zbbf3yh8ldqILT8o2u5MfFv2yrAUWOCNUsf2wyWaF2dmFAYU7/SK
 WfEaSkMPQg0UZ5XLSztFhBrHBYmzbK6g1J9srYwfjNVwDg0TA09F7dVcQ3UrXr6lcCiHVTZYh
 TkjsbNGZcfoSaolu187cQ84vySYUDc1tio8pcowh2n2cb1Wty9xMZFnuOPmE4g90MI4U6uKYW
 aT0opWeEhq9SpvYq7EGcuhAbXb8DFSgNaO8qPQqXx+nVdK+CXXOXgdBUiggnC2RGUq1JsSjpP
 oYgpqEJsTHc57kpGE2vBjOmV3iW+PyBEW5/IfBrRS84g4yvuYo2AbhaaN7OAmP0rI/EYPUOt6
 RJXk5LhnoAQYqnrqDbqGxfH9eNAw6KnTmnu6Anf6RsNK33H3XWJzA3U5iflDsLhX6bpB4dOe1
 eeSsYzSzfhmiOejakEUFmehNPk4/UZdqud5wO4Hy9ZjshLNkgWsCHpA2uBshc+DC+Sdz+EwYw
 sNaZnGUzjeWd04blfYhrCiOJPc7H1wIVIxsYlVWsQD5FQW5eKqv7XCj4ORnWfItK3/jaoISYF
 VN1gRYHt5uu3bEqpzAZ+sKPSw2kzfHVreTdHxa5aRF0Xqzvg4A9sYLEwjOosJFLR95dd87Ob4
 OP0f+Z4pKK390OfHkklGhGPpJythFsWt3XTrMJXX9ZWAuXV7FLgo2oDrmQp9U4s9tB8iJe6lg
 RN+GRXEyTQKY66p7TJMuP1tEfCNHT768uP+i+Wof2BtYYs8daRE/bZ080zzKvEa/brb11D4pw
 7djl2RW5cxw==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Wed, 17 Apr 2019, Junio C Hamano wrote:

> Phillip Wood <phillip.wood123@gmail.com> writes:
>
> > Avoid this potential problem by removing the sequencer state if we're
> > committing or resetting the final pick in a sequence.
>
> The use-case story before this conclusion only mentioned "commit"
> that concluded the multi-step cherry-pick/revert, and never talked
> about "reset", which made my eyebrows to rise.
>
> As a part of "reset", we have already been removing CHERRY_PICK_HEAD
> and REVERT_HEAD, so "git reset" during a conflicted "cherry-pick"
> for example is already destructive and the user can no longer get
> back to continuing the cherry-pick anyway after running it, even
> without this patch.  So from that point of view, it does make sense
> to remove the other sequencer states at the same time.

Do you mean to say that a `git reset` during `git cherry-pick <range>`
aborts it?

In my experience, this is not the case. The advice printed out after a
conflict even recommends to run `git reset` (followed by `git cherry-pick
=2D-continue`, in lieu of the `git cherry-pick --skip` we have yet to
implement).

So I don't think it is correct to say that `git reset` does not let the
user get back to continuing a cherry-pick...

Ciao,
Dscho
