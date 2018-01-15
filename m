Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A05A81F406
	for <e@80x24.org>; Mon, 15 Jan 2018 21:43:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750776AbeAOVns (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Jan 2018 16:43:48 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:39747 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750732AbeAOVnr (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 15 Jan 2018 16:43:47 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id A7A3620C0D;
        Mon, 15 Jan 2018 16:43:46 -0500 (EST)
Received: from web6 ([10.202.2.216])
  by compute2.internal (MEProxy); Mon, 15 Jan 2018 16:43:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=keith.so; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=mesmtp; bh=5eA+3z+4Ag8sWvfm5XUnbJW9U7
        +JJJiXADb5fe34u8M=; b=P0G+lywZZMllv7mvSvMQb7QkZ/z+gdfh1XuKL5cZkd
        pWlqQZ4SiV6m676c1HyUZ3umJYxr0vdiU0/hXS4Lr/mxN+LQDccXwQ4zS8gUHW3U
        hnuYhJBvBBJhmMWJ+H74ZhLUjSYGcgsvMoW1648Pip2GG+c4dicT1hRs2X+jBfbJ
        M=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=5eA+3z
        +4Ag8sWvfm5XUnbJW9U7+JJJiXADb5fe34u8M=; b=hUVOlz0kHrnFMeX3aKNGhU
        fXZrrMo2HHI3NB+UpkHgmn6Z5XGyyASr0kthGPDe6hYKZesJzwBAEO4PlK4waWU/
        43u/KfuAMKngWtTX07dOcN61X5rUM9+We7HqhzxUwpTe4mzPTiBXucicmIXqtdrA
        2m4LrdU57Q/T4Tdtxy/j3Z1woKmJCpxIDI2Lh9hJE0Wwi1yPsTL1KwNC/5WeukaJ
        tUEygrtWXNE7R3gCAGfHxGNA+w7C1DU7El0hKsDxyriRYV4aJmSUrtMzmDsf6UMz
        KoQkOatKei0bYcbZyWLgfITEgnd+852+2LPgb3uWBXumk4F8wefMb26blaIjHidA
        ==
X-ME-Sender: <xms:kiBdWvp5uaYq4Hh27-kCotgsNUwi1T_khWxCggB-GnTnm2nbNk5TKA>
Received: by mailuser.nyi.internal (Postfix, from userid 99)
        id 7F5A2425D; Mon, 15 Jan 2018 16:43:46 -0500 (EST)
Message-Id: <1516052626.2870893.1236353440.65CA651A@webmail.messagingengine.com>
From:   Keith Smiley <k@keith.so>
To:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?Q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Cc:     Todd Zullinger <tmz@pobox.com>,
        =?utf-8?Q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org,
        =?utf-8?Q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Kevin Daudt <me@ikke.info>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Mailer: MessagingEngine.com Webmail Interface - ajax-75de3051
Subject: Re: [PATCH] Add shell completion for git remote rm
In-Reply-To: <xmqq373miw4r.fsf@gitster.mtv.corp.google.com>
Date:   Mon, 15 Jan 2018 13:43:46 -0800
References: <20171229135240.GQ3693@zaya.teonanacatl.net>
 <20171229224825.31062-1-szeder.dev@gmail.com>
 <87y3ll6s0e.fsf@evledraar.gmail.com>
 <20171230005222.GT3693@zaya.teonanacatl.net>
 <87vago76i8.fsf@evledraar.gmail.com>
 <xmqq373miw4r.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

So it sounds like either we should deprecate rm, or I should update the pat=
ch to the suggested method where we just complete remotes, but not rm in th=
e list of completions.

Thoughts?

--=20
Keith Smiley

On Wed, Jan 3, 2018, at 11:24, Junio C Hamano wrote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>=20
> > On Sat, Dec 30 2017, Todd Zullinger jotted:
> >
> >> And I think that should also apply to
> >> not offering completion for commands/subcommands/options
> >> which are only kept for backward compatibility.
> >
> > Yeah I think it makes sense to at some point stop completing things if
> > we're going to remove stuff, if we decide to remove it.
> >
> >> Here's one way to make 'git remote rm <TAB>' work without
> >> including it in the output of 'git remote <TAB>':
> >>
> >> diff --git i/contrib/completion/git-completion.bash w/contrib/completi=
on/git-completion.bash
> >> index 3683c772c5..aa63f028ab 100644
> >> --- i/contrib/completion/git-completion.bash
> >> +++ w/contrib/completion/git-completion.bash
> >> @@ -2668,7 +2668,9 @@ _git_remote ()
> >>  		add rename remove set-head set-branches
> >>  		get-url set-url show prune update
> >>  		"
> >> -	local subcommand=3D"$(__git_find_on_cmdline "$subcommands")"
> >> +	# Don't advertise rm by including it in subcommands, but complete
> >> +	# remotes if it is used.
> >> +	local subcommand=3D"$(__git_find_on_cmdline "$subcommands rm")"
> >>  	if [ -z "$subcommand" ]; then
> >>  		case "$cur" in
> >>  		--*)
> >
> > Neat!
>=20
> Yes, indeed it is nice.
>=20
>=20
