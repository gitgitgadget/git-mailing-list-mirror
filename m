Return-Path: <SRS0=IiYM=AE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24087C433E0
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 21:13:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2CCD20706
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 21:13:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="EzZ5sAe9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393266AbgFWVNG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Jun 2020 17:13:06 -0400
Received: from mout.gmx.net ([212.227.17.21]:49095 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391088AbgFWVNA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jun 2020 17:13:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1592946768;
        bh=iZYrV6jwRZkrhTfWy8vbXu9jI0H7D3AmnRYzEVEpVpY=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=EzZ5sAe9FX6guECiw3hPqdVNCQMq2IxPybfoyGkd4Ipv/RuQIsOhPIrszYnlW7J9F
         pL1DJ7sYyzmfMTvPspRXx7im57dpGA/pgpkLxb+movVJXRZlm77EjtW5C91SVQS6tH
         ZbbbxdInNap3IgwJCdC9vXdtwFcROv+vRghpo4fY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.227.237] ([89.1.212.7]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MWici-1jL8CO1evI-00X0tl; Tue, 23
 Jun 2020 23:12:48 +0200
Date:   Tue, 23 Jun 2020 23:12:48 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, don@goodman-wilson.com, stolee@gmail.com,
        peff@peff.net, sandals@crustytoothpaste.net,
        Matt Rogers <mattr94@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: Re: [PATCH v2 02/12] fmt-merge-msg: introduce a way to override the
 main branch name
In-Reply-To: <xmqqmu51s88k.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2006232311270.54@tvgsbejvaqbjf.bet>
References: <pull.656.git.1591823971.gitgitgadget@gmail.com> <pull.656.v2.git.1592225416.gitgitgadget@gmail.com> <f4d547391537e5c3b0b4a07adb41b6aa56541fc3.1592225416.git.gitgitgadget@gmail.com> <1612660e-aa49-5d7f-d47e-34740e330eaa@kdbg.org>
 <xmqqmu51s88k.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:VuCUBZKEqmUrg4xLAvC1iyy2925uXEhikWQ7S2Lue1CFg1P3/lt
 u/Yrc/o4EEXP3AS2sS8O9kAMqG+d5LKx1Gf7uSA53N5FynwUOjhneeMoRQCVrkQPJHErKtP
 C/a3KdijH1Lfz5tV7r8d/ObdZox7az8RT0QU2BQT4g45Orb/kOfZ1GsW4Ycd9R8sr/wswYA
 9VyyZ2PMQml1812HTSBSg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:iboJp2qzwR4=:343ZUgMvyURj3920NnYkeq
 7zJVZWruZVjEcX+gy7R6VgU+m3wFCG2+ikGnp0bFG6l1p5reiveSx+eA+OF0ntGm+SvJX7ksF
 xE3GVpLQPk89BdRByBZHj63H4L2r4zer2mAA+ugW+qHvPOgARIX6OYl7AO+pzqSLkVrGrPrCH
 3FkrDzheSy6ewhjF4tJxRn09IGKOkKE7/4WynA7hxV+rjgs4+ubZ6M4D3pcTb69ZudyIDNmy9
 vDZAAd08I2p/KwiaVVCAUGJz8CORRByDcoz5u21IvpjgDPeZOMomvCPb0CWuv6ldfDJS+lF6n
 1mFj3xIgMytXplTUXKv6qk7qn0tgvqPbaMiUwb3ss995LHgK1QX4iyLl2u5oQKUq4VuM4+HnQ
 90yJht3AJWPtR2DCzjCd2D6ya0GZFxv8f5xzctYUCKWacQWHGSE1MOBi7+q8zIM4XlB6QWIU4
 d2ui2m0ar1gUDYq6oJ2mz271nGJPHHUVKShTRAofvkFyC5D1Bl4qZ5cLrFmLJTQQp6H9RHTre
 VnygIEuOh/8KytnZQ0umBVhmyVGAvJ/r37+FwcQz7cd5YoBAMHxJLhrphUSYCnmWgHYdeTX5I
 tAZTHvVTCScrewqiAqaWPFCcyNd6cqWR0ruB6GR5Mq/RFS96Zx8USUYjFR+CTua6XqBVdE3jx
 9VP99gHIwByaRvk6WQtrW5P9bIXuEF0EZLtqrWI/8Saomd1IlqV6qY9uG7tC2HnLoLdXlCiNl
 y7lQDilGQ1rWnvFwss+EtaoTCu9YBKpvFO7KlOV5TUBz59CRWsJ3IxeTmp8q7arCqOReNEvVc
 MeVDS7S+4ZeZt8NhdA6QpbV4xF5X0Cfi5QxF+NDbyL5RLDISk8xvRBx2/0Al2JMb+AKS43d8I
 G1iiT4WY2l23DGOsmVxdz45h40x8QKkOWiBDqjO9ZA8gXGLQapae/SnvRDy8eEsK6pOrll50F
 7oESvrZrSbYvuq++LPmHhliGWGSBtYJhKAVWw0+HLS3AjDImFyLKxMN/qphw88iZZaCzvBUxM
 sJ224UduPy1l74Ti6iuK46KcfzycYxjUQwtSn4iu39Yc+fK6kDkEpgK8q/Cy1vgny9g4aBZyl
 NdEfZMYAJD+KiRqpGOaS9GvULwZ50myYddndOaorXC5Ya49qzpoKGrfogYxqgkyyo+4kdZb2+
 DCH4To6FRpcS/EAo/c6nz0i3E2c1s8+YeZMEZEqWcfKm7A7Dtj9qEbIsRFGxzRRK5IrzTmkz6
 i4L9/8VwT5ETD9J6A
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio & Hannes,


On Wed, 17 Jun 2020, Junio C Hamano wrote:

> Johannes Sixt <j6t@kdbg.org> writes:
>
> > Am 15.06.20 um 14:50 schrieb Johannes Schindelin via GitGitGadget:
> >> @@ -451,10 +451,12 @@ static void fmt_merge_msg_title(struct strbuf *=
out,
> >>  			strbuf_addf(out, " of %s", srcs.items[i].string);
> >>  	}
> >>
> >> -	if (!strcmp("master", current_branch))
> >> +	main_branch =3D git_main_branch_name();
> >> +	if (!strcmp(main_branch, current_branch))
> >>  		strbuf_addch(out, '\n');
> >>  	else
> >>  		strbuf_addf(out, " into %s\n", current_branch);
> >> +	free(main_branch);
> >>  }
> >
> > Now that the removal of this special case is on the plate, I would
> > prefer that the phrase "into foo" is never appended instead of always
> > appended.
>
> I do not mind such an optional feature.  I always find it useful
> whenever I read "git log --oneline --first-parent master..pu" (of
> course I have an alias for that) to see which topics are already in
> my private "to be used in real life" edition, so I would oppose to
> an unconditional removal, though.

I concur that this would make for a fine optional feature. Of course, that
is an issue that is separate from the goal to make the default branch name
used by `git init` configurable, so I will leave that feature to be
implemented later (and by somebody else).

Ciao,
Dscho
