Return-Path: <SRS0=XbPV=A4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MALFORMED_FREEMAIL,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56C6BC433E3
	for <git@archiver.kernel.org>; Fri, 17 Jul 2020 10:18:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 285AB20775
	for <git@archiver.kernel.org>; Fri, 17 Jul 2020 10:18:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="S1+cpYET"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726233AbgGQKSi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Jul 2020 06:18:38 -0400
Received: from mout.gmx.net ([212.227.15.19]:50505 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725864AbgGQKSg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Jul 2020 06:18:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1594981112;
        bh=J/h2GQ+zMSEQIT0nHCyym+bX2cffpgKPbQstOEO5l80=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=S1+cpYETX9B0QjGGLxPVNWFmXAjV5dP8UPtt3EXgzweh6EvY6FwcqmTqfKK5uyDGs
         pCvLMOhufqWctl83XaeM+F9TcBuuhPS3wJDL81h9fMBtKuxSval1vJrVGH+xgUEbz0
         w+lStQ3werYbPztrhiJAI4OF4PpbHOIkIr2HCqdo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.237.98] ([213.196.213.77]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MTiPv-1kPh3t0b7d-00Tzdk; Fri, 17
 Jul 2020 12:18:32 +0200
Date:   Fri, 17 Jul 2020 10:52:06 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH v3 2/3] Modify pseudo refs through ref backend storage
In-Reply-To: <79cd5dd480a4218d4563120c03046375594cc23e.1594925141.git.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2007171042461.54@tvgsbejvaqbjf.bet>
References: <pull.673.v2.git.1594329108.gitgitgadget@gmail.com>        <pull.673.v3.git.1594925141.gitgitgadget@gmail.com> <79cd5dd480a4218d4563120c03046375594cc23e.1594925141.git.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:hTsC1ilOJuDT0ghNmCwQdgo0voP5Zbgs9CoGhbxtGxdqVbJV9V4
 18fnzIm5Meq8WpxBqnxii/OkeZ4Bnlzb9Sk8aB9O8ONfWBaNqMpt7ETsnavFsyOq3zuRN2X
 FuPZkYayIjb5ymQ3J3pFBxjYIAGRKBlqIWwaNON5sN5LcCZDHft4OrIzoO261Xh+DtHRbe5
 AGOi+eOILr9Bn6xauo9rw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:dqY426q2F2A=:DUrG6ZuebGfADfnEx40TRq
 vHhF8xlMa4o8ZuUbCV4fx37SinQ5VB+prheizf/4QtxaVjqiqLcu4R2wPORvJTlevBfdjSCNO
 ltGPUe6W5y1Z+cHuFWyEKBWIJ4u0fd31au0Y1HXdXjqC3+/fVX8a2yf68u6r/r2RuiUcrXOt0
 VrH/aepNGGNh+LkvO2wEBG4ZMOEW8Pg/9yl2/GgBtxUD0KG6/6hkuPE0yPNSxEAoHQfG/TuwW
 3UQcWusVyC2+hnbLVUSXvjpR4ud7TfdQ66k7le0EDG1MKSmJzRoSA0vf2YI63M+q8R7bqEO7X
 jqJm5wyyTw6Twc4cd015JVSQLC7mVIlwfs6JCMAqvYCuF8e9xmRWb++galoO7jqoV8/7enOMh
 LI1MBsiD8six5ugu89iYcFq9Tjimd1wNRjrxI/1U5FZqAu0Y2kOmfAAI2In16izsw4OiKFfAF
 YENZ4cyic9gQhl7bPOE7+H+Dvlp3cbg555KQ3CEneCcwewd+H6ZgWGDBP6PjLa+UzAbkOnH3c
 MV6J5UsPeUwrPlAst1Qeqwp1KuqsnTR/1Bra6AmXDus+et1jHWgXNC4nz2DJroPjszAimt0aF
 7R9r0Nuhkto3DTJ3qR4/UBGMDf3TS5zzsnn6hL4NqhWoZqz4l4lCJXMsPFiIU1sz7Kh4WhKg2
 mEPsAS8Cigozpm4tFl3tkH6iIaau5yRJdJ3/9OHC9wZS+JrcvZZNgCtJIhTD3Cb1Bywfn33um
 lv8ZigqJNwznfOXFxInyvpLHPZBg6a475tTXC9QwTOqF27YpoawYlZ383m5SnhIjFd/a+9Hx0
 mU/rr4IsA1l6hfup9i5w+f4M5TIuwo1fYSc60x/MUuNn3Frn/XWV+rAwgGbG+DsYLszrRP2ee
 P2bajZXMUDEoscl9yGiwr5iDR+OfjoqMVYcABxnfLSIkr+Vp1vnKc6tQnCvjcsRWlO+zxu3CN
 cGhZ4NOVz0uYQl+iAONbVDyDz6I01jJoQDg9h2a7jQez09Zihm2+GlYS/DmK67GDeg4aDCqFl
 smJRxiyjvTb9hgtt4lE4FiVU9/MtFKAcedSfxCM22r5dil1X90HzLleS9EfbVErLYCvV1Ka7k
 UZkeHjKQgUjbGgaDf+L2xzWDA6+0/2oJ7JTJoWhwXGYe7/S5wlk7x0m+1L0uc6cVulMBoFH/d
 ul/z6MGYmiVFrRxU6h7IuBO46OowEPStoYG9KUfEJBf4aKAhrDocwx0IwEh1Mf1owtmAJESQU
 WsJ8wh4IwabDQkFtetzuZl33Wt/3KPwpJ9AimMA==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Han-Wen,

