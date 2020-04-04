Return-Path: <SRS0=+7zH=5U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0BD1C2BA16
	for <git@archiver.kernel.org>; Sat,  4 Apr 2020 13:38:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BAD6206C3
	for <git@archiver.kernel.org>; Sat,  4 Apr 2020 13:38:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Iq2JC1A/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726229AbgDDNiI (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Apr 2020 09:38:08 -0400
Received: from mout.gmx.net ([212.227.17.20]:45841 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725837AbgDDNiI (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Apr 2020 09:38:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1586007480;
        bh=/6rVLcUzroAgEgWWVkaKazYHuddIpUAM+YEvE8eC6Gs=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Iq2JC1A/aCmKWnXuhAIqfh2FCVRfkJh0mCB02EoZ9srq3IssmukSU9og9JkqjgENb
         Zdeq/n8ANaDqo+jdbokB8FMVbnRpWYg05RZyLVG9Qcvqdf4GvEb0cvAxP+Bc3qBIbY
         qGnFFW0BJ2bT4pcejMbGpCKs3psMRmnr4KIjzdeo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from MININT-QA14EDB.fritz.box ([213.196.212.7]) by mail.gmx.com
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1Mk0JM-1is0wK1lvc-00kNc6; Sat, 04 Apr 2020 15:38:00 +0200
Date:   Sat, 4 Apr 2020 15:38:00 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/2] use `curl-config --cflags`
In-Reply-To: <20200326080540.GA2200522@coredump.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.2004041535360.46@tvgsbejvaqbjf.bet>
References: <20200326080540.GA2200522@coredump.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:ZTvf4ISiz5sqdrJYLqOCXFdUt7LVNcptscGZAU0Me4sRz10We5t
 Jkt4iPcbCO9UJEx32kyL6MGk8/+uLwhk2yjtZ+PFxZ7oY8rlXb9x/kui0/MScOo2r355snS
 nqUo5US74N2qY5iQ5HFeVG4P0fmcQfZaWcVOavBUoZb1vTmAsfQUYm6/FJsZAJEsqrkNUdU
 FqSBCgEpGs8bu67IGOr/g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:XjD4RhEP0p4=:fL1tehE+7mfxI5P9J1JBnt
 diXsH2x21M04a15WmgbxX6K3bJkEUQTgYVIJs1wPdduZM5ofY+2d2Tv8QPmKSFPJH5VloaGLt
 AVzSA8PUpQ93Px9fG1Pbo79Fyp1pur8xOC/ptRExIX1MLZiFhaa+Q6CLZ8NAf557jShjFhsmd
 2S03tZPdPSEO5oBiXJrBFZjxxQ8/G/P9QphLWH/PD6ifZW/DvzqP9ygQeJbVYvQyDkY2kXY49
 onMOi8b1KHE4w6G9BL/btWXdytZ/mW6d2TUwpbAYEZarNwvF1L0Y8J4HsnPco6ffZ8ul8OjrV
 euJFVENGFpTBW/nXoL1Y+EsCARf4ZM47x3L/Cno7AZQ6RaJrt9sAR7DtKO5yqmAcGi9Tk1uZw
 glnyBu+7oI72hMmWnpUooCRwh/QqlaMMaDlld/h+QyhKZLRPvPIvrnzre4ainAOiLNLrjIKNG
 123lvobycxFc0Hlslq+pA7gQNkSbvoFTdBrgi0N1rVVazhdXQi6luL1rOnA+hl+428lhFU48m
 1+NpCHqBgZSboOIgw5UQm8VeN5pcTt7XSIM7AEgVi+wXTwUgxu2CIRkluny867Ngnz2CQjPsY
 /lt1WxMpMaXI/K10xBXJooWmFzgaFel+baTfdVhRJJGsPRnNtDjpnHO84IFmiMGnf8s5szJnO
 iVcaoSnixBJj20IUch8nX7q+kq1CkCB28IfHaKvzjxNZdTXB2telmsy6ETN9hV783IdpzVPqu
 QRP3ZTd2fE5VG7/NDgtwkmz23JpCnbPmJYzcQB5aVHG3jAAEjjadrp+i0kFjbUQnTkajWdouQ
 wCq3LujEVcKqKNXbSJmh3438qocB/7irbKg0udNeCweeIFWZC5NdSR3Aqrbid2ip8jWJq86JD
 m5BSn+y65dpAO0eTDNfh/0bF0SYnlKDsnVq7k0fH+BJ0jdeZsGG4d6UaL23hmWbkJiXJhPgzn
 ZkY0D6z1urQqy2u0EapJNOljoEM6gF7rbuqTfRIIfZTGDLjXrHmuaBcHIZhNgXjhdwYWN6old
 PKV8hQY+2hhkz4AVeKnEqTKy0ucE7fmwq3iyeelYNhZqNvewvaHRwxSyoXMLTjhFykQ8wKHpb
 KgF034oeLy/ykD1AFonkudFycvDzP2fk0ivqUsEk95PqaFcwhtGj37eylEQONy5dip7xbZCJY
 kG/0jTVrOeF248DwWe47/PChxFf0ImzeenkkURCICup3e3OxYl6/BCBogDQumvXnJ1rnlJWZf
 11d0oU1ak5q7YVOck
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Thu, 26 Mar 2020, Jeff King wrote:

> I was recently testing Git's behavior with respect to various versions
> of libcurl. So I built a one-off libcurl and installed it in /tmp/foo,
> but was surprised that:
>
>   make CURL_CONFIG=3D/tmp/foo/bin/curl-config
>
> didn't work, since we do run "$(CURL_CONFIG) --libs". This fixes it,
> along with a minor optimization to the existing "--libs" call.
>
>   [1/2]: Makefile: avoid running curl-config multiple times
>   [2/2]: Makefile: use curl-config --cflags

I _suspect_ that this is responsible for the build failure

	make: curl-config: Command not found

at https://github.com/git/git/runs/556459415#step:4:674

Do we need this to fix this?

=2D- snip --
diff --git a/ci/test-documentation.sh b/ci/test-documentation.sh
index de41888430a..325b4cc6185 100755
=2D-- a/ci/test-documentation.sh
+++ b/ci/test-documentation.sh
@@ -11,6 +11,7 @@ filter_log () {
 	    -e '/^    \* new asciidoc flags$/d' \
 	    -e '/stripped namespace before processing/d' \
 	    -e '/Attributed.*IDs for element/d' \
+	    -e '/curl-config: Command not found/d' \
 	    "$1"
 }

=2D- snap --

Ciao,
Dscho

>
>  Makefile | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
>
> -Peff
>
