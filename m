Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 183E2C433DB
	for <git@archiver.kernel.org>; Mon, 18 Jan 2021 14:38:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCA33221FB
	for <git@archiver.kernel.org>; Mon, 18 Jan 2021 14:38:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392952AbhAROic (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Jan 2021 09:38:32 -0500
Received: from mout.gmx.net ([212.227.17.21]:36475 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392799AbhAROiF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jan 2021 09:38:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1610980587;
        bh=UmWGGEfaCNQZz7MMh0ywEh9/MhjxqUfGaKrHr1tYoMA=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=QiqJqWali5jpuSG3CHG7Q80bzqufeRwz095LNWlRxXySQuXkuzDRHUwfUaNUfFgH4
         cB0vzWhrxiVbRL1r6pnQEoPU2QbE3NVKaUa2tzBC6OgQKiXfVpWt73x8FKDCKXfFq2
         OvXHcBh82kgsPfPQJqSkA1+v3K1bJQ8KEH5Yy0uY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.25.115.203] ([89.1.215.22]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mj8mb-1ldZcc1AA9-00fAn9; Mon, 18
 Jan 2021 15:36:27 +0100
Date:   Mon, 18 Jan 2021 15:36:32 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= <avarab@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH 09/11] GETTEXT_POISON=rot13: do compare the output in
 `test_i18ncmp`
In-Reply-To: <xmqqlfcurn05.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2101181526550.52@tvgsbejvaqbjf.bet>
References: <pull.836.git.1610441262.gitgitgadget@gmail.com> <4669ccbb1ae40f0c58a2d8e3c8b3a34d82176c7a.1610441263.git.gitgitgadget@gmail.com> <xmqqeeiq3pkf.fsf@gitster.c.googlers.com> <nycvar.QRO.7.76.6.2101151643410.52@tvgsbejvaqbjf.bet>
 <xmqqlfcurn05.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:dVstzuXuyugFxwDaR90HDEhL/dR6ItvcZztS3SczDSWxOTo2jT9
 jhiaU6vqEuD+Cl+QfiR5XKA39eWaJqOLxyizfNAUvFKIG1Qq2sosDluehrap6FFEIsi9319
 nrWErhSVABoVtcHZIxEJKfqRfyLPqGDI9SfvoWtd6DZdz21U4LC+etk4pMjx18Blr0vVTnn
 0oCt8mvioh8oQ0o3zUMfQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9k5WoQmr4nI=:NZjc4yNuiQce+IEU+urIxi
 yIghXJru3Wv2znf60fK3+LsP1lspDtAwWdEY9KaTTs5ewFwZfsaYuwf+czwxxg4nDzhogvQqE
 lXBkDTh5+9R1MtgjBxIEDclc+bibLilx5aPXWhRtVxDvGGNs8KL2221tyHEd/O6e0CtXaUMfs
 CuxRtsJNlKREZRhpq28RwhMelLGse4uESOuQlCBR0f3IqgPO1bgTR/8EjP731dTask3oLwj5N
 EscJ3XCBJaIkSb26IOvG4W1i0phg+B9RecBI1H1G5oYpEVX/WAukDJfN32B/40bESRccqj9zX
 M9ADulXGaJ+MBM/CswCuxxB1C5KNQt9GnRMnJFCnhBFTtDQS+vDhkiy/bbqLvuIIR0Tp5sfTI
 aP7fFP54mpgN9feuuKm/EAR/3ZIJGqEj7oY9sXG1nbkaD5IGq2IBvjf4/qpy6it0SnZBXLyai
 yqynRsAg3Wc9kL9jnLp4qstM7w+oU0aaLaXtXPw48KVs8O2eBaa38laiTfnjxiA0lk5DeNNiB
 07mU9zQqB9HV2v74+1/DVmhVSkdo3v8YQvFtDPY+NtNR/ofng2jllS40ynmiTKPXZ0sNGSsmr
 PxRhsfzzLsk6rq6elm+wFzZSTs41b3VZ5PDm9lUDZaN9YEbn7VQPDJz846/OR7M9aoCowtki/
 o6ohggMQmV2daXCb/mOHgQtJKTjnMolm415vNpLxq/lOuii4tiMBhqUJwMfoES/lw8UOUCKdL
 xsWOJ3HiINNzGNSJ6odjVN+2VlrHjG7OohlvgH5qQwJlF4JAxmYe0oUz7+C8lkIP6QDAvE1Dm
 vN8zrNvFVAAbeV5mMSL8JGywZnoeWiSJHB2xBuyGZl7SnfuipD4wc5mXGWK/43uHF9WFunLhU
 laROyHe240olq3PNeeIMf+BNeSYfPi4IZvKbeITbg=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 15 Jan 2021, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> > On Tue, 12 Jan 2021, Junio C Hamano wrote:
> >
> >> > +static size_t unrot13(char *buf)
> >> > +{
> >> > +	char *p =3D buf, *q =3D buf;
> >> > +
> >> > +	while (*p) {
> >> > +		const char *begin =3D strstr(p, "<rot13>"), *end;
> >>
> >> AFAIR from my reading of [02/11], the encoding side did not special
> >> case the payload that has <ebg13> or </ebg13>; if we want to make it
> >> reversible conversion (which is excellent improvement over the
> >> current "# GETTEXT_POISON #" obfuscation), we'd need to do something
> >> about it, I think.
> >
> > Do you expect any message to be translated _twice_?
>
> Not at all.
>
> But what I had in mind, when I wrote the above, was that the
> programmers are entitled to expect that they are allowed to say:
>
> 	die(_("message with <ebg13/>, <ebg13> and <rot13> in it"));
>
> This will be rot13'd, and the entire thing will be enclosed inside
> "<rot13>...</rot13>"; I would expect that somewhere inside "..." the
> receiving end that attempts to parse it by relying on these markers
> will be confused.

Oh, _that_ is what you meant.

Yep, I don't expect any of Git's messages to contain "<ebg13>", ever.

> >> But on second thought, nobody can prevent a caller to die(_("%s", msg=
));
> >> to have "<rot13>" in the msg part, so perhaps punting like this
> >> series does is sufficient.  I dunno.
>
> And this comment still stands.

Slightly pedantic: the call would be `die(_("%s"), msg)` (note that the
`msg` is not inside the `_(...)`).

Similar to my point above, I do not expect any of Git's tests to emit a
message like that, and certainly not once/if we turn on rot13 mode in the
GETTEXT_POISON job of the CI build.

A blocker would have been if there might be the possibility that we _must_
add a test in the future that wants to emit a `msg` containing `<rot13>`.
But that seems utterly unlikely. And even if: then we'd just change the
rot13 mode to use a different needle.

Ciao,
Dscho
