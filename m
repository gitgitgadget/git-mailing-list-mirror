Return-Path: <SRS0=lPKc=7W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8870C433DF
	for <git@archiver.kernel.org>; Tue,  9 Jun 2020 11:18:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A041207ED
	for <git@archiver.kernel.org>; Tue,  9 Jun 2020 11:18:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="an1FwYjb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728961AbgFILSy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Jun 2020 07:18:54 -0400
Received: from mout.gmx.net ([212.227.17.21]:44063 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728967AbgFILSr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Jun 2020 07:18:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1591701525;
        bh=CUrgxd/b0ACWaEOcX+HlrDXEfDsqmgGwn94KLKduLw0=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=an1FwYjbfK2pWUG0KLLiFhDJLPn43MiWjYPhEE1TDjDH3vcN0KwPzjQKE/IJFky+u
         tYaqNCwDJBHrsirp3w6JFslBbSp5hl+lzw4N6W5pb8HrvoP9aCCMrWqzj8CiwRD7YG
         7a893eAnZJV3laHGlxlph9iojbFPGxhHQuTmri/c=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.24.170] ([213.196.212.25]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N2V0B-1iwXuM1jTz-013v7G; Tue, 09
 Jun 2020 13:18:45 +0200
Date:   Tue, 9 Jun 2020 08:12:02 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-QA14EDB.localdomain
To:     Steven Penny <svnpenn@gmail.com>
cc:     git@vger.kernel.org
Subject: Re: Change Native Windows shell
In-Reply-To: <CAAXzdLVmuONmow6cB-kko8-CkP2sA=UfpPBkiXqSCuTacGsFWA@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2006090811000.482@ZVAVAG-DN14RQO.ybpnyqbznva>
References: <CAAXzdLXt4+-34+OhS=Jn=-VeORN3Y2jMzzg9+bhyn88aN4hm0A@mail.gmail.com> <20200605000039.GB6569@camp.crustytoothpaste.net> <CAAXzdLVk3jLzuB2vgKGObQDjPydpdiawKJJ+-NMa376Gu1zt1A@mail.gmail.com> <nycvar.QRO.7.76.6.2006081935530.482@ZVAVAG-DN14RQO.ybpnyqbznva>
 <CAAXzdLVmuONmow6cB-kko8-CkP2sA=UfpPBkiXqSCuTacGsFWA@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:AgzgqwmM+gqOkdkpb+/30pKivVJJK1gKV0CqCAMEliKUD8o+suj
 pkJ6b7Vm+yl9lW04meiM6c3cS2tS/QJ5pQkjGDlAtb2S26AZy4gTinw/jtORGP6s2Jd4fLm
 tNmH0t3GU1bKC+pF9OH/sCBxUVhqQru6wv4nxK3AagGSgdYaMqtZ+VgHIQLYpzTynrpSyIy
 ZeUhxYE1DxVC1n9Lr8enw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:fAWixVr5svE=:fR0HqjZdFGTejOrBElW+ln
 cdsP28zZZM1ICy7njyjJ6YkWtUj6LeQqNYjYw1pndCf4kOVkgShY+PiPxna4fPnCqb3V8Di5z
 9RbxFNW1hBSvyHqBovSlr6gq5GVyQ1JeJ1ByfZ5eX/8DtNK9buTSbYkmE8OJml8ybFBVOi+Co
 7DurE09g2yroNeDPH5AmZzWV9dGqfjvwL7HqCwi0b/TgKh1Ov6Ij5qjbt99lbfJ/vgBSMzXNX
 D5Il8hdzu5KwHcPffr0355FvkUfHA+JQIP3B3jegLyS/qhpFRCqoHraoPhrtJPNDaLnwRR2OL
 07AKopKhsKt2juZy6HNeJNjZ3lgbQwbMDREGFg4r1ZksKP5Mxk5Xi2I5/xKT3XZ7Mmudtvcg9
 Y2/HWIzdgbrPzbHPMjg6tXX8lY4Tb1VJ3Xx2m+U5ra+VE2EHvlEv0pInI5kLfAzwYXgd7jhoh
 8fyuxW0XY/yetycsKsqkxQHa4oDROi7jdzrSyC2dNgVaU1aFGpRxw+tQHX//hFRA5JhR9kJ0F
 Ks3vPMANlSFrnJjuLEU1W7GwoIPDohiG7UWPvkY/ub27VlzWjnlbaGKen2NqOJ62ieeNm2qTd
 VDITm0xAqe2CsOBks/Ulm/VPje7b/BHPj1Yoe7m4Llz0vDBFgV96mtwYte5lGijKYrh5k76qt
 Af4QFpJQ0wkyVbfrmcKv8XKDj2DAobihbU0TArkylLX4XYjv87P56P+tZthhlJJalA5zL5PRe
 9tZX6T7bGYFz4zcCsPgDC2sSOiqpSm8Dn3u/+ZwmlnTELw7UfTtNfseqGJhjB5/NEHxhUqyzg
 RZQOrh0aj4tJTP9m3mfkHKsBSNQv41tE5dGYTUn+sJG5Doztsqrfv6qNHqw6uLg217Te+X8t5
 CNPCm9CUz0XjtLc/ug0j2np6U9RY9t6vAONiqm0oCc55GqWFHV6KauooTyqAMK6vRIjGxOzuC
 1C29/2ZntyB05qpm0X1IJvIxSK4sPuRL2FWBDFpm2NGgIfSKRiMgKmysu5Is3sszccXgFLkzx
 QCy7y1E+jEzULKAW2xopv5ynIp7M82/hRNJWJEI9jsxI1DKNhqMx3oNh2AEHcaQSaPhmCNNe+
 60MtpxEIIfJFXoRK+HPbEfN61pledG9KI3Xepqb0sThLQreooNXeYkzIJlIfZAm3n9OO/qoj4
 RGxsa/R0vIVcWZyaZRHkuTQZ6VpoGYiHFIypQJXCJz2fccX540XNfZqOiMKBh5/OFO/gv0Fbe
 H5GJzsb9p8GY2vbOx
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Steven,

On Mon, 8 Jun 2020, Steven Penny wrote:

> On Mon, Jun 8, 2020 at 5:46 PM Johannes Schindelin wrote:
> > That assumes that PowerShell is installed, which is not guaranteed,
> > either.
> >
> > Besides, quoting rules are most likely different with PowerShell than =
what
> > Git assumes, so you will have to take care of that, too.
> >
> > Finally, there are plenty of tips out there in the internet that simpl=
y
> > expect a POSIX shell to execute those script snippets. Any user would =
be
> > completely (and unnnecessarily) puzzled if those snippets won't work w=
ith
> > their Git for Windows.
> >
> > In short: it would be unwise for me to accept this change into Git for
> > Windows, at least as-is.
>
> I found a workaround. It seems as long as PAGER or similar is not get, t=
hen
> Git just tries to call `less.exe`. I didnt realize when I first posted t=
his,
> but native Windows Less is available:
>
> https://github.com/jftuga/less-Windows/releases
>
> So I am just bundling that with my Windows native Git:
>
> https://github.com/nu8/gulf/releases

What is your plan to address concerns of users trying to run popular
hooks? Those example hooks, and recommended hooks, that you can find e.g.
on StackOverflow are all POSIX shell scripts.

Ciao,
Johannes
