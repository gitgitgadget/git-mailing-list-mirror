Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AD00C433F5
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 17:33:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81906610C8
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 17:33:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345687AbhIGRex (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 13:34:53 -0400
Received: from mout.gmx.net ([212.227.15.18]:39575 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229493AbhIGRew (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 13:34:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1631036018;
        bh=XFK/vXWl2qFKOAixtspiywatf/7YZm0OdyIe46RF0D0=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=hExHaaSFzq6nxqZAVfeQyt8dxGmZTrY7dmA3hq6T8F3Doco3u//mgDBdzhRD5Bu+H
         rV625Ott7/mX6FeaFZzgESMcnWfGkPRN9d1rLYSUHCYpCE+O05ucXcjt4POXtfFifF
         jv37WmgUWZCqZh6Ebir9aqUmRsRdF5EsTjUI6sqE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.30.86.215] ([213.196.213.44]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MPGRz-1mbme70YBh-00PaK1; Tue, 07
 Sep 2021 19:33:38 +0200
Date:   Tue, 7 Sep 2021 19:33:52 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Johannes Sixt <j6t@kdbg.org>
cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Eric Wong <e@80x24.org>
Subject: Re: [PATCH v2 0/7] Drop support for git rebase --preserve-merges
In-Reply-To: <4e998676-4975-8ac2-35a0-34416938b62e@kdbg.org>
Message-ID: <nycvar.QRO.7.76.6.2109071930080.55@tvgsbejvaqbjf.bet>
References: <pull.195.git.1574542242.gitgitgadget@gmail.com> <pull.195.v2.git.1630497435.gitgitgadget@gmail.com> <xmqqk0k0ndbq.fsf@gitster.g> <nycvar.QRO.7.76.6.2109021616300.55@tvgsbejvaqbjf.bet> <4e998676-4975-8ac2-35a0-34416938b62e@kdbg.org>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:yWXj79dpg9zU/EgRvlXJNRHWJUYFYLy9SYmSGfK3lHqdMqQ/70Q
 4/CXeT5UoPBkoz3wURkOTN/TA03M+4BqyuLgmZM9SRLzPlqBGe3Gx34c78/kId+ttJ8q0fA
 90/lfWnM8MqIJtRLBhREd0OwlYDJOJ1GLEhQOZnbx3eVpTvjLstDjEklZ2q4EHLrJ63VQCv
 34WyTvgKwRoKCrZORzxjA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:yjDQujuTFjQ=:lEbYNRaRn/N21TIzPIecSz
 O7DKA+bK5SVMBYFnVLBYwRgtWtZKVHd/rRWJtYQYWUVYP8kLdQqWVQ3mzqsq+9j2XyYYuRZFy
 jrEe4P+NviRZjtanx0bBqKH6X+O7qQwuNwl/9tmTqfh/14I86tMh/QNAzzPIeMkQOzR4RV9Cx
 Qrue+nQopxaXjBgFi8mw4SSCYbX6rx+Z43jQenSjMvIzEFjsBtrcQA8qEvU+d15Hu6nDQvCFt
 9znawvqdTlZ9kr2JpnsnxiG7EqE9Phnvcw3HZunauLwEJxbKfQXQuufQaFNaUHqK2x9bM2Sli
 A7IcdwhUFVNFe+1HLkjinYkjRPdvugxa3HRBla5vO+IGbniA2oaqYufJx+soEnsIbsAjcoadB
 oOuo9lhO2oV0dpq0MIzCyTwgC0iC5tgef9nmtl0WZnILdPtG+LgAgq8DdD3HQZxYhIt8+nRX9
 gs9shVTpwvqNuGWy+jpkFsMiK/vZfPSlk97/ilrcna2tiiiWOSuwseVhsLmHSyWoHJb9Pp66+
 jCYfz5sDrLTPstXnZ1yoqQK2yLep3yYzdtC1OskLo3FyKdepEIBk547A9CkQ1ZJc+J1VS8Tf6
 tp6Gq85oGJ5K8a9f6MH8JtPRPs+SaUPdeKm2xcf6E9GCC3ZSk/M87eCN2fB/a/GvoWTfrC2P4
 PXAowmRAoZKId7ja71ttzoW8eneYGICO6sflL6VA3EmND0sglzPaxOJrNkb2D2Vm4bnbiPZlf
 lLHFyqVZBD613EG05bXQfZdW7wMLsm/cXG3kz9c0ap6U5IYC3tFxS0hJj77IeXlQJKNjGGaS7
 XpxFR5KglvpgWfjQn/vFUTfiLMiSpxEQ/ez/RUNcfDBjSAW/s/7C5dli/PIzW6qITFKJIh7r/
 WuLrS6TX6YGd+2MRn8q4d7vwcrpS7KCMxcsMyGucT8Z14f2Kf6KHce5vxLG6dBa24QWxl1oD2
 WxZs32kGQy8+gIm/m+lz5AqSbtWZ5G6exofcBkOoRUdjsmq+gymITmvuhR4JgR5t3rPAMG5Ic
 u25o455CK8K0N2pXzlduetl4Fcc6I6ha/msa+4w1hywuvM6y+8aQLyAkwFGd1IIhbB2HDJDev
 XD9jsKuS2jswBQ=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Hannes,

On Thu, 2 Sep 2021, Johannes Sixt wrote:

> Am 02.09.21 um 16:18 schrieb Johannes Schindelin:
> > On Wed, 1 Sep 2021, Junio C Hamano wrote:
> >> A good goal.  There is no remaining use case where (a fictitious and
> >> properly working version of) "--preserve-merges" option cannot be
> >> replaced by "--rebase-merges", is it?  I somehow had a feeling that
> >> the other Johannes (sorry if it weren't you, j6t) had cases that the
> >> former worked better, but perhaps I am mis-remembering things.
> >
> > I think that I managed to address whatever concerns there were about t=
he
> > `--rebase-merges` backend in the meantime.
>
> That was either my suggestion/desire to make no-rebase-cousins the
> default. That has been settled.
>
> Or my wish not to redo the merge, but to replay the first-parent
> difference. The idea never got traction, and I've long since abandoned
> my implementation of it.

Thank you for clarifying.

Yes, I remember how that idea came up, and I even tried that strategy for
a couple of merging rebases of Git for Windows' branch thicket. Sadly, it
did not work half as well as I had hoped.

The best idea I had back then still is in want of being implemented: sort
of a "four-way merge". It is basically the same as a three-way merge, but
allows for the pre-images to differ in the context (and yes, this cannot
be represented using the current conflict markers). Definitely not
trivial.

> > To be honest, I developed one (minor) concern in the meantime... Shoul=
d we
> > maybe try to be nicer to our users and keep handling the
> > `--preserve-merges` option by explicitly erroring out with the suggest=
ion
> > to use `--rebase-merges` instead? Not everybody reads release notes, a=
fter
> > all. In fact, it is my experience that preciously few users have the t=
ime
> > to even skim release notes...
>
> A valid concern, I would think.

Good. Since you concur with my hunch, I implemented that change.

Thank you for reviewing,
Dscho
