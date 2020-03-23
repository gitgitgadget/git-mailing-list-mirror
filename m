Return-Path: <SRS0=3T2S=5I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9715C4332B
	for <git@archiver.kernel.org>; Mon, 23 Mar 2020 21:08:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9034206C3
	for <git@archiver.kernel.org>; Mon, 23 Mar 2020 21:08:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="g4oYOmkg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbgCWVIm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Mar 2020 17:08:42 -0400
Received: from mout.gmx.net ([212.227.17.22]:50563 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726177AbgCWVIm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Mar 2020 17:08:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1584997717;
        bh=G5MvceWIdvVGvADSZSj9ET2A0EmPfcfg11oWQlQwseA=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=g4oYOmkgLmUo4JY+mvKOxGAaNQfcMw+xoxd+kBRidZC3qPzB+rqHnsvZ878Sv4o+m
         BCqPmPxoDbz5nAdWClHAH5XY1yX2VTbYXJ4CoAe+g0CyothfNaxKVb49WEH/TqmayZ
         TiEUW7d1sqWa6AVjITSmdzswyFm5d3Rd9jmxAY+w=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from MININT-QA14EDB.fritz.box ([89.1.215.97]) by mail.gmx.com
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MN5if-1izmEr1huH-00IzxB; Mon, 23 Mar 2020 22:08:36 +0100
Date:   Mon, 23 Mar 2020 22:08:36 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] import-tars: ignore the global PAX header
In-Reply-To: <xmqqh7yf55q7.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2003232205580.46@tvgsbejvaqbjf.bet>
References: <pull.577.git.1584968924555.gitgitgadget@gmail.com>        <fce519db-5ad4-270f-abcf-0e26549486cb@web.de> <xmqqh7yf55q7.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-869457192-1584997718=:46"
X-Provags-ID: V03:K1:jm7uVrFL9XQfPtRJzuDJODmT5imHrdEdT3Q/KMOEFQA+RZWEmo/
 rgHC8wmpjq47mzqhEJ00i9RBwzgOcoiVbEAJH5FEggRhxB5QXeqsmC/p2hyOKbjB6VHdRWm
 XWqCYL3sNrNDgshpcLLAZt0gABdqEKKjLJow1e/1m1qLvxyXni5YH9I6SqN2U7kyTHnY5P6
 22nMOvFRmgkEKeMkjz17g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:osdmngeSNuI=:hTOFzYhR5PM7VRMVkIgPvx
 5Rm6XFlcCDkWdTI9EqVuy5zqgZFPsyn3miE6eg/OWPAIXQLEYiBpPnLLR62BH+TSch8BSVNDl
 zEyP9x0wWXsWz7jdzoHpML2XxV+7vgBkcE7L7CUXe9SYCG3+Lf7KrsnKXLhROs9KOzR8Oyj23
 Fv2Huwu3QcNtmfLusNyPAVT7NWKCc5NtLr57HJtv2/SivaYLpGiORbt6oXLzEanhsCMsJq/O1
 9hNzWETLJqwUcC3pDjQ/e6xhTtim4b7hon5aKyLaWHJdY9mpd6gDUr1j6sPw8dBMS+BDx45C8
 yax3EkbUXizszqiF3EevYITz2yzSeSGZckgjyToH4Zr8IAAq9nVklkPhJcL7tQAVl7VzA0qsB
 n6qvd2dWfhfvFo/12F9uCYL/viBSXoyTdb6X9gEdOOx+L4hEw+dRxXxd68AcjgzChgVh3D3iY
 obsFibsbwd2Qp7KlUUY8xegrSpRZamxYx6nfxKEVNdO9wv0jKSPiIHvEhTHUyQxLUqMhicEns
 5RBAX01hVIeWVEPe4ZhATkxS6bHRcgcliF+iKhZlfdomw06be4fpIhfz4hoK8f6DpsmcKjFVs
 UtcLopUfbI7k3pe2NhIO1dgY4570YCIWXmqlBjAMyUEDMqJADLkP69WoY/14bIVYgSQwJMgrX
 uyUbTyE/TChBvCkJfUso2AJrVyHV47uNEOMQV9XXe77PUZTQBRNKNuqu+T01X4UKadr3T+Er3
 YY1hBZiF8lA6XM+fdDHEbjAQivHxR+P2EVT+PDBOo9xvQGSqmMqoTXj4fePn4rw4tH0Pr+u+y
 YRELTnJJ0JPTSiqQARjCYM0Fl8j1w+WhVhgEYGEbFke+Z0bTIDXE7dz2bTVQQvcm8hVxC/t0t
 fBktIjtUrpuXnypswB4eH2J1qcZHXYvPud9vejByqgkXHzh/OGuT3LOj2p0i1XlFHm297zMMg
 pR3CjkjZ2H3B5ukOurRgAKRjhDmbyme+/0AvBGtj5hwUJDCWlZOjYepQlIfldx719c+LZvfjG
 YBzmkom6lzh0q/jch3UBX1CPflEYZAVVotAeR4iQvPBbnTgEccaZXwr6nq0KL+7W/Mv7rNtXi
 oRGBrEf60gd79KkQiZo8ewkZ3NJy6bmJyZrg62gNWNHF6yIE8tOWeO6mDw16g123Emqazq32n
 NXSQh1WWS5DaI6brSU9nT9EZn2t0NDw1eTMxNK5qcviHk/POT49TzpMUP3oSlByqKJxiwaQuH
 zkYObrxuVCLPGFwnT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-869457192-1584997718=:46
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Junio,

