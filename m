Return-Path: <SRS0=ZaJ6=7X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BC3EC433E0
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 18:59:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C65CB2074B
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 18:59:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="FZiAFpWk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbgFJS7V (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Jun 2020 14:59:21 -0400
Received: from mout.gmx.net ([212.227.15.15]:32893 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726260AbgFJS7V (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jun 2020 14:59:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1591815554;
        bh=XsQ9ULVVjdpBX+WnOiQtaKyZdeYn1j0UOKgZiTeWDAs=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=FZiAFpWkSTikLY1YIoX+azJzLrAMDf87g0OF2xy1SXw6QKJA2kVx0lpdgXsDlDka1
         LTX7/8vQCSZl1x8LpPeXmTFAs7NpuBXlbRcxohTXnWmzvwKWIKhqTqv4qIpvf+8ikL
         mYkv7E+rkunCiW3Klnof45AgsLJG/sxzUnpnZzEY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.173.52] ([213.196.213.108]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N1wlv-1ilaNX2RIn-012EIf; Wed, 10
 Jun 2020 20:59:14 +0200
Date:   Wed, 10 Jun 2020 20:59:13 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, "hanwen@google.com" <hanwen@google.com>
Subject: Re: [PATCH v16 00/14] Reftable support git-core
In-Reply-To: <xmqqimfyg84j.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2006102056530.56@tvgsbejvaqbjf.bet>
References: <pull.539.v15.git.1590695209.gitgitgadget@gmail.com>        <pull.539.v16.git.1591380199.gitgitgadget@gmail.com>        <xmqq7dwfhlwt.fsf@gitster.c.googlers.com>        <CAOw_e7ZzEyb+21QHcNGcj5A8N501-a5fF3HNL0Jq6uD8S37G6A@mail.gmail.com>
 <xmqqimfyg84j.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:C00ldGLCEKhjOzzfxtTY7G7FsHOh4FPPG5S3JQexvgBoKzbLVBC
 wjN3YVp24rLOXq+3SlVBRvN3wQFYtMtyU3znU1/CV1hy6F9TUXog7cCSZnDwV3zDE7KUAih
 wwwBi+2lcqmnCShQqLJMNxElWAc5bwOdk33YNqZ1lfhrTqfchTkhP0AbmvgO71K5v4mdZhc
 vuXpoCMli7LSfDRZKlZ5w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8ToqceUFfR0=:lQwxxbIwAxzh3pqxaruqEK
 5afJ+ZX6aNy44rmhgPr+Zk6Ei88JlwZy8Nf0gZTK6mCtpeqjvbhMRHg3ufFUfuSEKzUdv6NsX
 m9wdfpcY77U6bnwiCQRh1o5AiX3DiX6+No+YRSC0PROGwVt1qGEhc4HIV+5SFRgGRXwBJveNu
 zfHfIEaoZ24MTeGSk3wub7RlGXjnr4VMzyIrKzVilgkE+9Hik3jg9dSmj1vDhJCubTwP1a35L
 PwrZ0/uT8rDFUQ+sADs+fNhD7EQtI7zY6Kvbxq3jyXrOTVqbZwuKgjOy2nyu2ASLborFaCg34
 rhqHXzzp4v4MbhfIJvYRqaddkoTNDk3Y7kbuIqxKXMbVMviNbDBfZub/WaVK+BiURoJ2rH0eK
 X1piqBTbSGg/AkEBnuLQnqgTDPcZwGrAUxg+1Mf00vgaGvheJ65RsMr1pgKL6kYUHDfTOfCKU
 gP8Q+UOxECb4p4XrvST8LSHEwrx60rp1FKeXC+mI3JjQpPT+knsvFe4Ph8dNS34BIz342mYyb
 AityLP/KxFPYpWlvBVZAJiWgfobIXeN9hLuw5dXq7d39c6MqX172mYs7mUo5kCw7qoDRHigw/
 Yp0hk1FSy2A3CkyoxmuHSXPP9d5maZSVI/pv2ff6qTGVrocYmgrVMLF9AXe/IeYIwkM4pyM7d
 +rRCh8wJDkQSF5AaY0km5iYoU158uVt6H0c5YQojVHl8Es+SFXJhU3cly+5gw3TmOK9dhZoTI
 eAx7dJxHX1r1srkuJD/lZk143mMLDzwSTyd7gXY5bYrwWKaHYqtmstzEbfwueidBvS4PRww24
 zShNRsELzIUNTTTvz2MkealbHW6VPkM3ZWiL5++/dY1D9H0HAGWOhVRCoyMiQzoyqJZazqJ6U
 +UyvQQtDsCsu5+wGDhMCgNMg5BX/joC4uaLcIZjj1oJLfxhkxhF4Oia7DM4MzEcxQXFROgF62
 Pfhairla459YdT3NNz/bymTHsU1fXAwHSYClodV5evNGA7WufnMq4xskV5GI8DDpi+gwZE+6B
 YRVrIl9GUyP8rayTKgu/lV1+xnG2vFHCtgwWhAMy6Qm1vzilRJCw4bTPyTEy6GiEGbmzuC8hH
 UQ+UbJv3cbS7wXDxseHQTStgrK6nmkYC0ukWbWOXfMULN2bZvF7alGPNGq/02ztTb86T38FB5
 ghRfEzuLknQe9iF68MCOMnJSUHgWFP8idSQZDnLOrUlhTzYr/2UTVEYugNQrs8ebjEwdkZY/Q
 5/znmOcEuyhs7euo1
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 10 Jun 2020, Junio C Hamano wrote:

> Han-Wen Nienhuys <hanwenn@gmail.com> writes:
>
> > There is also:
> >
> > reftable/stack_test.c:27:7: error: incompatible pointer types
> > initializing 'PREC_DIR *' with an expression of type 'DIR *'
> > [-Werror,-Wincompatible-pointer-types]
> >         DIR *dir =3D fdopendir(fd);
> >
> > on OSX. What is the proper dialect for reading out a directory within
> > the git source code? opendir and fdopendir are POSIX, so I'm surprised
> > this fails.
>
> I am reasonably sure we use opendir() to iterate over existing files
> and subdirectories in a directory (e.g. in the codepaths to
> enumerate loose object files in .git/objects/??/ directories).
>
> I do not offhand know we also use fdopendir() elsewhere.  I strongly
> suspect we do not.  Perhaps some platforms do POSIX.1-2001 but not
> ready for POSIX.1-2008 or something silly like that?

We don't. We also do not use `unlinkat()`. And we generally use
`remove_dir_recursively()` instead of implementing a separate version of
it that only handles one directory level ;-)

This is what I needed in Git for Windows' `shears/pu` branch to make it
compile again:

=2D- snipsnap --
Subject: [PATCH] fixup??? Add reftable library

Rather than causing a build failure e.g. on Windows, where `fdopendir()`
and `unlinkat()` just is not a thing, and rather than re-inventing
`remove_dir_recursively()`, let's just use the perfectly fine library
function we already have for that purpose.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
=2D--
 reftable/stack_test.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/reftable/stack_test.c b/reftable/stack_test.c
index ffcc1e42819a..4dadc39bf45f 100644
=2D-- a/reftable/stack_test.c
+++ b/reftable/stack_test.c
@@ -17,23 +17,20 @@ license that can be found in the LICENSE file or at
 #include "reftable.h"
 #include "test_framework.h"
 #include "reftable-tests.h"
+#include "dir.h"

 #include <sys/types.h>
 #include <dirent.h>

 static void clear_dir(const char *dirname)
 {
-	int fd =3D open(dirname, O_DIRECTORY, 0);
-	DIR *dir =3D fdopendir(fd);
-	struct dirent *ent =3D NULL;
+	struct strbuf buf =3D STRBUF_INIT;

-	assert(fd >=3D 0);
+	strbuf_addstr(&buf, dirname);
+	if (remove_dir_recursively(&buf, 0) < 0)
+		die("Could not remove '%s'", dirname);

-	while ((ent =3D readdir(dir)) !=3D NULL) {
-		unlinkat(fd, ent->d_name, 0);
-	}
-	closedir(dir);
-	rmdir(dirname);
+	strbuf_release(&buf);
 }

 static void test_read_file(void)
=2D-
2.27.0.windows.1

