Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F5DA1FF76
	for <e@80x24.org>; Thu, 22 Dec 2016 10:50:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756562AbcLVKus (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Dec 2016 05:50:48 -0500
Received: from hetzner.fladi.at ([144.76.17.165]:43274 "EHLO hetzner.fladi.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752694AbcLVKuq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Dec 2016 05:50:46 -0500
X-Greylist: delayed 2245 seconds by postgrey-1.27 at vger.kernel.org; Thu, 22 Dec 2016 05:50:46 EST
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=@; s=rsa1;
         h=Content-Type:MIME-Version:Date:Message-ID:Subject:From:To:Sender:Reply-To:
        Cc:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
        References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
        List-Owner:List-Archive; bh=15xzfMzDOuTy63MslVmNZFnio3IDJYEZTQlZ/tukZ0Q=; b=s
        dzwpDnl3RgJlWxTeGNKjkcXTGh4D+UXe9ES7tH2Kvnt6sb5jK3PI/ulrjQykWu9GZm7cW5QikaraC
        nauw17EG5t552f4zFI4p1M742UnuGcPBn9oXkDUFTCuzGiJ8WU;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=localhost;
         s=rsa1; h=Content-Type:MIME-Version:Date:Message-ID:Subject:From:To:Sender:
        Reply-To:Cc:Content-Transfer-Encoding:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=15xzfMzDOuTy63MslVmNZFnio3IDJYEZTQlZ/tukZ0Q=; b=TLpkWbo8Byzc9S4/IB1o6eczzo
        neEMKknszmXKWqr/4GDqMFerTrSaADKT54GqRMmRdpwlN9tmt7MZKSSdsymHlogaab2Jh6j8pvAz+
        6LxmNUgD6CSFsoGmlW3IQ6Kg8;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=fladi.at;
         s=rsa1; h=Content-Type:MIME-Version:Date:Message-ID:Subject:From:To:Sender:
        Reply-To:Cc:Content-Transfer-Encoding:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=15xzfMzDOuTy63MslVmNZFnio3IDJYEZTQlZ/tukZ0Q=; b=L53dXklTZbWdpqoA1wj2pXPOuw
        eTwZA58OA5QgwTn55MIFEvnfQ9Ywo1vd2wILyC5l/P4FmPFg51p9yDQfsq6a7qH/AL1bz7OVvwSOw
        Z9pdI2evpFmxx9fNMwXYA36pF;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=openservices.at; s=rsa1; h=Content-Type:MIME-Version:Date:Message-ID:
        Subject:From:To:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=15xzfMzDOuTy63MslVmNZFnio3IDJYEZTQlZ/tukZ0Q=; b=JI++6INK+EqU3ElMs+GF8qxUHf
        QwRXdBG9GBStTlb8Mro+QLUObMN6xl+M23VApUHTDurMms2u7bBsOx50oAsM3NqslMOjTHsPgqz8I
        C4ne7CtDA2Byt0FbkCAq5O7Ig;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=qraz.at;
        s=rsa1; h=Content-Type:MIME-Version:Date:Message-ID:Subject:From:To:Sender:
        Reply-To:Cc:Content-Transfer-Encoding:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=15xzfMzDOuTy63MslVmNZFnio3IDJYEZTQlZ/tukZ0Q=; b=a+936ELmQf8U4jqeGhoemtaRCH
        Cyd40Shs4JNX13WiLbGxa+POzpo364tjFjBXDepvQKBfgznAvGsiUWinfTB2Lv+oRod2tnyG/higG
        rubXJuCt8wwpDr0/6Xc+q1zRe;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=firedata.at
        ; s=rsa1; h=Content-Type:MIME-Version:Date:Message-ID:Subject:From:To:Sender:
        Reply-To:Cc:Content-Transfer-Encoding:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=15xzfMzDOuTy63MslVmNZFnio3IDJYEZTQlZ/tukZ0Q=; b=BGv/SwyJW0u1eNMg0Rjgf9zFlm
        CyIxWqwqlFcF/rKqM0KDjPTM8P0ONa0JGgbNdFVekQsuA2On2ArJd/kJUY/dQXdE8btfl0NHVtbo+
        G4Ch3vXbfiqTPzRnmgiV2vJXH;
Received: from [2a01:4f8:191:4a4:b072:45ff:feea:6846] (port=60088)
        by hetzner.fladi.at with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.88)
        (envelope-from <michael@fladi.at>)
        id 1cK0MP-0004Hs-N9
        for git@vger.kernel.org; Thu, 22 Dec 2016 11:12:34 +0100
To:     git@vger.kernel.org
From:   Michael Fladischer <michael@fladi.at>
Subject: Bug-Report: git-svn and backslash in SVN branch name
Openpgp: id=D8812F4065320B8DCA3CEF18694CADEF51C7B5B6
Organization: Fladi.at
Message-ID: <cb8cd9b1-9882-64d2-435d-40d0b2b82d59@fladi.at>
Date:   Thu, 22 Dec 2016 11:12:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.5.1
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="59QhWh9g7r6o0NL6u9MlWDWC1ddQ5c3Xs"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--59QhWh9g7r6o0NL6u9MlWDWC1ddQ5c3Xs
Content-Type: multipart/mixed; boundary="pX94JUFFFgHqu9g28aqBLhsu4nM4tTKMh";
 protected-headers="v1"
From: Michael Fladischer <michael@fladi.at>
To: git@vger.kernel.org
Message-ID: <cb8cd9b1-9882-64d2-435d-40d0b2b82d59@fladi.at>
Subject: Bug-Report: git-svn and backslash in SVN branch name

--pX94JUFFFgHqu9g28aqBLhsu4nM4tTKMh
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

I'm  trying to clone a SVN repo in order to migrate it to git but i hit
a wall with SVN branch names that contain a backslash, which seems to be
allowed in SVN but prohibited in git refs:

r289 =3D c4cb1f0c34e741a07de9673515c853d49c5522b9
(refs/remotes/origin/dicomBaseClass)
Found possible branch point: file:///path.repo/trunk/dicomBaseClass =3D>
file:///path.repo/tags/dicomBaseClass%5Cv0.1, 181
Initializing parent: refs/remotes/origin/tags/dicomBaseClass\v0.1@181
W: Ignoring error from SVN, path probably does not exist: (160013):
Filesystem has no item: File not found: revision 101, path
'/trunk/dicomBaseClass'
W: Do not be alarmed at the above message git-svn is just searching
aggressively for old history.
This may take a while on large repositories
Found possible branch point: file:///path.repo/dicomBaseClass =3D>
file:///path.repo/trunk/dicomBaseClass, 172
Initializing parent: refs/remotes/origin/tags/dicomBaseClass\v0.1@172
fatal: update_ref failed for ref
'refs/remotes/origin/tags/dicomBaseClass\v0.1@172': refusing to update
ref with bad name
'refs/remotes/origin/tags/dicomBaseClass\v0.1@172'
update-ref -m r75 refs/remotes/origin/tags/dicomBaseClass\v0.1@172
1fe0cc23e3cd56a1087562f8ca3d2e40cd2b30d4: command returned error: 128

The tag in case is "dicomBaseClass\v0.1@172".

Is there a way to mangle those names on the fly to get rid of the
backslashes or can they be handled in any other way to be compatible
with git?

Cheers,
--=20
Michael Fladischer
Fladi.at


--pX94JUFFFgHqu9g28aqBLhsu4nM4tTKMh--

--59QhWh9g7r6o0NL6u9MlWDWC1ddQ5c3Xs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEqVSlRXW87UkkCnJc/9PIi5l90WoFAlhbpwkACgkQ/9PIi5l9
0WpBcQf9FxvpYfCal9w52dn5cUPHUV4bo6Y7dRf6zCYo7Kh1Q6Y7jDA8YT0c2/gP
RzKN6faTCQBVZ4fogvxVOrBKnN819ZZh8eiFh2EF91X4lSMewnLL1OwhcEChcBHA
4tTFRcQcSKdW0Jr59IEb2IGk233ItyAR4xMLROJ72SVTf9FW2HIq0vpNBc+iPKJ9
Wd7n5ofipDci3L8o1aVn0FaLFf1Ea9kWFfsxc6T7bsEjKZJbmMW09AXP6MKaJ2L4
gMd64isNygTnD4UjJ9lQFzRyK8X5JvnCt2TcjtM6nFZ7Xervkg+LoNgJJjdsx74l
Xkww+9ANegzxSZ0Xu8nxYX65Bm8RIA==
=z30q
-----END PGP SIGNATURE-----

--59QhWh9g7r6o0NL6u9MlWDWC1ddQ5c3Xs--
