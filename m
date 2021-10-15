Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0646C433F5
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 17:47:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B164C60F56
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 17:47:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241649AbhJORtQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Oct 2021 13:49:16 -0400
Received: from mout.web.de ([212.227.15.4]:43279 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237559AbhJORtP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Oct 2021 13:49:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1634320027;
        bh=C11k2tKfyrVDvW6bvrK+xoukmUU5vIV+0zkVGfxC1P4=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=DDWnpbaefhpgaRHnkju8aL1oiDyCRgcmmLt5ni/91OXWgHkgLM+DAuRbhn+utvUqY
         FHrpyEyUCEpwi2etDE+pN6VFkDrEA73YgLaD1izERCquVKlta4NDVwAivhoHrMjyMv
         rC04WOodWOLokuoMx5f0UIb04PAQToY2O199RZXQ=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([79.203.20.171]) by smtp.web.de
 (mrweb003 [213.165.67.108]) with ESMTPSA (Nemesis) id
 0MeSLv-1mNS8z3iz1-00Q9tl; Fri, 15 Oct 2021 19:47:06 +0200
Subject: Re: force deterministic trees on git push - exact sort-order of
 filenames
To:     milan hauth <milahu@gmail.com>, git@vger.kernel.org
References: <CAGiEHCtdjA+cVXjN43NPbSZfrDtr-kDtPMN4x_VTGSJuPZ8bcg@mail.gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <dab8ce58-fef6-7988-f494-c096e1265aa2@web.de>
Date:   Fri, 15 Oct 2021 19:47:06 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAGiEHCtdjA+cVXjN43NPbSZfrDtr-kDtPMN4x_VTGSJuPZ8bcg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WLT7ZfMwa8N82E0Ae/x0/dk2J2Xkb8IhKE2MmncdBcpvDl+PJwW
 Y0tO+Pv8mTE7Ckayq72+DKFoEU/A1nrQr3qGfSWfTy32xZ+LTg7vJsuc+/JbywSdMNLuzya
 5q388RjAJ7jWIXbofTB7QjavedYpHusTtkMOiBycrc36474gCJLszSR7WbRoXlRNgkWEKsQ
 ZmbYEztGoIE2aUIuXPjKA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Z/sLY7kdVJE=:bWDkoFPT0UziGKtclLKJ4t
 SbtnR79avzWYjhXnXv+EG4IkmgBE6jHuiSbSsSV3OD03cvKO9blqrmrTuu80sdeWRD9G3Ogh7
 CJWlTPYzQxKm/V0Md2NiEycpI6Rr6n2szxDUSg8M8FY/TKoJv/fbPVjDkS2flEDgRinElbyxj
 dkQ3S/Jz374M+ZZ35ZCUab+nu6jcL5nbSdAqvbNIjtk9Bqrqf6Mw3eIYz0IfsAX1PpiBFetDs
 h8B3yHSS6eNVV4HKfzd8y63NcdFSrqLZ3DwlgRCyRcSoEVbwGdcoyKB9RXFujBfIXGj6uYuJB
 Pkcaf1/kT0FJX4texzpA+gieUyofhey/ywWbt+8HoTrZ+QWPs8Mfqp/H8EEJqZNS31O0+3vcS
 IPiQL6UzCDxrhai/4IJRZawYFLuIS6PSNO2ks3u0SDM6Gf1tsHY7vkzLwo59YzbgBfNdDtDp3
 cYnByv/5BLOgDDB1j8M1T3bKKcnp0qu6GV66ia9PHhDW0gSLtyahc+YYl9iee2m5mGZKEZpMB
 qjt/rR/7H73VUHfgpyQvZWvXV8lq9LV68tDAaBfInXp3Sh/YKkFGwkvgDvLXR7tGdh3SNzP+S
 6YUWKnv0xPXnmMAogMFKRzZ+pAbg8sVwNAwhOf+f1IyQ1zVNM++EkMFSeHy34+71tiVQhvMQW
 lw4FBwcjXUfZkymtjojfKS4a3cOhtTVYF/hYcBce2sUhnhFcD9Qe7ShJwqGZ1vWK0mnXhVEHq
 RFKmvxQ+kmF39WzXg48T7jkV6+gQKQrv+aTYAJ41zLq2mTSCDJeTGYavWhulRjq92Yw6Llr2f
 PVw9hW2lPsU6Tucqf3yzR/bjNxRveoFaUq+OqFxP2q3HeDlsVIG62DS/YeQ0f83F4WJHiPPF9
 zU0Q2BKA14zrmjbBMqA4yF563euauiNa6IKjxBCrUK+oIWEkOOSndFXOsxbNR8CcvYj7/4YOw
 /QvoCuYnqKioTjLoNTidW/eeyJnuq//UfrBCVo+qJLJhY4G13PbUUYr7tFBYBJgOiX83y0Ahs
 NhBL2bJUEZJOeRrQBazHXiShIpNaB+paDrWstkjINo0C0bnk9NwBB7CFE5Yumyjelw==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 15.10.21 um 18:04 schrieb milan hauth:
> fact: the sort-order of filenames in a tree is not strictly regulated

Actually it is.

> proposal: enforce the exact sort-order of tree-items,
> to make trees deterministic and reproducible.

That's a good idea.  It was implemented in e83c516331 (Initial revision
of "git", the information manager from hell, 2005-04-07), whose README
says:

  "A tree object is a list of permission/name/blob data, sorted by name.
   In other words the tree object is uniquely determined by the set
   contents, and so two separate but identical trees will always share
   the exact same object."

> the git server could refuse a 'git push',
> when the tree is invalid

It should.

> sample trees from [1] and [2]:
>
> git cat-file -p 2b75a7dbb76138587dbe50a5a6af8a6eedbaf66b | grep id_ed255=
19
> 100644 blob f914b3f712fc56ab212b53cb9055e1291b5c77a2    id_ed25519
> 100644 blob 40de4a8ac6027f64ac85f687bea7049467b428a2    id_ed25519.pub
>
> git cat-file -p c8a72e628d0ca0a174a1a4241e6c7314a4660f0f | grep example
> 100644 blob fde6f3cbd19addb8ce84ffe32ab4d040e8b09c18    example.pem
> 040000 tree 6b0ee97865059ac965590e0ff5272fb76b6fd2c8    example

Tree entries are sorted by name, except that the names of a sub-trees
(like "example" above) get an implicit slash (/) appended.  Slash
(ASCII character 47) sorts after dot (ASCII character 46).

Are you able to generate and push different trees objects that
reference the same entries (same names, hashes, modes) in different
order?

Ren=C3=A9
