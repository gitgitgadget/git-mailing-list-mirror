Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B28C320A40
	for <e@80x24.org>; Mon, 27 Nov 2017 06:07:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751096AbdK0GHq (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Nov 2017 01:07:46 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50201 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750838AbdK0GHp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Nov 2017 01:07:45 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0F4F6BCB90;
        Mon, 27 Nov 2017 01:07:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=PX0YtDsH94OrvOEuq4wtz19WMiQ=; b=TWjbBT
        nDMlnHQxHOtcPimAOnlIsBet4GG+tp09s8Dofdxg4p1wr+al1Y/sEMvgLAF+Zdbj
        UOkrfe7EMZ6XoBmLTmxwtQz8zAgHdgzBZVlrr0KU1BFYe7F9bVN3e83qeZ0ArW6E
        G7jiXg+Txr3kQu/H4WB4+rqiqTjfqKfWRbSck=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=KMswW0y74gTQDAbj6U5SUZd0QecYj4uq
        zeqC0mphACkpiF9nPgpHiZtyWNmAhN70NSAAEwCpfxqcrgksPeyFDaXBLGw6ZzNl
        Zvj4GRlolaYj751Fb8LDc+d+GNVgU9baBjB53cBFBiLdXc+cVYGHM3bn17MWEraw
        JvjvS31r/3s=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0715FBCB8F;
        Mon, 27 Nov 2017 01:07:45 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6108DBCB8E;
        Mon, 27 Nov 2017 01:07:44 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Nathan Neulinger <nneul@neulinger.org>,
        Santiago Torres <santiago@nyu.edu>, git@vger.kernel.org
Subject: Re: [PATCH] git-status.txt: mention --no-optional-locks
References: <20171122161014.djkdygmclk227xmq@LykOS.localdomain>
        <dfbf4af3-e87c-bdcb-7544-685572925a50@neulinger.org>
        <20171122202720.GD11671@aiede.mtv.corp.google.com>
        <20171122211729.GA2854@sigill>
        <20171122215635.GE11671@aiede.mtv.corp.google.com>
        <20171122220627.GE2854@sigill>
        <alpine.DEB.2.21.1.1711252240300.6482@virtualbox>
        <20171126192508.GB1501@sigill>
        <alpine.DEB.2.21.1.1711262231250.6482@virtualbox>
        <20171127052443.GB5946@sigill> <20171127060412.GA1247@sigill>
Date:   Mon, 27 Nov 2017 15:07:43 +0900
In-Reply-To: <20171127060412.GA1247@sigill> (Jeff King's message of "Mon, 27
        Nov 2017 01:04:12 -0500")
Message-ID: <xmqqindwcl00.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 48B98956-D339-11E7-83C3-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Mon, Nov 27, 2017 at 12:24:43AM -0500, Jeff King wrote:
>
>> > If people have to ask on the mailing list even after reading the man
>> > pages, that's a strong indicator that we could do better.
>> 
>> Sure. That's why I suggested improving the documentation in my last
>> email. But in all the discussion, I haven't seen any patch to that
>> effect.
>
> Maybe like this.

I gave it only a single read, and it was a quite easy read.

Will queue but not immediately merge to 'next' before I hear from
others.

Thanks.

> -- >8 --
> Subject: [PATCH] git-status.txt: mention --no-optional-locks
>
> If you come to the documentation thinking "I do not want Git
> to take any locks for my background processes", then you may
> easily run across "--no-optional-locks" in git.txt.
>
> But it's quite reasonable to hit a specific instance of the
> problem: you have "git status" running in the background,
> and you notice that it causes lock contention with other
> processes. So you look in git-status.txt to see if there is
> a way to disable it, but there's no mention of the flag.
>
> Let's add a short note mentioning that status does indeed
> touch the index (and why), with a pointer to the global
> option. That can point users in the right direction and help
> them make a more informed decision about what they're
> disabling.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  Documentation/git-status.txt | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
> index fc282e0a92..81cab9aefb 100644
> --- a/Documentation/git-status.txt
> +++ b/Documentation/git-status.txt
> @@ -387,6 +387,19 @@ ignored submodules you can either use the --ignore-submodules=dirty command
>  line option or the 'git submodule summary' command, which shows a similar
>  output but does not honor these settings.
>  
> +BACKGROUND REFRESH
> +------------------
> +
> +By default, `git status` will automatically refresh the index, updating
> +the cached stat information from the working tree and writing out the
> +result. Writing out the updated index is an optimization that isn't
> +strictly necessary (`status` computes the values for itself, but writing
> +them out is just to save subsequent programs from repeating our
> +computation). When `status` is run in the background, the lock held
> +during the write may conflict with other simultaneous processes, causing
> +them to fail. Scripts running `status` in the background should consider
> +using `git --no-optional-locks status` (see linkgit:git[1] for details).
> +
>  SEE ALSO
>  --------
>  linkgit:gitignore[5]
