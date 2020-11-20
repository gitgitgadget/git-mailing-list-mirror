Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B44D0C5519F
	for <git@archiver.kernel.org>; Fri, 20 Nov 2020 13:09:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46CB722255
	for <git@archiver.kernel.org>; Fri, 20 Nov 2020 13:09:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="QkdbHoDg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbgKTNJR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Nov 2020 08:09:17 -0500
Received: from mout.gmx.net ([212.227.17.22]:42429 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726118AbgKTNJR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Nov 2020 08:09:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1605877745;
        bh=nI1HQRu4pfnSHvQYcpONts/QD2FGQugUOti8V8g7BUQ=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=QkdbHoDgBxRewgflmZUhMJN4iptbdewsbCM/mFGTNHQs0dmH8kfLqjrF4LlmOXKPu
         AltdETIaOuKrFInrl4zMR+kD+UXl5h0wEp6q6RDtMbVZVkeR84r+6jDW5wAKXV9EBB
         41wxs+VGi4O1XM2NwQ5J3YaMvrMUiU8SG5FD6BVM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.26.22.105] ([213.196.212.61]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N6sn1-1kBRDK2Myl-018KQU; Fri, 20
 Nov 2020 14:09:05 +0100
Date:   Fri, 20 Nov 2020 14:09:06 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, git@vger.kernel.org, Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 28/27] tests: run tests omitted by
 PREPARE_FOR_MAIN_BRANCH
In-Reply-To: <xmqqo8jtxhyu.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2011201403440.56@tvgsbejvaqbjf.bet>
References: <pull.762.v2.git.1605629547.gitgitgadget@gmail.com> <20201118114834.11137-1-avarab@gmail.com> <nycvar.QRO.7.76.6.2011190044100.56@tvgsbejvaqbjf.bet> <xmqqo8jtxhyu.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:nSZ7cv0AMgFXoblnTjeVXvNRffQ7gdgYIL1MpfNChh2tgfWNAL7
 3S5n1bV8L+earTOUjFoy1yxBPlmmS9JrwZGfeliNMTnXx2lsjVNV0mgxBu+MXrRQq0KU/Hf
 aFEX9nheuyap2Fch7iG3lZG4rSnPAW2X0dYLkUetBHjcCoZsvbmFczk7E9CJ991NUE6JON2
 HzS3D5ChuLjTQLSFo16nw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:crT2a0L9YhQ=:XsteyVt6v15orH/oGVJ1FZ
 fh8ZJvaUDc940UCaZ12CKk4FEO023MtICV5nEvMY2QaHfVBVSuAFe/67f8UccpjSGTd6U3Y7e
 GXS/0OuxD6ZPac8KxRlNkzLa9Qroj9yJPSY2YZ9jstg9R7ZJ8jEXceYXakEgQF4YUOcxYp87s
 aC9Lbu6DXiJxNXxpdxq33mcbHcbjlYoxc8i8CKaf/G2Rs9EsYVqzdpUqoO6Ua7zFH5aecUjhh
 DRS3oegB8ZFZX0/e7J8GgKJjEAoidBxiEug0hlHv5DYrHqdVf0xjCZW/0TfJ/b4kgYDUZF+pZ
 4YkKjeaUmf8wqaApdINPpMHeHQLxwAKBNDb7eKrxFU/zezDfrsYTQ2K1snp6x44frKHOeNATM
 JsVIp1mmCynE/W4RZk6H5IrKBKsPo8S1SPM9W38oct/FUFwuD4E15rz0mfCRNzW05O56DwsPB
 VqUIbcGIMgBX2JBfJH1SMYqMkO/G8sfus9UK6+HXkjfn1nDeHSPPr8woXZ48R8lEqO9VpzgGk
 4hdPg8q2stnCCMZUY5yIyhcBeR70rMVkrIihGe3jfEdLTurinK484d9+Df+VTzdBTOohz72ct
 g5tcHYX4awsPTXb4ukVxNsyLC667b0cpdWCcczG8VOt02apoh2cg8G5K1t7pftnm3PKlFBOl0
 KX7CmbZ7iCpyuPuDN1agukIoD1vhL70e0SA0R0nIRY37WPhfsmIWdI94OazZUevEH/ePcEfHz
 2i7Qv6AJI0xk+4kvZiLcrPBILq4D+DP9AuAGOxGxGJj9ssJTOPXYpmPlYngbWdW3CQ4H/h3iJ
 oiiL/LvEzvBQz0rNNhM72XdIdvfVjZEJZK0pL7eK64Qhgv/IL1ZCh6W1GMP5Ev+1Yu7oQwX8l
 AgKFDUBa9GqaLag1GoxOWw6JIt1DZZEU6/hGwfy+s=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 19 Nov 2020, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> > The conflicts might be trivial, but every conflict makes it harder to
> > juggle branch thickets like Junio's `seen`. And those things add up.
> > They're no fun, and they make life hard and tedious.
>
> The worst part is they can easily be cause of unintended breakage
> due to mismerge.
>
> > t5526 conflicts _semantically_ with `pk/subsub-fetch-fix` (which touch=
es
> > t5526 and adds a new test case referring to `master`).
> >
> > t9902 conflicts with `fc/bash-completion-post-2.29`, and in contrast t=
o
> > the t5526 issue (which is trivial, even if it does require manual fixi=
ng),
> > the t9902 is a bit more hairy to reason about.
> >
> > So yes, I would love to have that test coverage back, but not by makin=
g
> > the transition to `main` even harder by reverting parts of it.
>
> Hmph, wouldn't the forcing with GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
> to 'master' be the right way to keep test coverage?

Well, I was naive enough to think that this whole "let's transition the
test suite to use `main` as default branch name" business would go over
much quicker. With that expectation, I was content to already have
`PREPARE_FOR_MAIN`-marked test cases in t5526 and t9902. They are
currently skipped because that prereq is still waiting for the transition
to complete.

That's what my promise was about: as soon as the competing topics settle,
I want to address those two test scripts in particular, moving them over
to `GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain`.

> After all, the primary goal is to prepare tests so that we won't lose
> coverage when the fallback default of init.defaultbranch is switched to
> 'main', and it is a secondary goal of much lessor importance to reduce
> the number of hits from "git grep master t/".
>
> > That's why I promised publicly to take care of the loose ends as quick=
ly
> > as I can, after the conflicting issues graduate to `next` (or when the=
y
> > become stalled or even dropped from `seen`).
>
> Perhaps I should start to more aggressively drop topics from `seen`
> that are not sufficiently reviewed?  The guiding principle ought to
> be "unreviewed patches are not worth applying", but I have a feeling
> that we have become more and more lax over time due to shortage of
> quality reviews.  I dunno.

FWIW I think you do a wonderful job of keeping the patch series in `seen`.
I wish we could keep the CI build passing a bit more, but I'd rather have
the branches that are in flight in one place, so that it is easy e.g. to
find out whether `git diff next..seen -- t/t9902\*` is empty (to determine
whether working on that script would cause conflicts right now).

Ciao,
Dscho

