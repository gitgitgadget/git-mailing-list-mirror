Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E6E381FDEA
	for <e@80x24.org>; Tue,  9 May 2017 13:42:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752986AbdEINma (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 May 2017 09:42:30 -0400
Received: from mout.gmx.net ([212.227.17.21]:52157 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752576AbdEINm3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 May 2017 09:42:29 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MA9FV-1dIqtm1NSD-00BJhv; Tue, 09
 May 2017 15:42:19 +0200
Date:   Tue, 9 May 2017 15:42:17 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, git@vger.kernel.org,
        Stefan Beller <sbeller@google.com>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v4 11/25] checkout: fix memory leak
In-Reply-To: <xmqqk25sch89.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.21.1.1705091540130.146734@virtualbox>
References: <cover.1493740497.git.johannes.schindelin@gmx.de>        <cover.1493906084.git.johannes.schindelin@gmx.de>        <2704e145927c851c4163a68cfdfd5ada48fff21d.1493906085.git.johannes.schindelin@gmx.de>        <36a581f6-077e-ca89-49d0-ad487ff222a3@web.de>
 <xmqqk25sch89.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-2142021902-1494337339=:146734"
X-Provags-ID: V03:K0:FWthnxCG4GujNvL6GgHyu30h6OsYoR+8rclRwcwO86AOb+q54wF
 M48wQCgT6KDCH5HZDQdhZCdFueVgYB5d07layLIpqkIRv60fTMxruTfgJu6AEONB9h/JpYm
 mAEARhnvsbjB/JTMfdbP+ABgnQRpvRRZId+zPjieE2s1wJjb3rVLvgspXrwo/ldkSiB7w7p
 qyOyHc899KbP7USE1xhew==
X-UI-Out-Filterresults: notjunk:1;V01:K0:2FXZtbIn0AQ=:1AZOja8sce7IpoKoGqg9Zc
 pDLa/gRVJOvNF+ie/1KTkRM+yp7IspzvJ8TSKFJOQAZUIa+AHIvfMydAWQkzENWp4aK6QVtTK
 8Kei0/HpOxxZfQ3g7ylV3mtgi6ISKUH/kBQGWFFOe/UkCSG+Vbj1vv+QXRuIQ/oBdIGjbD1/q
 B7YiXaz5Fx+L1UGA1iFRmab8u6sHoBz6gUaqdUFEqDAgSzj+8Ry4mf4azKltQbpDfSBQIIgxP
 l3KH1JyNngXZIT/eWw6SAq190CfKX3p7gBVi2yE1y/DkYG8ITLnoTb1s27b7TI3KDxX4N8tlf
 ce/7eBeT8nhYg80UHFwQ+RJMXrwDuMNeVa2CPo5ZWCRS/GAsv6z8k+3YqEhYHdwXvmtx6S54V
 bLRVU5PSY8w+ikNdsjOu8XxJv8wWXEZyhIZxJY1Dok63qKFTjnaVfzajg+mFupRV4UcvcSt+V
 ZHxdAoV8SiHxvzLt/0cYWrUd94UhMFRrItrGeELWlrWQPSh36iPGzXPumgiwPZ5g7igxtTjt8
 jduPb49omBw/hAdsVJfiELTVxKu3ptvJSSUwwVt7ZQegZbQhYbb7v9/pwaA9a/UiYyS9IOpKG
 Jh8+DbsBx9zZUrZkTanr+VOzPGjv9C1zwRf0M1fplVgleTjA9zQ/Zv8Hn3M3/gFN75VO09T3P
 xA+x6905QgQm5dbz/OdO///e10D0yy2JvIMJXTIOfahFbrrFopRtdDQ9yz/tYTNrAMA9+bR1a
 T0ULtJ0mlC3SSkCpuQM0xfG0enN2vwIuuBaWlLBHIdwWwr2D7Q+WXIbJuCgl0E4xLNUPl8tQE
 CmJcSOv
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-2142021902-1494337339=:146734
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Junio & Ren=C3=A9,

On Mon, 8 May 2017, Junio C Hamano wrote:

> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>=20
> >>   =09/*
> >>   =09 * NEEDSWORK:
> >>   =09 * There is absolutely no reason to write this as a blob object
> >> -=09 * and create a phony cache entry just to leak.  This hack is
> >> -=09 * primarily to get to the write_entry() machinery that massages
> >> -=09 * the contents to work-tree format and writes out which only
> >> -=09 * allows it for a cache entry.  The code in write_entry() needs
> >> -=09 * to be refactored to allow us to feed a <buffer, size, mode>
> >> -=09 * instead of a cache entry.  Such a refactoring would help
> >> -=09 * merge_recursive as well (it also writes the merge result to the
> >> -=09 * object database even when it may contain conflicts).
> >> +=09 * and create a phony cache entry.  This hack is primarily to get
> >> +=09 * to the write_entry() machinery that massages the contents to
> >> +=09 * work-tree format and writes out which only allows it for a
> >> +=09 * cache entry.  The code in write_entry() needs to be refactored
> >> +=09 * to allow us to feed a <buffer, size, mode> instead of a cache
> >> +=09 * entry.  Such a refactoring would help merge_recursive as well
> >> +=09 * (it also writes the merge result to the object database even
> >> +=09 * when it may contain conflicts).
> >>   =09 */
> >>   =09if (write_sha1_file(result_buf.ptr, result_buf.size,
> >>   =09=09=09    blob_type, oid.hash))
> >
> > Random observation: Using pretend_sha1_file here would at least avoid
> > writing the blob.
>=20
> Yup, you should have told that to me back in Aug 2008 ;-) when I did
> 0cf8581e ("checkout -m: recreate merge when checking out of unmerged
> index", 2008-08-30); pretend_sha1_file() was available since early
> 2007, and there is no excuse that this codepath did not use it.

I hope y'all agree that this is outside the scope of my patch series...

> >> @@ -251,6 +251,7 @@ static int checkout_merged(int pos, const struct c=
heckout *state)
> >>   =09if (!ce)
> >>   =09=09die(_("make_cache_entry failed for path '%s'"), path);
> >>   =09status =3D checkout_entry(ce, state, NULL);
> >> +=09free(ce);
> >>   =09return status;
> >>   }
> >
> > I wonder if that's safe.  Why document a leak when it could have been
> > plugged this easily instead?
> >
> > A leak is better than a use after free, so
> > let's be extra careful here.  Would it leave the index inconsistent?  O=
r
> > perhaps freeing it has become safe in the meantime?
> >
> > @Junio: Do you remember the reason for the leaks in 0cf8581e330
> > (checkout -m: recreate merge when checking out of unmerged index).
>=20
> Yes.
>=20
> In the very old days it was not allowed to free(3) contents of
> active_cache[] and this was an old brain fart that came out of
> inertia.  We are manufacturing a brand new ce, only to feed it to
> checkout_entry() without even registering it to the active_cache[]
> array, and the ancient rule doesn't even apply to such a case.
>=20
> So I think it was safe to free(3) even back then.

So this patch is good, then?

> > And result_buf is still leaked here, right?
>=20
> Good spotting.  It typically would make a larger leak than a single
> ce, I would suppose ;-)

I saw you added this as a fixup! commit. If you don't mind, and if no
other changes are requested, would you mind rebase'ing this yourself?

Thanks,
Dscho
--8323329-2142021902-1494337339=:146734--
