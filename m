Return-Path: <SRS0=FGj8=74=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E611C433DF
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 10:34:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0AECC20707
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 10:34:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="JPxFAYuK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728428AbgFOKeB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Jun 2020 06:34:01 -0400
Received: from mout.gmx.net ([212.227.17.21]:48737 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728369AbgFOKd5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Jun 2020 06:33:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1592217219;
        bh=pO/bbem5H2bfsMNe3nXOH7VHclSxCkheArnuOmK7QbE=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=JPxFAYuKv2TEibHJtgNJ/v/LNxbz+RFQt9QM9dYx/Ax8sfWIu/ZpC2uTKIV+TMY/r
         5GNU2kxy793QtNeUPlrEOLbcOsefpxkw541aCYTJg9p+lf8Pq3Ax8UoqftByll8OwF
         kpwo8lTIXYLI8OuDzHdsKQFF3Ys5uYBURHi58n0M=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.173.52] ([213.196.213.210]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MvsJ5-1is7c53A2x-00svSN; Mon, 15
 Jun 2020 12:33:38 +0200
Date:   Mon, 15 Jun 2020 00:00:24 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Don Goodman-Wilson via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, don@goodman-wilson.com, stolee@gmail.com,
        peff@peff.net, sandals@crustytoothpaste.net
Subject: Re: [PATCH 1/9] init: allow overriding the default branch name for
 new repositories
In-Reply-To: <xmqqlfks2pod.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2006142350580.56@tvgsbejvaqbjf.bet>
References: <pull.656.git.1591823971.gitgitgadget@gmail.com> <90912e32da1192cfc3b39a18cb606caa46e85b1c.1591823971.git.gitgitgadget@gmail.com> <be09ffbb-4e38-5b67-54da-0b60d5e2d8c3@gmail.com> <nycvar.QRO.7.76.6.2006121308030.56@tvgsbejvaqbjf.bet>
 <xmqqlfks2pod.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Jysb8vywPlvfm9CQW8+QrVx8afBY/rHmfcJv3BkEdNrfydmpmeg
 c762joIKjgsPcK+Jsp0I1dNWCOsuNGcl/MBevFS17XBnK2LNnelQvLwezq5GRMbpBA86+x3
 QRNo56qnQ/RTr1ZUe9xwjmc6TnrsDlyZ8lFNyx98/izXCjMr7BKnicSzsr/lgqO8e3XQdzc
 AJ4m/4UCVnu95jOtXkpuw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:MjNrBEp+ULc=:HTM+yA9HXA6QewLXgpM1oI
 yP1G5vuhiyTeweJqjgZC1bHPd60Q7mRrEnWclnAhzq1oCZ8+9JTeAwdEdwBozOkR5AQLInblJ
 OEIHsz4K/c4XF+o6fiijdEvuSovHJ0+7nGQnPjKDYBvGvl5mw9jXwumFZo2M/DmYGSQ45zkzd
 /qDVe6ln+7T5rWdzAcg+rtxSXiikRkHfo9kJ1E6ZtuRAG7e0l0gOWG+h29i2tOHiRqkIaGM6u
 FlZ7FWNp0qjXHzaBMlqgymdxtBkVky89mMT0MAxlDZZzbJV4BFtj1Q8O7LXpQIOTOfZqAObiH
 g+VXSOnVtI2eJUVwF4cSuAuAEyZ7US0YrVmLZaB3b65UuIPlarsjQdXhqnd8VGYPuDFtCJt5C
 /Bux9fzminoSG5s/e/ep8zKmOkiaky6aP/BZrVofUmOKUtkcgcruxeMpUWbX8rRvVMJXd/a0d
 6rPLsP9+0qYfFluU7en4tdsxa6DJNhQ725veoafvzt43k1niR0YEy1wZxA92OCoCT98jTShuw
 xOdl5kn1nk381Kf+LDfPz/W8uaSwI/GpMSSYsTc9k39MWl98cmROnFvMgyfDasZOB4IuvutwT
 IcC9Tc3DC9iN4Zp7LR29VBxtDYD8bsRAcqqsGuVuKdFHbtmjbXnsvcsQdMdyv9lEzNCZg2Bv7
 G1V1WJxMohXCsudTHJcqUisPSIkf8CdOPUEuDDt3FwyE3kebU6+LBGoNIG89wI3NuTqZP072O
 /RrqJj4YcZRuV5JzyBU6yALGfXnc14YBA3/2wDgnqtFpcJH6U8cUjIXM2CNzhpDbP/oKrqoqw
 MhaWBbDMKuf/jH+CU0cB9qJy9My4fR/NGJsaM2iHlYWSv1r71xtL5+lw8KsOPhB2EcRiRHxls
 QqMVUtOj8G4wid4hVGCX8L6ObHcljf2YQ9ETTFJi9af+l5ewv/4/ViG/8Qp/Eq8z9A73gro+S
 1mV9qHaORWrdopRkValkTL05/ZV5qahswa0qr+oLDiKBUhvXf1qubb9Z7PkKdLM8FR191svRX
 xzTf8EUpzT3mG3mbgN1/PJkXaDIpEXDdjCIMPlE3q2nSkCec7q2O0lySwX1A+RyLszy4SvOBd
 UoLXChayI1n8k0Loy2eYZC/j7J862+bTUOtXR6eVgM0Sw/fLNOTng40GYq4STIbggoWwUJ7Gg
 GaMqh5YNlmXUG4/m00kfOXQueW+3l5csHtThCckTCfPBiNsU1PjEL9d2KLOgoecCP3yj1fp7I
 gDonpdlCzRznSGyok
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 12 Jun 2020, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> > I added a _brief_ extension to the context to the first commit's commi=
t
> > message. However, I do not want to go into details here because _this_
> > patch series is only about empowering users to change their default ma=
in
> > branch name.
>
> Sensible.
>
> And I do not think the planned follow-up work to rename 'master' to
> something else needs to be defended with lengthy history lessons.

Yes, I agree. It is probably sufficient to just point at a couple
high-profile projects that already made the switch to `main`.

> Sufficiently large part of the user population are unhappy with the
> use of the word 'master' as the default name of the primary branch
> in a newly created repository, and the mere fact that we are aware
> of that is good enough justification to move _away_ from 'master'.

Yes, even Pasky says he regrets the choice of term (see
https://twitter.com/xpasky/status/1271477451756056577):

	I picked the names "master" (and "origin") in the early Git tooling
	back in 2005.

	(this probably means you shouldn't give much weight to my name
	preferences :) )

	I have wished many times I would have named them "main" (and
	"upstream") instead.

> In other words, we do not have to explain why 'master' was bad, as
> it does not have to be bad for everybody to be replaced.
>
> But you need to defend that the new word you picked is something
> everybody is happy with.  That is much harder ;-).

To be honest, I stopped looking for got arguments in favor of one
name after a couple days, and instead focused on the consensus I
saw: Chrome [*1*] and node.js [*2*] apparently stated publicly that
they want to change their main branches to `main`, and GitLab [*3*]
and GitHub [*4*] seem to intend to change the default for new
repositories accordingly.

It is not like we have to decide for the community (as we did back
in 2005). I am actually quite relieved about that.

Ciao,
Dscho

URL *1*: https://twitter.com/Una/status/1271180494944829441
URL *2*: https://github.com/nodejs/node/issues/33864
URL *3*: https://gitlab.com/gitlab-org/gitlab/-/issues/221164
URL *4*: https://twitter.com/natfriedman/status/1271253144442253312
(this is not really a public announcement, I agree, but it is a
public Tweet by the CEO)
