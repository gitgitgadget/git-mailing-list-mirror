Return-Path: <SRS0=DNVg=EI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3046DC388F2
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 12:36:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA4152225B
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 12:36:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="XdEZNeuF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728610AbgKBMgI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Nov 2020 07:36:08 -0500
Received: from mout.gmx.net ([212.227.17.20]:50203 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728511AbgKBMgI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Nov 2020 07:36:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1604320564;
        bh=RMR89nnMYJaYWY252LKYoEIqWsqqWDqa5KNvh7GG2/w=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=XdEZNeuF3hZdxASt0P2rknJ4f9b0tYT9M1rTDDKK3F5ctkKGDL9AyUA7HR6jrwRyY
         +kTHCEZDKrV2yyguzz97Hg2KhRD+ZSdEVyKZu/QSDGuRzwY15ea6VwfkbuPN2zlphG
         8bDG3Sos3VkOcwt0yW7EoqZM23YuBA33R3rE0GJ8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.26.25.62] ([89.1.214.166]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MGhuU-1kdMfu0zLe-00DpZb; Mon, 02
 Nov 2020 13:36:04 +0100
Date:   Mon, 2 Nov 2020 02:58:26 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: sj/untracked-files-in-submodule-directory-is-not-dirty, was Re:
 What's cooking in git.git (Oct 2020, #04; Tue, 27)
In-Reply-To: <xmqqmu079rbv.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2011020251520.18437@tvgsbejvaqbjf.bet>
References: <xmqqmu079rbv.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Pe4xVckejl1RC9nqDEFAWoEWdXB9h3hCd4aFCHolBfcaFsx7UEi
 pUU4y2yU7pfDAh87uFHVnRKnS7EVhKqZhtCfEshfrzalIXzf9dRzJJNJ3VeOcUUOmDmGDZB
 ejxLRIrJ7e3nArx1sNcS4GEyL2/StvQHveu1V8Ia2pr6h/HWSRxeI7wJRJgKmw4rOorvSxq
 zZb7N+uURyjVZjLuWVvzA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:C8f1yLe5uUY=:hDXB/5pkeh5KI9KJhOMzKD
 ZDHPsDRmDUG/b8T7DG80WjSDrT6hoyK5iuGTXOtC4RKQcc5/rjRY9hW3RF35MQrxa4/NwBcoV
 H60RNvAcSJWdbHvptrxWgcpev+R60BuKnUCu1lP7nbygXOoN5+udQOnvAgmnePCh+u5LePsG0
 4Je+DFQ0NE+aabFL+s+wVnkqh//jWTiFDNYV9LuF/kRFyz0kzgNm9LZA3UkrmoEPBlLu+s2eU
 R/X9bc0y6XT8lvNdb9eDcUVKXg6+/yXvcQwQkiXjFymOhwd46YaT9RLkF0EFDaDDg456qDS/Y
 LvAt/MRI6NLEjXZWfHa2+uBKEbETofd7LtTPfx4Ki91WDKrHK6TEiSCXHBfh5rbHNvRRNalu3
 EArBA1KUT3urUH9VIaF4qkwgz1aBtojlFj0HLYWrDZKRgfy2y0V7jHNH7xQlVbA/WcR9ow4UP
 5QWpXFTJuqYIXfh0aRrHJ1Qh944cKqEnEx8xj8fwxV8jxIjTs9rxL0wyExM5ru0dYE/eeN8Iw
 GNU1T92ciC1uFxJuscOMqcnh+MkhLglbJ0/CbhMp00XoA465FjA6XTvSIYJu+upJf1WUlwEUB
 mGU6RnGFussYQjav9ddrLfQECqKUQLYEOqTukR9buHSFseNpuoLcvwfBV1Y70sdzqNL3U9k0S
 zZr2upJ1VAVKIoGt/DtSNtSOXby9aQ+tDtGh6AYCeqjRyOHilP0B4Thh/eUwdH4hT00Drw/9O
 nlvt3VtdhdYe6Lsvrwa/q4C60KKJXw1eKdOF+yCKEjv1RVo+2i8ah2TyqZHjU0Q/q5nU3GFMh
 OCCbC/uNpVWpZJiOCSr/GYJ3Hd8xOnNq54OUbhhBvx8E2/4KA4cw25D1IZKEvTo4Nsf9ezDLK
 3flElhHeg7o8cSK2FHjJHw5VqpobzjPHLZ79jKcfo=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 27 Oct 2020, Junio C Hamano wrote:

> * sj/untracked-files-in-submodule-directory-is-not-dirty (2020-10-26) 1 =
commit
>  - diff: do not show submodule with untracked files as "-dirty"
>
>  "git diff" showed a submodule working tree with untracked cruft as
>  "Submodule commit <objectname>-dirty", but a natural expectation is
>  that the "-dirty" indicator would align with "git describe --dirty",
>  which does not consider having untracked files in the working tree
>  as source of dirtiness.  The inconsistency has been fixed.
>
>  Needs doc update.

I *think* the original rationale for marking submodules with untracked
(_un-ignored_) files was to avoid deleting a submodule that has
uncommitted (because untracked) files.

This is just a fall-out of the submodule design where it pretends that
submodules are files, but files only have a handful "aggregate states":
they are either ignored, untracked, up to date or dirty. Whereas submodule
can be all of the above, pretty much at the same time.

This patch affects e.g. if some script wants to determine whether a
submodule can be deleted safely and uses `git diff` to do so. With this
patch, it is possible to lose data irretrievably.

Ciao,
Dscho
