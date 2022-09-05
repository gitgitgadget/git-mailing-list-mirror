Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B04CECAAD5
	for <git@archiver.kernel.org>; Mon,  5 Sep 2022 10:36:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237413AbiIEKgU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Sep 2022 06:36:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236831AbiIEKgR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Sep 2022 06:36:17 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE3022D1E6
        for <git@vger.kernel.org>; Mon,  5 Sep 2022 03:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1662374171;
        bh=6lfFRBX+rQeiGQlVf9kq+A3kRJA2PcakStlIAL2GvWA=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=bUO+4PEJnuGDScbdDgKvkZUFrEsLNddkthyRYJLqHrVVstNtFln6jnS7kcMkqKt4W
         0v548Y2Hms5+G1B1pbCKFNMxTOzrSmLFJGBZBKUo+IDz1oIXrSv03K13XfsI8vHL+o
         3ju5ZPBXfXAwMdD2vq7mND4FAPRGcpasDTH68+OQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.23.220.106] ([213.196.212.69]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N2mBQ-1pVgoQ1p0e-0135wg; Mon, 05
 Sep 2022 12:36:10 +0200
Date:   Mon, 5 Sep 2022 12:36:09 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, derrickstolee@github.com, gitster@pobox.com,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Victoria Dye <vdye@github.com>
Subject: Re: [PATCH v2 0/9] scalar: integrate into core Git
In-Reply-To: <pull.1341.v2.git.1662134210.gitgitgadget@gmail.com>
Message-ID: <73sr2o20-q1np-sn3n-n3p0-8s904n966344@tzk.qr>
References: <pull.1341.git.1661961746.gitgitgadget@gmail.com> <pull.1341.v2.git.1662134210.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:whgLhozex2WzyyNOFMyF2nhX/l4iB8nnybYI8aH9ZW81lXByipy
 Bnt8aORnjTKsfECDq5fC3ngVd8zl9AfMlcTDU8v7++Sk+vr2PcW3jpgWZ7VtP+OfsG7rdfT
 pgSflyzXvmEj4ZyiSP4h92Tp2iAXkhVkgOj5nE9dG4eA6yzZrpd1vOZ8EFF9d7dV8M93r04
 /z1/bYy20nRX95uDH+wYA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:wKOEyTGp0Z8=:UFzxbvHaC25RRqgteKh6/Y
 2ZWd0ioYtjqDbPPZ8uZL78WK7PeZuommrohmWU6m9+GX67n8VD2FCGLBsPRgSaV+CUnbSAeib
 ApII41MUnBJWDLQW/k++N48rG7BU3YtE1ZMGObyzF9gZ164UfT+DWm4AgWzkIs5Nesrdwduni
 bQf1fFse03xKIvpIOaZwHGnnFaMq6409X3yQP1jO+Qf+7SZ3sHDOs5qheFTk6WPN5W2y8TbEa
 qkVd/QGtx0TmanPsK3ox3Mzo4ZVNsQi+0+/SOzV8VvGk3IRUmZcjwxs/55ClOVKEIjyOSW4GE
 JZ25c4jgoCfGIVqjRjKD/rJKEcZIwaQwtzsF3olnwkwcAyaAJ7GpfdU9KtnBC9XRAOPN6EUb5
 uidAK5a3C9QI00VaSFI/Zv1za1SLz/nZarxU4rS4nGkaBmur7Hii7UfgRNDv3Qi/IiyCugEW2
 ty4FnrrOUPHLb1oRn4lQ8k0kbZwfrmo/Ev1/2RJf4UvwpoDv6ghD4A/ztIntPNUrF9g4WM2s8
 bPDUT3lFt5bfRkqdwhiwaSnmJtm19G4oBsLfZvEXqaZMrmjUqav+SSX/N8AyM9eGWVyJv1/vy
 VLmLfZ+DfLo0W4NAF9RRoc4x0A8CJO/Ibcns+8pFh/KVQbXVbeGs6Fc8piMpHc4QfbRbvkRWq
 pr+Qh6gqQShFIcNSxFCCt+76gCzf3DqOSTMjFk9ejx0N0F1g2+5QyAnfjZfZXbskBsNHNJMqF
 BopDvjQaKMiysCVIwmWCMFN4F2oD5XGjO/Uv8bduwGDEdMmv9pfbBD0msrz5GX7DVdR/m+g3X
 hnvDp/eNpE60fc6LdM/9V6n94lFGaCWSu97Cekk8UMblI0uHtMjb6LTR42MZ2Q5HGRKn8oOav
 HPwMG3eTOoqR62SsgBSUfKin5d/qiKO/PTear7GhrBFlzZLiKqmfdnNxebMwtQD9kqJ7o8cGe
 wIBq0HBi7PdjgYcRwIu8I3TCOG7F6Z+1JU+jwWn1RrHiv7m0+JyGEeTvQR/WdWtI4j87w28c/
 UzkRrEAGlon9AXGeuVsVkSQk6CjZk1Zg2mIdQ+hxkekn42H54Xg6KNazOzbNSpiWJCurW88RI
 A5tSjgk6MzvoKv5J0IFCd8Y95PGMuxk4uv9cD2k7qIrMYHWD0b1PA3+M6bV++LhW4phoLrtYH
 ODTctIEJ3UEbU1u02Ilj43gqNT
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Victoria,

On Fri, 2 Sep 2022, Victoria Dye via GitGitGadget wrote:

> Changes since V1
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>  * Updated 'scalar.txt' description from "Associated with [git]" -> "Par=
t of
>    [git]".
>  * Fixed Dscho's "Signed-off-by" and author emails on patches 3 & 4.
>  * Added 'scalar' to 'git help -a' command list.
>  * Removed translation tag for literal 'scalar help' usage string.
>  * Updated 'scalar clone' tests to clone to unique targets and clean up =
only
>    when test passes.
>  * Changed 'p9210' perf tests to invoke 'git' and 'scalar' with '-C', ra=
ther
>    than creating a subshell to run commands.
>  * Fixed use of 'test_env_bool' with 'GIT_PERF_USE_SCALAR', locally test=
ed
>    to make sure it was working as-intended.

This iteration addresses all concerns I had.

Thank you so much!
Dscho
