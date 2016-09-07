Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 44E1E1F859
	for <e@80x24.org>; Wed,  7 Sep 2016 13:44:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752829AbcIGNoP (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Sep 2016 09:44:15 -0400
Received: from smtp.gentoo.org ([140.211.166.183]:39492 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752437AbcIGNoO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2016 09:44:14 -0400
Received: from abudhabi.paradoxon.rec (p4FDA9DB0.dip0.t-ipconnect.de [79.218.157.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: polynomial-c)
        by smtp.gentoo.org (Postfix) with ESMTPSA id BAD583407AF;
        Wed,  7 Sep 2016 13:44:12 +0000 (UTC)
Date:   Wed, 7 Sep 2016 15:44:04 +0200
From:   Lars Wendler <polynomial-c@gentoo.org>
To:     git@vger.kernel.org
Cc:     "Robin H. Johnson" <robbat2@gentoo.org>, lekto@o2.pl
Subject: segfault in http.c when https URL is mistyped
Message-ID: <20160907154404.107fe6e6@abudhabi.paradoxon.rec>
In-Reply-To: <20160907151607.2b288034@abudhabi.paradoxon.rec>
References: <20160907151607.2b288034@abudhabi.paradoxon.rec>
Organization: Gentoo
X-Mailer: Claws Mail 3.14.0 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 boundary="Sig_/T/5Cx1QJ1if7GwhUhJQnGwy"; protocol="application/pgp-signature"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--Sig_/T/5Cx1QJ1if7GwhUhJQnGwy
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi,

we at Gentoo got a bug report [1] about git-remote-https segfaulting
when the URL has been mistyped.=20
This seems to only be triggered when git was compiled with curl
support:

  git clone https::/some.example-site.net/test.git

Observe the "https::/" instead of "https://". As soon as you run such a
command, syslog receives a message like:

  kernel: git-remote-http[8766]: segfault at 0 ip 0000000000408abd sp
  00007ffd70adf7c0 error 4 in git-remote-https[400000+103000]

Kind regards
Lars

[1] https://bugs.gentoo.org/592522

--=20
Lars Wendler
Gentoo package maintainer
GPG: 21CC CF02 4586 0A07 ED93  9F68 498F E765 960E 9B39

Attention! New gpg key! See
https://www.gentoofan.org/blog/index.php?/archives/9-New-gpg-keys.html

--Sig_/T/5Cx1QJ1if7GwhUhJQnGwy
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJX0BmkAAoJEFcd0tA0PGA55OoP/i+GtCiySWZkn7AAJurbH3b8
YKgBey/Z54Gb5uelAEp1iT/UOf62hvF4nrLa7UeEnFhmFO981NeOZ5Iv5CelSBiA
vdTffBdLput3Q8FJ5bbaKaj4DtSe/C2tTXeJRo0kda6L+JgXsHMw9xBgRaQT1ACl
eJWCS4aQVFHmcEJWCSpfFR5DjkLF7jhBuUoN/KL/2AUr/D/hF3ZEyuf4tVLgLWq5
7OBqp4A9hRpjPPdWRK/x5VlhK4jvpMPVtyI4FeN9N9LYMqpb6heI3pppz2lAx1it
X15GEIza+U9b17S4ATBLBMUIEP2WGSc7i4QFpwAl9YS9CNSpKt74NHfv3UFcBIyM
eWeBSVJkTHVMz8edPlexbod47ipA/TTlADzhHz3ayRd2lEdKdBQL1wZ0tqg09vZp
s10QANPs0sIpl4ewCIsos7AH25oH9IpKDBt9URiPbCHbXt0TN0vuU+wjPnjPnsnV
aMjM3wiL57xrpXpmWShVXuNXcrYtPqG08VpA5vA1Ays5d/5kug6SfcX14KjJuTgH
H/rt8mYOkvFTuWNhbZKVYx4SOfJ11yaIOLtfscalowWX14CyDgc1Hcg7Z1J3rGtH
vhcgfuz227g9R7Bn3lFiLyaV3u5fcw1+jMiZYdOpiC/2k1qauMQW1efWsQcz6TG+
xxL4caWIcN/9BXZgAXXc
=Tg55
-----END PGP SIGNATURE-----

--Sig_/T/5Cx1QJ1if7GwhUhJQnGwy--