On Thu, 16 Jul 2020, Han-Wen Nienhuys via GitGitGadget wrote:

> From: Han-Wen Nienhuys <hanwen@google.com>
>
> The previous behavior was introduced in commit 74ec19d4be
> ("pseudorefs: create and use pseudoref update and delete functions",
> Jul 31, 2015), with the justification "alternate ref backends still
> need to store pseudorefs in GIT_DIR".
>
> Refs such as REBASE_HEAD are read through the ref backend. This can
> only work consistently if they are written through the ref backend as
> well. Tooling that works directly on files under .git should be
> updated to use git commands to read refs instead.
>
> The following behaviors change:
>
> * Updates to pseudorefs (eg. ORIG_HEAD) with
>   core.logAllRefUpdates=3Dalways will create reflogs for the pseudoref.
>
> * non-HEAD pseudoref symrefs are also dereferenced on deletion. Update
>   t1405 accordingly.

Unfortunately, there is still a breakage in t1405, although it only really
shows up on Windows and macOS because of case-insensitive filesystems.
https://github.com/gitgitgadget/git/runs/879772942?check_suite_focus=3Dtru=
e
shows the concrete problem: t1405.17 'delete_ref(refs/heads/foo)' will
fail thusly:

	++ test-tool ref-store main delete-ref msg refs/heads/foo c90e4dc5e12224a=
428dedfbd45ba11e5531706a2 0
	error: cannot lock ref 'refs/heads/foo': is at 1e995a94b5a60488b6ebaf78ec=
779d85a55ea700 but expected c90e4dc5e12224a428dedfbd45ba11e5531706a2
	error: last command exited with $?=3D1

The reason is that there exists a `refs/heads/foo` _and_ the symref `FOO`
(which points to `refs/heads/master`, which is at 1e995a).

An earlier symptom of this bug is visible on Linux, too, though: when
you run t1405.4 'delete_refs(FOO, refs/tags/new-tag)', it shows this:

	+ git rev-parse FOO --
	warning: ignoring dangling symref FOO
	fatal: bad revision 'FOO'

(Seeing this warning suggests to me that this should probably be caught
_by the regression test_, i.e. stderr should be redirected, and it should
be verified via `test_i18ngrep` that that warning is not shown.)

The reason for this warning is that the symref `.git/FOO` is no longer
removed as part of t1405.4 'delete_refs(FOO, refs/tags/new-tag)'. I've
used this patch to bisect the breakage down to this here patch:

=2D- snip --
diff --git a/t/t1405-main-ref-store.sh b/t/t1405-main-ref-store.sh
index a8d695cd4f1..779906d607f 100755
=2D-- a/t/t1405-main-ref-store.sh
+++ b/t/t1405-main-ref-store.sh
@@ -34,6 +34,7 @@ test_expect_success 'delete_refs(FOO, refs/tags/new-tag)=
' '
 	m=3D$(git rev-parse master) &&
 	$RUN delete-refs 0 nothing FOO refs/tags/new-tag &&
 	test_must_fail git rev-parse FOO -- &&
+	test_path_is_missing .git/FOO &&
 	test_must_fail git rev-parse refs/tags/new-tag --&&
 	test_must_fail git rev-parse master -- &&
 	git update-ref refs/heads/master $m
=2D- snap --

Hopefully you can figure out what is going wrong.

Ciao,
Dscho
