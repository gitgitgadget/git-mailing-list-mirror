Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F975C433E0
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 15:45:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F04A9207B7
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 15:44:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236395AbhA0Pok (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Jan 2021 10:44:40 -0500
Received: from mout.gmx.net ([212.227.15.15]:53477 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235907AbhA0Pmh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jan 2021 10:42:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1611762062;
        bh=Cj0h/rau7iLOeio7DDfy/rLUa6hOf5ZBza8o6nLlvXo=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=PW348FlheWYSj6lpkzeATTljXPu7pVTXwkgT4NZFpKl9qsHPk5YeYfWH2C0m89py1
         tZh5QiMi2l4v5oQan7euUVA1GffG5lcFLky2gp/K7jG4ksZhcLMU1KKR81cu0d31Xj
         HIM7Y6sTHRvF1544MCFGxlL/0GDGCOx+Ulvwd2x4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.88.23] ([89.1.213.153]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MwQXH-1lwLOd2MQn-00sROz; Wed, 27
 Jan 2021 16:41:02 +0100
Date:   Wed, 27 Jan 2021 04:01:33 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 3/3] range-diff(docs): explain how to specify commit
 ranges
In-Reply-To: <xmqq1recal32.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2101270357480.57@tvgsbejvaqbjf.bet>
References: <pull.841.git.1611267638.gitgitgadget@gmail.com> <041456b6e73b3a88097d0cc06056eb43d35d42c6.1611267638.git.gitgitgadget@gmail.com> <xmqqwnw5am64.fsf@gitster.c.googlers.com> <nycvar.QRO.7.76.6.2101221720200.52@tvgsbejvaqbjf.bet>
 <xmqq1recal32.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:nPXyy2vs8Gksh51dPZuR7ei9IwzFf5Jq6TPfYzqTYiHdZJqoRrf
 FSlzdxKUuXzNGTj19jEJhBtfzPAX6pe/Ml5GD+d6fiHEN3L3vjQhygkaPDRzJghnYOmL/WT
 vDnBhX82NN4xNBqxu0Lh48aTXj514rZqsJdLrm2uo0VUN/z0YJNO30ixoV1myNJQVfwoMjB
 lsyaCWe7rxETKDKCv/xFw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:tevJaeiPtjA=:MULQX5GMhz7Gvk2H7vJqYC
 ZpTr6egEjWafFEN1bLfOrfH5ku3fL8kbNCUJTa6HxpwJ/y8/h9PB5bacwz6NS2k8A4+UtfAUU
 BDsmCY2RdWjtSEN6DfquvS06EoQyM0F+sgInq3JdZMgXDkluPjhXpcZy4YLLhvP6dEkXBbCkk
 +YOF5RlSigGyahKfi3NZsRvM+89ctjg3elbRUoIlkd//hJTcO3g7ejcYtljaRbM2e+GJZrcqH
 SQ7K3NGUdCO3LyM2jpU3Dc2/6uTiwh4T4dcKsXcOuS/cMWGlB1ErllPvy7qkw2rCywHbHuqik
 LFVlLgWK3GLOLEqf0c/R2Q3VA1Lzdbjo0uGadr5U9UX6qwqKSubxeS9pZRxga9rHRxFkBkR0U
 xbpE97xslfoQ37Rbjn5oEvIi4fRoqEe8Atxl2UIDiR5nJsL4OQ/pStYVr9NyHmtl7zxNA2yNX
 XbxhhL4sNTejhNvI2oFtb7OgtTbemdhjeB1Q1h3xHiTgjR5IhdFVxL+rct8PuiM496LxWL2Nl
 1fGYKIlVQf4GY2cWCdyp/K8+H2ZjKVIQ/aYi6TnuD99A45/oWFivin1EtKU2PGxiKhqjSHZ9A
 D6KKn36xB/q/4R36c/doIe/7XrQd3F17K8+xImE8LQ9uDncjuP3KPdbY3lmCmH8RYZOit3H8a
 577IigV7EAreGVVRhV0kWPUQDHmqUIANaKxVwB1iiOd6VgMnxQC4XFqxrlZjjwDJAVBHlBCZS
 doEqma89hYFmTZI1jKBxChpg+w04ZCDl5kgaD91mKxqXtrSEUyabHkAYX48I7cRGcXxKTICV8
 DPGBl6IcQtD2tO0mmRFL0cOgzKvmP6n4Plw+kZJc8lZyjrNXYGnXXynUhDXtY1u3Rzrg6LMIq
 MFueUVJz/EeKBTTY6cU/gq45Zh/AiOBqDC17cgknM=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 22 Jan 2021, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> >> > +- `<rev1>...<rev2>`. This resembles the symmetric ranges mentioned=
 in
> >> > +  the `SPECIFYING RANGES` section of linkgit:gitrevisions[7], and =
is
> >> > +  equivalent to `<base>..<rev1> <base>..<rev2>` where `<base>` is =
the
> >> > +  merge base as obtained via `git merge-base <rev1> <rev2>`.
>
> The above paragraph says A...B is turned into $(git merge-base A
> B)..A and $(git merge-base A B)..B, but I wonder if we should be
> rewriting it into A..B and B..A instead; that would make it
> unnecessary to explain what should happen when there are more than
> one merge bases.

You know what? I lied. The code already does what you suggested. Look
[here](https://github.com/git/git/blob/v2.30.0/builtin/range-diff.c#L59-L7=
7):

	[...]
        } else if (argc =3D=3D 1) {
                const char *b =3D strstr(argv[0], "..."), *a =3D argv[0];
                int a_len;

                if (!b) {
                        error(_("single arg format must be symmetric range=
"));
                        usage_with_options(builtin_range_diff_usage, optio=
ns);
                }

                a_len =3D (int)(b - a);
                if (!a_len) {
                        a =3D "HEAD";
                        a_len =3D strlen(a);
                }
                b +=3D 3;
                if (!*b)
                        b =3D "HEAD";
                strbuf_addf(&range1, "%s..%.*s", b, a_len, a);
                strbuf_addf(&range2, "%.*s..%s", a_len, a, b);
	[...]

> >> Does this merely resemble?  Isn't it exactly what a symmetric range i=
s?
> >
> > No, it is not exactly what a symmetric range is because `range-diff`
> > treats both arms of the symmetric range independently, as two distinct
> > non-symmetric ranges.
>
> This however is an end-user documentation, isn't it?

Yes, and the end user is talking about _two_ commit ranges in the context
of `git range-diff`, and about _one_ commit range in the context of `git
log`.

So I still think that it really just only resembles the symmetric range.
It is fundamentally as different from it as the number 2 is different from
the number 1.

Ciao,
Dscho
