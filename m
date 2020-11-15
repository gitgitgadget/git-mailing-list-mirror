Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90749C83D51
	for <git@archiver.kernel.org>; Mon, 16 Nov 2020 12:38:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3034F20855
	for <git@archiver.kernel.org>; Mon, 16 Nov 2020 12:38:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="cb6NDAHX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729882AbgKPLn1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Nov 2020 06:43:27 -0500
Received: from mout.gmx.net ([212.227.17.20]:37257 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726487AbgKPLn0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Nov 2020 06:43:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1605526992;
        bh=eUU7eYcqftV9UGYFjY8Q8eodXGLr9wCZuSOjpQ/bGeE=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=cb6NDAHXEBL/sJonDKHQ/rvOeQ9iCQ7vzsKndJqqVcMJ8RLw/9t5orTYMKkhdEK5F
         q4ahJB8TngHvgE2U4eicK6tSNL1RdCM0nqoirEf7JLY3badmOfmuvor2/zZFdUxsLJ
         prCUwDxHAFuhkDVm/n+keTrxi066Mcs8gDzfOgok=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.26.25.62] ([213.196.212.61]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MAOJP-1kXjAZ2MWZ-00Bpxi; Mon, 16
 Nov 2020 12:43:12 +0100
Date:   Mon, 16 Nov 2020 00:26:36 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Derrick Stolee <stolee@gmail.com>, Taylor Blau <me@ttaylorr.com>,
        git@vger.kernel.org, dstolee@microsoft.com, peff@peff.net
Subject: Re: [PATCH 15/23] t5310: add branch-based checks
In-Reply-To: <xmqqwnyr38rh.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2011160024050.18437@tvgsbejvaqbjf.bet>
References: <cover.1605123652.git.me@ttaylorr.com> <9ab4b94b3573346b31e710486799ab3d95bade8e.1605123653.git.me@ttaylorr.com> <abf9273f-4795-5a48-c28b-15e68d40b910@gmail.com> <xmqqwnyr38rh.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:N/A1XjNn0aogu5/73wonRtxNy3vnlTGgVE3GFYa0cmWQqLpxoTS
 8Yjb/XyqP6t+y0eaCBzPWYTEV547oNW34RIZX1td6VcDgHcs7qhd6/TBm7upNIs7ppAmqM4
 ahKpYbumYA97qb8E1SSUD0cLP9O0/pE7zosiQAG0843cc5u6sMFeQTtMFCp1V/pwE0pzav8
 ZNHqU44lAeKlrbM1GaFcw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9HELzAzeAHM=:EFuQM9G+j+oJ8uvvkdTYmJ
 ca+f256OdTduR7CG0AbY1L5w3P+tTkwa3ifUimZZHZDwizeEeESSjf4vPVIsV9qN/YW/1wgoJ
 3tUIEfUgw8pEmlLlAW8gp2iCU3mNll4dVq9wu57GXVmadAB5eQMu4G7aDYzzw7NUQs7CCaEsZ
 JuLbkYuTwWM5u0M43qSLCimlk4K9Hd2wMrnkpfi8tX017FmX7G6N2iJ/6Trkk9dJv24r44vD2
 dZuco9Vp19/3kVHh0gFwoDqGld66Kbuf439QKL0y6FoagvPC2cTr+zNRCILn2do0vwvFsrmXx
 /OC4HX6CgbgxbYljBB483fIvtypZs+c10gXzkhjSnmqnXnUHBHlibTvYBPFteWK8U+xSqKSSQ
 du6452IjL3nD8tkOaC5AnjNUw/Z2TIASCpeOWUP7JCHbdTZWX0ichjr5C5GgYv9aiQ3Dypq/U
 GzcjE68+IQjCAbFzrhyfRjpiHeeTSoY2jju4Yx7BQspRcSchbwCPVM+SzNFkIi3cftmZB++CW
 P7oHaU1xlKaGCvULYXk06d0H7wAKvYQbPAcOk0tbGuC/Wp4q5nJp2FhoYEPzQazxAC5bZZAXg
 VkBjjKuTg/dx/27qb6ifr+YRKSDc+6NMAKygufwMV/orj/0WaEDNKv2kZF7k421tCM1nHfeE9
 M8ZMC5tMTk+jvOyrVUP5dWiIfHTas//qrDE7o1PVPt39uxaI5D4wb505Ydllf0lX0aQPFHQhV
 UZeP2S8DfN7i4p8yKpr624n76p63SVDUprhBawKsLNbQ1zPC1fwWMNgDm8EQmdf+Y5QcGEhJc
 cfv5R+n7kBgUzLJWTXjZdbE6YVFfw6SfvFjB5Ea8urUDYAuQoz3PJvkqJEETy+emXW39u/uGn
 erCpw13jbFfCflZKDr48VbGLTjy9Yq8YAFvvOqWiU=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 11 Nov 2020, Junio C Hamano wrote:

> Derrick Stolee <stolee@gmail.com> writes:
>
> > On 11/11/2020 2:43 PM, Taylor Blau wrote:
> >> From: Derrick Stolee <dstolee@microsoft.com>
> >>
> >> The current rev-list tests that check the bitmap data only work on HE=
AD
> >> instead of multiple branches. Expand the test cases to handle both
> >> 'master' and 'other' branches.
> >
> > Adding Johannes to CC since this likely will start colliding with his
> > default branch rename efforts.

It's okay. It's not like this is the only topic I have to navigate around.

> >> +rev_list_tests () {
> >> +	state=3D$1
> >> +
> >> +	for branch in "master" "other"
> >> +	do
> >> +		rev_list_tests_head
> >> +	done
> >> +}
> >
> > Specifically, this is a _new_ instance of "master", but all the
> > other instances of "master" are likely being converted to "main"
> > in parallel. It would certainly be easier to convert this test
> > _after_ these changes are applied, but that's unlikely to happen
> > with the current schedule of things.
>
> In some tests, it may make sense to configure init.defaultbranchname
> in $HOME/.gitconfig upfront and either (1) leave instances of
> 'master' as they are (we may want to avoid 'slave', but 'master' is
> not all that wrong), or (2) rewrite instances of 'master' to 'main'
> (or 'primary' or whatever init.defaultbranchname gets configured).

I explored this option very early on (so long ago that I failed to mention
it). The problem with that is that `$HOME` is set thusly in `test-lib.sh`:

	HOME=3D"$TRASH_DIRECTORY"

In other words, the test repository's top-level directory is the home
directory. Which means that `git status`, when run directly after `.
test-lib.sh` would already show `.gitignore` as untracked, something that
would trip up a couple of test scripts.

Ciao,
Dscho
