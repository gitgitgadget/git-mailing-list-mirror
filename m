Return-Path: <SRS0=LPWw=2P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03F3AC2D0DA
	for <git@archiver.kernel.org>; Wed, 25 Dec 2019 12:09:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C27172073B
	for <git@archiver.kernel.org>; Wed, 25 Dec 2019 12:09:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="k1iayt7A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbfLYMJo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Dec 2019 07:09:44 -0500
Received: from mout.gmx.net ([212.227.15.19]:36907 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726106AbfLYMJo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Dec 2019 07:09:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1577275778;
        bh=H2x2W4IDOTScIoauiOJyB/DmYrz6GWZBUKYVKgqHGm0=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=k1iayt7AvzhujyXulhjI0VuFasu4alvcvwskMnUzsc6wC6evs8nUWt61tDGvySRiu
         Yz7YtgE1NwnnZivaMiZb0vS+NT0ds+wtpp9U3sJy/UUUtqW0fWULOVjoasdJiiHS2b
         jJ+JxxF9v8HD6ZfBbTHglSS3dSDtU0mf9GEjhvtg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.152]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MORAa-1j8lVn46UY-00Pujm; Wed, 25
 Dec 2019 13:09:38 +0100
Date:   Wed, 25 Dec 2019 13:09:21 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/9] built-in add -p: add support for the same config
 settings as the Perl version
In-Reply-To: <xmqqimm5601h.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1912251303320.46@tvgsbejvaqbjf.bet>
References: <pull.175.git.1576968120.gitgitgadget@gmail.com>        <xmqqpngd60rx.fsf@gitster-ct.c.googlers.com> <xmqqimm5601h.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:L1tp6jsgyMQNubZ0VEH3Z9/Bq72WHPVvfDJbWYlKWDkyxv9VSn0
 KgXuCoHfVhDF886IRTlhmLQVe74Kv+66Co9aAHQu8N+teMJYkNL9y385Xzhht9NTX+tgs80
 xxoYzp1W1AMeeheDQOnQpT5Q5SZS+1hAfqGYXaurtQdJ1KsM0NPPXK2xKVS10b7BIEBJ5oL
 9M4AnZlnbAWjtZtWdZ/+g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:SE9TXZZfHwM=:PoBHF2m6gIBdqnEviQ18/7
 euWcmUVTOLR8ziHOJeZwJMjAI3XdIQzButljzR4zXouBezF/85PFNDlU5QOAcP7ueaPXJvpFq
 i2Vmc1UZNMEd6ge1yWTzJvJQEVuQ/DpVPtXW12H2BldXyuraXLtzHLYRwSyaqSOoyrVQIjYtf
 JoSO0tTRSlovQ9kocVrEXcK5gfksgLqecxlD2mEeb+xmBu1cDuzSvPcag3bykYIhUjBUMvXAF
 CKxR52ZAxWtuMm/9H4S/n1RDeEcS2XW4s9BP2vFvSeMWGLE7wEaYE/1CTsCKntPV5cVxFKA4a
 0kz29aEqfnh4JOrFL35uFDLj0ynGBMxrbRGZ5LVo1CMhvcaSYaXcruuygQpBNyAB5X9WoSCnC
 B1GOUEhXSXxIEkR0aBXw+JbkODOozKTwp5Cu91GvoPwWfwUcuadeIhK9mr2p9zEtkpyYpc3SW
 9muKoxPkIwdK0jrBkz+7xxKBijFRCcQgU5Ehh+g8PD7YwC17noGGgEIEHA571hTRrtBug9+OQ
 jKY4Vvg9ftgrLZKTBly8nRfIzjTPZvb5tbmM2XwoW/tAS5IGTsJveeJxo5fvbycHNE8hUvCfk
 KV4HQMUtxkQiXuf+IAODeAfYKL//CaDur9fzHfGlzjhyYglfEXbmbHMhV+PDVPF6dHUmL9yn+
 /XloCvwe30mwVUQOYPTZ+G40zU0YZDjbtZf9FTXCqx0b/EGyZf93/Eg82FpxAR+5PfuydWPL2
 4OkXd/8X/F5H864AIcOt21hI10hjfY28AYSEhFD0ujgXSd/58xJ+B0DTtx8HZ4fkD5ZDsItVO
 swIaWBwfzRM3VCornQtxUgWRbYGT0c3InDEPFz4k2Dk1n/JB3RrV8fYW//T1rbhBj3Ghj86/w
 RlGsK0wMK2KKwU4+G1fevbadKC5Gq8zDzERkhhwXgrRzjd4yXTXR+BdCWzfy2FHwuTVIiKR/m
 1joLL2N1mX4ZIgJl75wP3tQlU84ZnTrKXHc5/KDuFzOR4UAFqyMaQaB0mA9r6nGfO/J07fAzl
 lKvFsH9W/k/i13t7O2KuBvduFe0/VwcqPLDFFX5OIGWQrcw81sTBaeme+VUsAAF+YI1V3EfCE
 M9dPdscYcU17m2/ubDadCu7RxJOn4xQZq9OmFmcjSNnurtciDMC3YgKiVLiX5/FzBHEo9s5ni
 ZaGzjId6NU2+rLc/B9H56iVucd9OA7lrAOLJv8ys8nvnv7ENhh5nRa7fKpPMg9iiohv9A/piL
 uptfwdDqItOefoQrXxTuM3Z9gzI0UGzOnrxuGcCrhCw2mFk2O7ZukRRY8NuA=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 24 Dec 2019, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
>
> > "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> > writes:
> >
> >> base-commit: 2d4b85ddc76af3e703e6e3a6a72319b5e79c2d8b
> >
> > It is not generally helpful to those who reads this list to use a
> > commit that is not part of history leading to my 'pu' or 'next' as
> > the base.
>
> I think there was only one spot that needed adjusting to the newer
> iteration of the js/patch-mode-in-others-in-c series.
>
> This may have started as "there are some configuration variables
> that are ignored in the C version, fix them" and that may be why
> the pull-request branch says "config-settings", but overall, I think
> the bulk of the change ends up being a "how would we implement the
> annoying-to-implement-portably single-key behaviour".
>
> I think it is a mistake to write the lower-level terminal access
> code without using established libraries (or write it with a higher
> level abstraction offered by scripting languages like Perl and
> Pythnon), and I would personally take, given a choice between
> accepting such maintenance/porting liability and dropping of
> single-key behaviour, the latter in any second.
>
> I wonder if it makes sense to split this series into two so that the
> early and easier part for leftover config bits can graduate
> separately early in the next cycle, instead of letting the parts
> that tackles the terminal nightmare (note that the problem being
> nightmare is not the fault of this topic) which would inevitably
> take more time to stabilize take the remainder of the series hostage
> to it.

I wondered about the same two things: whether to use an established
library, and whether to split off the patches for the config settings.

Alas, I did not find any established library that I could use on Windows,
so there is _already_ a precedent for doing it the way my patches do it.
And if we already have to e.g. spawn `infocmp` and poll to catch Escape
sequences for Windows, my reasoning went: why not just do it for all
platforms? This simplifies the overall complexity of the patches, as we do
not have to do _too_ different things for Windows vs non-Windows.

About the config settings, sure, they could be split off, but for me this
patch series really is about getting the built-in to reach parity with the
Perl script version of `git add -i`/`git add -p`.

In short, I really would like to keep the overall direction of this patch
series intact.

Ciao,
Dscho
