Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 310B9C433EF
	for <git@archiver.kernel.org>; Fri, 10 Dec 2021 22:59:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240357AbhLJXDB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Dec 2021 18:03:01 -0500
Received: from mout.gmx.net ([212.227.15.18]:54407 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239946AbhLJXDA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Dec 2021 18:03:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1639177154;
        bh=0DvY3qx96gQd51+022XYAxi9NRhAgIthQkOA5HFqypk=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=AOCterBUfSo97Am+ur4FTxhrg4KSOp8dOQ8cbHQdi/0iLqDh+8DSb6K2VZnDVt+Bp
         U198VZwvuHcXz45TLkys0H3eRgVVkzZkDM4RnMRpEAvBeveswpn+QOBY+nwPZrd91Y
         w21X5MDD4wnmMYoAG2DxvqjDkCSyj94b+f1aKD4g=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.17.164.160] ([213.196.212.194]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MCbIn-1mmE5K3iIl-009iVW; Fri, 10
 Dec 2021 23:59:14 +0100
Date:   Fri, 10 Dec 2021 23:59:11 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     phillip.wood@dunelm.org.uk,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?UTF-8?Q?Slavica_=C4=90uki=C4=87?= <slawica92@hotmail.com>,
        Denton Liu <liu.denton@gmail.com>
Subject: Re: [PATCH 2/2] add -i: default to the built-in implementation
In-Reply-To: <xmqq5ys7vt8t.fsf@gitster.g>
Message-ID: <nycvar.QRO.7.76.6.2112102356150.90@tvgsbejvaqbjf.bet>
References: <pull.1087.git.1638281655.gitgitgadget@gmail.com>        <84824918ae4564a9194a1a55124ee8694f210437.1638281655.git.gitgitgadget@gmail.com>        <a936a701-c13f-346e-69ee-85441ca20641@gmail.com>        <nycvar.QRO.7.76.6.2112021557530.63@tvgsbejvaqbjf.bet>
 <xmqq5ys7vt8t.fsf@gitster.g>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:SKhGuKHFNrgX2gP4ENsyeKOKGpxNGRIY+GsKWP5Thc8daIFbktg
 sOkvcp9nE8s/Ibbf/J80rc1B+AyBqgxcYMxYvH+g54kYh0CqnbbkXyqPYW51zabcm68HolR
 W7dWdVUOSGjmIzdH6XN0WeAcqBXwNLscjbUPkv2W1vRKKNiPcJDmuTNKmGgJfQIK+/y58kj
 C3TGtCXcfxcR+ueJs4btg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mGeMfw8qMC4=:bRaNfJC6xbwd46M69LH4x8
 kmpichZxZP/objP/oMkcnYbA0I2AtBup8NAcJNyCgPfLeMMMzkPsGG/0NUvh+43EG1WP+dZ0v
 L/w7ahcoDlM9CClHV18Vs3PHbhqNw0+1g7KoDFLkRLVRJJm75VeYnl/WdpTbJ3a8UbnhIBms0
 LK1wE5nn1MLYI+UOEoaqWGUvj650+ZCcYPRqo5JI9Xr2fC1tAZ08xb6Oq8jlS8ciwdD1/Kysx
 OiXmtWi0mOiLfdl+kPZB9N0QF6HbzNZfYrg7cRXPixh+sYeQ7oa64h/vMO/0N9Orvomu6VMve
 FPhd3qfYI5SOFV38pnPKQ0fBLmacyCDJbjIqFZ8Yj5kCkCksB3ynvMklkDbpDF8yJ9l7XeoF7
 WC34yC6qyLaW4JzZ/FKUiRC3LtveEK9KVpw9sk/lI9jz+fKXkz+zyLPQFjGMQh8+MRf5D90a4
 y4sTZGCpziudVdZaeK30301FFn8r0CLFbYfAkbFxzpWjMeeVeIJPXM3zfbHGZFeOaNaw1R//k
 pcVK49xYwpOZQsg4NWfnhmXOgcA+5ZxiFSCSFJhYGy/cg1oCaWOnyqhtkjWgKPmKw6XJD7f2V
 89EwPRXW//I/C5+pQ2xhKfE872FoUki2YfQKvUZwE8Z1XJpACStgJh6AyW/jxB32u8SNbsv5l
 TW0PcswsSUtgOfVU59lFSwNjOobBNG9wtv4VW/sQx2UmjaQKy/dtGo3XY7Y5ezJZkYyQi7Dux
 71WuNWRKJSGZ5ffy6zkJlriRLICkzfvRXWqM7L8VUPsAVKu1T3mWgvfV6oWnD+VF+hens9spU
 u/e24eN+lYpKfqfIbAo6KMn9ZC28k/wVZpV8mlFcqKk8uY+ILLXK0ErVKbTqDRxsL7lcoDUeP
 vuShtnyZGXiEDkkjtn4YAdLp1NMpP2FVIcWl0mJbUZdMfeUh0Rn9uk0k4IcKdp2ckc63Lyjgq
 eqOEBn3wjSXgYl1BNKK3pTeNYvRXI45Q2tfEMLSoNMPtFf3fDix1fPOdP7j5UMF38M/M4s7K7
 L90x4ePg4CCGO2T0q2Ja9cTkRoBzO9YrEzc9wnk5GTl2RZxTJtN/7ZMWYSajXyodrPFHhU4Rt
 Y6ZWhw68plPjwk=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 2 Dec 2021, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> >> > +	if (use_builtin_add_i < 0 &&
> >> > +	    git_config_get_bool("add.interactive.usebuiltin",
> >> > +				&use_builtin_add_i))
> >> > +		use_builtin_add_i =3D 1;
> >> >   -	if (use_builtin_add_i =3D=3D 1) {
> >> > +	if (use_builtin_add_i !=3D 0) {
> >>
> >> This could be simplified to "if (use_builtin_add_i)" but don't re-rol=
l just
> >> for that
> >
> > I was actually considering this, given that Git's coding practice sugg=
ests
> > precisely the form you suggested.
> >
> > However, in this instance I found that form misleading: it would read =
to
> > me as if `use_builtin_add_i` was a Boolean. But it is a tristate, it c=
an
> > also be `-1` ("undecided"). And I wanted to express "if this is not se=
t to
> > `false` specifically", therefore I ended up with my proposal.
>
> I do not think that line of logic is sensible.  The variable starts
> its life as a tristate (i.e. not just bool but can be unknown), and
> the four new lines above the conditional the patch adds is exactly
> about getting rid of the unknown-ness and turning it into a known
> boolean.  After that happens, the variable can safely be used as a
> boolean.  In fact, I view the four lines before it is exactly to
> allow us to do so.
>
> Writing "if not zero" implies that the variable can have a non-zero
> value that is still "unknown" at this point in the code that has to
> be defaulted to "true", which would mean that the "if unset, read
> the config, and if that fails, default to true" logic above is not
> doing its job.  That is a false impression that misleads readers of
> the code.
>
> So, I would say this conditional just should treat the variable as a
> simple boolean.

That forces the reader to perform those mental gymnastics to follow the
reasoning that the tristate now essentially became a Boolean.

I wanted to avoid that unnecessary cognitive load.

Ciao,
Dscho
