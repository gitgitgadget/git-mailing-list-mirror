Return-Path: <SRS0=Lnee=43=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 315E4C10F27
	for <git@archiver.kernel.org>; Tue, 10 Mar 2020 12:17:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 039622468E
	for <git@archiver.kernel.org>; Tue, 10 Mar 2020 12:17:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Tt/Q6cb6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbgCJMRr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Mar 2020 08:17:47 -0400
Received: from mout.gmx.net ([212.227.15.19]:34779 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726211AbgCJMRr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Mar 2020 08:17:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1583842663;
        bh=ZMWC0sSu/yYhW1gmEYqym39L8W//VCYOviNwwPG3Vbg=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Tt/Q6cb6ESRkxv/jOSKGmQC2Qd1we5ViBKjy3zwctpGz5iRDKVAeVT/cjLcwsz/yI
         X9KqcEa5PfM5BK1/Y6fP1TLwjJ8Vur8LMDeT7Ley2TRGMFqsEozFGgVDNmHL8rB800
         qMv77Plkhu1ZnxeuG9HjbWTXVjTz9lebum2Mb4f8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from MININT-QA14EDB.fritz.box ([89.1.212.209]) by mail.gmx.com
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MNKm0-1j0Bkz0qpm-00Os0L; Tue, 10 Mar 2020 13:17:43 +0100
Date:   Tue, 10 Mar 2020 13:17:28 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jonathan Tan <jonathantanmy@google.com>
cc:     git@vger.kernel.org, stolee@gmail.com, git@jeffhostetler.com
Subject: Re: [PATCH] rebase --merge: optionally skip upstreamed commits
In-Reply-To: <20200309205523.121319-1-jonathantanmy@google.com>
Message-ID: <nycvar.QRO.7.76.6.2003101315100.46@tvgsbejvaqbjf.bet>
References: <20200309205523.121319-1-jonathantanmy@google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:ShvonHOuqppWpV4l7YCmhsBFlvTbEwxf9ib0LaMS3vkZyozhsmK
 Rmg6yQ58YXgd5rnt1dNjI5xvkZTBD58NY5AlyKnhDB6ffuSTGow/jKM/SeThrGA+Iv+4AHE
 i3P6aHcyOy3DONMc8PD3Js7pcfkP/pD6XTMfnXLTSpyGOcEZlNBJeB2v+XcMij2JqJ3rvJB
 xRvOLT/Y9fdTaffiSaEFw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:BJqajae/nkk=:PVCSN2fiD952nQO55um8wa
 UUR4X+P1u8uDaKUISrkOlzQ0z9BhY8R6TIpIGSBamA/VBZ1tTUlc8fMJZE33BswOKppdx70RX
 Nklz+8uqrwzBpNbM0GdWe1IPvhn7cDNOpZQ/+qjrq/DhYKVMIVvGUwoPXV2gje+Lxsoefj6/I
 PlsmeiQsgRaTEo0UKePkkkslIaoP7xFL9aVfIODx2lvMP1D5w93Tb0N/BmBUiaYr4i1D++8Pj
 LGWJ0BbzE40yfZqEX5U3s8Fwxs4LIEsTA1klX3Ej3I1sRmjt5jjSffneBlXB9zlhSebQm//Sm
 FLKQpOsa/CIx0WoGUnI6Xxq8Nltj9AzhiEpNe2qmVM6AAKXLCizWpf010Jr5on6LWbQPQSM0v
 vjFdD1wSMt9JyvG6zhu6Uk03IBlHAQd+IJcPnq6xQmEHo+oGS47bG1Z8J0+E/lmucTJPkzEM+
 rnuYDEvhUq6zsgRziGHNw357H0/dv0JXGlS/oYhMlXbdAsyHukZxEjNsjUWAoJ69RM9Z/+hmp
 6/1EZeIjpdopAbYNruZD/Z55UDmy045amZ3yYw4Ch9nJS7Ja7OyQJZ5RojgWlTKJkp0c+PxYX
 NLtKBqpzWcsjN4mMEKsuQda+2/A+po/XfcE7PV1rKjHyJXoBrzMew/3Ho6bu0Yfneaq3RAnXP
 8ResYGm1xkl5rYbCGYBdgFAho8m9ndO3/RgZsIWyP3io5aalZpfikP8B7pfn1J9f9qS6VVeda
 npaGcEU25rplvoQV2bzACtwcUYLa7OC+bGuJ93MitVThI1ai9MbAO+Ld9y1qndv/pE7K9ZTU5
 m4DQXu3ozT4ENOcc28Ea1d4tuOLkIlq0bzey/mz5tRRH5GHONhx4JQH/lfyFSg3Z+JaEUbROP
 w3vwdBtOqOt0BRbeh6j2GBh4WPk3o/cUjoKIMCQxcSnkD6Xg5DkxWz1jey01aUIfeXzPLLVoE
 ZC3j9XAI8rhWJdoS2HwpD9UkNFPCI3tX2WXqEHeDKyCzimIgG9Qw9yw8VqIorT+cfGXbcZJp4
 JUrxogalHSEa4tcQK8mJXfsBpnHgBz5YEffMxxyC50r7za1XN6QQiiN2VmmJvRWm0lR2ofOXU
 ek6LJJjcT8WhYr4sH+d/FwpFdii/KdKnhjOjs5SAqpO27kqlXKGjE8uP2IIcrkFv8SHC5EoBw
 9LIAf3+h3FscIq/Vn4qUZgq/umfE4MF08X1znQE5YiJJm4ve2ausx+INqCrrQDJCuLVcfNy/U
 jZ3DwLRfH4VqCx41c
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jonathan,

On Mon, 9 Mar 2020, Jonathan Tan wrote:

> When rebasing against an upstream that has had many commits since the
> original branch was created:
>
>  O -- O -- ... -- O -- O (upstream)
>   \
>    -- O (my-dev-branch)
>
> because "git rebase" attempts to exclude commits that are duplicates of
> upstream ones, it must read the contents of every novel upstream commit,
> in addition to the tip of the upstream and the merge base. This can be a
> significant performance hit, especially in a partial clone, wherein a
> read of an object may end up being a fetch.
>
> Add a flag to "git rebase" to allow suppression of this feature. This
> flag only works when using the "merge" backend.

I wonder whether we can make this a bit more user-friendly by defaulting
to `--right-only` if there are no promised objects in the symmetric range,
and if there _are_ promised objects, to skip `--right-only`, possibly with
an advice that we did that and how to force it to download the promised
objects?

Ciao,
Dscho
