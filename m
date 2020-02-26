Return-Path: <SRS0=QAHC=4O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C30AC4BA13
	for <git@archiver.kernel.org>; Wed, 26 Feb 2020 16:13:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 402B02084E
	for <git@archiver.kernel.org>; Wed, 26 Feb 2020 16:13:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="EnTcOBzH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727193AbgBZQNF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Feb 2020 11:13:05 -0500
Received: from mout.gmx.net ([212.227.17.22]:54787 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726278AbgBZQNF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Feb 2020 11:13:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1582733582;
        bh=5Xd82y0ScK7m5VOEGXF/uxbneiHKMHLvItKH4BY/Nm0=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=EnTcOBzHrF5c9RQgliuC14Wu95oeGuWnp/2gnAfTWeGAGpLsp3t/vthxzV0B4sOJw
         1HSUXk97szH3TUIk+K0ekPxWte728jH2ChrhOLwtk7EbkHhzNvt2uFXFuwEIU1N5de
         2z5wMzsmh62GyLWyE5Bao2upd5GZsqTBPO/6txrs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.86]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MwfWU-1jLkGq0kH4-00y79j; Wed, 26
 Feb 2020 17:13:02 +0100
Date:   Wed, 26 Feb 2020 17:13:00 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Emily Shaffer <emilyshaffer@google.com>
cc:     git@vger.kernel.org,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Subject: Re: [PATCH v8 09/15] bugreport: generate config safelist based on
 docs
In-Reply-To: <20200220015858.181086-10-emilyshaffer@google.com>
Message-ID: <nycvar.QRO.7.76.6.2002261649550.46@tvgsbejvaqbjf.bet>
References: <20200220015858.181086-1-emilyshaffer@google.com> <20200220015858.181086-10-emilyshaffer@google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:ixm1KYleVG4ElxT3wnC6vAZTCi0A7UgCrsF1mADEuDQkpGfBn8V
 NJSSXEBaquYLeymEBCn/B4c5hwQkRRfUo5AohbnnDwyPJbGlspbC5IUYiU1XoLdBlMt7lHQ
 AzK72pw3x6/7tEp9a55qsw8UA/aZXtbhYmukvW3Wcom2KkYBr1fRuZ8HXgm/m9qnx8ynawN
 uiZ7eNJwJUMO7V+H/dOqA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ni6McXWoFLQ=:uNY7jKL/NLcVBEPAQpKrIo
 OiDlwKkOB20ASGuna0zY5TJnZuhmy3HM6U3IbtZrhJoO/q07OjGnG+dA431n/uYyAbqTgswNv
 0zIj/PdXboNgDykhwJQOGWKkR5fuWPOnzKRW8EWj6Tfq2sKRr0PIQF21eFKX9PH1IxeItVFNi
 FYwq+n1qn6DVM/nAM14iHNtuvT5RCVrVhUCgt0bF3GXMWaSinFvu5cLgdw9JivtB47+L6EywT
 DJXeGMQmWQKjbLDu9FLN19d46fYcn9TmeSLY67XCoZfw9jC+fbpCn4hEmKV67o/8GIKTchO44
 D02XWU5sgmth1Dwp6JtrZheP7UxE2eXAslgitBZWGA2QW0lClkcUb9ex7WI6/O5CWpJZdTVom
 5v/r5uVhQ75MG9zLOLUKLWgcpKCj6VHaGHhB45BCFHig7nx35dNbuWDksRjEjf4DrWicEZvTu
 ukGaYjLJuJ4BzAGKdtRR2z6aAgIJv90MKO4iMQ3ni7ThV6qw1IZB0fDcaQAtQn1VdS8MUKdOB
 IXVcoCKUwHMLY/IpSLqMBi/BIstBnbH1RPrFOdDwjtVM+lc6PK1JfzwuB8qvF7Kd+N9KXJ7P4
 rQnX9VJ8FarcNnqRJRacm20Am9BaaBlBOd3JiJSbDrhbRXNqKVMFYcvPaC1YmPrEI5/HdSnLE
 UrIKtWMQUEjKqoqD9ORAfJ/JgmcbYLBKWiBIArROyZrhn7CQXGEXpC0Ja5lErY8mWe9umFqO7
 B/v/kIHVa4tl6pm8MInh+EVIcAp8SJfvxrsdldvICymQ8z5fHHzFi+agfGwHq82KyQ5n2AZaS
 NlqbaPv/tsMSvbWLZewMzxqxl9ceBZohrhhXbhlFuPzsFp3WHe5PaPQf9XHRO9IhTDD+PKyjn
 32EkF8PCMzYviiAQxaMxpxd8w7FEZNSEK6zf6IBnsxJOvfpVurepM4++0yg7TD2gRBVAC/rnI
 jAn6fwdFlKedFQuutbNeKvbT0hLySCFAjriYSVcjZ9lyytfzdDXcuCe5xwtFk0bkfMdSADbvE
 yRultKYwqCgxriGrKhvLltjxhZx4t25HfwaVbUk24wAFyKcg84QyXF/5v9O/kBVkon/cvWXEH
 O1ifQRc/nV6++TqAOE39y3XoH1LYbB1h8Psed2iD0UfRrx9gbbrnkQ8kBlPi/trPcsEt8/6ID
 bd9Zdvs8eRTPW3qJo9L2PiJiyjhJIUUaj8OysX+ZGl5Qq8H/nFD11TBJqQLFjsbSRGuNHcWvT
 7It+duqjuAhPJR71Q
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Emily,

On Wed, 19 Feb 2020, Emily Shaffer wrote:

> diff --git a/Makefile b/Makefile
> index 9e6705061d..6bdd3b9337 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -818,6 +818,7 @@ VCSSVN_LIB =3D vcs-svn/lib.a
>
>  GENERATED_H +=3D config-list.h
>  GENERATED_H +=3D command-list.h
> +GENERATED_H +=3D bugreport-config-safelist.h
>
>  LIB_H :=3D $(sort $(patsubst ./%,%,$(shell git ls-files '*.h' ':!t/' ':=
!Documentation/' 2>/dev/null || \
>  	$(FIND) . \

In order to pretend that we actually care about developers on Windows,
let's squash this in?

=2D- snipsnap --
Subject: [PATCH] fixup??? bugreport: generate config safelist based on doc=
s

The Visual Studio build is a special beast: as we cannot assume the
presence of any Unix tools on Windows, we have to commit all of the
files generated via shell scripts.

These two generated header files are no exception.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
=2D--
 config.mak.uname | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/config.mak.uname b/config.mak.uname
index 6d58d22cd5a..f1f36e43e47 100644
=2D-- a/config.mak.uname
+++ b/config.mak.uname
@@ -788,8 +788,10 @@ vcxproj:
 	git add -f git/LinkOrCopyBuiltins.targets git-remote-http/LinkOrCopyRemo=
teHttp.targets

 	# Add command-list.h
-	$(MAKE) MSVC=3D1 SKIP_VCPKG=3D1 prefix=3D/mingw64 command-list.h
-	git add -f command-list.h
+	$(MAKE) MSVC=3D1 SKIP_VCPKG=3D1 prefix=3D/mingw64 command-list.h \
+		config-list.h bugreport-config-safelist.h
+	git add -f command-list.h \
+	 	config-list.h bugreport-config-safelist.h

 	# Add scripts
 	rm -f perl/perl.mak
=2D-
2.25.1.windows.1

