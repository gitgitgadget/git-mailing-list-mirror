Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B81171F461
	for <e@80x24.org>; Tue, 27 Aug 2019 10:00:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727306AbfH0KAC (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Aug 2019 06:00:02 -0400
Received: from knopi.disroot.org ([178.21.23.139]:40726 "EHLO
        knopi.disroot.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbfH0KAC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Aug 2019 06:00:02 -0400
X-Greylist: delayed 381 seconds by postgrey-1.27 at vger.kernel.org; Tue, 27 Aug 2019 06:00:00 EDT
Received: from localhost (localhost [127.0.0.1])
        by disroot.org (Postfix) with ESMTP id 5F4B623A34
        for <git@vger.kernel.org>; Tue, 27 Aug 2019 11:53:38 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at disroot.org
Received: from knopi.disroot.org ([127.0.0.1])
        by localhost (disroot.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id aBSLVcTsgjod for <git@vger.kernel.org>;
        Tue, 27 Aug 2019 11:53:37 +0200 (CEST)
From:   Vipul <finn02@disroot.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
        t=1566899617; bh=B0zvUwmKx+mfPO1u6edV20vGolX18kDwl3InwQ+2X90=;
        h=From:To:Subject:Date;
        b=CLeDV+SHorRd1KwMfEjfrMcb0uFmoYFX84nfLUj6OswMSTJkr1UbWZZYf3eAOgJFD
         GB90Yn+AaxK9Lg3jbymAHIBwR984h78SIPKwPcSpk3RyhCFZtE09fIP8smMIUm+4nJ
         7blSMadusPUAdAFAmiPkkWQA58XDMN5UZb+ss4u9xdOkkPoj0Kmb2Z4PTpdyi1AzPo
         0I9A67mZv+0vJtGWSdW08+CqHBX/9r5g/ocvs/EwehDzPO5P85LwfCuGbDu0pq7NM5
         06sdjRKLlMv5C9ulyU2Za5oXIW6rpx7d/HQIsesQZzcP8yOUgzhyqQKz1qa8lWi1sr
         4567oJBQz5piA==
Openpgp: preference=signencrypt
Autocrypt: addr=finn02@disroot.org; keydata=
 mDMEXRx7cxYJKwYBBAHaRw8BAQdAKciEXPQkIdtaWRhCIHoSIiBY4g5ZfIP1axIJDFNi5Yu0
 IFZpcHVsIEt1bWFyIDxmaW5uMDJAZGlzcm9vdC5vcmc+iJYEExYKAD4WIQS5z8d4HtK3bcaz
 H3/qgPyoFmeTQQUCXRx7cwIbAQUJA8JnAAULCQgHAwUVCgkICwUWAwIBAAIeAQIXgAAKCRDq
 gPyoFmeTQXjCAP42jD3kQc7BCyR4Ay6I4BhIGYpyPiw9rJInGFtwaZsI5wD/bisWiN14ZuVA
 cop7o/DYqX2K6pRpEap3XqYUEoJKrgS4OARdHHxWEgorBgEEAZdVAQUBAQdAZ2pWXE/s6AfF
 APSNgAU1H4PgVASh/X9N0adLq1YJplwDAQgHiH4EGBYKACYWIQS5z8d4HtK3bcazH3/qgPyo
 FmeTQQUCXRx8VgIbDAUJAeEzgAAKCRDqgPyoFmeTQUGRAP0RlzrFUA0ZAnMJY6asTOd09mxl
 HaiVCjmalM/QY4gNggD/VDcEs9q6eDRAJi4q/VgGwAKEG37pnN2VGfNXFkweYwC4MwRdHHx4
 FgkrBgEEAdpHDwEBB0AE+sNCB2H528wQwT+JBOVcizDtuVzX573iqlwlrximWoj1BBgWCgAm
 FiEEuc/HeB7St23Gsx9/6oD8qBZnk0EFAl0cfHgCGwIFCQHhM4AAgQkQ6oD8qBZnk0F2IAQZ
 FgoAHRYhBC+P1j3RPqH/yxnKNPUjW5+MjneUBQJdHHx4AAoJEPUjW5+MjneUMxgBANyMa1h8
 k7K+S5ozyIkKAGEzPkbpvbmzJXDgkdjvJ/76AQDRfbuR+tGOfhJtYsZKJa6jmGr7WYRrmuJS
 V+PChHe7DAHyAQDMLXZgSTGQooEb50BRM4zllFM6Sbx6ld4izSDWnt87LQEA2S/YbiM57y0v
 HbW6ULT6+Un4KxzFBvl9iZyFMBVRbAw=
To:     git@vger.kernel.org
Subject: Support for an interactive confirmation prompt when users can
 possibly lose their work like some UNIX commands
Message-ID: <c1136131-0a9e-9dbb-3ad7-495ac96c1ef0@disroot.org>
Date:   Tue, 27 Aug 2019 09:53:30 +0000
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="eU2TVPymDBFxOi7ooVkPxj4XCEOV8Ef72"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--eU2TVPymDBFxOi7ooVkPxj4XCEOV8Ef72
Content-Type: multipart/mixed; boundary="K5Ih8NEIzRttGp66W6nnlEGuAyu3HPXH1";
 protected-headers="v1"
From: Vipul <finn02@disroot.org>
To: git@vger.kernel.org
Message-ID: <c1136131-0a9e-9dbb-3ad7-495ac96c1ef0@disroot.org>
Subject: Support for an interactive confirmation prompt when users can
 possibly lose their work like some UNIX commands

--K5Ih8NEIzRttGp66W6nnlEGuAyu3HPXH1
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi,

Sometimes, I messed-up with git repository and lost works due
carelessness. This includes reset a branch instead of other, drop the
stash etc by mistake. I wonder, is there way to a get an interactive
confirmation prompt (which ask for yes/no option) before executing those
commands when users can possibly lose their work? Like, some UNIX
commands have support for an interactive prompt (like 'rm -i', 'mv -i',
'cp -i', etc) for ex: before deleting and overwriting a file a
confirmation is prompt and asking for users permission.
	If there would no such feature available in git, so how do other people
avoid these kind of mistakes? Obviously, one them would be recheck the
command carefully before executing it and repo status but, I think
sometimes people also do these kind of mistakes. For now, to minimize
some of these kind problems I've modified my bash shell prompt to show
all kind information related to a git repository by sourcing
"git-prompt" script (provided with git package) and turn on all of flags
provided by it which significantly increase my productivity and less
mistakes than earlier. But, anything else I can do to avoid these kind
of mistakes at first place or increase my productivity (it includes
adopting some best practices, using some command line tools etc).
  	I searched it on the Internet and found that there are many GUI tools
available which help with these problems but don't want to use GUI tools
because most of time I work in command line environment and love using
command line tool than GUI one.

Any help would be greatly appreciated. Thanks.

PS: Sometimes, I would recover my work by seeking some help mostly on
#git IRC but, it would be better avoid this kind of mess at first place.

Cheers,
Vipul


--K5Ih8NEIzRttGp66W6nnlEGuAyu3HPXH1--

--eU2TVPymDBFxOi7ooVkPxj4XCEOV8Ef72
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQQvj9Y90T6h/8sZyjT1I1ufjI53lAUCXWT9mwAKCRD1I1ufjI53
lE46AP9ierNIdnhh7QUyDx5sWutKrHpLWxa5uiV3+DLPS9YGcAEAkkCkvDdpF9Ny
ZcnfsiwzxBcyM+bDh+w8SRXk1GBuHAQ=
=tvky
-----END PGP SIGNATURE-----

--eU2TVPymDBFxOi7ooVkPxj4XCEOV8Ef72--
