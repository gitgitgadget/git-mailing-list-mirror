Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1DFE31FADF
	for <e@80x24.org>; Mon,  8 Jan 2018 20:45:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756481AbeAHUpn (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Jan 2018 15:45:43 -0500
Received: from mout.gmx.net ([212.227.15.15]:58554 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756465AbeAHUpm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jan 2018 15:45:42 -0500
Received: from [192.168.0.129] ([37.201.193.20]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MNZ9u-1eVsLI0NFS-007Gm0; Mon, 08
 Jan 2018 21:45:38 +0100
Date:   Mon, 8 Jan 2018 21:45:37 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] bisect: avoid NULL pointer dereference
In-Reply-To: <07a8cdae-8f8c-8560-c450-c6089a942c96@web.de>
Message-ID: <nycvar.QRO.7.76.6.1801082145140.31@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <07a8cdae-8f8c-8560-c450-c6089a942c96@web.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1391129291-1515444338=:31"
X-Provags-ID: V03:K0:2PVgZYsQLE8CZHYeaqYokGyu43S+lnzNJsA1mNAiI834Bar5WIw
 q8JXBocERwHQwoak8RVViGzlPmIVzHYZcV9R4T2iPeNiPnqAKg/ocoGDUlWIN0lgjhaBfyS
 oLNlgP8iXA/zCy4fq7S5f2OVt8491gxqiB/FvIC1PJd1uWAKaquGOM0XC/LHfTM7IgfSQkY
 J7bMWf+M41EA0lc74p22A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Y6i17jxRbrQ=:czyf//J3b4qLTsZkb1TZ30
 rJOMDg6DCB4v912iHDYntOX8/IiOy/rSqZN4CVpyVJA5O5DUERJWn9+t3RMvx8N9ZouK+ZzM+
 tGbKomltDsBA9INQ95K3DbbRaJHiwgYUzrRi9x/i3wJlsfntSaGvP5s9fV6XpwpRw8gXiKxtG
 gV8xeWq3voG/ZlAxqh2FmURd/OL/2YKiV9rgc5obenr2VYqHbY67dQldkBz5A+ObrcT4w51Y8
 hRhkKZQpBSkXExG5ZWSuEctV9ZnOkj7vzY0UE5cWFPSo5KdjOhwahOz/h80Ws9zJ4qkLDPhWS
 R/+v80qmqLSatVxiX/Z15NpY5pg13xmf6dfM0H4X+oECA9rz0SRtl+UzbC4FRqmcqxP1IcGQz
 S+C7oKnJ9N8nEbdyY164qUGVi1Bd/hUvmc6TkxWh0uxUumJEA1gpCdoTMPt26Xwa3daCcz/Jv
 UrmzDf7LMQ1DP7wgl7OlXTkL83vPCIfVt1pgIYMRr0zrRGdJWcy24beqtZdSv2DrOBDf/SYtr
 Of5w/qiT+sEjG18AMtZ+NqziZBr8VXlKLpBso1aQoV/hawqgypatfx9p055m6BEAOf9uhJezX
 X2feXpHz5A3zH/QZcnb5aBkn3VWLi4wHEtzpcgAWW+lXGMg2ig6jupjwFc2CmHiHHmm+GRIrV
 BxlGiIBLczf7DiTiqOp7Wt2MKjlD6N8isKwgkKbZo63DhomnMoKJCnsdo602BH+tUy15mTVzF
 PtMN6x/J6e7x3KvCX/JknXPdaYE9IppKaXDgqji4WXrxa8OTsiXgpfAJN8NR8dmTXOi1dvTbO
 raQdUsfl7kPR6CVH1Xub3Paqp5IooaFaZtBxwSS/teu8w7pZo55iP3MDMhiRoWUarYb8YM0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1391129291-1515444338=:31
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Ren=C3=A9,

On Mon, 8 Jan 2018, Ren=C3=A9 Scharfe wrote:

> 7c117184d7 (bisect: fix off-by-one error in `best_bisection_sorted()`)
> fixed an off-by-one error, plugged a memory leak and removed a NULL
> check.  However, the pointer p *is* actually NULL if an empty list is
> passed to the function.  Let's add the check back for safety.  Bisecting
> nothing doesn't make too much sense, but that's no excuse for crashing.
>=20
> Found with GCC's -Wnull-dereference.
>=20
> Signed-off-by: Rene Scharfe <l.s.r@web.de>
> ---
>  bisect.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/bisect.c b/bisect.c
> index 0fca17c02b..2f3008b078 100644
> --- a/bisect.c
> +++ b/bisect.c
> @@ -229,8 +229,10 @@ static struct commit_list *best_bisection_sorted(str=
uct commit_list *list, int n
>  =09=09if (i < cnt - 1)
>  =09=09=09p =3D p->next;
>  =09}
> -=09free_commit_list(p->next);
> -=09p->next =3D NULL;
> +=09if (p) {
> +=09=09free_commit_list(p->next);
> +=09=09p->next =3D NULL;
> +=09}
>  =09strbuf_release(&buf);
>  =09free(array);
>  =09return list;

Isn't this identical to
https://public-inbox.org/git/20180103184852.27271-1-avarab@gmail.com/ ?

Ciao,
Dscho
--8323329-1391129291-1515444338=:31--