On Mon, 23 Mar 2020, Junio C Hamano wrote:

> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>
> > Am 23.03.20 um 14:08 schrieb Johannes Schindelin via GitGitGadget:
> >> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >>
> >> Git's own `git archive` inserts that header, but it often gets into t=
he
> >> way of `import-tars.perl` e.g. when a prefix was specified (for examp=
le
> >> via `--prefix=3Dmy-project-1.0.0/`, or when downloading a `.tar.gz` f=
rom
> >> GitHub releases): this prefix _should_ be stripped.
> >>
> >> Let's just skip it.
> >
> > git archive uses a global pax header to pass the ID of the archived
> > commit as a comment, and for mtime values after 2242-03-16.  Ignoring =
it
> > in a simple importer seems reasonable for now, but I don't understand
> > how this relates to prefixes.  Is it because the header is treated as =
a
> > regular file with the full path "pax_global_header" (independently fro=
m
> > any prefix for actual files) and can thus be placed outside the expect=
ed
> > destination directory?
>
> Thanks for asking the question, as I was also curious if we are
> throwing away too much (perhaps "prefix is given as a global pax
> header, and ignoring all global pax headers is the most expedite
> way" was the reason the patch was written that way?).  I agree with
> you that for the purpose of simple-minded importer, it probably is
> acceptable to take such a short-cut, but it would help future
> developers if we clearly documented that it is a short-cut that
> throws too much.  That would welcome their effort to enhance the
> importer, if they find it more useful to keep some other information
> found in global headers, without breaking the intent of this change.

I don't think that we're throwing away anything because the PAX header is
intended to be a _header_, not a _file_, yet
`contrib/fast-import/import-tars.perl` currently treats PAX headers that
way.

> Having said all that, even before "git archive" existed, release
> tarballs by many projects had leading prefix so that a tarball
> extract would be made inside a versioned directory.  To truly help
> users of the importer, doesn't the logic to allow the user to say
> "please strip one leading level of directory from all the tarballs I
> feed you, as I know they are versioned directories" belong to the
> command line option of the importer?

I guess nobody needed an explicit way to strip path prefixes yet, since
the implicit way works so well.

Ciao,
Dscho

--8323328-869457192-1584997718=:46--
