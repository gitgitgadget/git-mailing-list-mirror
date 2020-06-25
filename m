Return-Path: <SRS0=4a08=AG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDB83C433E0
	for <git@archiver.kernel.org>; Thu, 25 Jun 2020 13:07:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD74B20702
	for <git@archiver.kernel.org>; Thu, 25 Jun 2020 13:07:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="PsbCEXpK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404760AbgFYNHR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Jun 2020 09:07:17 -0400
Received: from mout.gmx.net ([212.227.17.22]:33611 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403941AbgFYNHR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jun 2020 09:07:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1593090423;
        bh=lFqq6pFvT1ZR0aZZro2Pf/IQvnVu9wCcDd61/oBACGY=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=PsbCEXpKKYqrLwW/bmiAR5n7WI7hna09PXunodIkecoBqO5626nfjdmpUKxDzPase
         +FQvhTh/I5iPm9XQ0VrNfFvB3tqoLdVPNtrJ4tObkBIY+RCeZUzVKp/3OCjctH2l/z
         jmEntDla5MsVY/mudEhoeVGlAFFlxXt7QnhVZBrk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.227.237] ([213.196.213.24]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mo6qp-1j4vYT37Vr-00pZta; Thu, 25
 Jun 2020 15:07:02 +0200
Date:   Thu, 25 Jun 2020 15:07:03 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, don@goodman-wilson.com, stolee@gmail.com,
        peff@peff.net, sandals@crustytoothpaste.net,
        Matt Rogers <mattr94@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Denton Liu <liu.denton@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
Subject: Re: [PATCH v3 1/8] fmt-merge-msg: stop treating `master` specially
In-Reply-To: <xmqqzh8s7838.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2006251506020.54@tvgsbejvaqbjf.bet>
References: <pull.656.v2.git.1592225416.gitgitgadget@gmail.com> <pull.656.v3.git.1592951611.gitgitgadget@gmail.com> <fffdb9944fc2672ccb7eac776cdd18855a1f99dc.1592951611.git.gitgitgadget@gmail.com> <xmqqzh8s7838.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:3WWpCJnjf7iS6E6+KY/o0A2QQDKXGAcMavGBJS3JCVXAvhJjEbf
 x0MrHnq5weINUdOOIqz9k0hGrmsSRmvDJmO/RZWtBVy/eE2yKV/ZnkV3wPJsazcdgUG6Nof
 uXMOgg17KRsB52nNKT8O0OV3rWzgFghlfeIBNl5VvjUQSYhpnhhW0/Hc0nfNyrJ8zu1FO95
 DeiQMMJH/V5RnWzPZs9Fw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mo9kR/+su8Y=:Xz6eW1NR1x0lXWLOIwbc/I
 XoA6MY5567+I6BOgzdc10PP9Ysb2uG4pnrF6p4gGGO6NHBjBZahzaFNu0Yjg3QmC6mbqLCYUx
 A8elafEKR/Yzs5ED/S8GZkmgnVFokqov6Ar2oeQoB1PNv9cpk/JyAvnknhwwWjj2njfyednV0
 HtExiQBk8BjawJXT9lgOoeapDJv52zCTkwQNpoxAqH/DMreQnTj8zaU6wMa9bm5Knxoazur0T
 J1U1Q01CY8fC8yDtCKuvwaT4SEjlBe2KJuqcSZqzTDC40PWXMZxSM+lMOpRXaETU+jZdrbcy9
 iyK01Pg24sO/DuB9bLwYJ8HneBAYhp5n6o5+SfuW8bSm7zrPSHyG1WkhtKjAeB+xsKFo+2iR4
 ogQk9heJN4w3gZVc5EYlZaqlwnSmG6iXfVyXyGtpJYKl3HK4xTsFH/BCa8BzHx5PURYda+X5y
 Wdx8aEsu5whSvkGuvhI1uHo/0WQ+ko+HrWdzJYehXHP/ySrHj1i/bF/SgovkD4L74Pq4hcWI5
 Wr7BTr1G/wla+u7U7TumHmi4xYgA8VFNg1F+NqlQuHf+6kvv+AHaR3U1gKZSyEb5/KxFs2Ihu
 aikT7FdJDBgieCC8XNQmw52H7A4k59/btd5tQ99tVa//JraGY6sKShvS+KGNmJJlE/dC+UEac
 OwZ2Zo7t9Nw/ToDrw5g/dLTkWpyZGoJ6O+3cyBBOa19xNuEn4toBExNNqJyUdmIDl+X21jZmV
 +EO88o0TCZzqSMCY0l41OJ2wuFavOc+webAKsNCUDwGosHnXS6okegVDNlLNGN72aHkPvVz48
 kbjyZ2UduoEQyLkJfeWk3zGaR3xquUp3RDIaTA9Ekz0tbqXHwDZbZbJ91FSWd+A69xKju/JAE
 8wEFI9mV6uzgPsDuvHENYynRjxICrbe12C2AOTCxm+3brYsNVsnoS+6FogLqal9EY7AOHGpqI
 pKKkEzF+AxvSfS4e2A5gw5j4J58oPuQ3B4Irsbve2x4z1SP2B4fi0jg/b3/omFzh58rQaEfYU
 xSOKSi0j1TtJCMz57zMSuaIcx0p+FPHI9fz6+LDrgeam7hfGXSiD5LXH07wSjayp8ANBYTeoe
 wTMXnViYmQc5aBlYt6biAs5Xo1d9lUH40ufCVIKeYzZKb7bDLwIURvHLCgfTOQ2o5EMNhyVp1
 e3AlJy1xXkdUkcn1oSlF8OoP7IUhdybvP5/e1nuyuH8IbyrvlctzRPFrFbybBzHrx7MKCMhC+
 3CANf03jFXZZgyUCX
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 24 Jun 2020, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > In the context of many projects renaming their primary branch names aw=
ay
> > from `master`, Git wants to stop treating the `master` branch speciall=
y.
> >
> > Let's start with `git fmt-merge-msg`.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  fmt-merge-msg.c                               |  5 +-
> >  t/t1507-rev-parse-upstream.sh                 |  2 +-
> >  t/t4013-diff-various.sh                       |  4 +-
> >  t/t4013/diff.log_--decorate=3Dfull_--all        |  2 +-
> >  t/t4013/diff.log_--decorate_--all             |  2 +-
> >  ...--patch-with-stat_--summary_master_--_dir_ |  2 +-
> >  t/t4013/diff.log_--patch-with-stat_master     |  2 +-
> >  .../diff.log_--patch-with-stat_master_--_dir_ |  2 +-
> >  ...ot_--cc_--patch-with-stat_--summary_master |  2 +-
> >  ..._--root_--patch-with-stat_--summary_master |  2 +-
> >  .../diff.log_--root_--patch-with-stat_master  |  2 +-
> >  ...root_-c_--patch-with-stat_--summary_master |  2 +-
> >  t/t4013/diff.log_--root_-p_master             |  2 +-
> >  t/t4013/diff.log_--root_master                |  2 +-
> >  t/t4013/diff.log_-m_-p_--first-parent_master  |  2 +-
> >  t/t4013/diff.log_-m_-p_master                 |  4 +-
> >  t/t4013/diff.log_-p_--first-parent_master     |  2 +-
> >  t/t4013/diff.log_-p_master                    |  2 +-
> >  t/t4013/diff.log_master                       |  2 +-
> >  t/t4013/diff.show_--first-parent_master       |  2 +-
> >  t/t4013/diff.show_-c_master                   |  2 +-
> >  t/t4013/diff.show_-m_master                   |  4 +-
> >  t/t4013/diff.show_master                      |  2 +-
> >  ...ot_--cc_--patch-with-stat_--summary_master |  2 +-
> >  ...root_-c_--patch-with-stat_--summary_master |  2 +-
> >  t/t4202-log.sh                                | 72 +++++++++---------=
-
> >  t/t6200-fmt-merge-msg.sh                      | 36 +++++-----
> >  t/t7600-merge.sh                              | 14 ++--
> >  t/t7608-merge-messages.sh                     | 10 +--
> >  29 files changed, 94 insertions(+), 97 deletions(-)
>
> This must have been tedious as the tests with merge commits are all
> over the place (I know updating t4013 would not have been too much
> of the work as it has its own self-update knob, but it still is a
> lot of work to verify that the changes make sense).

I missed the self-update knob, but in any case, I would not have used it,
anyway, to make sure that I do look closely at all the sites.

Ciao,
Dscho
