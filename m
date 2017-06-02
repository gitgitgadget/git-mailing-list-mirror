Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AAB582027C
	for <e@80x24.org>; Fri,  2 Jun 2017 13:48:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751140AbdFBNsH (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Jun 2017 09:48:07 -0400
Received: from host24.ssl-gesichert.at ([213.145.225.190]:35475 "EHLO
        host24.ssl-gesichert.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751128AbdFBNsG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jun 2017 09:48:06 -0400
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Fri, 02 Jun 2017 09:48:06 EDT
Received: (qmail 19359 invoked by uid 7799); 2 Jun 2017 15:41:23 +0200
Received: by simscan 1.4.0 ppid: 19298, pid: 19355, t: 0.0177s
         scanners: clamav: 0.99.2/m:57/d:23440
Received: from fw-103.apa.at (HELO ?10.210.240.12?) (philipp@gortan.org@194.232.128.103)
  by host24.ssl-gesichert.at with SMTP; 2 Jun 2017 15:41:23 +0200
To:     git@vger.kernel.org
From:   Philipp Gortan <philipp@gortan.org>
Subject: git-gui ignores core.hooksPath
Message-ID: <953845c2-4326-608a-c342-2d2141da561c@gortan.org>
Date:   Fri, 2 Jun 2017 15:41:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="lhJxmTem2gJKoMhoI8Bd2NMwaPM6m8UO9"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lhJxmTem2gJKoMhoI8Bd2NMwaPM6m8UO9
Content-Type: multipart/mixed; boundary="vbO7w3QpHUf3HrrIBaVQVFeLb1vhL2rdL";
 protected-headers="v1"
From: Philipp Gortan <philipp@gortan.org>
To: git@vger.kernel.org
Message-ID: <953845c2-4326-608a-c342-2d2141da561c@gortan.org>
Subject: git-gui ignores core.hooksPath

--vbO7w3QpHUf3HrrIBaVQVFeLb1vhL2rdL
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi git devs,

First off, thanks for your awesome work!

I've been unhappy for quite a while that I had to configure the hooks
manually for each of my repos - until I found out recently that there is
the core.hooksPath config variable that (when set globally) allows me to
specify a hooks directory to be used for all my repositories.

Now I was happy - for a few minutes, until I tested this feature in
git-gui, and realized that it doesn't work there.

This seems to be caused by "proc githook_read", which says "set pchook
[gitdir hooks $hook_name]" instead of querying "git config
core.hooksPath" first - cf
https://github.com/git/git/blob/2cc2e70264e0fcba04f9ef791d144bbc8b501206/=
git-gui/git-gui.sh#L627

Would be great if this could get fixed...

Thanks, Philipp


--vbO7w3QpHUf3HrrIBaVQVFeLb1vhL2rdL--

--lhJxmTem2gJKoMhoI8Bd2NMwaPM6m8UO9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHEEARECADEWIQT1VoD9JYxWv4mfZ1NmXayc5UDBCwUCWTFq9BMccGhpbGlwcEBn
b3J0YW4ub3JnAAoJEGZdrJzlQMELgmkAnikfj2YrKRqx5xy2cOAPylTv1UoXAKCI
BbgO/WQ8yf31RuaJqRKdInl1EA==
=h5xS
-----END PGP SIGNATURE-----

--lhJxmTem2gJKoMhoI8Bd2NMwaPM6m8UO9--
