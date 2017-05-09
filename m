Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF2541FDEA
	for <e@80x24.org>; Tue,  9 May 2017 13:39:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753858AbdEINjw (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 May 2017 09:39:52 -0400
Received: from mout.gmx.net ([212.227.15.18]:49664 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753576AbdEINjw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 May 2017 09:39:52 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lcjgd-1drLgB0brz-00k4wu; Tue, 09
 May 2017 15:39:32 +0200
Date:   Tue, 9 May 2017 15:39:30 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 12/25] split_commit_in_progress(): fix memory leak
In-Reply-To: <49fad7f1-0bad-dbd2-89ff-5476f9b5bf91@web.de>
Message-ID: <alpine.DEB.2.21.1.1705091536120.146734@virtualbox>
References: <cover.1493387231.git.johannes.schindelin@gmx.de> <cover.1493740497.git.johannes.schindelin@gmx.de> <8cc59c706934134294e91a99062f7dcc0bda17db.1493740497.git.johannes.schindelin@gmx.de> <8a0a2230-239e-b6c8-f7c0-8192e6cec7ec@web.de>
 <alpine.DEB.2.21.1.1705041231270.4905@virtualbox> <49fad7f1-0bad-dbd2-89ff-5476f9b5bf91@web.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1336982809-1494337172=:146734"
X-Provags-ID: V03:K0:Sb12p4IXw6c98Srd9sGBK+9TESCQav5XkMKy86GbLCRG75Os4HL
 w8fv6WY77Dy6pTzISSdSxKjDafjc6ZI2QWxNbc/Ss0RMQDjcMbfBx4YkRc6x2436Iptx7fM
 GAzZudsx9SPKhGgszjyy1iJmKFPF+XvctZI2cDogpoF/IOYQRlmwcYSabOpCPisAK4Ing1v
 FI254KTt16dNYG+Aej+Yw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:+Y1sWFRtun4=:Li8RA61JL76YV8gYGCjt1g
 Pj3cU1HphvjuJnTa26IN1Hgic5LoWNdtA/MHuygK1BcSejlQye664/ykMn2VitszlgcDQLfUj
 jNbHejz27Eye+7Wh24ACNLKN2M7XSjFMjeFfd6Xfm84lRGAVU72gQpT3Ejv1vqFgHvNqp5Ygb
 rcxlqy7FJRlPB+QD3LTYcj720UfQc+PUInAduNxWDR2fFXIKvJP+UDMXCXm8rzNlR5tKIgjtc
 AiD2GIA7804dTZOSiJfGI2fB/WSia7+CZWyokbK/F1T8Bg24+POYqvRLc6JN3cERgxxZfc5mY
 sjB9BS5p8EuB69gUVOO+wFeKfPi7xrEaTeD9mzk8gec68EFtprBNXVEHqJWgahqpPv7UDGD1Z
 GPC6ifSX+AeXqwmVxkXTxYN4uBm9jHjIPScYQHL6vZLWTMUTLOeVUiZooK/OgGGbC+q3B7pF5
 dz1Bp683Lncx8mQrkJmZdf470sqqo0W6+z6JJaF+2RVfiuWo8NYB99XEQPUhQ7uMuIEWEgL82
 YZOaNPCTB/Xhy5t6ptDzVHGSsZON5hGMDV1/nbAsqJespqyeZ2hAolvenBsJijJQqiPIySDje
 9LMetQPlvxt6eo3b679mIe00nIdNusFcM/B7tQsWjZWtX089Ac2AyTqyzvjJQIg545mztrUa0
 LXDZQulaHxRIBA57aIj/ITkPRwbD5YBC+SatnpagJM4URwch7u4o+h4igJIT9+A9NG233q3eQ
 ImNgEQK3baZkuEPK83YjKjIa9YIHhSFabJmX2a9+BxG0lYz1DL1IG0REiJ6JiUEvW3f98PLm8
 0Xne9kp
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1336982809-1494337172=:146734
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Ren=C3=A9,

On Sat, 6 May 2017, Ren=C3=A9 Scharfe wrote:

> Am 04.05.2017 um 12:59 schrieb Johannes Schindelin:
>
> > diff --git a/wt-status.c b/wt-status.c
> > index 1f3f6bcb980..117ac8cfb01 100644
> > --- a/wt-status.c
> > +++ b/wt-status.c
> > @@ -1082,34 +1082,29 @@ static char *read_line_from_git_path(const char
> > *filename)
> >   static int split_commit_in_progress(struct wt_status *s)
> >   {
> >   =09int split_in_progress =3D 0;
> > -=09char *head =3D read_line_from_git_path("HEAD");
> > -=09char *orig_head =3D read_line_from_git_path("ORIG_HEAD");
> > -=09char *rebase_amend =3D read_line_from_git_path("rebase-merge/amend"=
);
> > -=09char *rebase_orig_head =3D read_line_from_git_path("rebase-merge/or=
ig-head");
> > -
> > -=09if (!head || !orig_head || !rebase_amend || !rebase_orig_head ||
> > -=09    !s->branch || strcmp(s->branch, "HEAD")) {
> > -=09=09free(head);
> > -=09=09free(orig_head);
> > -=09=09free(rebase_amend);
> > -=09=09free(rebase_orig_head);
> > -=09=09return split_in_progress;
> > -=09}
> > -
> > -=09if (!strcmp(rebase_amend, rebase_orig_head)) {
> > -=09=09if (strcmp(head, rebase_amend))
> > -=09=09=09split_in_progress =3D 1;
> > -=09} else if (strcmp(orig_head, rebase_orig_head)) {
> > -=09=09split_in_progress =3D 1;
> > -=09}
> > +=09char *head, *orig_head, *rebase_amend, *rebase_orig_head;
> > +
> > +=09if ((!s->amend && !s->nowarn && !s->workdir_dirty) ||
> > +=09    !s->branch || strcmp(s->branch, "HEAD"))
> > +=09=09return 0;
> >   -=09if (!s->amend && !s->nowarn && !s->workdir_dirty)
> > -=09=09split_in_progress =3D 0;
> > +=09head =3D read_line_from_git_path("HEAD");
> > +=09orig_head =3D read_line_from_git_path("ORIG_HEAD");
> > +=09rebase_amend =3D read_line_from_git_path("rebase-merge/amend");
> > +=09rebase_orig_head =3D read_line_from_git_path("rebase-merge/orig-hea=
d");
>=20
> Further improvement idea (for a later series): Use rebase_path_amend()
> and rebase_path_orig_head() somehow, to build each path only once.
>=20
> Accessing the files HEAD and ORIG_HEAD directly seems odd.
>=20
> The second part of the function should probably be moved to sequencer.c.

Sure. On all four accounts.

> > +
> > +=09if (!head || !orig_head || !rebase_amend || !rebase_orig_head)
> > +=09=09; /* fall through, no split in progress */
>=20
> You could set split_in_progress to zero here.  Would save a comment
> without losing readability.

But that would confuse e.g. myself, 6 months down the road: why assign
that variable when it already has been assigned? (And we have to assign it
because there is still a code path entering none of these if/else if's
arms).

> > +=09else if (!strcmp(rebase_amend, rebase_orig_head))
> > +=09=09split_in_progress =3D !!strcmp(head, rebase_amend);
> > +=09else if (strcmp(orig_head, rebase_orig_head))
> > +=09=09split_in_progress =3D 1;
> >  =20
> >    free(head);
> >    free(orig_head);
> >    free(rebase_amend);
> >    free(rebase_orig_head);
> > +
>=20
> Isn't the patch big enough already without rearranging the else blocks
> and adding that blank line? :)

The else blocks are not really rearranged; apart from the early return,
the rest of the logic has been painstakingly kept in the same order.

Ciao,
Dscho
--8323329-1336982809-1494337172=:146734--
