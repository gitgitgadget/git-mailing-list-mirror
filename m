Return-Path: <SRS0=vH5l=CZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5352CC433E2
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 19:47:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E49D7208E4
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 19:47:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="jeYVBXaa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727303AbgIPTrc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Sep 2020 15:47:32 -0400
Received: from mout.gmx.net ([212.227.15.19]:34425 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728212AbgIPTrJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Sep 2020 15:47:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1600285606;
        bh=AE9MeXZCHtYY8RsnDfq7zGETk2QtN2dCwQ9/EiYKnLI=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=jeYVBXaa6PXf3HDG+quuVSlsuzkFHwJIrSU1NLzyFyCEnSoh6e/snUXwKb3qc83On
         77C240G9kb8seNMo0cPv1klLzCt0zy66/gLTqs2d/KM8rxD9W3TH6PHrkSxe2VNyXa
         yCmmdYM5Y1yypwQ3w8w+XxXqW75Hc6RhPm3lfdm8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.17.239.213] ([213.196.213.124]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MQMuR-1k5eqd01Hl-00MKDI; Wed, 16
 Sep 2020 21:46:46 +0200
Date:   Wed, 16 Sep 2020 21:46:46 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Matthieu Moy <git@matthieu-moy.fr>,
        =?UTF-8?Q?Antoine_Beaupr=C3=A9?= <anarcat@debian.org>,
        Simon Legner <Simon.Legner@gmail.com>
Subject: Re: [PATCH 00/15] remote-mediawiki: various fixes to make tests
 pass
In-Reply-To: <20200916102918.29805-1-avarab@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2009162144390.56@tvgsbejvaqbjf.bet>
References: <20200916102918.29805-1-avarab@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1787123509-1600285608=:56"
X-Provags-ID: V03:K1:m2bEi+llzJuq9NPeTPxdmUmeoUArGk/2lyEmkl6S9KCJiM/CqcC
 JDWXGuvuCVCD2B06PxBDQzgWHq+ii1o323aQUVV+Cgm2toJ90/tiaj4JfAPacmYmVp5839I
 oClRq0nlbX/qwI0sQqK8O9hSAYftS4JcshXDXR4gkdL5w3lMy5NX+DHvJrPDmAk1RPQ/62N
 rNbXt2fpwowLA9FJNK9IA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:OvvZebuOjyk=:pktu+67QcZ7ttFoVFgAjco
 26MihAbgYvVqEX8HWUfOloZjq6wIiw88ULMDHl+Dw99/Y4xBvCLMjULQmgnk8zYvrYydoJkzp
 4NtxfGhrroJRHqVS10y47DMuHKNCZCUoz58ergffQsl8EMqxRQBwVDr0RlMmd4S7Bht5rri8+
 cHxkzZlIgzAKiafS8D0vvDsFr9axxrJLCfQTAMJ7AllA3WLEhUH8X6AN5JHpYadNs+kqBa3D8
 1tVDxNRKlMVjbsmyGr7Ywvpp6CsaKxmlChjXSMDi6a/GJaX8uLVwL8K15R/zgMH4w2Jh0hrTn
 qcDUpujVr4ttd/150a22GLPbuZdCtBFDCUXQ7T9/NLODPhvsdQ+0cHji6Tk426Jky67bz4kDu
 wTQ6hlPI8tdSyz1h4K0iuBNKXHikeLZLxb4IPLT+b7tzeteFeofG1llv+ciS80TajPucn7LkM
 Sn2I3nbM+xA9gpwCSx6mOCDQP4a2mRdWqgsx/6mvPEOlHSyn4Jjn2ohmOfigwUEWsOSjdwoj2
 Kh6BtkugbWOOURg5A4ItYFSZY+0MlgYUVXVsuzaZSXkYBrKW4ENi52Nk4sGbOEhjCyf3AbJo1
 xUSLDR4wcWaTbvlYX7eg1Fd9aPyfqUZGqTRVHumPYi18k+44wgje2CwWFarmpAyLLnuDZe55e
 1eJWcl3RGw6DKOwSSLkYfveTGgAnmlD1UJwcwuGZD+Odjhizg32+B2xyvD1G+AUqlyJKSBau9
 F9h0M3hT7b5bt7mfCR166WNDkkcfAfHVtBvyMwtb6KtPlrsUJpicAadINE7OaxSl7oIf+9+U3
 0P2pVEOArQk2I19ambUyqj0jRcnvJSHd6VNLmN/VTfLXPxG+7JxAEqymcsKKG6HX2Ee+WclGq
 Qwwf4wfgWmuYa1rcYoM9QV6MsdPrAX9BRuzXO/6MGrianSaT10DHyzhB8Go9Xi7W+fu1+QTbM
 mdrX0ha/uwXQPRz82QhDADP1M3zid9F8dYIrUJA4KIJH+SySTDiFKWVL5z5zbnzgbTVhufODb
 DIwjzrI0uTCiF61MqHWM01YFObddUL/CJSM+pivJYHSESFAixKiBfkH0j0bTZvai0AxDLXVBn
 EwOBjX+07fLTEeMHudLlhs0QZtJm3f9gRcVAU2ornPI3tRY6qJijV8S20IMMNTtMYxLDsR02Z
 sYIoyVhjpcFLXZ40kairdRpp55vAsyih1DJpQX9nkd3DgsxulmwuVZtStIjgF45ymQL8uLLVT
 V/mkR+l3GUieGQrnIIFE22CKcqcZxP6EFZEG7pg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1787123509-1600285608=:56
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi =C3=86var,

On Wed, 16 Sep 2020, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> I had occasion to look at remote-mediawiki and I couldn't even get the
> test suite to run. The patches below have more detail but there's
> issues like a hard error on any Perl release newer than ones released
> in 2013, and the MediaWiki release it tries to use spewing errors on
> any modern PHP version.
>
> This series fixes these issues. With it applied it's possible to run
> the tests, and they all pass.

I glimpsed through the patches, and they all look in pretty good shape. I
just wish that the TODO in Simon's patch had been resolved, and that the
test failures had been root-caused, but then, I personally do not really
care all that much about the `remote-mediawiki` backend any longer, so I
am fine with the patches as-are (modulo Danh's/Eric's nit about the
extra tests before `test_cmp`).

Thanks,
Dscho

>
> Simon Legner (1):
>   remote-mediawiki: fix duplicate revisions being imported
>
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (14):
>   remote-mediawiki doc: correct link to GitHub project
>   remote-mediawiki doc: link to MediaWiki's current version
>   remote-mediawiki doc: bump recommended PHP version to 7.3
>   remote-mediawiki tests: use the login/password variables
>   remote-mediawiki tests: use a 10 character password
>   remote-mediawiki tests: use test_cmp in tests
>   remote-mediawiki tests: guard test_cmp with test_path_is_file
>   remote-mediawiki tests: change `[]` to `test`
>   remote-mediawiki tests: use "$dir/" instead of "$dir."
>   remote-mediawiki tests: use a more idiomatic dispatch table
>   remote-mediawiki tests: replace deprecated Perl construct
>   remote-mediawiki tests: use inline PerlIO for readability
>   remote-mediawiki tests: use CLI installer
>   remote-mediawiki tests: annotate failing tests
>
>  contrib/mw-to-git/git-mw.perl                 |   2 +-
>  contrib/mw-to-git/git-remote-mediawiki.perl   |   5 +-
>  contrib/mw-to-git/git-remote-mediawiki.txt    |   2 +-
>  contrib/mw-to-git/t/.gitignore                |   2 +-
>  contrib/mw-to-git/t/README                    |  10 +-
>  contrib/mw-to-git/t/install-wiki/.gitignore   |   1 -
>  .../t/install-wiki/LocalSettings.php          | 129 --------------
>  .../mw-to-git/t/install-wiki/db_install.php   | 120 -------------
>  contrib/mw-to-git/t/t9360-mw-to-git-clone.sh  |   8 +-
>  .../t/t9363-mw-to-git-export-import.sh        |  15 +-
>  contrib/mw-to-git/t/test-gitmw-lib.sh         | 159 +++++++++---------
>  contrib/mw-to-git/t/test-gitmw.pl             |  22 ++-
>  contrib/mw-to-git/t/test.config               |  23 +--
>  13 files changed, 129 insertions(+), 369 deletions(-)
>  delete mode 100644 contrib/mw-to-git/t/install-wiki/.gitignore
>  delete mode 100644 contrib/mw-to-git/t/install-wiki/LocalSettings.php
>  delete mode 100644 contrib/mw-to-git/t/install-wiki/db_install.php
>
> --
> 2.28.0.297.g1956fa8f8d
>
>

--8323328-1787123509-1600285608=:56--
