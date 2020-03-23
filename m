Return-Path: <SRS0=3T2S=5I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23CE8C43331
	for <git@archiver.kernel.org>; Mon, 23 Mar 2020 21:05:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA492206C3
	for <git@archiver.kernel.org>; Mon, 23 Mar 2020 21:05:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="IRR69FqJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbgCWVFb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Mar 2020 17:05:31 -0400
Received: from mout.gmx.net ([212.227.17.22]:45041 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726145AbgCWVFa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Mar 2020 17:05:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1584997529;
        bh=k3q1CoiCud/PheYNTqABP6mEm8I5Kq0Zzt+eIP8E3Gs=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=IRR69FqJzgmvFzrzoUK1FTskHoziX1h0IZ1JCoYKS4yxG77QKfkrdKYcAW7mx02+g
         a/kvDcCRGyj33MpHh4hcdKqptEL0b8gGwFGKDrP2BrNCG/PFcT5FJqfgx4doG5dg3y
         BL/lA1EvMrwddzCsifogT8I7ZNDqrEUMcw3kEkS8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from MININT-QA14EDB.fritz.box ([89.1.215.97]) by mail.gmx.com
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1N79yG-1jJyp22Aeq-017Z1F; Mon, 23 Mar 2020 22:05:29 +0100
Date:   Mon, 23 Mar 2020 22:05:28 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] import-tars: ignore the global PAX header
In-Reply-To: <fce519db-5ad4-270f-abcf-0e26549486cb@web.de>
Message-ID: <nycvar.QRO.7.76.6.2003232158160.46@tvgsbejvaqbjf.bet>
References: <pull.577.git.1584968924555.gitgitgadget@gmail.com> <fce519db-5ad4-270f-abcf-0e26549486cb@web.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1237582995-1584997530=:46"
X-Provags-ID: V03:K1:goxwlvzLQ+LvT+Msel4SC69ZsxXjLB/SxJ93GfvNoxJE/hTjskW
 hM0wVEfN3Fq1VidyyFjYbRzPldPmDXGurUnhPN1kjKhnxqqktC3VfqJszFcPMNjsX32NJ3V
 3qQPsStwDQS1xVT6VpEJaOxA7tWNtowHVAzVrYqV5ybEAbaP9TbUAAEjrUVro9Jz7IDS8JB
 uBb2QnFckmBjgw5mx10Uw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:c9ezBFhUX6w=:UuZ67neNomN6HENzQhdtAT
 GW2dxN4mRdHwjbNyt9jKI03OEKttLDa6NBOw8N88B7MpxjlO648ymgAXwsAGq9USk7Kpx+wlw
 +nH0mNwLUSLHhfV/psTn2VltXitY/ko5jZOGHJyxZ8B/KsbxyYoTzplPmArtymn5bbk99L5na
 c6i0Xxooz4XH7ttQ0REC+x5ukESKRTV+VQdJsYdTnMQiNOT6s4/O2VK+IXW2yCS+d1e5kwC9/
 HuALSTJjnS0ne1/hZYKsbW0Epaxa4mzs9QErvBfjC0ZDDEdFUTThBxDwIwiommwi8WGOrK0P9
 jr9dc0tUz8/gLuisFMkWHfPFUbmOdeXGhCuDuNjXlJ94+fQ2vheYEp013hHP7YLXww2iOEIl7
 6MUoqlMGJWayqSrrvnN9U83skjT/hTMSvrNFYE+iKmDv5mTAzK1ngwh2OlSEHIMBnu+rsDCWL
 exQSnPN/OUT7gml3VOaJWa9ao59HT3+aJimcNp+bGcDui4nXMx5CCwMB+ufGUAdL9tag+RnY0
 WQ03SOuGZ0Rtu18AOsINu1O6YTRcS2YQsG2jGE9TmbbKlLsKDuTm/eBKkm1TzCz8WgpV9G0K1
 FCXee2ueXG2QWN7I3/+H5mBCWrtl6ZSzkv+ssEx40/sU427bHfyyIlkgU+34RJ4D8oqztVbrM
 OJ9yPwrIDjrIO+7MpfPEwa2qeBPTSTpmyfQYMyDufje4oPBWeB1fOj4We+V5uB4cZRzalHzF4
 rEjxz7tlQ5NXWuNCJTVh5/3a8h/3j1PtTI+PwoNYhYWzIlX4uNmBwZG9751GL0+AgoEFsp7F5
 x1nNhkuEm/pmLktbH4fI2zT9p4+AUrqSWd37xFOPSnyndstvd7VQeTxgptacucfzq/WTdwsZZ
 t5Ma6njszHQ++m71NOJEelROIHmp21ZRxQumCRAAF4yS4zEeGfDL4T5sC9O405rXqt8+/Rv6e
 IfL44nFh4pPJWAf7tIh9B6enSW826CYQQRwWgoB8pc9BcbYwK7+3L+ImY4DudCYuTz0B3MYt3
 g27lJP3C87p/Y95GqYdD//YJzmHAlQikDT9/HKhpqAGDTTwmc9yKwAZl+VgJZcHnVdp8tw/0F
 6pustRak4VbAadSMbb2Kj9bBEG1l0feRoZWY9LXipi1AG8n1RgGZAFV+VhRXB49DGmHeq+R0M
 LY6q5S9Q5VevmGXm6qm9v9EIzA0c983YmbFVEM1XllkQdOzRfSVYj3TQFwP5cniXnmbKJBbWn
 zjUOB6f/BAlDFDibQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1237582995-1584997530=:46
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Ren=C3=A9,

On Mon, 23 Mar 2020, Ren=C3=A9 Scharfe wrote:

> Am 23.03.20 um 14:08 schrieb Johannes Schindelin via GitGitGadget:
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > Git's own `git archive` inserts that header, but it often gets into th=
e
> > way of `import-tars.perl` e.g. when a prefix was specified (for exampl=
e
> > via `--prefix=3Dmy-project-1.0.0/`, or when downloading a `.tar.gz` fr=
om
> > GitHub releases): this prefix _should_ be stripped.
> >
> > Let's just skip it.
>
> git archive uses a global pax header to pass the ID of the archived
> commit as a comment, and for mtime values after 2242-03-16.  Ignoring it
> in a simple importer seems reasonable for now, but I don't understand
> how this relates to prefixes.

The tar importer in `contrib/fast-import/import-tars.perl` has a very
convenient feature that I took for public knowledge: if _all_ paths stored
in the imported `.tar` start with a common prefix, e.g.
`my-project-1.0.0/` as indicated in the commit message (or `git-2.26.0/`
in the tar at https://github.com/git/git/archive/v2.26.0.tar.gz), then
this prefix is stripped.

This feature makes a ton of sense because it is relatively common to
import two or more revisions of the same project into Git, and obviously
we don't want all files to live in a tree whose name changes from revision
to revision.

Now, the problem with that feature is that it breaks down if there is a
`pax_global_header` "file" located outside of said prefix.

> Is it because the header is treated as a regular file with the full path
> "pax_global_header" (independently from any prefix for actual files) and
> can thus be placed outside the expected destination directory?

Exactly.

Thanks,
Dscho

>
> Thanks,
> Ren=C3=A9
>
>

--8323328-1237582995-1584997530=:46--
